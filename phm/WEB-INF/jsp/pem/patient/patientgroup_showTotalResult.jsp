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
			table,th,td{text-align:center;}		
			#averageForAll{width:480px; height:300px;}
			#averageForExc{width:480px; height:300px;}
			#detail{padding: 50px 100px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;}
		</style>
<%@ include file="../../system/admin/top.jsp"%> 
<script type="text/javascript">
$(function(){
	var averageForAll = echarts.init(document.getElementById('averageForAll'));	
	var averageForExc = echarts.init(document.getElementById('averageForExc'));	
 	var DataStr =${checkResult};
 	//各项平均检测值
 	var allData = DataStr.allAverageValueList;
 	var allValuesLen = allData.length;
 	var allValuesArr = new Array();
 	var allNamesArr = new Array();
 	for(var i= 0;i<allValuesLen;i++){
 		allValuesArr.push(allData[i].value);
 		allNamesArr.push(allData[i].name);
 	}
 	//异常平均检测值
 	var excData = DataStr.exceptionalAverageValueList;
 	var excValuesLen = excData.length;
 	var excValuesArr = new Array();
 	var excNamesArr = new Array();
 	for(var i= 0;i<excValuesLen;i++){
 		excValuesArr.push(excData[i].value);
 		excNamesArr.push(excData[i].name);
 	}

	var allOption = {
	    title: {
	        text: '各项平均检测值',
	        subtext: ''
	    },
	    color: ['#3398DB'],
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
	            data :allNamesArr,
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
	            name:'直接访问',
	            type:'bar',
	            barWidth: '60%',
	            data:allValuesArr
	        }
	    ]
	};
	averageForAll.setOption(allOption);	
	var excOption = {	
	    title: {
	        text: '各项异常检测值',
	        subtext: ''
	    },
	    color: ['#3398DB'],
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
	            data :excNamesArr,
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
	            name:'直接访问',
	            type:'bar',
	            barWidth: '60%',
	            data:excValuesArr
	        }
	    ]
	};
	averageForExc.setOption(excOption);
	//异常明细
	averageForExc.on('click', function (param) {
		var title = DataStr.groupName+" "+allData[param.dataIndex].name+" 检查异常人员明细";
 		var excDetail = allData[param.dataIndex].detail;
		var len = excDetail.length; 
		var str = "<div id='detail'>"
  		for(var j= 0; j<len;j++){
  			str += '<p>'+excDetail[j].name+" 的检测值是 "+excDetail[j].value+'</p>'; //拼接str

		} 
		str +="</div>"
		layer.open({
			  type: 1
			  ,title: title //不显示标题栏
			  ,closeBtn: false
			  ,area: '400px;'
			  ,shade: 0
			  ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
			  ,resize: true
			  ,btn: ['我知道了']
			  ,btnAlign: 'c'
			  ,moveType: 1 //拖拽模式，0或者1
			  ,content:str
			});
	});
});
</script>
	</head>
<body>
<%-- 	<h3>${checkResult.groupName}</h3> --%>
	<table class="table table-bordered">
	  <thead>
	  	<tr>
	  		<th>应检人数</th>
		  	<th>实检人数</th>
		  	<th>正常人数</th>
		  	<th>异常人数</th>
	  	</tr>
	  </thead>
	  <tbody>
	  	<tr>
	  		<td>${checkResultObject.allNum}</td>
	  		<td>${checkResultObject.doneNum}</td>
	  		<td>${checkResultObject.normalNum}</td>
	  		<td>${checkResultObject.exceptionalNum}</td>
	  	</tr>	
	  </tbody>
	</table>
<div id ="averageForAll"></div>
<div id ="averageForExc"></div>
</body>
</html>