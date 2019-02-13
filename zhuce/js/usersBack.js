var token = getCookie("pemUtoken");

var uType = getCookie("pemUtype");

/**测试题--缓存之前已选答案信息(按量表缓存)
 * explain:必须在testing页面之前存好，如果在testing页面存的话，每次修改缓存后，一加载页面又变成登录时加载的数据了
 * @page:userInfo
 */
function partSheetAnswer() {
    var oneSheetSubInfo = {};
    for(var i = 0; i < sheetList.length; i++){
        var questionOptions = [];
        var items = sheetList[i].items;
        var totalTime = 0;
        for(var j = 0; j < items.length; j++){
            var oneQuestions = {};
            oneQuestions.sheetId = sheetList[i].sheetInfo.id;
            oneQuestions.questionId = items[j].questionId;
            if(items[j].time == ""){
                oneQuestions.time = 0;
                totalTime = totalTime;
            }else{
                oneQuestions.time = items[j].time;
                totalTime = totalTime + items[j].time;
            }
            oneQuestions.funcType = items[j].funcType;
            var optionList = items[j].optionList;
            var oneAnswerIds = [];
            for(var m = 0; m<optionList.length; m++){
                if(optionList[m].selected == 1){
                    oneAnswerIds.push(optionList[m].optionId);
                }
            }
            oneQuestions.optionIds = oneAnswerIds;
            questionOptions.push(oneQuestions);
        }
        var sheetId = sheetList[i].sheetInfo.id;
        oneSheetSubInfo.sheetId = sheetId;
        oneSheetSubInfo.time = totalTime;
        oneSheetSubInfo.questionOptions = questionOptions;
        localStorage.setItem("sheet"+sheetId,JSON.stringify(oneSheetSubInfo));
    }
}
/**测试题-套餐列表及套餐里的量表列表（从缓存中获取）
 * @page:testing
 * */
function packageFun() {
    packageSheets = JSON.parse(localStorage.getItem("packageSheets"));
    var innerHtml = '';
    var checkStateNum = 0; //所有量表的答题完成总数
    var sheetNum = 0;//量表总数
    for(var m = 0; m < packageSheets.length; m++){
        if(packageSheets.length == 0){
            $("#listBox").html('<div class="pd5 text-center"><i class="ic ic-no-info"></i><p class="gray">没有数据显示</p></div>');
            $(".pages").remove();
            $(".JSSubmit").hide();
        }else{
            innerHtml += '<div class="row mt20 mb20">';
            innerHtml +=     '<div class="col-xs-12 col-md-12"><div class="taocanName" style="padding-left:2px;">'+packageSheets[m].packageInfo.name+'</div></div>';
            innerHtml += '</div>';
            var pkSheetList = packageSheets[m].sheetList;
            if(pkSheetList.length > 0){
                for(var i = 0; i < pkSheetList.length; i++){
                    sheetNum ++;
                    innerHtml += '<div class="row test">';
                    innerHtml +=     '<div class="col-xs-12 col-md-10 cont">';
                    innerHtml +=         '<h3>'+pkSheetList[i].sheetName+'</h3>';
                    innerHtml +=         '<div class="txt">'+pkSheetList[i].sheetDescription+'</div>';
                    innerHtml +=         '<div class="row">';
                    innerHtml +=             '<div class="col-xs-6 col-md-4">检测单位：'+pkSheetList[i].hospitalName+'</div>';
                    innerHtml +=             '<div class="col-xs-6 col-md-3">卡号：'+pkSheetList[i].cardNum+'</div>';
                    innerHtml +=             '<div class="col-xs-6 col-md-3">开卡时间：'+pkSheetList[i].activeTime+'</div>';
                    if(pkSheetList[i].checkStatus == 1){
                        checkStateNum++;
                        innerHtml +=             '<div class="col-xs-6 col-md-2">状态：已完成</div>';
                    }else{
                        innerHtml +=             '<div class="col-xs-6 col-md-2">状态：未完成</div>';
                    }
                    innerHtml +=         '</div>';
                    innerHtml +=     '</div>';
                    innerHtml +=     '<div class="col-xs-12 col-md-2 text-center"><div class="btn-box">';
                    if(pkSheetList[i].checkStatus == 0){//1已完成 0未开始答题 2一开始答题但未完成
                        innerHtml += '<a href="javascript:;" onclick="testingAnswerGuide('+pkSheetList[i].sheetId+')" data-id="'+pkSheetList[i].sheetId+'" id="btn_'+pkSheetList[i].sheetId+'" class="mbtn" data-state="'+pkSheetList[i].checkStatus+'">开始答题</a>';
                    }
                    if(pkSheetList[i].checkStatus == 1){
                        innerHtml += '<a href="javascript:;" class="mbtn mbtn-gray" data-state="'+pkSheetList[i].checkStatus+'">答题完毕</a>';
                    }
                    if(pkSheetList[i].checkStatus == 2){
                        innerHtml += '<a href="javascript:;" onclick="startCheck('+pkSheetList[i].sheetId+')" data-id="'+pkSheetList[i].sheetId+'" id="btn_'+pkSheetList[i].sheetId+'" class="mbtn" data-state="'+pkSheetList[i].checkStatus+'">继续答题</a>';
                    }
                    innerHtml +=     '</div></div>';
                    innerHtml += '</div>';
                }
                $("#listBox").html(innerHtml);
                htmlHeight();

                //总提交按钮状态(套餐是否提交1是0否)
                /*if(packageSheets[m].packageInfo.isFinished == 1){
                    $("#testSubmit").attr("disabled",true);
                }else{
                    var stateNumber = 0;
                    $("#listBox").find(".mbtn").each(function () {
                        var state = parseInt($(this).attr('data-state'));
                        if(state == 1){
                            stateNumber++
                        }
                    })
                    if(sheetList.length == stateNumber){
                        $("#testSubmit").removeAttr("disabled");
                    }
                }*/
            }
        }
    }
    if(checkStateNum == sheetNum){
        $("#testSubmit").removeAttr("disabled");
    }else{
        $("#testSubmit").attr("disabled",true);
    }
}
/**测试题-试题指导语
 * @page:testing
 * */
function testingAnswerGuide(sheetId) {
    $("#testlist").hide();
    $("#testGuide").show();
    $("#testQuestion").hide();
    var pkSheetList = null;
    for(var m = 0; m < packageSheets.length; m++){
        pkSheetList = packageSheets[m].sheetList;//套餐量表
        for(var i = 0; i < pkSheetList.length; i++){
            if(sheetId == pkSheetList[i].sheetId){
                $("#guideBox").html(pkSheetList[i].sheetDescription);
            }
        }
    }
    var innerHtml = '';
    innerHtml += '<div class="text-center mt40" id="btnStartBox">';
    innerHtml +=     '<a href="javascript:;" class="btn btn-danger bg-red pdlr30 ml10" id="btnStart" onclick="startCheck('+sheetId+')">开始测试</a>';
    innerHtml += '</div>';
    var newHtml = '<a href="javascript:;" class="btn btn-danger bg-red pdlr30 ml10" id="btnStart" onclick="startCheck('+sheetId+')">开始测试</a>'
    if($("#btnStartBox").length == 0){//不存在按钮
        $("#guideBox").after(innerHtml);
    }else{                            //存在替换
        $("#btnStartBox").html(newHtml);
    }
    htmlHeight();
}
/**测试题-开始作答
 * @page:testing
 * */
function startCheck(sheetId) {
    $("#testlist").hide();
    $("#testGuide").hide();
    $("#testQuestion").show();
    number = getMarkSeq(sheetId);//得到当前下标并赋值给number
    sheetQuestion(sheetId);      //从缓存获取题目
    stop();                      //停止计时(防止做了一量表没有提交又去做下一量表)
    startTimer();                //开始计时
}
/**测试题-计时器
 * @page:testing
 * */
//开始
function startTimer() {
    int = setInterval(timer,50);
}
//计时
function timer() {
    millisecond = millisecond + 50;
    if(millisecond >= 1000){
        millisecond = 0;
        second = second + 1;
        sheetSecond = sheetSecond + 1;
    }
}
//重置
function Reset() {
    window.clearInterval(int);
    sheetSecond=millisecond=second=0;
    //document.getElementById('timetext').value='00时00分00秒000毫秒';
}
//暂停
function stop() {
    window.clearInterval(int);
}
/**测试题--从缓存中获取单个题目跟答案
 * @page:testing
 * @param:sheetId量表ID
 */
