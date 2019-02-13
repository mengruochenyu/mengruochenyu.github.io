var Regexs = {  
    email: /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,//邮箱  
    phone: /^0\d{2,3}-?\d{7,8}$/,//座机手机号码  
    mobilePhone: /^1(3|4|5|7|8)\d{9}$/,//所有手机号码  
    num: /[^0-9]/,//数字  
    qq: /^[1-9][0-9]{4,9}$/,  //QQ号码
    positiveNum: /^[0-9]\d*(\.\d+)?$/,  //正数
    positiveInteger: /^[0-9]*[1-9][0-9]*$/, //正整数
}; 


/**
 * 校验手机号格式是否正确
 * @param mobilePhone 手机号码
 * @returns {Boolean}
 */
function validateMobilePhone(mobilePhone) {
	var reg = Regexs.mobilePhone;
	if((reg.test(mobilePhone))){
	    return true;
	}
	return false;
}

/**
 * 校验邮箱格式是否正确
 * @param email 邮箱
 * @returns {Boolean}
 */
function validateEmail(email) {  
    var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;  
    if (reg.test(email)) {  
        return true;   
    } 
    return false;  
}  

/**
 * 校验电话格式是否正确
 * @param email 邮箱
 * @returns {Boolean}
 */
function validatePhone(phone){
   var reg = /^0\d{2,3}-?\d{7,8}$/;
   if(reg.test(phone)){
       return true;
   }
   return false;
}


/**
 * 校验字符串是否为合法QQ号码
 * @param {String} 字符串
 * @return {bool} 是否为合法QQ号码
 */
function validateQQ(qq) {
     var reg = /^[1-9][0-9]{4,9}$/;
     if (reg.test(qq)) {
         return true;
     }
     return false;
 }

/**
 * 校验字符长度
 * @param field
 * @param length
 */
function validateFieldLength(field, length) {
	$("#" + field ).keydown(function(){
		var fieldValue = $("#" + field).val();
		if(fieldValue.length >= length) {
			$("#" + field).val(fieldValue.substr(0,10));
		}
	    $("#" + field).css("background-color","#FFFFCC");
	});
}

/**
 * 校验数字是否为 大于0 的数
 * @param num
 */
function validatePositiveNum(num) {
	var reg = Regexs.positiveNum;
	if (reg.test(num)) {
        return true;
    }
    return false;
} 

/**
 * 校验参数是否为正整数
 * @param integer 整数
 * @returns {Boolean}
 */
function validatePositiveInt(integer) {
	var reg = Regexs.positiveInteger;
	if (reg.test(integer)) {
        return true;
    }
    return false;
}

