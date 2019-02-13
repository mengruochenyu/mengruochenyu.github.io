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
	function saveOfficesToDepart(target){
	    debugger;
	    var a=$("#editForm").serialize();
		var ajaxObject={
			url:"hospitaldepartofficeasso/saveOfficesToDepart.do?"+$("#editForm").serialize(),
			data:{},
            success:function (data) {
                if(data.code==200){
                    showSuccessMessage();
                    window.location.reload();
                    hideDialog(target);
                }else{
                    bootbox.alert(data.msg);
                }
            }
        };
        ajaxPost(ajaxObject);
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
        <style>
            td#officesTD label {
                padding: 3px 10px;
                width: 175px;
            }
        </style>
	</head>
<body>
	<form action="hospitaldepartofficeasso/saveOfficesToDepart.do" name="editForm" id="editForm" method="post" onsubmit="return save();">
		<input type="hidden" name="departmentId" id="departmentId" value="${department.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>选择科室</td>
				<td id="officesTD">
					<c:choose>
						<c:when test="${not empty officeList}">
							<c:forEach items="${officeList}" var="var">
								<label><input type="checkbox" name="officeIds" <c:if test="${var.selectFlag == 1}">checked="checked" </c:if> value="${var.id}" >${var.name}</label>
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
                    <a class="btn btn-small btn-success" onclick="goAdd(this);">新增科室</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="btn btn-small btn-success" onclick="saveOfficesToDepart(this);">一键保存</a>
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
<script>
    function goAdd(){
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>hospitaloffice/goAdd.do?departmentId=${department.id}'),
            title: '新增科室'
        });
    }
</script>
</html>