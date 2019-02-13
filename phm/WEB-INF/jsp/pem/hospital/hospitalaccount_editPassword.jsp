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
/* 		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入医院ID');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入账号');
			return false;
		}
		if($("#password").val()==""){
			popupTip('password', '请输入密码');
			return false;
		}
		if($("#roleId").val()==""){
			popupTip('roleId', '请输入角色ID');
			return false;
		} */
		if($("#password").val()==""){
			popupTip('password', '请输入密码');
			return false;
		}
		if($("#password").val().length <8){
			popupTip('password', '密码长度不能小于8位');
			return false;
		}
		var action = '${msg}';
		var url = 'hospitalaccount/' + action;
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
	<form action="hospitalaccount/${msg}.do" name="editForm" id="editForm" method="post">
		<%-- <input type="hidden" name="accountName" id="accountName" value="${entity.accountName}"/> --%>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账号:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}"readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>新密码:</td>
				<td><input type="text" name="password" id="password" value="" maxlength="32" placeholder="请输入新密码"/></td>
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