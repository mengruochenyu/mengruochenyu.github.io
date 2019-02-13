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
			popupTip('name', '请输入批次名称');
			return false;
		}
		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入医院id');
			return false;
		}
		if($("#hospitalName").val()==""){
			popupTip('hospitalName', '请输入医院名称');
			return false;
		}
		if($("#cardType").val()==""){
			popupTip('cardType', '请输入卡片类型 1实体卡 2干预卡');
			return false;
		}
		if($("#cardCount").val()==""){
			popupTip('cardCount', '请输入卡片数量');
			return false;
		}
		if($("#validTimeStart").val()==""){
			popupTip('validTimeStart', '请输入有效期开始时间');
			return false;
		}
		if($("#validTimeEnd").val()==""){
			popupTip('validTimeEnd', '请输入有效期结束时间');
			return false;
		}
	
		var action = '${msg}';
		var url = 'cardbatch/' + action;
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
	<form action="cardbatch/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>批次名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入批次名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院id:</td>
				<td><input type="number" name="hospitalId" id="hospitalId" value="${entity.hospitalId}" maxlength="32" placeholder="请输入医院id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院名称:</td>
				<td><input type="text" name="hospitalName" id="hospitalName" value="${entity.hospitalName}" maxlength="32" placeholder="请输入医院名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>卡片类型 1实体卡 2干预卡:</td>
				<td><input type="number" name="cardType" id="cardType" value="${entity.cardType}" maxlength="32" placeholder="请输入卡片类型 1实体卡 2干预卡"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>卡片数量:</td>
				<td><input type="number" name="cardCount" id="cardCount" value="${entity.cardCount}" maxlength="32" placeholder="请输入卡片数量"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>有效期开始时间:</td>
				<td><input class="span10 date-picker" name="validTimeStart" id="validTimeStart" value="${entity.validTimeStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="有效期开始时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>有效期结束时间:</td>
				<td><input class="span10 date-picker" name="validTimeEnd" id="validTimeEnd" value="${entity.validTimeEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="有效期结束时间"/></td>
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