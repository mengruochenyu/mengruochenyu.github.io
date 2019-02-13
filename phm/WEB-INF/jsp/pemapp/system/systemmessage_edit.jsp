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
		if($("#synopsis").val()==""){
			popupTip('synopsis', '请输入消息简介');
			return false;
		}
		if(content.getContent()=="" || content.getContent()==null){
            popupTip('content', '请输入正文');
            return false;
        }
		var action = '${msg}';
		var url = 'systemmessage/' + action;
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
	<form action="systemmessage/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息简介:</td>
				<td><input type="text" name="synopsis" id="synopsis" value="${entity.synopsis}" maxlength="32" placeholder="请输入消息简介"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>消息内容:</td>
				<td>
                    <textarea name="content" id="content">${entity.content}</textarea>
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