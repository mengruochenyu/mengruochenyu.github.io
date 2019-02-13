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
			popupTip('name', '请输入类型名称');
			return false;
		}
		/* if($("#parentId").val()==""){
			popupTip('parentId', '请输入上级类型id');
			return false;
		} */
		if($("#remark").val()==""){
			popupTip('remark', '请输入备注');
			return false;
		}
	
		var action = '${msg}';
		var url = 'systempackagetype/' + action;
		ajaxSave(target, url, action);
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
	<form action="systempackagetype/${msg}.do" name="editForm" id="editForm" method="post">
		<input type="hidden" name="id" id="id" value="${entity.id}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>类型名称:</td>
				<td><input type="text" name="name" id="name" value="${entity.name}" maxlength="32" placeholder="请输入类型名称"/></td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>套餐类型</td>
				<td style="padding-right: 20px;">
                  <span class="">
                      <select name="parentId" id="parentId">
                          <option value="0">(一级类型)</option>
                          <c:choose>
                              <c:when test="${not empty bigTypeList}">
                                  <c:forEach items="${bigTypeList}" var="packageType">
                                      <option value="${packageType.id}" <c:if test="${packageType.id==entity.parentId}">selected</c:if>>${packageType.name}</option>
                                   </c:forEach>
                              </c:when>
                          </c:choose>
                      </select>
                  </span>
                  <i class="fa fa-search" title="选择'一级类型'即代表创建一级分类项；&#10;选择'其他类型'即代表创建该分类下的二级分类项；"></i>
              </td>
			</tr>
			<tr><td style="width:80px;text-align: right;padding-top: 13px;"><em>*</em>备注:</td>
				<td><textarea style="width:250px; resize:none; height:80px;" name="remark" id="remark" placeholder="请输入备注">${entity.remark}</textarea></td>
			</tr>
			<tr><td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr><td style="text-align: center;" colspan="10">
					<a id="saveBtn" class="btn btn-primary" style="width:100px" onclick="save(this);">保存</a>
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>