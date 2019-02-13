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
	<!-- doctor/${msg}.do -->
	<form action="" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>姓名:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入姓名"/></td>
				<td style="width:80px;text-align: right;padding-top: 13px;" rowspan="2"><em>*</em>头像:</td>
				<td rowspan="2"><a href="javascript:void(0)" class="newspic" id="photoCheck">
						<c:if test="${entity.photoUrl != null && entity.photoUrl != ''}">
							<img style="width:130px;height:100px;" src="<%=basePath%>${entity.photoUrl}"/>
						</c:if>
						<c:if test="${entity.photoUrl == null || entity.photoUrl == ''}">
							<img style="width:130px;height:100px;" src="<%=basePath%>static/img/doctortouxiang.png"/>
						</c:if>
					</a>
					<input type="file" id="photoUrl" name="photoUrl" onchange="showPic(this)"  style="display: none"/>
					<input type="hidden" id="checkPhotoUrl" value="${entity.photoUrl}"/>
				</td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>电话:</td>
				<td>
					<input type="text" name="mobile" id="mobile" value="${entity.mobile}" maxlength="32" placeholder="请输入电话"/>
					<span class="btn btn-mini btn-info" style="display:none"></span>
				</td>
			</tr>
			<tr><td colspan="4"><hr></td></tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>性别:</td>
				<td><select id="gender" name="gender"></select></td>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>提成比例:</td>
				<td><input type="text" name="royaltyRate" id="royaltyRate" value="${entity.royaltyRate}" maxlength="32" placeholder="请输入提成比例"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>状态:</td>
				<td><select id="status" name="status"></select></td>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>开拓人员:</td>
				<td><select id="pioneerId" name="pioneerId"></select></td>
				
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">账户类型:</td>
				<td><select id="accountType" name="accountType" ></select></td>
				<td style="width:80px;text-align: right;padding-top: 13px;">收益账户:</td>
				<td><input type="text" name="incomeAccount" id="incomeAccount" value="${entity.incomeAccount}" maxlength="32" placeholder="请输入收益账户"/></td>
				
				<%-- <td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>账户余额:</td>
				<td><input type="text" name="accountBalance" id="accountBalance" value="${entity.accountBalance}" maxlength="32" placeholder="请输入账户余额"/></td> --%>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;">头衔/称号:</td>
				<td><select id="titleId" name="titleId"></select></td>
				<%-- <td style="width:80px;text-align: right;padding-top: 13px;" rowspan="2"><em>*</em>备注:</td>
				<td rowspan="2"><textarea style="width:200px; resize:none; height:65px;" name="remark" id="remark" placeholder="请输入备注">${entity.remark}</textarea></td> --%>
			    
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>个人简介:</td>
				<td colspan="3"><textarea name="introduce" id="introduce">${entity.introduce}</textarea></td>
			</tr>
			<tr><td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">保存成功</td></tr>
			<tr><td style="text-align: center;" colspan="10">
					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a></td>
			</tr>
		</table>
		</div>
	</form>
</body>

<script type="text/javascript">
	UEDITOR_CONFIG.UEDITOR_HOME_URL = './ueditor/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息
	//富文本
	UE.delEditor('introduce');
	var content = UE.getEditor('introduce',{
	    initialFrameHeight:200,
	    initialFrameWidth:500,
	    autoHeightEnabled: false,
	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
	    toolbars:[[
	        'source', '|', 'undo', 'redo', '|',
	        'bold', 'italic', 'underline',  'strikethrough',
	        'removeformat', 'formatmatch', 'pasteplain', '|',
	        'forecolor',  'insertorderedlist', 'insertunorderedlist',
	        'selectall', 'cleardoc', '|',
	        'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',"simpleupload","insertimage",'|',
	        'indent','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
	        'fontfamily', 'fontsize',
	    ]],
	    'fontsize':[10, 11, 12, 14, 16, 18, 20, 24, 36],
	    'fontfamily':[
            { label:'',name:'songti',val:'宋体,SimSun'},
            { label:'',name:'kaiti',val:'楷体,楷体_GB2312, SimKai'},
            { label:'',name:'yahei',val:'微软雅黑,Microsoft YaHei'},
            { label:'',name:'heiti',val:'黑体, SimHei'},
            { label:'',name:'lishu',val:'隶书, SimLi'},
            { label:'',name:'andaleMono',val:'andale mono'},
            { label:'',name:'arial',val:'arial, helvetica,sans-serif'},
            { label:'',name:'arialBlack',val:'arial black,avant garde'},
            { label:'',name:'comicSansMs',val:'comic sans ms'},
            { label:'',name:'impact',val:'impact,chicago'},
            { label:'',name:'timesNewRoman',val:'times new roman'}
        ],
	    //关闭elementPath
	    elementPathEnabled:false,
	    //关闭自动保存
	    enableAutoSave: false,
	    saveInterval: (60*60*24)
	});
	
	UE.Editor.prototype._bkGetActionUrl=UE.Editor.prototype.getActionUrl;
	UE.Editor.prototype.getActionUrl=function(action){
	    if (action == 'uploadimage'){
	        return "<%=basePath%>common/ueditorUpload";    /* 这里填上你自己的上传图片的action */
	    }else{
	        return this._bkGetActionUrl.call(this, action);
	    }
	};
	
