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
</script>
	</head>
<body>
	<form action="patientcheckreport/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
<%-- 			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告单状态:</td>
				<td><input type="number" name="reportStatus" id="reportStatus" value="${entity.reportStatus}" maxlength="32" placeholder="请输入报告单状态"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测时间:</td>
				<td><input type="text" name="checkTime" id="checkTime" value="${entity.checkTime}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告时间:</td>
				<td><input type="text" name="reportTime" id="reportTime" value="${entity.reportTime}" readonly="readonly"/></td>
			</tr>
<%-- 			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生ID:</td>
				<td><input type="number" name="auditDoctorId" id="auditDoctorId" value="${entity.auditDoctorId}" maxlength="32" placeholder="请输入审核医生ID"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生名称:</td>
				<td><input type="text" name="auditDoctorName" id="auditDoctorName" value="${entity.auditDoctorName}" readonly="readonly"/></td>
			</tr>
<%-- 			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生签名:</td>
				<td><input type="text" name="auditDoctorSign" id="auditDoctorSign" value="${entity.auditDoctorSign}" maxlength="32" placeholder="请输入审核医生签名"/></td>
			</tr --%>>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核时间:</td>
				<td><input type="text" name="auditTime" id="auditTime" value="${entity.auditTime}" readonly="readonly"/></td>
			</tr>
<%-- 			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告单号:</td>
				<td><input type="text" name="reportNum" id="reportNum" value="${entity.reportNum}" maxlength="32" placeholder="请输入报告单号"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测评语:</td>
				<td><textarea style="width:200px" name="checkComment" id="checkComment" readonly="readonly">${entity.checkComment}</textarea></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测建议:</td>
				<td><textarea style="width:200px" name="checkComment" id="checkComment" readonly="readonly">${entity.checkSuggest}</textarea></td>
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<!-- <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a> -->
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>