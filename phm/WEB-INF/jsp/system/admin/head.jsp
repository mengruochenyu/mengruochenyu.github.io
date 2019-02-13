<div id="navbar" class="navbar navbar-default ace-save-state">
			<div class="navbar-container ace-save-state" id="navbar-container">
				<!-- #section:basics/sidebar.mobile.toggle -->
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="fa fa-bar"></span>

					<span class="fa fa-bar"></span>

					<span class="fa fa-bar"></span>
				</button>

				<!-- /section:basics/sidebar.mobile.toggle -->
				<div class="navbar-header pull-left">
					<!-- #section:basics/navbar.layout.brand -->
					<a href="#" class="navbar-brand">
						<small>
							<img alt="" src="static/img/logo.png" style="width:26px;height:26px;margin-top:-3px;"></img>
							${pd.SYSNAME}
						</small>
					</a>

					<!-- /section:basics/navbar.layout.brand -->

					<!-- #section:basics/navbar.toggle -->

					<!-- /section:basics/navbar.toggle -->
				</div>

				<!-- #section:basics/navbar.dropdown -->
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<!-- #section:basics/navbar.user_menu -->
						<li class="dropdown-modal">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<span id="user_info">
							</span>

								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul id="user_menu" class="user-menu dropdown-menu-right dropdown-menu dropdown-caret dropdown-close"
							style="min-width:160px">
								<li><a onclick="editUserH();" style="cursor:pointer;"><i class="ace-icon fa fa-user"></i> 修改资料</a></li>
								<li><a onclick="changePassword();" style="cursor:pointer;"><i class="ace-icon fa fa-user"></i> 修改密码</a></li>
								
								<c:if test="${sessionScope.sessionUser.roleId == 1}">
									<li><a onclick="menu();" style="cursor:pointer;"><i class="ace-icon fa fa-cogs"></i> 菜单管理</a></li>
								</c:if>
							<li class="divider"></li>
							<li><a href="logout"><i class="ace-icon fa fa-power-off"></i> 退出</a></li>
						</li>

						<!-- /section:basics/navbar.user_menu -->
					</ul>
				</div>

				<!-- /section:basics/navbar.dropdown -->
			</div><!-- /.navbar-container -->
		</div>
	
	
		<!--引入属于此页面的js -->
		<script type="text/javascript" src="static/js/myjs/head.js?v=1"></script>
		<script type="text/javascript">
			//修改密码
			function changePassword(){
				 BootstrapDialog.show({cssClass:"one-row-dialog",
			        message: $('<div></div>').load(locat+'/userInfo/goChangePassword.do'),
			        title: '修改密码',
			      });
			}
		</script>
