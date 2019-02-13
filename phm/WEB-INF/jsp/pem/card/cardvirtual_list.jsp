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
            <b>${hospital.name}</b>虚拟卡列表
			<!-- 检索  -->
			<form action="cardvirtual/list.do" method="post" name="Form" id="Form">
                <input type="hidden" value="${hospital.id}" name="hospitalId"/>
			<table>
				<tr>
                    <td>
                        <span class="input-icon">
                            <input autocomplete="off" id="nav-search-input" type="text" name="card_num" value="${pd.card_num}" placeholder="卡号" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                    </td>
                    <td>
                        <span class="input-icon">
                            <input autocomplete="off" type="text" name="patient_item_name" value="${pd.patient_item_name}" placeholder="用户姓名" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                    </td>
                    <td>
                        <select id="status" name="status">
                            <option value="-1">卡片状态</option>
                            <option value="1" <c:if test="${pd.status==1}">selected</c:if>>未检测</option>
                            <option value="2" <c:if test="${pd.status==2}">selected</c:if>>已检测</option>
                        </select>
                    </td>
                    <td><input class="span10 date-picker" name="create_time_start" id="create_time_start" value="${pd.create_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建时间开始"/></td>
                    <td><input class="span10 date-picker" name="create_time_end" id="create_time_end" value="${pd.create_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建时间结束"/></td>
                    <td><input class="span10 date-picker" name="check_time_start" id="check_time_start" value="${pd.check_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="检测时间开始"/></td>
                    <td><input class="span10 date-picker" name="check_time_end" id="check_time_end" value="${pd.check_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="检测时间结束"/></td>
                    <td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->

			<table id="table_report" class="table table-hover">
				
				<thead>
					<tr>
						<th>序号</th>
						<th>编号</th>
						<th>医院</th>
						<th>状态</th>
						<th>科室</th>
						<th>关联用户</th>
						<th>创建时间</th>
						<th>检测时间</th>
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
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td>${var.num}</td>
                                <td>${var.hospitalName}</td>
                                <td>${var.statusName}</td>
                                <td>${var.officeName}</td>
                                <td>${var.patientItemName}</td>
                                <td>${var.activeTime}</td>
                                <td>${var.checkTime}</td>
							</tr>
						</c:forEach>
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
                    <a href="<%=basePath%>hospital/list/card.do?batchType=${batchType}" class="btn btn-small btn-primary" title="返回医院列表">返回医院列表</a>
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
	
	//检索
	function search(){
		top.jzts();
		$("#Form").submit();
	}
	
	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>cardvirtual/goAdd.do'),
            title: '新增'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>cardvirtual/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>cardvirtual/delete/"+id;
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
		var url = '<%=basePath%>cardvirtual/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>