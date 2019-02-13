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
		if($("#checkSheetId").val()==""){
			popupTip('checkSheetId', '请输入体检表ID');
			return false;
		}
		if($("#checkSheetName").val()==""){
			popupTip('checkSheetName', '请输入检测体检表名称');
			return false;
		}
		if($("#questionId").val()==""){
			popupTip('questionId', '请输入题目ID');
			return false;
		}
		if($("#questionDescription").val()==""){
			popupTip('questionDescription', '请输入题目描述');
			return false;
		}
		if($("#questionName").val()==""){
			popupTip('questionName', '请输入题目名称');
			return false;
		}
		if($("#patientOption").val()==""){
			popupTip('patientOption', '请输入用户选择答案');
			return false;
		}
		if($("#patientScore").val()==""){
			popupTip('patientScore', '请输入用户分值');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientcheckquestionoption/' + action;
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
	<form action="patientcheckquestionoption/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户检测ID:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入用户检测ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检表ID:</td>
				<td><input type="number" name="checkSheetId" id="checkSheetId" value="${entity.checkSheetId}" maxlength="32" placeholder="请输入体检表ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测体检表名称:</td>
				<td><input type="text" name="checkSheetName" id="checkSheetName" value="${entity.checkSheetName}" maxlength="32" placeholder="请输入检测体检表名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>题目ID:</td>
				<td><input type="number" name="questionId" id="questionId" value="${entity.questionId}" maxlength="32" placeholder="请输入题目ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>题目描述:</td>
				<td><input type="text" name="questionDescription" id="questionDescription" value="${entity.questionDescription}" maxlength="32" placeholder="请输入题目描述"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>题目名称:</td>
				<td><input type="text" name="questionName" id="questionName" value="${entity.questionName}" maxlength="32" placeholder="请输入题目名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户选择答案:</td>
				<td><input type="text" name="patientOption" id="patientOption" value="${entity.patientOption}" maxlength="32" placeholder="请输入用户选择答案"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户分值:</td>
				<td><input type="number" name="patientScore" id="patientScore" value="${entity.patientScore}" maxlength="32" placeholder="请输入用户分值"/></td>
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