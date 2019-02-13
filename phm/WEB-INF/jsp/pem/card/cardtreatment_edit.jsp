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
		if($("#num").val()==""){
			popupTip('num', '请输入编号');
			return false;
		}
		if($("#batchName").val()==""){
			popupTip('batchName', '请输入批次名称');
			return false;
		}
		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入医院ID');
			return false;
		}
		if($("#status").val()==""){
			popupTip('status', '请输入状态');
			return false;
		}
		if($("#activeTime").val()==""){
			popupTip('activeTime', '请输入激活时间');
			return false;
		}
		if($("#checkTime").val()==""){
			popupTip('checkTime', '请输入检测时间');
			return false;
		}
		if($("#validTimeStart").val()==""){
			popupTip('validTimeStart', '请输入有效期开始时间');
			return false;
		}
		if($("#validTimeEnd").val()==""){
			popupTip('validTimeEnd', '请输入有效期开始时间');
			return false;
		}
	
		var action = '${msg}';
		var url = 'cardtreatment/' + action;
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
	<form action="cardtreatment/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>编号:</td>
				<td><input type="text" name="num" id="num" value="${entity.num}" maxlength="32" placeholder="请输入编号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>批次名称:</td>
				<td><input type="text" name="batchName" id="batchName" value="${entity.batchName}" maxlength="32" placeholder="请输入批次名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院ID:</td>
				<td><input type="number" name="hospitalId" id="hospitalId" value="${entity.hospitalId}" maxlength="32" placeholder="请输入医院ID"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>状态:</td>
				<td><input type="number" name="status" id="status" value="${entity.status}" maxlength="32" placeholder="请输入状态"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>激活时间:</td>
				<td><input type="text" name="activeTime" id="activeTime" value="${entity.activeTime}" maxlength="32" placeholder="请输入激活时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测时间:</td>
				<td><input type="text" name="checkTime" id="checkTime" value="${entity.checkTime}" maxlength="32" placeholder="请输入检测时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>有效期开始时间:</td>
				<td><input type="text" name="validTimeStart" id="validTimeStart" value="${entity.validTimeStart}" maxlength="32" placeholder="请输入有效期开始时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>有效期开始时间:</td>
				<td><input type="text" name="validTimeEnd" id="validTimeEnd" value="${entity.validTimeEnd}" maxlength="32" placeholder="请输入有效期开始时间"/></td>
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