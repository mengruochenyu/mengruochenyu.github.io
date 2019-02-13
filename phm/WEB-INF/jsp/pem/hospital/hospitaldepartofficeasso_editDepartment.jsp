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
	function save(){
/* 		if($("#departmentId").val()==""){
			popupTip('departmentId', '请输入部门ID');
			return false;
		}
		if($("#officeId").val()==""){
			popupTip('officeId', '请输入科室ID');
			return false;
		} */
		//var object={}
		var officeId = $("#officeId").val();
		var departIdArr = new Array();
		$('input[name="departmentId"]:checked').each(function(){
			departIdArr.push($(this).val());
		}); 
		if(departIdArr.length == 0){
			return false;
		}
		//alert();
		var departIdListStr = departIdArr.join(",");		
		var ajaxObject={
			url:"hospitaldepartofficeasso/saveDepart4Office",
			data:{
				officeId:officeId,
				departIdListStr:departIdListStr
				},
			success:function (data) { 						
				location.reload();
				 }, 
			fail:function(){console.log("fail")},
			error:function(){console.log("error")},
		}
		ajaxPost(ajaxObject);	
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
	<form action="hospitaldepartofficeasso/saveDepart4Office.do" name="editForm" id="editForm" method="post" onsubmit="return save();">
		<input type="hidden" name="officeId" id="officeId" value="${officeId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>选择部门</td>
				<td>
					<c:choose>
						<c:when test="${not empty departmentList}">
							<c:forEach items="${departmentList}" var="var">
								<label><input type="checkbox" name="departmentId" <c:if test="${var.selectFlag == 1}">checked="checked" </c:if> value="${var.id}" >${var.name}${var.selectFlag}</label>
							 </c:forEach>								
						</c:when>	
					</c:choose>
				</td>
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<!-- <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a> -->
					<button  class="submitBtn" type="submit" >保存</button>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>