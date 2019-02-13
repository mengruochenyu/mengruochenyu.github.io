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
		if($("#name").val()==""){
			popupTip('name', '请输入APP名称');
			return false;
		}
		if($("#version").val()==""){
			popupTip('version', '请输入APP版本');
			return false;
		}
		if($("#type").val()==""){
			popupTip('type', '请输入APP类型');
			return false;
		}
		/* if($("#fileDownAddress").val()==""){
			popupTip('fileDownAddress', '请输入文件下载地址');
			return false;
		} */
		/* if($("#qrcodeDownAddress").val()==""){
			popupTip('qrcodeDownAddress', '请输入二维码下载地址');
			return false;
		} */
		/* if($("#updateHint").val()==""){
			popupTip('updateHint', '请输入版本更新提示语');
			return false;
		} */
		if($("#status").val()==""){
			popupTip('status', '请输入可更新状态');
			return false;
		}
		/* if($("#size").val()==""){
			popupTip('size', '请输入文件大小');
			return false;
		} */
		if($("#isConstraint").val()==""){
			popupTip('isConstraint', '请输入是否强制更新');
			return false;
		}
		if($("#versionType").val()==""){
			popupTip('versionType', '请输入版本类型');
			return false;
		}
	
		var action = '${msg}';
		var url = 'systemversion/' + action + "Version";
        var formData = new FormData($("#editForm")[0]);
         $.ajax({
             async: false,
             url: url,
             type: 'post',
             data: formData,
             processData: false,
             contentType: false,
             success: function (result) {
                 if (result.code == 200) {
                     location.reload();
                 }else{
                     if(result.data != null && result.data !=""){
                         bootbox.alert(result.data);
                     }else{
                         bootbox.alert(result.msg);
                     }
                 }
             }
         });
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
	
	/* function showPic(data) {
        if (data.files && data.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
            	
                data.parentNode.childNodes[1].childNodes[1].src = evt.target.result;
            }
            reader.readAsDataURL(data.files[0]);
        }
    } */
	
</script>
	</head>
<body>
	<form action="systemversion/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>APP名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>APP版本:</td>
				<td><input type="text" name="version" id="version" value="${entity.version}" maxlength="32" placeholder="请输入版本"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>APP类型:</td>
				<td><input type="text" name="type" id="type" value="${entity.type}" maxlength="32" placeholder="请输入类型"/></td>
			</tr>
			 <tr>
                <td style="width:80px;text-align: right;padding-top: 13px;">文件:</td>
                <td>
                    <input type="file" class="imgUrl" id="fileDownAddress" name="fileDownAddress"
                            accept="*/*"/>
            </tr>
           <%--  <tr>
            <td class="name">二维码:</td>
            <td>
                <a href="javascript:void(0)" class="newspic">
                    <c:if test="${entity.qrcodeDownAddress != null && entity.qrcodeDownAddress != ''}">
                        <img style="width: 100px; height: 50px;"
                             src="<%=basePath%>${entity.qrcodeDownAddress}" />
                    </c:if>
                    <c:if test="${entity.fileDownAddress == null || entity.qrcodeDownAddress == ''}">
                        <img style="width: 100px; height: 50px;"
                             src="<%=basePath%>static/img/selectimg.png" />
                    </c:if>
                </a>
                <input type="file" name="qrcodeDownAddress" id="qrcodeDownAddress" onchange="showPic(this)" style="display: none;" accept="image/*"/></td>
        </tr> --%>
			<%-- <tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>二维码下载地址:</td>
				<td><input type="text" name="qrcodeDownAddress" id="qrcodeDownAddress" value="${entity.qrcodeDownAddress}" maxlength="32" placeholder="请输入二维码下载地址"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">版本更新提示语:</td>
				<td><input type="text" name="updateHint" id="updateHint" value="${entity.updateHint}" maxlength="32" placeholder="请输入版本更新提示语"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>可更新状态:</td>
				<td>
                    <select name="status" id="status">
                       <option value="">--请选择--</option>
                       <option value="0" <c:if test="${entity.status == 0}">selected</c:if>> 否</option>
                       <option value="1" <c:if test="${entity.status == 1}">selected</c:if>> 是</option>
                    </select>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">文件大小:</td>
				<td><input type="text" name="size" id="size" value="${entity.size}" maxlength="32" placeholder="请输入文件大小"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>是否强制更新:</td>
				<td>
                <select name="isConstraint" id="isConstraint">
                    <option value="">--请选择--</option>
                    <option value="0" <c:if test="${entity.isConstraint == 0}">selected</c:if>> 否</option>
                    <option value="1" <c:if test="${entity.isConstraint == 1}">selected</c:if>> 是</option>
                </select>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>版本类型:</td>
				<td>
                <select name="versionType" id="versionType">
                    <option value="">--请选择--</option>
                     <option value="android_member" <c:if test="${entity.versionType == 'android_member'}">selected</c:if>> android用户端</option>
                     <option value="android_doctor" <c:if test="${entity.versionType == 'android_doctor'}">selected</c:if>> android医生端</option>
                     <option value="ios_member" <c:if test="${entity.versionType == 'ios_member'}">selected</c:if>> ios用户端</option>
                     <option value="ios_doctor" <c:if test="${entity.versionType == 'ios_doctor'}">selected</c:if>> ios医生端</option>
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