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
		<style>
			img{border:1px solid #ddd;border-radius:10px;}
		</style>
        <script type="text/javascript">
            $(function(){
            	//展示选项
                var num = ${optionNum};
                for(i= 1;i<num+1;i++){
                    $("#tr"+i).show();
                }
                //添加选项
                $("#addMore").click(function(){
                    num++;
                    if(num>10){
                        alert("最多添加10个选项！")
                        return false;
                    }
                    $("#tr"+num).show();
                })
            });

            //这个方法用来获取应该返回的图片的路径
            var disposeImg = function(imgId){
            	var idDecoment = "#"+imgId;
            	var checkOImg = $(idDecoment).parent().find("img").attr('src');
            	if (checkOImg.indexOf("static/img/default_upload_option.png",0) > 0) {
            		return "";
				}
            	checkOImg = checkOImg.substring(checkOImg.indexOf("upload",0),checkOImg.length);
            	return checkOImg;
            };
            
            //保存
            function save(target){
            	var sheetId = $("#sheetId").val();
            	//构建传输载体：
        		var formData = new FormData();
        		formData.append("optionId1", $("#optionId1").val());
        		formData.append("optionId2", $("#optionId2").val());
        		formData.append("optionId3", $("#optionId3").val());
        		formData.append("optionId4", $("#optionId4").val());
        		formData.append("optionId5", $("#optionId5").val());
        		formData.append("optionId6", $("#optionId6").val());
        		formData.append("optionId7", $("#optionId7").val());
        		formData.append("optionId8", $("#optionId8").val());
        		formData.append("optionId9", $("#optionId9").val());
        		formData.append("optionId10", $("#optionId10").val());
        		formData.append("score1", $("#score1").val());
        		formData.append("score2", $("#score2").val());
        		formData.append("score3", $("#score3").val());
        		formData.append("score4", $("#score4").val());
        		formData.append("score5", $("#score5").val());
        		formData.append("score6", $("#score6").val());
        		formData.append("score7", $("#score7").val());
        		formData.append("score8", $("#score8").val());
        		formData.append("score9", $("#score9").val());
        		formData.append("score10", $("#score10").val());
        		formData.append("seq1", $("#seq1").val());
        		formData.append("seq2", $("#seq2").val());
        		formData.append("seq3", $("#seq3").val());
        		formData.append("seq4", $("#seq4").val());
        		formData.append("seq5", $("#seq5").val());
        		formData.append("seq6", $("#seq6").val());
        		formData.append("seq7", $("#seq7").val());
        		formData.append("seq8", $("#seq8").val());
        		formData.append("seq9", $("#seq9").val());
        		formData.append("seq10", $("#seq10").val());
        		formData.append("textOption1", $("#textOption1").val());
        		formData.append("textOption2", $("#textOption2").val());
        		formData.append("textOption3", $("#textOption3").val());
        		formData.append("textOption4", $("#textOption4").val());
        		formData.append("textOption5", $("#textOption5").val());
        		formData.append("textOption6", $("#textOption6").val());
        		formData.append("textOption7", $("#textOption7").val());
        		formData.append("textOption8", $("#textOption8").val());
        		formData.append("textOption9", $("#textOption9").val());
        		formData.append("textOption10", $("#textOption10").val());
        		formData.append("imgOption1", (document.getElementById('imgOption1').files[0] == undefined)?disposeImg("imgOption1"):document.getElementById('imgOption1').files[0]);
        		formData.append("imgOption2", (document.getElementById('imgOption2').files[0] == undefined)?disposeImg("imgOption2"):document.getElementById('imgOption2').files[0]);
        		formData.append("imgOption3", (document.getElementById('imgOption3').files[0] == undefined)?disposeImg("imgOption3"):document.getElementById('imgOption3').files[0]);
        		formData.append("imgOption4", (document.getElementById('imgOption4').files[0] == undefined)?disposeImg("imgOption4"):document.getElementById('imgOption4').files[0]);
        		formData.append("imgOption5", (document.getElementById('imgOption5').files[0] == undefined)?disposeImg("imgOption5"):document.getElementById('imgOption5').files[0]);
        		formData.append("imgOption6", (document.getElementById('imgOption6').files[0] == undefined)?disposeImg("imgOption6"):document.getElementById('imgOption6').files[0]);
        		formData.append("imgOption7", (document.getElementById('imgOption7').files[0] == undefined)?disposeImg("imgOption7"):document.getElementById('imgOption7').files[0]);
        		formData.append("imgOption8", (document.getElementById('imgOption8').files[0] == undefined)?disposeImg("imgOption8"):document.getElementById('imgOption8').files[0]);
        		formData.append("imgOption9", (document.getElementById('imgOption9').files[0] == undefined)?disposeImg("imgOption9"):document.getElementById('imgOption9').files[0]);
        		formData.append("imgOption10", (document.getElementById('imgOption10').files[0] == undefined)?disposeImg("imgOption10"):document.getElementById('imgOption10').files[0]);
        		formData.append("questionId", $("#questionId").val());
        		formData.append("contType", $("#contType").val());
        		formData.append("optionType", $("#optionType").val());
        		formData.append("funcType", $("#funcType").val());
        		formData.append("type", $("#choice:checked").val());
        		formData.append("sheetId", sheetId);
        		formData.append("questionText", $("#questionText").val());
        		formData.append("questionImg", (document.getElementById('questionImg').files[0] == undefined)?$("#questionImg").val():document.getElementById('questionImg').files[0]);
        		
        		$.ajax({
        			url: "checkquestion/savequestionandoption.do",
        			async: false,
        			type: "POST",
        			data: formData,
        			processData: false,
        			contentType: false,
        			success: function(data) {
       					location.href = 'checksheet/list.do';
        			},
        			error: function(xhr) {
        				console.log("erro");
       					console.log(xhr);
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

            $(".newspic").click(function() {
                $(this).next('input').click();
            });

            //图片的点击事件在这里，预览图片的实现
            function showPic(data) {
                if (data.files && data.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(evt) {
                        data.parentNode.childNodes[3].childNodes[1].src = evt.target.result;
                    }
                    reader.readAsDataURL(data.files[0]);
                }
            }
        </script>
</head>
<body>
    <form action="" name="editForm" id="editForm" method="post" enctype="multipart/form-data" onsubmit="return save();">
        <div>
            <label>单选/多选&nbsp;&nbsp;</label>
            <label class="radio-inline">
                <input id="choice" type="radio" class="type" name="type"  value="1" <c:if test="${entity.type==1 || entity.type==null}">checked</c:if>> 单选
            </label>
            <label class="radio-inline">
                <input id="choice" type="radio" class="type" name="type" value="2" <c:if test="${entity.type==2}">checked</c:if>> 多选
            </label>
        </div>
        <input type="hidden" name="questionId" id="questionId" value="${entity.questionId}"/>
        <input type="hidden" name="contType" id="contType" value="${entity.contType}"/>
        <input type="hidden" name="optionType" id="optionType" value="${entity.optionType}"/>
        <input type="hidden" name="funcType" id="funcType" value="${pd.funcType}"/>
        <input type="hidden" name="sheetId" id="sheetId" value="${sheetId}"/>
        <div id="zhongxin" style="padding-top:20px;">
            <table id="table_report" class="table noline">
                <tr>
                    <td colspan="4" id="quesCon1" style="">
                        <textarea style="width:480px;" name=questionText id=questionText  placeholder="请输入题目">${entity.questionText}</textarea>
                    </td>
                </tr>
                <tr>
                	<td colspan="4" id="quesCon1" style="">
                		<!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.questionImg != null and entity.questionImg != ''}"><img style="width:250px;height:120px;" src="<%=basePath%>${entity.questionImg}"/></c:if>
                            <c:if test="${entity.questionImg == null or entity.questionImg == ''}"><img style="width:250px;height:120px;"  src="<%=basePath%>static/img/default_upload_question.png"/></c:if>
                        </a>
                        <input type="file" id="questionImg" name=questionImg onchange="showPic(this)"  style="display: none"/>
                	</td>
                </tr>
                <tr>
                    <td>
                        <label style="width:210px;text-align:center">选项</label>
                    </td>
                    <td>
                        <label style="width:100px;text-align:center;" >图片</label>
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
                    	<textarea style="width:210px;resize:none;" name=textOption1 id="textOption1"  placeholder="请输入选项A">${entity.textOption1}</textarea>
                    </td>
                    <td>
                    	<!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic" >
                            <c:if test="${entity.imgOption1 != null and entity.imgOption1 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption1}"/></c:if>
                            <c:if test="${entity.imgOption1 == null or entity.imgOption1 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption1" name="imgOption1" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score1" id="score1" value="${entity.score1}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq1" id="seq1" value="${entity.seq1}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr2" style="display:none;">
                    <td  >
                        <input type="hidden" name="optionId2" id="optionId2" value="${entity.optionId2}"/>
                        <textarea style="width:210px;resize:none;" name=textOption2 id="textOption2"  placeholder="请输入选项B">${entity.textOption2}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption2 != null and entity.imgOption2 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption2}"/></c:if>
                            <c:if test="${entity.imgOption2 == null or entity.imgOption2 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption2" name="imgOption2" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score2" id="score2" value="${entity.score2}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq2" id="seq2" value="${entity.seq2}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr3" style="display:none;">
                    <td  >
                        <input type="hidden" name="optionId3" id="optionId3" value="${entity.optionId3}"/>
                        <textarea style="width:210px;resize:none;" name=textOption3 id="textOption3"  placeholder="请输入选项C">${entity.textOption3}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption3 != null and entity.imgOption3 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption3}"/></c:if>
                            <c:if test="${entity.imgOption3 == null or entity.imgOption3 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption3" name="imgOption3" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score3" id="score3" value="${entity.score3}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq3" id="seq3" value="${entity.seq3}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr4" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId4" id="optionId4" value="${entity.optionId4}"/>
                        <textarea style="width:210px;resize:none;" name=textOption4 id="textOption4"  placeholder="请输入选项D">${entity.textOption4}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption4 != null and entity.imgOption4 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption4}"/></c:if>
                            <c:if test="${entity.imgOption4 == null or entity.imgOption4 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption4" name="imgOption4" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score4" id="score4" value="${entity.score4}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq4" id="seq4" value="${entity.seq4}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr5" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId5" id="optionId5" value="${entity.optionId5}"/>
                        <textarea style="width:210px;resize:none;" name=textOption5 id="textOption5"  placeholder="请输入选项E">${entity.textOption5}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption5 != null and entity.imgOption5 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption5}"/></c:if>
                            <c:if test="${entity.imgOption5 == null or entity.imgOption5 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption5" name="imgOption5" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score5" id="score5" value="${entity.score5}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq5" id="seq5" value="${entity.seq5}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr6" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId6" id="optionId6" value="${entity.optionId6}"/>
                        <textarea style="width:210px;resize:none;" name=textOption6 id="textOption6"  placeholder="请输入选项F">${entity.textOption6}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption6 != null and entity.imgOption6 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption6}"/></c:if>
                            <c:if test="${entity.imgOption6 == null or entity.imgOption6 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption6" name="imgOption6" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score6" id="score6" value="${entity.score6}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq6" id="seq6" value="${entity.seq6}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr7"  style="display:none;">
                    <td >
                        <input type="hidden" name="optionId7" id="optionId7" value="${entity.optionId7}"/>
                        <textarea style="width:210px;resize:none;" name="textOption7" id="textOption7"  placeholder="请输入选项G">${entity.textOption7}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption7 != null and entity.imgOption7 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption7}"/></c:if>
                            <c:if test="${entity.imgOption7 == null or entity.imgOption7 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption7" name="imgOption7" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score7" id="score7" value="${entity.score7}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq7" id="seq7" value="${entity.seq7}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr8" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId8" id="optionId8" value="${entity.optionId8}"/>
                        <textarea style="width:210px;resize:none;" name="textOption8" id="textOption8"  placeholder="请输入选项H">${entity.textOption8}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption8 != null and entity.imgOption8 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption8}"/></c:if>
                            <c:if test="${entity.imgOption8 == null or entity.imgOption8 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption8" name="imgOption8" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score8" id="score8" value="${entity.score8}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq8" id="seq8" value="${entity.seq8}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr9" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId9" id="optionId9" value="${entity.optionId9}"/>
                        <textarea style="width:210px;resize:none;" name=textOption9 id="textOption9"  placeholder="请输入选项I">${entity.textOption9}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption9 != null and entity.imgOption9 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption9}"/></c:if>
                            <c:if test="${entity.imgOption9 == null or entity.imgOption9 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption9" name="imgOption9" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score9" id="score9" value="${entity.score9}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq9" id="seq9" value="${entity.seq9}"  title="序号" placeholder="序号"/>
                    </td>
                </tr>
                <tr id="tr10" style="display:none;">
                    <td >
                        <input type="hidden" name="optionId10" id="optionId10" value="${entity.optionId10}"/>
                        <textarea style="width:210px;resize:none;" name=textOption10 id="textOption10"  placeholder="请输入选项J">${entity.textOption10}</textarea>
                    </td>
                    <td>
                        <!-- 下面是图片的元素 --> 
                        <a href="javascript:void(0)" class="newspic">
                            <c:if test="${entity.imgOption10 != null and entity.imgOption10 != ''}"><img style="width:100px;height:50px;" src="<%=basePath%>${entity.imgOption10}"/></c:if>
                            <c:if test="${entity.imgOption10 == null or entity.imgOption10 == ''}"><img style="width:100px;height:50px;"  src="<%=basePath%>static/img/default_upload_option.png"/></c:if>
                        </a>
                        <input type="file" class="optCon2" id="imgOption10" name="imgOption10" onchange="showPic(this)"  style="display: none"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="score10" id="score10" value="${entity.score10}" placeholder="分数"/>
                    </td>
                    <td>
                        <input style="width:50px;" type="text" name="seq10" id="seq10" value="${entity.seq10}"  title="序号" placeholder="序号"/>
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