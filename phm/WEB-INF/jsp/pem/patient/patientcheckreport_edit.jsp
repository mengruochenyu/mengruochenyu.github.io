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
			popupTip('patientItemId', '请输入用户检测ID');
			return false;
		}
		if($("#reportStatus").val()==""){
			popupTip('reportStatus', '请输入报告单状态');
			return false;
		}
		if($("#checkTime").val()==""){
			popupTip('checkTime', '请输入检测时间');
			return false;
		}
		if($("#reportTime").val()==""){
			popupTip('reportTime', '请输入报告时间');
			return false;
		}
		if($("#auditDoctorId").val()==""){
			popupTip('auditDoctorId', '请输入审核医生ID');
			return false;
		}
		if($("#auditDoctorName").val()==""){
			popupTip('auditDoctorName', '请输入审核医生名称');
			return false;
		}
		if($("#auditDoctorSign").val()==""){
			popupTip('auditDoctorSign', '请输入审核医生签名');
			return false;
		}
		if($("#auditTime").val()==""){
			popupTip('auditTime', '请输入审核时间');
			return false;
		}
		if($("#reportNum").val()==""){
			popupTip('reportNum', '请输入报告单号');
			return false;
		}
		if($("#checkComment").val()==""){
			popupTip('checkComment', '请输入检测评语');
			return false;
		}
		if($("#checkSuggest").val()==""){
			popupTip('checkSuggest', '请输入检测建议');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientcheckreport/' + action;
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
	<form action="patientcheckreport/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户检测ID:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入用户检测ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告单状态:</td>
				<td><input type="number" name="reportStatus" id="reportStatus" value="${entity.reportStatus}" maxlength="32" placeholder="请输入报告单状态"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测时间:</td>
				<td><input type="text" name="checkTime" id="checkTime" value="${entity.checkTime}" maxlength="32" placeholder="请输入检测时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告时间:</td>
				<td><input type="text" name="reportTime" id="reportTime" value="${entity.reportTime}" maxlength="32" placeholder="请输入报告时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生ID:</td>
				<td><input type="number" name="auditDoctorId" id="auditDoctorId" value="${entity.auditDoctorId}" maxlength="32" placeholder="请输入审核医生ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生名称:</td>
				<td><input type="text" name="auditDoctorName" id="auditDoctorName" value="${entity.auditDoctorName}" maxlength="32" placeholder="请输入审核医生名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核医生签名:</td>
				<td><input type="text" name="auditDoctorSign" id="auditDoctorSign" value="${entity.auditDoctorSign}" maxlength="32" placeholder="请输入审核医生签名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>审核时间:</td>
				<td><input type="text" name="auditTime" id="auditTime" value="${entity.auditTime}" maxlength="32" placeholder="请输入审核时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>报告单号:</td>
				<td><input type="text" name="reportNum" id="reportNum" value="${entity.reportNum}" maxlength="32" placeholder="请输入报告单号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测评语:</td>
				<td><input type="text" name="checkComment" id="checkComment" value="${entity.checkComment}" maxlength="32" placeholder="请输入检测评语"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测建议:</td>
				<td><input type="text" name="checkSuggest" id="checkSuggest" value="${entity.checkSuggest}" maxlength="32" placeholder="请输入检测建议"/></td>
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