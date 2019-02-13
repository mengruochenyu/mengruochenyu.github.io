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
$(function(){
		var action = '${msg}';
		var num =5;
 		if(action == 'edit'){			
			num =${optionNum};
		} 
 		//展示选项
		for(i= 1;i<num+1;i++){
			$("#tr"+i).show();
		}	
 		//查看时，参数制度，隐藏继续添加和保存按钮
 		var operationType = ${operationType};
 		if(operationType == 2){
 			$("input").attr("readonly","readonly");
 			$("button").hide();
 		}
 		
 		//添加选项
 		$("#addMore").click(function(){
			num++;			
			if(num>15){
				alert("最多添加15个选项！")
				return false;
			}
			$("#tr"+num).show();
 		}) 
	}) 
	
	//保存
	function save(target){
/* 		if($("#name").val()==""){
			popupTip('name', '请输入名称');
			return false;
		}
		if($("#description").val()==""){
			popupTip('description', '请输入内容');
			return false;
		}
		if($("#type").val()==""){
			popupTip('type', '请输入类型');
			return false;
		} */
	
		//var action = '${msg}';
		//alert();
		//var url = 'checkquestion/saveQuestion';
		//ajaxSave(target, url, action);
		//return false;
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
	
</script>
	</head>
<body>
	<form action="checkquestion/saveQuestion.do" name="editForm" id="editForm" method="post" onsubmit="return save();">
		<input type="hidden" name="questionId" id="questionId" value="${entity.questionId}"/>
		<div id="zhongxin" style="padding-top:20px;">
		<table id="table_report" class="table noline">
			<tr>
<!-- 				<td style="width:80px;text-align: right;padding-top: 13px;">题目</td> -->
                <td colspan="3"><label></label><textarea type="text" style="width:480px;" name="question" id="question"  placeholder="请输入题目">${entity.question}</textarea></td>
			</tr>
			<tr>
				<td>
					<label style="width:350px;text-align:center">选项</label>
				</td>
				<td>	
					<label style="width:50px;text-align:center" >分值</label>
				</td>
				<td>
					<label style="width:30px;text-align:center">序号</label>
				</td> 
			</tr>
			<tr id="tr1" style="display:none;">		
				<td>
					<input  type="hidden" name="optionId1" id="optionId1" value="${entity.optionId1}"/>
					<input style="width:350px;" type="text" name="option1" id="option1" value="${entity.option1}" maxlength="32" placeholder="请输入选项A"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score1" id="score1" value="${entity.score1}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq1" id="seq1" value="${entity.seq1}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr2" style="display:none;">
				<td>
					<input type="hidden" name="optionId2" id="optionId2" value="${entity.optionId2}"/>
					<input style="width:350px;" type="text" name="option2" id="option2" value="${entity.option2}" maxlength="32" placeholder="请输入选项B"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score2" id="score2" value="${entity.score2}" maxlength="32" placeholder="分数"/>
				</td>				
				<td>
					<input style="width:50px;" type="text" name="seq2" id="seq2" value="${entity.seq2}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr3" style="display:none;">
				<td>
					<input type="hidden" name="optionId3" id="optionId3" value="${entity.optionId3}"/>
					<input style="width:350px;" type="text" name="option3" id="option3" value="${entity.option3}" maxlength="32" placeholder="请输入选项C"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score3" id="score3" value="${entity.score3}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq3" id="seq3" value="${entity.seq3}"  title="序号" placeholder="序号"/>
				</td> 				
			</tr>
			<tr id="tr4" style="display:none;">
				<td>
					<input type="hidden" name="optionId4" id="optionId4" value="${entity.optionId4}"/>
					<input style="width:350px;" type="text" name="option4" id="option4" value="${entity.option4}" maxlength="32" placeholder="请输入选项D"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score4" id="score4" value="${entity.score4}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq4" id="seq4" value="${entity.seq4}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr5" style="display:none;">
				<td>
					<input type="hidden" name="optionId5" id="optionId5" value="${entity.optionId5}"/>
					<input style="width:350px;" type="text" name="option5" id="option5" value="${entity.option5}" maxlength="32" placeholder="请输入选项E"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score5" id="score5" value="${entity.score5}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq5" id="seq5" value="${entity.seq5}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr6" style="display:none;">
				<td>
					<input type="hidden" name="optionId6" id="optionId6" value="${entity.optionId6}"/>
					<input style="width:350px;" type="text" name="option6" id="option6" value="${entity.option6}" maxlength="32" placeholder="请输入选项F"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score6" id="score6" value="${entity.score6}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq6" id="seq6" value="${entity.seq6}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr7"  style="display:none;">
				<td>
					<input type="hidden" name="optionId7" id="optionId7" value="${entity.optionId7}"/>
					<input style="width:350px;" type="text" name="option7" id="option7" value="${entity.option7}" maxlength="32" placeholder="请输入选项G"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score7" id="score7" value="${entity.score7}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq7" id="seq7" value="${entity.seq7}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr8" style="display:none;">
				<td>
					<input type="hidden" name="optionId8" id="optionId8" value="${entity.optionId8}"/>
					<input style="width:350px;" type="text" name="option8" id="option8" value="${entity.option8}" maxlength="32" placeholder="请输入选项H"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score8" id="score8" value="${entity.score8}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq8" id="seq8" value="${entity.seq8}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr9" style="display:none;">
				<td>
					<input type="hidden" name="optionId9" id="optionId9" value="${entity.optionId9}"/>
					<input style="width:350px;" type="text" name="option9" id="option9" value="${entity.option9}" maxlength="32" placeholder="请输入选项I"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score9" id="score9" value="${entity.score9}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq9" id="seq9" value="${entity.seq9}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr10" style="display:none;">
				<td>
					<input type="hidden" name="optionId10" id="optionId10" value="${entity.optionId10}"/>
					<input style="width:350px;" type="text" name="option10" id="option10" value="${entity.option10}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>	
					<input style="width:50px;" type="text" name="score10" id="score10" value="${entity.score10}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq10" id="seq10" value="${entity.seq10}"  title="序号" placeholder="序号"/>
				</td> 
			</tr>
			<tr id="tr11" style="display:none;">
				<td>
					<input type="hidden" name="optionId11" id="optionId11" value="${entity.optionId11}"/>
					<input style="width:350px;" type="text" name="option11" id="option11" value="${entity.option11}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="score11" id="score11" value="${entity.score11}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq11" id="seq11" value="${entity.seq11}"  title="序号" placeholder="序号"/>
				</td>
			</tr>
			<tr id="tr12" style="display:none;">
				<td>
					<input type="hidden" name="optionId12" id="optionId12" value="${entity.optionId12}"/>
					<input style="width:350px;" type="text" name="option12" id="option12" value="${entity.option12}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="score12" id="score12" value="${entity.score12}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq12" id="seq12" value="${entity.seq12}"  title="序号" placeholder="序号"/>
				</td>
			</tr>
			<tr id="tr13" style="display:none;">
				<td>
					<input type="hidden" name="optionId13" id="optionId13" value="${entity.optionId13}"/>
					<input style="width:350px;" type="text" name="option13" id="option13" value="${entity.option13}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="score13" id="score13" value="${entity.score13}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq13" id="seq13" value="${entity.seq13}"  title="序号" placeholder="序号"/>
				</td>
			</tr>
			<tr id="tr14" style="display:none;">
				<td>
					<input type="hidden" name="optionId14" id="optionId14" value="${entity.optionId14}"/>
					<input style="width:350px;" type="text" name="option14" id="option14" value="${entity.option14}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="score14" id="score14" value="${entity.score14}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq14" id="seq14" value="${entity.seq14}"  title="序号" placeholder="序号"/>
				</td>
			</tr>
			<tr id="tr15" style="display:none;">
				<td>
					<input type="hidden" name="optionId15" id="optionId15" value="${entity.optionId15}"/>
					<input style="width:350px;" type="text" name="option15" id="option15" value="${entity.option15}" maxlength="32" placeholder="请输入选项J"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="score15" id="score15" value="${entity.score15}" maxlength="32" placeholder="分数"/>
				</td>
				<td>
					<input style="width:50px;" type="text" name="seq15" id="seq15" value="${entity.seq15}"  title="序号" placeholder="序号"/>
				</td>
			</tr>
			<tr>
				<td id="successMessage" style="text-align: center;display:none;color:#045e9f" colspan="10">
					保存成功
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<button  class=" btn  btn-info" id="addMore" type="button" style="margin-right:100px;" >继续添加</button>
					<button  class=" btn btn-small btn-success" type="submit" >保存</button>
				</td>
			</tr>
		</table>
		</div>
		
	</form>
</body>
</html>