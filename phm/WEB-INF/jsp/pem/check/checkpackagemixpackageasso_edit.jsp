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
		if($("#packageMixId").val()==""){
			popupTip('packageMixId', '请输入混合套餐id');
			return false;
		}
		if($("#packageId").val()==""){
			popupTip('packageId', '请输入套餐id');
			return false;
		}
		if($("#sortIndex").val()==""){
			popupTip('sortIndex', '请输入序号');
			return false;
		}
	
		var action = '${msg}';
		var url = 'checkpackagemixpackageasso/' + action;
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
	<form action="checkpackagemixpackageasso/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>混合套餐id:</td>
				<td><input type="number" name="packageMixId" id="packageMixId" value="${entity.packageMixId}" maxlength="32" placeholder="请输入混合套餐id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐id:</td>
				<td><input type="number" name="packageId" id="packageId" value="${entity.packageId}" maxlength="32" placeholder="请输入套餐id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>序号:</td>
				<td><input type="number" name="sortIndex" id="sortIndex" value="${entity.sortIndex}" maxlength="32" placeholder="请输入序号"/></td>
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