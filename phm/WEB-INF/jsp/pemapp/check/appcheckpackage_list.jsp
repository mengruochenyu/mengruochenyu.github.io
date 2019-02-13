<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%>
        <style>
            td .content{
                text-overflow: ellipsis;
                width:250px;
                overflow: hidden;
                display: inline-block;
            }
            .content-td{
                position: relative;
            }
            td span.content-det{
                font-size: 11px;
                color: salmon;
                display: inline-block;
            }
        </style>
	</head>
		<script>
        //选择医院
        function selectNext(obj){
	       	$("#query_key_next").empty();//初始化select
            if($(obj).val()==null||$(obj).val()==""){// 一级筛选为空，即不为需要筛选的条件返回false
	           	$("#query_key_next").removeAttr("name");
	            $("#next_type").attr("name","query_key_typeId");
	            $("#next_doctor").attr("name","query_key_doctorId");
	         	$("#query_key_next").append("<option value=''>二级分类筛选</option>");
	          	$("#next_type").attr("value","");
	            $("#next_doctor").attr("value","");
	        	return false;
            }
            var root = $(obj).val();// 如果一级筛选不为空，移除隐藏元素的name属性
            $("#next_type").removeAttr("name");
            $("#next_doctor").removeAttr("name");
            //提示语句显示
           	if (root==2) {
           	 $("#query_key_next").append("<option value=''>平台套餐类型筛选</option>");
			} else {
				$("#query_key_next").append("<option value=''>指定医生套餐筛选</option>");
			}
            $.ajax({
                url:"<%=basePath%>appcheckpackage/findnextmenu/"+$(obj).val(),
                type: "GET",
                dataType:'json',
                contentType: "application/json;charset=UTF-8",
                cache: false,
                success:function(data){
                    if(data.code==200){
                        var resultList=data.data;
                        if(resultList != null && resultList.length>0 ){
                            for(var i=0;i<resultList.length;i++){
                               var result=resultList[i];
                               if (root == 2) {
                            	 console.log($("#next_type").val() == result.typeId);
                               	 $("#query_key_next").removeAttr("name");
                               	 $("#query_key_next").attr("name","query_key_typeId");
                               	 if ($("#next_type").val() == result.typeId){
                               		 if (result.parentId == 0) {
                               			$("#query_key_next").append("<option value='"+result.typeId+"' selected>"+result.typeName+"(一级类型)"+"</option>");
									} else {
										$("#query_key_next").append("<option value='"+result.typeId+"' selected>"+result.typeName+"</option>");
									}
								} else {
									if (result.parentId == 0) {
										$("#query_key_next").append("<option value='"+result.typeId+"'>"+result.typeName+"(一级类型)"+"</option>");
									} else {
										$("#query_key_next").append("<option value='"+result.typeId+"'>"+result.typeName+"</option>");
									}
								}
							} else if (root == 3) {
								$("#query_key_next").removeAttr("name");
                              	$("#query_key_next").attr("name","query_key_doctorId");
                              	if ($("#next_doctor").val() == result.doctorId){
                              		$("#query_key_next").append("<option value='"+result.doctorId+"' selected>"+result.doctorName+"</option>");
								} else {
									$("#query_key_next").append("<option value='"+result.doctorId+"'>"+result.doctorName+"</option>");
								}
								
							} else {
								return false;
							}
                            }
                        }
                    }
                }
            });
        }
    </script>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="appcheckpackage/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
                    <td>
                        <span class="input-icon">
                            <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="这里输入体检表名称" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                    </td>
                    <td>
                          <span class="input-icon">
                              <select id="root" name="query_key_root" onchange="selectNext(this)">
                                  <option value="">请选择套餐类型</option>
                                  <option value="2" <c:if test="${pd.query_key_root=='2'}">selected</c:if>>APP平台套餐</option>
                                  <option value="3" <c:if test="${pd.query_key_root=='3'}">selected</c:if>>医生个人套餐</option>
                              </select>
                          </span>
                      </td>
                     <td>
                        <span>
                        	<select id="query_key_next">
                            	<option value="">二级分类筛选</option>
                        	</select>
                        </span>
                        <input type="hidden" name="query_key_typeId" id="next_type" value="${pd.query_key_typeId}"/>
                        <input type="hidden" name="query_key_doctorId" id="next_doctor" value="${pd.query_key_doctorId}"/>
                    </td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
					<td colspan="5">&nbsp;&nbsp;<em>*</em><span>&nbsp;套餐类型包含"医生个人套餐"和"APP平台套餐"，二级分类会根据选择的套餐类型，出现不同的二级分类列表。</span></td>
				</tr>
			</table>
			<!-- 检索 style="white-space: nowrap;"  -->
			<table id="table_report" class="table table-hover">
				<thead>
					<tr>
						<th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>名称</th>
						<th>套餐类型</th>
						<th>二级分类/医生姓名</th>
						<th>描述</th>
						<th style="width: 45%;">量表</th>
						<th>价格</th>
						<th style="text-align: center;">状态</th>
						<th style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${varList == null}">
				    	<tr class="main_info">
							<td colspan="100" class="center" >请输入搜索条件</td>
						</tr>
					</c:when>
					<c:when test="${not empty varList}">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td>
                                	${var.name}
                                </td>
                                <td>
                                	<c:if test="${var.root == 1}">PC端套餐</c:if>
                                	<c:if test="${var.root == 2}">APP端平台套餐</c:if>
                                	<c:if test="${var.root == 3}">医生个人套餐</c:if>
                                </td>
                                <td>
                                	<c:if test="${var.root == '3'}">${var.doctorName}</c:if>
                                	<c:if test="${var.root == '2'}">${var.typeName}</c:if>
                                </td>
                                
                                <td>${var.description}</td>
                                <td>${var.sheetNameStr}</td>
                                <td>${var.price}</td>
                                <td style="text-align: center;">
                                <c:if test="${var.root == 2}">
                                	<c:if test="${var.onSold == '0'||var.onSold == ''||var.onSold == null}">未上架</c:if>
                                	<c:if test="${var.onSold == '1'}">上架</c:if>
                                </c:if>
                                <c:if test="${var.root != 2}">
                                -
                                </c:if>
                                </td>
								<td class="center" style="width: 200px;">
									<div style="text-align: center;">
										<div class="inline position-relative">
										<c:if test="${var.root != 2}">
                                         -
                                        </c:if>
										<c:if test="${var.root == 2}">
											<c:if test="${var.onSold == '0'||var.onSold == ''||var.onSold == null}">
												<a class='btn btn-mini btn-info' title="上下架管理" onclick="editOnSold('${var.id}','${var.onSold}');;">上架</a>
											</c:if>
											<c:if test="${var.onSold == '1'}">
												<a class='btn btn-mini btn-info' title="上下架管理" onclick="editOnSold('${var.id}','${var.onSold}');">下架</a>
											</c:if>
											<a class='btn btn-mini btn-info' title="选择体检表" onclick="addCheckSheet('${var.id}');">选择体检表</a>
											<a class='btn btn-mini btn-info' style="margin-top: 2px;" title="编辑" onclick="edit('${var.id}');">编辑</a>
										</c:if>
										<c:if test="${var.root == 3}">
											<span>(医生个人套餐不支持操作)</span>
										</c:if>
											<%--<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>--%>
										</div>
									</div>
								</td>
								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				
				
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					<a class="btn btn-small btn-info" onclick="restoreDefault();" title="恢复默认价格">恢复默认价格</a>
					<a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
