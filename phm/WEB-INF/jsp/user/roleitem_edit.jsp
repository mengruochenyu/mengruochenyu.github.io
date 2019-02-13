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

$().ready(function() {
	// 在键盘按下并释放及提交后验证提交表单
	  $("#editForm").validate({
		    rules: {
		    	roleName:{
			        required: true,
			        maxlength: 10
			      }
		    },
		    messages: {
		    	roleName: {
		    		required: "请输入角色名称",
			        maxlength: "角色名称必须大于10"
		    	}
		    }
		});
	});
	
	//保存
	function save(target){
		//$("#editForm").valid();
		
		if($("#roleName").val()==""){
			popupTip('roleName', '请输入角色名');
			return false;
		}
		if($("#roleLevel").val()==""){
			popupTip('roleLevel', '请输入角色级别');
			return false;
		}
		if($("#filQx").val()==""){
			popupTip('filQx', '请输入数据可见性数据过滤权限');
			return false;
		}
		if($("#isPub").val()==""){
			popupTip('isPub', '请输入是否公开');
			return false;
		}
		if($("#regFlg").val()==""){
			popupTip('regFlg', '请输入注册选项');
			return false;
		}
		
		if($("#status").val()==""){
			popupTip('status', '请输入状态');
			return false;
		}
	
		var action = '${msg}';
		var url = 'roleitem/' + action;
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
		$("#field").focus();
	}
	
</script>
	</head>
<body>
	<form action="roleitem/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="roleItemId" id="roleItemId" value="${entity.roleItemId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>角色名:</td>
				<td><input type="text" name="roleName" id="roleName" value="${entity.roleName}" maxlength="32" placeholder="请输入角色名" title="角色名"/></td>
			</tr>
			<tr>
				<td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>角色级别:</td>
				<td>
					<select name="roleLevel" id="roleLevel">
						<option value="1" <c:if test="${entity.roleLevel == 1}">selected</c:if>>用户</option>
						<option value="2" <c:if test="${entity.roleLevel == 2}">selected</c:if>>平台</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>是否公开:</td>
				<td>
					<select name="isPub" id="isPub">
						<option value="1" <c:if test="${entity.isPub == 1}">selected</c:if>>是</option>
						<option value="0" <c:if test="${entity.isPub == 0}">selected</c:if>>否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>注册选项:</td>
				<td>
					<select name="regFlg" id="regFlg">
						<option value="1" <c:if test="${entity.regFlg == 1}">selected</c:if>>注册选项</option>
						<option value="0" <c:if test="${entity.regFlg == 0}">selected</c:if>>非注册选项</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:160px;text-align: right;padding-top: 13px;">角色描述:</td>
				<td><input type="text" name="desc" id="desc" value="${entity.desc}" maxlength="32" placeholder="请输入角色描述" title="角色描述"/></td>
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