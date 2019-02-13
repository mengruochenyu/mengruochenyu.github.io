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
	var fieldArray = ["log_id","user_id","user_name","user_ip","operation_time","page_name","operation_content","del_flag","create_user_id","create_time","update_user_id","update_time",""];
	
	//保存
	function save(target){
			if($("#log_id").val()==""){
				popupTip('log_id', '请输入日志表id');
				return false;
			}
			if($("#user_id").val()==""){
				popupTip('user_id', '请输入用户id');
				return false;
			}
			if($("#user_name").val()==""){
				popupTip('user_name', '请输入用户姓名');
				return false;
			}
			if($("#user_ip").val()==""){
				popupTip('user_ip', '请输入操作ip');
				return false;
			}
			if($("#operation_time").val()==""){
				popupTip('operation_time', '请输入操作时间');
				return false;
			}
			if($("#page_name").val()==""){
				popupTip('page_name', '请输入画面名');
				return false;
			}
			if($("#operation_content").val()==""){
				popupTip('operation_content', '请输入操作内容');
				return false;
			}
			if($("#del_flag").val()==""){
				popupTip('del_flag', '请输入删掉标识');
				return false;
			}
			if($("#create_user_id").val()==""){
				popupTip('create_user_id', '请输入创建者id');
				return false;
			}
			if($("#create_time").val()==""){
				popupTip('create_time', '请输入创建时间');
				return false;
			}
			if($("#update_user_id").val()==""){
				popupTip('update_user_id', '请输入修改者id');
				return false;
			}
			if($("#update_time").val()==""){
				popupTip('update_time', '请输入修改时间');
				return false;
			}
	
		var action = '${msg}';
		var url = 'log/rest/' + action;
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
	<form action="log/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="id" id="id" value="${pd.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>日志表id:</td>
				<td><input type="text" name="log_id" id="log_id" value="${pd.log_id}" maxlength="32" placeholder="请输入日志表id" title="日志表id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户id:</td>
				<td><input type="text" name="user_id" id="user_id" value="${pd.user_id}" maxlength="32" placeholder="请输入用户id" title="用户id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户姓名:</td>
				<td><input type="text" name="user_name" id="user_name" value="${pd.user_name}" maxlength="32" placeholder="请输入用户姓名" title="用户姓名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>操作ip:</td>
				<td><input type="text" name="user_ip" id="user_ip" value="${pd.user_ip}" maxlength="32" placeholder="请输入操作ip" title="操作ip"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>操作时间:</td>
				<td><input type="text" name="operation_time" id="operation_time" value="${pd.operation_time}" maxlength="32" placeholder="请输入操作时间" title="操作时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>画面名:</td>
				<td><input type="text" name="page_name" id="page_name" value="${pd.page_name}" maxlength="32" placeholder="请输入画面名" title="画面名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>操作内容:</td>
				<td><input type="text" name="operation_content" id="operation_content" value="${pd.operation_content}" maxlength="32" placeholder="请输入操作内容" title="操作内容"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>删掉标识:</td>
				<td><input type="text" name="del_flag" id="del_flag" value="${pd.del_flag}" maxlength="32" placeholder="请输入删掉标识" title="删掉标识"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>创建者id:</td>
				<td><input type="text" name="create_user_id" id="create_user_id" value="${pd.create_user_id}" maxlength="32" placeholder="请输入创建者id" title="创建者id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>创建时间:</td>
				<td><input type="text" name="create_time" id="create_time" value="${pd.create_time}" maxlength="32" placeholder="请输入创建时间" title="创建时间"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>修改者id:</td>
				<td><input type="text" name="update_user_id" id="update_user_id" value="${pd.update_user_id}" maxlength="32" placeholder="请输入修改者id" title="修改者id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>修改时间:</td>
				<td><input type="text" name="update_time" id="update_time" value="${pd.update_time}" maxlength="32" placeholder="请输入修改时间" title="修改时间"/></td>
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