var nowQInfo = ''; //当前这套题目的信息
var nowQList =  '';//当前这套题目的题目跟答案
function sheetQuestion(sheetId) {
    for(var i = 0; i < sheetList.length; i++){
        if(sheetId == sheetList[i].sheetInfo.id){
            nowQInfo = sheetList[i].sheetInfo;
            nowQList = sheetList[i].items;
        }
    }
    $("#sheetName").text(nowQInfo.name);
    $("#sheetName").attr({"data-id":sheetId});

    totalResult = nowQList.length;       //当前这套题的题目总条数
    $("#totalNumber").text(totalResult);//总条数
    $("#nowNumber").text(number+1);     //当前第几条
    //进度条
    var divide = 100/totalResult;//每等分值
    var percent = number*divide;//第几等分所占值
    $("#progress").css("width",percent+"%");
    //最后一题---答题进度100%
    if(number == totalResult-1){
        percent = totalResult*divide;//第几等分所占值
        $("#progress").css("width",percent+"%");
    }

    //按钮各种情况的显示
    if(number == totalResult-1){
        $("#btnPre").show();
        $("#btnNext").hide();
        $("#btnSubmit").show();
    }else if(number == 0){
        $("#btnPre").hide();
        $("#btnNext").show();
        $("#btnSubmit").hide();
    }else{
        $("#btnPre").show();
        $("#btnNext").show();
        $("#btnSubmit").hide();
    }

    //单个题目跟答案HTML
    var qHtml = quizAnswersHtml(nowQList[number],number+1);
    $("#quizBox").html(qHtml);
    htmlHeight();

    //根据之前的选中值设置(选中状态)
    $("#quizBox").find(".radio").each(function () {
        var selected = $(this).attr('data-select');
        if(selected == 1){
            $(this).addClass("active");
            $(this).find(".ic").addClass("ic-radio-active");
        }
    })
    //选中
    $(".radio").click(function(){
        checkAnswer($(this),sheetId);
    })
}
/**测试题--做题选答案-存答案 HTML
 * @page: testing
 * @param: ths当前答案标签,sheetId量表Id
 */
function checkAnswer(ths,sheetId){
    var type = JSON.parse(ths.siblings(".a-title").attr("data-type"));            //当前答案类型 1单选 2多选
    var questionId = JSON.parse(ths.siblings(".a-title").attr("data-questionid"));//当前选中题目Id
    var answerId = JSON.parse(ths.attr("data-optionid"));                         //当前选中答案Id
    var oneSheetInfo = {};
    oneSheetInfo = JSON.parse(localStorage.getItem("sheet"+sheetId));         //当前量表原来选的信息
    if(oneSheetInfo != null){
        var questionOptions = oneSheetInfo.questionOptions;
        for(var i = 0; i<questionOptions.length; i++){
            if(questionId == questionOptions[i].questionId){
                answerIds = questionOptions[i].optionIds;//原来选的答案
            }
        }
    }
    /**添加(或修改)答案**/
    //改变答案的selected值 1选中0没选中
    var index1 = -1, index2 = -1, index3 = -1;
    for(var i = 0; i < sheetList.length; i++){
        if(sheetId == sheetList[i].sheetInfo.id){
            index1 = i;
            var items = sheetList[i].items;
            for(var j = 0; j < items.length; j++){
                if(items[j].questionId == questionId){
                    index2 = j;
                    var optionList = items[j].optionList;
                    for(var m = 0; m < optionList.length; m++){
                        if(answerId == optionList[m].optionId){
                            index3 = m;
                        }
                    }
                }
            }
        }
    }
    //选中效果//answerIds(单选追加当前ID，多选追加多个ID、再选删除ID)
    if(type == 1){
        ths.addClass("active");
        ths.find(".ic").addClass("ic-radio-active");
        ths.siblings().removeClass("active");
        ths.siblings().find(".ic").removeClass("ic-radio-active");
        answerIds = [];
        answerIds.push(answerId);
        //改变答案选中状态值selected
        var cOptionList = sheetList[index1].items[index2].optionList;
        for(var m = 0; m < cOptionList.length; m++){
            cOptionList[m].selected = 0;
        }
        sheetList[index1].items[index2].optionList[index3].selected = 1;
        localStorage.setItem("sheetListInfo", JSON.stringify(sheetList));
    }
    if(type == 2){
        if(ths.hasClass("active")){
            ths.removeClass("active");
            ths.find(".ic").removeClass("ic-radio-active");
            if(answerIds.indexOf(answerId) == -1){                //不存在
                answerIds.push(answerId);                         //追加
                //改变答案选中状态值selected
                sheetList[index1].items[index2].optionList[index3].selected = 1;
            }else{
                answerIds.splice($.inArray(answerId,answerIds),1);//删除当前ID
                //改变答案选中状态值selected
                sheetList[index1].items[index2].optionList[index3].selected = 0;
            }
        }else{
            ths.addClass("active");
            ths.find(".ic").addClass("ic-radio-active");
            answerIds.push(answerId);
            //改变答案选中状态值selected
            sheetList[index1].items[index2].optionList[index3].selected = 1;

        }
        localStorage.setItem("sheetListInfo", JSON.stringify(sheetList));
    }

    /**赋值(或重新赋值)量表信息**/
    var questions = {};
    questions.sheetId = nowQInfo.id;
    questions.questionId = questionId;
    questions.funcType = type;
    questions.time = second;
    questions.optionIds = answerIds;
    if(oneSheetInfo != null) {
        oneSheetInfo.sheetId = questions.sheetId;
        var options = oneSheetInfo.questionOptions;
        var index = findElem(options,"questionId",questionId);       //判定当前questionId是否在已选择的题目列表(oneSheetInfo)里
        if(index == -1){ //问题(不存在)追加
            options.push(questions);
            localStorage.setItem("sheet"+sheetId, JSON.stringify(oneSheetInfo));
        }else{           //问题(存在)修改
            if(oneSheetInfo.time != 0){
                oneSheetInfo.time = sheetSecond + oneSheetInfo.time;//量表总时间(原来选的)
            }else{
                oneSheetInfo.time = sheetSecond;
            }
            for (var i = 0; i < options.length; i++) {
                if (options[i].questionId == questionId) {
                    options[i].optionIds = answerIds;
                    if(options[i].time != 0){
                        options[i].time = options[i].time;//单题时间(原来选的)
                    }else{
                        options[i].time = second;
                    }
                }
            }
            localStorage.setItem("sheet"+sheetId, JSON.stringify(oneSheetInfo));
        }
    }else{//第一次赋值
        var questionOptions = [];
        oneSheetInfo = {
            questionOptions: questionOptions,
            sheetId: sheetId,
            time: 0
        };
        oneSheetInfo.questionOptions.push(questions);
        localStorage.setItem("sheet"+sheetId, JSON.stringify(oneSheetInfo));
    }
    /**修改套餐答题状态(第一次选择就改变)**/
    if(number == 0){
        for(var m = 0; m < packageSheets.length; m++){
            for(var i = 0; i < packageSheets[m].sheetList.length; i++){
                if(packageSheets[m].sheetList[i].sheetId == sheetId){
                    packageSheets[m].sheetList[i].checkStatus = 2;
                    localStorage.setItem("packageSheets", JSON.stringify(packageSheets));
                    break;
                }
            }
        }
    }
    //单选时调用
    if(type == 1){
        //下一题
        if(number < totalResult-1) {
            number = getMarkSeq(sheetId);//得到当前下标赋值给number
            number++;
            setMarkSeq(sheetId);//改变当前下标
        }
        goSubmitOneQuestion(sheetId,questionId);
        second = 0;//一道题目计时结束
    }
}
/**测试题--单个答案HTML
 * @page:testing
 */
function answersHtml(answers,csNumber) {
    var innerHtml = '';
    innerHtml += '<div class="radio {pic}" data-optionId="{optionId}" data-select="{selected}" style="{marginLeft}">';
    innerHtml +=     '<i class="ic ic-radio"></i>';
    innerHtml +=     '{answer}';
    innerHtml += '</div>';
    innerHtml = innerHtml.replace("{optionId}",answers.optionId);
    innerHtml = innerHtml.replace("{selected}",answers.selected);
    if(answers.contType == 0){//文字
        innerHtml = innerHtml.replace("{pic}","");
        innerHtml = innerHtml.replace("{answer}",answers.description);
    }
    if(answers.contType == 1){//图片
        innerHtml = innerHtml.replace("{pic}","pic");
        var imgHtml = '<img src="'+answers.description+'" class="aImg" />';
        if(csNumber>9)
            innerHtml = innerHtml.replace("{marginLeft}","margin-left:40px");
        innerHtml = innerHtml.replace("{answer}",imgHtml);
    }
    return innerHtml;
}
/**测试题--单个题目跟答案HTML
 * @page:testing
 */
function quizAnswersHtml(quizAnswers,csNumber) {
    var innerHtml = '';
    innerHtml += '<div class="a-title mb20 clearfix" data-questionId="{questionId}" data-type="{type}">{num}.{qTitle}</div>';
    for(var i = 0; i<quizAnswers.optionList.length;i++){
        var answer = answersHtml(quizAnswers.optionList[i],csNumber);
        innerHtml += answer;
    }
    innerHtml = innerHtml.replace("{questionId}",quizAnswers.questionId);
    innerHtml = innerHtml.replace("{type}",quizAnswers.type);
    innerHtml = innerHtml.replace("{num}",csNumber);
    if(quizAnswers.contType == 0){//文字
        innerHtml = innerHtml.replace("{qTitle}",quizAnswers.description);
    }
    if(quizAnswers.contType == 1){//图片
        var imgHtml = '<img src="'+quizAnswers.description+'" class="tImg" />';
        innerHtml = innerHtml.replace("{qTitle}",imgHtml);
    }
    //判断题目类型改变提示文字内容
    if(quizAnswers.type == 1){
        $("#tips").html("单选题，请选择！");
    }
    if(quizAnswers.type == 2){
        $("#tips").html("多选题，请选择！");
    }
    return innerHtml;
}
//得到当前下标
function getMarkSeq(sheetId){
    for(var i = 0; i < sheetList.length; i++){
        if(sheetId == sheetList[i].sheetInfo.id){
            return sheetList[i].sheetInfo.markSeq;
        }
    }
}
//改变当前下标
function setMarkSeq(sheetId){
    for(var i = 0; i < sheetList.length; i++){
        if(sheetId == sheetList[i].sheetInfo.id){
            sheetList[i].sheetInfo.markSeq = number;
            localStorage.setItem("sheetListInfo", JSON.stringify(sheetList));
            break;
        }
    }
}
/**测试题-提交(单个题目)调用
 * @page:testing
 * */
