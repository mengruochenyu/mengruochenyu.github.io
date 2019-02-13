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
        <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
        <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <style>
            #sortable { list-style-type: none; margin: 0; padding: 0; width: 90%; cursor: pointer; }
            #sortable li { background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px; line-height: 50px;}
            #sortable li span {}
            #sortable li .button {background:#438eb9;color:#ffffff;border-radius:4px;border:2px black; width:60px; height:30px;}
            .btn-small {padding: 6px 20px;border:0;border-radius:4px;color:#ffffff;line-height: 24px;font-size: 14px;background-color: #87B87F !important;}
            .ui-state-highlight{background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px;height:30px; }
            .col-md-8,.col-md-4 {
            	overflow: hidden;
            	text-overflow: ellipsis;
            	white-space:nowrap;
            }
            img{border:1px solid #ddd;border-radius:10px;}
        </style>
        <script>
          $(function() {
            $( "#sortable" ).sortable(
                {placeholder: "ui-state-highlight"}
            );
            $( "#sortable" ).disableSelection();
          });
        </script>
	  
        <script type="text/javascript">
            function deleteQuestion(target){
                $(target).parent().parent().remove();
            }
            function editQuestion(quesId,sheetId){
                BootstrapDialog.show({cssClass:'two-row-dialog',
                    message: $('<div></div>').load('<%=basePath%>checkquestion/goEdit?quesId='+quesId+'&sheetId='+sheetId),
                    title: '编辑题目'
                  });
            }
            //保存体检表
            function saveSheet(){
                //获取sheetid
                var sheetId = $("#id").val();
                //获取题目id
                var questions=$("[name='quesId']");//DOM对象数组
                var len = questions.length;
                var idArray = new Array();
                for(var i=0 ; i<len;i++){
                    idArray[i] = $(questions[i]).val();
                }
                var idsStr = idArray.join(",");
                //ajaxbao保存
                var ajaxObject = {};
                var url = 'checksheet/sortQuestion';
                var data = {sheetId:sheetId,idsStr:idsStr};
                $.ajax({
                    type: "POST",
                    url: url,
                    data: JSON.stringify(data),
                    dataType:'json',
                    contentType: "application/json;charset=UTF-8",
                    cache: false,
                    success: function(result){
                        //window.location.href ("checksheet/list.do");
                        window.location.reload();
                    },
                error: function(result){
                        window.location.reload();
                    }
                });
                return false;
            }

            var saveFlag=true;

            function goAddCheckQuestion(sheetId){
                BootstrapDialog.show({cssClass:'two-row-dialog',
                    message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCheckQuestion?sheetId'+sheetId+"&funcType=1"),
                    title: '添加体检题目'
                });
            }
            function goAddCollectQuestion(sheetId){
                BootstrapDialog.show({cssClass:'two-row-dialog',
                    message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCollectQuestion?sheetId'+sheetId),
                    title: '添加数据采集题目'
                });
            }
        </script>
	</head>
    <body>
    <%-- 	<form action="checksheet/${msg}.do" name="editForm" id="editForm" method="post"> --%>
	 	<input type="hidden" id="id" name="id" value="${entity.id}">
	 	<div id="sheetInfo" style="margin-left:30px;">
            <p>${entity.name}</p>
            <p>描述：${entity.description}</p>
            <span>最小预警值：${entity.min}</span>
            <span>最大预警值：${entity.max}</span>
            <div style="margin-top: 15px;">
                <%--<a class='btn btn-mini btn-info' title="添加题目" href="<%=basePath%>goAddSheetQuestion/${entity.id}">添加题目</a>--%>
                <a class='btn btn-mini btn-success' title="添加数据采集题目" onclick="goAddCollectQuestion(${entity.id})">添加数据采集题目</a>
                <button  class="btn btn-mini btn-primary" onclick="saveSheet()" >保存排序(及移除)</button>
                <a class='btn btn-mini btn-primary' title="返回上一页" href="<%=basePath%>checksheet/list.do">返回上一页</a>
            </div>
        </div>
	 	 <ul id="sortable">
 				<c:choose>
					<c:when test="${not empty entity.quesList}">
						<c:forEach items="${entity.quesList}" var="ques" varStatus="quesVs">
                            <li class="ui-state-default row" style="<c:if test='${ques.funcType==2}'>border-color:red;</c:if>">
                                <div class="col-md-4">
                                    <input type="hidden" name="quesId" value="${ques.id}">
                                    <input type="button" class="button btn btn-primary"  onclick="deleteQuestion(this)" value="移除">
                                    <input type="button" class="button btn btn-success"  onclick="editQuestion('${ques.id}','${entity.id}')" value="编辑">
                                    <span>${ques.seq}</span>
                                    <span>${ques.descriptionText}</span>
                                    <c:if test="${ques.descriptionImg != null && ques.descriptionImg != ''}">
                                    	<img style="width:100px;height:50px;" src="<%=basePath%>${ques.descriptionImg}"/>
                                    </c:if>
                                    <%-- <c:if test="${ques.contType == 0}"><span>${ques.description}</span></c:if>
                                    <c:if test="${ques.contType == 1}"><img style="width:100px;height:50px;" src="<%=basePath%>${ques.description}"/></c:if> --%>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty ques.optionList}">
                                        <div class="col-md-8">
                                            <c:forEach items="${ques.optionList}" var="option" varStatus="optionVs">
                                                <span style="margin-left:30px;">${optionVs.index+1}</span>
                                                <span>${option.descriptionText}</span>
                                                <c:if test="${option.descriptionImg != null && option.descriptionImg != ''}">
			                                    	<span><img style="width:100px;height:50px;" src="<%=basePath%>${option.descriptionImg}"/></span>
			                                    </c:if>
                                                <%-- <c:if test="${option.contType == 0}"><span>${option.description}</span></c:if>
                                                <c:if test="${option.contType == 1}"><img style="width:100px;height:50px;" src="<%=basePath%>${option.description}"/></c:if> --%>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li><span>没有题目，请录入题目</span> </li>
					</c:otherwise>
				</c:choose>
		</ul> 
<!-- 		
	</form> -->
</body>
</html>