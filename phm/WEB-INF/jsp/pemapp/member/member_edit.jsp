<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<form action="member/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>编号:</td>
				<td><input type="text" name="number" id="number" value="${entity.number}" maxlength="32" placeholder="请输入编号" disabled="disabled"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>姓名:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入姓名"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>电话:</td>
				<td><input type="text" name="mobile" id="mobile" value="${entity.mobile}" maxlength="32" placeholder="请输入电话"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>头像:</td>
				<td><a href="javascript:void(0)" class="newspic">
						<c:if test="${entity.photoUrl != null && entity.photoUrl != ''}">
							<img style="width:200px;height:100px;" src="<%=basePath%>${entity.photoUrl}"/>
						</c:if>
						<c:if test="${entity.photoUrl == null || entity.photoUrl == ''}">
							<img style="width:200px;height:100px;" src="<%=basePath%>static/img/selectimg.png"/>
						</c:if>
					</a>
					<input type="file" id="photoUrl" name="photoUrl" onchange="showPic(this)"  style="display: none"/>
				</td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>性别:</td>
				<td><select id="gender" name="gender"></select></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>省-市-区:</td>
				<td><div id="distpicker" data-toggle="distpicker">
                        <select id="addressProvSel"></select>
                        <select id="addressCitySel"></select>
                        <select id="addressCountySel"></select>
                    </div>
                    <input type="hidden" name="addressProv" id="addressProv" value=""/>
                    <input type="hidden" name="addressCity" id="addressCity" value=""/>
                    <input type="hidden" name="addressCounty" id="addressCounty" value=""/>
				</td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">详细地址:</td>
				<td><input type="text" name="addressDetail" id="addressDetail" value="${entity.addressDetail}" maxlength="32" placeholder="请输入详细地址"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">生日:</td>
				<td><input id="birthday" type="text" class="form-control span10 date-picker" value="${fn:substring(entity.birthday,0,10)}" 
						data-date-format="yyyy-mm-dd" placeholder="请输入预约日期"></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">学历:</td>
				<td><select id="degree" name="degree"></select></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">职业:</td>
				<td><select id="career" name="career"></select></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">婚姻状态:</td>
				<td><select id="maritalStatus" name="maritalStatus"></select></td>
			</tr>
			<tr><td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">保存成功</td></tr>
			<tr><td style="text-align: center;" colspan="10">
					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a>
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
<script type="text/javascript">
	//组件初始化
	$('.date-picker').datepicker();
	//这里是图片（头像）的部分：
	$(".newspic").click(function() {
		$(this).next('input').click();
	});	
	
	//ready事件
	$(function(){
		//初始化省市区
        $("#distpicker").distpicker({
            province:"${entity.addressProv}",
            city: "${entity.addressCity}",
            district:"${entity.addressCounty}"
        });
		//构建下拉菜单 
		SELECT_LIST.getGenderSelect("gender",'${entity.gender}');//性别
		SELECT_LIST.getDegreeSelect("degree",'${entity.degree}');//学历
		SELECT_LIST.getCareerSelect("career",'${entity.career}');//职业
		SELECT_LIST.getMaritalStatusSelect("maritalStatus",'${entity.maritalStatus}');//婚姻状况
	});
	//点击事件：在页面上展示上传图片的预览
	function showPic(data) {
		if (data.files && data.files[0]) {
			var reader = new FileReader();
			reader.onload = function(evt) {
				data.parentNode.childNodes[0].childNodes[1].src = evt.target.result; 
			}
			reader.readAsDataURL(data.files[0]);
		}
	}
	
	//这里是表单提交事件
	function save(target){
		//表单验证，不进行表单验证
		/* if (checkForm() == false) {
			return false;
		} */
		console.log("进来了吧");
		//省
        var addressProv=$("#addressProvSel").val();
        //市
        var addressCity=$("#addressCitySel").val();
        //区
        var addressCounty=$("#addressCountySel").val();
        
		//构建FormData
		var formData = new FormData();
		formData.append("id", $('#id').val());
		formData.append("number", $('#number').val());
		formData.append("name", $('#name').val());
		formData.append("mobile", $('#mobile').val());
		formData.append("gender", $('#gender').val());
		formData.append("addressProv", addressProv);
		formData.append("addressCity", addressCity);
		formData.append("addressCounty", addressCounty);
		formData.append("addressDetail", $('#addressDetail').val());
		formData.append("birthday",$('#birthday').val());
		formData.append("degree", $('#degree').val());
		formData.append("career", $('#career').val());
		formData.append("maritalStatus", $('#maritalStatus').val());
		
		if(document.getElementById('photoUrl').files[0] == undefined){
		    formData.append("photoUrl",$("#photoUrl").val());
		}else{
		    formData.append("photoUrl",document.getElementById('photoUrl').files[0]);//将文件放到FormData中
		}
		console.log("这样吗");
		//这里是AJAX的操作，以及一些参数的给出
		var action = '${msg}';
		console.log(action);
		var url = 'member/to'+action;
		$.ajax({
			async : false,
			url : url,
			type : 'post',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data) {
				if (data.code == 200) {
					showSuccessMessage();
					hideDialog(target);
					location.reload();
				}
			},
		});
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
	//表单验证
	function checkForm(){
		var regphone=/^(13|15|18)[0-9]{9}$/; // 手机号正则表达式
		console.log("编号："+$("#number").val());
		/* if($("#number").val()==""){
			popupTip('number', '请输入编号');
			return false;
		} */
		if($("#name").val()==""){
			popupTip('name', '请输入姓名');
			return false;
		}
		if($("#mobile").val()==""){
			popupTip('mobile', '请输入电话');
			return false;
		}
		if (regphone.test($("#mobile").val()) == false) {
			popupTip('mobile', '请输入正确的电话号码');
			return false;
		}
		if($("#photoUrl").val()==""){ /* 头像的验证 */
			popupTip('photoUrl', '请选择头像');
			return false;
		}
		if($("#gender").val()==""){
			popupTip('gender', '请选择性别');
			return false;
		}
		/* 省市区的验证 */
		if ($("#addressProvSel").val()=="") {
			popupTip('addressProvSel', '请选择省份');
			return false;
		}
		if ($("#addressCitySel").val()=="") {
			popupTip('addressCitySel', '请选择城市');
			return false;
		}
		if ($("#addressCountySel").val()=="") {
			popupTip('addressCountySel', '请选择区域');
			return false;
		}
		if($("#addressDetail").val()==""){
			popupTip('addressDetail', '请输入详细地址');
			return false;
		}
		if($("#birthday").val()==""){
			popupTip('birthday', '请选择生日');
			return false;
		}
		if($("#degree").val()==""){
			popupTip('degree', '请选择文化程度');
			return false;
		}
		if($("#career").val()==""){
			popupTip('career', '请选择职业');
			return false;
		}
		if($("#maritalStatus").val()==""){
			popupTip('maritalStatus', '请选择婚姻状况');
			return false;
		}
	}
</script>
</html>