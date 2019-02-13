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
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%><!-- jsp文件头和头部 -->
</head>
<style>
	select {
		cursor: pointer;
	}
</style>
<body>
<div class="container-fluid" id="main-container">
<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
			<!-- 检索  -->
			<form action="doctor/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key" value="${pd.query_key}" placeholder="输入姓名" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span></td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_mobile" value="${pd.query_key_mobile}" placeholder="输入电话" />
					</span></td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_incomeAccount" value="${pd.query_key_incomeAccount}" placeholder="输入收益账户" />
					</span></td>
							<%-- <input autocomplete="off" id="nav-search-input" type="text" name="query_key_qualification" value="${pd.query_key_qualification}" placeholder="输入资质" />
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_royaltyRate" value="${pd.query_key_royaltyRate}" placeholder="输入提成比例" /> --%>
					<!-- 下拉菜单 -->
					<td><span class="input-icon"><select id="query_key_gender" name="query_key_gender"></select></span></td>
					<!-- <td><span class="input-icon"><select id="query_key_titleId" name="query_key_titleId"></select></span></td> -->
					<!-- <td><span class="input-icon"><select id="query_key_accountType" name="query_key_accountType"></select></span></td> -->
					<td><span class="input-icon"><select id="query_key_pioneerId" name="query_key_pioneerId"></select></span></td>
					<td><span class="input-icon"><select id="query_key_status" name="query_key_status"></select></span></td>
					
					<%-- <td><input class="span10 date-picker" name="query_time_start" id="query_time_start" value="${pd.query_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td><input class="span10 date-picker" name="query_time_end" id="query_time_end" value="${pd.query_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td> --%>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-hover">
				<thead>
					<tr><th><label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label></th>
						<th>序号</th>
						<th>头像</th>
						<th>医生姓名</th>
						<th>医生电话</th>
						<th>医生性别</th>
						<th>个人简介</th>
						<th>头衔/称号</th>
						<th>收益账户</th>
						<th>账户类型</th>
						<!-- <th>账户余额</th> -->
						<th>提成比例</th>
						<th>开拓人员</th>
						<th>状态</th>
						<!-- <th>备注</th> -->
						<th>擅长方向</th>
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
							<tr><td style="width: 30px;">
									<label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
                                <td style="width: 135px;"><img style="width: 100px;height:50px;" src="<%=basePath%>${var.photoUrl}"/></td>
                                <td>${var.name}</td>
                                <td>${var.mobile}</td>
                                <td><c:if test="${var.gender == 0}">女</c:if>
                                	<c:if test="${var.gender == 1}">男</c:if>
                                	</td>
                                <td>
                                	<a class='btn btn-mini btn-info' title="头衔" onclick="showIntroduce('${var.id}');">查看简历</a>
                                	<%-- ${var.introduce} style="max-width: 130px"--%>
                                </td>
                                <td><c:if test="${var.titleId == ''}">无头衔</c:if>
                                	<c:if test="${var.titleId != '' && not empty titleList}">
                                		<c:forEach items="${titleList}" var="title" varStatus="vs">
                                			<c:if test="${title.dictionaryId == var.titleId}">${title.dicName}</c:if>
                                		</c:forEach>
                                	</c:if>
                                </td>
                                <td>${var.incomeAccount}</td>
                                <td><c:if test="${var.accountType == 1}">支付宝账户</c:if>
                                	<c:if test="${var.accountType == 2}">微信账户</c:if>
                                	<c:if test="${var.accountType == 3}">银行卡账户</c:if>
                                	</td>
                                <%-- <td>${var.accountBalance}</td> --%>
                                <td>${var.royaltyRate}</td>
                                <td><c:if test="${var.pioneerId == ''}">无开拓人员</c:if>
                                	<c:if test="${var.pioneerId != '' && not empty pioneerList}">
                                		<c:forEach items="${pioneerList}" var="pioneer" varStatus="vs">
                                			<c:if test="${pioneer.id == var.pioneerId}">${pioneer.name}</c:if>
                                		</c:forEach>
                                	</c:if>
                                </td>
                                <td><c:if test="${var.status == 0}">禁用</c:if>
                                	<c:if test="${var.status == 1}">启用</c:if>
                                	</td>
                                <%-- <td style="max-width: 100px">${var.remark}</td> --%>
                                <td style="max-width: 130px;">
                                	<c:forEach items="${specialityList}" var="list" varStatus="vs" >
                                		<c:if test="${list.doctor_id == var.id}">
                                			<span style="color:${list.font_color}">${list.speciality_name}</span>&nbsp;&nbsp;
                                		</c:if>
                                	</c:forEach>
                                </td>
								<td style="width: 200px;" class="center">
									<div><c:if test="${QX.edit != 1 && QX.del != 1 }">
										 <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										 </c:if>
										 <div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' title="禁用/解禁" onclick="editSatus('${var.id}','${var.status}');">
													<c:if test="${var.status == 1}">禁用</c:if>
													<c:if test="${var.status == 0}">解禁</c:if>
												</a>
												<a class='btn btn-mini btn-info' title="头衔" onclick="editSpeciality('${var.id}');">擅长方向</a>
												<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}');"><i class="fa fa-edit"></i>编辑</a>
											</c:if>
											<%-- <c:if test="${QX.del == 1 }">
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>
											</c:if> --%>
									</div></div>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr><td colspan="100" class="center">您无权查看</td></tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info"><td colspan="100" class="center" >没有相关数据</td></tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr><td style="vertical-align:top;">
					<c:if test="${QX.add == 1 }">
					<a class="btn btn-small btn-success" onclick="add();">新增</a>
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
</body>
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
				$(this).closest('tr').toggleClass('selected');2999
			});
		});
		//构建下拉菜单 
		SELECT_LIST.getGenderSelect("query_key_gender",'${pd.query_key_gender}');//性别
		SELECT_LIST.getAccountTypeSelect("query_key_accountType",'${pd.query_key_accountType}');//账号类型
		SELECT_LIST.getDoctorStatusSelect("query_key_status",'${pd.query_key_status}');//医生账号状态
		SELECT_LIST.getDoctorTitleSelect("query_key_titleId",'${pd.query_key_titleId}');//医生头衔
		SELECT_LIST.getDoctorExpioneerSelect("query_key_pioneerId",'${pd.query_key_pioneerId}');//医生绑定的开拓人员
	});
