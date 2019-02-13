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
    <title>体检报告详情</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="/phm/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="<%=basePath%>static/reportdetail/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath%>static/reportdetail/css/report.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>static/reportdetail/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>static/reportdetail/js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>static/reportdetail/js/jquery.jqprint-0.3.js"></script>
    <script type="text/javascript" src="<%=basePath%>static/reportdetail/js/main.js"></script>
    <script type="text/javascript" src="<%=basePath%>static/reportdetail/js/reports.js"></script>
</head>
<body>
  <div class="main">
      <div class="container-fluid" id="printBox">
          <div class="border pd2">
              <h2 class="text-center rtitle" id="reportTitle"></h2>
              <div class="row">
                  <div class="col-xs-9 col-md-9">
                      <div class="mtitle"><i class="icon icon-dian"></i>基本信息</div>
                  </div>
                  <div class="col-xs-3 col-md-3 text-right pdt6" id="btnTopBox">
                      <a href="javascript:;" class="mbtn mbtn-blue" id="btnTop" style="display: none"></a>
                      <!--<a href="javascript:;" class="mbtn mbtn-blue" id="btnPrint">打印</a>-->
                  </div>
              </div>
              <div class="row mt20">
                  <div class="col-xs-4 col-md-3">姓名：<span id="name"></span></div>
                  <div class="col-xs-4 col-md-3">手机：<span id="mobile"></span></div>
                  <div class="col-xs-4 col-md-3">性别：<span id="genderName"></span></div>
                  <div class="col-xs-4 col-md-3">年龄：<span id="age"></span></div>
                  <div class="col-xs-4 col-md-3">职业：<span id="career"></span></div>
                  <div class="col-xs-4 col-md-3">婚姻状况：<span id="maritalStatusName"></span></div>
                  <div class="col-xs-4 col-md-3">文化程度：<span id="degree"></span></div>
                  <div class="col-xs-4 col-md-3">所属：<span id="groupName"></span></div>
                  <div class="col-xs-4 col-md-3">科室：<span id="checkOfficeName"></span></div>
              </div>
              <div class="row mt20">
                  <div class="col-xs-6 col-md-6">套餐名称：<span id="checkPackageName"></span></div>
                  <div class="col-xs-6 col-md-6">医生：<span id="checkDoctorName"></span></div>
                  <div class="col-xs-6 col-md-6">干预卡号：<span id="treatCardNum"></span></div>
                  <div class="col-xs-6 col-md-6">体检卡号：<span id="checkCardNum"></span></div>
                  <div class="col-xs-6 col-md-6">检测时间：<span id="checkTime"></span></div>
                  <div class="col-xs-6 col-md-6">报告时间：<span id="reportTime"></span></div>
              </div>
          </div>
          <div class="mt20">
              <div id="listBox">
              </div>
              <div class="text-right mt20" id="doctorSignUrl"></div>
          </div>
      </div>
  </div>
    <div style="width:100%;position: fixed;bottom: 10px;text-align: center;">
        <a class="btn btn-small btn-primary" title="返回上一页" href="javascript:history.back();">返回上一页</a>
    </div>
</body>
<script>
    var reportId = '${reportId}';
    var sheetId = '';//每套题目ID
    var sheetNum = 0;//几套题目
    $(function(){
        reportDetail(reportId);
        //返回
        $("#back").click(function () {
            history.back();
        })
        $("#btnTop").click(function () {
            if($(this).text() == "确认审核"){//确认审核
                var reportIds = [];
                reportIds.push(reportId);
                reportCheck(reportIds);
            }
            if($(this).text() == "打印"){//打印
                //保存为图片打印
                for(var i = 0; i<sheetNum; i++){
                    $("#chartImg_"+i).show();
                    $("#chart_"+i).hide();
                }
                //打印预览
                $("#printBox").jqprint();
            }
        })
    })
</script>
</html>
