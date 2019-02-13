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
	<style>
		#showInfo {
			width: 400px;
			min-height: 150px;
			border: 1px dashed gray;
			margin: 5px auto 0px;
			padding: 5px;
		}
	</style>
	<script type="text/javascript">
		function edit(id){
			BootstrapDialog.show({cssClass:'three-row-dialog',
	            message: $('<div></div>').load('<%=basePath%>doctor/goEdit/'+id),
	            title: '编辑'
	          });
		}
	</script>
<body>
	<form action="" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${doctor.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生姓名:</td>
				<td><label>${doctor.name}</label></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生电话:</td>
				<td><label>${doctor.mobile}</label></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生简历:</td></tr>
			<tr><td colspan="2"><div id = "showInfo">${doctor.introduce}</div></td></tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-primary" style="width:100px" onclick="edit('${doctor.id}');">去编辑简历</a>
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>