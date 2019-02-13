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
		if($("#name").val()==""){
			popupTip('name', '请输入名称');
			return false;
		}
		if($("#accountName").val()==""){
			popupTip('accountName', '请输入账号');
			return false;
		}
		if($("#dockingName").val()==""){
			popupTip('dockingName', '请输入对接人');
			return false;
		}
		if($("#dockingPhone").val()==""){
			popupTip('dockingPhone', '请输入对接人电话');
			return false;
		}
	
		var action = '${msg}';
		var url = 'hospitaldepartment/' + action;
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
	<form action="hospitaldepartment/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<input type="hidden" name="hospitalId" value="<%=request.getParameter("hospitalId")%>"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账号:</td>
				<td><input type="text" name="accountName" id="accountName"  <c:if test="${msg == 'edit'}">readonly='readonly'</c:if> value="${entity.accountName}" maxlength="32" placeholder="请输入账号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人:</td>
				<td><input type="text" name="dockingName" id="dockingName" value="${entity.dockingName}" maxlength="32" placeholder="请输入对接人"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人电话:</td>
				<td><input type="text" name="dockingPhone" id="dockingPhone" value="${entity.dockingPhone}" maxlength="32" placeholder="请输入对接人电话"/></td>
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