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
<body>
	<form action="doctorspecialityasso/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${doctor.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生姓名:</td>
				<td><label>${doctor.name}</label></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生电话:</td>
				<td><label>${doctor.mobile}</label></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>医生专长:</td>
				<td>
					<span class="input-icon">
						<select name="speciality" id="specialityId">
							<option value="">请选择专长</option>
                       		<c:forEach items="${specialityList}" var="speciality" varStatus="vs">
                       			<option value="${speciality.dictionaryId}">${speciality.dicName}</option>
                       		</c:forEach>
						</select>
                   </span>
                   <span class="input-icon">
							<select name="color" id="colorId">
								<option value="">请选择字段颜色</option>
	                       		<c:forEach items="${colorList}" var="color" varStatus="vs">
	                       			<option value="${color.dictionaryId}" style="color: ${color.dicName}">
	                       				${color.dicName}
	                       			</option>
	                       		</c:forEach>
							</select>
                   		</span>
                   <a class='btn btn-mini btn-info' onclick="newAsso()">新增</a>
				</td>
			</tr>
			<!-- 接下来是该医生的所有专长的列表能够提供修改和删除 -->
			<tr><td></td><td><span>医生专长列表:</span></td></tr>
			<c:forEach items="${assoList}" var="asso" varStatus="vs">
				<tr>
					<td></td>
					<td>
						<c:forEach items="${specialityList}" var="speciality" varStatus="vs">
						<c:forEach items="${colorList}" var="color" varStatus="vs">
							<c:if test="${color.dictionaryId== asso.fontColorId}">
							<c:if test="${speciality.dictionaryId== asso.specialityId}">
								<span style="color: ${color.dicName}; width: 150px;">${speciality.dicName}</span>
							</c:if></c:if>
						</c:forEach></c:forEach>
						<span class="input-icon">
							<select name="colorId" id="color">
								<option value="">请选择字段颜色</option>
	                       		<c:forEach items="${colorList}" var="color" varStatus="vs">
	                       			<option value="${color.dictionaryId}" <c:if test="${color.dictionaryId== asso.fontColorId}">selected</c:if> style="color: ${color.dicName}">
	                       				${color.dicName}
	                       			</option>
	                       		</c:forEach>
							</select>
                   		</span>
                   		<%-- <a class='btn btn-mini btn-info' onclick="delAsso(${asso.id})">修改</a> --%>
                   		<a class='btn btn-mini btn-info' onclick="delAsso(${asso.id})">删除</a>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
<script type="text/javascript">
	function checkForm(){
		if($("#specialityId").val()==""){
			popupTip('specialityId', '请选择擅长方向');
			return false;
		}
		if($("#colorId").val()==""){
			popupTip('colorId', '请输入选择颜色');
			return false;
		}
		return true;
	}
	
	//新增专长关系数据
	function newAsso(){
		if (checkForm() == false) {
			return false;
		}
		//必要参数：医生id、专长字段在数据字典中的id、选择的颜色在数据字典中的id
		var doctorId = $("#id").val();
		var specialityId = $("#specialityId").val();
		var colorId = $("#colorId").val();
		$.ajax({
	        url: '<%=basePath%>doctorspecialityasso/saveasso',
	        type: "POST",
	        data:{
	        	"doctorId" : doctorId,
	        	"specialityId" : specialityId,
	        	"fontColorId" : colorId
            },
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        success: function(result){
	        	var code = result.code;
				if (code == 200) {
					bootbox.confirm('操作成功', function(result) {
						location.reload();
		    		});
				} else if (code == 504) {
					alert("新增专长已存在！");
				} else {
					console.log(code);
				}
	        },
	        error: function(result){
	        	bootbox.alert("操作失败");
	        },
	        dataType:'json'
	    });
	}
	//删除专长
	function delAsso(id){
		var url = "<%=basePath%>doctorspecialityasso/delete/"+id;
		$.ajax({
	        url: url,
	        type: "POST",
	        data:null,
	        success: function(result){
	        	var code = result.code;
				if (code == 200) {
					bootbox.confirm('操作成功', function(result) {
		    			if (result) {
		    				location.reload();
						}
		    		});
				} else {
					console.log(code);
				}
	        },
	        error: function(result){
	        	bootbox.alert("操作失败");
	        },
	        dataType:'json'
	    });
	}
	//提示信息
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
</html>