<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			<form action="patientcheckdatacollection/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key" value="${pd.query_key}" placeholder="这里输入关键词" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><input class="span10 date-picker" name="query_time_start" id="query_time_start" value="${pd.query_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td><input class="span10 date-picker" name="query_time_end" id="query_time_end" value="${pd.query_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-hover"  style="white-space: nowrap;">
				
				<thead>
					<tr>
						<th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>体检用户ID</th>
						<th>体检用户名称</th>
						<th>团体名称</th>
						<th>手机号</th>
						<th>生日</th>
						<th>学历</th>
						<th>职业</th>
						<th>未婚/已婚</th>
						<th>问题描述</th>
						<th>选项描述</th>
						<th>量表名称</th>
						<th>量表总分</th>
						<th>因子分数</th>
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
                                <td>${var.patientItemId}</td>
                                <td>${var.name}</td>
                                <td>${var.groupName}</td>
                                <td>${var.mobile}</td>
                                <td>${var.birthday}</td>
                                <td>${var.degree}</td>
                                <td>${var.career}</td>
                                <td>
                                    <c:if test="${var.maritalStatus==0}">未婚</c:if>
                                    <c:if test="${var.maritalStatus==1}">已婚</c:if>
                                </td>
                                <td>
                                    <c:if test="${var.contType==0}">
                                        <c:if test="${fn:length(var.questionDesc)>10}">
                                            <%request.setAttribute("enter","\r\n");%>
                                            ${fn:substring(var.questionDesc,0,10)}...<a onclick='javascript:bootbox.alert("${fn:replace(var.questionDesc,enter,'')}");' style="text-decoration: none;cursor: pointer;">详情</a>
                                        </c:if>
                                        <c:if test="${fn:length(var.questionDesc)<=10}">
                                            ${var.questionDesc}
                                        </c:if>
                                    </c:if>
                                    <c:if test="${var.contType==1}">
                                        <img src="<%=basePath%>${var.questionDesc}" style="max-width: 180px;max-height: 120px;">
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${var.contType==0}">
                                        ${var.patientOptionDesc}
                                    </c:if>
                                    <c:if test="${var.contType==1}">
                                        <c:set value="${ fn:split(var.patientOptionDesc, ',')}" var="patientOptionDescArr"/>
                                        <c:forEach items="${patientOptionDescArr}" var="patientOptionDesc" varStatus="vs">
                                            <img src="<%=basePath%>${patientOptionDesc}" style="vertical-align:middle;max-width: 180px;max-height: 120px;">
                                        </c:forEach>
                                    </c:if>
                                </td>
                                <td>${var.checkSheetName}</td>
                                <td>${var.sheetSumScore}</td>
                                <td>
                                    <c:if test="${var.factorScores==null or var.factorScores==''}">无</c:if>
                                    <c:if test="${var.factorScores!=null and var.factorScores!=''}">${var.factorScores}</c:if>
                                </td>
								<td style="width: 70px;" class="center">
									<div>
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
											</c:if>
											<c:if test="${QX.del == 1 }">
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>
											</c:if>
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
					<c:if test="${QX.add == 1 }">
					</c:if>
					<c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a>
					</c:if>
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
            message: $('<div></div>').load('<%=basePath%>patientcheckdatacollection/goAdd.do'),
            title: '新增'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientcheckdatacollection/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>patientcheckdatacollection/delete/"+id;
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
		var url = '<%=basePath%>patientcheckdatacollection/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>