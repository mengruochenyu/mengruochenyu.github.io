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
			<form action="patientgroup/groupList.do" method="post" name="Form" id="Form">
			<table>
				<tr>
						<td style="width:100px;">
							<span class="">
								<input autocomplete="off" id="nav-search-input" type="text" name="group_name" value="${pd.group_name}" placeholder="团队名称" />
							</span>
						</td>
						<td style="width:100px;">
							<span class="">
								<select name="hospital_name" id="hospital_name">
									<option value="">选择医院</option>
									<c:choose>
										<c:when test="${not empty hospitalList}">
											<c:forEach items="${hospitalList}" var="hospital">
												<option value="${hospital.name}">${hospital.name}</option>
											 </c:forEach>								
										</c:when>	
									</c:choose>
								</select>
							</span>
						</td>
						<td style="width:100px;">
							<span class="input-icon">
								<select name="hospital_office_name" id="hospital_office_name">
									<option value="">选择科室</option>
									<c:choose>
										<c:when test="${not empty officeList}">
											<c:forEach items="${officeList}" var="office">
												<option value="${office.name}">${office.name}</option>
											 </c:forEach>								
										</c:when>	
									</c:choose>
								</select>
							</span>
						</td>
						<td style="width:250px;">
							<label class="" style="border:1px solid #CDC9C9">
								<span>人数筛选</span>
								<input autocomplete="off"  style="width:75px" type="number" name="min_num" value="${pd.min_num}" />
								<span>-</span>
								<input autocomplete="off"  style="width:75px" type="number" name="max_num" value="${pd.max_num}"/>
							</label>
						</td>
					<td><input class="span10 date-picker" name="query_time_start" id="query_time_start" value="${pd.query_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建开始日期"/></td>
					<td><input class="span10 date-picker" name="query_time_end" id="query_time_end" value="${pd.query_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建结束日期"/></td>
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
						<th>团队ID</th>
						<th>团队名称</th>
						<th>医院名称</th>
						<th>科室名称</th>
						<th>创建日期</th>
						<th>全部人数</th>
						<th>已检人数</th>
						<th>未检人数</th>
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
                                <td>${var.id}</td>
                                <td><a href="<%=basePath%>patientitem/itemList.do?origin=group&groupId=${var.id}">${var.name}</a></td>
                                <td>${var.hospitalName}</td>
                                <td>${var.hospitalOfficeName}</td>
                                <td>${var.createTime}</td>
                                <td>${var.allNum}</td>
                                <td>${var.doneNum}</td>
                                <td>${var.undoneNum}</td>
								<td style="width: 70px;" class="center">
									<div>									
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' title="结果汇总" onclick="showTotalResult('${var.id}','${var.name}');">结果汇总</a>
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
                    <a class="btn btn-small btn-primary" onclick="excelExport()" href="javascript:void(0);">导出Excel</a>
                </td>
<%-- 				<td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
					<c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a>
					</c:if>
				</td> --%>
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

    function excelExport(){
        var seles=$("input[name='ids']:checked");
        if(!seles||seles.length==0){
            bootbox.alert("您还没有选择任何数据");
            return false;
        }
        var ids=[];
        for(var i=0;i<seles.length;i++){
            ids[i]=$(seles[i]).val();
        }
        window.location.href="<%=basePath%>patientgroup/groupList/excel?ids="+ids;
    }

	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientgroup/goAdd.do'),
            title: '新增'
          });
	}
	
	//结果汇总
	function showTotalResult(id,groupName){
/* 		layer.open({
			  type: 2, 
			  title:"浏览详情",
			  area: ['1080px', '600px'],
			  content: 'patientgroup/goShowTotalResult/'+id
			}); 	 */
		BootstrapDialog.show({cssClass:'four-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientgroup/goShowTotalResult/'+id),
            title: groupName+'的结果查看'
          });
	}
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientgroup/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>patientgroup/delete/"+id;
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
		var url = '<%=basePath%>patientgroup/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>