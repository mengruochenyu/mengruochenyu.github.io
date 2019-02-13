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
		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入医院ID');
			return false;
		}
		if($("#groupId").val()==""){
			popupTip('groupId', '请输入团体ID');
			return false;
		}
		if($("#groupName").val()==""){
			popupTip('groupName', '请输入团体名称');
			return false;
		}
		if($("#checkCardType").val()==""){
			popupTip('checkCardType', '请输入检测卡类型');
			return false;
		}
		if($("#checkCardNum").val()==""){
			popupTip('checkCardNum', '请输入检测卡卡号');
			return false;
		}
		if($("#checkOfficeId").val()==""){
			popupTip('checkOfficeId', '请输入科室ID');
			return false;
		}
		if($("#checkOfficeName").val()==""){
			popupTip('checkOfficeName', '请输入科室名称');
			return false;
		}
		if($("#checkDoctorId").val()==""){
			popupTip('checkDoctorId', '请输入医生ID');
			return false;
		}
		if($("#checkDoctorName").val()==""){
			popupTip('checkDoctorName', '请输入医生');
			return false;
		}
		if($("#checkPackageId").val()==""){
			popupTip('checkPackageId', '请输入套餐ID');
			return false;
		}
		if($("#checkPackageName").val()==""){
			popupTip('checkPackageName', '请输入套餐名称');
			return false;
		}
		if($("#treatCardStatus").val()==""){
			popupTip('treatCardStatus', '请输入干预卡状态');
			return false;
		}
		if($("#treatCardNum").val()==""){
			popupTip('treatCardNum', '请输入干预卡卡号');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入姓名');
			return false;
		}
		if($("#department").val()==""){
			popupTip('department', '请输入部门');
			return false;
		}
		if($("#gender").val()==""){
			popupTip('gender', '请输入性别');
			return false;
		}
		if($("#mobile").val()==""){
			popupTip('mobile', '请输入手机号');
			return false;
		}
		if($("#birthday").val()==""){
			popupTip('birthday', '请输入出生年月');
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
			popupTip('maritalStatus', '请输入婚姻状况');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientitem/' + action;
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
	<form action="patientitem/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院ID:</td>
				<td><input type="number" name="hospitalId" id="hospitalId" value="${entity.hospitalId}" maxlength="32" placeholder="请输入医院ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>团体ID:</td>
				<td><input type="number" name="groupId" id="groupId" value="${entity.groupId}" maxlength="32" placeholder="请输入团体ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>团体名称:</td>
				<td><input type="text" name="groupName" id="groupName" value="${entity.groupName}" maxlength="32" placeholder="请输入团体名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测卡类型:</td>
				<td><input type="number" name="checkCardType" id="checkCardType" value="${entity.checkCardType}" maxlength="32" placeholder="请输入检测卡类型"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测卡卡号:</td>
				<td><input type="text" name="checkCardNum" id="checkCardNum" value="${entity.checkCardNum}" maxlength="32" placeholder="请输入检测卡卡号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>科室ID:</td>
				<td><input type="number" name="checkOfficeId" id="checkOfficeId" value="${entity.checkOfficeId}" maxlength="32" placeholder="请输入科室ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>科室名称:</td>
				<td><input type="text" name="checkOfficeName" id="checkOfficeName" value="${entity.checkOfficeName}" maxlength="32" placeholder="请输入科室名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生ID:</td>
				<td><input type="number" name="checkDoctorId" id="checkDoctorId" value="${entity.checkDoctorId}" maxlength="32" placeholder="请输入医生ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生:</td>
				<td><input type="text" name="checkDoctorName" id="checkDoctorName" value="${entity.checkDoctorName}" maxlength="32" placeholder="请输入医生"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐ID:</td>
				<td><input type="number" name="checkPackageId" id="checkPackageId" value="${entity.checkPackageId}" maxlength="32" placeholder="请输入套餐ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐名称:</td>
				<td><input type="text" name="checkPackageName" id="checkPackageName" value="${entity.checkPackageName}" maxlength="32" placeholder="请输入套餐名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>干预卡状态:</td>
				<td><input type="number" name="treatCardStatus" id="treatCardStatus" value="${entity.treatCardStatus}" maxlength="32" placeholder="请输入干预卡状态"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>干预卡卡号:</td>
				<td><input type="text" name="treatCardNum" id="treatCardNum" value="${entity.treatCardNum}" maxlength="32" placeholder="请输入干预卡卡号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>姓名:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入姓名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>部门:</td>
				<td><input type="text" name="department" id="department" value="${entity.department}" maxlength="32" placeholder="请输入部门"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>性别:</td>
				<td><input type="number" name="gender" id="gender" value="${entity.gender}" maxlength="32" placeholder="请输入性别"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>手机号:</td>
				<td><input type="text" name="mobile" id="mobile" value="${entity.mobile}" maxlength="32" placeholder="请输入手机号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>出生年月:</td>
				<td><input type="text" name="birthday" id="birthday" value="${entity.birthday}" maxlength="32" placeholder="请输入出生年月"/></td>
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
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>婚姻状况:</td>
				<td><input type="number" name="maritalStatus" id="maritalStatus" value="${entity.maritalStatus}" maxlength="32" placeholder="请输入婚姻状况"/></td>
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