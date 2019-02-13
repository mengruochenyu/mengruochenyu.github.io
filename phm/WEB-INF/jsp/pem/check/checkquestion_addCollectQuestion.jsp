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
    <style>
        img{border:1px solid #ddd;border-radius:10px;}
    </style>
    <script type="text/javascript">

        //保存
        function save(target){
            //保存被选择的问题内容
            var contType = $("#contType").val();
            if(contType == 0){
                $("#quesCon2").remove();
            }else{
                $("#quesCon1").remove();
            }
            //保存被选择的选项
            var optionType = $("#optionType").val();
            if(optionType == 0){
                $(".optionType2").remove();
            }else{
                $(".optionType1").remove();
            }
            return true
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

        $(".newspic").click(function() {
            $(this).next('input').click();
        });

        function showPic(data) {
            if (data.files && data.files[0]) {
                var reader = new FileReader();
                reader.onload = function(evt) {
                    data.parentNode.childNodes[1].childNodes[1].src = evt.target.result;
                };
                reader.readAsDataURL(data.files[0]);
            }
        }

        function add(target){
            var selectBoxes=$("[name='ids']:checked");
            var sortable=$("#sortable");
            for(var i=0;i<selectBoxes.length;i++){
                var obj=selectBoxes[i];
                var id=$(obj).val();
                var description=$(obj).attr("data-description");
                var contType=$(obj).attr("data-contType");
                var html=
                    "<li class=\"ui-state-default row\" style=\"border-color:red;\">" +
                        "<div class=\"col-md-4\">" +
                        "<input type=\"hidden\" name=\"quesId\" value=\""+id+"\">" +
                        "<input type=\"button\" class=\"button btn btn-primary\"  onclick=\"deleteQuestion(this)\" value=\"移除\">\n" +
                        (contType==0?("<span>"+description+"</span>"):("<img style=\"width:100px;height:50px;\" src=\"<%=basePath%>"+description+"\"/>"))+
                        "</div>"+
                        "<div class=\"col-md-4\" style=\"text-align: right;width: 60%;\">数据采集题目</div>"
                    +"</li>";
                sortable.prepend(html);
            }
            hideDialog(target);
        }

        function cancel(target){
            hideDialog(target);
        }
    </script>
</head>
<body>
    <form action="checksheet/saveQuestionForSheet.do" name="editForm" id="editForm" method="post" enctype="multipart/form-data" onsubmit="return save();">
        <table id="table_report" class="table table-hover">
            <thead>
                <tr>
                    <th>
                        <label><input type="checkbox" id="zcheckbox" class="ace" /><span class="lbl"></span></label>
                    </th>
                    <th>序号</th>
                    <th>题干</th>
                    <th>单选/多选</th>
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
                                    <label><input type='checkbox' name='ids' class="ace" data-contType="${var.contType}" data-description="${var.description}" value="${var.id}" /><span class="lbl"></span></label>
                                </td>
                                <td style="width: 40px;">${vs.index+1}</td>
                                <td>${var.description}</td>
                                <td><c:if test="${var.type==1}">单选</c:if><c:if test="${var.type==2}">多选</c:if></td>
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
                    <td style="vertical-align:top;text-align: center;">
                        <a class="btn btn-small btn-success" onclick="add(this);">确定添加</a>
                        <a class="btn btn-small" onclick="cancel(this);">取消</a>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>