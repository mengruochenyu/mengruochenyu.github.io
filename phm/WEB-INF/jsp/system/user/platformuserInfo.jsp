<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript">
$(top.hangge());
//保存
function save(target){
	if($("#accountname").val()=="" || $("#accountname").val()=="此用户名已存在!"){
		$("#accountname").tips({
			side:3,
            msg:'输入用户名',
            bg:'#AE81FF',
            time:2
        });
		
		$("#accountname").focus();
		$("#accountname").val('');
		$("#accountname").css("background-color","white");
		return false;
	}else{
		$("#accountname").val(jQuery.trim($('#accountname').val()));
	}
	
	if($("#name").val()==""){
		
		$("#name").tips({
			side:3,
            msg:'输入姓名',
            bg:'#AE81FF',
            time:3
        });
		$("#name").focus();
		return false;
	}
	
	var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
	if($("#mobilePhone").val()==""){
		
		$("#mobilePhone").tips({
			side:3,
            msg:'输入手机号',
            bg:'#AE81FF',
            time:3
        });
		$("#mobilePhone").focus();
		return false;
	}else if($("#mobilePhone").val().length != 11 && !myreg.test($("#mobilePhone").val())){
		$("#mobilePhone").tips({
			side:3,
            msg:'手机号格式不正确',
            bg:'#AE81FF',
            time:3
        });
		$("#mobilePhone").focus();
		return false;
	}
	
	var url = '<%=basePath%>userInfo/edit';
	ajaxSave(target, url, "edit");
	return false;
	
}

//判断用户名是否存在
function hasU(target){
	var accountname = $.trim($("#accountname").val());
	$.ajax({
		type: "POST",
		url: '<%=basePath%>user/hasU.do',
    	data: {accountname:accountname,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if("success" == data.result){
				var action = '${msg }';
				var url = 'user/rest/' + action;
				ajaxSave(target, url, action);
			 }else{
				$("#accountname").css("background-color","#D16E6C");
				setTimeout("$('#accountname').val('此用户名已存在!')",500);
			 }
		}
	});
}

//判断邮箱是否存在
function hasE(accountname){
	var email = $.trim($("#email").val());
	$.ajax({
		type: "POST",
		url: '<%=basePath%>user/hasE.do',
    	data: {email:email,accountname:accountname,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if("success" != data.result){
				 $("#email").tips({
						side:3,
			            msg:'邮箱已存在',
			            bg:'#AE81FF',
			            time:3
			        });
				setTimeout("$('#email').val('')",2000);
			 }
		}
	});
}

</script>
</head>
<body>

<form action="userInfo/edit" name="userForm" id="userForm1" method="post">
		<div id="zhongxin" style="padding-top:20px;">
		<table class="table noline">
			<tr>
				<td><i>用户名:</i><input type="text" name="accountname" id="accountname" value="${pd.accountname }" readonly="readonly"/></td>
				<td><i>姓 名:</i><input type="text" name="name" id="name"  value="${pd.name }"  maxlength="32" placeholder="请输入姓名" title="姓名"/></td>				
			</tr>
			<tr>
				<td><i>手机号:</i><input type="text" name="mobilePhone" id="mobilePhone"  value="${pd.mobilePhone }"  maxlength="11" minlength="11" placeholder="请输入手机号" title="手机号"/></td>				
				<td><i>Q Q :</i><input type="text" name="qqId" id="qq" onkeyup="value=value.replace(/[^\d]/g,'')" value="${pd.qqId}" maxlength="11" placeholder="请输入qq号(可不填)" title="qq"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="2">
					<a id="saveBtn" class="btn btn-primary" style="text-align: center;width:100px;" onclick="save(this);">保  存</a>
				</td>
			</tr>
		</table>
		</div>
		
	</form>

</body>
</html>