//页面跳转
function jump(page) {
    window.location.href = page;
}
/*获取URL参数
 *decodeURI() 函数可对 encodeURI() 函数编码过的 URI 进行解码。
 *返回theRequest对象（参数1个或多个都可用）
**/
function getURL(){
    var url = decodeURI(window.location.search);
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i++){
            theRequest[strs[i].split("=")[0]] = strs[i].split("=")[1];
        }
    }
    if (theRequest.length <= 0)
        return null;
    return theRequest;
}
//loading -- page need bootstrap
function showLoading(txt) {
    var innerHtml = '';
    innerHtml += '<div class="modal" id="showLoading" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
    innerHtml += '<div class="modal-dialog" style="width:224px">';
    innerHtml += '<div class="modal-content pd20">';
    innerHtml += '<div class="modal-body text-center"><img src="images/loading.gif" /><p class="mt10">'+ txt +'</p></div>';
    innerHtml += '</div></div></div>';
    $("body").append(innerHtml);
    $('#showLoading').modal({
        backdrop: false,//点击空白处不关闭对话框
        keyboard: false,//键盘关闭对话框
        show:true//弹出对话框
    });
}
function showLoadingLittle(lab) {
    var innerHtml = '<div class="pd5 text-center"><img src="images/loading2.gif" /><p class="mt5">加载中...</p></div>';
    $(lab).html(innerHtml)
}
function hideLoading() {
    $("#showLoading").remove();
    $(".modal-backdrop").remove();
}
//Alert -- page need bootstrap
function Alert(txt) {
    var innerHtml = '';
    innerHtml += '<div class="modal" id="Alert" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
    innerHtml +=     '<div class="modal-dialog" style="width:200px">';
    innerHtml +=         '<div class="modal-content pd20">';
    innerHtml +=             '<div class="modal-body text-center"><p class="mt10">'+ txt +'</p></div>';
    innerHtml +=         '</div>';
    innerHtml +=     '</div>';
    innerHtml += '</div>';
    $("body").append(innerHtml);
    $("#Alert").modal("show");
    $(".modal-backdrop").remove();
    setTimeout(function () {
        $("#Alert").remove();
        $(".modal-backdrop").remove();
    },1000)
}
//Alert no need bootstrap
function Alert2(txt) {
    var innerHtml = '';
    innerHtml += '<div class="modal in show" id="Alert2" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
    innerHtml +=     '<div class="modal-dialog" style="width:200px; margin-top: 30%;">';
    innerHtml +=         '<div class="modal-content pd20">';
    innerHtml +=             '<div class="modal-body text-center"><p class="mt10">'+ txt +'</p></div>';
    innerHtml +=         '</div>';
    innerHtml +=     '</div>';
    innerHtml += '</div>';
    $("body").append(innerHtml);
    $(".modal-backdrop").remove();
    setTimeout(function () {
        $("#Alert2").remove();
        $(".modal-backdrop").remove();
    },1000)
}
//Ajax-get
function getAjax(param){
    var url = param.url;
    var success = param.success;
    var fail = param.fail;
    $.ajax({
        url:url,
        type:"get",
        dataType:"json",
        contentType: "application/json; charset=utf-8",
        success:function(data){
            var code = data.code;
            if(code == 200){
                success(data);
            }else if(code == 402 || code == 407){
                console.log("参数存在异常");
            }else if(code == 409 || code == 410){
                jump(config.login);
                delAllCookies();
            }else{
                fail(data);
            }
        },error:function (xhr) {
            Alert("网络不稳定，稍后再试！");
        }
    });
}
//Ajax-post
function postAjax(param){
    var url = param.url;
    var para = param.data;
    var success = param.success;
    var fail = param.fail;
    $.ajax({
        url:url,
        type:"post",
        dataType:"json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(para),
        success:function(data){
            var code = data.code;
            if(code == 200){
                success(data);
            }else if(code == 402 || code == 407){
                console.log("参数存在异常");
            }else if(code == 409 || code == 410){
                jump(config.login);
                delAllCookies();
            }else{
                fail(data);
            }
        },error:function (xhr) {
            Alert("网络不稳定，稍后再试！");
        }
    });
}
/**截取时间（如把2017-10-17 12:40:57截取只要2017-10-17）
 * @page:用到时间的地方
 * @type:html
 */
function cutOutTime(time) {
    var cTime = time.split(" ");
    return cTime[0];
}