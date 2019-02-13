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
			popupTip('patientItemId', '请输入体检用户id');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入体检用户名称');
			return false;
		}
		if($("#groupName").val()==""){
			popupTip('groupName', '请输入团体名称');
			return false;
		}
		if($("#mobile").val()==""){
			popupTip('mobile', '请输入手机号');
			return false;
		}
		if($("#birthday").val()==""){
			popupTip('birthday', '请输入生日');
			return false;
		}
		if($("#degree").val()==""){
			popupTip('degree', '请输入学历');
			return false;
		}
		if($("#career").val()==""){
			popupTip('career', '请输入职业');
			return false;
		}
		if($("#maritalStatus").val()==""){
			popupTip('maritalStatus', '请输入未婚/已婚');
			return false;
		}
		if($("#questionId").val()==""){
			popupTip('questionId', '请输入体检问题id');
			return false;
		}
		if($("#questionDesc").val()==""){
			popupTip('questionDesc', '请输入体检问题描述');
			return false;
		}
		if($("#contType").val()==""){
			popupTip('contType', '请输入展示类型 0文本 1图片');
			return false;
		}
		if($("#patientOptionId").val()==""){
			popupTip('patientOptionId', '请输入用户选项id');
			return false;
		}
		if($("#patientOptionDesc").val()==""){
			popupTip('patientOptionDesc', '请输入用户选项描述');
			return false;
		}
		if($("#checkSheetId").val()==""){
			popupTip('checkSheetId', '请输入量表id');
			return false;
		}
		if($("#checkSheetName").val()==""){
			popupTip('checkSheetName', '请输入量表名称');
			return false;
		}
		if($("#sheetSumScore").val()==""){
			popupTip('sheetSumScore', '请输入量表总分');
			return false;
		}
		if($("#factorScores").val()==""){
			popupTip('factorScores', '请输入因子分数（用英文逗号隔开）');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientcheckdatacollection/' + action;
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
	<form action="patientcheckdatacollection/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检用户id:</td>
				<td><input type="number" name="patientItemId" id="patientItemId" value="${entity.patientItemId}" maxlength="32" placeholder="请输入体检用户id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检用户名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入体检用户名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>团体名称:</td>
				<td><input type="text" name="groupName" id="groupName" value="${entity.groupName}" maxlength="32" placeholder="请输入团体名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>手机号:</td>
				<td><input type="text" name="mobile" id="mobile" value="${entity.mobile}" maxlength="32" placeholder="请输入手机号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>生日:</td>
				<td><input class="span10 date-picker" name="birthday" id="birthday" value="${entity.birthday}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="生日"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>学历:</td>
				<td><input type="text" name="degree" id="degree" value="${entity.degree}" maxlength="32" placeholder="请输入学历"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>职业:</td>
				<td><input type="text" name="career" id="career" value="${entity.career}" maxlength="32" placeholder="请输入职业"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>未婚/已婚:</td>
				<td><input type="number" name="maritalStatus" id="maritalStatus" value="${entity.maritalStatus}" maxlength="32" placeholder="请输入未婚/已婚"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检问题id:</td>
				<td><input type="number" name="questionId" id="questionId" value="${entity.questionId}" maxlength="32" placeholder="请输入体检问题id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检问题描述:</td>
				<td><input type="text" name="questionDesc" id="questionDesc" value="${entity.questionDesc}" maxlength="32" placeholder="请输入体检问题描述"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>展示类型 0文本 1图片:</td>
				<td><input type="number" name="contType" id="contType" value="${entity.contType}" maxlength="32" placeholder="请输入展示类型 0文本 1图片"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户选项id:</td>
				<td><input type="number" name="patientOptionId" id="patientOptionId" value="${entity.patientOptionId}" maxlength="32" placeholder="请输入用户选项id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户选项描述:</td>
				<td><input type="text" name="patientOptionDesc" id="patientOptionDesc" value="${entity.patientOptionDesc}" maxlength="32" placeholder="请输入用户选项描述"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>量表id:</td>
				<td><input type="number" name="checkSheetId" id="checkSheetId" value="${entity.checkSheetId}" maxlength="32" placeholder="请输入量表id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>量表名称:</td>
				<td><input type="text" name="checkSheetName" id="checkSheetName" value="${entity.checkSheetName}" maxlength="32" placeholder="请输入量表名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>量表总分:</td>
				<td><input type="text" name="sheetSumScore" id="sheetSumScore" value="${entity.sheetSumScore}" maxlength="32" placeholder="请输入量表总分"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>因子分数（用英文逗号隔开）:</td>
				<td><input type="text" name="factorScores" id="factorScores" value="${entity.factorScores}" maxlength="32" placeholder="请输入因子分数（用英文逗号隔开）"/></td>
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