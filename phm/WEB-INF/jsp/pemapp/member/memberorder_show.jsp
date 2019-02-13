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
	</head>
<body>
	<form action="" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;">订单号:</td>
				<td><label>${order.number}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 用户姓名:</td>
				<td><label>
					<c:if test="${order.memberName == null || order.memberNamememberName ==''}">------</c:if>
					${order.memberName}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 医生姓名:</td>
				<td><label>
					<c:if test="${order.doctorName == null || order.doctorName ==''}">------</c:if>
					${order.doctorName}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 套餐名称:</td>
				<td><label>
					<c:if test="${order.packageName == null || order.packageName ==''}">------</c:if>
					${order.packageName}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 套餐构成:</td>
				<td><label>
					<c:if test="${order.sheetNameStr == null || order.sheetNameStr ==''}">------</c:if>
					${order.sheetNameStr}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 生成时间:</td>
				<td><label>
					<c:if test="${order.buildTime == null || order.buildTime ==''}">------</c:if>
					${order.buildTime}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 实际支付金额:</td>
				<td><label>
					<c:if test="${order.payAmount == null || order.payAmount ==''}">------</c:if>
					${order.payAmount}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 订单状态:</td>
				<td><label>
					<c:if test="${order.status == null || order.status ==''}">------</c:if>
					<c:forEach items="${statuslist}" var="status" varStatus="vs">
                    	<c:if test="${status.key == order.status }">${status.value}</c:if>
                    </c:forEach>
                </label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 支付账号:</td>
				<td><label>
					<c:if test="${order.payAccount == null || order.payAccount ==''}">------</c:if>
					${order.payAccount}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 支付交易号:</td>
				<td><label>
					<c:if test="${order.payTradeNo == null || order.payTradeNo ==''}">------</c:if>
					${order.payTradeNo}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 支付时间:</td>
				<td><label>
					<c:if test="${order.payTime == null || order.payTime ==''}">------</c:if>
					${order.payTime}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 开始测试时间:</td>
				<td><label>
					<c:if test="${order.checkBeginTime == null || order.checkBeginTime ==''}">------</c:if>
					${order.checkBeginTime}</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 完成时间:</td>
				<td><label>
					<c:if test="${order.checkFinishTime == null || order.checkFinishTime ==''}">------</c:if>
					${order.checkFinishTime}
				</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 审核时间:</td>
				<td><label>
					<c:if test="${order.auditTime == null || order.auditTime ==''}">------</c:if>
					${order.auditTime}
				</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 退款申请时间:</td>
				<td><label>
					<c:if test="${order.drawbackApplicationTime == null || order.drawbackApplicationTime ==''}">------</c:if>
					${order.drawbackApplicationTime}
				</label></td>
			</tr>
			<tr>
				<td style="width:100px;text-align: right;padding-top: 13px;"> 退款到账时间:</td>
				<td><label>
					<c:if test="${order.drawbackFinishTime == null || order.drawbackFinishTime ==''}">------</c:if>
					${order.drawbackFinishTime}
				</label></td>
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