function goSubmitOneQuestion(sheetId,questionId){
    var nowSheet = JSON.parse(localStorage.getItem("sheet"+sheetId));//当前量表（已选）所有题目信息
    var subQuestions = [];
    var questionOptions = nowSheet.questionOptions;
    for(var m = 0; m < questionOptions.length; m++){
        if(questionId == questionOptions[m].questionId){
            subQuestions[0] = questionOptions[m];//当前题目信息
        }
    }
    submitOneQuestion(subQuestions);//提交(单个题目)服务器
    sheetQuestion(sheetId);         //从缓存获取下一道题目
}
/**测试题-提交(单个题目)服务器
 * @page:testing
 * */
function submitOneQuestion(subQuestions) {
    postAjax({
        url: config.userUrl + "item/submit/questions?token=" + token,
        data: subQuestions,
        success:function(data){

        },fail:function(data){

        },error:function (xhr) {

        }
    })
}
/**测试题-提交(单个量表)服务器
 * @page:testing
 * */
function submitOneSheet() {
    totalResult = 0;
    number = 0;
    stop();         //停止计时
    sheetSecond = 0;//量表答题时间归零
    var sheetId = JSON.parse($("#sheetName").attr("data-id"));
    var nowSheet = JSON.parse(localStorage.getItem("sheet"+sheetId)); //当前量表（已选）所有题目信息
    $("#modalSubmit").modal("hide");
    showLoading("提交中....");
    postAjax({
        url: config.userUrl + "item/submit/sheet?token=" + token,
        data: nowSheet,
        success:function(data){
            hideLoading();
            Alert("提交成功！",function(){
                submitOneSheetOk(sheetId);
            });
        },fail:function(data){
            hideLoading();
            Alert(data.msg);
        },error:function (xhr) {
            hideLoading();
            Alert("提交失败！请连接网络后再提交",function(){
                submitOneSheetError(sheetId);
                location.reload();
            });
        }
    })
}
/**测试题-提交(量表)成功后修改缓存及按钮状态
 * @page:testing
 * */
function submitOneSheetOk(sheetId) {
    $("#testlist").show();
    $("#testGuide").hide();
    $("#testQuestion").hide();
    htmlHeight();
    //让本套题不能再修改
    $("#btn_"+sheetId).addClass("mbtn-gray");
    $("#btn_"+sheetId).text("答题完毕");
    $("#btn_"+sheetId).removeAttr("onClick");
    //修改(套餐中量表答题状态)checkStatus:1已完成
    for(var m = 0; m < packageSheets.length; m++){
        for(var i = 0; i < packageSheets[m].sheetList.length; i++){
            if(packageSheets[m].sheetList[i].sheetId == sheetId){
                packageSheets[m].sheetList[i].checkStatus = 1;
                localStorage.setItem("packageSheets", JSON.stringify(packageSheets));
            }
        }
    }
    packageFun();//量表列表
}
/**测试题-提交(量表)失败(没网时)后修改缓存及按钮状态
 * @page:testing
 * */
function submitOneSheetError(sheetId){
    $("#testlist").show();
    $("#testGuide").hide();
    $("#testQuestion").hide();
    htmlHeight();
    //修改(套餐量表答题状态)checkStatus:2答了没答完
    for(var m = 0; m < packageSheets.length; m++) {
        for (var i = 0; i < packageSheets[m].sheetList.length; i++) {
            if (packageSheets[m].sheetList[i].sheetId == sheetId) {
                packageSheets[m].sheetList[i].checkStatus = 2;
                localStorage.setItem("packageSheets", JSON.stringify(packageSheets));
            }
        }
    }
    packageFun();//量表列表
}
/**测试题-提交(总)服务器
 * @page:testing
 * */
function submitAllSheet() {
    for(var m = 0; m < packageSheets.length; m++){
        var pkSheetList = packageSheets[m].sheetList;
        //var sheetId = 0;
        var allSheetAnswer = [];
        //检测是否所有量表已提交并组装答案
        for(var i = 0; i < pkSheetList.length; i++) {
            if (pkSheetList[i].checkStatus != 1) {
                AlertNoX("提示","<p class='text-center mtb20'>您还有未回答试题或未提交量表哦！请先完成</p>");
                $("#btnModalNoX").click(function () {
                    $('#alertNoXModal').modal('hide');
                    $('#alertNoXModal').remove();
                })
                return;
            }
            //拼凑所有量表答案(因为每套量表提交后就不能更改，并所有量表都提交了才能提交整套量表，所以这个按钮提交的答案无效，可直接提交空)
            /*sheetId = pkSheetList[i].sheetId;
            var oneSheetAnswer = JSON.parse(localStorage.getItem("sheet"+sheetId));
            var subOneSheet = {};
            subOneSheet.sheetId = sheetId;
            subOneSheet.questionOptions = oneSheetAnswer;
            var oneSheetTime = 0;
            for(var j = 0; j < oneSheetAnswer.length; j++){
                oneSheetTime = oneSheetTime + oneSheetAnswer[j].time;
            }
            subOneSheet.time = oneSheetTime;
            allSheetAnswer.push(subOneSheet);*/
        }
    }


    showLoading("提交中...");
    postAjax({
        url: config.userUrl + "item/submit/package?token=" + token,
        data: allSheetAnswer,
        success:function(data){
            hideLoading();
            AlertNoX("提示","<p class='text-center mtb20'>所有试题回答完成，答案已提交!</p>");
            $("#btnModalNoX").click(function () {
                jump("testing.html");
                $("#testSubmit").attr("disabled",true);
            })
            for(var m = 0; m < packageSheets.length; m++){
                packageSheets[m].packageInfo.isFinished = 1;
            }
            localStorage.setItem("packageSheets", JSON.stringify(packageSheets));
        },fail:function(data){
            hideLoading();
            Alert(data.msg);
        },error:function (xhr) {
            hideLoading();
            Alert("提交失败！请连接网络后再提交");
        }
    })
}
/**按照属性值，查找对象(根据属性值得到当前对象在数组中的位置（索引值）)
 * (用于判定当前问题是否在已选择的题目列表里)
 * @param:array数组;attr属性名;val要查的值
 * */
function findElem(array,attr,val){
    for (var i = 0; i< array.length; i++){
        if(array[i][attr]==val){
            return i;
        }
    }
    return -1;
}
//删除数组中相同元素
function unique(sheets){
    var n = []; //一个新的临时数组
    //遍历当前数组
    for(var i = 0; i < sheets.length; i++){
        //如果当前数组的第i已经保存进了临时数组，那么跳过，
        //否则把当前项push到临时数组里面
        if (n.indexOf(sheets[i]) == -1) n.push(sheets[i]);
    }
    return n;
}

/**获取用户信息
 * @page:userInfo
 * */
