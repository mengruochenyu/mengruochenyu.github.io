<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
</head>
<body>
    <div style="width: 100%;text-align: center;margin-top: 30px;">
        <a class='btn btn-lg btn-primary' title="添加体检题目" onclick="goAddCheckQuestion(${checkSheet.id})">添加体检题目</a>
    </div>
    <div style="width: 100%;text-align: center;margin-top: 30px;margin-bottom: 30px;">
        <a class='btn btn-lg btn-primary' title="添加数据采集题目" onclick="goAddCollectQuestion(${checkSheet.id})">添加数据采集题目</a>
    </div>
</body>

<script>
    function goAddCheckQuestion(sheetId){
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCheckQuestion/'+sheetId),
            title: '添加体检题目'
        });
    }
    function goAddCollectQuestion(sheetId){
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCollectQuestion/'+sheetId),
            title: '添加数据采集题目'
        });
    }
</script>
</html>
