﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../admin/top.jsp"%> 
	</head> 
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="user/listUsers.do" method="post" name="userForm" id="userForm">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="USERNAME" value="${pd.USERNAME }" placeholder="请输入关键词" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始"/></td>
					<td><input class="span10 date-picker" name="lastLoginEnd" name="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="最近登录结束"/></td>
					<td style="vertical-align:top;"> 
					 	<select class="chzn-select" name="ROLE_ID" data-placeholder="请选择职位" style="vertical-align:top;width: 120px;">
						<option value=""></option>
						<option value="">全部</option>
						<c:forEach items="${roleList}" var="role">
							<option value="${role.ROLE_ID }" <c:if test="${pd.ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
						</c:forEach>
					  	</select>
					</td>
					<c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i class="fa form-btn-icon fa-download"></i></a></td>
					</c:if>
				</tr>
			</table>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-hover">
				
				<thead>
					<tr>
						<th>
						<label><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>用户名</th>
						<th>姓名</th>
						<th>职位</th>
						<th><i class="fa fa-mobile-phone"></i>手机</th>
						<th><i class="fa fa-time hidden-phone"></i>最近登录</th>
						<th>上次登录IP</th>
						<th>操作</th>
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty userList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${userList}" var="user" varStatus="vs">
									
							<tr>
								<td style="width: 30px;">
									<c:if test="${user.USERNAME != 'admin'}"><label><input type='checkbox' class="ace" name='ids' value="${user.USER_ID }" id="${user.EMAIL }" alt="${user.PHONE }"/><span class="lbl"></span></label></c:if>
									<c:if test="${user.USERNAME == 'admin'}"><label><input type='checkbox' class="ace" disabled="disabled" /><span class="lbl"></span></label></c:if>
								</td>
								<td >${vs.index+1}</td>
								<td><a>${user.USERNAME }</a></td>
								<td>${user.NAME }</td>
								<td>${user.ROLE_NAME }</td>
								<c:if test="${QX.FX_QX == 1 }">
								<td>${user.PHONE }</td>
								</c:if>
								<td>${user.LAST_LOGIN}</td>
								<td>${user.IP}</td>
								<td>
									<div class='hidden-phone visible-desktop btn-group'>
										
										<c:if test="${QX.edit == 1 }">
											<c:if test="${user.USERNAME != 'admin'}"><a class='btn btn-mini btn-info' title="编辑" onclick="editUser('${user.USER_ID }');"><i class='fa fa-edit'></i></a></c:if>
											<c:if test="${user.USERNAME == 'admin'}"><a class='btn btn-mini btn-info' title="您不能编辑"><i class='fa fa-edit'></i></a></c:if>
										</c:if>
										<c:choose>
											<c:when test="${user.USERNAME=='admin'}">
												<a class='btn btn-mini btn-danger' title="不能删除"><i class='fa fa-trash'></i></a>
											</c:when>
											<c:otherwise>
												<c:if test="${QX.del == 1 }">
												 <a class='btn btn-mini btn-danger' title="删除" onclick="delUser('${user.USER_ID }','${user.USERNAME }');"><i class='fa fa-trash'></i></a>
												</c:if>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
							</tr>
						
						</c:forEach>
						</c:if>
						
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="10" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="10" class="center">没有相关数据</td>
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
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
					</c:if>
					<c:if test="${QX.del == 1 }">
					<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='fa fa-trash'></i></a>
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
		
		<!-- 返回顶部  -->
		
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#userForm").submit();
		}
		
		
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 
		}
		
		//去发送短信页面
		function sendSms(phone){
			 
		}
		//新增
		function add(){
			 BootstrapDialog.show({cssClass:'one-row-dialog',
	            message: $('<div></div>').load('<%=basePath%>user/goAddU.do'),
	            title: '新增'
	          });
		}
		
		//修改
		function editUser(user_id){
			BootstrapDialog.show({cssClass:'one-row-dialog',
	            message: $('<div></div>').load('<%=basePath%>user/goEditU.do?USER_ID='+user_id),
	            title: '资料'
	          });
		}
		
		//删除
		function delUser(patientId,msg){
			bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>user/deleteU.do?USER_ID="+patientId+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var emstr = '';
					var phones = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
						  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
						  	else emstr += ';' + document.getElementsByName('ids')[i].id;
						  	
						  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
						  	else phones += ';' + document.getElementsByName('ids')[i].alt;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>user/deleteAllU.do?tm='+new Date().getTime(),
						    	data: {USER_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '确定要给选中的用户发送邮件吗?'){
							sendEmail(emstr);
						}else if(msg == '确定要给选中的用户发送短信吗?'){
							sendSms(phones);
						}
						
						
					}
				}
			});
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//日期框
			$('.date-picker').datepicker();
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
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
		
		//导出excel
		function toExcel(){
			var USERNAME = $("#nav-search-input").val();
			var lastLoginStart = $("#lastLoginStart").val();
			var lastLoginEnd = $("#lastLoginEnd").val();
			var ROLE_ID = $("#role_id").val();
			window.location.href='<%=basePath%>user/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
		}
		
		//打开上传excel页面
		function fromExcel(){
			 BootstrapDialog.show({cssClass:'one-row-dialog',
	            message: $('<div></div>').load('<%=basePath%>user/goUploadExcel.do'),
	            title: 'EXCEL 导入到数据库'
	          });
		}
		
		</script>
		
	</body>
</html>