function getUserInfo() {
    getAjax({
        url: config.userUrl + "user/findUserInfo?token=" + token,
        success:function(data){
            var result = data.data.userInfo;
            $("#name").val(result.name);
            $("#birthday").val(result.birthday);
            $("#career").val(result.career);
            $("#gender").val(result.gender);
            $("#degree").val(result.degree);
            $("#maritalStatus").val(result.maritalStatus);
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**完善用户信息
 * @page:userInfo
 * */
function completeUserInfo() {
    var name = $("#name").val();
    var birthday = $("#birthday").val();
    var career = $("#career").val();
    var gender = $("#gender").val();
    var maritalStatus = $("#maritalStatus").val();
    var degree = $("#degree").val();
    if($.trim(name) == ""){
        Alert("请填写姓名");
        return;
    }
    if($.trim(birthday) == ""){
        Alert("请填写生日");
        return;
    }
    if($.trim(career) == ""){
        Alert("请选择职业");
        return;
    }
    if($.trim(degree) == ""){
        Alert("请选择文化程度");
        return;
    }
    postAjax({
        url: config.userUrl + "user/editUserInfo?token=" + token,
        data: {name:name,birthday:birthday,career:career,gender:gender,maritalStatus:maritalStatus,degree:degree},
        success:function(data){
            AlertNoX("提示","<p class='text-center mtb20'>保存成功!</p>");
            $("#btnModalNoX").click(function () {
                jump("index.html");
            })
        },fail:function(data){
            Alert("服务器异常！");
        }
    })
}

/**报告-列表
 * @page:report
 * */
function reportList() {
    showLoading("加载中...");
    getAjax({
        url: config.url + "patient/report/list?token=" + token,
        success:function(data){
            hideLoading();
            var result = data.data;
            if(result.length == 0){
                $("#listBox").html(noList());
                $(".pages").remove();
            }
            if(result.length>0){
                $("#listBox").html(htmlReportList(result));
                htmlHeight();
            }
        },fail:function(data){
            hideLoading();
            Alert("服务器异常！");
        }
    })
}
/**报告-列表-HTML
 * @page:report
 * */
function htmlReportList(data) {
    var innerHtml = '';
    for(var i = 0; i<data.length; i++){
        innerHtml += '<div class="col-xs-3 col-md-3">';
        innerHtml +=     '<div class="report-box">';
        innerHtml +=         '<h2>'+data[i].packageNameStr+'</h2>';
        innerHtml +=         '<div class="pd5">';
        innerHtml +=             '<p>测试时间：'+cutOutTime(data[i].checkTime)+'</p>';
        innerHtml +=             '<p>测试团体：'+data[i].groupName+'</p>';
        innerHtml +=             '<p>测试单位：'+data[i].hospitalName+'</p>';
        innerHtml +=             '<p>测试科室：'+data[i].officeName+'</p>';
        innerHtml +=         '</div>';
        if(data[i].reportStatus == 0){//未审核
            innerHtml +=     '<div class="pd5 text-center"><a href="javascript:;" class="mbtn mbtn-gray">审核中</a></div>';
        }else{
            innerHtml +=     '<div class="pd5 text-center"><a href="reportDetail.html?rId='+data[i].reportId+'&from=user" class="mbtn">查看</a></div>';
        }
        innerHtml +=     '</div>';
        innerHtml += '</div>';
    }
    return innerHtml;
}
/**报告-用户信息
 * @page:reportUserInfo
 * */
function reportUserInfo(){
    showLoading("加载中...");
    getAjax({
        url: config.url + "patient/detail?token=" + token,
        success:function(data){
            hideLoading();
            var patientInfo = data.data.patient;
            var packageList = data.data.packageList;
            reportUserInfoHtml(patientInfo);
            reportUserPackageList(packageList,patientInfo.id);
        },fail:function(data){
            hideLoading();
            Alert("服务器异常！");
        }
    })
}
/**报告-用户基本信息-HTML
 * @page:reportUserInfo
 * @param:data用户数据
 * */
function reportUserInfoHtml(data){
    $("#hospital").html(data.hospitalName);
    $("#name").html(data.name);
    $("#checkCardNum").html(data.checkCardNum);
    $("#mobile").html(data.mobile);
    $("#checkOfficeName").html(data.checkOfficeName);
    if(data.gender == 0){
        $("#genderName").html("女");
    }
    if(data.gender == 1){
        $("#genderName").html("男");
    }
    $("#age").html(data.birthday);
    $("#career").html(data.career);
    $("#degree").html(data.degree);
    if(data.maritalStatus == 0){
        $("#maritalStatusName").html("未婚");
    }
    if(data.maritalStatus == 1){
        $("#maritalStatusName").html("已婚");
    }
    if(data.maritalStatus == 2){
        $("#maritalStatusName").html("离异");
    }
    $("#groupName").html(data.groupName);
    $("#checkDoctorName").html(data.checkDoctorName);

    $("#checkTime").html(data.checkTime);
    $("#reportTime").html(data.reportTime);

}
/**报告-用户基本信息-HTML
 * @page:reportUserInfo
 * @param:data套餐列表数据;id用户Id
 * */
function reportUserPackageList(data,id){
    var innerHtml = '';
    innerHtml += '<div class="row">';
    for(var i = 0; i < data.length; i++){
        innerHtml +=   '<div class="col-xs-6 col-md-3"><a href="reportDetail.html?uId='+id+'&pId='+data[i].id+'" class="mbtn">'+data[i].name+'</a></div>';
    }
    innerHtml += '</div>';
    $("#listBox").html(innerHtml);
}
/**报告-团体查看个人报告详情
 * @page:reportDetail
 * */
function reportDetail() {
    postAjax({
        url: config.url + "group/patient/package/report/detail?token="+token,
        data: {reportId:rId,groupType:uType},
        success:function(data){
            var result = data.data;
            $("title").text(result.name+"的体检报告");
            $("#hospital").text(result.name+"的体检报告");
            $("#checkPackageName").text(result.checkPackageName);
            $("#name").text(result.name);
            $("#checkCardNum").text(result.checkCardNum);
            $("#mobile").text(result.mobile);
            $("#age").text(result.age);
            $("#career").text(result.career);
            $("#maritalStatusName").text(result.maritalStatusName);
            $("#groupName").text(result.groupName);
            $("#checkDoctorName").text(result.checkDoctorName);
            $("#checkOfficeName").text(result.checkOfficeName);

            var reportList = result.sheetReportList;
            for(var i = 0; i<reportList.length; i++) {
                var report = reportHtml(reportList[i], i);
                $("#listBox").append(report);

                if(reportList[i].echartType != 6){//不是条形指针图时显示总分
                    var iHtml = '';//分数
                    iHtml = '<p class="text-center jsScore">';
                    iHtml +=    '<span class="mlr10 yinzi">总分：'+reportList[i].score+'分</span>';
                    if(reportList[i].factors.length>0){
                        for(var j= 0; j<reportList[i].factors.length; j++){
                            iHtml += '<span class="mr20 yinzi">'+reportList[i].factors[j].name + ": " +reportList[i].factors[j].score+'分</span>';
                        }
                    }
                    iHtml += '</p>';
                    $("#chart_"+i).after(iHtml);
                }

                //图形
                if(reportList[i].echartType == 1){//1折线图 2条形图 3饼状图 4仪表盘 5雷达图 6条形指针图
                    chartLine(reportList[i],i);
                }else if(reportList[i].echartType == 2){
                    chartColumnar(reportList[i],i);
                }else if(reportList[i].echartType == 3){
                    chartPie(reportList[i],i)
                }else if(reportList[i].echartType == 6){
                    chartColumnarPointer(reportList[i],i)
                }else{
                    chartPanel(reportList[i],i);
                    $("#chart_"+i).siblings(".jsScore").css({"margin-top":"-80px"});
                    $("#chart_"+i).addClass("panel");
                }
            }
            htmlHeight();
        },fail:function(data){
            Alert("服务器异常！");
        }
    })
}
/**报告-个人查看报告详情
 * @page:reportDetail
 * */
function userReportDetail() {
    getAjax({
        url: config.url + "patient/package/report/detail/"+rId+"?token="+token,
        success:function(data){
            var result = data.data;
            $("title").text(result.name+"的体检报告");
            $("#hospital").text(result.name+"的体检报告");
            $("#checkPackageName").text(result.checkPackageName);
            $("#name").text(result.name);
            $("#checkCardNum").text(result.checkCardNum);
            $("#mobile").text(result.mobile);
            $("#age").text(result.age);
            $("#career").text(result.career);
            $("#maritalStatusName").text(result.maritalStatusName);
            $("#groupName").text(result.groupName);
            $("#checkDoctorName").text(result.checkDoctorName);
            $("#checkOfficeName").text(result.checkOfficeName);
            //5套特殊量表展示
            var specialPackageResultList = result.specialPackageResultList;//测试情况
            var specialPackageHint = result.specialPackageHint;//最近的提示文字
            var specialPackageCompareHint = result.specialPackageCompareHint;//对比提示文字
            if(specialPackageResultList.length > 0){
                $("#listBox").html(htmlSpecialPackage(specialPackageResultList,specialPackageHint));
                if(specialPackageResultList.length > 1){//当出现多条数据时对比
                    $("#listBox").append(htmlSpecialPackageCompare(specialPackageResultList,specialPackageCompareHint));
                    chartColumnarCompare(specialPackageResultList);
                }
            }
            //单套量表情况
            var reportList = result.sheetReportList;
            for(var i = 0; i<reportList.length; i++) {
                var report = reportHtml(reportList[i], i);
                $("#listBox").append(report);

                if(reportList[i].echartType != 6){//不是条形指针图时显示总分
                    var iHtml = '';//分数
                    iHtml = '<p class="text-center jsScore">';
                    iHtml +=    '<span class="mlr10 yinzi">总分：'+reportList[i].score+'分</span>';
                    if(reportList[i].factors.length>0){
                        for(var j= 0; j<reportList[i].factors.length; j++){
                            iHtml += '<span class="mr20 yinzi">'+reportList[i].factors[j].name + ": " +reportList[i].factors[j].score+'分</span>';
                        }
                    }
                    iHtml += '</p>';
                    $("#chart_"+i).after(iHtml);
                }

                //图形
                if(reportList[i].echartType == 1){//1折线图 2条形图 3饼状图 4仪表盘 5雷达图 6条形指针图
                    chartLine(reportList[i],i);
                }else if(reportList[i].echartType == 2){
                    chartColumnar(reportList[i],i);
                }else if(reportList[i].echartType == 3){
                    chartPie(reportList[i],i)
                }else if(reportList[i].echartType == 6){
                    chartColumnarPointer(reportList[i],i)
                }else{
                    chartPanel(reportList[i],i);
                    $("#chart_"+i).siblings(".jsScore").css({"margin-top":"-80px"});
                    $("#chart_"+i).addClass("panel");
                }
            }
            htmlHeight();
        },fail:function(data){
            Alert("服务器异常！");
        }
    })
}
/**报告-个人查看报告详情
 * @page:reportDetail
 * */
function myReportDetail() {
	console.log(config.url);
    getAjax({
        url: config.url + "../../memberorder/report/detail/"+rId,
        success:function(data){
            var result = data.data;
            $("title").text(result.name+"的体检报告");
            $("#hospital").text(result.name+"的体检报告");
            $("#checkPackageName").text(result.checkPackageName);
            $("#name").text(result.name);
            $("#checkCardNum").text(result.checkCardNum);
            $("#mobile").text(result.mobile);
            $("#age").text(result.age);
            $("#career").text(result.career);
            $("#maritalStatusName").text(result.maritalStatusName);
            $("#groupName").text(result.groupName);
            $("#checkDoctorName").text(result.checkDoctorName);
            $("#checkOfficeName").text(result.checkOfficeName);
            //5套特殊量表展示
            var specialPackageResultList = result.specialPackageResultList;//测试情况
            var specialPackageHint = result.specialPackageHint;//最近的提示文字
            var specialPackageCompareHint = result.specialPackageCompareHint;//对比提示文字
            if(specialPackageResultList.length > 0){
                $("#listBox").html(htmlSpecialPackage(specialPackageResultList,specialPackageHint));
                if(specialPackageResultList.length > 1){//当出现多条数据时对比
                    $("#listBox").append(htmlSpecialPackageCompare(specialPackageResultList,specialPackageCompareHint));
                    chartColumnarCompare(specialPackageResultList);
                }
            }
            //单套量表情况
            var reportList = result.sheetReportList;
            for(var i = 0; i<reportList.length; i++) {
                var report = reportHtml(reportList[i], i);
                $("#listBox").append(report);

                if(reportList[i].echartType != 6){//不是条形指针图时显示总分
                    var iHtml = '';//分数
                    iHtml = '<p class="text-center jsScore">';
                    iHtml +=    '<span class="mlr10 yinzi">总分：'+reportList[i].score+'分</span>';
                    if(reportList[i].factors.length>0){
                        for(var j= 0; j<reportList[i].factors.length; j++){
                            iHtml += '<span class="mr20 yinzi">'+reportList[i].factors[j].name + ": " +reportList[i].factors[j].score+'分</span>';
                        }
                    }
                    iHtml += '</p>';
                    $("#chart_"+i).after(iHtml);
                }

                //图形
                if(reportList[i].echartType == 1){//1折线图 2条形图 3饼状图 4仪表盘 5雷达图 6条形指针图
                    chartLine(reportList[i],i);
                }else if(reportList[i].echartType == 2){
                    chartColumnar(reportList[i],i);
                }else if(reportList[i].echartType == 3){
                    chartPie(reportList[i],i)
                }else if(reportList[i].echartType == 6){
                    chartColumnarPointer(reportList[i],i)
                }else{
                    chartPanel(reportList[i],i);
                    $("#chart_"+i).siblings(".jsScore").css({"margin-top":"-80px"});
                    $("#chart_"+i).addClass("panel");
                }
            }
            htmlHeight();
        },fail:function(data){
            Alert("服务器异常！");
        }
    })
}
/**个人报告--5套特殊量表展示
 * @page:reportDetail
 * @param:list5套量表检测结果；tips提示文字；compareTips每套量表多次检测提示文字
 */
function htmlSpecialPackage(list,tips) {
    var sheetReportList = list[0].sheetReportList;//最近一次检测
    var innerHtml = '';
    innerHtml += '<h3 class="mb10 blue r-title">综合情况</h3>';
    innerHtml += '<div class="mb20"><table class="table table-blue table-border-tr">';
    innerHtml +=   '<tr>';
    innerHtml +=     '<th class="divide-30">检测项目</th>';
    innerHtml +=     '<th class="divide-20">测试日期</th>';
    innerHtml +=     '<th class="divide-10">结果</th>';
    innerHtml +=     '<th class="divide-20">提示</th>';
    innerHtml +=     '<th class="divide-20">预警</th>';
    innerHtml +=   '</tr>';
    for(var i = 0; i < sheetReportList.length; i++){
        if(i%2 == 0){
            innerHtml += '<tr class="active">';
        }else{
            innerHtml += '<tr>';
        }
        innerHtml +=     '<td>'+sheetReportList[i].sheetName+'</td>';
        innerHtml +=     '<td>'+cutOutTime(sheetReportList[i].checkTime)+'</td>';
        innerHtml +=     '<td>'+sheetReportList[i].result+'</td>';
        innerHtml +=     '<td>'+sheetReportList[i].alert+'</td>';
        innerHtml +=     '<td>'+sheetReportList[i].degreeText+'</td>';
        innerHtml +=   '</tr>';
    }
    innerHtml +=   '<tr>';
    innerHtml +=     '<td>综合</td>';
    innerHtml +=     '<td colspan="4">'+tips+'</td>';
    innerHtml +=   '</tr>';
    innerHtml += '</table></div>';
    return innerHtml;
}
/**个人报告--5套特殊量表展示(多次对比)
 * @page:reportDetail
 * @param:list5套量表检测结果；compareTips每套量表多次检测提示文字
 */
function htmlSpecialPackageCompare(list,compareTips) {
    var innerHtml = '';
    innerHtml += '<h3 class="mb10 mt20 blue r-title">自身个体前后纵向报告分析</h3>';
    innerHtml += '<div class="row">';
    innerHtml +=   '<div class="col-xs-6 col-md-6">';
    innerHtml +=     '<table class="table table-blue table-border-tr">';
    innerHtml +=       '<tr>';
    innerHtml +=         '<th>批次</th>';
    for(var i = 0; i < list.length; i++){
        innerHtml +=     '<th>'+list[i].batchNum+'</th>';
    }
    innerHtml +=       '</tr>';

    innerHtml +=      '<tr class="active">';
    innerHtml +=         '<td>日期</td>';
    for(var i = 0; i < list.length; i++) {
        innerHtml +=      '<td>'+cutOutTime(list[i].checkTime)+'</td>';
    }
    innerHtml +=      '</tr>';

    var myArray = ['','','','',''];
    for(var j = 0; j < list.length; j++) {
        var sheetReportList = list[j].sheetReportList;
        for(var i = 0; i < sheetReportList.length; i++){
            if(j == 0){
                var html = '<tr><td>'+sheetReportList[i].sheetName+'</td>';
                myArray[i] = myArray[i] + html;
            }
            var html2 = '<td>'+sheetReportList[i].result+'</td>';
            myArray[i] = myArray[i] + html2;
            if(j == list.length - 1){
                myArray[i] = myArray[i] + '</tr>';
            }
        }
    }
    for(var i = 0; i < myArray.length; i++){
        innerHtml += myArray[i];
    }

    innerHtml +=       '<tr>';
    innerHtml +=         '<td>预警等级</td>';
    for(var j = 0; j < list.length; j++) {
        innerHtml +=     '<td>'+list[j].alertDegreeText+'</td>';
    }
    innerHtml +=       '</tr>';
    innerHtml +=     '</table>';
    innerHtml +=   '</div>';
    innerHtml +=   '<div class="col-xs-6 col-md-6">';
    innerHtml +=        '<div id="chartCompare" style="width:100%;height:490px;"></div>';
    innerHtml +=        '<img id="chartCompareImg" style="width:100%;height:400px;display: none">';
    innerHtml +=   '</div>';
    innerHtml += '</div>';
    innerHtml += '<div class="mb40">';
    innerHtml +=   '<h3 class="text-center mb20">提示</h3>';
    innerHtml +=   '<div>'+compareTips+'</div>';
    innerHtml += '</div>';
    innerHtml += '<div style="page-break-after:always;"></div>';
    return innerHtml;
}
/**个人报告--个人多次对比-条形图(柱状图)
 * @page:reportDetail
 */
function chartColumnarCompare(list) {
    var dom = document.getElementById("chartCompare");
    var myChart = echarts.init(dom);
    var app = {};
    var option = null;
    var xData = [];//X轴数据
    var mySeries = [];
    var myDate = [];
    for(var i = 0; i < list.length; i++){
        var seriesObj = {};
        var score = [];
        var sheetReportList = list[i].sheetReportList;
        for(var j = 0; j < sheetReportList.length; j++){
            if(j != sheetReportList.length - 1){
                if(i == 0){
                    xData.push(sheetReportList[j].sheetName);
                }
                seriesObj.name = list[i].batchNum;
                seriesObj.type = 'bar';
                score.push(sheetReportList[j].result);
                seriesObj.data = score;

                myDate.push(cutOutTime(list[i].batchNum));
            }
        }
        mySeries.push(seriesObj);
    }
    option = {
        title : {
            text: '',
        },
        color: ['#1378b5','#64b8ea','#a6d3ef','#cae4f5'],
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            //data:['蒸发量','降水量']
            data: myDate
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                //data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                data: xData
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series: mySeries
    };
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
    //打印预览把表格生成图片
    var myChartImg = document.getElementById('chartCompareImg');
    myChartImg.src = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });
}
/**个人报告-仪表盘
 * @page:reportingDetail
 */
function chartPanel(data,idx) {
    var result = data;
    if(data.renderExpression == ""){
        Alert2("后台体检表参数没配置成功，不能访问，请联系医生！");
        return;
    }
    var tempObject = JSON.parse(data.renderExpression);
    var mySeries = [];
    var myMax = parseInt(tempObject.section[tempObject.section.length-1]);
    for(var i = 0; i<tempObject.section.length; i++){
        var mySeriesOne = {};
        if(i+1 == tempObject.section.length)
            break;
        mySeriesOne.name = result.sheetName;
        mySeriesOne.type = 'gauge';
        mySeriesOne.radius = '100%';
        mySeriesOne.min = Math.ceil(JSON.parse(tempObject.section[i]));
        mySeriesOne.max = Math.ceil(JSON.parse(tempObject.section[i+1]));
        mySeriesOne.splitNumber = 1;
        mySeriesOne.axisTick = { // 坐标轴小标记
            show: false,        // 属性show控制显示与否，默认不显示
        };
        mySeriesOne.detail = {formatter:result.score + ""};//显示得分
        //判定得分在哪个区间就在哪个区间显示指针
        if(mySeriesOne.min<=result.score && result.score<=mySeriesOne.max){
            mySeriesOne.data = [{value: result.score,name: "得分"}];//鼠标移上去得分
        }
        mySeriesOne.startAngle = 180-(tempObject.section[i]/myMax)*180;
        mySeriesOne.endAngle = 180-(tempObject.section[i+1]/myMax)*180;
        mySeriesOne.axisLine = {            // 坐标轴线
            lineStyle: {       // 属性lineStyle控制线条样式
                color: [[1, tempObject.color[i]]],
            }
        };
        mySeries.push(mySeriesOne);
    }
    var myChart = echarts.init(document.getElementById('chart_'+idx));
    myOption = {
        tooltip : {
            //formatter: "{a} <br/>{b} : {c}%"
            formatter: "{a} <br/>{b} : {c}"//鼠标移上去效果
        },
        toolbox: {
            feature: {
                //restore: {},
                //saveAsImage: {}
            }
        },
        series: mySeries,
    }
    myChart.setOption(myOption);
}
/**个人报告-饼状图
 * @page:reportingDetail
 */
function chartPie(data,idx) {
    var result = data;
    if(data.renderExpression == ""){
        Alert2("后台体检表参数没配置成功，不能访问！");
        return;
    }
    var temps = result.temps;
    var myData = [];
    for(var i = 0; i < temps.length; i++){
        var myDataOne = {
            value: result.score,
            name: result.temps[i].name,
        }
        myData.push(myDataOne);
    }
    var myChart = echarts.init(document.getElementById('chart_'+idx));
    myOption = {
        title : {
            /*text: "测试结果："+result.score+"分",
            x:'center',
            textStyle: {
                color: '#4da1ff',
                fontSize : 14,
            },
            borderWidth: 1,
            borderColor: '#4da1ff',*/
        },
        tooltip: {
            show: true,
            formatter: "{a} {c}分"
        },
        series : [
            {
                name:'总分：',
                type: 'pie',
                radius : '80%',
                center: ['50%', '50%'],
                selectedMode: 'single',
                /*data:[
                    {value:result.score*2, name:"最高得分"},
                    {value:result.score, name: "得分"},
                ],*/
                data: myData,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)',
                    },
                    normal: {
                        color: function(params) {
                            // build a color map as your need.
                            var colorList = [
                                '#9bbb59','#8064a2',"#4bacc6","#c0504d",
                            ];
                            return colorList[params.dataIndex]
                        },
                    }
                },
                label: {
                    normal: {
                        show: true//饼图图形上的文本标签
                    }
                }
            }
        ]
    };
    myChart.setOption(myOption);
}
/**个人报告-折线图
 * @page:reportingDetail
 */
