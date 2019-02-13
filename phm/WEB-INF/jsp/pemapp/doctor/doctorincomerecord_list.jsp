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
<script type="text/javascript">
$(function(){
	SELECT_LIST.getDoctorSelect("doctor-selector", "${pd.query_doctor_id}");
})
</script>
</head>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="doctorincomerecord/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key" value="${pd.query_key}" placeholder="搜索	医生姓名/手机号" title="输入医生姓名/手机号码搜索" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<%-- <td>
                        <span class="input-icon">
                            <select id="doctor-selector" name="query_doctor_id" value="${pd.query_doctor_id}" >
                                <option value="">请选择医生</option>
                            </select>
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
					<tr>
						<th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>医生姓名</th>
						<th>订单编号</th>
						<th>金额</th>
						<th>收益时间</th>
						<!-- <th>检测用户</th> -->
						<th>操作</th>
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
								<td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td>${var.doctorName}</td>
                                <td>${var.orderNumber}</td>
                                <td>${var.amount}</td>
                                <td>${var.incomeTime}</td>
                                <%-- <td>${var.memberId}</td> --%>
								<td style="width: 70px;" class="center">
									<div>
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' title="查看" onclick="edit('${var.id}');"><i class="fa fa-edit"></i></a>
											</c:if>
											<%-- <c:if test="${QX.del == 1 }">
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>
											</c:if> --%>
										</div>
									</div>
								</td>
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
					<%-- <c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if> --%>
					<a class="btn btn-small btn-success" onclick="exportList();">导出</a>
					
					<%-- <c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a>
					</c:if> --%>
				</td>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
		</form>
		<form action="<%=basePath%>doctorincomerecord/export" id="download" style="display: none">
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
	
	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctorincomerecord/goAdd.do'),
            title: '新增'
          });
	}
	
	//导出列表
	function exportList(){
		var idsTarget = $("input[name='ids']:checked");
		var ids = '';
		$("input[name='ids']:checked").each(function(){ 
			ids = ids + ',' + $(this).val(); 
	    }); 
		ids = ids.substring(1);
		url = "doctorincomerecord/export";
	    if(ids==''){
	        bootbox.alert("您还没有选择任何内容");
	        return;
	    }
		bootbox.confirm('确定要导出选中的数据吗?', function(result) {
			if(result) {
				$("#idsStr").val(ids);
				$("#download").submit();
			}
		}); 
		
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctorincomerecord/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>doctorincomerecord/delete/"+id;
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
		var url = '<%=basePath%>doctorincomerecord/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>