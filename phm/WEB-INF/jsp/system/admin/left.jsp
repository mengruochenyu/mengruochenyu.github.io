<%
	String pathl = request.getContextPath();
	String basePathl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+pathl+"/";
%>
<style type="text/css">
    *::-webkit-scrollbar{width:10px;height:10px;}
	*::-webkit-scrollbar-button{width:0px; height:0px;}
	*::-webkit-scrollbar-track{background:#f7f7f7;}
	*::-webkit-scrollbar-thumb{background:#cfcfd1;}
	*::-webkit-scrollbar-track,*::-webkit-scrollbar-thumb{border-radius:5px;}
	*::-webkit-scrollbar-corner,*::-webkit-scrollbar-resizer,*::-webkit-scrollbar-button{background:#fff;}
    
</style>
<script type="text/javascript">
	$(function () {
		resizeMenu();
		$(window).resize(function() {
			resizeMenu();
		});
	});
	
	function resizeMenu(){
		var parentHeight = $(document).height() - 60;
		$("#sidebar").height(parentHeight);
		if($("#sidebar").width() > 100){
			$("#sidebar").css("overflow-y", "auto");
			$("#sidebar").css("overflow-x", "hidden");
		}else{
			$("#sidebar").css("overflow-y", "");
			$("#sidebar").css("overflow-x", "");
		}
	}
	
	function collapseClick(){
		if($("#sidebar").width() > 100){
			$("#sidebar").css("overflow-y", "");
			$("#sidebar").css("overflow-x", "");
		}else{
			$("#sidebar").css("overflow-y", "auto");
			$("#sidebar").css("overflow-x", "hidden");
		}
	}
</script>

		<!-- 本页面涉及的js函数，都在head.jsp页面中     -->
		<div id="sidebar" class="sidebar responsive ace-save-state" style="zindex:9999">
				<ul class="nav nav-list">

					<li class="active" id="fhindex">
						<a href="main/index">
							<i class="menu-icon fa fa-tachometer"></i>
							<span class="menu-text"> 首页 </span>
						</a>

						<b class="arrow"></b>
					</li>



			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
				<li id="lm${menu.menuId }">
					  <a style="cursor:pointer;" class="dropdown-toggle" >
						<i class="menu-icon ${menu.menuId == null || menu.menuIcon == 'icon-desktop' ? 'fa fa-desktop' : menu.menuIcon}"></i>
						<span class="menu-text">${menu.displayName }</span>
						<b class="arrow fa fa-angle-down"></b>
					  </a>

					  <ul class="submenu">
							<c:forEach items="${menu.subMenu}" var="sub">
								<c:if test="${sub.hasMenu}">
								<c:choose>
									<c:when test="${not empty sub.menuUrl}">
									<li id="z${sub.menuId }">
										<a style="cursor:pointer;" class="J_menuItem" 
											url="${sub.menuUrl }" index="lm${menu.menuId }" text="${sub.displayName }" >
											<i class="menu-icon fa fa-caret-right"></i>${sub.displayName }
										</a>
										<b class="arrow"></b>
									</li>
									</c:when>
									<c:otherwise>
									<li><a href="javascript:void(0);"><i class="menu-icon fa fa-caret-right"></i>${sub.displayName }</a></li>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:forEach>
				  		</ul>
				</li>
				</c:if>
			</c:forEach>

				</ul><!--/.nav-list-->

				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse" onclick="collapseClick()">
					<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

			</div><!--/#sidebar-->

