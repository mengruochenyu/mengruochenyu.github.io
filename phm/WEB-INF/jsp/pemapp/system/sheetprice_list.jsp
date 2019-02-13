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
                width:250px;
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
			<form action="sheetprice/list.do" method="post" name="Form" id="Form">
			<table>
				<tr><td><span class="input-icon">
                            <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="这里输入体检表名称" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                    </span></td>
                    <td><span class="input-icon"><select id="query_key_echartTypeName" name="query_key_echartTypeName"></select></span></td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-hover" style="white-space: nowrap;">
				<thead>
					<tr><th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label></th>
						<th>量表ID</th>
						<th>名称</th>
						<th>展示方式</th>
						<th>价格</th>
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
							<tr id="sheet_tr_${var.id}">
								<td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 80px;">${var.id}</td>
                                <td>${var.name}</td>
                               <%-- <td><textarea style="width:400px; resize:none;">${var.description}</textarea></td> --%>
                                <td>${var.echartTypeName}</td>
                                <td style="width: 200px"><input type="text" value="${var.price}" ></td>
								<td style=""><a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}','${var.price}');">保存</a></td>
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
			<tr><td style="vertical-align:top;">
					<!-- <a class="btn btn-small btn-success" onclick="add();">新增</a> -->
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
            message: $('<div></div>').load('<%=basePath%>checksheet/goAdd.do'),
            title: '新增'
          });
	}
	//保存按钮
	function edit(id,price){
        //每次点击保存的时候，都要后去前面文本框的值，并存储下来
        //执行的操作：获取点击的id和当前的价格，然后Ajax访问后台，把这两个参数传过去
        var textStr = $(event.currentTarget).parent().prev().children().val();
        bootbox.confirm('是否确定修改价格？', function(result) {
			if(result) { //点击确定以后的操作
		        $.ajax({
		        	url: '<%=basePath%>sheetprice/updatepricebyid',
					type: "POST",
					data: {id:id,price:textStr},
					dataType: "json",
					success: function(data) {
						var code = data.code;
						if (code == 200) {
							console.log(code);
							window.location.reload();
						} else if (code == 407) {
							console.log("参数存在异常");
							alert("数据异常！");
						} else {
							console.log(code);
						}
					}
		        });
			}
		});
	}
	//删除
	function del(id){
		var url = "<%=basePath%>checksheet/delete/"+id;
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
		//绑定select
		SELECT_LIST.getEchartTypeSelect("query_key_echartTypeName",'${pd.query_key_echartTypeName}');
	});
	//批量操作
	function makeAll(){
		var url = '<%=basePath%>checksheet/deleteBatch';
		ajaxDeleteBatch(url);
	}
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>