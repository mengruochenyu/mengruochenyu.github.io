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
		<%@ include file="../system/admin/top.jsp"%> 
	
	<style type="text/css">
		.table-bordered td, .table-bordered th {
			border: 1px solid #ddd;
		}
		
		.table_th{
			border: 1px solid #ddd;
			font-size: 14px;
			font-weight: bold;
			text-align: center;
		}
		

		.table td, .table th {
			padding: 8px;
			line-height: 1.53846154;
			vertical-align: top;
			border-bottom: 1px solid #ddd;
			-webkit-transition: background .3s cubic-bezier(.175,.885,.32,1);
			-o-transition: background .3s cubic-bezier(.175,.885,.32,1);
			transition: background .3s cubic-bezier(.175,.885,.32,1);
		}
		
		.text-right{
			text-align:right;
			font-size: 14px;
		}
		
		.w-150px{
			width: 200px;
		}

		.group-item {
			display: block;
			width: 120px;
			float: left;
			font-size: 14px;
		}
	</style>
		
<script type="text/javascript">
	
	//保存
	function save(target){
		var actionArray = [];
		$('input:checkbox').each(function() { 
		    if($(this).prop('checked')) {
		    	var value = $(this).val();
		    	if(value != "on"){
					actionArray.push($(this).val());
		    	}
			}
		});
		
		var currentUrl = window.location.href;
		var roleId = currentUrl.substring(currentUrl.lastIndexOf("/") + 1);
		
		var url = 'menuaction/changeRights';
		var data = {roleId:roleId, actionIdList:actionArray};
		
		var ajaxObject = {};
	    ajaxObject.url = url;
	    ajaxObject.data = data;
	    ajaxObject.success = function(result){
	    	bootbox.alert("保存成功");
	    }
		
	    ajaxPost(ajaxObject);
	    
	    return false;
	}
	
	$(document).ready(function(){ 
		$("input.menu_item").click(function(){
			var selected = $(this).is(":checked");
			var currentId = this.id;
			$("input." + currentId).prop("checked",selected);
		}) 
	});
	
	function pageBack(){
		history.back();
	}
	 
	
</script>
	</head>
<body>
	<form action="menuaction/changeRights" name="Form" id="Form" method="post" >
		<input type="hidden" name="roldId" id="roldId" value="${roldId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table class="table table-hover table-striped table-bordered table-form" style="width:900px;margin-left:50px;"> 
		    <thead>
		      <tr>
		        <th class="table_th">菜单名称</th>
		        <th class="table_th">动作</th>
		      </tr>
		    </thead>
		    <tbody>
	    		<c:forEach items="${varList}" var="menu" varStatus="vs">
			    	<tr class="bg-gray">
			      		<th class="text-right w-150px">${menu.menuName}
				  		<input type="checkbox" id="menu_${menu.menuId}" class="menu_item"></th>
			      		<td id="product" class="pv-10px">
			      			<c:forEach items="${menu.list}" var="menuAction" varStatus="action">
								<div class="group-item">
						          <input type="checkbox" class="menu_${menu.menuId}" value="${menuAction.menuActionId}"
						          	<c:if test="${menuAction.selected}">checked</c:if>
						          >
						          <span class="priv">${menuAction.menuActionName}</span>
						        </div>
					        </c:forEach>
			            </td>
			    	</tr>
		    	</c:forEach>
		    	
		    	<tr>
					<td style="text-align: center;" colspan="3" >
						<a id="saveBtn" class="btn btn-secondary" style="width:100px" onclick="save(this);">保存</a>
						<a id="backBtn" class="btn btn-secondary" style="width:100px" onclick="pageBack();">返回</a>
					</td>
				</tr>
		    </tbody>
		</table>
	</form>
</body>
</html>