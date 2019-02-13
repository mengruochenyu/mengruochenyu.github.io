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
	$(function(){
		//识别行为，当为新增的时候隐藏价格设置框，当为编辑的时候显示价格设置框
		var movement = '${msg}';
		console.log(movement);
		if (movement == "edit") { // 默认是隐藏的，只有编辑才显示
			$("#setPrice").attr("name","price");
			$("#setTr").removeAttr("style");
		}
		
	});
	//保存
	function save(target){
		if($("#name").val()==""){
			popupTip('name', '请输入名称');
			return false;
		}
		if($("#description").val()==""){
			popupTip('description', '请输入描述');
			return false;
		}
		if($("#typeId").val()==""){
			popupTip('typeId', '请选择套餐类型');
			return false;
		}
	
		var action = '${msg}';
		var url = 'appcheckpackage/' + action;
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
	<form action="appcheckpackage/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
        <input type="hidden" name="officeId" id="officeId" value="${hospitalOffice.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐类型:</td>
				<td style="padding-left: 12px;">
                    <span class="input-icon">
                        <select id="typeId" name="typeId">
                        	<c:choose>
								<c:when test="${not empty packageTypeList}">
								    <option value="">选择套餐类型</option>
									<c:forEach items="${packageTypeList}" var="packageType" varStatus="vs">
			                            <option value="${packageType.typeId}" <c:if test="${entity.typeId==packageType.typeId}">selected</c:if>>${packageType.typeName}</option>
			                        </c:forEach>
								</c:when>
	                            <c:otherwise>
									 <option value="">路径出错！</option>
								</c:otherwise>
	                        </c:choose>
                        </select>
                    </span>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>描述:</td>
				<td><input type="text" name="description" id="description" value="${entity.description}" placeholder="请输入描述"/></td>
			</tr>
			<tr id="setTr" style="display: none">
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>价格:</td>
				<td><input type="text" id="setPrice" value="${entity.price}" placeholder="请输入价格"/></td>
				<td><input type="hidden" name="root" id="root" value="2"/></td>
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