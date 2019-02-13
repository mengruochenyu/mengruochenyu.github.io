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
		if($("#dicName").val()==""){
			popupTip('dicName', '请输入代码名称');
			return false;
		}
		if($("#dicType").val()==""){
			popupTip('dicType', '请输入代码类别');
			return false;
		}
		if($("#viewSortby").val()==""){
			popupTip('viewSortby', '请输入显示排序');
			return false;
		}
	
		var action = '${msg}';
		var url = 'dictionary/' + action;
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
	<form action="dictionary/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="dictionaryId" id="dictionaryId" value="${entity.dictionaryId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>字段内容:</td>
				<td><input type="text" name="dicName" id="dicName" value="${entity.dicName}" maxlength="32" placeholder="请输入代码名称" title="代码名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>字段类型:</td>
				<td>
					<select id="dicType" name="dicType" style="vertical-align:top;">
						<c:forEach items="${dicTypeList}" var="type" varStatus="vs">
							<option value="${type.code}" <c:if test="${entity.dicType == type.code}">selected</c:if>>${type.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>显示排序:</td>
				<td><input type="number" name="viewSortby" id="viewSortby" value="${entity.viewSortby}" maxlength="32" placeholder="请输入显示排序" title="显示排序"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">描述:</td>
				<td><input type="text" name="desc" id="desc" value="${entity.desc}" maxlength="32" placeholder="请输入描述" title="描述"/></td>
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