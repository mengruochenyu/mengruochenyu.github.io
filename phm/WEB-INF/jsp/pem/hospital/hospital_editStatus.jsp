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
/* 		var action = '${msg}';
		var url = 'hospital/' + action;
		ajaxSave(target, url, action); */
		return true;
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
	
	$(".newspic").click(function() {
		$(this).next('input').click();
	});	
	function showPic(data) {
		if (data.files && data.files[0]) {
			var reader = new FileReader();
 			reader.onload = function(evt) {
 				data.parentNode.childNodes[1].childNodes[1].src = evt.target.result; 
			}
			reader.readAsDataURL(data.files[0]);
		}
	}
</script>
	</head>
<body>
	<form action="hospital/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医院logo:</td>
				<td>
					<a href="javascript:void(0)" class="newspic">
						<c:if test="${entity.logoUrl != null && entity.logoUrl != ''}"><img style="width:200px;height:100px;" src="<%=basePath%>${entity.logoUrl}"/></c:if>
						<c:if test="${entity.logoUrl == null || entity.logoUrl == ''}"><img style="width:200px;height:100px;"  src="<%=basePath%>static/img/selectimg.png"/></c:if>
					</a>
					<input type="file" id="logoUrl" name="logoUrl" onchange="showPic(this)"  style="display: none"/>
				</td>									
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账号:</td>
				<td><input type="text" name="accountName" id="accountName"  <c:if test="${msg == 'edit'}">readonly='readonly'</c:if> value="${entity.accountName}" maxlength="32" placeholder="请输入账号"/></td>
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
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>合同号:</td>
				<td><input type="text" name="contractNum" id="contractNum" value="${entity.contractNum}" maxlength="32" placeholder="请输入合同号"/></td>
			</tr>
<%-- 			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>状态:</td>
				<td><input type="number" name="status" id="status" value="${entity.status}" maxlength="32" placeholder="请输入状态"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测报告审核设置:</td>
				<td>
					<label><input type="radio" name="reportAudit" value="1"  <c:if test="${msg == 'save'}">checked="checked"</c:if> <c:if test="${entity.reportAudit == 1}">checked="checked"</c:if>>审核</label>
					<label><input type="radio" name="reportAudit" value="0"  <c:if test="${entity.reportAudit == 0}">checked="checked"</c:if>>不审核</label>
				<%-- <input type="number" name="reportAudit" id="reportAudit" value="${entity.reportAudit}" maxlength="32" placeholder="请输入检测报告审核设置"/> --%>
				</td>
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
						<button  class="submitBtn" type="submit" >保存</button>
					<!-- <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a> -->
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>