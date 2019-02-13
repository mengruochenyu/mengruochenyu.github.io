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
			popupTip('pid', '请输入示例：10025880');
			return false;
		}
		if($("#insuranceNo").val()==""){
			popupTip('insuranceNo', '请输入示例：801952555876');
			return false;
		}
		if($("#patientName").val()==""){
			popupTip('patientName', '请输入示例：测试1');
			return false;
		}
		if($("#tmpFlag").val()==""){
			popupTip('tmpFlag', '请输入示例：正式');
			return false;
		}
		if($("#lastName").val()==""){
			popupTip('lastName', '请输入示例：测');
			return false;
		}
		if($("#firstName").val()==""){
			popupTip('firstName', '请输入示例：试1');
			return false;
		}
		if($("#py").val()==""){
			popupTip('py', '请输入示例：CS1');
			return false;
		}
		if($("#wb").val()==""){
			popupTip('wb', '请输入示例：IY1');
			return false;
		}
		if($("#sexCode").val()==""){
			popupTip('sexCode', '请输入示例：1');
			return false;
		}
		if($("#sex").val()==""){
			popupTip('sex', '请输入示例：男');
			return false;
		}
		if($("#dateOfBirth").val()==""){
			popupTip('dateOfBirth', '请输入示例：19790905');
			return false;
		}
		if($("#timeOfBirth").val()==""){
			popupTip('timeOfBirth', '请输入示例：000000');
			return false;
		}
		if($("#marriageStatusCode").val()==""){
			popupTip('marriageStatusCode', '请输入示例：1');
			return false;
		}
		if($("#marriageStatus").val()==""){
			popupTip('marriageStatus', '请输入示例：未婚');
			return false;
		}
		if($("#occupationCode").val()==""){
			popupTip('occupationCode', '请输入示例：4');
			return false;
		}
		if($("#occupation").val()==""){
			popupTip('occupation', '请输入示例：教师');
			return false;
		}
		if($("#nationalityCode").val()==""){
			popupTip('nationalityCode', '请输入示例：1');
			return false;
		}
		if($("#nationality").val()==""){
			popupTip('nationality', '请输入示例：汉族');
			return false;
		}
		if($("#countryCode").val()==""){
			popupTip('countryCode', '请输入示例：CN');
			return false;
		}
		if($("#country").val()==""){
			popupTip('country', '请输入示例：中国');
			return false;
		}
		if($("#birthPlace").val()==""){
			popupTip('birthPlace', '请输入示例：杭州市萧山区城厢街道萧然东路19号');
			return false;
		}
		if($("#nativePlace").val()==""){
			popupTip('nativePlace', '请输入示例：');
			return false;
		}
		if($("#bloodType").val()==""){
			popupTip('bloodType', '请输入示例：');
			return false;
		}
		if($("#certType").val()==""){
			popupTip('certType', '请输入示例：身份证');
			return false;
		}
		if($("#certNo").val()==""){
			popupTip('certNo', '请输入示例：339005197909054915');
			return false;
		}
		if($("#feeTypeCode").val()==""){
			popupTip('feeTypeCode', '请输入示例：01');
			return false;
		}
		if($("#feeType").val()==""){
			popupTip('feeType', '请输入示例：');
			return false;
		}
		if($("#company").val()==""){
			popupTip('company', '请输入示例：浙江萧山医院');
			return false;
		}
		if($("#businessAddress").val()==""){
			popupTip('businessAddress', '请输入示例：浙江萧山医院');
			return false;
		}
		if($("#businessPostCode").val()==""){
			popupTip('businessPostCode', '请输入示例：');
			return false;
		}
		if($("#businessPhone").val()==""){
			popupTip('businessPhone', '请输入示例：');
			return false;
		}
		if($("#homeAddressCode").val()==""){
			popupTip('homeAddressCode', '请输入示例：');
			return false;
		}
		if($("#homeAddress").val()==""){
			popupTip('homeAddress', '请输入示例：浙江');
			return false;
		}
		if($("#homePostCode").val()==""){
			popupTip('homePostCode', '请输入示例：');
			return false;
		}
		if($("#mobilePhone").val()==""){
			popupTip('mobilePhone', '请输入示例：18967168210');
			return false;
		}
		if($("#contact").val()==""){
			popupTip('contact', '请输入示例：蒋利军');
			return false;
		}
		if($("#relationCode").val()==""){
			popupTip('relationCode', '请输入示例：1');
			return false;
		}
		if($("#relation").val()==""){
			popupTip('relation', '请输入示例：配偶');
			return false;
		}
		if($("#contactMethod").val()==""){
			popupTip('contactMethod', '请输入示例：888210');
			return false;
		}
		if($("#operatorId").val()==""){
			popupTip('operatorId', '请输入示例：1');
			return false;
		}
		if($("#operator").val()==""){
			popupTip('operator', '请输入示例：倪震涛');
			return false;
		}
		if($("#operatorTime").val()==""){
			popupTip('operatorTime', '请输入示例：20140912134302');
			return false;
		}
	
		var action = '${msg}';
		var url = 'xiaoshaninhospitalinfo/' + action;
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
	<form action="xiaoshaninhospitalinfo/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：10025880:</td>
				<td><input type="text" name="pid" id="pid" value="${entity.pid}" maxlength="32" placeholder="请输入示例：10025880"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：801952555876:</td>
				<td><input type="text" name="insuranceNo" id="insuranceNo" value="${entity.insuranceNo}" maxlength="32" placeholder="请输入示例：801952555876"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：测试1:</td>
				<td><input type="text" name="patientName" id="patientName" value="${entity.patientName}" maxlength="32" placeholder="请输入示例：测试1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：正式:</td>
				<td><input type="text" name="tmpFlag" id="tmpFlag" value="${entity.tmpFlag}" maxlength="32" placeholder="请输入示例：正式"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：测:</td>
				<td><input type="text" name="lastName" id="lastName" value="${entity.lastName}" maxlength="32" placeholder="请输入示例：测"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：试1:</td>
				<td><input type="text" name="firstName" id="firstName" value="${entity.firstName}" maxlength="32" placeholder="请输入示例：试1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：CS1:</td>
				<td><input type="text" name="py" id="py" value="${entity.py}" maxlength="32" placeholder="请输入示例：CS1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：IY1:</td>
				<td><input type="text" name="wb" id="wb" value="${entity.wb}" maxlength="32" placeholder="请输入示例：IY1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：1:</td>
				<td><input type="text" name="sexCode" id="sexCode" value="${entity.sexCode}" maxlength="32" placeholder="请输入示例：1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：男:</td>
				<td><input type="text" name="sex" id="sex" value="${entity.sex}" maxlength="32" placeholder="请输入示例：男"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：19790905:</td>
				<td><input type="text" name="dateOfBirth" id="dateOfBirth" value="${entity.dateOfBirth}" maxlength="32" placeholder="请输入示例：19790905"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：000000:</td>
				<td><input type="text" name="timeOfBirth" id="timeOfBirth" value="${entity.timeOfBirth}" maxlength="32" placeholder="请输入示例：000000"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：1:</td>
				<td><input type="text" name="marriageStatusCode" id="marriageStatusCode" value="${entity.marriageStatusCode}" maxlength="32" placeholder="请输入示例：1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：未婚:</td>
				<td><input type="text" name="marriageStatus" id="marriageStatus" value="${entity.marriageStatus}" maxlength="32" placeholder="请输入示例：未婚"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：4:</td>
				<td><input type="text" name="occupationCode" id="occupationCode" value="${entity.occupationCode}" maxlength="32" placeholder="请输入示例：4"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：教师:</td>
				<td><input type="text" name="occupation" id="occupation" value="${entity.occupation}" maxlength="32" placeholder="请输入示例：教师"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：1:</td>
				<td><input type="text" name="nationalityCode" id="nationalityCode" value="${entity.nationalityCode}" maxlength="32" placeholder="请输入示例：1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：汉族:</td>
				<td><input type="text" name="nationality" id="nationality" value="${entity.nationality}" maxlength="32" placeholder="请输入示例：汉族"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：CN:</td>
				<td><input type="text" name="countryCode" id="countryCode" value="${entity.countryCode}" maxlength="32" placeholder="请输入示例：CN"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：中国:</td>
				<td><input type="text" name="country" id="country" value="${entity.country}" maxlength="32" placeholder="请输入示例：中国"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：杭州市萧山区城厢街道萧然东路19号:</td>
				<td><input type="text" name="birthPlace" id="birthPlace" value="${entity.birthPlace}" maxlength="32" placeholder="请输入示例：杭州市萧山区城厢街道萧然东路19号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="nativePlace" id="nativePlace" value="${entity.nativePlace}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="bloodType" id="bloodType" value="${entity.bloodType}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：身份证:</td>
				<td><input type="text" name="certType" id="certType" value="${entity.certType}" maxlength="32" placeholder="请输入示例：身份证"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：339005197909054915:</td>
				<td><input type="text" name="certNo" id="certNo" value="${entity.certNo}" maxlength="32" placeholder="请输入示例：339005197909054915"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：01:</td>
				<td><input type="text" name="feeTypeCode" id="feeTypeCode" value="${entity.feeTypeCode}" maxlength="32" placeholder="请输入示例：01"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="feeType" id="feeType" value="${entity.feeType}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：浙江萧山医院:</td>
				<td><input type="text" name="company" id="company" value="${entity.company}" maxlength="32" placeholder="请输入示例：浙江萧山医院"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：浙江萧山医院:</td>
				<td><input type="text" name="businessAddress" id="businessAddress" value="${entity.businessAddress}" maxlength="32" placeholder="请输入示例：浙江萧山医院"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="businessPostCode" id="businessPostCode" value="${entity.businessPostCode}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="businessPhone" id="businessPhone" value="${entity.businessPhone}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="homeAddressCode" id="homeAddressCode" value="${entity.homeAddressCode}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：浙江:</td>
				<td><input type="text" name="homeAddress" id="homeAddress" value="${entity.homeAddress}" maxlength="32" placeholder="请输入示例：浙江"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：:</td>
				<td><input type="text" name="homePostCode" id="homePostCode" value="${entity.homePostCode}" maxlength="32" placeholder="请输入示例："/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：18967168210:</td>
				<td><input type="text" name="mobilePhone" id="mobilePhone" value="${entity.mobilePhone}" maxlength="32" placeholder="请输入示例：18967168210"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：蒋利军:</td>
				<td><input type="text" name="contact" id="contact" value="${entity.contact}" maxlength="32" placeholder="请输入示例：蒋利军"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：1:</td>
				<td><input type="text" name="relationCode" id="relationCode" value="${entity.relationCode}" maxlength="32" placeholder="请输入示例：1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：配偶:</td>
				<td><input type="text" name="relation" id="relation" value="${entity.relation}" maxlength="32" placeholder="请输入示例：配偶"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：888210:</td>
				<td><input type="text" name="contactMethod" id="contactMethod" value="${entity.contactMethod}" maxlength="32" placeholder="请输入示例：888210"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：1:</td>
				<td><input type="text" name="operatorId" id="operatorId" value="${entity.operatorId}" maxlength="32" placeholder="请输入示例：1"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：倪震涛:</td>
				<td><input type="text" name="operator" id="operator" value="${entity.operator}" maxlength="32" placeholder="请输入示例：倪震涛"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>示例：20140912134302:</td>
				<td><input type="text" name="operatorTime" id="operatorTime" value="${entity.operatorTime}" maxlength="32" placeholder="请输入示例：20140912134302"/></td>
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