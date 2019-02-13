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
    <style>
        td .content{
            text-overflow: ellipsis;
            width:60px;
            overflow: hidden;
            display: inline-block;
        }
        .content-td{
            position: relative;
        }
        td span.content-det{
            font-size: 11px;
            color: salmon;
            display: inline-block;
        }
    </style>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="hospitaldepartment/list.do" method="post" name="Form" id="Form">
            <b style="font-size: 14px;">${hospital.name}</b>部门列表
			<table id="table_report" class="table table-hover" style="white-space: nowrap;">
				
				<thead>
					<tr>
                        <th>序号</th>
                        <th>名称</th>
						<th>账号</th>
						<th>对接人</th>
						<th>对接人电话</th>
						<th>全部团体数</th>
						<th>完成团体数</th>
						<th>全部个人数</th>
						<th>完成个人数</th>
						<th>全部人次数</th>
						<th>完成人次数</th>
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
								<td style="width: 40px;">${vs.index+1}</td>
                                <td><a href="<%=basePath%>hospitaloffice/list.do?departmentId=${var.id}">${var.name}</a></td>
                                <td>${var.accountName}</td>
                                <td>${var.dockingName}</td>
                                <td>${var.dockingPhone}</td>
                                <td>${var.statistic.groupAllNum}</td>
                                <td>${var.statistic.groupDoneNum}</td>
                                <td>${var.statistic.itemAllNum}</td>
                                <td>${var.statistic.itemDoneNum}</td>
                                <td>${var.statistic.manTimeAllNum}</td>
                                <td>${var.statistic.manTimeDoneNum}</td>
								<td style="width: 70px;" class="center">
									<div>
										<div class="inline position-relative">
                                            <a class="btn btn-mini btn-success" onclick="editPassword('${var.accountName}');" title="修改密码" >修改密码</a>
                                            <a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}');"><i class="fa fa-edit"></i></a>
                                            <a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>
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
					<a class="btn btn-small btn-success" onclick="add();">新增部门</a>
                    <a href="javascript:void(0);" class="btn btn-small btn-info" onclick="window.history.back(-1);">返回医院列表</a>
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
            message: $('<div></div>').load('<%=basePath%>hospitaldepartment/goAdd.do?hospitalId=${pd.hospitalId}'),
            title: '新增部门'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>hospitaldepartment/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>hospitaldepartment/delete/"+id;
		ajaxDelete(url);
	}

    function showCont(obj){
        layer.open({
            content:obj,
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
	
	//批量操作
	function makeAll(){
		var url = '<%=basePath%>hospitaldepartment/deleteBatch';
		ajaxDeleteBatch(url);
	}
	//修改密码
	function editPassword(accountName){
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