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
                        <!-- 检索  -->
                        <form action="checkquestion/list.do?funcType=2" method="post" name="Form" id="Form">
                            <table>
                                <tr>
                                    <td>
                                        <span class="input-icon">
                                            <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name}" placeholder="这里输入关键词" />
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
                                        <th>
                                        <label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
                                        </th>
                                        <th>题目ID</th>
                                        <th>题干</th>
                                        <th>单选/多选</th>
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
                                                <td style="width: 30px;">
                                                    <label><input type='checkbox' name='ids' class="ace" value="${var.id}" /><span class="lbl"></span></label>
                                                </td>
                                                <td style="width: 40px;">${var.id}</td>
                                                <td>
                                                    <c:if test="${var.contType==0}">${var.description}</c:if>
                                                    <c:if test="${var.contType==1}">
                                                        <img src="<%=basePath%>${var.description}" style="max-height: 120px;max-width: 180px;">
                                                    </c:if>
                                                </td>
                                                <td><c:if test="${var.type==1}">单选</c:if><c:if test="${var.type==2}">多选</c:if></td>
                                                <td style="width: 160px;" class="center">
                                                    <div>
                                                        <div class="inline position-relative">
                                                            <a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.id}');">编辑</a>
                                                            <a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.id}');">删除</a>
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
                                        <a class="btn btn-small btn-danger" onclick="makeAll();" title="删除" ><i class='fa fa-trash'></i></a>
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

        //新增数据采集题目
        function add(){
             BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>checkquestion/goAddCheckQuestion.do?funcType=2'),
                title: '新增'
              });
        }

        //查看
        function showDetail(id){
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>checkquestion/goShowDetail/'+id),
                title: '查看详情'
              });
        }
        //修改
        function edit(quesId){
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>checkquestion/goEdit?quesId='+quesId),
                title: '编辑'
              });
        }
        //批量操作--导入题目到试卷
        function addQuetionToSheet(){
            var questions=$("[name='ids']:checked");//DOM对象数组
            var len = questions.length;
            if(len == 0){
                alert("请至少选择一道题目！");
                return false;
            }
            var idArray = new Array();
            for(var i=0 ; i<len;i++){
                idArray[i] = $(questions[i]).val();
            }
            var idsStr = idArray.join(",");
            //alert(idsStr);
            BootstrapDialog.show({cssClass:'two-row-dialog',
                message: $('<div></div>').load('<%=basePath%>checkquestion/goAddQuetionToSheet/'+idsStr),
                title: '编辑'
              });
        }
        //删除
        function del(id){
            var url = "<%=basePath%>checkquestion/delete/"+id;
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
            var url = '<%=basePath%>checkquestion/deleteBatch';
            ajaxDeleteBatch(url);
        }

        function searchReset(){
            $("#Form").find(':input').not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
        }
    </script>

        </body>
</html>