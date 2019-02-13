<%@page import="com.blue.pem.common.HospitalAccountRoleEnum"%>
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

    <!--zTree-->
    <script type="text/javascript" src="<%=basePath%>static/js/zTree/jquery.ztree.all.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>static/css/zTree/metroStyle.css" />

    <script>
        var setting = {
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
                    rootPId: ""
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
                        id:sheetIdPrefix+"${var.sheetId}", pId:classIdPrefix+"${var.classify}", rawId:"${var.sheetId}", name:"${var.sheetName}",open:false,isParent:false
                        ,checked:"<c:if test='${var.isSelected==1}'>true</c:if>"
                    }
                </c:forEach>
            </c:if>
        ];

        var zTree;
        $(document).ready(function(){
            var t = $("#tree");
            zTree=$.fn.zTree.init(t, setting, zNodes);
        });

        //保存
        function savePackageSheets(target){
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
            var url="<%=basePath%>checkpackage/savePackageSheets.do?packageId=${packageInfo.id}&sheetIds="+selectSheetIds.toString();
            var ajaxObject={
                url:url,
                data:{},
                success:function (data) {
                    if(data.code==200){
                        showSuccessMessage();
                        window.location.reload();
                        hideDialog(target);
                    }else{
                        bootbox.alert(data.msg);
                    }
                }
            };
            ajaxPost(ajaxObject);
        }
    </script>
    <style>
        .modal-content{
            min-height:300px !important;
        }
    </style>
</head>
<body>
<div class="container-fluid" id="main-container">
    <ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>
    <div style="width: 100%;">
        <a class="btn btn-small btn-success" onclick="savePackageSheets(this);">保存</a>
    </div>
</div>
<script type="text/javascript">
</script>
</body>
</html>