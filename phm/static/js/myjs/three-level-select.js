//页面加载事件 用作添加、修改
function initCategorySelect(selectFirstLevelId, selectSecondLevelId, selectThirdLevelId){
	var productcategoryId = $('#productcategoryId').val();	
	var firstlevelId = selectFirstLevelId;
	var secondLevelId = selectSecondLevelId;
	var thirdLevelId = selectThirdLevelId;
	if(firstlevelId == ''){
		firstlevelId = -1;
	}
	if(secondLevelId == ''){
		secondLevelId = -1;
	}
	if(thirdLevelId == ''){
		thirdLevelId = -1;
	}
	initFirstLevel(firstlevelId,secondLevelId,thirdLevelId);
}
//一级分类初始化
function initFirstLevel(firstlevelId,secondLevelId,thirdLevelId){
	var firstlevelParentId = -1;
	$.ajax({
  		type:"post",
		data:{'parentId':firstlevelParentId},
		url:'productcategory/findListByParentId/'+firstlevelParentId,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
				$("#categoryFirstLevel").empty();
				var setFirstlevelId=false;
				for(var i=0;i<data.data.length;i++){
					if(data.data[i].isShow != 1){
						continue;
					}
					if(setFirstlevelId == false && firstlevelId == -1){//未设置过1级分类ID，且2级分类ID不为-1
						firstlevelId = data.data[i].productcategoryId;
						setFirstlevelId = true;
					}
					$("#categoryFirstLevel").append("<option value='"+data.data[i].productcategoryId+"'>"+data.data[i].productcategoryName+"</option>"); 
				}
				$("#categoryFirstLevel").find("option[value='"+firstlevelId+"']").attr("selected",true);
				//二级分类			
				if(firstlevelId == -1){
					$("#categorySecondLevel").html('')
					$("#categoryThirdLevel").html('')
				}else{
					initSecondLevel(firstlevelId,secondLevelId,thirdLevelId)
				}
			}else{
				//不做处理
			}
		}
	});
}

