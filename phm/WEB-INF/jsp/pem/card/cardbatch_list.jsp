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

            <b style="font-size: 14px;">${hospital.name}</b><c:if test="${pd.batchType==1}">实体卡</c:if><c:if test="${pd.batchType==2}">干预卡</c:if>批次列表
			<form action="cardbatch/list.do" method="post" name="Form" id="Form">
			    <input type="hidden" name="batchType" value="${pd.batchType}"/>
			    <input type="hidden" name="hospitalId" value="${hospital.id}"/>
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
		
		
			<table id="table_report" class="table table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>批次名称</th>
						<th>关联医院</th>
						<th>卡片数量</th>
						<th>有效期开始时间</th>
						<th>有效期结束时间</th>
						<th>创建时间</th>
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
                                <td><a onclick="showDetail('${var.id}','${var.cardType}');" href="javascript:void(0);">${var.name}</a></td>
                                <td>${var.hospitalName}</td>
                                <td>${var.cardCount}</td>
                                <td>${var.validTimeStart}</td>
                                <td>${var.validTimeEnd}</td>
                                <td>${var.createTime}</td>
								<td style="width: 150px;" class="center">
                                    <div>
                                        <div class="inline position-relative">
                                            <a class="btn btn-mini btn-primary" href="<%=basePath%><c:if test="${pd.batchType==1}">cardentity</c:if><c:if test="${pd.batchType==2}">cardtreatment</c:if>/excel.do?batchId=${var.id}&order=1">导出Excel</a>
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
					<a class="btn btn-small btn-success" onclick="add();">新建批次</a>
                    <a href="<%=basePath%>hospital/list/card.do?batchType=${pd.batchType}" class="btn btn-small btn-info">返回医院列表</a>
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
	    var batchType=${pd.batchType};
	    var cardUrl;
	    var cardName;
	    if(batchType==1){
            cardUrl='cardentity';
            cardName="实体卡";
        }
        else if(batchType==2){
	        cardUrl='cardtreatment';
	        cardName="干预卡";
        }else{
            alert('请刷新页面重试');
            return false;
        }
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>'+cardUrl+'/goAddBatch.do?hospitalId=${hospital.id}'),
            title: '${hospital.name}-'+cardName+"批次"
          });
	}

	function showDetail(batchId,cardType){
	    if(cardType==1){
            window.location.href="<%=basePath%>cardentity/list.do?hospitalId=${hospital.id}&&batchId="+batchId;
        }else if (cardType==2){
            window.location.href="<%=basePath%>cardtreatment/list.do?hospitalId=${hospital.id}&&batchId="+batchId;
        }
    }

	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>cardbatch/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
	function del(id){
		var url = "<%=basePath%>cardbatch/delete/"+id;
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
		var url = '<%=basePath%>cardbatch/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>