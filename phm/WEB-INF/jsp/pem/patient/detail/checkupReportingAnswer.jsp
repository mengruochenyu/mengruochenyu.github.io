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
  <meta charset="utf-8">
  <title>体检报告答题详情</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link href="/phm/favicon.ico" rel="shortcut icon" type="image/x-icon" />
  <link href="<%=basePath%>static/reportdetail/css/bootstrap.min.css" type="text/css" rel="stylesheet">
  <link href="<%=basePath%>static/reportdetail/css/report.css" type="text/css" rel="stylesheet">
</head>
<body>
  <div class="main main3">
      <div class="answer-top" id="topic" style="min-height: 60px">
          <!--<a href="javascript:;" class="mbtn mbtn-radius-big mbtn-blue">1~9</a>-->
      </div>
      <div class="container-fluid">
          <div class="row" id="answer">
              <!--<div class="col-xs-4 col-md-4 border-right-bottom">
                  <div class="pd5">
                      <p>1.您平时走路先抬左脚还是右脚</p>
                      <p>1.您平时走路先抬左脚还是右脚</p>
                      <p class="blue">答案：右脚</p>
                  </div>
              </div>-->
          </div>
          <div class="clearfix">
              <div class="pages mt20">
                  <div class="M-box"></div>
              </div>
          </div>
      </div>
  </div>
  <div style="width:100%;position: fixed;bottom: 10px;text-align: center;">
      <a class="btn btn-small btn-primary" title="返回上一页" href="javascript:history.back();">返回上一页</a>
  </div>
<script type="text/javascript" src="<%=basePath%>static/reportdetail/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/reportdetail/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/reportdetail/js/jquery.pagination.js"></script>
<script type="text/javascript" src="<%=basePath%>static/reportdetail/js/main.js"></script>
<script type="text/javascript" src="<%=basePath%>static/reportdetail/js/reports.js"></script>
<script>
    var sheetReportId = '${sheetReportId}';
    var pageNum = 1;
    var pageSize = 15;
    $(function(){
        answerList(sheetReportId,pageNum,pageSize);
    })
</script>
</body>
</html>
