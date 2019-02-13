<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<html lang="en">
<head>
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%><!-- jsp文件头和头部 -->
	<script type="text/javascript" src="static/js/myjs/select-list-ajax.js"></script>
</head>

<body>
<div class="container-fluid" id="main-container">
<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
			<!-- 检索  -->
			<form action="member/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_number" value="${pd.query_key_number}" placeholder="输入编号" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span></td>
					<td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_name" value="${pd.query_key_name}" placeholder="输入姓名" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span></td>
                    <td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_mobile" value="${pd.query_key_mobile}" placeholder="输入电话" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span></td>
                    <td><span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="query_key_addressDetail" value="${pd.query_key_addressDetail}" placeholder="输入详细地址" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
					</span></td>
                    <td style="padding-left: 12px;">
                        <span class="input-icon"><select name="query_key_gender" id="gender_filtrate"></select></span></td>
					<td><span class="input-icon"><select name="query_key_degree" id="degree_filtrate"></select></span></td>
                    <td style="">
                        <span class="input-icon"><select name="query_key_career" id="career_filtrate"></select></span></td>
                    <td style="width:100px;">
                        <span class="input-icon"><select name="query_key_maritalStatus" id="maritalStatus_filtrate"></select></span></td>
					<td style="padding-right: 20px;">
                        <span class="input-icon"><select name="query_key_doctor_id" id="doctor_filtrate"></select></span></td>
					<!-- 下拉菜单 -->
					<td><input class="span10 date-picker" name="query_time_start" id="query_time_start" value="${pd.query_time_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/></td>
					<td><input class="span10 date-picker" name="query_time_end" id="query_time_end" value="${pd.query_time_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
				</tr>
			</table>
			<!-- 检索  -->
			<table id="table_report" class="table table-hover">
				<thead>
					<tr><th>
						<label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
						</th>
						<th>序号</th>
						<th>编号</th>
						<th>姓名</th>
						<th>电话</th>
						<th>头像</th>
						<th>性别</th>
						<th>地区</th>
						<th>详细地址</th>
						<th>生日</th>
						<th>学历</th>
						<th>职业</th>
						<th>婚姻状态</th>
						<th>状态</th>
						<!-- <th>操作</th> -->
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
                                <td>${var.number}</td>
                                <td>${var.name}</td>
                                <td>${var.mobile}</td>
                                <td><img style="width: 100px;height:50px;" src="<%=basePath%>${var.photoUrl}"/></td>
                                <td><c:if test="${var.gender == 0}">女</c:if>
                                	<c:if test="${var.gender == 1}">男</c:if>
                                	</td>
                                <td>${var.addressProv} ${var.addressCity} ${var.addressCounty}</td>
                                <td>${var.addressDetail}</td>
                                <td>${fn:substring(var.birthday,0,10)}</td>
                                <td>${var.degree}</td>
                                <td>${var.career}</td>
                                <td><c:if test="${var.maritalStatus == 0}">未婚</c:if>
                                	<c:if test="${var.maritalStatus == 1}">已婚</c:if>
                                	<c:if test="${var.maritalStatus == 2}">离异</c:if>
                                	</td>
                                <td><c:if test="${var.status == 0}">禁用</c:if>
                                	<c:if test="${var.status == 1}">启用</c:if>
                                	</td>	
								<%-- <td style="width: 59px;" class="center">
									<div><c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}');"><i class="fa fa-edit"></i>编辑</a>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');"><i class="fa fa-trash"></i></a>
											</c:if>
										</div>
									</div>
								</td> --%>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr><td colspan="100" class="center">您无权查看</td></tr>
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
			<tr><td style="vertical-align:top;">
					<%-- <c:if test="${QX.add == 1 }">
						<!-- <a class="btn btn-small btn-success" onclick="add();">新增</a> -->
					</c:if> --%>
					<%-- <c:if test="${QX.del == 1 }">
					<a class="btn btn-small btn-danger" onclick="makeAll();" title="批量删除" ><i class='fa fa-trash'></i>批量删除</a>
					</c:if> --%>
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
		//省
        var addressProv=$("#addressProvSel").val();
        //市
        var addressCity=$("#addressCitySel").val();
        //区
        var addressCounty=$("#addressCountySel").val();
        $("#addressProv").val(addressProv);
        $("#addressCity").val(addressCity);
        $("#addressCounty").val(addressCounty);
		top.jzts();
	}
	//新增按钮
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>member/goAdd.do'),
            title: '新增'
          });
	}
	//修改、编辑按钮
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>member/goEdit/'+id),
            title: '编辑'
          });
	}
	//删除（未使用）
	function del(id){
		var url = "<%=basePath%>member/delete/"+id;
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
		//初始化完成
		//birthdayShow.substr(0,10)
		//动态构建医患关系下拉菜单 doctor_filtrate
		SELECT_LIST.getDoctorSelect("doctor_filtrate",'${pd.query_key_doctor_id}');
		//静态下拉菜单的获取
		SELECT_LIST.getGenderSelect("gender_filtrate",'${pd.query_key_gender}');
		SELECT_LIST.getDegreeSelect("degree_filtrate",'${pd.query_key_degree}');
		SELECT_LIST.getCareerSelect("career_filtrate",'${pd.query_key_career}');
		SELECT_LIST.getMaritalStatusSelect("maritalStatus_filtrate",'${pd.query_key_maritalStatus}');
	});
	//批量操作
	function makeAll(){
		var url = '<%=basePath%>member/deleteBatch';
		ajaxDeleteBatch(url);
	}
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>