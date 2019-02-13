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
			popupTip('name', '请输入名称');
			return false;
		}
		if($("#dockingName").val()==""){
			popupTip('dockingName', '请输入对接人');
			return false;
		}
		if($("#dockingPhone").val()==""){
			popupTip('dockingPhone', '请输入对接人电话');
			return false;
		}
		if($("#addressProv").val()==""){
			popupTip('addressProv', '请输入地址省');
			return false;
		}
		if($("#addressCity").val()==""){
			popupTip('addressCity', '请输入地址市');
			return false;
		}
		if($("#addressCounty").val()==""){
			popupTip('addressCounty', '请输入地址区县');
			return false;
		}
		if($("#addressDetail").val()==""){
			popupTip('addressDetail', '请输入地址详情');
			return false;
		}
		if($("#industry").val()==""){
			popupTip('industry', '请输入行业');
			return false;
		}
		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入医院ID');
			return false;
		}
		if($("#hospitalOfficeId").val()==""){
			popupTip('hospitalOfficeId', '请输入科室ID');
			return false;
		}
		if($("#hospitalOfficeName").val()==""){
			popupTip('hospitalOfficeName', '请输入科室名称');
			return false;
		}
		if($("#checkCardType").val()==""){
			popupTip('checkCardType', '请输入检测卡类型');
			return false;
		}
	
		var action = '${msg}';
		var url = 'patientgroup/' + action;
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
	<form action="patientgroup/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人:</td>
				<td><input type="text" name="dockingName" id="dockingName" value="${entity.dockingName}" maxlength="32" placeholder="请输入对接人"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人电话:</td>
				<td><input type="text" name="dockingPhone" id="dockingPhone" value="${entity.dockingPhone}" maxlength="32" placeholder="请输入对接人电话"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>地址省:</td>
				<td><input type="text" name="addressProv" id="addressProv" value="${entity.addressProv}" maxlength="32" placeholder="请输入地址省"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>地址市:</td>
				<td><input type="text" name="addressCity" id="addressCity" value="${entity.addressCity}" maxlength="32" placeholder="请输入地址市"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>地址区县:</td>
				<td><input type="text" name="addressCounty" id="addressCounty" value="${entity.addressCounty}" maxlength="32" placeholder="请输入地址区县"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>地址详情:</td>
				<td><input type="text" name="addressDetail" id="addressDetail" value="${entity.addressDetail}" maxlength="32" placeholder="请输入地址详情"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>行业:</td>
				<td><input type="text" name="industry" id="industry" value="${entity.industry}" maxlength="32" placeholder="请输入行业"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院ID:</td>
				<td><input type="number" name="hospitalId" id="hospitalId" value="${entity.hospitalId}" maxlength="32" placeholder="请输入医院ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>科室ID:</td>
				<td><input type="number" name="hospitalOfficeId" id="hospitalOfficeId" value="${entity.hospitalOfficeId}" maxlength="32" placeholder="请输入科室ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>科室名称:</td>
				<td><input type="text" name="hospitalOfficeName" id="hospitalOfficeName" value="${entity.hospitalOfficeName}" maxlength="32" placeholder="请输入科室名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测卡类型:</td>
				<td><input type="number" name="checkCardType" id="checkCardType" value="${entity.checkCardType}" maxlength="32" placeholder="请输入检测卡类型"/></td>
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