function chartLine(data,idx) {
    var result = data;
    var myData = [];
    var myDataName = [];
    if(result.factors.length>0){
        for(var i = 0; i<result.factors.length; i++){
            myData.push(result.factors[i].score);
            myDataName.push(result.factors[i].name);
        }
    }else{
        myData.push(result.score);
        myDataName.push(result.sheetName);
    }
    var myChart = echarts.init(document.getElementById('chart_'+idx));
    myOption = {
        /*title: {
            text: '堆叠区域图'
        },*/
        tooltip : {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                label: {
                    backgroundColor: '#04e1d8'
                }
            }
        },
        legend: {
            //data:['邮件营销']
        },
        toolbox: {
            feature: {
                //saveAsImage: {}//显示把表格已图片形式下载
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                boundaryGap : false,
                //data : ['谎话测试','心理测试','体能测试','眼力测试','肢体测试','沟通测试','表达测试']
                data : myDataName
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'',
                type:'line',
                stack: '得分',
                areaStyle: {normal: {}},
                //data:[120, 132, 101, 134, 90, 280, 210],
                data:myData,
                label: {
                    normal: {
                        show: true
                    }
                },
                areaStyle: {
                    normal: {
                        color: '#4099fd',
                        lineStyle: {
                            color: '#4099fd'
                        }
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#4099fd',
                        lineStyle: {
                            color: '#4099fd'
                        }
                    }
                },
            }
        ]
    };
    myChart.setOption(myOption);
}
/**个人报告-条形图(柱状图)
 * @page:reportingDetail
 */