//二级分类初始化
function initSecondLevel(firstlevelId,secondLevelId,thirdLevelId){
	$.ajax({
  		type:"post",
		data:{'parentId':firstlevelId},
		url:'productcategory/findListByParentId/'+firstlevelId,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
				$("#categorySecondLevel").empty();
				var setSecondLevelId=false;
				for(var i=0;i<data.data.length;i++){
					if(data.data[i].isShow != 1){
						continue;
					}
					if(setSecondLevelId == false && secondLevelId == -1){
						secondLevelId = data.data[i].productcategoryId;
						setSecondLevelId = true;
					}
					$("#categorySecondLevel").append("<option value='"+data.data[i].productcategoryId+"'>"+data.data[i].productcategoryName+"</option>"); 
				}
				$("#categorySecondLevel").find("option[value='"+secondLevelId+"']").attr("selected",true);
				//三级分类					
				if(secondLevelId == -1){
					$("#categoryThirdLevel").html('')
				}else{
					initThirdLevel(firstlevelId,secondLevelId,thirdLevelId)	
				}
			}else{
				//不做处理
			}
		}
	});
}
//三级分类初始化
function initThirdLevel(firstlevelId,secondLevelId,thirdLevelId){
	$.ajax({
  		type:"post",
		data:{'parentId':secondLevelId},
		url:'productcategory/findListByParentId/'+secondLevelId,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
				$("#categoryThirdLevel").empty();
				var setp=false;
				for(var i=0;i<data.data.length;i++){
					if(data.data[i].isShow != 1){
						continue;
					}
					if(setp == false && thirdLevelId == -1){
						thirdLevelId = data.data[i].productcategoryId;
						setp = true;
					}
					$("#categoryThirdLevel").append("<option value='"+data.data[i].productcategoryId+"'>"+data.data[i].productcategoryName+"</option>"); 
				}
				$('#productcategoryId').val(thirdLevelId);
				$("#categoryThirdLevel").find("option[value='"+thirdLevelId+"']").attr("selected",true);
				threeClassAttr(thirdLevelId);
			}else{
				//不做处理
			}
		}
	});
}
//一级分类change事件
function changeCategoryFirstLevel(firstlevelId){
	//二级分类
	initSecondLevel(firstlevelId,-1,-1)
}
//二级分类change事件
function changeCategorySecondLevel(secondLevelId){
	//三级分类
	initThirdLevel(-1,secondLevelId,-1)
}
//三级分类change事件
function changeCategoryThirdLevel(thirdLevelId){
	$('#productcategoryId').val(thirdLevelId);
	threeClassAttr(thirdLevelId);
}
//三级产品分类属性
var productProps=[];
function threeClassAttr(threeClassId){
	//根据分类ID 查询属性
	$.ajax({
  		type:"post",
		data:{'parentId':threeClassId},
		url:'productclass/findListByParentId/'+threeClassId,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
                if (data.data.length > 0) {
                    var html = '<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>产品属性:</td>';
                    for (var i = 0; i < data.data.length; i++) {
                        //productClassIds += data.data[i].productClassId+'$'+data.data[i].attributeName+',';
                        if (data.data[i].isUse == 0) {
                            continue;
                        }
                        html = html + '<td>';
                        if (data.data[i].isRequired == 1) {
                            html = html + '<em>*</em>';
                        }
                        var attrName = 'productProp' + (i + 1);
                        var attrValue = productProps[i + 1]
                        html = html + data.data[i].attributeName + ':&nbsp;<input type="text" maxlength="50" contenteditable="true"  value="' + attrValue + '" style="width: 120px;" name="' + attrName + '"/></td>';
					}
                    $('#prodcutClass').html(html);
                    //$('#productClassIds').val(productClassIds);//属性ID集合 后台需处理
                } else {
                    var html = '<td style="width:80px;text-align: right;padding-top: 13px;"></td>';
                    $('#prodcutClass').html(html);
				}
			}else{

            }
		}
	});
}
function initAddressSelect(selectFirstLevelId, selectSecondLevelId,selectThirdLevelId){
	var divisionId = selectThirdLevelId;
	if(!divisionId){
		//添加
		//省
		var parent1 = -1;
		$.ajax({
	  		type:"post",
			data:{'parentId':parent1},
			url:'division/findListByParentId/'+parent1,
			dataType:"json",
			success:function(data){
				if(data.code == 200){
					var parent2 = -1;
					$("#addressFirstLevel").empty();
					for(var i=0;i<data.data.length;i++){
						if(i == 0){
							parent2 = data.data[i].divisionId;
						}
						$("#addressFirstLevel").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
					}
					//市
					$.ajax({
				  		type:"post",
						data:{'parentId':parent2},
						url:'division/findListByParentId/'+parent2,
						dataType:"json",
						success:function(data){
							if(data.code == 200){
								var parent3 = -1;
								$("#addressSecondLevel").empty();
								for(var i=0;i<data.data.length;i++){
									if(i == 0){
										parent3 = data.data[i].divisionId;
									}
									$("#addressSecondLevel").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
								}
								//区
								$.ajax({
							  		type:"post",
									data:{'parentId':parent3},
									url:'division/findListByParentId/'+parent3,
									dataType:"json",
									success:function(data){
										if(data.code == 200){
											var p = -1;
											$("#addressThirdLevel").empty();
											for(var i=0;i<data.data.length;i++){
												if(i == 0){
													p = data.data[i].addressCode;
												}
												$("#addressThirdLevel").append("<option value='"+data.data[i].addressCode+"'>"+data.data[i].divisionName+"</option>"); 
											}
											$('#addressCode').val(p);
										}else{
											//不做处理
										}
									}
								});
							}else{
								//不做处理
							}
						}
					});
				}else{
					//不做处理
				}
			}
		});
	}else{
		//修改
		var parentId = -1;
		var parent1 = selectFirstLevelId;
		var parent2 = selectSecondLevelId;
		var parent3 = selectThirdLevelId;
		//省
		$.ajax({
	  		type:"post",
			data:{'parentId':parentId},
			url:'division/findListByParentId/'+parentId,
			dataType:"json",
			success:function(data){
				if(data.code == 200){
					$("#addressFirstLevel").empty();
					for(var i=0;i<data.data.length;i++){
						$("#addressFirstLevel").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
					}
					$("#addressFirstLevel").find("option[value='"+parent1+"']").attr("selected",true);
					//市
					$.ajax({
				  		type:"post",
						data:{'parentId':parent1},
						url:'division/findListByParentId/'+parent1,
						dataType:"json",
						success:function(data){
							if(data.code == 200){
								$("#addressSecondLevel").empty();
								for(var i=0;i<data.data.length;i++){
									$("#addressSecondLevel").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
								}
								$("#addressSecondLevel").find("option[value='"+parent2+"']").attr("selected",true);
								//区
								$.ajax({
							  		type:"post",
									data:{'parentId':parent2},
									url:'division/findListByParentId/'+parent2,
									dataType:"json",
									success:function(data){
										if(data.code == 200){
											$("#addressThirdLevel").empty();
											var addressCode = "";
											for(var i=0;i<data.data.length;i++){
												$("#addressThirdLevel").append("<option value='"+data.data[i].addressCode+"'>"+data.data[i].divisionName+"</option>");
												if(data.data[i].divisionId == parent3){
													addressCode = data.data[i].addressCode;
												}
											}
											$("#addressThirdLevel").find("option[value='"+addressCode+"']").attr("selected",true);
										}else{
											//不做处理
										}
									}
								});
							}else{
								//不做处理
							}
						}
					});
				}else{
					//不做处理
				}
			}
		});
	}
}


