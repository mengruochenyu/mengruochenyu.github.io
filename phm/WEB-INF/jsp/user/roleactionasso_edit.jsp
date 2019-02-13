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
		if($("#roleId").val()==""){
			popupTip('roleId', '请输入角色权限表ID');
			return false;
		}
		if($("#menuActionId").val()==""){
			popupTip('menuActionId', '请输入菜单动作表ID');
			return false;
		}
	
		var action = '${msg}';
		var url = 'roleactionasso/' + action;
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
	
</script>
	</head>
<body>
	<form action="roleactionasso/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="roleActionAssoId" id="roleActionAssoId" value="${entity.roleActionAssoId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>角色权限表ID:</td>
				<td><input type="number" name="roleId" id="roleId" value="${entity.roleId}" maxlength="32" placeholder="请输入角色权限表ID" title="角色权限表ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单动作表ID:</td>
				<td><input type="number" name="menuActionId" id="menuActionId" value="${entity.menuActionId}" maxlength="32" placeholder="请输入菜单动作表ID" title="菜单动作表ID"/></td>
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