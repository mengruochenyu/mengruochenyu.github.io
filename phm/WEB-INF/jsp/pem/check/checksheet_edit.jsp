<%@ page import="com.blue.common.model.CheckReportEchartTypeEnum" %>
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
			popupTip('name', '请输入名称');
			return false;
		}
		if((editor.getContent()==""||editor.getContent()==null)&&($("#description").val()==null||$("#description").val()=='')){
			popupTip('description', '请输入量表指导语');
			return false;
		}
		if($("#classify").val()==""){
			popupTip('classify', '请选择量表分类');
			return false;
		}
		var action = '${msg}';
		var url = 'checksheet/' + action;
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

	function doHelp1(){
        layer.open({
            content:"可直接使用（无需定义）的变量：<br>patientItem（体检用户信息），<br>"+
            "sheetScoreSum(检测分数)<br>"+
            "返回方式：直接return double类型变量。<br>"+
            "比如：<br>" +
            "double calculateScore=sheetScoreSum*patientItem.getGender();<br>"+
            "return calculateScore;",
            area:"476px",
            title:"分数表达式规范"
        });
    }
	function doHelp2(){
        layer.open({
            content:"json格式，颜色：color，刻度：scale",
            title:"渲染参数"
        });
    }

    function checkExpression(flag){
        var expression=$("#scoreExpression").val();
        var ajaxObject={};
        ajaxObject.url="<%=basePath%>checksheet/checkExpression";
        ajaxObject.data={
            "expression":expression
        };
        ajaxObject.success=function(result){
            if(200 == result.code){
                if(flag==1) alert("验证通过");
            }else{
                alert(result.msg);
            }
        }
        ajaxPost(ajaxObject);
    }
</script>
	</head>
<body>
	<form action="checksheet/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" style="width:231px;" placeholder="请输入名称"/></td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>量表分类:</td>
                <td>
                    <select id="classify" name="classify" style="width: 231px;">
                        <option value="">请选择分类</option>
                        <c:if test="${not empty classifyList}">
                            <c:forEach items="${classifyList}" var="var">
                                <option value="${var.id}" <c:if test="${var.id==entity.classify}">selected</c:if>>${var.name}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </td>
			</tr>
            <tr>
                <td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>展示方式:</td>
                <td>
                    <select name="echartType" id="echartType" style="width: 231px;">
                        <option value="">请选择</option>
                        <option value= 0 >自定义</option>
                        <%for(CheckReportEchartTypeEnum echartTypeEnum:CheckReportEchartTypeEnum.values()){
                            request.getSession().setAttribute("echart",echartTypeEnum);
                        %>
                            <option value="${echart.code}" <c:if test="${echart.code==entity.echartType}">selected</c:if>>${echart.name}</option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <%--  <tr>
                <td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>第二个表格展示方式:</td>
                <td>
                    <select name="secondEchartType" id="secondEchartType" style="width: 231px;">
                        <option value="">若有请选择</option>
                        <option value= 0 >自定义</option>
                        <%for(CheckReportEchartTypeEnum echartTypeEnum:CheckReportEchartTypeEnum.values()){
                            request.getSession().setAttribute("echart",echartTypeEnum);
                        %>
                            <option value="${echart.code}" <c:if test="${echart.code==entity.secondEchartType}">selected</c:if>>${echart.name}</option>
                        <%}%>
                    </select>
                </td>
            </tr> --%>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;"><em>*</em>指导语:</td>
				<td>
                    <textarea name="description" id="description" placeholder="请输入指导语">${entity.description}</textarea>
                </td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;">小于该值时预警:</td>
				<td><input type="text" name="min" id="min" value="${entity.min}" maxlength="32" style="width:231px;" placeholder="请输入小于该值时预警"/></td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;">大于该值时预警:</td>
				<td><input type="text" name="max" id="max" value="${entity.max}" style="width:231px;" maxlength="32" placeholder="请输入大于该值时预警"/></td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;">
                    分数表达式<a href="javascript:void(0);" class="easyui-linkbutton" onclick="doHelp1()"><i class="fa fa-question-circle"></i></a>:
                    <br><br><a href="javascript:void(0);" onclick="checkExpression(1)">点击验证</a>
                </td>
				<td><textarea name="scoreExpression" id="scoreExpression" style="width: 231px;height: 85px;" placeholder="请输入分数表达式">${entity.scoreExpression}</textarea></td>
			</tr>
			<tr>
				<td style="width:140px;text-align: right;padding-top: 13px;">渲染参数<a href="javascript:void(0);" class="easyui-linkbutton" onclick="doHelp2()"><i class="fa fa-question-circle"></i></a>:</td>
				<td><textarea name="renderExpression" id="renderExpression" style="width: 231px;height: 85px;" placeholder="请输入渲染参数(json格式)">${entity.renderExpression}</textarea></td>
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
    UE.delEditor('description');
    var editor = UE.getEditor('description',{
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