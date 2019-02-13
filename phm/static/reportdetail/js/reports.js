/**报告-详情
 * @page:checkupReportingDetail
 */
function reportDetail(reportId) {
    getAjax({
        url: "/phm/patientcheckreport/findPachageCheckReportDetail/"+reportId,
        success:function (data) {
            var result = data.data;
            $("#reportTitle").html(result.hospitalName+'体检报告');
            $("#name").text(result.name);
            $("#checkCardNum").text(result.checkCardNum);
            $("#mobile").text(result.mobile);
            $("#genderName").text(result.genderName);
            $("#age").text(result.age);
            $("#career").text(result.career);
            $("#maritalStatusName").text(result.maritalStatusName);
            $("#degree").text(result.degree);
            $("#groupName").text(result.groupName);
            $("#checkDoctorName").text(result.checkDoctorName);
            $("#checkOfficeName").text(result.checkOfficeName);
            $("#checkPackageName").text(result.checkPackageName);
            $("#treatCardNum").text(result.treatCardNum);
            $("#reportTime").text(result.reportTime);
            $("#checkTime").text(result.checkTime);
            var reportList = result.sheetReportList;
            sheetNum = reportList.length;
            var iHtml = '';
            for(var i = 0; i<reportList.length; i++){
                var report = reportHtml(reportList[i],i,reportList.length);
                $("#listBox").append(report);
                if(reportList[i].ecahrtType == 4){
                    iHtml = '<p class="text-center jsScore" style="margin-top: -70px;"><span class="mlr10 yinzi">测试结果：'+reportList[i].score+'分</span>';
                }else{
                    iHtml = '<p class="text-center jsScore"><span class="mlr10 yinzi">测试结果：'+reportList[i].score+'分</span>';
                }
                if(reportList[i].factors.length>0){
                    for(var j= 0; j<reportList[i].factors.length; j++){
                        iHtml += '<span class="mr20 yinzi">'+reportList[i].factors[j].name + ": " +reportList[i].factors[j].score+'分</span>';
                    }
                }
                iHtml += '</p>';
                $("#chartImg_"+i).after(iHtml);
                $("#btnTop").show();
                $("#btnTop").text("打印");
                $("#checkCommentArea_"+i).hide();
                $("#checkSuggestArea_"+i).hide();
                $("#checkComment_"+i).show();
                $("#checkSuggest_"+i).show();
                $("#btnUpdate_"+i).hide();
                //图形
                if(reportList[i].echartType == 1){//1折线图 2条形图 3饼状图 4仪表盘
                    chartLine(reportList[i],i);
                }else if(reportList[i].echartType == 2){
                    chartColumnar(reportList[i],i);
                }else if(reportList[i].echartType == 3){
                    chartPie(reportList[i],i)
                }else{
                    //chartPanel(reportList[i],i);
                    chartPanel2(reportList[i],i);
                }
            }
            //签名
            var singUrl = '<div class="text-right mt20"><img src="/phm/'+result.doctorSignUrl+'" class="signature" id="doctorSignUrl"></div>'
            $("#listBox").find(".border.last").append(singUrl);
        },fail:function(data){
            //Alert(data.msg);
        }
    })
}
/**体检结果统计图-仪表盘
 * @page:checkupReportingDetail
 */
