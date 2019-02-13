var SELECT_LIST = {
	//动态，获取医生列表 
	getDoctorSelect:function(targetId,selectedValue){
		var url = "doctor/getallinfo";
		var item = {};
		item.url = url;
		item.targetId = targetId;
		item.selectedValue = selectedValue;
	    item.firstOption = '<option value="">选择医生</option>';
		ajaxGenerateSelect(item);
	},
	
	//动态，获取头衔列表 
	getDoctorTitleSelect:function(targetId,selectedValue){
		var url = "dictionary/findListByDicType/doctor_title";
		var item = {};
		item.url = url;
		item.targetId = targetId;
		item.selectedValue = selectedValue;
	    item.firstOption = '<option value="">--请选择头衔--</option>';
	    item.keyValue = "dictionaryId";
	    item.keyName = "dicName";
		ajaxGenerateSelect(item);
	},
	
	//动态，获取开拓人员列表
  	getDoctorExpioneerSelect:function(targetId,selectedValue){
  		var url = "doctorexploiter/getAllList";
		var item = {};
		item.url = url;
		item.targetId = targetId;
		item.selectedValue = selectedValue;
	    item.firstOption = '<option value="">--请选择开拓人员--</option>';
		ajaxGenerateSelect(item);
	},
	
	//静态，获取性别下拉菜单
	getGenderSelect:function(targetId,selectedValue){
		var data = ["男","女"];
		var value= ["1","0"];
		var html = "";
		html = '<option value="">--请选择性别--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取学历下拉菜单
	getDegreeSelect:function(targetId,selectedValue){
		var data = ["本科及以上","大专","高中/中专","初中","小学","其他"];
		var value= ["本科及以上","大专","高中/中专","初中","小学","其他"];
		var html = "";
		html = '<option value="">--请选择学历--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取职业下拉菜单
	getCareerSelect:function(targetId,selectedValue){
		var data = ["企业职员","国家公职人员","务农","务工","科技技术员","教师","学生","无业","其他"];
		var value= ["企业职员","国家公职人员","务农","务工","科技技术员","教师","学生","无业","其他"];
		var html = "";
		html = '<option value="">--请选择职业--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i]; 
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取婚姻状况下拉菜单
	getMaritalStatusSelect:function(targetId,selectedValue){
		var data = ["未婚","已婚","离异"];
		var value= ["0","1","2"];
		var html = "";
		html = '<option value="">--请选择婚姻状况--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取账号类型
	getAccountTypeSelect:function(targetId,selectedValue){
		var data = ["支付宝账户","微信账户","银行卡账户"];
		var value= ["1","2","3"];
		var html = "";
		html = '<option value="">--请选择账户类型--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取医生账号状态
          	getDoctorStatusSelect:function(targetId,selectedValue){
		var data = ["启用","禁用"];
		var value= ["1","0"];
		var html = "";
		html = '<option value="">--请选择状态--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
	        		selected = "selected";
	        	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
	         html += option;
	        }
		 $("#" + targetId).html('').append(html);
	},
	
	//静态，获取量表的展示形式
  	getEchartTypeSelect:function(targetId,selectedValue){
  		console.log(selectedValue);
		var data = ["折线图","条形图","饼状图","仪表盘","雷达图","条形指针图"];
		var value= [1,2,3,4,5,6];
		var html = "";
		html = '<option value="">--选择显示的展示方式--</option>';
		 for(var i=0;i<data.length;i++){
			 var option = "<option value='#(value)' #(selected)>#(name)</option>";
			 var dataItem = value[i];
			 var selected = "";
			 if (selectedValue == value[i]){
		    		selected = "selected";
		    	}
			 var nameValue = data[i];
			 option = option.replace("#(value)", dataItem).replace("#(selected)", selected).replace("#(name)",nameValue);
		     html += option;
		    }
		 $("#" + targetId).html('').append(html);
	}
	
}
