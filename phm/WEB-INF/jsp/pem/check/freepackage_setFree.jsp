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
		if($("#freePackageId").val()==""){
			popupTip('freePackageId', '请选择免费套餐');
			return false;
		}
		if($("#reservePackageId").val()==""){
			popupTip('reservePackageId', '请选择备用套餐');
			return false;
		}
	
		var action = 'setFreePackage';
		var url = 'freepackage/' + action;
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
	<form action="freepackage/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${freePackage.id}"/>
		<input type="hidden" name="officeId" id="officeId" value="${office.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>免费套餐:</td>
				<td>
                    <select id="freePackageId" name="freePackageId">
                        <c:if test="${not empty packageList}">
                            <c:forEach items="${packageList}" var="var">
                                <option value="${var.id}" <c:if test="${var.id==freePackage.freePackageId}">selected</c:if>>${var.name}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>备用套餐:</td>
				<td>
                    <select id="reservePackageId" name="reservePackageId">
                        <c:if test="${not empty packageList}">
                            <c:forEach items="${packageList}" var="var">
                                <option value="${var.id}" <c:if test="${var.id==freePackage.reservePackageId}">selected</c:if>>${var.name}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </td>
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