function chartColumnar(data,idx) {
    var result = data;
    var myData = [];
    var myDataName = [];
    if(result.factors.length>0){
        for(var i = 0; i<result.factors.length; i++){
            myData.push(result.factors[i].score);
            myDataName.push(result.factors[i].name);
        }
    }else{
        myData.push(result.score);
        myDataName.push(result.sheetName);
    }
    var myChart = echarts.init(document.getElementById('chart_'+idx));
    myOption = {
        color: ['#1378b5'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                //data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                data: myDataName,
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'得分',
                type:'bar',
                barWidth: '25%',//柱子的宽度
                label: { //柱子顶部的值
                    normal: {
                        show: true,
                        position: 'top',
                        textStyle: {
                            fontSize : 18,
                        },
                    }
                },
                //data:[10, 52, 200, 334, 390, 330, 220]
                data: myData
            }
        ]
    };
    myChart.setOption(myOption);
}
/**个人报告-条形指针图
 * @page:reportingDetail
 * @param:score分数
 */
function chartColumnarPointer(data,idx) {
    var innerHtml = '';
    innerHtml += '<div class="text-center">';
    innerHtml +=     '<img src="{pic}">';
    innerHtml +=     '<p><span class="yinzi">{name}</span></p>';
    innerHtml += '</div>';
    if(data.score == 0){
        innerHtml = innerHtml.replace("{pic}","images/noexist.jpg");
        innerHtml = innerHtml.replace("{name}","不存在");
    }else{
        innerHtml = innerHtml.replace("{pic}","images/exist.jpg");
        innerHtml = innerHtml.replace("{name}","存在");
    }
    $('#chart_'+idx).html(innerHtml);
}
/**个人报告-每套题目单个Html
 * @page:reportingDetail
 */
function reportHtml(data,idx) {
    var result = data;
    var innerHtml = '';
    innerHtml += '<div class="rtitle2">{reportName}</div>';
    innerHtml += '<h2 class="r-title">体检信息</h2>';
    if(data.echartType == 6){
        innerHtml += '<div id="chart_'+idx+'" style="width: 100%;"></div>';
    }else{
        innerHtml += '<div id="chart_'+idx+'" style="width: 100%; height: 400px;"></div>';
    }
    innerHtml += '<h2 class="r-title">体检评语</h2>';
    innerHtml += '<div class="pbox" id="checkComment_'+idx+'">{comment}</div>';
    innerHtml += '<h2 class="r-title">体检建议</h2>';
    innerHtml += '<div class="report-text" id="checkSuggestArea_'+idx+'">{suggest}</div>';
    innerHtml = innerHtml.replace("{reportName}",result.sheetName);
    innerHtml = innerHtml.replace("{comment}",result.checkComment);
    innerHtml = innerHtml.replace("{suggest}",result.checkSuggest);
    return innerHtml;
}

/**团体、部门、小组账号批次列表
 * @page:indext
 */
function batchList(pageNum){
    showLoadingLittle($("#listBox"));
    postAjax({
        url: config.url + "group/batch/paging?token=" + token,
        data: {pageNum:pageNum,pageSize:pageSize,condition:{type:uType}},
        success:function(data){
            var result = data.data;
            var groupInfo = result.pageData;
            $("#groupName").html(groupInfo.groupName);
            $("#industry").html(groupInfo.industry);
            $("#number").html(groupInfo.batchCount);
            $("#address").html(groupInfo.address);
            var list = result.list;
            if(list.length == 0){
                $("#listBox").html(noList());
                $(".pages").remove();
            }else{
                $("#listBox").html(htmlBatchList(list));
                htmlHeight();
                //分页数>1时显示分页
                if(data.data.totalPage>1){
                    if($(".pages").length<1){
                        $("#listBox").after('<div class="pages mt20 mb20"><div class="M-box"></div></div>');
                    }
                    //分页
                    $('.M-box').pagination({
                        totalData:data.data.totalResult, //数据总条数
                        pageCount:data.data.totalPage,
                        showData:10, //每页显示的条数
                        current:pageNum,
                        callback:function(api){
                            pageNum = api.getCurrent(); //获取当前页
                            batchList(pageNum);
                        }
                    });
                }else{
                    $(".pages").remove();
                }
            }
        },fail:function(data){
            Alert("服务器异常！");
        }
    })
}
/**团体、部门、小组账号批次列表--HTML
 * @page:indext
 */
