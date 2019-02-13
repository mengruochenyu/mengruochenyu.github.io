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
		if($("#departmentId").val()==""){
			popupTip('departmentId', '请输入部门id');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入小组名称');
			return false;
		}
		if($("#account").val()==""){
			popupTip('account', '请输入小组账号');
			return false;
		}
		if($("#password").val()==""){
			popupTip('password', '请输入小组密码');
			return false;
		}
	
		var action = '${msg}';
		var url = 'hospitalgroupteam/' + action;
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
		$("#" + field).focus();
	}
	
</script>
	</head>
<body>
	<form action="hospitalgroupteam/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>部门id:</td>
				<td><input type="number" name="departmentId" id="departmentId" value="${entity.departmentId}" maxlength="32" placeholder="请输入部门id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>小组名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入小组名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>小组账号:</td>
				<td><input type="text" name="account" id="account" value="${entity.account}" maxlength="32" placeholder="请输入小组账号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>小组密码:</td>
				<td><input type="text" name="password" id="password" value="${entity.password}" maxlength="32" placeholder="请输入小组密码"/></td>
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