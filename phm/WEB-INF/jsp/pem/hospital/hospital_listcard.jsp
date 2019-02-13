<%@page import="com.blue.pem.common.HospitalAccountRoleEnum"%>
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
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="hospital/list/card.do?batchType=${pd.batchType}" method="post" name="Form" id="Form">
			<table>
				<tr>
				     <td>
                        <span >
                            <select name = "query_type">
                                <option <c:if test="${var.type==1} ">selected</c:if> value = "1">医院</option>
                                <option <c:if test="${var.type==2} ">selected</c:if>  value = "2">运营商</option>
                            </select>
                        </span>
                    </td>
                    <td>
                        <span class="input-icon">
                            <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="医院名称" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                    </td>
                    
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
                </tr>
			</table>
			<!-- 检索  -->

			<table id="table_report" class="table table-hover" style="white-space: nowrap;">
				<thead>
					<tr>
                        <th style="width: 35px;">序号</th>
						<th>医院名称</th>
						<th>地址省</th>
						<th>地址市</th>
						<th>地址区县</th>
						<th>地址详情</th>
						<th>医院状态</th>
					</tr>
				</thead>

				<tbody>

				<!-- 开始循环 -->
				<c:choose>
					<c:when test="${varList == null}">
				    	<tr class="main_info">
							<td colspan="100" class="center" >请输入搜索条件</td>
						</tr>
					</c:when>
					<c:when test="${not empty varList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
                                <td>${vs.index+1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${pd.batchType==0}">
                                            <a href="<%=basePath%>cardvirtual/list.do?hospitalId=${var.id}">${var.name}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<%=basePath%>cardbatch/list.do?batchType=${pd.batchType}&hospitalId=${var.id}">${var.name}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${var.addressProv}</td>
                                <td>${var.addressCity}</td>
                                <td>${var.addressCounty}</td>
                                <td>${var.addressDetail}</td>
                                <td>${var.getStatusDesc()}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
<script type="text/javascript">
		
	$(top.hangge());

	//去医院人事结构页面
	function goHospitalTree(hospitalId){
        <%--location.href="<%=basePath%>"+"hospital/tree/"+hospitalId;--%>
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load("<%=basePath%>"+"hospital/tree/"+hospitalId),
            title: '医院人事结构'
        });
    }

	//检索
	function search(){
		top.jzts();
		$("#Form").submit();
	}
	
	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>hospital/goAdd.do'),
            title: '新增'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>hospital/goEdit/'+id),
            title: '编辑'
          });
	}
	//禁用解禁
	function editSatus(id,status){
		var newStatus = 0;//默认是禁用
		var descStr = "您确定要禁用该医院吗?";
		if(status == 0){
			newStatus = 1;//如果原来状态是禁用，则解禁
			descStr = "您确定要解禁该医院吗?";
		}		
		console.log(id+"----"+status);
		var url = "<%=basePath%>hospital/editStatus/"+id+"/"+newStatus;
		bootbox.confirm(descStr, function(result) {
			if(!result){return;}
 		    $.ajax({
		        type: "POST",
		        url: url,
		        dataType:'json',
		        contentType: "application/json;charset=UTF-8",
		        cache: false,
		        success: function(result){
		            	location.reload();
		        },
		        error: function(result){
		        	location.reload();
		        }
		    }); 
		});   
	}
	//删除
	function del(id){
		var url = "<%=basePath%>hospital/delete/"+id;
		ajaxDelete(url);
	}
		
</script>
		
<script type="text/javascript">
		
	$(function() {
		
		//下拉框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		//日期框
		$('.date-picker').datepicker();
		
		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
				
		});
		
	});
	
	//批量操作
	function makeAll(){
		var url = '<%=basePath%>hospital/deleteBatch';
		ajaxDeleteBatch(url);
	}
	//修改密码
	function editPassword(){
		var items=$("[name='ids']:checked");//DOM对象数组
		if(items.length !=1){
			alert("请选择一个用户！");
			return false;
		}
		var accountName = $(items[0]).attr("account-name");
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>hospitalaccount/goEditPassword/'+accountName),
            title: '修改密码'
          });
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>