<script type="text/javascript">
		
	$(top.hangge());
	
	//去设置免费套餐页面
    function setFreePackage() {
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>freepackage/goSetFreePackage?officeId=${hospitalOffice.id}'),
            title: '设置免费套餐'
        });
    }
	
	//检索
	function search(){
		top.jzts();
		$("#Form").submit();
	}
	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>appcheckpackage/goAdd.do'),
            title: '新增'
          });
	}
	//选择体检表
	function addCheckSheet(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkpackage/goSelectSheet/'+id),
            title: '编辑'
          });
	}
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>appcheckpackage/goEdit/'+id),
            title: '编辑'
          });
	}
	//删除
	function del(id){
		var url = "<%=basePath%>appchecksheet/delete/"+id;
		ajaxDelete(url);
	}
	//上下架管理
	function editOnSold(id,onSold){
		var newOnSold = 0;//默认值：未上架
		var descStr = "确定要下架本套餐吗?";
		if(onSold == 0||onSold == ''||onSold == null){
			newOnSold = 1;//如果原来状态是未上架，则现在上架
			descStr = "确定要上架本套餐吗?";
		}		
		var url = "<%=basePath%>appcheckpackage/editOnSold";
		bootbox.confirm(descStr, function(result) {
			if(!result){return;}
 		    $.ajax({
		        type: "POST",
		        url: url,
		        data:{
		        	id:id,
		        	newOnSold:newOnSold
		        },
		        dataType:'json',
		        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		        cache: false,
		        success: function(result){
		            	location.reload();
		        },
		        error: function(result){
		        	location.reload();
		        }
		    }); 
		});   
	}
</script>
<script type="text/javascript">
		
	$(function() {
		
		//下拉框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		//日期框
		$('.date-picker').datepicker();
		
		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
		
		//页面加载完成：调用一级菜单的事件
		selectNext($("#root"));
		
	});
	
	//批量操作
	function makeAll(){
		var url = '<%=basePath%>appcheckpackage/deleteBatch';
		console.log(url);
		ajaxDeleteBatch(url);
	}
	
	//批量操作二：设置价格恢复默认值
	function restoreDefault(){
		var url = '<%=basePath%>appcheckpackage/restoredefault';
		//获取选中的数据
		var str = '';
		for(var i=0;i < document.getElementsByName('ids').length;i++){
	        if(document.getElementsByName('ids')[i].checked){
	            if(str=='') str += document.getElementsByName('ids')[i].value;
	            else str += ',' + document.getElementsByName('ids')[i].value;
	        }
	    }
		if(str==''){
	        bootbox.alert("您还没有选择任何内容");
	        return;
	    }
		bootbox.confirm('确定要恢复默认价格吗？', function(result) {
			if(result) { //点击确定以后的操作
	            var data = {ids:str};
	            var ajaxObject = {};
	            ajaxObject.url = url;
	        	ajaxObject.data = data;
	        	ajaxObject.success = function(result){
	        		bootbox.confirm('操作成功', function(result) {
	        			if (result) {
	        				location.reload();
						}
	        		});
	        	};
	        	ajaxObject.fail = function(result){
	        		 bootbox.alert("操作失败");
	        	};
	        	ajaxPost(ajaxObject);
			}
		});
		
	};
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>