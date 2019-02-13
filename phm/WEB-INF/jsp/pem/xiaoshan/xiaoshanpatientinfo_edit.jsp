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
		if($("#pid").val()==""){
			popupTip('pid', '请输入病人ID');
			return false;
		}
		if($("#insuranceNo").val()==""){
			popupTip('insuranceNo', '请输入病人医保号');
			return false;
		}
		if($("#patientName").val()==""){
			popupTip('patientName', '请输入病人姓名');
			return false;
		}
		if($("#sex").val()==""){
			popupTip('sex', '请输入病人性别');
			return false;
		}
		if($("#dateOfBirth").val()==""){
			popupTip('dateOfBirth', '请输入病人出生日期（格式：yyyyMMdd）');
			return false;
		}
		if($("#marriageStatus").val()==""){
			popupTip('marriageStatus', '请输入病人婚姻状况');
			return false;
		}
		if($("#occupation").val()==""){
			popupTip('occupation', '请输入病人职业');
			return false;
		}
		if($("#formalSchooling").val()==""){
			popupTip('formalSchooling', '请输入病人文化水平');
			return false;
		}
		if($("#nativePlace").val()==""){
			popupTip('nativePlace', '请输入病人籍贯');
			return false;
		}
		if($("#certType").val()==""){
			popupTip('certType', '请输入病人证件类型');
			return false;
		}
		if($("#certNo").val()==""){
			popupTip('certNo', '请输入病人证件号');
			return false;
		}
		if($("#patientClass").val()==""){
			popupTip('patientClass', '请输入病人身份');
			return false;
		}
		if($("#company").val()==""){
			popupTip('company', '请输入病人工作单位');
			return false;
		}
		if($("#publicExpenseNo").val()==""){
			popupTip('publicExpenseNo', '请输入病人医疗证号');
			return false;
		}
		if($("#contractUnit").val()==""){
			popupTip('contractUnit', '请输入合同单位');
			return false;
		}
		if($("#businessAddress").val()==""){
			popupTip('businessAddress', '请输入病人工作单位地址');
			return false;
		}
		if($("#businessPostCode").val()==""){
			popupTip('businessPostCode', '请输入病人工作单位邮编');
			return false;
		}
		if($("#businessPhone").val()==""){
			popupTip('businessPhone', '请输入病人工作单位电话');
			return false;
		}
		if($("#homeAddressCode").val()==""){
			popupTip('homeAddressCode', '请输入病人家庭住址代码');
			return false;
		}
		if($("#homeAddress").val()==""){
			popupTip('homeAddress', '请输入病人家庭住址');
			return false;
		}
		if($("#mobilePhone").val()==""){
			popupTip('mobilePhone', '请输入病人手机号');
			return false;
		}
		if($("#operator").val()==""){
			popupTip('operator', '请输入经办人');
			return false;
		}
		if($("#operatorTime").val()==""){
			popupTip('operatorTime', '请输入办理时间（格式：yyyyMMddHHmmss）');
			return false;
		}
		if($("#available").val()==""){
			popupTip('available', '请输入可用标志（Y-可用 N-停用）');
			return false;
		}
	
		var action = '${msg}';
		var url = 'xiaoshanpatientinfo/' + action;
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
	<form action="xiaoshanpatientinfo/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人ID:</td>
				<td><input type="text" name="pid" id="pid" value="${entity.pid}" maxlength="32" placeholder="请输入病人ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人医保号:</td>
				<td><input type="text" name="insuranceNo" id="insuranceNo" value="${entity.insuranceNo}" maxlength="32" placeholder="请输入病人医保号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人姓名:</td>
				<td><input type="text" name="patientName" id="patientName" value="${entity.patientName}" maxlength="32" placeholder="请输入病人姓名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人性别:</td>
				<td><input type="text" name="sex" id="sex" value="${entity.sex}" maxlength="32" placeholder="请输入病人性别"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人出生日期（格式：yyyyMMdd）:</td>
				<td><input type="text" name="dateOfBirth" id="dateOfBirth" value="${entity.dateOfBirth}" maxlength="32" placeholder="请输入病人出生日期（格式：yyyyMMdd）"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人婚姻状况:</td>
				<td><input type="text" name="marriageStatus" id="marriageStatus" value="${entity.marriageStatus}" maxlength="32" placeholder="请输入病人婚姻状况"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人职业:</td>
				<td><input type="text" name="occupation" id="occupation" value="${entity.occupation}" maxlength="32" placeholder="请输入病人职业"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人文化水平:</td>
				<td><input type="text" name="formalSchooling" id="formalSchooling" value="${entity.formalSchooling}" maxlength="32" placeholder="请输入病人文化水平"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人籍贯:</td>
				<td><input type="text" name="nativePlace" id="nativePlace" value="${entity.nativePlace}" maxlength="32" placeholder="请输入病人籍贯"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人证件类型:</td>
				<td><input type="text" name="certType" id="certType" value="${entity.certType}" maxlength="32" placeholder="请输入病人证件类型"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人证件号:</td>
				<td><input type="text" name="certNo" id="certNo" value="${entity.certNo}" maxlength="32" placeholder="请输入病人证件号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人身份:</td>
				<td><input type="text" name="patientClass" id="patientClass" value="${entity.patientClass}" maxlength="32" placeholder="请输入病人身份"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人工作单位:</td>
				<td><input type="text" name="company" id="company" value="${entity.company}" maxlength="32" placeholder="请输入病人工作单位"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人医疗证号:</td>
				<td><input type="text" name="publicExpenseNo" id="publicExpenseNo" value="${entity.publicExpenseNo}" maxlength="32" placeholder="请输入病人医疗证号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>合同单位:</td>
				<td><input type="text" name="contractUnit" id="contractUnit" value="${entity.contractUnit}" maxlength="32" placeholder="请输入合同单位"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人工作单位地址:</td>
				<td><input type="text" name="businessAddress" id="businessAddress" value="${entity.businessAddress}" maxlength="32" placeholder="请输入病人工作单位地址"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人工作单位邮编:</td>
				<td><input type="text" name="businessPostCode" id="businessPostCode" value="${entity.businessPostCode}" maxlength="32" placeholder="请输入病人工作单位邮编"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人工作单位电话:</td>
				<td><input type="text" name="businessPhone" id="businessPhone" value="${entity.businessPhone}" maxlength="32" placeholder="请输入病人工作单位电话"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人家庭住址代码:</td>
				<td><input type="text" name="homeAddressCode" id="homeAddressCode" value="${entity.homeAddressCode}" maxlength="32" placeholder="请输入病人家庭住址代码"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人家庭住址:</td>
				<td><input type="text" name="homeAddress" id="homeAddress" value="${entity.homeAddress}" maxlength="32" placeholder="请输入病人家庭住址"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>病人手机号:</td>
				<td><input type="text" name="mobilePhone" id="mobilePhone" value="${entity.mobilePhone}" maxlength="32" placeholder="请输入病人手机号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>经办人:</td>
				<td><input type="text" name="operator" id="operator" value="${entity.operator}" maxlength="32" placeholder="请输入经办人"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>办理时间（格式：yyyyMMddHHmmss）:</td>
				<td><input type="text" name="operatorTime" id="operatorTime" value="${entity.operatorTime}" maxlength="32" placeholder="请输入办理时间（格式：yyyyMMddHHmmss）"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>可用标志（Y-可用 N-停用）:</td>
				<td><input type="text" name="available" id="available" value="${entity.available}" maxlength="32" placeholder="请输入可用标志（Y-可用 N-停用）"/></td>
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