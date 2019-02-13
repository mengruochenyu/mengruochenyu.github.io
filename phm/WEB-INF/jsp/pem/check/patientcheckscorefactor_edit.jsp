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
			popupTip('name', '请输入因子名称');
			return false;
		}
		if($("#sumScore").val()==""){
			popupTip('score', '请输入分数');
			return false;
		}
		if($("#remark").val()==""){
			popupTip('remark', '请输入评语');
			return false;
		}
		if($("#sheetId").val()==""){
			popupTip('sheetId', '请输入体检表ID');
			return false;
		}
		if($("#questionIdStr").val()==""){
			popupTip('questionIdStr', '请输入题目ID');
			return false;
		}
		if($("#optionIdStr").val()==""){
			popupTip('optionIdStr', '请输入选项ID');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientcheckscorefactor/' + action;
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
	<form action="patientcheckscorefactor/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>因子名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入因子名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>分数:</td>
				<td><input type="number" name="score" id="score" value="${entity.score}" maxlength="32" placeholder="请输入分数"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>评语:</td>
				<td><input type="text" name="remark" id="remark" value="${entity.remark}" maxlength="32" placeholder="请输入评语"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检表ID:</td>
				<td><input type="number" name="sheetId" id="sheetId" value="${entity.sheetId}" maxlength="32" placeholder="请输入体检表ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>题目ID:</td>
				<td><input type="text" name="questionIdStr" id="questionIdStr" value="${entity.questionIdStr}" maxlength="32" placeholder="请输入题目ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>选项ID:</td>
				<td><input type="text" name="optionIdStr" id="optionIdStr" value="${entity.optionIdStr}" maxlength="32" placeholder="请输入选项ID"/></td>
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