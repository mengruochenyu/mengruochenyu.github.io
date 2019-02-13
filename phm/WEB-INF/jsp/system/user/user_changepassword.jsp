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
	$(top.hangge());
	
	
	//保存
	function save(target){	
		if($("#oldPassword").val()==""){
			$("#oldPassword").tips({
				side:3,
	            msg:'输入旧密码',
	            bg:'#AE81FF',
	        });
			$("#password").focus();
			return false;
		}
		if($("#password").val()==""){
			$("#password").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#password").focus();
			return false;
		}
		if($("#password").val()!=$("#chkpwd").val()){
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		
		var oldPassword = $("#oldPassword").val();
		var password =$("#password").val();
		
		var postObject = {};
		postObject.data = {oldPassword:oldPassword,newPassword:password};
		postObject.url = '<%=basePath%>userInfo/changePassword';
		postObject.success=function(){
			bootbox.alert("修改成功");
		};
		postObject.fail=function(result){
			bootbox.alert(result.msg);
		}
		ajaxPost(postObject);
	}
	
</script>
	</head>
<body>
	<form action="userInfo/${msg}" name="Form" id="Form" method="post">
		<div id="zhongxin" style="padding-top:20px;">
		<table class="table noline">
			<tr>
				<td><input type="password" name="oldPassword" id="oldPassword" maxlength="64" placeholder="输入旧密码" title="旧密码"/></td>
			</tr>
			<tr>
				<td><input type="password" name="password" id="password" maxlength="64" placeholder="输入密码(最少六位)" title="密码"/></td>
			</tr>
			<tr>
				<td><input type="password" name="chkpwd" id="chkpwd" maxlength="64" placeholder="确认密码" title="确认密码" /></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<a id="saveBtn" class="btn btn-primary" style="width:100px;" onclick="save(this);">保  存</a>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
	
</body>
</html>