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
		if($("#hospitalId").val()==""){
			popupTip('hospitalId', '请输入运营商');
			return false;
		}
		if($("#name").val()==""){
			popupTip('name', '请输入医生姓名');
			return false;
		}
		if($("#accountName").val()==""){
			popupTip('accountName', '请输入账号');
			return false;
		}
		<c:if test="${msg=='save'}">
            if($("#signImageUrl").val()==""){
                popupTip('signImageUrl', '请输入医生签名图片');
                return false;
            }
            accountIsExist();
            var flag = $('#accountIsExist').val();
    		if(flag != "false"){
    			popupTip('accountName', '账号已存在');
    			return false;
    		}
        </c:if>

/* 		var action = '${msg}';
		var url = 'hospitalauditdoctor/' + action;
		ajaxSave(target, url, action); */
		return true;
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
	function accountIsExist(){
	    var url="hospital/accountIsExist/" + $('#accountName').val();
	    $.ajax({
	        type: "POST",
	        url: url,
	        dataType: 'json',
	        async:false,
	        contentType: "application/json;charset=UTF-8",
	        success: function(result){
	        	if(result.code == 200){
	        		$('#accountIsExist').val("false");
	        	}
	        	if(result.code == 625){
	        		$('#accountIsExist').val("true");
	        	}
	        }
	    })   
	}
	
	$(".newspic").click(function() {
		$(this).next('input').click();
	});	
	function showPic(data) {
		if (data.files && data.files[0]) {
			var reader = new FileReader();
			reader.readAsDataURL(data.files[0]); 
 			reader.onload = function(evt) {
 				data.parentNode.childNodes[1].childNodes[1].src = evt.target.result; 
			}

		}
	}
</script>
	</head>
<body>
<form action="operatorauditdoctor/saveHospitalauditdoctor.do" name="editForm" id="editForm" method="post" enctype="multipart/form-data" onsubmit="return save();">
<%-- 	<form action="hospitalauditdoctor/${msg}.do" name="editForm" id="editForm" method="post"> --%>
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>运营商:</td>
				<td>
					<select name="hospitalId" id="hospitalId">
						<c:choose>
							<c:when test="${not empty hospitalList}">
								<c:forEach items="${hospitalList}" var="hospital">
									<option value="${hospital.id}" <c:if test="${entity.hospitalId == hospital.id}">selected='selected'</c:if>>${hospital.name}</option>
								 </c:forEach>								
							</c:when>	
						</c:choose>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生姓名:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入医生姓名"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账号:</td>
				<td>
				<input type="hidden" id="accountIsExist" value =""/>
				<input type="text" name="accountName" id="accountName" <c:if test="${msg == 'edit'}">readonly='readonly'</c:if>  value="${entity.accountName}" maxlength="32" placeholder="请输入账号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>签名图片:</td>
				<td>
					<a href="javascript:void(0)" class="newspic">
						<c:if test="${entity.signImageUrl != null && entity.signImageUrl != ''}"><img style="width:200px;height:100px;" src="<%=basePath%>${entity.signImageUrl}"/></c:if>
						<c:if test="${entity.signImageUrl == null || entity.signImageUrl == ''}"><img style="width:200px;height:100px;"  src="<%=basePath%>static/img/selectimg.png"/></c:if>
					</a>
					<input type="file" id="signImageUrl" name="signImageUrl" onchange="showPic(this)"  style="display: none"/>
				</td>																					
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">				
				<button  class="submitBtn btn btn-primary" type="submit" >保存</button>
<!-- 					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a> -->
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>