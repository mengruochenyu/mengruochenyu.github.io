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

    <script type="text/javascript">

        //保存
        function excelExport(target){
            if($("#batchName").val()==""){
                popupTip('batchName', '请选择批次');
                return false;
            }

            var batchName=$("#batchName").val();

            window.location.href= '<%=basePath%>cardentity/excel.do?batchName='+batchName;

            hideDialog(target);
            return false;
        }

        function popupTip(field, msg){
            $("#"+field).tips({
                side:3,
                msg:msg,
                bg:'#AE81FF',
                time:2
            });
            $("#" + field).focus();
        }

    </script>
</head>
<body>
<form action="cardentity/addBatch.do" name="editForm" id="editForm" method="post">
    <div id="zhongxin" style="padding-top:20px;">
        <table id="table_report" class="table noline">
            <tr>
                <td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>批次:</td>
                <td>
                    <select id="batchName" name="batchName">
                        <option value="">请选择</option>
                        <c:if test="${not empty batchNameList}">
                            <c:forEach items="${batchNameList}" var="batchName">
                                <option value="${batchName}">${batchName}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="10">
                    <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="excelExport(this)">导出</a>
                </td>
            </tr>
        </table>
    </div>
    <script>
    </script>
</form>
</body>
</html>