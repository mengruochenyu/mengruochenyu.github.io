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
			popupTip('checkSheetId', '请输入检测体检表ID');
			return false;
		}
		if($("#lookStatus").val()==""){
			popupTip('lookStatus', '请输入查看状态');
			return false;
		}
		if($("#dealStatus").val()==""){
			popupTip('dealStatus', '请输入处理状态');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientcheckalert/' + action;
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
	<form action="patientcheckalert/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户检测ID:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入用户检测ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测体检表ID:</td>
				<td><input type="number" name="checkSheetId" id="checkSheetId" value="${entity.checkSheetId}" maxlength="32" placeholder="请输入检测体检表ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>查看状态:</td>
				<td><input type="number" name="lookStatus" id="lookStatus" value="${entity.lookStatus}" maxlength="32" placeholder="请输入查看状态"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>处理状态:</td>
				<td><input type="number" name="dealStatus" id="dealStatus" value="${entity.dealStatus}" maxlength="32" placeholder="请输入处理状态"/></td>
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