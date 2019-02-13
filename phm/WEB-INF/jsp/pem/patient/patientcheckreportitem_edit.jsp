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
		if($("#parentId").val()==""){
			popupTip('parentId', '请输入所属报告单ID');
			return false;
		}
		if($("#checkSheetId").val()==""){
			popupTip('checkSheetId', '请输入检测体检表ID');
			return false;
		}
		if($("#checkSheetName").val()==""){
			popupTip('checkSheetName', '请输入检测体检表名称');
			return false;
		}
		if($("#checkTime").val()==""){
			popupTip('checkTime', '请输入检测时间');
			return false;
		}
		if($("#checkScore").val()==""){
			popupTip('checkScore', '请输入检测分值');
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
		var url = 'patientcheckreportitem/' + action;
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
	<form action="patientcheckreportitem/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户检测ID:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入用户检测ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>所属报告单ID:</td>
				<td><input type="number" name="parentId" id="parentId" value="${entity.parentId}" maxlength="32" placeholder="请输入所属报告单ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测体检表ID:</td>
				<td><input type="number" name="checkSheetId" id="checkSheetId" value="${entity.checkSheetId}" maxlength="32" placeholder="请输入检测体检表ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测体检表名称:</td>
				<td><input type="text" name="checkSheetName" id="checkSheetName" value="${entity.checkSheetName}" maxlength="32" placeholder="请输入检测体检表名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测时间:</td>
				<td><input type="text" name="checkTime" id="checkTime" value="${entity.checkTime}" maxlength="32" placeholder="请输入检测时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测分值:</td>
				<td><input type="number" name="checkScore" id="checkScore" value="${entity.checkScore}" maxlength="32" placeholder="请输入检测分值"/></td>
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