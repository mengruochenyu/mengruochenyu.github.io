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
	<%@ include file="../system/admin/top.jsp"%> 
	</head>
<body>

<script type="text/javascript">

var selectRoleId = "${pd.roleId}";
$(function() {
	$.post('<%=basePath%>platformuser/roleList',function(data){
	    if(data!=null){
	        var html="<option value=''>选择角色</option>";
	        for(var i=0;i<data.length;i++){
	        	var selected = "";
	        	if(selectRoleId == data[i].roleItemId){
	        		selected = "selected";
	        	}
	             html += "<option value='"+data[i].roleItemId+"' " + selected + ">"+data[i].roleName+"</option>";
	        }
	        $("#roleIdSelect").html('').append(html);  
	    }
	});
});

</script>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="platformuser/list.do" method="post" name="Form" id="Form">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" maxlength="50" name="accountname" value="${pd.accountname}" placeholder="输入用户名" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="mobilePhone" value="${pd.mobilePhone}" placeholder="请输入手机号" />
							<i class="ace-icon fa fa-search nav-search-icon"></i>
						</span>
					</td>
					<td>
					&nbsp;
						角色:&nbsp;<select data-section-name="overview" class="select" name="roleId" id="roleIdSelect" >
						</select>
					</td>
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
						<th>序号</th>
						<th>用户名</th>
						<th>姓名</th>
						<th>手机</th>
						<th>QQ</th>
						<th>部门</th>
						<th>性别</th>
						<th>角色</th>
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
									<label><input type='checkbox' name='ids' class="ace" value="${var.platformuserId}" /><span class="lbl"></span></label>
								</td>
								<td style="width: 40px;">${vs.index+1}</td>
										<td>${var.accountname}</td>
										<td>${var.name}</td>
										<td>${var.mobilePhone}</td>
										<td>${var.qqId}</td>
										<td>${var.depcdName}</td>
										<td>${var.sexType}</td>
										<td>${var.roleName}</td>
								<td>
									<div>
									
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.platformuserId}');"><i class="fa fa-edit"></i></a>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.platformuserId}');"><i class="fa fa-trash"></i></a>
											</c:if>
											<c:if test="${QX.edit == 1 }">
												<a class='btn btn-mini btn-info' onclick="changePw('${var.platformuserId}');"><i class="fa fa-lock"></i>重置密码</a>
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
					<a class="btn btn-small btn-info" onclick="add();">新增</a>
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
            message: $('<div></div>').load('<%=basePath%>platformuser/goAdd.do'),
            title: '新增'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>platformuser/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//删除
		function del(id){
			var url = "<%=basePath%>platformuser/delete/"+id;
			ajaxDelete(url);
		}
	
		//密码重置
		function changePw(id){
			var postObject = {};
			postObject.url = '<%=basePath%>platformuser/changePw/'+id;
			postObject.success=function(){
				bootbox.alert("密码重置成功");
			};
			postObject.fail=function(result){
				bootbox.alert(result.msg);
			}
			ajaxPost(postObject);
		}
		
		//角色设置
		 function updateRole(id){
			$.ajax({
		        type: "POST",
		        dataType: "json",
		        data: {"id":id},    
		        url: "<%=basePath%>platformuser/changeRole",
		        success: function (data) {
		        	alert("设置成功");
		        	window.location.reload();
		        }
		    });
		}
		
		
		//角色还原
		 function resetRole(id){
			$.ajax({
		        type: "POST",
		        dataType: "json",
		        data: {"id":id},    
		        url: "<%=basePath%>platformuser/resetRole",
		        success: function (data) {
		        	alert("设置成功");
		        	window.location.reload();
		        }
		    });
		}
		
		//请求角色信息
</script>
		
<script type="text/javascript">
		
	$(function() {
		setListActionUrl();
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
		var url = '<%=basePath%>platformuser/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>

<div id="u224" class="text">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<tr><font color="blue"><span>密码重置</span><span>： </span><span>重置为手机后6位</span></font></tr></p>
</div>
	</body>
</html>