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
    <div class="container-fluid" id="main-container1">
        <div id="page-content1" class="clearfix">
            <div class="row-fluid">
                <div class="row-fluid">
                    <!-- 检索  -->
                    <form action="hospitalofficedoctor/list.do" method="post" name="Form" id="Form">
                        <input type="hidden" value="${hospitalOffice.id}" name="officeId" >
                        <b>${hospital.name}-${hospitalOffice.name}</b>医生列表
                        <table id="table_report1" class="table table-hover">
                            <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>姓名</th>
                                    <th>备注</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <c:forEach items="${varList}" var="var" varStatus="vs">
                                            <tr>
                                                <td style="width: 40px;">${vs.index+1}</td>
                                                <td>${var.doctorName}</td>
                                                <td>${var.remark}</td>
                                                <td style="width: 70px;" class="center">
                                                <div>
                                                    <div class="inline position-relative">
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
                                        <a class="btn btn-small btn-success" onclick="add();">新增科室医生</a>
                                        <a class="btn btn-small btn-info" onclick="javascript:window.history.back(-1);">返回科室列表</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        //检索
        function search(){
            top.jzts();
            $("#Form").submit();
        }

        //新增
        function add(){
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>hospitalofficedoctor/goAdd.do?officeId=${hospitalOffice.id}'),
                title: '新增科室医生'
            });
        }

        //修改
        function edit(id){
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>hospitalofficedoctor/goEdit/'+id+"?officeId=${hospitalOffice.id}"),
                title: '编辑'
            });
        }

        //删除
        function del(id){
            var url = "<%=basePath%>hospitalofficedoctor/delete/"+id;
            ajaxDelete(url);
        }

        //新增套餐
        function addPackage(officeId){
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>checkpackage/goAdd.do?officeId='+officeId),
                title: '新增科室套餐'
            });
        }
    </script>

    <script type="text/javascript">

        $(function(){
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
            var url = '<%=basePath%>hospitalofficedoctor/deleteBatch';
            ajaxDeleteBatch(url);
        }

        function searchReset(){
            $("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
        }
    </script>
</body>
</html>