function chartPanel(data,idx) {
    var result = data;
    if(data.renderExpression == ""){
        Alert2("后台体检表参数没配置成功，不能访问！");
        return;
    }
    var tempObject = JSON.parse(data.renderExpression);
    var number = tempObject.color.length;//分成几段
    var colorArr = [];
    for(var i = 0;i< number;i++){
        colorArr[i] = [tempObject.section[i+1] /tempObject.section[number], tempObject.color[i]];
    }
    var myChart = echarts.init(document.getElementById('chart_'+idx));
    myOption = {
        tooltip : {
            //formatter: "{a} <br/>{b} : {c}"
        },
        toolbox: {
            feature: {
                //restore: {},//刷新按钮
                //saveAsImage: {}//显示把表格以图片形式下载
            }
        },
        series: [
            {
                name: result.sheetName,
                type: 'gauge',
                radius: '100%',
                max: tempObject.section[number],//最大值
                //splitNumber: number, //分割段数，默认为10
                detail: {formatter:result.score + ""},
                data: [{value: result.score,name: "得分"}],
                axisLine: { //坐标轴线，默认显示
                    lineStyle: {       // 颜色区块
                        //color: [[0.2, '#008001'], [0.3, '#f3bb20'], [0.4, '#f07a20'],[1, '#fe0000']],
                        color: colorArr,
                    }
                },
                splitLine:{//主分隔线，默认显示
                    show: true,
                    length:30,
                    lineStyle: {
                        color: '#eee',
                        width: 0.4,
                        type: 'solid'
                    }
                }
            }
        ]
    };
    myChart.setOption(myOption);
    //打印预览把表格生成图片
    var myChartImg = document.getElementById('chartImg_'+idx);
    myChartImg.src = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });
}
function chartPanel2(data,idx) {
    var result = data;
    if(data.renderExpression == ""){
        Alert2("后台体检表参数没配置成功，不能访问！");
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
    //打印预览把表格生成图片
    var myChartImg = document.getElementById('chartImg_'+idx);
    myChartImg.src = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });
}
/**体检结果统计图-饼状图
 * @page:checkupReportingDetail
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
                name:'测试结果：',
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
    //打印预览把表格生成图片//getDataURL 调用得太快了，饼图还没有渲染（饼图有初始动画）,不加延时图片生成不成功
    setTimeout(function () {
        var myChartImg = document.getElementById('chartImg_'+idx);
        myChartImg.src = myChart.getDataURL({
            pixelRatio: 2,
            backgroundColor: '#fff'
        });
    },1500)
}
/**体检结果统计图-折线图
 * @page:checkupReportingDetail
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
                //saveAsImage: {}//显示把表格以图片形式下载
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
    //打印预览把表格生成图片
    var myChartImg = document.getElementById('chartImg_'+idx);
    myChartImg.src = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });
}
/**体检结果统计图-条形图(柱状图)
 * @page:checkupReportingDetail
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
        color: ['#4099fd'],
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
                barWidth: '60%',
                //data:[10, 52, 200, 334, 390, 330, 220]
                data: myData
            }
        ]
    };
    myChart.setOption(myOption);
    //打印预览把表格生成图片
    var myChartImg = document.getElementById('chartImg_'+idx);
    myChartImg.src = myChart.getDataURL({
        pixelRatio: 2,
        backgroundColor: '#fff'
    });
}

/**体检报告每套题目单个Html
 * @page:checkupReportingDetail
 */
function reportHtml(data,idx,length) {
    var result = data;
    var innerHtml = '';
    if(idx == length-1){
        innerHtml += '<div class="border pd2 mt20 last">';
    }else{
        innerHtml += '<div class="border pd2 mt20">';
    }
    innerHtml += '<div class="rtitle2">{reportName}</div>';
    innerHtml += '<div class="row mt20">';
    innerHtml +=     '<div class="col-xs-12 col-md-12">';
    innerHtml +=         '<div class="mtitle"><i class="icon icon-dian"></i>体检结果统计图</div>';
    innerHtml +=     '</div>';
    innerHtml +=     '<div class="pd2" id="chartBox">';
    innerHtml +=        '<div id="chart_'+idx+'" style="width: 100%; height: 450px;"></div>';
    innerHtml +=        '<img id="chartImg_'+idx+'" style="width:100%;display:none;">';
    innerHtml +=    '</div>';
    innerHtml += '</div>';
    innerHtml += '<div class="row mt20 js_answer">';
    innerHtml +=     '<div class="col-xs-12 col-md-12">';
    innerHtml +=         '<div class="mtitle"><i class="icon icon-dian"></i>答题记录</div>';
    innerHtml +=     '</div>';
    innerHtml += '</div>';
    innerHtml += '<div class="text-center mt20 js_answerbtn"><a href="javascript:;" onclick="goToAnswer('+result.sheetReportId+')" class="mbtn mbtn-blue mbtn-big">查看答题详情</a></div>';
    innerHtml += '<div class="row mt20">';
    innerHtml +=     '<div class="col-xs-12 col-md-12">';
    innerHtml +=         '<div class="mtitle"><i class="icon icon-dian"></i>体检评语</div>';
    innerHtml +=     '</div>';
    innerHtml +=     '<div class="pd2">';
    innerHtml +=         '<textarea class="form-control text-left textarea" id="checkCommentArea_'+idx+'" rows="6" style="display:none">{comment}</textarea>';
    innerHtml +=         '<div class="pbox" id="checkComment_'+idx+'">{comment}</div>';
    innerHtml +=     '</div>';
    innerHtml += '</div>';
    innerHtml += '<div class="row mt20">';
    innerHtml +=     '<div class="col-xs-12 col-md-12">';
    innerHtml +=         '<div class="mtitle"><i class="icon icon-dian"></i>体检建议</div>';
    innerHtml +=     '</div>';
    innerHtml +=     '<div class="pd2">';
    innerHtml +=         '<textarea class="form-control text-left textarea" rows="6" id="checkSuggestArea_'+idx+'" style="display: none">{suggest}</textarea>';
    innerHtml +=         '<div class="pbox" id="checkSuggest_'+idx+'">{suggest}</div>';
    innerHtml +=     '</div>';
    innerHtml += '</div>';
    innerHtml += '<div class="text-center"><a href="javascript:;" class="mbtn mbtn-blue mbtn-big" id="btnUpdate_'+idx+'" onclick="reportUpdate('+result.sheetReportId+','+idx+')">确认修改</a></div>';
    innerHtml += '</div>';
    innerHtml += '<div style="page-break-after:always;"></div>';
    innerHtml = innerHtml.replace("{reportName}",result.sheetName);
    innerHtml = innerHtml.replace("{comment}",result.checkComment).replace("{comment}",result.checkComment);
    innerHtml = innerHtml.replace("{suggest}",result.checkSuggest).replace("{suggest}",result.checkSuggest);
    return innerHtml;
}
/**体检报告去每套题目详情
 * @page:checkupReportingDetail
 */
