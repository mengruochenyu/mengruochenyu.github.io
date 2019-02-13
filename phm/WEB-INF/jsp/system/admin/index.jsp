<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="top.jsp"%>
	
	<script type="text/javascript">
		$("#sidebar-collapse").on("click",function(){
      $("#sidebar").toggleClass("menu-min");
      $(this.firstChild).toggleClass("icon-double-angle-right");
      a=$("#sidebar").hasClass("menu-min");
     // document.cookie="hasMenu="+a+";";
     if(a){$(".open > .submenu").removeClass("open")}
      }
		);
	</script>
	<link rel="stylesheet" href="static/extend/css/style.css?v=18" />
	<script type="text/javascript"  src="static/extend/js/contabs.js?v=10" ></script>
</head>
<body class="no-skin" onready="setContentHeight()">
	<!-- 页面顶部¨ -->
	<%@ include file="head.jsp"%>
	<div lass="main-container ace-save-state" id="main-container">
		<script type="text/javascript">
				try{ace.settings.loadState('main-container')}catch(e){}
			</script>

		<script type="text/javascript">
			function setContentHeight(){
				var content = document.getElementById("content-main");
				var bheightT = document.documentElement.clientHeight;
				content.style.height = (bheightT  - 45 - 45) + 'px';
			}
			window.onload = function(){
				setContentHeight();
			}
			window.onresize=function(){  
				setContentHeight();
			};
		</script>	
		<!-- menu toggler -->

		<!-- 左侧菜单 -->
		<%@ include file="left.jsp"%>

		<div id="main-content" class="main-content">
			<div class="main-content-inner" style="height:100%">
				<!-- #section:basics/content.breadcrumbs -->
				<div id="jzts" style="display:none; width:100%; position:fixed; z-index:99999999;">
					<div style="padding-left: 45%;padding-top: 20%;">
						<div style="float: left;margin-top: 3px;"><img src="static/images/loading2.gif" /> </div>
					</div>
				</div>
				
				<div class="content-tabs">
	                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
	                </button>
	                <nav class="page-tabs J_menuTabs">
	                    <div class="page-tabs-content">
	                        <a href="javascript:;" class="active J_menuTab" data-id="login_default">首页</a>
	                    </div>
	                </nav>
	                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
	                </button>
	            </div>
	            
	            
				<div class="J_mainContent" id="content-main">
	                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="<%=basePath%>login_default.do" frameborder="0" data-id="login_default" seamless></iframe>
	            </div>
			</div>	

		</div>
		<!-- #main-content -->
	</div>
	
</body>
</html>