</script>
<script type="text/javascript">
	$(top.hangge());
	//检索事件
	function search(){
		top.jzts();
		$("#Form").submit();
	}
	//新增按钮的点击事件
	function add(){
		 BootstrapDialog.show({cssClass:'three-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctor/goAdd.do'),
            title: '新增'
          });
	}
	//修改：编辑按钮的点击事件
	function edit(id){
		BootstrapDialog.show({cssClass:'three-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctor/goEdit/'+id),
            title: '编辑'
          });
	}
	//修改：擅长方向的点击事件
	function editSpeciality(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctorspecialityasso/goEdit/'+id),
            title: '编辑专长'
          });
	}
	//展示个人简历信息showIntroduce
	function showIntroduce(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>doctor/showIntroduce/'+id),
            title: '医生个人简历'
          });
	}
	//删除：删除按钮的点击事件
	function del(id){
		var url = "<%=basePath%>doctor/delete/"+id;
		ajaxDelete(url);
	}
	//批量操作：批量删除
	function makeAll(){
		var url = '<%=basePath%>doctor/deleteBatch';
		ajaxDeleteBatch(url);
	}
	//清空、重置搜索菜单
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
	//禁用解禁
	function editSatus(id,status){
		var newStatus = 0;//默认是禁用
		var descStr = "您确定要禁用该医生吗?";
		if(status == 0){
			newStatus = 1;//如果原来状态是禁用，则解禁
			descStr = "您确定要解禁该医生吗?";
		}		
		var url = "<%=basePath%>doctor/editStatus";
		bootbox.confirm(descStr, function(result) {
			if(!result){return;}
 		    $.ajax({
		        type: "POST",
		        url: url,
		        data:{
		        	id:id,
		        	newStatus:newStatus
		        },
		        dataType:'json',
		        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		        cache: false,
		        success: function(result){
		            	if (result.code == 200) {
		            		location.reload();
						}
		        },
		        error: function(result){
		        	location.reload();
		        }
		    }); 
		});   
	}
</script>
</html>