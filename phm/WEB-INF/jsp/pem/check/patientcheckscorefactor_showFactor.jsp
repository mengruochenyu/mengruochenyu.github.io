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
	  <script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
	  <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	  <link rel="stylesheet" href="jqueryui/style.css">
	  <style>
	  body{margin:10px 50px;}
	  #sortable { list-style-type: none; margin: 0; padding: 0; width: 90%; cursor: pointer; }
	  #sortable li { background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px; }
	  #sortable li span {}
	  #sortable li .deleteQuestion {background:#438eb9;color:#ffffff;border-radius:4px;border:2px black; width:60px; height:30px;}
	  .btn-small {padding: 6px 20px;border:0;border-radius:4px;color:#ffffff;line-height: 24px;font-size: 14px;background-color: #87B87F !important;}
	  .ui-state-highlight{background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px;height:30px; }
	  </style>
 <script>
 </script>	 
	  
<script type="text/javascript">

</script>
</head>
<body>
<div class="container-fluid">
<button  class="btn btn-primary" onclick="reload()" >刷新</button>	  	
<button  class="btn btn-primary" onclick="addFactor('${entity.id}')" >添加因子</button>	  	
<h3>《${entity.name}》因子分析列表</h3>
<c:choose>
<c:when test="${not empty factorList}">
	<c:forEach items="${factorList}" var="factor" varStatus="factorListVs">
		 <div>
		 	<div>${factorListVs.index+1}</div>
			<div>名称：${factor.name}</div> 
		  	<div>分数：${factor.score}</div> 
		  	<p>评语：${factor.remark}</p> 
				<c:choose>
			<c:when test="${not empty factor.quesList}">
			  	<c:forEach items="${factor.quesList}" var="ques" varStatus="quesVs">
			  		<div>
					  	<c:if test="${ques.contType == 0}">
	  					  		<span class="col-md-4">题目：${ques.quesContent}</span> 
					  	</c:if>
					  	<c:if test="${ques.contType == 1}">
	  					  		<span class="col-md-4">题目：<img style="width:100px;height:50px;" src="<%=basePath%>ques.quesContent"/></span> 
					  	</c:if>
					  	<c:if test="${ques.optionType == 0}">
  						  		<span>选项：${ques.optionContent}</span>  
					  	</c:if>
					  	<c:if test="${ques.optionType == 1}">
	  					  		<span class="col-md-4">题目：<img style="width:100px;height:50px;" src="<%=basePath%>ques.optionContent"/></span> 
					  	</c:if>


			  		</div>
			  	</c:forEach>
			</c:when>
			</c:choose>	
			<button  class="btn btn-small btn-success" onclick="edit('${factor.id}')" >编辑</button>	  	
			<button  class="btn btn-small btn-success" onclick="del('${factor.id}')" >删除</button>	  	
		 </div> 
		 <hr>
	</c:forEach>
</c:when>
</c:choose>
</div>

<script type="text/javascript">
	//删除
	function del(id){
		var url = "<%=basePath%>patientcheckscorefactor/delete/"+id;
		ajaxDelete(url);
	}
	//编辑因子
	function edit(factorId){
		//var sheetId = $(sheets[0]).val();
		location.href = '<%=basePath%>patientcheckscorefactor/goEditFactor/'+factorId;
	}
	//刷新
	function reload(){
		location.reload();	
	}
	//添加因子
	function addFactor(sheetId){
		location.href = '<%=basePath%>patientcheckscorefactor/goAddFactor/'+sheetId;
	}
</script>
</body>
</html>