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
		if($("#sheetId").val()==""){
			popupTip('sheetId', '请输入问题单ID');
			return false;
		}
		if($("#questionId").val()==""){
			popupTip('questionId', '请输入问题ID');
			return false;
		}
		if($("#questionSeq").val()==""){
			popupTip('questionSeq', '请输入题目序号');
			return false;
		}
	
		var action = '${msg}';
		var url = 'checksheetquestionasso/' + action;
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
	<form action="checksheetquestionasso/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>问题单ID:</td>
				<td><input type="number" name="sheetId" id="sheetId" value="${entity.sheetId}" maxlength="32" placeholder="请输入问题单ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>问题ID:</td>
				<td><input type="number" name="questionId" id="questionId" value="${entity.questionId}" maxlength="32" placeholder="请输入问题ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>题目序号:</td>
				<td><input type="number" name="questionSeq" id="questionSeq" value="${entity.questionSeq}" maxlength="32" placeholder="请输入题目序号"/></td>
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