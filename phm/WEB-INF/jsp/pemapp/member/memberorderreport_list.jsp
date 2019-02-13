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
			<form action="memberorder/report/list.do" method="post" name="Form" id="Form">
			<table>
				<tr><td><span class="">
						 	 <select id="query_key_status" name="query_key_status">
						 	 	<option value="" >--按订单状态筛选--</option>
                                 <c:forEach items="${statuslist}" var="status" varStatus="vs">
                        	       		<option value="${status.key }" <c:if test="${status.key == pd.query_key_status }">selected</c:if>>${status.value}</option>
                               	</c:forEach>
                             </select>
					</span></td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_report_number" value="${pd.query_key_report_number}" placeholder="按报告编号检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_number" value="${pd.query_key_number}" placeholder="按订单号检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_member_name" value="${pd.query_key_member_name}" placeholder="按用户姓名检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
							<input type="hidden" name="query_key_member_id" id="query_key_member_id" value="${pd.query_key_member_id}"/>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_doctor_name" value="${pd.query_key_doctor_name}" placeholder="按照医生姓名检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
							<input type="hidden" name="query_key_doctor_id" id="query_key_doctor_id" value="${pd.query_key_doctor_id}"/>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_package_name" value="${pd.query_key_package_name}" placeholder="按照套餐名称检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_sheet_name_str" value="${pd.query_key_sheet_name_str}" placeholder="按照套餐组成检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_pay_account" value="${pd.query_key_pay_account}" placeholder="按照支付账号检索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<%-- <td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key" value="${pd.query_key}" placeholder="这里输入关键词" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td> --%>
					<td><input class="span10 date-picker" name="query_time_start" id="query_time_start" value="${pd.query_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td><input class="span10 date-picker" name="query_time_end" id="query_time_end" value="${pd.query_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-hover">
				<thead>
					<tr><th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>报告编号</th>
						<th>订单编号</th>
						<th>用户</th>
						<th>医生</th>
						<th>套餐构成</th>
						<th>支付账号</th>
						<th>审核时间</th>
						<th>报告详情</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${orderList == null}">
				    	<tr class="main_info">
							<td colspan="100" class="center" >请输入搜索条件</td>
						</tr>
					</c:when>
					<c:when test="${not empty orderList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${orderList}" var="var" varStatus="vs">
							<tr><td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td style="max-width:88px;">${var.reportNumber}</td>
                                <td style="max-width:88px;">${var.number}</td>
                                <td>${var.memberName}</td>
                                <td>${var.doctorName}</td>
                                <td>${var.packageName}</td>
                                <td>${var.payAccount}</td>
                                <td>${var.auditTime}</td>
                                <td><a href="http://118.178.182.6/doctor/reportDetailBack.html?rId=${var.patientItemId }&from=1" target="_blank">查看报告详情</a></td><!-- reportId -->
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr><td colspan="100" class="center">您无权查看</td></tr>
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
			<tr><td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
						<!-- <a class="btn btn-small btn-success" onclick="add();">新增</a> -->
						<a class="btn btn-small btn-success" onclick="exportList();">导出</a>
					</c:if>
					<c:if test="${QX.del == 1 }">
						<!-- <a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a> -->
					</c:if>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
		<form action="<%=basePath%>memberorder/export" id="download" style="display: none">
			<input type="text"  id ="idsStr" name ="idsStr" value="" >
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
	//导出列表
	function exportList(){
		var idsTarget = $("input[name='ids']:checked");
		var ids = '';
		$("input[name='ids']:checked").each(function(){
			ids = ids + ',' + $(this).val(); 
	    }); 
		ids = ids.substring(1);
		url = "memberorder/exportExcel";
	    if(ids==''){
	        bootbox.alert("您还没有选择任何内容");
	        return;
	    }
		bootbox.confirm('确定要导出选中的数据吗?', function(result) {
			if(result) {
				console.log("确定要导出选中的数据吗");
				console.log($("#idsStr").val(ids));
				$("#idsStr").val(ids);
				$("#download").submit();
			}
		}); 
	}
	//修改
	function edit(id){
       var url = '<%=basePath%>memberorder/refund/'+id;
       bootbox.confirm('确定要此操作吗？', function(result) {
		if(result) { //点击确定以后的操作
            var ajaxObject = {};
            ajaxObject.url = url;
        	ajaxObject.data = null;
        	ajaxObject.success = function(result){
        		bootbox.confirm('操作成功', function(result) {
        			if (result) {
        				location.reload();
					}
        		});
        	};
        	ajaxObject.fail = function(result){
        		 bootbox.alert("操作失败");
        	};
        	ajaxPost(ajaxObject);
		}
	   });
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
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>