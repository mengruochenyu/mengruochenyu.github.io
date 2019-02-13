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
        <%@ include file="../../system/admin/top.jsp"%>
<script type="text/javascript">
	
	//保存
	function save(target){
		accountIsExist();
		if($("#name").val()==""){
			popupTip('name', '请输入名称');
			return false;
		}
/* 		if($("#logoUrl").val()==""){
			popupTip('logoUrl', '请输入医院logo');
			return false;
		} */
		if($("#accountName").val()==""){
			popupTip('accountName', '请输入账号');
			return false;
		}
		if($("#dockingName").val()==""){
			popupTip('dockingName', '请输入对接人');
			return false;
		}
		if($("#dockingPhone").val()==""){
			popupTip('dockingPhone', '请输入对接人电话');
			return false;
		}
/* 		if($("#addressProv").val()==""){
			popupTip('addressProv', '请输入地址省');
			return false;
		}
		if($("#addressCity").val()==""){
			popupTip('addressCity', '请输入地址市');
			return false;
		}
		if($("#addressCounty").val()==""){
			popupTip('addressCounty', '请输入地址区县');
			return false;
		} */
		if($("#addressDetail").val()==""){
			popupTip('addressDetail', '请输入地址详情');
			return false;
		}
		if($("#contractNum").val()==""){
			popupTip('contractNum', '请输入合同号');
			return false;
		}
		if($("#hospitalPath").val()==""){
			popupTip('hospitalPath', '请输入运营商端路径');
			return false;
		}
		if($("#userPath").val()==""){
			popupTip('userPath', '请输入用户端路径');
			return false;
		}
		if($("#reportAudit").val()==""){
			popupTip('reportAudit', '请输入检测报告审核设置');
			return false;
		}
        //省
        var addressProv=$("#addressProvSel").val();
        var addressProvId=$("#addressProvSel").find("option:selected").attr("data-code");
        //市
        var addressCity=$("#addressCitySel").val();
        var addressCityId=$("#addressCitySel").find("option:selected").attr("data-code");
        //区
        var addressCounty=$("#addressCountySel").val();
        var addressCountyId=$("#addressCountySel").find("option:selected").attr("data-code");

        $("#addressProv").val(addressProv);
        $("#addressProvId").val(addressProvId);
        $("#addressCity").val(addressCity);
        $("#addressCityId").val(addressCityId);
        $("#addressCounty").val(addressCounty);
        $("#addressCountyId").val(addressCountyId);
        var action = '${msg}';
        if(action == "save"){
        	accountIsExist();
            var flag = $('#accountIsExist').val();
    		if(flag != "false"){
    			popupTip('accountName', '账号已存在');
    			return false;
    		}
        }
	
/* 		var action = '${msg}';
		var url = 'hospital/' + action;
		ajaxSave(target, url, action); */
		return true;
	}
	
	function accountIsExist(){
	    var url="hospital/accountIsExist/" + $('#accountName').val();
	    $.ajax({
	        type: "POST",
	        url: url,
	        dataType: 'json',
	        async:false,
	        contentType: "application/json;charset=UTF-8",
	        success: function(data){
	        	if(data.code == 200){
	        		$('#accountIsExist').val("false");
	        	}
	        	if(data.code == 625){
	        		$('#accountIsExist').val("");
	        	}
	        }
	    }); 
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
	
	$(".newspic").click(function() {
		$(this).next('input').click();
	});	
	function showPic(data) {
		if (data.files && data.files[0]) {
			var reader = new FileReader();
 			reader.onload = function(evt) {
 				data.parentNode.childNodes[1].childNodes[1].src = evt.target.result; 
			}
			reader.readAsDataURL(data.files[0]);
		}
	}
</script>
	</head>
<body>
<%-- 	<form action="hospital/${msg}.do" name="editForm" id="editForm" method="post"> --%>
		<form action="operator/saveHospital.do" name="editForm" id="editForm" method="post" enctype="multipart/form-data" onsubmit="return save();">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<input type="hidden" name="type" id="type" value="${type}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>省-市-区:</td>
				<td>
                        <div id="distpicker" data-toggle="distpicker">
                            <select id="addressProvSel"></select>
                            <select id="addressCitySel"></select>
                            <select id="addressCountySel"></select>
                        </div>
                        <input type="hidden" name="addressProv" id="addressProv" value=""/>
                        <input type="hidden" name="addressCity" id="addressCity" value=""/>
                        <input type="hidden" name="addressCounty" id="addressCounty" value=""/>
                        <input type="hidden" name="addressProvId" id="addressProvId" value=""/>
                        <input type="hidden" name="addressCityId" id="addressCityId" value=""/>
                        <input type="hidden" name="addressCountyId" id="addressCountyId" value=""/>
                        <script>
                            //初始化省市区
                            $("#distpicker").distpicker({
                                <%--shopProvinceId:'${entity.shopProvince}',--%>
                                <%--shopCityId: '${entity.shopProvince}',--%>
                                <%--shopRegionId:'${entity.shopRegion}'--%>
                                province:"${entity.addressProv}",
                                city: "${entity.addressCity}",
                                district:"${entity.addressCounty}"
                            });
                        </script>
				</td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>运营商介绍:</td>
				<td><textarea rows="3" style="resize:none;width:200px;"name="intro" id="intro""placeholder="请输入名称">${entity.intro}</textarea></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>运营商logo:</td>
				<td>
					<a href="javascript:void(0)" class="newspic">
						<c:if test="${entity.logoUrl != null && entity.logoUrl != ''}"><img style="width:200px;height:100px;" src="<%=basePath%>${entity.logoUrl}"/></c:if>
						<c:if test="${entity.logoUrl == null || entity.logoUrl == ''}"><img style="width:200px;height:100px;"  src="<%=basePath%>static/img/selectimg.png"/></c:if>
					</a>
					<input type="file" id="logoUrl" name="logoUrl" onchange="showPic(this)"  style="display: none"/>
				</td>									
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账号:</td>
				<td>
				<input type="hidden" id="accountIsExist" value =""/>
				
				<input type="text" name="accountName" id="accountName"  <c:if test="${msg == 'edit'}">readonly='readonly'</c:if> value="${entity.accountName}" maxlength="32" placeholder="请输入账号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人:</td>
				<td><input type="text" name="dockingName" id="dockingName" value="${entity.dockingName}" maxlength="32" placeholder="请输入对接人"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>对接人电话:</td>
				<td><input type="text" name="dockingPhone" id="dockingPhone" value="${entity.dockingPhone}" maxlength="32" placeholder="请输入对接人电话"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>地址详情:</td>
				<td><input type="text" name="addressDetail" id="addressDetail" value="${entity.addressDetail}" maxlength="32" placeholder="请输入地址详情"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>合同号:</td>
				<td><input type="text" name="contractNum" id="contractNum" value="${entity.contractNum}" maxlength="32" placeholder="请输入合同号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>运营商端路径:</td>
				<td><textarea style="resize: none;width:200px;" name="hospitalPath" id="hospitalPath" placeholder="请输入运营商端路径">${entity.hospitalPath}</textarea></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>用户端路径:</td>
				<td><textarea style="resize: none;width:200px;" name="userPath" id="userPath" placeholder="请输入用户端路径">${entity.userPath}</textarea></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>检测报告审核设置:</td>
				<td>
					<label><input type="radio" name="reportAudit" value="1"  <c:if test="${msg == 'save'}">checked="checked"</c:if> <c:if test="${entity.reportAudit == 1}">checked="checked"</c:if>>审核</label>
					<label><input type="radio" name="reportAudit" value="0"  <c:if test="${entity.reportAudit == 0}">checked="checked"</c:if>>不审核</label>
				</td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检卡权限:</td>
                <td>
                    <select id="cardRight" name="cardRight">
                        <option value="2" <c:if test="${entity.cardRight==2}">selected</c:if>>实体卡；虚拟卡</option>
                        <option value="0" <c:if test="${entity.cardRight==0}">selected</c:if>>只有虚拟卡</option>
                        <option value="1" <c:if test="${entity.cardRight==1}">selected</c:if>>只有实体卡</option>
                    </select>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>数据是否共享:</td>
                <td>
                    <select id="isShare" name="isShare">
                        <option value="0" <c:if test="${entity.isShare==0}">selected</c:if>>不共享</option>
                        <option value="1" <c:if test="${entity.isShare==1}">selected</c:if>>共享</option>
                    </select>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>体检报告用户可见:</td>
                <td>
                    <select id="userLook" name="userLook">
                        <option value="0" <c:if test="${entity.userLook==0}">selected</c:if>>不可见</option>
                        <option value="1" <c:if test="${entity.userLook==1}">selected</c:if>>可见</option>
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
						<button  class="submitBtn btn btn-primary" type="submit" >保存</button>
					<!-- <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a> -->
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>