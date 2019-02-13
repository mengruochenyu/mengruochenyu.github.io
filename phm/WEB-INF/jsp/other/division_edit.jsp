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
		<base href="<%=basePath%>">
		
<script type="text/javascript">
	
	//保存
	function save(target){
		if($("#divisionName").val()==""){
			popupTip('divisionName', '请输入行政区划名称');
			return false;
		}
		if($("#divisionOrderby").val()==""){
			popupTip('divisionOrderby', '请输入行政区划排序');
			return false;
		}
		if($("#divisionLevel").val()==""){
			popupTip('divisionLevel', '请输入行政区划级别');
			return false;
		}
		if($("#divisionParentid").val()==""){
			$('#divisionParentid').val(-1);
		}
		if($("#zipCode").val()==""){
			popupTip('zipCode', '请输入邮编');
			return false;
		}
		if($("#addressCode").val()==""){
			popupTip('addressCode', '请输入区划代码');
			return false;
		}
		var action = '${msg}';
		var url = 'division/' + action;
		ajaxSave(target, url, action);
		return false;
	}
	
	function popupTip(field, msg){
		$("#"+field).tips({
			side:3,
            msg:msg,
            bg:'#AE81FF',
            time:2
        });
		$("#field").focus();
	}
	//选择分类级别显示不同分类
	function changeParent(divisionLevel){
		var parentId = -1;
		if(divisionLevel == 1){
			$('#parentTr').hide();
			$('#parentId').val(parentId);
			return;
		}else if(divisionLevel == 2){
			$('#parentTr').show();
			$('#parent1').show();
			$('#parent2').hide();
			//请求数据 一级分类 父节点-1
			$.ajax({
		  		type:"post",
				data:{'parentId':parentId},
				url:'division/findListByParentId/'+parentId,
				dataType:"json",
				success:function(data){
					if(data.code == 200){
						$("#parent1").empty();
						for(var i=0;i<data.data.length;i++){
							if(i == 0){
								parentId = data.data[i].divisionId;
							}
							$("#parent1").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
						}
						$('#divisionParentid').val(parentId);
					}else{
						//不做处理
					}
				}
			});
		}else if(divisionLevel == 3){
			$('#parentTr').show();
			$('#parent1').show();
			$('#parent2').show();
			//请求数据 一级分类 父节点-1
			$.ajax({
		  		type:"post",
				data:{'parentId':parentId},
				url:'division/findListByParentId/'+parentId,
				dataType:"json",
				success:function(data){
					if(data.code == 200){
						var parent1 = -1;
						$("#parent1").empty();
						for(var i=0;i<data.data.length;i++){
							if(i == 0){
								parent1 = data.data[i].divisionId;
							}
							$("#parent1").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
						}
						//查找二级分类 父节点为第一条数据
						if(parent1 != -1){
							$.ajax({
						  		type:"post",
								data:{'parentId':parent1},
								url:'division/findListByParentId/'+parent1,
								dataType:"json",
								success:function(data){
									if(data.code == 200){
										$("#parent2").empty();
										for(var i=0;i<data.data.length;i++){
											if(i == 0){
												parentId = data.data[i].divisionId;
											}
											$("#parent2").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
										}
										$('#divisionParentid').val(parentId);
									}else{
										//不做处理
									}
								}
							});
						}
					}else{
						//不做处理
					}
				}
			});
		}
	}
	//一级分类change事件
	function changeParent1(parentId){
		var divisionLevel = $('#divisionLevel').val();
		if(divisionLevel == 3){
			$.ajax({
		  		type:"post",
				data:{'parentId':parentId},
				url:'division/findListByParentId/'+parentId,
				dataType:"json",
				success:function(data){
					if(data.code == 200){
						$("#parent2").empty();
						for(var i=0;i<data.data.length;i++){
							if(i == 0){
								parentId = data.data[i].divisionId;
							}
							$("#parent2").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
						}
						$('#divisionParentid').val(parentId);
					}else{
						//不做处理
					}
				}
			});
		}else if(divisionLevel == 2){
			$('#divisionParentid').val(parentId);
		}
	}
	//二级分类change事件
	function changeParent2(parentId){
		$('#divisionParentid').val(parentId);
	}
	//页面加载事件 用作修改
	$(document).ready(function() { 
		var divisionLevel = $('#divisionLevel').val();
		var parentId = $('#divisionParentid').val();
		if(divisionLevel == 1){//大分类
			//不做处理
			//return;
		}else if(divisionLevel == 2){//中分类
			//此时根据parentId查询所有大分类
			var p1 = -1;
			$('#parentTr').show();
			$('#parent1').show();
			$('#parent2').hide();
			$.ajax({
		  		type:"post",
				data:{'parentId':p1},
				url:'division/findListByParentId/'+p1,
				dataType:"json",
				success:function(data){
					if(data.code == 200){
						$("#parent1").empty();
						for(var i=0;i<data.data.length;i++){
							$("#parent1").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
						}
						$("#parent1").find("option[value='"+parentId+"']").attr("selected",true);
					}else{
						//不做处理
					}
				}
			});
		}else if(divisionLevel == 3){//小分类时
			//此时根据parentId查询所有大分类、中分类
			$('#parentTr').show();
			$('#parent1').show();
			$('#parent2').show();
			var parentParentId = '${entity.division.divisionParentid}';//大分类ID
			var parentId = '${entity.divisionParentid}';//中分类ID
			var p1 = -1;
			//加载大分类
			$.ajax({
		  		type:"post",
				data:{'parentId':p1},
				url:'division/findListByParentId/'+p1,
				dataType:"json",
				success:function(data){
					if(data.code == 200){
						$("#parent1").empty();
						for(var i=0;i<data.data.length;i++){
							$("#parent1").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
						}
						$("#parent1").find("option[value='"+parentParentId+"']").attr("selected",true);
						$.ajax({
					  		type:"post",
							data:{'parentId':parentId},
							url:'division/findListByParentId/'+parentId,
							dataType:"json",
							success:function(data){
								if(data.code == 200){
									$("#parent2").empty();
									for(var i=0;i<data.data.length;i++){
										$("#parent2").append("<option value='"+data.data[i].divisionId+"'>"+data.data[i].divisionName+"</option>"); 
									}
									$("#parent2").find("option[value='"+parentId+"']").attr("selected",true);
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
	}); 
</script>
	</head>
<body>
	<form action="division/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="divisionId" id="divisionId" value="${entity.divisionId}"/>
		<input type="hidden" name="divisionParentid" id="divisionParentid" value="${entity.divisionParentid}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>区划名称:</td>
				<td><input type="text" name="divisionName" id="divisionName" value="${entity.divisionName}" maxlength="32" placeholder="请输入行政区划名称" title="行政区划名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>区划排序:</td>
				<td><input type="number" name="divisionOrderby" id="divisionOrderby" value="${entity.divisionOrderby}" maxlength="32" placeholder="请输入行政区划排序" title="行政区划排序"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>区划级别:</td>
				<td>
				<select class="chzn-select" name="divisionLevel" id="divisionLevel" data-placeholder="请选择行政区划级别" style="vertical-align:top;width: 120px;" onchange="changeParent(this.value);">
					<option value="1" <c:if test="${entity.divisionLevel == 1}">selected</c:if>>省</option>
					<option value="2" <c:if test="${entity.divisionLevel == 2}">selected</c:if>>市</option>
					<option value="3" <c:if test="${entity.divisionLevel == 3}">selected</c:if>>区县</option>
			  	</select>
				</td>
			</tr>
			<tr style="display:none" id="parentTr">
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>父分类:</td>
				<td>
					<select class="chzn-select" id="parent1" style="vertical-align:top;width: 120px;" onchange="changeParent1(this.value);">
				  	</select>
				  	<select class="chzn-select" id="parent2" style="vertical-align:top;width: 120px;" onchange="changeParent2(this.value);">
				  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>邮编:</td>
				<td><input type="text" name="zipCode" id="zipCode" value="${entity.zipCode}" maxlength="32" placeholder="请输入邮编" title="邮编"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>区划代码:</td>
				<td><input type="text" name="addressCode" id="addressCode" value="${entity.addressCode}" maxlength="32" placeholder="请输入邮编" title="邮编"/></td>
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>