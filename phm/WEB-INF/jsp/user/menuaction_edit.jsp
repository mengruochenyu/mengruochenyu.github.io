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
		if($("#menuActionCode").val()==""){
			popupTip('menuActionCode', '请输入菜单动作编号');
			return false;
		}
		if($("#menuActionName").val()==""){
			popupTip('menuActionName', '请输入菜单动作名称');
			return false;
		}
		if($("#menuActionOrder").val()==""){
			popupTip('menuActionOrder', '请输入菜单动作排序');
			return false;
		}
		if($("#menuId").val()==""){
			popupTip('menuId', '请输入菜单表ID');
			return false;
		}
	
		var action = '${msg}';
		var url = 'menuaction/' + action;
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
	<form action="menuaction/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="menuActionId" id="menuActionId" value="${entity.menuActionId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单动作编号:</td>
				<td><input type="text" name="menuActionCode" id="menuActionCode" value="${entity.menuActionCode}" maxlength="32" placeholder="请输入菜单动作编号" title="菜单动作编号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单动作名称:</td>
				<td><input type="text" name="menuActionName" id="menuActionName" value="${entity.menuActionName}" maxlength="32" placeholder="请输入菜单动作名称" title="菜单动作名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单动作排序:</td>
				<td><input type="number" name="menuActionOrder" id="menuActionOrder" value="${entity.menuActionOrder}" maxlength="32" placeholder="请输入菜单动作排序" title="菜单动作排序"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单表ID:</td>
				<td><input type="number" name="menuId" id="menuId" value="${entity.menuId}" maxlength="32" placeholder="请输入菜单表ID" title="菜单表ID"/></td>
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