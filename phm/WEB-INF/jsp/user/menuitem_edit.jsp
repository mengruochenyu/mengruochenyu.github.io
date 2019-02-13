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
		if($("#menuName").val()==""){
			popupTip('menuName', '请输入菜单名称');
			return false;
		}
		if($("#menuUrl").val()==""){
			popupTip('menuUrl', '请输入菜单对应跳转url');
			return false;
		}
		if($("#parentId").val()==""){
			popupTip('parentId', '请输入父菜单ID');
			return false;
		}
		if($("#menuOrder").val()==""){
			popupTip('menuOrder', '请输入菜单排序');
			return false;
		}
		if($("#menuIcon").val()==""){
			popupTip('menuIcon', '请输入菜单图标');
			return false;
		}
		if($("#menuType").val()==""){
			popupTip('menuType', '请输入菜单类型');
			return false;
		}
	
		var action = '${msg}';
		var url = 'menuitem/' + action;
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
	<form action="menuitem/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="menuItemId" id="menuItemId" value="${entity.menuItemId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单名称:</td>
				<td><input type="text" name="menuName" id="menuName" value="${entity.menuName}" maxlength="32" placeholder="请输入菜单名称" title="菜单名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单对应跳转url:</td>
				<td><input type="text" name="menuUrl" id="menuUrl" value="${entity.menuUrl}" maxlength="32" placeholder="请输入菜单对应跳转url" title="菜单对应跳转url"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>父菜单ID:</td>
				<td><input type="number" name="parentId" id="parentId" value="${entity.parentId}" maxlength="32" placeholder="请输入父菜单ID" title="父菜单ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单排序:</td>
				<td><input type="number" name="menuOrder" id="menuOrder" value="${entity.menuOrder}" maxlength="32" placeholder="请输入菜单排序" title="菜单排序"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单图标:</td>
				<td><input type="text" name="menuIcon" id="menuIcon" value="${entity.menuIcon}" maxlength="32" placeholder="请输入菜单图标" title="菜单图标"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>菜单类型:</td>
				<td><input type="number" name="menuType" id="menuType" value="${entity.menuType}" maxlength="32" placeholder="请输入菜单类型" title="菜单类型"/></td>
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