function goToAnswer(sheetReportId) {
    jump("/phm/patientcheckreport/goCheckupReportingAnswer/"+sheetReportId);
}

/**用户答题记录
 * @page:checkupReportingAnswer
 */
function answerList(reportId,pageNum,pageSize) {
    getAjax({
        url: "/phm/patientcheckreport/findUserOptionList?reportId="+reportId+"&pageNum="+pageNum+"&pageSize="+pageSize,
        success:function (data) {
            var result = data.data.questionList;
            var list = result.list;
            $("#topic").html("<span>量表："+data.data.sheetInfo.sheetName+"</span>");
            if(list.length == 0){
                $("#answer").html('<div class="pd5 text-center"><i class="ic ic-no-info"></i><p class="gray">没有数据显示</p></div>');
                $(".pages").remove();
            }else{
                var innerHtml = '';
                var xuhao = 0;
                for(var i = 0; i<list.length; i++){
                    if(pageNum == 1){
                        xuhao = i + 1;
                    }else{
                        xuhao = (pageNum-1)*result.showCount+(i + 1);
                    }
                    innerHtml += '<div class="col-xs-4 col-md-4 border-right-bottom">';
                    innerHtml +=     '<div class="pd5">';
                    if(list[i].o_cont_type == 1){
                        innerHtml +=     '<p class="que">'+xuhao+'. 问：<img src="'+list[i].questionDescription+'" class="question" /></p>';
                    }else{
                        innerHtml +=     '<p class="que">'+xuhao+'. 问：'+list[i].questionDescription+'</p>';
                    }
                    if(list[i].q_cont_type == 1){//0文字1图片
                        innerHtml +=     '<p class="blue">&nbsp;&nbsp;&nbsp;&nbsp;答：<img src="'+imgUrl+list[i].optionDescription+'" class="answer" /></p>';
                    }else{
                        innerHtml +=     '<p class="blue">&nbsp;&nbsp;&nbsp;&nbsp;答：'+list[i].optionDescription+'</p>';
                    }
                    innerHtml +=     '</div>';
                    innerHtml += '</div>';
                }
                $("#answer").html(innerHtml);
                //分页数>1时显示分页
                if(result.totalPage>1){
                    if($(".pages").length<1)
                        $("#answer").after('<div class="pages mt20"><div class="M-box"></div></div>');
                    //分页
                    $('.M-box').pagination({
                        totalData:result.totalResult, //数据总条数
                        pageCount:result.totalPage,
                        showData:15, //每页显示的条数
                        coping:true, //是否开启首页和末页，值为boolean
                        isHide:true,//总页数为0或1时隐藏分页控件
                        keepShowPN:true, //是否一直显示上一页下一页
                        current:pageNum,
                        callback:function(api){
                            pageNum = api.getCurrent(); //获取当前页
                            answerList(reportId,pageNum,pageSize);
                        }
                    });
                }else{
                    $(".pages").remove();
                }
            }
        },fail:function(data){
            Alert(data.msg)
        }
    })
}
