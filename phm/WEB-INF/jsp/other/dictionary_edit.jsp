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
	var fieldArray = ["dic_id","dic_name","dic_type","sort","desc","del_flag","create_user_id","create_time","update_user_id","update_time",""];
	
	//保存
	function save(target){
			if($("#dic_id").val()==""){
				popupTip('dic_id', '请输入代码id');
				return false;
			}
			if($("#dic_name").val()==""){
				popupTip('dic_name', '请输入代码名称');
				return false;
			}
			if($("#dic_type").val()==""){
				popupTip('dic_type', '请输入代码类别');
				return false;
			}
			if($("#sort").val()==""){
				popupTip('sort', '请输入显示排序');
				return false;
			}
			if($("#desc").val()==""){
				popupTip('desc', '请输入描述');
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
		var url = 'dictionary/rest/' + action;
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
	<form action="dictionary/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="id" id="id" value="${pd.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>代码id:</td>
				<td><input type="text" name="dic_id" id="dic_id" value="${pd.dic_id}" maxlength="32" placeholder="请输入代码id" title="代码id"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>代码名称:</td>
				<td><input type="text" name="dic_name" id="dic_name" value="${pd.dic_name}" maxlength="32" placeholder="请输入代码名称" title="代码名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>代码类别:</td>
				<td><input type="text" name="dic_type" id="dic_type" value="${pd.dic_type}" maxlength="32" placeholder="请输入代码类别" title="代码类别"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>显示排序:</td>
				<td><input type="text" name="sort" id="sort" value="${pd.sort}" maxlength="32" placeholder="请输入显示排序" title="显示排序"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>描述:</td>
				<td><input type="text" name="desc" id="desc" value="${pd.desc}" maxlength="32" placeholder="请输入描述" title="描述"/></td>
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