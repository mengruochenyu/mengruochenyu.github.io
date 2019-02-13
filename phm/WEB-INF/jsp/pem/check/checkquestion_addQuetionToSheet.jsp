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
		return true
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
	<form action="checkquestion/${msg}.do" name="editForm" id="editForm" method="post" onsubmit="return save();">
		<input type="hidden" name="quesIdsStr" id="quesIdsStr" value="${quesIdsStr}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检表</td>
				<td>
					<select name="id" id="id">
						<c:choose>
							<c:when test="${not empty sheetList}">
								<c:forEach items="${sheetList}" var="sheet">
									<option value="${sheet.id}">${sheet.name}</option>
								 </c:forEach>								
							</c:when>	
						</c:choose>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<button  class=" btn btn-small btn-success" type="submit" >保存</button>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>