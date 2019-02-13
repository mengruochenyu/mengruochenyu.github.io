var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});


//菜单状态切换
var fmid = "fhindex";
var mid = "fhindex";
function siMenu(id,fid,menuName,menuUrl){
	if(id != mid){
		$("#"+mid).removeClass();
		mid = id;
	}
	if(fid != fmid){
		$("#"+fmid).removeClass();
		fmid = fid;
	}
	$("#"+fid).attr("class","active open");
	$("#"+id).attr("class","active");
	top.mainFrame.tabAddHandler(id,menuName,menuUrl);
}

var USER_ID;

$(function(){
	$.ajax({
		type: "POST",
		url: locat+'/head/getUname.do?tm='+new Date().getTime(),
    	data: encodeURI(""),
		dataType:'json',
		//beforeSend: validateData,
		cache: false,
		success: function(result){
			if(result.code == 200){
				var resultData = result.data;
				$("#user_info").html('<small>Welcome</small> '+resultData.name+'');
				USER_ID = resultData.userId;
			}
		}
	});
});


//修改个人资料
function editUserH(){
	 BootstrapDialog.show({cssClass:"two-row-dialog",
        message: $('<div></div>').load(locat+'/userInfo/goEdit'),
        title: '修改资料',
      });
}

//菜单
function menu(){
	 BootstrapDialog.show({cssClass:'three-row-dialog',
         message: $('<div id="leftMenuId"></div>').load(locat+'/menu.do'),
         title: '菜单编辑'
       });
	 
}

//清除加载进度
function hangge(){
	$("#jzts").hide();
}

//显示加载进度
function jzts(){
	$("#jzts").show();
}