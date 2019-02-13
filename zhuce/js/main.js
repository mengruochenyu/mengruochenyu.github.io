//var myHttp = 'http://118.178.182.6/';//测试
//var myHttp = 'http://120.55.52.206/';
var myHttp = 'http://127.0.0.1/';



/*var searchUrl = JSON.parse(localStorage.getItem("userUrl"));*/
var loginUrl = 'login.html';
/*if(searchUrl != null) {
    loginUrl = "login.html" + searchUrl;
}*/
    var config = {
        userUrl: myHttp + "phm/app/patient/",//1.0接口
        url: myHttp + "phm/api/",//2.0接口
        imgUrl: myHttp + "phm/",
        login: loginUrl
    }

    function setCookie(name, value) {
        /*localStorage(name, value);*/
        var Days = 30;
        var exp = new Date();
        exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
        document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ";path=/";
    }

    function setCookieNoTime(name, value) {
        document.cookie = name + "=" + escape(value) + ";path=/";
    }





//读取cookies
    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }

//删除cookies
    function delCookie(name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        var cval = getCookie(name);
        if (cval != null) {
            document.cookie = name + "=0;expires=" + exp.toGMTString() + ";path=/";
        }
    }

//退出登录删除cookies
    function delMember() {
        delCookie("pemUtoken");
        jump(config.login);
        localStorage.clear();
    }

//接口返回代码-调到登录页时删除cookies
    function delAllCookie() {
        delCookie("pemUtoken");
        localStorage.removeItem("userUrl");
        localStorage.clear();
    }

//页面跳转
    function jump(page) {
        window.location.href = page;
    }

    /*获取URL参数
     *decodeURI() 函数可对 encodeURI() 函数编码过的 URI 进行解码。
     *返回theRequest对象（参数1个或多个都可用）
    **/
    function getURL() {
        var url = decodeURI(window.location.search);
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
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
        innerHtml += '<div class="modal alert" id="showLoading" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
        innerHtml += '<div class="modal-dialog" style="width:224px">';
        innerHtml += '<div class="modal-content pd20">';
        innerHtml += '<div class="modal-body text-center"><img src="images/loading.gif" /><p class="mt10">' + txt + '</p></div>';
        innerHtml += '</div></div></div>';
        $("body").append(innerHtml);
        $('#showLoading').modal({
            backdrop: false,//点击空白处不关闭对话框
            keyboard: false,//键盘关闭对话框
            show: true//弹出对话框
        });
    }

    function showLoadingLittle(lab) {
        var innerHtml = '<div class="pd5 text-center"><img src="images/loading.gif" /><p class="mt5">加载中...</p></div>';
        $(lab).html(innerHtml)
    }

    function hideLoading() {
        $("#showLoading").remove();
        $(".modal-backdrop").remove();
    }

//Alert -- page need bootstrap
    function Alert(txt, func) {
        var innerHtml = '';
        innerHtml += '<div class="modal alert" id="Alert" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
        innerHtml += '<div class="modal-dialog" style="width:240px">';
        innerHtml += '<div class="modal-content">';
        innerHtml += '<div class="modal-body text-center"><p class="mt10">' + txt + '</p></div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        $("body").append(innerHtml);
        $("#Alert").modal("show");
        $(".modal-backdrop").remove();
        htmlHeight();
        setTimeout(function () {
            $("#Alert").remove();
            $(".modal-backdrop").remove();
            if (func != null)
                func();
        }, 1500)
    }

//Alert no need bootstrap
    function Alert2(txt) {
        var innerHtml = '';
        innerHtml += '<div class="modal alert" id="Alert2" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="myModalAlert">';
        innerHtml += '<div class="modal-dialog" style="width:220px;">';
        innerHtml += '<div class="modal-content pd20">';
        innerHtml += '<div class="modal-body text-center"><p class="mt10">' + txt + '</p></div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        $("body").append(innerHtml);
        $(".modal-backdrop").remove();
        setTimeout(function () {
            $("#Alert2").remove();
            $(".modal-backdrop").remove();
        }, 1000)
    }

//弹框-不能关闭
    function AlertNoX(title, cont) {
        var innerHtml = '';
        innerHtml += '<div class="modal ml-model" id="alertNoXModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="hide">';
        innerHtml += '<div class="modal-dialog" role="document">';
        innerHtml += '<div class="modal-content">';
        innerHtml += '<div class="modal-header">';
        innerHtml += '<h4 class="modal-title text-center">' + title + '</h4>';
        innerHtml += '</div>';
        innerHtml += '<div class="modal-body">' + cont + '</div>';
        innerHtml += '<div class="modal-footer text-center">';
        innerHtml += '<button type="button" class="btn btn-danger bg-red pdlr30" id="btnModalNoX">确定</button>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        innerHtml += '</div>';
        if ($("#alertNoXModal").length < 1) {
            $("body").append(innerHtml);
        } else {
            $("#alertNoXModal").find(".modal-title").html(title);
            $("#alertNoXModal").find(".modal-body").html(cont);
        }
        $('#alertNoXModal').modal('show');
        htmlHeight();
    }

