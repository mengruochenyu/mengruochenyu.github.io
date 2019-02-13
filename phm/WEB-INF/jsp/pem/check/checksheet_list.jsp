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
        <script>
            var openTitle="展开模板";
            var closeTitle="折叠模板";
            var openStatus="open";
            var closeStatus="close";

            //展开/关闭模板
            function expandSwift(btn, sheetId){

                var status=$(btn).attr("data-switch");
                if(status==closeStatus){
                    templateSrch(btn,status,sheetId);
                }else{
                    var target=$("tr[data-target='tr_sheet_"+sheetId+"']");
                    target.remove();
                    $(btn).text(openTitle);
                    $(btn).attr("title",openTitle);
                    $(btn).attr("data-switch",closeStatus);
                }
            }

            //刷新/展开模板列表
            function templateSrch(btn,status,sheetId){
                debugger;
                var html="";
                html+="<tr data-target='tr_sheet_"+sheetId+"'>";
                var ajaxObject={};

                ajaxObject.url="<%=basePath%>"+"checksheet/template/list/"+sheetId;
                ajaxObject.data={};
                ajaxObject.success=function (data) {
                    var varList = data.data;
                    if (varList != null && varList.length > 0) {
                        html+="<td colspan='7' style='padding:0 4%;background-color: white;'>";
                        html+="<table class='table-sheet-childs table' style='margin-bottom: -1px;'>";
                        $.each(varList, function (index, vs) {
                            html+="<tr>";
                            html+="<td>";
                            if(index==varList.length-1)
                                html += "<img src='static/images/joinbottom.gif' style='vertical-align: middle;'/>";
                            else
                                html += "<img src='static/images/join.gif' style='vertical-align: middle;'/>";
                            html+=(vs.name)+"</td>";
                            html+="<td>"+(vs.checkSheetName)+"</td>";
                            html+="<td>"+vs.rangMin +" - "+(vs.rangMax)+"</td>";
                            html+="<td class=\"content-td\"><span style=\"\" class=\"content\">"+(vs.comment)+"</span><a href=\"javascript:void(0);\" onclick=\"showCont($(this).prev().text());\"><span class=\"content-det\">详细</span></a></td>";
                            html+="<td class=\"content-td\"><span style=\"\" class=\"content\">"+(vs.suggest)+"</span><a href=\"javascript:void(0);\" onclick=\"showCont($(this).prev().text());\"><span class=\"content-det\">详细</span></a></td>";
                            html+="<td style=\"width: auto;\" class=\"center\">";
                            html+="<div>";
                            html+="<div class=\"inline position-relative\">";
                            html+="<a class='btn btn-mini btn-success' style='margin-right:3px;' title='新增' onclick=\"addTemp('"+vs.checkSheetId+"')\">新增</a>";
                            html+="<a class='btn btn-mini btn-info' style='margin-right:3px;' title=\"编辑\" onclick=\"editTemp('"+(vs.id)+"');\"><i class=\"fa fa-edit\"></i></a>";
                            html+="<a class='btn btn-mini btn-danger' title=\"删除\" onclick=\"delTemp('"+(vs.id)+"',"+sheetId+");\"><i class=\"fa fa-trash\"></i></a>";
                            html+="</div>";
                            html+="</div>";
                            html+="</td>";
                            html+="</tr>";
                        });
                        html+="</table>";
                        html+="</td>";
                    }else{
                        html+="<td colspan=\"6\" class=\"center\" >没有相关数据</td>" +
                            "<td><div><div class=\"inline position-relative\">" +
                            "<a class='btn btn-mini btn-success' title='新增模板' onclick=\"addTemp('"+sheetId+"')\">新增模板</a></div></div></td>"+
                            "</div></div></td>";
                    }
                    html+="</tr>";
                    var sheet_tr=$("#sheet_tr_"+sheetId);
                    debugger;
                    if(status==openStatus){
                        sheet_tr.next().remove();
                    }
                    sheet_tr.after(html);
                    if(btn){
                        $(btn).text(closeTitle);
                        $(btn).attr("title",closeTitle);
                        $(btn).attr("data-switch",openStatus);
                    }
                }
                ajaxPost(ajaxObject);
            }

            function showCont(obj){
                layer.open({
                    content:obj
                });
            }
        </script>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="checksheet/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
                    <td>
                        <span class="input-icon">
                            <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="这里输入体检表名称" />
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                    </td>
                    <td>
                        <select name="classify">
                            <option value="">选择分类</option>
                            <c:if test="${not empty classifyList}">
                                <c:forEach items="${classifyList}" var="var">
                                    <option value="${var.id}" <c:if test="${var.id==pd.classify}">selected</c:if>>${var.name}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-hover" style="white-space: nowrap;">
				
				<thead>
					<tr>
						<th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>量表ID</th>
						<th>名称</th>
						<th>体检表描述</th>
						<th>小于该值时预警</th>
						<th>大于该值时预警</th>
						<th>展示方式</th>
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
								<td style="width: 40px;">${var.id}</td>
                                <td>${var.name}</td>
                              <%--   <td><div style="text-overflow: ellipsis;width: 250px;overflow: hidden;display: inline-block;">${var.description}</div></td> --%>
                                <td><textarea style="width:300px; resize:none;">${var.description}</textarea></td>
                                <td><c:if test="${var.min==0}"><span>无</span></c:if><c:if test="${var.min!=0}">${var.min}</c:if></td>
                                <td><c:if test="${var.max==0}"><span>无</span></c:if><c:if test="${var.max!=0}">${var.max}</c:if></td>
                                <td>${var.echartTypeName}</td>
								<td style="" class="center">
                                    <div>
                                        <a class='btn btn-mini btn-info' title="展开模板" data-switch="close" onclick="expandSwift(this,'${var.id}');">展开模板</a>
                                        <div class="inline position-relative">
                                                <a class='btn btn-mini btn-info' title="添加体检题目" onclick="goAddCheckQuestion('${var.id}');">添加题目</a>
												<a class='btn btn-mini btn-info' title="题目清单" onclick="sortQuestion('${var.id}');">题目清单</a>
												<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}');">编辑</a>
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
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					<a class="btn btn-small btn-success" onclick="addFactor();">添加因子</a>
					<a class="btn btn-small btn-success" onclick="showFactor();">查看因子</a>
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
	
	//排序
	function sortQuestion(id){
		location.href = '<%=basePath%>checksheet/goSortQuestion/'+id;
	}
	//添加体检题目
	function goAddCheckQuestion(sheetId){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCheckQuestion?funcType=1&sheetId='+sheetId),
            title: '添加体检题目'
        });
	}
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checksheet/goEdit/'+id),
            title: '编辑'
          });
	}
	//修改模板
	function editTemp(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkreporttemplate/goEdit/'+id),
            title: '编辑'
          });
	}
	//新增模板
    function addTemp(sheetId){
	    debugger;
        BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>checkreporttemplate/goAdd.do?sheetId='+sheetId),
            title: '新增'
        });
    }
	//删除
	function del(id){
		var url = "<%=basePath%>checksheet/delete/"+id;
		ajaxDelete(url);
	}
	//删除模板
	function delTemp(tempId,sheetId){
	    if(!confirm("确定要删除吗？")){
	        return false;
        }
		var url = "<%=basePath%>checkreporttemplate/delete/"+tempId;
        $.ajax({
            type: "POST",
            url: url,
            data: {},
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            cache: false,
            success: function (data) {
                if(data.code==200){
                    templateSrch(null,'open',sheetId);
                }else{
                    alert(data.msg);
                }
            }
        });
	}
	//添加因子
	function addFactor(){
		var sheets=$("[name='ids']:checked");//DOM对象数组
		if(sheets.length !=1){
			bootbox.alert("请选择一张体检表！");
			return false;
		}
		var sheetId = $(sheets[0]).val();
		location.href = '<%=basePath%>patientcheckscorefactor/goAddFactor/'+sheetId;
	}
	//查看因子
	function showFactor(){
		var sheets=$("[name='ids']:checked");//DOM对象数组
		if(sheets.length !=1){
			bootbox.alert("请选择一张体检表！");
			return false;
		}
		var sheetId = $(sheets[0]).val();
		location.href = '<%=basePath%>patientcheckscorefactor/goShowFactor/'+sheetId;
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
		var url = '<%=basePath%>checksheet/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>