//一级分类change事件
function changeAddressFirstLevel(parent1){
	//二级分类
	$.ajax({
  		type:"post",
		data:{'parentId':parent1},
		url:'division/findListByParentId/'+parent1,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
				var parent2 = -1;
				$("#addressSecondLevel").empty();
				for(var i=0;i<data.data.length;i++){
					if(i == 0){
						parent2 = data.data[i].divisionId;
					}
					$("#addressSecondLevel").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
				}
				//三级分类
				$.ajax({
			  		type:"post",
					data:{'parentId':parent2},
					url:'division/findListByParentId/'+parent2,
					dataType:"json",
					success:function(data){
						if(data.code == 200){
							var parent3 = -1;
							$("#addressThirdLevel").empty();
							for(var i=0;i<data.data.length;i++){
								if(i == 0){
									parent3 = data.data[i].addressCode;
								}
								$("#addressThirdLevel").append("<option value='"+data.data[i].addressCode+"'>"+data.data[i].divisionName+"</option>"); 
							}
							$('#addressCode').val(parent3);
						}else{
							//不做处理
						}
					}
				});
			}else{
				//不做处理
			}
		}
	});
}

//二级分类change事件
function changeAddressSecondLevel(parent2){
	//三级分类
	$.ajax({
  		type:"post",
		data:{'parentId':parent2},
		url:'division/findListByParentId/'+parent2,
		dataType:"json",
		success:function(data){
			if(data.code == 200){
				var parent3 = -1;
				$("#addressThirdLevel").empty();
				for(var i=0;i<data.data.length;i++){
					if(i == 0){
						parent3 = data.data[i].addressCode;
					}
					$("#addressThirdLevel").append("<option value='"+data.data[i].addressCode+"'>"+data.data[i].divisionName+"</option>"); 
				}
				$('#addressCode').val(parent3);
			}else{
				//不做处理
			}
		}
	});
}
//三级分类change事件
function changeAddressThirdLevel(parent3){
	$('#addressCode').val(parent3);
}