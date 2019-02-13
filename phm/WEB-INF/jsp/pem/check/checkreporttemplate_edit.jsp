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
			popupTip('name', '请输入模板名称');
			return false;
		}
		if($("#degree").val()==""){
			popupTip('degree', '请选择测试结果等级');
			return false;
		}
		if($("#rangMin").val()==""){
			popupTip('rangMin', '请输入分数最小值');
			return false;
		}
		if($("#rangMax").val()==""){
			popupTip('rangMax', '请输入分数最大值');
			return false;
		}
        if($("#rangMin").val()<0){
            popupTip('rangMin', '输入不规范');
            return false;
        }
        if(!(parseFloat($("#rangMax").val())>parseFloat($("#rangMin").val()))){
            popupTip('rangMax', '最大值必须大于最小值');
            return false;
        }
		if(editor1.getContent()==""||editor1.getContent()==null){
			popupTip('comment', '请输入评语');
			return false;
		}
		if(editor2.getContent()==""||editor2.getContent()==null){
			popupTip('suggest', '请输入建议');
			return false;
		}
	
		var action = '${msg}';
		var url = 'checkreporttemplate/' + action;
		ajaxSave(target, url, action,null,null,function(){
		    debugger;
            templateSrch(null,'open',${sheet.id});
        });
		return false;
	}

	//根据体检表查询模板
	function findTemplates(obj){

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
</style>
	</head>
<body>
	<form action="checkreporttemplate/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
        <input type="hidden" name="checkSheetId" value="${sheet.id}">
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
            <tr>
                <td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>体检表:</td>
                <td>
                    ${sheet.name}
                </td>
            </tr>
            <tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>模板名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" style="width: 231px;" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>结果等级:</td>
				<td>
				<select id="degree" name="degree" style="width: 231px;">
                        <option value="1" <c:if test="${entity.degree==1}">selected</c:if>>正常</option>
                        <option value="2" <c:if test="${entity.degree==2}">selected</c:if>>轻度</option>
                        <option value="3" <c:if test="${entity.degree==3}">selected</c:if>>中度</option>
                        <option value="4" <c:if test="${entity.degree==4}">selected</c:if>>中重</option>
                        <option value="5" <c:if test="${entity.degree==5}">selected</c:if>>重度</option>
                    </select>
				</td>
			</tr>
            <tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>分数区间:</td>
				<td>
                    <input type="number" style="width: 110px !important;" name="rangMin" id="rangMin" value="${entity.rangMin}" maxlength="32" placeholder="最小值(包含)"/>
                    - <input type="number" style="width: 110px !important;" name="rangMax" id="rangMax" value="${entity.rangMax}" maxlength="32" placeholder="最大值(包含)"/>
                </td>
            </tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>评语:</td>
				<td>
                    <textarea name="comment" id="comment" placeholder="请输入评语">${entity.comment}</textarea>
                </td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>建议:</td>
				<td>
                    <textarea name="suggest" id="suggest" placeholder="请输入建议">${entity.suggest}</textarea>
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
<script>
    UEDITOR_CONFIG.UEDITOR_HOME_URL = './ueditor/'; //一定要用这句话，否则你需要去ueditor.config.js修改路径的配置信息
    //富文本
    var editor1 = UE.getEditor('comment',{
        initialFrameHeight:300,
        initialFrameWidth:231,
        //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
        toolbars:[[
            'bold', 'italic', 'underline',
            'indent','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify'
        ]],
        //关闭elementPath
        elementPathEnabled:false
        //关闭自动保存
        ,enableAutoSave: false
    });

    //富文本
    var editor2 = UE.getEditor('suggest',{
        initialFrameHeight:300,
        initialFrameWidth:231,
        //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
        toolbars:[[
            'bold', 'italic', 'underline',
            'indent','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify'
        ]],
        //关闭elementPath
        elementPathEnabled:false
        //关闭自动保存
        ,enableAutoSave: false
    });
</script>
</html>