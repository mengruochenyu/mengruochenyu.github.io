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
    <%@ include file="../../system/admin/top.jsp" %>

    <!--zTree-->
    <script type="text/javascript" src="<%=basePath%>static/js/zTree/jquery.ztree.all.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>static/css/zTree/metroStyle.css" />
    <script>
        var setting= {
            view: {
                dblClickExpand: true,
                showLine: false,
                selectedMulti: false
            },
            async:{
                enable:false,
                autoParam:["id"],
                type:"get",
                dataType:"json",
                url:"<%=basePath%>hospital/tree/async"
            },
            check:{
                enable:true
            },
            data: {
                simpleData: {
                    enable:true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: "0"
                }
            },
            callback: {
                onAsyncSuccess:zTreeOnAsyncSuccess,
                onAsyncError:zTreeOnAsyncError
            }
        };

        function zTreeOnAsyncSuccess(event, treeId, treeNode, data) {
        }

        function zTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
            bootbox.alert("加载失败");
        }

        var classIdPrefix="c_";
        var sheetIdPrefix="s_";
        var zNodes =[
            <c:if test="${not empty classifyList}">
                <c:forEach items="${classifyList}" var="var" varStatus="vs">
                    <c:if test="${vs.index!=0}">,</c:if>
                    {id:classIdPrefix+"${var.id}", pId:0, rawId:"${var.id}", name:"${var.name}", open:false,isParent:true}
                </c:forEach>
            </c:if>
            <c:if test="${not empty sheetList}">
                <c:forEach items="${sheetList}" var="var">
                    ,{
                        id:sheetIdPrefix+"${var.id}", pId:classIdPrefix+"${var.classify}", rawId:"${var.id}", name:"${var.name}",open:false,isParent:false,checked:false
                    }
                </c:forEach>
            </c:if>
        ];
        var zTree;
        $(document).ready(function(){
            var t = $("#tree1");
            zTree=$.fn.zTree.init(t, setting, zNodes);
            t.hide();
            $(".date-picker").datepicker();
        });
        function pcgOrSheetOnChange() {
            var value=$("#pcgOrSheet").val();
            if(value==0){
                $("#packageId").show();
                $("#tree1").hide();
            }else{
                $("#packageId").hide();
                $("#tree1").show();
            }
        }

    </script>

    <script type="text/javascript">
        function popupTip(field, msg){
            $("#"+field).tips({
                side:3,
                msg:msg,
                bg:'#AE81FF',
                time:2
            });
            $("#" + field).focus();
        }

        //保存
        function exportData(target){
            var selectNodes=zTree.getCheckedNodes(true);
            var selectSheetIds=[];
            if(selectNodes!=null&&selectNodes.length>0){
                for(var i=0;i<selectNodes.length;i++){
                    var node=selectNodes[i];
                    if(!node.isParent){
                        selectSheetIds.push(node.rawId);
                    }
                }
            }
            $("#sheetIds").val(selectSheetIds);
//            document.getElementById("editForm").submit();
            window.location.href="<%=basePath%>patientCheckData/exportExcel.do?"+$("#editForm").serialize();
        }
    </script>
</head>
<body>
<form action="<%=basePath%>patientCheckData/exportExcel.do" name="editForm" id="editForm" enctype="multipart/form-data" method="post">
    <input type="hidden" name="sheetIds" id="sheetIds" value=""/>
    <div id="zhongxin" style="padding-top:20px;">
        <table id="table_report" class="noline">
            <tr>
                <td style="width: 150px;text-align: right;">开始日期：</td>
                <td style="width: 210px;">
                    <input class="span10 date-picker" name="startDate" id="startDate" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:200px;" placeholder="开始日期"/>
                </td>
            </tr>
            <tr>
                <td style="width: 150px;text-align: right;">结束日期：</td>
                <td style="width: 210px;">
                    <input class="span10 date-picker" name="endDate" id="endDate" value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:200px;" placeholder="结束日期"/>
                </td>
            </tr>
            <tr>
                <td style="width: 150px;text-align: right;">医院：</td>
                <td style="width: 210px;">
                    <select id="hospitalId" name="hospitalId" style="width: 200px;">
                        <option value="">选择医院</option>
                        <c:forEach items="${hospitalList}" var="hospital" varStatus="vs">
                            <option value="${hospital.id}">${hospital.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 150px;text-align: right;">
                    <select id="pcgOrSheet" name="pcgOrSheet" onchange="pcgOrSheetOnChange()" style="width: 115px;">
                        <option value="0">按套餐筛选</option>
                        <option value="1">按量表筛选</option>
                    </select>：
                </td>
                <td style="width: 210px;">
                    <ul id="tree1" class="ztree" style="width:260px;max-height: 200px; overflow:auto;"></ul>
                    <select id="packageId" name="packageId" style="width: 200px;">
                        <c:if test="${not empty packageList}">
                            <c:forEach items="${packageList}" varStatus="vs" var="var">
                                <option value="${var.id}">${var.name}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="10" style="text-align: center;">
                    <a class="btn btn-small btn-success" style="width: 100px;" onclick="exportData(this);">确认导出</a>
                </td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>