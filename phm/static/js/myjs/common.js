
function ajaxSave(target, url, action, codeErrorHandle, resetFun, afterHandle, jsonData){
    var data;
    var formItem;
    if(jsonData){
        data = jsonData;
    }else{
        formItem = getFormItem(target);
        data = serializeArray(formItem);
    }
        
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        dataType:'json',
        contentType: "application/json;charset=UTF-8",
        cache: false,
        success: function(data){
            var isAdd = "save" == action || action.indexOf("save") == 0;
            hideSavingMessage(target);  
            if(200 == data.code){
                if(isAdd){
                    showSuccessMessage();
                    if(resetFun){
                        resetFun();
                    }else{
                        if(formItem)
                            formItem.reset();
                    }
                }else{
                    showSuccessMessage();
                    hideDialog(target);
                }

                if(afterHandle){
                    afterHandle(data.data);
                }else{
                	location.reload();
                }
            }else if(codeErrorHandle){
                codeErrorHandle(data.code);
            }else if(data.msg){
            	bootbox.alert(data.msg);
            }else{
                bootbox.alert("保存失败");
            }
        },
        error: function(data){
            hideSavingMessage(target);  
            bootbox.alert("出现异常");
        }
    });
    
    showSavingMessage(target);
}


function ajaxDelete(url){
	bootbox.confirm("确定要操作吗?", function(result) {
		if(!result)
			return;
		ajaxConfirmDelete(url, {});
	});
    
}

function ajaxConfirmDelete(url, data){
	var ajaxObject = {};
	ajaxObject.url = url;
	ajaxObject.data = data;
	ajaxObject.success = function(result){
		location.reload();
	};
	ajaxObject.fail = function(result){
		 bootbox.alert("删除失败");
	};
	
	ajaxPost(ajaxObject);
}

function ajaxDeleteBatch(url){
	bootbox.confirm('确定要删除选中的数据吗?', function(result) {
		if(result) {
			
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			if(str==''){
				bootbox.dialog("您没有选择任何内容!", 
					[
					  {
						"label" : "关闭",
						"class" : "btn-small btn-success",
						"callback": function() {
							//Example.show("great success");
							}
						}
					 ]
				);
				
				$("#zcheckbox").tips({
					side:3,
		            msg:'点这里全选',
		            bg:'#AE81FF',
		            time:8
		        });
				
				return;
			}else{
				var data = {ids:str};
				ajaxConfirmDelete(url,data);
			}
		}
	});
}


var isAjaxPost = false;
/***
 * 
 * {
 * 		target:
 * 		url:
 * 		data:
 * 		success:
 * 		fail:
 * 		error:
 * 		
 * }
 * @returns
 */
function ajaxPost(ajaxObject){
	if(isAjaxPost){
		return;
	}
	
//	var target = ajaxObject.target;
	var url = ajaxObject.url;
	var data = ajaxObject.data;
	var success = ajaxObject.success;
	var fail = ajaxObject.fail;
	var error = ajaxObject.error;
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        dataType:'json',
        contentType: "application/json;charset=UTF-8",
        cache: false,
        success: function(result){
        	isAjaxPost = false;
            if(200 == result.code){
                if(success){
                	success(result);
                }else{
                	location.reload();
                }
            }else if(fail){
            	fail(result);
            }else{
                bootbox.alert(result.msg);
            }
        },
        error: function(result){
        	isAjaxPost = false;
        	if(error){
        		error(result);
        	}else{
        		bootbox.alert("出现异常");
        	}
        }
    });
   
}

function ajaxMethod(ajaxObject){
	var url = ajaxObject.url;
	var success = ajaxObject.success;
	var fail = ajaxObject.fail;
	var error = ajaxObject.error;
	var data = ajaxObject.data;
	
    $.ajax({
        type: ajaxObject.method,
        url: url,
        data: data,
        dataType:'json',
        contentType: "application/json;charset=UTF-8",
        cache: false,
        success: function(result){
            if(200 == result.code){
                success(result);
            }else if(fail){
            	fail(result);
            }else{
                bootbox.alert(result.msg);
            }
        },
        error: function(result){
        	if(error){
        		error(result);
        	}else{
        		bootbox.alert("出现异常");
        	}
        }
    });
   
}

function serializeArray(formItem)
{
	var o = {};
	var a = $(formItem).serializeArray();
	$.each(a, function() {
    	if (o[this.name] !== undefined) {
        	if (!o[this.name].push) {
            	o[this.name] = [o[this.name]];
        	}
        	o[this.name].push($.trim(this.value) || '');
    	} else {
        	o[this.name] = $.trim(this.value) || '';
    	}
	});
	return o;
};

function showSuccessMessage(){
	toastr.options = {
      "closeButton": false,
      "debug": false,
      "newestOnTop": false,
      "progressBar": false,
      "positionClass": "toast-bottom-center",
      "preventDuplicates": true,
      "onclick": null,
      "showDuration": "300",
      "hideDuration": "1000",
      "timeOut": "2000",
      "extendedTimeOut": "1000",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut"
    }
    toastr.success("保存成功");
}

