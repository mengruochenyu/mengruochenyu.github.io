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
	var selectRoleId = "${entity.roleId}";
	var selectDepcdId = "${entity.depcd}";

	$.post('<%=basePath%>platformuser/roleList',function(data){
	    if(data!=null){
	        var html="<option value=''>请选择角色</option>";
	        for(var i=0;i<data.length;i++){
	        	var item = data[i];
		        var option = "<option value='#(optionValue)' #(optionSelected)>#(optionName)</option>";
		        var selected = "";
		        if(item.roleItemId == selectRoleId){
		        	selected = "selected";
		        }
				option = option.replace("#(optionValue)", item.roleItemId).replace("#(optionName)"
						, data[i].roleName).replace("#(optionSelected)", selected);       	
	             html += option;
	        }
	        $("#role_selecter").html('').append(html);
	    }
	});
	
	
	//保存
	function save(target){
		if($("#accountname").val()==""){
			popupTip('accountname', '请输入用户名');
			return false;
		}
		if('${msg}' == "save" && $("#password").val()==""){
			popupTip('password', '请输入用户密码');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入姓名');
			return false;
		}
		if($("#mobilePhone").val()==""){
			popupTip('mobilePhone', '请输入手机');
			return false;
		}
		if(!validateMobilePhone($("#mobilePhone").val())) {
			popupTip('mobilePhone', '手机号格式有误，请重新输入');
			return false;
		}
		
		if(!$("#qq").val()=="" && !validateQQ($("#qq").val())){
			popupTip('qq', 'QQ格式有误，请重新输入');
			return false;
		}
		
		if($("#sex_selecter").val()==""){
			popupTip('sex_selecter', '请选择性别');
			return false;
		}
		
		
		if($("#role_selecter").val()==""){
			popupTip('role_selecter', '请选择角色');
			return false;
		}
	
		var action = '${msg}';
		var url = 'platformuser/' + action;
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
	<form action="platformuser/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="platformuserId" id="platformuserId" value="${entity.platformuserId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>角色:</td>
				<td><select data-section-name="overview" value="" class="select" name="roleId" id="role_selecter" ></select></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户名:</td>
				<td><input type="text" name="accountname" id="accountname" value="${entity.accountname}" maxlength="32" placeholder="请输入成员用户名" title="成员用户名"/></td>
			</tr>
			<c:if test="${msg == 'save'}">
				<tr>
					<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户密码:</td>
					<td><input type="password" name="password" id="password" value="${entity.password}" maxlength="32" placeholder="请输入成员用户密码" title="成员用户密码"/></td>
				</tr>
			</c:if>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>姓名:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入姓名" title="姓名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>性别:</td>
				<td><select data-section-name="overview" value="sex" class="select" name="sex" id="sex_selecter" >
						<option value="">请选择性别</option>
						<option value="0" <c:if test="${entity.sex == 0}">selected</c:if>>男</option>
						<option value="1" <c:if test="${entity.sex == 1}">selected</c:if>>女</option>
				</select></td>
			</tr>
			
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>手机:</td>
				<td><input type="text" name="mobilePhone"  onkeyup="value=value.replace(/[^\d]/g,'')"  id="mobilePhone" value="${entity.mobilePhone}" maxlength="32" placeholder="请输入手机" title="手机"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">Q Q:</td>
				<td><input type="text" name="qqId" id="qq" onkeyup="value=value.replace(/[^\d]/g,'')" value="${entity.qqId}" maxlength="11" placeholder="请输入QQ号" title="QQ"/></td>
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