function htmlBatchList(data){
    var innerHtml = '';
    innerHtml += '<table class="table table-blue table-border-tr">';
    innerHtml +=   '<tr>';
    innerHtml +=     '<th class="divide-20">批次编号</th>';
    innerHtml +=     '<th class="divide-10">创建时间</th>';
    innerHtml +=     '<th class="divide-12">部门</th>';
    innerHtml +=     '<th class="divide-12">小组</th>';
    innerHtml +=     '<th class="divide-5">数量</th>';
    innerHtml +=     '<th class="divide-6">类型</th>';
    innerHtml +=     '<th class="divide-25">套餐/量表</th>';
    innerHtml +=     '<th class="divide-10">操作</th>';
    innerHtml +=  '</tr>';

    for(var i = 0; i < data.length; i++) {
        var allTeamNum = 0;//单批次下总小组数
        for (var j = 0; j < data[i].departmentList.length; j++) {
            var tList = data[i].departmentList[j].teamList;
            allTeamNum += tList.length;
        }
        innerHtml += '<tr>';
        innerHtml += '<td rowspan="'+allTeamNum+'">' + data[i].number + '</td>';
        innerHtml += '<td rowspan="'+allTeamNum+'">' + cutOutTime(data[i].createTime) + '</td>';
        var two = 0;
        for (var m = 0; m < data[i].departmentList.length; m++) {
            var teamNum = data[i].departmentList[m].teamList.length;//单部门下小组数
            if(two != 0){//多部门第2行start
                innerHtml += '<tr>';
            }
            two = 1;
            innerHtml += '<td rowspan="'+teamNum+'">'+data[i].departmentList[m].name+'</td>';
            var teamList = data[i].departmentList[m].teamList;
            var three = 0;
            for(var n = 0; n < teamList.length; n++) {
                if(three != 0){//多小组第2行start
                    innerHtml += '<tr>';
                }
                three = 1;
                innerHtml += '<td>' + teamList[n].name + '</td>';
                innerHtml += '<td>' + teamList[n].peopleCount + '</td>';
                if(teamList[n].checkCardType == 2){
                    innerHtml += '<td>虚拟卡</td>';
                }else{
                    innerHtml += '<td>实体卡</td>';
                }
                innerHtml += '<td>'+teamList[n].packageNameStr+'</td>';
                innerHtml += '<td class="divide-6">';
                if(uType == "group"){
                    innerHtml += '<a href="reportGroup.html?bId='+teamList[n].batchId+'" class="mbtn-b mbtn-blue">查看</a>';
                }
                if(uType == "department"){
                    innerHtml += '<a href="reportDepartment.html?bId='+teamList[n].batchId+'&dId='+data[i].departmentList[m].departmentId+'" class="mbtn-b mbtn-blue">查看</a>';
                }
                if(uType == "team"){
                    innerHtml += '<a href="reportTeam.html?bId='+teamList[n].batchId+'&tId='+teamList[n].teamId+'" class="mbtn-b mbtn-blue">查看</a>';
                }
                innerHtml += '</td>';
                innerHtml += '</tr>';//批次第1行end-多部门第2行end-多小组第2行end
            }
        }
    }
    innerHtml += '</table>';
    return innerHtml;
}
/**团体报告
 * @page:reportGroup
 */
