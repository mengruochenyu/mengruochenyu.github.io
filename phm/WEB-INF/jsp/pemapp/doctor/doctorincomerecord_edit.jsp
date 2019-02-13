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
		if($("#doctorId").val()==""){
			popupTip('doctorId', '请输入医生id');
			return false;
		}
		if($("#orderId").val()==""){
			popupTip('orderId', '请输入订单id');
			return false;
		}
		if($("#amount").val()==""){
			popupTip('amount', '请输入金额');
			return false;
		}
		if($("#incomeTime").val()==""){
			popupTip('incomeTime', '请输入收益时间');
			return false;
		}
		if($("#memberId").val()==""){
			popupTip('memberId', '请输入检测用户');
			return false;
		}
	
		var action = '${msg}';
		var url = 'doctorincomerecord/' + action;
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
	<form action="doctorincomerecord/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生:</td>
				<td><input type="text" id="doctorName" value="${entity.doctorName}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>订单:</td>
				<td><input type="text" id="orderNumber" value="${entity.orderNumber}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>金额:</td>
				<td><input type="text" name="amount" id="amount" value="${entity.amount}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>收益时间:</td>
				<td><input type="text" name="incomeTime" id="incomeTime" value="${entity.incomeTime}"readonly="readonly"/></td>
			</tr>
			<%-- <tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测用户:</td>
				<td><input type="number" name="memberId" id="memberId" value="${entity.memberId}" maxlength="32" placeholder="请输入检测用户"/></td>
			</tr> --%>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="location.reload();">关闭</a>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>