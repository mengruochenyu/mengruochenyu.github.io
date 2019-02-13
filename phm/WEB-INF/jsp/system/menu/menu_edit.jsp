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
			$(top.hangge());	
			$(document).ready(function(){
					if($("#menuId").val()!=""){
						var parentId = $("#pId").val();
						if(parentId=="0"){
							$("#parentId").attr("disabled",true);
						}else{
							$("#parentId").val(parentId);
							$("#form-field-radio1").attr("disabled",true);
							$("#form-field-radio2").attr("disabled",true);
							$("#form-field-radio1").attr("checked",false);
							$("#form-field-radio2").attr("checked",false);
						}
					}
				});
				
				var menuUrl = "";
				function setMUR(){
					menuUrly = $("#menuUrl").val();
					if(menuUrly != ''){menuUrl = menuUrly;}
					if($("#parentId").val()=="0"){
						$("#menuUrl").attr("readonly",true);
						$("#menuUrl").val("");
						$("#form-field-radio1").attr("disabled",false);
						$("#form-field-radio2").attr("disabled",false);
					}else{
						$("#menuUrl").attr("readonly",false);
						$("#menuUrl").val(menuUrl);
						$("#form-field-radio1").attr("disabled",true);
						$("#form-field-radio2").attr("disabled",true);
						$("#form-field-radio1").attr("checked",false);
						$("#form-field-radio2").attr("checked",false);
					}
				}
				
				//保存
				function save(target){
					if($("#menuName").val()==""){
						
						$("#menuName").tips({
							side:3,
				            msg:'请输入菜单名称',
				            bg:'#AE81FF',
				            time:2
				        });
						
						$("#menuName").focus();
						return false;
					}
					if($("#menuUrl").val()==""){
						$("#menuUrl").val('#');
					}
					if($("#menuOrder").val()==""){
						
						$("#menuOrder").tips({
							side:1,
				            msg:'请输入菜单序号',
				            bg:'#AE81FF',
				            time:2
				        });
						
						$("#menuOrder").focus();
						return false;
					}
					
					if(isNaN(Number($("#menuOrder").val()))){
						
						$("#menuOrder").tips({
							side:1,
				            msg:'请输入菜单序号',
				            bg:'#AE81FF',
				            time:2
				        });
						
						$("#menuOrder").focus();
						$("#menuOrder").val(1);
						return false;
					}

					var action = 'edit';
					var url = 'menu/rest/' + action;
					ajaxSave(target, url, action, null, null, function(){
						$("#leftMenuId").load('<%=basePath%>menu.do');
					});

					return false;
				}
				
				function setType(value){
					$("#menuType").val(value);
				}
		</script>
		
	</head>
	
	<body>
		<form action="menu/edit.do" name="menuForm" id="menuForm" method="post">
			<input type="hidden" name="menuId" id="menuId" value="${pd.menu_id}"/>
			<input type="hidden" name="pId" id="pId" value="${pd.parent_id}"/>
			<input type="hidden" name="menuType" id="menuType" value="${pd.menu_type }"/>
			<div id="zhongxin">
			<table>
				<tr>
					<td>
						<select name="parentId" id="parentId" onchange="setMUR()" title="菜单">
							<option value="0">顶级菜单</option>
							<c:forEach items="${menuList}" var="menu">
								<option value="${menu.menuId }">${menu.menuName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><input type="text" name="menuName" id="menuName" placeholder="请输入菜单名称" value="${pd.menu_name }" title="名称"/></td>
				</tr>
				<tr>
					<td><input type="text" name="menuUrl" id="menuUrl" placeholder="请输入链接地址" value="${pd.menu_url }" title="地址"/></td>
				</tr>
				<tr>
					<td><input type="number" name="menuOrder" id="menuOrder" placeholder="请输入序号" value="${pd.menu_order}" title="序号"/></td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');" <c:if test="${pd.menuType == '1' }">checked="checked"</c:if> type="radio" value="fa fa-edit"><span class="lbl">系统菜单</span></label>
						<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" <c:if test="${pd.menuType != '1' }">checked="checked"</c:if> type="radio" value="fa fa-edit"><span class="lbl">业务菜单</span></label>
					</td>
				</tr>
				<tr>
				<td style="text-align: center; padding-top: 10px;">
					<a class="btn btn-primary" onclick="save(this);">保存</a>
					
				</td>
			</tr>
			</table>
			</div>
		</form>
	</body>
</html>