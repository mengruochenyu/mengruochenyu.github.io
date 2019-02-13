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
        function save(target){
            if($("#name").val()==""){
                popupTip('name', '请输入批次名称');
                return false;
            }
            if($("#cardCount").val()==""){
                popupTip('cardCount', '请输入卡片数量');
                return false;
            }
            if($("#cardCount").val()>10000||$("#cardCount").val()<0){
                popupTip('cardCount', '一次只能生成10000张卡片');
                return false;
            }
            if($("#validTimeStart").val()==""){
                popupTip('validTimeStart', '请选择开始时间');
                return false;
            }
            if(new Date($("#validTimeStart").val())<new Date(new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate())){
                popupTip('validTimeStart', '开始时间不能早于当前时间');
                return false;
            }
            if($("#validTimeEnd").val()==""){
                popupTip('validTimeEnd', '请选择结束时间');
                return false;
            }
            if(new Date($("#validTimeEnd").val())<=new Date($("#validTimeStart").val())){
                popupTip('validTimeEnd', '结束时间不能早于开始时间');
                return false;
            }

            var action = 'addBatch.do';
            var url = 'cardtreatment/' + action;

            var formItem = getFormItem(target);
            var data = serializeArray(formItem);

            var batchName=$("#name").val();

            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify(data),
                dataType:'json',
                contentType: "application/json;charset=UTF-8",
                cache: false,
                success: function(data){
                    if(200 == data.code){
                        showSuccessMessage();
                        if(confirm("干预卡生成成功，是否导出excel表格？")){
                            window.location.href= '<%=basePath%>cardtreatment/excel.do?batchName='+batchName;
                        }
                        hideDialog(target);
                    }else if(data.msg){
                        bootbox.alert(data.msg);
                    }else{
                        bootbox.alert("保存失败");
                    }
                },
                error: function(data){
                    hideSavingMessage(target);
                    bootbox.alert("出现异常");
                }
            });

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
<form action="cardtreatment/addBatch.do" name="editForm" id="editForm" method="post">
    <input type="hidden" value="2" name="cardType">
    <input type="hidden" value="${hospital.id}" name="hospitalId">
    <div id="zhongxin" style="padding-top:20px;">
        <table id="table_report" class="table noline">
            <tr>
                <td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>批次名称:</td>
                <td><input type="text" name="name" id="name" value="" maxlength="32" placeholder="请输入批次名称"/></td>
            </tr>
            <tr>
                <td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>卡片数量:</td>
                <td><input type="number" name="cardCount" id="cardCount" value="" maxlength="4" placeholder="请输入卡片数量"/></td>
            </tr>
            <tr>
                <td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>有效期开始时间:</td>
                <td><input type="text" name="validTimeStart" id="validTimeStart" class="date-picker" value="" maxlength="32" data-date-format="yyyy-mm-dd" placeholder="请选择时间" readonly/></td>
            </tr>
            <tr>
                <td style="width:160px;text-align: right;padding-top: 13px;"><em>*</em>有效期结束时间:</td>
                <td><input type="text" name="validTimeEnd" id="validTimeEnd" class="date-picker" value="" maxlength="32" data-date-format="yyyy-mm-dd" placeholder="请选择时间" readonly/></td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="10">
                    <a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">批量生成</a>
                </td>
            </tr>
        </table>
    </div>
    <script>
        $(".date-picker").datepicker();
    </script>
</form>
</body>
</html>