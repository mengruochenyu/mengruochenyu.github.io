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
	<script>
        //选择医院
        function selectHospital(obj){
            $("#hospital_office_id").empty();
            $("#hospital_office_id").append("<option value=''>全部科室</option>");
            if($(obj).val()==null||$(obj).val()==""){
                return false;
            }
            $.ajax({
                url:"<%=basePath%>hospitaloffice/findOfficeByHospital/"+$(obj).val(),
                type: "GET",
                dataType:'json',
                contentType: "application/json;charset=UTF-8",
                cache: false,
                success:function(data){
                    if(data.code==200){
                        var officeList=data.data;
                        if(officeList!=null&&officeList.length>0){
                            for(var i=0;i<officeList.length;i++){
                                var office=officeList[i];
                                $("#hospital_office_id").append("<option value='"+office.id+"'>"+office.name+"</option>");
                            }
                        }
                    }
                }
            });
        }
      <%--   <c:if test="${pd.hospital_id!=null and pd.hospital_id!=''}">
            $.ajax({
                url:"<%=basePath%>hospitaloffice/findOfficeByHospital/${pd.hospital_id}",
                type: "GET",
                dataType:'json',
                contentType: "application/json;charset=UTF-8",
                cache: false,
                success:function(data){
                    if(data.code==200){
                        var officeList=data.data;
                        if(officeList!=null&&officeList.length>0){
                            for(var i=0;i<officeList.length;i++){
                                var office=officeList[i];
                                var html="<option value='"+office.id+"'";
                                <c:if test="${pd.hospital_office_id !=null and pd.hospital_office_id!=''}">
                                    if(office.id==${pd.hospital_office_id}){
                                        html+="selected";
                                    }
                                </c:if>
                                html+=">"+office.name+"</option>";
                                $("#hospital_office_id").append(html);
                            }
                        }
                    }
                }
            });
        </c:if> --%>
    </script>
    </head>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
			<!-- 检索  -->
			<form action="patientitem/itemList.do" method="post" name="Form" id="Form">
                <input type="hidden" name="groupId" id="groupId" value="${pd.groupId}"/>
                <input type="hidden" name="origin" id="origin" value="${pd.origin}"/>
                <input type="hidden" name="isAlert" id="isAlert" value="${pd.isAlert}"/>
                <c:if test="${pd.origin=='group'}">
                    <a class="btn btn-small btn-primary" onclick="" href="javascript:history.back(-1);">返回上一页</a>
                </c:if>
                <c:if test="${pd.origin=='history'}">
                    <a class="btn btn-small btn-primary" onclick="" href="javascript:history.back(-1);">返回上一页</a>
                </c:if>
                <c:if test="${pd.origin==null||pd.origin==''||pd.origin=='alert'}">
                    <table>
                        <tr>
                            <td>
                                <input type="text" name="checkCardNum" id="checkCardNum" value="${pd.checkCardNum}" placeholder="体检卡号"/>
                            </td>
                            <td>
                                <input type="text" name="name" id="name" value="${pd.name}" placeholder="姓名"/>
                            </td>
                            <td>
                                <input type="text" name="mobile" id="mobile" value="${pd.mobile}" placeholder="手机号"/>
                            </td>
                            <td>
                                <input type="text" name="groupName" id="groupName" value="${pd.groupName}" placeholder="团体名称"/>
                            </td>
                            <td style="width:100px;">
                                <span class="">
                                    <select name="hospital_id" id="hospital_id" onchange="selectHospital(this);">
                                        <option value="">选择医院</option>
                                        <c:choose>
                                            <c:when test="${not empty hospitalList}">
                                                <c:forEach items="${hospitalList}" var="hospital">
                                                    <option value="${hospital.id}" <c:if test="${pd.hospital_id==hospital.id}">selected</c:if>>${hospital.name}</option>
                                                 </c:forEach>
                                            </c:when>
                                        </c:choose>
                                    </select>
                                </span>
                            </td>
                            <td style="width:100px;">
                                <span class="input-icon">
                                    <select name="hospital_office_id" id="hospital_office_id">
                                        <option value="">选择科室</option>
                                    </select>
                                </span>
                            </td>
                            <td style="">
                                <span class="input-icon">
                                    <select name="isGroup" id="isGroup">
                                        <option value="">全部</option>
                                        <option value="1" <c:if test="${pd.isGroup=='1'}">selected</c:if>>团体</option>
                                        <option value="0" <c:if test="${pd.isGroup=='0'}">selected</c:if>>个体</option>
                                    </select>
                                </span>
                            </td>
                            <td style="">
                                <span class="input-icon">
                                    <select name="item_gender" id="item_gender">
                                        <option value="">选择性别</option>
                                        <option value="1" <c:if test="${pd.item_gender=='1'}">selected</c:if>>男</option>
                                        <option value="0" <c:if test="${pd.item_gender=='0'}">selected</c:if>>女</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td style="width:100px;">
                                <span class="input-icon">
                                    <select name="item_age" id="item_age">
                                        <option data-min-age="" data-max-age=""  class="age_range">选择年龄区间</option>
                                        <option data-min-age="" data-max-age="20" <c:if test="${pd.max_age=='20'}">selected</c:if> class="age_range"  value="100">20以下</option>
                                        <option data-min-age="20" data-max-age="30" <c:if test="${pd.max_age=='30'}">selected</c:if> class="age_range" >20-30</option>
                                        <option data-min-age="30" data-max-age="40" <c:if test="${pd.max_age=='40'}">selected</c:if> class="age_range">30-40</option>
                                        <option data-min-age="40" data-max-age="50" <c:if test="${pd.max_age=='50'}">selected</c:if> class="age_range">40-50</option>
                                        <option data-min-age="40" data-max-age="60" <c:if test="${pd.max_age=='60'}">selected</c:if> class="age_range" >50-60</option>
                                        <option data-min-age="60" data-max-age="" <c:if test="${pd.min_age=='60'}">selected</c:if> class="age_range">60以上</option>
                                    </select>
                                </span>
                                <input type="hidden" name="min_age" id="min_age">
                                <input type="hidden" name="max_age" id="max_age">
                            </td>
                            <td style="">
                                <span class="input-icon">
                                    <select name="treat_status" id="treat_status">
                                        <option value="">干预状态</option>
                                        <option value="1" <c:if test="${pd.treat_status=='1'}">selected</c:if>>开启</option>
                                        <option value="0" <c:if test="${pd.treat_status=='0'}">selected</c:if>>关闭</option>
                                    </select>
                                </span>
                            </td>
                            <c:if test="${pd.origin==null||pd.origin==''}">
                                <td style="">
                                    <span class="input-icon">
                                        <select name="check_status" id="check_status">
                                            <option value="-1">体检状态</option>
                                            <option value="1" <c:if test="${pd.check_status=='1'}">selected</c:if>>已体检</option>
                                            <option value="0" <c:if test="${pd.check_status=='0'}">selected</c:if>>未体检</option>
                                        </select>
                                    </span>
                                </td>
                            </c:if>
                            <td style="">
                                <span class="input-icon">
                                    <select name="report_status" id="report_status">
                                        <option value="">审核状态</option>
                                        <option value="0" <c:if test="${pd.report_status=='0'}">selected</c:if>>未审核</option>
                                        <option value="1" <c:if test="${pd.report_status=='1'}">selected</c:if>>已审核</option>
                                        <option value="2" <c:if test="${pd.report_status=='2'}">selected</c:if>>已打印</option>
                                    </select>
                                </span>
                            </td>
                            <td><input class="span10 date-picker" name="query_time_start_create" id="query_time_start_create" value="${pd.query_time_start_create}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建开始日期"/></td>
                            <td><input class="span10 date-picker" name="query_time_end_create" id="query_time_end_create" value="${pd.query_time_end_create}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="创建结束日期"/></td>
                            <td><input class="span10 date-picker" name="query_time_start_report" id="query_time_start_report" value="${pd.query_time_start_report}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="报告生成开始日期"/></td>
                            <td><input class="span10 date-picker" name="query_time_end_report" id="query_time_end_report" value="${pd.query_time_end_report}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="报告生成结束日期"/></td>
                            <td><input class="span10 date-picker" name="query_time_start_audit" id="query_time_start_audit" value="${pd.query_time_start_audit}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="审核开始日期"/></td>
                            <td><input class="span10 date-picker" name="query_time_end_audit" id="query_time_end_audit" value="${pd.query_time_end_audit}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="审核结束日期"/></td>
                            <td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i class="fa form-btn-icon fa-search"></i></button></td>
                            <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="searchReset();" title="重置"><i class="fa form-btn-icon fa-refresh"></i></a></td>
                        </tr>
                    </table>
                </c:if>
			<!-- 检索  -->
		
		
			<table id="table_report" class="table table-hover" style="white-space: nowrap;">
				<thead>
					<tr>
                        <th>
                            <label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
                        </th>
						<th>序号</th>
						<th>姓名</th>
                        <th>医院</th>
                        <th>科室</th>
                        <th>科室医生</th>
                        <th>体检状态</th>
                        <th>审核状态</th>
                        <th>团体名称</th>
                        <th>部门</th>
                        <th>体检卡号</th>
                        <th>体检卡类型</th>
                        <th>体检套餐</th>
                        <th>干预卡状态</th>
                        <th>干预卡号</th>
                        <th>手机号</th>
                        <th>性别</th>
						<th>出生年月</th>
						<th>学历</th>
						<th>职业</th>
						<th>录入时间</th>
						<th>报告生成时间</th>
						<th>报告审核时间</th>
						<th>审核医生</th>
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
								<td style="width: 40px;">${vs.index+1}</td>
                                <td>${var.name}</td>
                                <td>${var.hospitalName}</td>
                                <td>${var.checkOfficeName}</td>
                                <td>${var.checkDoctorName}</td>
                                <td>${var.checkStatusName}</td>
                                <td>${var.reportStatusName}</td>
                                <td>
                                    <c:if test="${var.groupName != null && var.groupName != ''}">${var.groupName}</c:if>
                                    <c:if test="${var.groupName == null || var.groupName == ''}">个体</c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${var.department==null||var.department==''}">无</c:when>
                                        <c:otherwise>${var.department}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${var.checkCardNum}</td>
                                <td>${var.checkCardTypeName}</td>
                                <td>${var.checkPackageName}</td>
                                <td>${var.treatCardStatusName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${var.treatCardNum==null||var.treatCardNum==''}">无</c:when>
                                        <c:otherwise>${var.treatCardNum}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${var.mobile}</td>
                                <td>${var.genderName}</td>
                                <td>${var.birthday}</td>
                                <td>${var.degree}</td>
                                <td>
                                    <c:if test="${var.career != null && var.career != ''}">${var.career}</c:if>
                                    <c:if test="${var.career == null || var.career == ''}">无</c:if>
                                </td>
                                <td>${var.createTime}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${var.reportTime==null||var.reportTime==''}">无</c:when>
                                        <c:otherwise>${var.reportTime}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${var.auditTime==null||var.auditTime==''}">无</c:when>
                                        <c:otherwise>${var.auditTime}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${var.auditDoctorName==null||var.auditDoctorName==''}">无</c:when>
                                        <c:otherwise>${var.auditDoctorName}</c:otherwise>
                                    </c:choose>
                                </td>
								<td style="width: 70px;" class="">
									<div style="text-align: right;">
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="fa fa-lock" title="无权限"></i></span>
										</c:if>
                                        <div class="inline position-relative">
                                            <c:if test="${QX.cha== 1 }">
                                                <c:if test="${var.checkStatus==1}">
                                                    <a class='btn btn-mini btn-info' title="单次报告" onclick="showReport('${var.reportId}');">单次报告</a>
                                                </c:if>
                                                <c:if test="${(pd.origin!=null||pd.origin!='')&&pd.origin!='history'}">
                                                    <a class='btn btn-mini btn-info' title="历史记录" href="<%=basePath%>patientitem/itemList.do?origin=history&mobile=${var.mobile}">历史记录</a>
                                                </c:if>
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
                    <c:if test="${(pd.origin==null||pd.origin=='')||(pd.origin=='alert')}">
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
		var min_age = $(".age_range:selected").attr("data-min-age");
		var max_age = $(".age_range:selected").attr("data-max-age");
		$("#min_age").val(min_age);
		$("#max_age").val(max_age);
		//alert($("#min_age").val());
		//alert($("#max_age").val());
		return false;
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
        window.location.href="<%=basePath%>patientitem/itemList/excel?patientItemIds="+ids;
    }

	//新增
	function add(){
		 BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientitem/goAdd.do'),
            title: '新增'
          });
	}
	
	//修改
	function edit(id){
		BootstrapDialog.show({cssClass:'two-row-dialog',
            message: $('<div></div>').load('<%=basePath%>patientitem/goEdit/'+id),
            title: '编辑'
          });
	}
	
	//去体检报告详情页面
	function showReport(id){
        window.location.href='<%=basePath%>patientcheckreport/goShowReport/'+id;
	}

	//删除
	function del(id){
		var url = "<%=basePath%>patientitem/delete/"+id;
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
		var url = '<%=basePath%>patientitem/deleteBatch';
		ajaxDeleteBatch(url);
	}
	
	function searchReset(){
		$("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
	}
</script>
		
	</body>
</html>