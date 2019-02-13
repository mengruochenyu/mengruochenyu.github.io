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
		if($("#memberId").val()==""){
			popupTip('memberId', '请输入用户id');
			return false;
		}
		if($("#typeId").val()==""){
			popupTip('typeId', '请输入消息类型id');
			return false;
		}
		if($("#synopsis").val()==""){
			popupTip('synopsis', '请输入消息简介');
			return false;
		}
		if($("#content").val()==""){
			popupTip('content', '请输入消息内容');
			return false;
		}
		if($("#status").val()==""){
			popupTip('status', '请输入消息状态，0未读，1已读');
			return false;
		}
		if($("#orderId").val()==""){
			popupTip('orderId', '请输入与消息相关的订单id');
			return false;
		}
	
		var action = '${msg}';
		var url = 'membermessage/' + action;
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
	<form action="membermessage/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户id:</td>
				<td><input type="number" name="memberId" id="memberId" value="${entity.memberId}" maxlength="32" placeholder="请输入用户id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息类型id:</td>
				<td><input type="number" name="typeId" id="typeId" value="${entity.typeId}" maxlength="32" placeholder="请输入消息类型id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息简介:</td>
				<td><input type="text" name="synopsis" id="synopsis" value="${entity.synopsis}" maxlength="32" placeholder="请输入消息简介"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息内容:</td>
				<td><input type="text" name="content" id="content" value="${entity.content}" maxlength="32" placeholder="请输入消息内容"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息状态，0未读，1已读:</td>
				<td><input type="number" name="status" id="status" value="${entity.status}" maxlength="32" placeholder="请输入消息状态，0未读，1已读"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>与消息相关的订单id:</td>
				<td><input type="number" name="orderId" id="orderId" value="${entity.orderId}" maxlength="32" placeholder="请输入与消息相关的订单id"/></td>
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