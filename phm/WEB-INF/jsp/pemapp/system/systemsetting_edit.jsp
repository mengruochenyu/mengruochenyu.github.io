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
			popupTip('name', '请输入设置名称');
			return false;
		}
		if($("#code").val()==""){
			popupTip('code', '请输入该设置的索引值');
			return false;
		}
		if($("#stringValue").val()==""){
			popupTip('stringValue', '请输入设置的值');
			return false;
		}
		/* if($("#doubleValue").val()==""){
			popupTip('doubleValue', '请输入设置的值');
			return false;
		}
		if($("#intValue").val()==""){
			popupTip('intValue', '请输入设置的值');
			return false;
		} */
		/* if($("#index").val()==""){
			popupTip('index', '请输入排序号');
			return false;
		}
		if($("#content").val()==""){
			popupTip('content', '请输入图文内容');
			return false;
		}
		if($("#remark").val()==""){
			popupTip('remark', '请输入描述');
			return false;
		} */
		/* if(content.getContent()=="" || content.getContent()==null){
            popupTip('content', '请输入正文');
            return false;
        } */
	
		var action = '${msg}';
		var url = 'systemsetting/' + action;
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
	<form action="systemsetting/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>设置名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入设置名称"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>该设置的索引值:</td>
				<td><input type="text" name="code" id="code" value="${entity.code}" maxlength="32" placeholder="请输入该设置的索引值" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">设置的值:</td>
				<td><input type="text" name="stringValue" id="stringValue" value="${entity.stringValue}" maxlength="32" placeholder="请输入设置的值"/></td>
			</tr>
			<%-- <tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>设置的值:</td>
				<td><input type="text" name="doubleValue" id="doubleValue" value="${entity.doubleValue}" maxlength="32" placeholder="请输入设置的值"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>设置的值:</td>
				<td><input type="number" name="intValue" id="intValue" value="${entity.intValue}" maxlength="32" placeholder="请输入设置的值"/></td>
			</tr> --%>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>排序号:</td>
				<td><input type="number" name="index" id="index" value="${entity.index}" maxlength="32" placeholder="请输入排序号"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">图文内容:</td>
				<td>
                    <textarea name="content" id="content">${entity.content}</textarea>
                </td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;">描述:</td>
				<td><input type="text" name="remark" id="remark" value="${entity.remark}" maxlength="32" placeholder="请输入描述"/></td>
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
<script type="text/javascript">
UEDITOR_CONFIG.UEDITOR_HOME_URL = './ueditor/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息
//富文本
UE.delEditor('content');
var content = UE.getEditor('content',{
    initialFrameHeight:200,
    initialFrameWidth:300,
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
    //关闭elementPath
    elementPathEnabled:false
    //关闭自动保存
    ,enableAutoSave: false,
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
</html>