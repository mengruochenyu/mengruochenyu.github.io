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
			<form action="checkpackage/list.do" method="post" name="Form" id="Form">
            <b>${hospital.name}-${hospitalOffice.name}</b>套餐列表
			<table id="table_report" class="table table-hover">
				<thead>
					<tr>
						<th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>名称</th>
						<th>描述</th>
						<th>量表</th>
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
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td>${var.name}<c:if test="${var.id==freePackage.freePackageId}">&nbsp;&nbsp;&nbsp;<span style="color: #E17B67;font-style: oblique ;">免费</span></c:if></td>
                                <td>${var.description}</td>
                                <td>${var.sheetNameStr}</td>
								<td class="center" style="width: 200px;">
									<div style="text-align: left;">
										<div class="inline position-relative">
												<a class='btn btn-mini btn-info' title="选择体检表" onclick="addCheckSheet('${var.id}');">选择体检表</a>
												<a class='btn btn-mini btn-info' style="margin-top: 2px;" title="编辑" onclick="edit('${var.id}');">编辑</a>
												<%--<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>--%>
										</div>
									</div>
								</td>
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
                    <a class="btn btn-small btn-info" onclick="javascript:window.history.back(-1);">返回科室列表</a>
                    <a class="btn btn-small btn-info" onclick="setFreePackage();" title="设置免费套餐">设置免费套餐</a>
                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                    <a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i></a>
                </td>
				<td style="vertical-align:top;">
                    <%--<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>--%>
                </td>
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

    //去设置免费套餐页面
    function setFreePackage() {
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>freepackage/goSetFreePackage?officeId=${hospitalOffice.id}'),
            title: '设置免费套餐'
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
            message: $('<div></div>').load('<%=basePath%>checkpackage/goAdd.do?officeId=${hospitalOffice.id}'),
            title: '新增'
          });
	}
	
	//选择体检表
	function addCheckSheet(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkpackage/goSelectSheet/'+id),
            title: '编辑'
          });
	}
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkpackage/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>checkpackage/delete/"+id;
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
		var url = '<%=basePath%>checkpackage/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>