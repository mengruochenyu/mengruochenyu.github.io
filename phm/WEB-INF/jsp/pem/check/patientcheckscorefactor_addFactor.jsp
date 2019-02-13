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
	  #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; cursor: pointer; }
	  #sortable li { background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px;}
	  #sortable li span {}
	  #sortable li .deleteQuestion {background:#438eb9;color:#ffffff;border-radius:4px;border:2px black; width:60px; height:30px;}
	  .btn-small {padding: 6px 20px;border:0;border-radius:4px;color:#ffffff;line-height: 24px;font-size: 14px;background-color: #87B87F !important;}
	  .ui-state-highlight{background:#ffffff;margin: 5px 3px 3px 0; padding: 0.4em;  font-size: 14px;height:30px; }
	  </style>
 <script>
 </script>	 
	  
<script type="text/javascript">

	//保存体检表
	function saveSheet(){
		if($("#name").val()==""){
			bootbox.alert('请输入因子名称');
			return false;
		}		
		if($("#sumScore").val()==""){
			bootbox.alert('请输入分数');
			return false;
		}		
		if($("#remark").val()==""){
			bootbox.alert('请输入评语');
			return false;
		}		
		var quesIdArr = new Array();
		var optionIdArr = new Array();
		//regroup dada
		$("input[class=checkBox]:checked").each(function(){
			var quesId = $(this).attr("data-ques-id");
			quesIdArr.push(quesId);
			var optionId = $(this).attr("data-option-id");
			optionIdArr.push(optionId);
		})
		//judge empty data for option
		if(quesIdArr.length == 0){
			bootbox.alert("请至少选择一个选项！");
			return false;
		}
		var quesIdStr = quesIdArr.join(",");
		var optionIdStr = optionIdArr.join(",");

		var id = $("#id").val();
		var sheetId = $("#sheetId").val();
		var name = $("#name").val();
		var score = $("#score").val();
		var remark = $("#remark").val();
		var action = '${msg}';
	 	var url = 'patientcheckscorefactor/'+action; 
		var data = {
				id:id,
				sheetId:sheetId,
				name:name,
				score:score,
				remark:remark,
				questionIdStr:quesIdStr,
				optionIdStr:optionIdStr
			};
	    $.ajax({
	        type: "POST",
	        url: url,
	        data: JSON.stringify(data),
	        dataType:'json',
	        contentType: "application/json;charset=UTF-8",
	        cache: false,
	        success: function(result){
	        	bootbox.alert(result.msg);
	        	if(result.code == 200){
	        		location.reload();
	        	}
	        	
	        },
	        error: function(result){
	        	 bootbox.alert("保存失败");
	        	location.reload();
	        }
	    });
	    return false;
	}
</script>
	</head>
<body>
<div class="container">
<button  class="btn btn-primary" onclick="reload()" >刷新</button>	  	
<button  class="btn btn-primary" onclick="showFactor('${entity.id}')" >查看因子</button>	  	
 	<form action="patientcheckscorefactor/${msg}.do" name="editForm" id="editForm" method="post">
	 	<input type="hidden"  id="id" name="id" value="${factor.id}">
	 	<input type="hidden"  id="sheetId" name="sheetId" value="${entity.id}">
	 	<input type="hidden" id="questionIdStr" name="questionIdStr">
	 	<input type="hidden" id="optionIdStr" name="optionIdStr">
 		<p>添加因子分析</p>
	 	<h2>${entity.name}</h2>
 	  <div class="form-group">
	    <label >因子名称</label>
	    <input type="text" name="name" id="name" value="${factor.name}"placeholder="请输入因子名称"  >
	  </div>
	  <div class="form-group">
	    <label >评分</label>
	    <input type="text" name="score" id="score" value="${factor.score}" placeholder="请输入分数">
	  </div>
	 	<div>
		<textarea class="form-control" rows="3" name="remark" id="remark"  placeholder="请输入评语">${factor.remark}</textarea>
	 	</div>	

	 	 <ul id="sortable">	 	 
 				<c:choose>
					<c:when test="${not empty entity.quesList}">
						<c:forEach items="${entity.quesList}" var="ques" varStatus="quesVs">
							  <li class="row ui-state-default">
								  	<input type="hidden" value="${ques.id}">
								  	<div class="col-md-4">
									  	<span>${ques.seq}</span> 
									  	<c:if test="${ques.contType == 0}">
 										  	<span>${ques.description}</span> 
									  	</c:if>
									  	<c:if test="${ques.contType == 1}">
 										  	<span><img style="width:100px;height:50px;" src="<%=basePath%>${ques.description}"/></span> 
									  	</c:if>

								  	</div>
								  	<div class="col-md-8">
				  	 				<c:choose>
									<c:when test="${not empty ques.optionList}">
									  	<c:forEach items="${ques.optionList}" var="option" varStatus="optionVs">
									  		<input type="checkbox"  class="checkBox" data-ques-id="${ques.id}" data-option-id="${option.id}">
									  		<span>${optionVs.index+1}</span> 
										  	<c:if test="${option.contType == 0}">
	  										  		<span style="margin-right:20px;">${option.description}</span> 
										  	</c:if>
										  	<c:if test="${option.contType == 1}">
										  			<span><img style="width:100px;height:50px;" src="<%=basePath%>${option.description}"/></span> 
										  	</c:if>
									  	</c:forEach>
									</c:when>
									</c:choose>	  	
								  	</div>
							  </li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li><span>没有题目，请录入题目</span> </li>
					</c:otherwise>
				</c:choose>
		</ul> 
		<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="saveSheet();">保存</a>
	 	 <!-- <button  class="btn btn-small btn-success" onclick="saveSheet()" >保存</button>	 -->
	</form>
</div>

<script type="text/javascript">
$(function(){
	$(".checkBox").change(function(){
		//alert(1);
		if($(this).is(':checked')) {
			//alert(2);
			//var quesId = $(this).attr("data-ques-id");
			//alert("quesId--"+quesId);
			//$(this).parent().children("input").attr("checked",false);
			//$("input[data-ques-id= $(this).attr("data-ques-id")]").attr("checked",false);
			//$(this).attr("checked","true");
			//$(this).css("checked","checked");
		}
	})
	
})
	//刷新
	function reload(){
		location.reload();	
	}
	//添加因子
	function showFactor(sheetId){
		location.href = '<%=basePath%>patientcheckscorefactor/goShowFactor/'+sheetId;
	}
</script>
</body>
</html>