//Ajax-get
    function getAjax(param) {
        var url = param.url;
        var success = param.success;
        var fail = param.fail;
        var error = param.error;
        var async = true;
        if(param.async != undefined){
            async = param.async;
        }
        $.ajax({
            url: url,
            type: "get",
            async: async,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var code = data.code;
                if (code == 200) {
                    success(data);
                } else if (code == 402 || code == 407) {
                    hideLoading();
                    console.log("参数存在异常");
                } else if (code == 409 || code == 410) {
                    hideLoading();
                    Alert("登录超时，请重新登录", function () {
                        jump(config.login);
                        delAllCookie();
                    });
                } else {
                    fail(data);
                }
            }, error: function (xhr) {
                hideLoading();
                if (error) {//error存在就调用这
                    error(xhr);
                } else {
                    Alert("网络不稳定，稍后再试！");
                }
            }
        });
    }

    /*getAjax({
        url:config.url + "user/person_center?token=" + token,
        data: {},
        success:function(){
        },
        fail:function(data){

        },error:function (xhr) {

        }
    });*/

//Ajax-post
    function postAjax(param) {
        var url = param.url;
        var para = param.data;
        var success = param.success;
        var fail = param.fail;
        var error = param.error;
        var async = true;
        if(param.async != undefined){
            async = param.async;
        }
        $.ajax({
            url: url,
            type: "post",
            async: async,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(para),
            success: function (data) {
                var code = data.code;
                if (code == 200) {
                    success(data);
                }else if(code == 403){
                    hideLoading();
                    console.log("参数为空");
                }else if (code == 402 || code == 407) {
                    hideLoading();
                    console.log("参数存在异常");
                }/*else if(code == 409 || code == 410){
                hideLoading();
                Alert("登录超时，请重新登录",function () {
                    jump(config.login);
                    delAllCookie();
                });
            }*/ else {
                    fail(data);
                }
            }, error: function (xhr) {
                hideLoading();
                if (error) {//error存在就调用这
                    error(xhr);
                } else {
                    Alert("网络不稳定，稍后再试！");
                }
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

    /**选了省后市区默认赋值第一个值，选了市后区默认第一个（这个方法要定义，空的也可以，否则会报错）
     * @page:用到省市区插件的地方
     */
    function setAddressSelect() {
        /*//provinceId = $("#sProvince").find("option:selected").attr("data-code");
        addressProv = $("#sProvince").val();
        //防止选了省不选市的情况
        //countyId = $("#sCity").find("option:selected").attr("data-code");
        addressCity = $("#sCity").val();
        addressCounty = $("#sCounty").val();*/
    }

    /**截取时间（如把2017-10-17 12:40:57截取只要2017-10-17）
     * @page:用到时间的地方
     */
    function cutOutTime(time) {
        var cTime = time.split(" ");
        return cTime[0];
    }

    /**设置高度
     * 有滚动条的页面因为设置了html的高度100%，所以撑不开
     * */
    function htmlHeight() {
        var result = document.body.scrollHeight > (window.innerHeight || document.documentElement.clientHeight);//判断是否有滚动条
        if (result == true) {
            $("html").css({"height": "auto"})
        } else {
            $("html").css({"height": "100%"});
            $(".modal-open .modal").css({"overflow-y": "hidden"});//阻止Alert弹框有滚动条
        }
    }

    /**列表页没有数据
     * */
    function noList() {
        var innerHtml = '';
        innerHtml += '<div class="pd5 text-center"><i class="ic ic-no-info"></i><p class="gray">没有数据显示</p></div>';
        return innerHtml;
    }

    /**登录(手机号)
     * @page:login
     * */
    var status = 0;//执行完
    function loginPhone() {
        var iptPhone = $("#iptPhone").val();
        var iptCode = $("#iptSmsCode").val();
        if ($.trim(iptPhone) == "") {
            Alert("请填写手机号！");
            return;
        }
        if ($.trim(iptCode) == "") {
            Alert("请填写验证码！");
            return;
        }
        status = 0;
        var path = window.location.href;
        postAjax({
            url: config.userUrl + "login/login",
            data: {type: 1, mobile: iptPhone, authCode: iptCode, loginUrl: path},
            success: function (data) {
                var token = data.data.token;
                setCookieNoTime("pemUtoken", token);
                loadSheetList();//缓存测试题目单
                loadsheetListInfo();//缓存测试题目信息
            }, fail: function (data) {
                htmlHeight();
                Alert(data.msg);
            }
        })
    }

    /**登录(账号)
     * @page:login
     * */
    function loginAccount() {
        var iptAccount = $("#iptAccount").val();
        if ($.trim(iptAccount) == "") {
            Alert("请填写账号！");
            return;
        }
        var iptPwd = $("#iptPwd").val();
        if ($.trim(iptPwd) == "") {
            Alert("请填写密码！");
            return;
        }
        status = 0;
        postAjax({
            url: config.url + "group/login",
            data: {accountName: iptAccount, password: iptPwd},
            success: function (data) {
                var token = data.data.token;
                var uType = data.data.type;
                setCookieNoTime("pemUtoken", token);
                setCookieNoTime("pemUtype", uType);
                AlertNoX("提示", "<p class='text-center mtb20'>登录成功，查看个人信息。</p>");
                $("#btnModalNoX").click(function () {
                    jump("indext.html");
                })
            }, fail: function (data) {
                htmlHeight();
                Alert(data.msg)
            }
        })
    }

    /**登录(就诊卡-判定是否绑定手机号)
     * @page:login
     * */
    function loginCard() {
        var iptCard = $("#iptCard").val();
        if ($.trim(iptCard) == "") {
            Alert("请填写就诊卡号！");
            return;
        }
        status = 0;
        var path = window.location.href;
        postAjax({
            url: config.url + "patient/card/binding",
            data: {cardNum: iptCard, loginUrl: path},
            success: function (data) {
                var token = data.data;
                setCookieNoTime("pemUtoken", token);
                loadSheetList();//缓存测试题目单
                loadsheetListInfo();//缓存测试题目信息
            }, fail: function (data) {
                if (data.code == 631) {
                    Alert(data.msg);
                    $("#cardBindPhone").show();
                    $("#btnSubmitCard").click(function () {
                        loginCardBind()
                    })
                } else {
                    Alert(data.msg);
                }
            }
        })
    }

    /**登录(就诊卡)
     * @page:login
     * */
    function loginCardBind() {
        var iptCard = $("#iptCard").val();
        if ($.trim(iptCard) == "") {
            Alert("请填写就诊卡号！");
            return;
        }
        var iptPhoneCard = $("#iptPhoneCard").val();
        if ($.trim(iptPhoneCard) == "") {
            Alert("请填写手机号！");
            return;
        }
        var iptSmsCodeCard = $("#iptSmsCodeCard").val();
        if ($.trim(iptSmsCodeCard) == "") {
            Alert("请填写验证码！");
            return;
        }
        status = 0;
        var path = window.location.href;
        postAjax({
            url: config.url + "patient/mobile/login",
            data: {cardNum: iptCard, loginUrl: path, mobile: iptPhoneCard, authCode: iptSmsCodeCard},
            success: function (data) {
                var token = data.data.token;
                setCookieNoTime("pemUtoken", token);
                loadSheetList();//缓存测试题目单
                loadsheetListInfo();//缓存测试题目信息
            }, fail: function (data) {
                Alert(data.msg);
            }
        })
    }

    /**测试题-套餐量表列表(从服务器获取存缓存)
     * @page:testing
     * */
    function loadSheetList() {
        localStorage.removeItem("packageSheets");
        localStorage.removeItem("sheetListInfo");
        var token = getCookie("pemUtoken");
        if (token == null || token == undefined) {
            jump(config.login);
        }
        getAjax({
            url: config.userUrl + "item/findPackageSheets?token=" + token,
            success: function (data) {
                status++;
                var result = data.data;
                if (typeof(Storage) != undefined) {
                    localStorage.setItem("packageSheets", JSON.stringify(result));
                    if (status == 2) {
                        AlertNoX("提示", "<p class='text-center mtb20'>登录成功，查看个人信息。</p>");
                        $("#btnModalNoX").click(function () {
                            jump("userInfo.html");
                        })
                    }
                } else {
                    Alert("抱歉！您的浏览器不支持 Web Storage ...");
                }
            }, fail: function (data) {
                Alert(data.msg);
            }
        })
    }

//医生端直接跳转过来时调用
    function loadSheetList2() {
        localStorage.removeItem("packageSheets");
        localStorage.removeItem("sheetListInfo");
        var token = getCookie("pemUtoken");
        if (token == null || token == undefined) {
            jump(config.login);
            return;
        }
        getAjax({
            url: config.userUrl + "item/findPackageSheets?token=" + token,
            success: function (data) {
                status++;
                var result = data.data;
                if (typeof(Storage) != undefined) {
                    localStorage.setItem("packageSheets", JSON.stringify(result));
                    packageFun();//量表列表
                } else {
                    Alert("抱歉！您的浏览器不支持 Web Storage ...");
                }
            }, fail: function (data) {
                Alert(data.msg);
            }
        })
    }

    /**获取医院名称跟LOGO
     * @page:login/testing
     * */
    function getDomain(path) {
        getAjax({
            url: config.userUrl + "login/userPath?path=" + path,
            success: function (data) {
                var result = data.data;
                $("#hospitalLogo").attr("src", config.imgUrl + result.logoUrl);
                $("#brief").html(result.intro)
            }, fail: function (data) {
                if (data.code == 622) {
                    Alert("该访问路径不存在！");
                } else {
                    Alert(data.msg);
                }
            }
        })
    }

    /**测试题-题目
     * @page:testingAnswer
     */
    function loadsheetListInfo() {
        localStorage.removeItem("packageSheets");
        localStorage.removeItem("sheetListInfo");
        var token = getCookie("pemUtoken");
        if (token == null || token == undefined) {
            jump(config.login);
        }
        showLoading("加载中...");
        getAjax({
            url: config.userUrl + "item/list?token=" + token,
            success: function (data) {
                hideLoading();
                status++;
                var result = data.data;
                if (typeof(Storage) !== "undefined") {
                    localStorage.setItem("sheetListInfo", JSON.stringify(result));
                    hideLoading();
                    if (status == 2) {
                        AlertNoX("提示", "<p class='text-center mtb20'>登录成功，查看个人信息。</p>");
                        $("#btnModalNoX").click(function () {
                            jump("userInfo.html");
                        })
                    }
                } else {
                    Alert("抱歉！您的浏览器不支持 Web Storage ...");
                }
            }, fail: function (data) {
                hideLoading();
                Alert(data.msg);
            }
        })
    }

//医生端直接跳转过来时调用
    function loadsheetListInfo2() {
        localStorage.removeItem("packageSheets");
        localStorage.removeItem("sheetListInfo");
        var token = getCookie("pemUtoken");
        if (token == null || token == undefined) {
            jump(config.login);
            return;
        }
        getAjax({
            url: config.userUrl + "item/list?token=" + token,
            success: function (data) {
                status++;
                var result = data.data;
                if (typeof(Storage) !== "undefined") {
                    sheetList = result;
                    localStorage.setItem("sheetListInfo", JSON.stringify(result));
                } else {
                    Alert("抱歉！您的浏览器不支持 Web Storage ...");
                }
            }, fail: function (data) {
                hideLoading();
                Alert(data.msg);
            }
        })
    }

    /** 校验手机号
     * phone：传过来的val值
     */
    function checkPhone(phone) {
        if (phone == "" || phone == null) {
            Alert("请输入手机号！");
            return false;
        }
        if (!(/^1(3|4|5|7|8)\d{9}$/.test(phone))) {
            alert("手机号码格式不正确！");
            return false;
        }
        return true;
    }

    /**登录-发验证码
     * @page:login
     * */
    function sendSmsCode(ths) {
        var phone = $(ths).siblings(".input").val();
        var btnCode = $(ths);
        var ck = checkPhone(phone);
        if (ck == true) {
            var sec = 60;
            postAjax({
                url: config.userUrl + "ahthCode/sendAuthCodeLogin/" + phone,
                success: function (data) {
                    if (data.code == 200) {
                        btnCode.attr('disabled', 'true');
                        btnCode.addClass("btn-code-gray");
                        var interval = setInterval(function () {
                            if (sec == 0) {
                                btnCode.text("重新获取").removeClass("btn-code-gray");
                                btnCode.removeAttr("disabled");
                                btnCode.attr("onclick", "sendSmsCode()");
                                clearInterval(interval);
                                return;
                            }
                            btnCode.text("重新发送" + sec + "秒");
                            sec--;
                        }, 1000);
                    }
                }, fail: function (data) {
                    Alert(data.msg);
                }
            });
        }
    }

    $(function () {
        //复选框
        $(".JScheckbox").click(function () {
            if ($(this).hasClass("icon-checkbox")) {
                $(this).addClass("icon-checkbox-checked").removeClass("icon-checkbox");
            } else {
                $(this).addClass("icon-checkbox").removeClass("icon-checkbox-checked");
            }
            $(this).parents().siblings().find(".JScheckbox").removeClass("icon-checkbox-checked").addClass("icon-checkbox");
        });
    })
