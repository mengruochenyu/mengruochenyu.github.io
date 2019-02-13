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
		if($("#patientItemId").val()==""){
			popupTip('patientItemId', '请输入病人id');
			return false;
		}
		if($("#checkPackageId").val()==""){
			popupTip('checkPackageId', '请输入套餐id');
			return false;
		}
		if($("#status").val()==""){
			popupTip('status', '请输入是否结束');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientpackageasso/' + action;
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
	<form action="patientpackageasso/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人id:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入病人id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐id:</td>
				<td><input type="number" name="checkPackageId" id="checkPackageId" value="${entity.checkPackageId}" maxlength="32" placeholder="请输入套餐id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>是否结束:</td>
				<td><input type="number" name="status" id="status" value="${entity.status}" maxlength="32" placeholder="请输入是否结束"/></td>
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