</script>
<script type="text/javascript">
	$(function(){
		//构建下拉菜单 
		SELECT_LIST.getGenderSelect("gender",'${entity.gender}');//性别
		SELECT_LIST.getAccountTypeSelect("accountType",'${entity.accountType}');//账号类型
		SELECT_LIST.getDoctorStatusSelect("status",'${entity.status}');//医生账号状态
		SELECT_LIST.getDoctorTitleSelect("titleId",'${entity.titleId}');//医生账号状态
		SELECT_LIST.getDoctorExpioneerSelect("pioneerId",'${entity.pioneerId}');//医生绑定的开拓人员
		//获取默认参数
		if ('${msg}'=="save") {
			var url = '<%=basePath%>systemsetting/getvaluebycode';
			console.log(url);
			$.post(url,{"code":"doctor_royalty_rate"},function(results){
				$("#royaltyRate").val(results.data);
			}
			);
		}
	});
	
	//这里是头像的点击事件：
	$(".newspic").click(function() {
		$(this).next('input').click();
	});	
	function showPic(data) {// 点击事件：在页面上展示上传图片的预览
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
		var action = '${msg}';
		console.log(action);
		//表单验证
		if (checkForm() == false) {
			return false;
		}
		//表单验证完成，构建FormData
		var formData = new FormData();
		formData.append("id", $('#id').val());
		formData.append("name", $('#name').val());
		formData.append("mobile", $('#mobile').val());
		formData.append("gender", $('#gender').val());
		formData.append("introduce", content.getContent());
		formData.append("incomeAccount", $('#incomeAccount').val());
		formData.append("accountType", $('#accountType').val());
		formData.append("accountBalance", $('#accountBalance').val());
		formData.append("titleId", $('#titleId').val());
		formData.append("qualification", $('#qualification').val());
		formData.append("royaltyRate", $('#royaltyRate').val());
		formData.append("status", $('#status').val());
		formData.append("remark", $('#remark').val());
		formData.append("pioneerId", $('#pioneerId').val());
		
		if(document.getElementById('photoUrl').files[0] == undefined){
		    formData.append("photoUrl","static/img/doctortouxiang.png");
		}else{
		    formData.append("photoUrl",document.getElementById('photoUrl').files[0]);//将文件放到FormData中
		}
		//这里是AJAX的操作，以及一些参数的给出
		var url = 'doctor/to'+action;
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
				} else {
					console.log(data.code);
				}
			},
		});
		return true;
	}
	
	//用来提示的方法
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
		console.log(regphone);
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
		/* if($("#photoUrl").val()=="" && $("#checkPhotoUrl").val()==""){
			popupTip('photoCheck', '请选择头像');
			return false;
		} */
		if($("#gender").val()==""){
			popupTip('gender', '请选择性别');
			return false;
		}
		if($("#accountType").val()==""){
			popupTip('accountType', '请选择账户类型');
			return false;
		}
		if($("#titleId").val()==""){
			popupTip('titleId', '请选择头衔/称号');
			return false;
		}
		if($("#incomeAccount").val()==""){
			popupTip('incomeAccount', '请输入收益账户');
			return false;
		}
		if($("#pioneerId").val()==""){
			popupTip('pioneerId', '请选择开拓人员');
			return false;
		}
		/* if($("#accountBalance").val()==""){
			popupTip('accountBalance', '请输入账户余额');
			return false;
		} */
		if($("#royaltyRate").val()==""){
			popupTip('royaltyRate', '请输入提成比例');
			return false;
		}
		if($("#status").val()==""){
			popupTip('status', '请选择状态');
			return false;
		}
		if($("#remark").val()==""){
			popupTip('remark', '请输入备注');
			return false;
		}
		if(content.getContent()=="" || content.getContent()==null){
            popupTip('introduce', '请输入个人简介');
            return false;
        }
	};
</script>
</html>