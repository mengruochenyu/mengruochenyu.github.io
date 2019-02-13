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
                    enable:true,
                    autoParam:["id"],
                    type:"get",
                    dataType:"json",
                    url:"<%=basePath%>hospital/tree/async"
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
            };

            function zTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
                bootbox.alert("加载失败");
            }
            
            var zNodes =[
                {id:"h_${hospital.id}", pId:0, name:"${hospital.name}", open:true,isParent:true}
            ];

            var zTree;
            $(document).ready(function(){
                var t = $("#tree");
                zTree=$.fn.zTree.init(t, setting, zNodes);

                var root=zTree.getNodeByTId("h_${hospital.id}");
                zTree.expandNode(root,true);
            });
        </script>
        <style>
            .modal-content{
                min-height:300px !important;
            }
        </style>
	</head>
    <body>
        <div class="container-fluid" id="main-container">
            <div id="page-content" class="clearfix">
                <ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>
            </div>
        </div>
        <script type="text/javascript">
        </script>
    </body>
</html>