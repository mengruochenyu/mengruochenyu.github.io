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
		if($("#groupId").val()==""){
			popupTip('groupId', '请输入团体id');
			return false;
		}
		if($("#number").val()==""){
			popupTip('number', '请输入编号');
			return false;
		}
		if($("#remark").val()==""){
			popupTip('remark', '请输入备注');
			return false;
		}
	
		var action = '${msg}';
		var url = 'hospitalbatch/' + action;
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
	<form action="hospitalbatch/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>团体id:</td>
				<td><input type="number" name="groupId" id="groupId" value="${entity.groupId}" maxlength="32" placeholder="请输入团体id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>编号:</td>
				<td><input type="text" name="number" id="number" value="${entity.number}" maxlength="32" placeholder="请输入编号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>备注:</td>
				<td><input type="text" name="remark" id="remark" value="${entity.remark}" maxlength="32" placeholder="请输入备注"/></td>
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