function showSavingMessage(target){
	var str = $(target).text()+"中...";
	$(target).text(str);
    $(target).attr("disabled", "disabled");
}

function hideSavingMessage(target){
	var str = $(target).text();
	str = str.substring(0,str.length-4)
    $(target).text(str);
	$(target).removeAttr("disabled");
}

function hideDialog(formItem){
    var id = getDialogId(formItem);
    if(id){
        BootstrapDialog.getDialog(id).close();
    }
}

function getDialogId(formItem){
    var parentEle = formItem.parentNode;
    while(parentEle){
        var role = parentEle.attributes["role"];
        if(role && role.value=="dialog"){
            return parentEle.id;
        }

        parentEle = parentEle.parentNode;
    }

    return "";
}

function getFormItem(btnItem){
    var parentEle = btnItem.parentNode;
    while(parentEle){
        var method = parentEle.attributes["method"];
        if(method && method.value=="post"){
            return parentEle;
        }

        parentEle = parentEle.parentNode;
    }    
}

function setListActionUrl(){
	var url = location.href;
	var actionUrl = url.split("?")[0];
	$("#Form").attr("action", actionUrl);
}


/***
 * 
 * {
 * 		url: 获取值的路径
 * 		mehtod: get还是post
 * 		keyValue: 对象中作为option value的字段
 * 		keyName: 对象中作为option显示的字段
 * 		targetId: select控件的id
 * 		selectedValue: select控件选中的值
 * 		firstOption: 首个提示框 = "<option value=''>请选择</option>";
 * 		
 * }
 * @returns
 */
function ajaxGenerateSelect(selectObject){
	var url = selectObject.url;
	var method = selectObject.method ? selectObject.method : "POST";
	var keyValue = selectObject.keyValue ? selectObject.keyValue : "id";
	var keyName = selectObject.keyName ? selectObject.keyName : "name";
	var selectedValue = selectObject.selectedValue ? selectObject.selectedValue : null;
	var targetId = selectObject.targetId;
	var condition = selectObject.condition ? selectObject.condition : {};
	var afterHandle = selectObject.afterHandle;
	var formatter = selectObject.formatter;
	var firstOption = selectObject.firstOption;
	var ajaxObject = {};
	ajaxObject.url = url;
	ajaxObject.method = method;
	ajaxObject.data = JSON.stringify(condition);
	ajaxObject.success = function(result){
		var data = result.data;
        var html = "";
        if(firstOption){
        	html = firstOption;
        }
        for(var i=0;i<data.length;i++){
        	var selected = "";
        	var dataItem = data[i];
        	if(selectedValue == dataItem[keyValue]){
        		selected = "selected";
        	}
             var option = "<option value='#(value)' #(selected)>#(name)</option>";
             var nameValue = dataItem[keyName];
             if(formatter){
            	 nameValue = formatter(dataItem);
             }
             option = option.replace("#(value)", dataItem[keyValue]).
             	replace("#(name)",nameValue).replace("#(selected)", selected);
             html += option;
        }
        $("#" + targetId).html('').append(html);
        if(afterHandle){
        	afterHandle();
        }
	};
	
	ajaxMethod(ajaxObject);
}

function getSelectedText(selectId){
	return $("#" + selectId).find("option:selected").text();
}

function goBack(){
	history.back();
}

function goBackAndRefresh(){
	location.href = document.referrer;
}

var tableMap = {};

function tableInputFormatter(value, row, index, inputIdSuffix, unit){
	if(!value){
		value = "";
	}
	if(!unit){
		unit = "";
	}
	
	var inputId = inputIdSuffix + index;
	tableMap[inputId] = row;
	
	var text = '<input style="width:120px" type="number" id="#(id)" value="'+value+'" ' + 
			'onblur=\'tableInputOnblurHandler(this, "#(targetId)", "#(key)")\'/>' + unit;
	text = text.replace("#(id)", inputId);
	text = text.replace("#(targetId)",inputId);
	text = text.replace("#(key)", inputIdSuffix);
	
    return text;
}

function tableInputOnblurHandler(target, id, key){
	var row = tableMap[id];
	row[key] = $(target).val();
}

function inputPopupTip(field, msg){
	$("#"+field).tips({
		side:3,
        msg:msg,
        bg:'#AE81FF',
        time:2
    });
	$("#"+field).focus();
}

function popupImage(url){
	layer.photos({
	    photos: {
	    	  "data": [   //相册包含的图片，数组格式
	    	    {
	    	      "src": url, //原图地址
	    	    }
	    	  ]
	    	}
	    ,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
	  });
}


function popupTargetImage(img){
	var url = img.src;
	popupImage(url);
}

function exportExcel(url, formId){
	window.location.href = url + "/excel?" + $("#" + formId).serialize();
}