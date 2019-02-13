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
					actionArray.push(value);
		    	}
			}
		});
		
		var url = 'menuaction/setting/${menuId}';
		var data = actionArray;
		
		var ajaxObject = {};
	    ajaxObject.url = url;
	    ajaxObject.data = data;
	    ajaxObject.success = function(result){
	    	BootstrapDialog.alert('保存成功');
	    }
		
	    ajaxPost(ajaxObject);
	    
	    return false;
	}
	
	
</script>
	</head>
<body>
	<form action="menuaction/setting" name="Form" id="Form" method="post" >
		<input type="hidden" name="menuId" id="menuId" value="${menuId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table class="table table-hover table-striped table-bordered table-form" style="width:500px;margin-left:20px;"> 
		    <tbody>
		    	<tr class="bg-gray">
		      		<td id="product" class="pv-10px">
		      			<c:forEach items="${varList}" var="menuAction" varStatus="action">
							<div class="group-item">
					          <input type="checkbox" class="menu_${menuAction.menuActionCode}" value="${menuAction.menuActionCode}"
					          	<c:if test="${menuAction.selected}">checked</c:if>
					          >
					          <span class="priv">${menuAction.menuActionName}</span>
					        </div>
				        </c:forEach>
		            </td>
		    	</tr>
		    	
		    	<tr>
					<td style="text-align: center;" colspan="3" >
						<a id="saveBtn" class="btn btn-secondary" style="width:100px" onclick="save(this);">保存</a>
					</td>
				</tr>
		    </tbody>
		</table>
	</form>
</body>
</html>