function reportGroup(){
    showLoadingLittle($("#checkResultList"));
    getAjax({
        url: config.url + "group/batch/report/detail/"+bId+"?token="+token,
        success:function (data) {
            var result = data.data;
            $("#groupName").html(result.groupName);
            //检测结果列表
            var checkResultList = result.checkResultList;
            $("#checkResultList").html(htmlCheckResultList(checkResultList));
            if(checkResultList.length > 0){
                for(var i = 0; i < checkResultList.length; i++){
                    htmlReportGroupPie(i,checkResultList[i]);
                }
            }
            $("#checkResultList").append(reportTips(result.checkResultHint));
            //平均分
            var averageScoreList = result.sheetAverageScoreList;
            var packagePeopleCount = result.packagePeopleCount;
            $("#groupAverage").html(htmlReportGroupAverage(packagePeopleCount,averageScoreList));
            $("#groupAverage").append(reportTips(result.sheetAverageScoreHint));
            //团体部门情况
            var departmentReportList = result.departmentReportList;
            $("#groupDepartment").html(htmlReportGroupDepartment(departmentReportList,'group'));
            $("#groupDepartment").append(reportTips(result.departmentListHint));
            htmlHeight();
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**团体报告--各量表检测结果列表--HTML
 * @page:reportGroup
 */
function htmlCheckResultList(data){
    var innerHtml = '';
    for(var i = 0; i < data.length; i++){
        innerHtml += '<div class="r-title2">'+data[i].sheetName+'</div>';
        innerHtml += '<div class="row">';
        innerHtml +=     '<div class="col-xs-6 col-md-6 mt20">';
        innerHtml +=         '<table class="table table-blue table-border-tr">';
        innerHtml +=             '<tr><th>预警程度</th><th>测试人数</th><th>比例</th></tr>';
        if(data[i].resultList.length > 0){
            var resultList = data[i].resultList;
            for(var j = 0; j < resultList.length; j++){
                innerHtml +=      '<tr>';
                innerHtml +=         '<td>'+resultList[j].degree+'</td>';
                innerHtml +=         '<td>'+resultList[j].peopleCount+'</td>';
                innerHtml +=         '<td>'+resultList[j].percent+'</td>';
                innerHtml +=       '</tr>';
            }
        }else{
            innerHtml +=           '<tr><td colspan="3" class="gray">还没有人测试</td></tr>';
        }
        innerHtml +=         '</table>';
        innerHtml +=     '</div>';
        innerHtml +=     '<div class="col-xs-6 col-md-6">';
        innerHtml +=         '<div id="chart_'+i+'" class="JSChart" style="width: 100%;height: 200px"></div>';
        innerHtml +=         '<div class="rlegend text-center">';
        if(data[i].resultList.length > 0) {
            var resultList = data[i].resultList;
            for(var m = 0; m < resultList.length; m++) {
                innerHtml += '<span class="color-grade JSprint color-grade'+resultList[m].result+'"></span>';
                innerHtml += '<span class="rlegend-txt">'+resultList[m].degree+'：'+resultList[m].percent+'</span>';
            }
        }
        innerHtml +=         '</div>';
        innerHtml +=     '</div>';
        innerHtml += '</div>';
    }
    return innerHtml;
}
/**团体报告--饼图--HTML
 * @page:reportGroup
 */
function htmlReportGroupPie(index,data){
    var myChartGroup = echarts.init(document.getElementById('chart_'+index));
    if(data.resultList.length > 0) {
        var resultList = data.resultList;
        var myData = [];
        var myColorList = [];
        for(var j = 0; j < resultList.length; j++){
            var myDataObj = {};
            myDataObj.value = parseInt(resultList[j].percent);
            myDataObj.name = resultList[j].degree;
            myData.push(myDataObj);
            if(resultList[j].result == 1){
                myColorList.push("#9a0109");
            }
            if(resultList[j].result == 2){
                myColorList.push("#e41b25");
            }
            if(resultList[j].result == 3){
                myColorList.push("#f9a122");
            }
            if(resultList[j].result == 4){
                myColorList.push("#fce27e");
            }
            if(resultList[j].result == 5){
                myColorList.push("#4dd646");
            }
            if(resultList[j].result == 6){
                myColorList.push("#8ee689");
            }
        }
        var optionGroup = {
            tooltip: {
                show: true
            },
            series : [
                {
                    type: 'pie',
                    //radius: ['30%','80%'],//饼图的半径，内半径，外半径。
                    //radius : '80%',
                    center: ['50%', '50%'],
                    selectedMode: 'single',
                    // data:[
                    //     {value:1, name: '正常'},
                    //     {value:1, name: '轻度'},
                    //     {value:1, name: '中度'},
                    //     {value:1, name: '重度'},
                    // ],
                    data: myData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)',
                        },
                        normal: {
                            color: function(params) {
                                // build a color map as your need.
                                // var colorList = [
                                //     '#4dd646','#f9a122','#e41b25','#9a0109',
                                // ];
                                var colorList = myColorList;
                                return colorList[params.dataIndex]
                            },
                        }
                    },
                    label: {
                        normal: {
                            show: false//饼图图形上的文本标签
                        }
                    }
                }
            ]
        };
        myChartGroup.setOption(optionGroup);
    }
}
/**团体报告--团体平均分--HTML
 * @page:reportGroup
 * @param:num:测试总人数
 */
function htmlReportGroupAverage(num,data){
    var innerHtml = '';
    innerHtml += '<table class="table table-blue table-border-tr">';
    innerHtml += '<tr>';
    innerHtml +=     '<th>测试人数</th>';
    for(var i = 0; i < data.length; i++){
        innerHtml += '<th>'+data[i].sheetName+'</th>';
    }
    innerHtml += '</tr>';
    innerHtml += '<tr>';
    innerHtml +=     '<td>'+num+'</td>';
    if(data.length > 0) {
        for (var j = 0; j < data.length; j++) {
            innerHtml += '<td>' + data[j].result + '</td>';
        }
    }else{
        innerHtml += '<td class="gray text-center">无数据</td>';
    }
    innerHtml += '</tr>';
    innerHtml += '</table>';
    return innerHtml;
}
/**团体报告--团体所有部门报告--HTML
 * @page:reportGroup
 * @param:from(group团体报告,department部门报告)
 */
function htmlReportGroupDepartment(data,from){
    var innerHtml = '';
    innerHtml += '<table class="table table-blue table-border-tr">';
    innerHtml +=   '<tr>';
    innerHtml +=     '<th class="divide-30">量表名称</th>';
    if(from == "group"){
        innerHtml +=     '<th>部门名称</th>';
        for(var i = 0; i < data.length; i++){
            innerHtml += '<th>'+data[i].departmentName+'</th>';
        }
    }else{
        innerHtml +=     '<th>小组名称</th>';
        for(var i = 0; i < data.length; i++){
            innerHtml += '<th>'+data[i].teamName+'</th>';
        }
    }
    innerHtml +=     '<th>合计人数</th>';
    innerHtml +=   '</tr>';
    innerHtml +=   '<tr>';
    var one = 0;
    for(var i = 0; i < data.length; i++) {
        var checkResultList = data[i].checkResultList;//部门下量表
        for(var m = 0; m < checkResultList.length; m++){
            var resultList = checkResultList[m].resultList;//量表下的等级
            var sheetNum = 1;//量表数量
            if(resultList != 0){
                sheetNum = resultList.length + 1;//量表数量
            }
            if(one == 0){
                innerHtml +=  '<td rowspan="'+sheetNum+'">'+checkResultList[m].sheetName+'</td>';
            }
            innerHtml +=  '<td>测试人数</td>';
            for(var i = 0; i < data.length; i++){
                innerHtml +=  '<td>'+checkResultList[m].peopleCountBySheet+'</td>';
            }
            innerHtml +=  '<td>0</td>';
            innerHtml +=  '<tr>';
            for(var n = 0; n < resultList.length; n++){
                innerHtml +=  '<td>'+resultList[n].degree+'</td>';
                innerHtml +=  '<td>'+resultList[n].peopleCount+'</td>';
                innerHtml +=  '<td>0</td>';
                if(one == 0){
                    innerHtml += '</tr>';
                }
            }
        }
        one = 1;
    }
    innerHtml +=   '</tr>';
    innerHtml += '</table>';
    return innerHtml;
}
/**团体报告--报告下面的提示
 * @page:reportGroup/reportDepartment
 */
function reportTips(data){
    var html1 = '';
    html1 += '<div class="r-tips">';
    html1 +=     '<h3>提示</h3>';
    if(data == ''){
        html1 += '<div class="gray">无</div>';
    }else{
        html1 += '<div class="gray">'+data+'</div>';
    }
    html1 += '</div>';
    return html1;
}

/**部门列表
 * @page:reportDepartmentList
 */
function departmentList(){
    showLoadingLittle($("#listBox"));
    getAjax({
        url: config.url + "group/batch/department/list/"+bId+"?token="+token,
        success:function (data) {
            var result = data.data;
            var list = result.departmentList;
            if(list.length > 0){
                $("#listBox").html(htmlDepartmentList(list));
            }else{
                $("#listBox").html(noList());
            }
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**部门列表-HTML
 * @page:reportDepartmentList
 */
function htmlDepartmentList(data) {
    var innerHtml = '';
    for(var i = 0; i < data.length; i++){
        innerHtml += '<div class="col-xs-3 col-md-3">';
        innerHtml +=     '<div class="dment">';
        innerHtml +=     '<h2>'+data[i].name+'</h2>';
        innerHtml +=     '<div class="pd5">';
        var teamList = data[i].teamList;
        for(var j = 0; j < teamList.length; j++){
            innerHtml +=     '<p class="mb10">'+teamList[j].name+'：'+teamList[j].peopleCount+'人</p>';
        }
        innerHtml +=     '</div>';
        innerHtml +=     '<div class="pd5 text-center"><a href="reportDepartment.html?bId='+data[i].batchId+'&dId='+data[i].departmentId+'" class="mbtn">查看报告</a></div>';
        innerHtml +=     '</div>';
        innerHtml += '</div>';
    }
    return innerHtml;
}
/**部门报告
 * @page:reportDepartment
 */
function reportDepartment(){
    showLoadingLittle($("#checkResultList"));
    postAjax({
        url: config.url + "group/department/report/detail?token="+token,
        data: {batchId:bId,departmentId:dId,groupType:uType},
        success:function (data) {
            var result = data.data;
            //检测结果列表
            var checkResultList = result.checkResultList;
            $("#checkResultList").html(htmlCheckResultList(checkResultList));
            if(checkResultList.length > 0){
                for(var i = 0; i < checkResultList.length; i++){
                    htmlReportGroupPie(i,checkResultList[i]);
                }
            }
            $("#checkResultList").append(reportTips(result.checkResultHint));
            //平均分
            var averageScoreList = result.sheetAverageScoreList;
            var packagePeopleCount = result.packagePeopleCount;
            $("#groupAverage").html(htmlReportGroupAverage(packagePeopleCount,averageScoreList));
            $("#groupAverage").append(reportTips(result.sheetAverageScoreHint));
            //部门小组情况
            var teamReportList = result.teamReportList;
            $("#groupDepartment").html(htmlReportGroupDepartment(teamReportList,'department'));
            $("#groupDepartment").append(reportTips(result.teamListHint));
            htmlHeight();
        },fail:function(data){
            Alert(data.msg);
        }
    })
}

/**小组列表
 * @page:reportTeamList
 */
function teamList(){
    showLoadingLittle($("#listBox"));
    postAjax({
        url: config.url + "group/batch/team/list?token="+token,
        data: {batchId:bId,departmentId:dId,groupType:uType},
        success:function (data) {
            var result = data.data;
            var list = result.teamList;
            if(list.length > 0){
                $("#listBox").html(htmlTeamList(list));
            }else{
                $("#listBox").html(noList());
            }
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**小组列表--HTML
 * @page:reportTeamList
 */
function htmlTeamList(data) {
    var innerHtml = '';
    for(var i = 0; i < data.length; i++){
        innerHtml += '<div class="col-xs-3 col-md-3">';
        innerHtml +=     '<div class="dment">';
        innerHtml +=     '<h2>'+data[i].name+'</h2>';
        innerHtml +=     '<div class="pd5">';
        innerHtml +=         '<p class="mb10">人数：'+data[i].peopleCount+'人</p>';
        innerHtml +=         '<p class="mb10">套餐：'+data[i].packageNameStr+'</p>';
        innerHtml +=     '</div>';
        innerHtml +=     '<div class="pd5 text-center"><a href="reportTeam.html?bId='+data[i].batchId+'&tId='+data[i].teamId+'" class="mbtn">查看报告</a></div>';
        innerHtml +=     '</div>';
        innerHtml += '</div>';
    }
    return innerHtml;
}
/**小组报告
 * @page:reportTeam
 */
function reportTeam(){
    showLoadingLittle($("#checkResultList"));
    postAjax({
        url: config.url + "group/team/report/detail?token="+token,
        data: {batchId:bId,teamId:tId,groupType:uType},
        success:function (data) {
            var result = data.data;
            //检测结果列表
            var checkResultList = result.checkResultList;
            $("#checkResultList").html(htmlCheckResultList(checkResultList));
            if(checkResultList.length > 0){
                for(var i = 0; i < checkResultList.length; i++){
                    htmlReportGroupPie(i,checkResultList[i]);
                }
            }
            $("#checkResultList").append(reportTips(result.checkResultHint));
            //平均分
            var averageScoreList = result.sheetAverageScoreList;
            var packagePeopleCount = result.packagePeopleCount;
            $("#groupAverage").html(htmlReportGroupAverage(packagePeopleCount,averageScoreList));
            $("#groupAverage").append(reportTips(result.sheetAverageScoreHint));
            htmlHeight();
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**小组--用户列表
 * @param:reportUserList
 * */
function reportUserList(pageNum){
    showLoadingLittle($("#listBox"));
    postAjax({
        url: config.url + "group/batch/team/patient/paging?token=" + token,
        data: {pageNum:pageNum,pageSize:pageSize,condition:{batchId:bId,teamId:tId,groupType:uType}},
        success:function(data){
            var list = data.data.list;
            if(list.length == 0){
                $("#listBox").html(noList());
                $(".pages").remove();
            }else{
                $("#listBox").html(htmlReportUserList(list));
                //分页数>1时显示分页
                if(data.data.totalPage>1){
                    if($(".pages").length<1){
                        $("#listBox").after('<div class="pages mt20"><div class="M-box"></div></div>');
                    }
                    //分页
                    $('.M-box').pagination({
                        totalData:data.data.totalResult, //数据总条数
                        pageCount:data.data.totalPage,
                        showData:10, //每页显示的条数
                        current:pageNum,
                        callback:function(api){
                            pageNum = api.getCurrent(); //获取当前页
                            reportUserList(pageNum);
                        }
                    });
                }else{
                    $(".pages").remove();
                }
            }
        },fail:function(data){
            Alert(data.msg);
        }
    })
}
/**小组--用户列表--HTML
 * @param:reportUserList
 * */
function htmlReportUserList(data){
    var innerHTML = '';
    innerHTML += '<table class="table table-blue">';
    innerHTML +=   '<tr>';
    innerHTML +=     '<th class="divide-20">体检卡号</th>';
    innerHTML +=     '<th class="divide-15">姓名</th>';
    innerHTML +=     '<th class="divide-15">手机号码</th>';
    innerHTML +=     '<th class="divide-30">套餐或量表</th>';
    innerHTML +=     '<th class="divide-10">操作</th>';
    innerHTML +=   '</tr>';
    for(var i = 0; i < data.length; i++){
        if(i%2 == 0){
            innerHTML += '<tr class="active">';
        }else{
            innerHTML += '<tr>';
        }
        innerHTML +=       '<td>'+data[i].cardNumber+'</td>';
        innerHTML +=       '<td>'+data[i].name+'</td>';
        innerHTML +=       '<td>'+data[i].mobile+'</td>';
        innerHTML +=       '<td>'+data[i].packageNameStr+'</td>';
        if(data[i].reportId == ''){
            innerHTML +=   '<td>未检测</td>';
        }else{
            innerHTML +=   '<td><a href="reportDetail.html?rId='+data[i].reportId+'" class="mbtn-b mbtn-blue">查看报告</a></td>';
        }
        innerHTML +=   '</tr>';
    }
    innerHTML += '</table>';
    return innerHTML;
}
