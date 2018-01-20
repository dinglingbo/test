/**
*校验字符串是否只由英文字母和数字 - _ . 组成
*验证通过返回true,否则返回false
**/
function isNumLettMidDownDot(str)
{
    if(typeof(str)=="object") str=str.value;
	if(/^[0-9A-Za-z\-_\.]+$/.test(str))
	{
		return true;
	}
	return false;
}

/**
*校验字符串是否只由英文字母和数字_组成
*验证通过返回true,否则返回false
**/
function isNumLettDown(str)
{
    if(typeof(str)=="object") str=str.value;
	if(/^[0-9A-Za-z_]+$/.test(str))
	{
		return true;
	}
	return false;
}
/**
*校验字符串是否只由英文字母和数字和下划线和中杠组成
*验证通过返回true,否则返回false
**/
function isNumLettMidDown(str)
{
    if(typeof(str)=="object") str=str.value;
	if(/[^(\w*)*-]|[(?!\*).]/.test(str))
	{
		return false;
	}
	return true;
}
/**
*校验字符串是否以字母开头
*验证通过返回true,否则返回false
**/
function isLetterAhead(str)
{
  if(typeof(str)=="object") str=str.value;
	if(/^[a-zA-Z]/.test(str))
	{
		return true;
	}
	return false;
}
/**
*校验字符串是否以字母_开头
*验证通过返回true,否则返回false
**/
function isLetterDownAhead(str)
{
  if(typeof(str)=="object") str=str.value;
	if(/^[a-zA-Z_]/.test(str))
	{
		return true;
	}
	return false;
}

/**
*校验字符串是否是合法的java类名称（包括包名）
*验证通过返回true,否则返回false
**/
function isJavaClass(str)
{
    if(typeof(str)=="object") str=str.value;
    var regu = /^[_A-Za-z]+[_A-Za-z0-9]*$/;
    var re = new RegExp(regu);
    var tmpArray = str.split(".");
    for(var i=0;i<tmpArray.length;i++){
    	
    	if(!re.test(tmpArray[i]))
    		return false;
    }
    return true;
    
}

/**
*校验字符串是否是合法的java方法名称
*验证通过返回true,否则返回false
**/
function isJavaMethod(str)
{
    if(typeof(str)=="object") str=str.value;
    
    var regu = /^[_A-Za-z]+[_A-Za-z0-9]*$/;
	var re = new RegExp(regu);
	if (re.test( str )) {
		return true;
	}
	return false;
}

/**
*校验字符串是否是合法的日志名称
*验证通过返回true,否则返回false
**/
function isLogName(str)
{
    if(typeof(str)=="object") str=str.value;
    
    var regu = /^[A-Za-z]+[_A-Za-z0-9\-]*$/;
	var re = new RegExp(regu);
	if (re.test( str )) {
		return true;
	}
	return false;
}


/**
*校验字符串是否以字母开头 可以包含字母-_.
*验证通过返回true,否则返回false
**/
function f_check_LetterAhead_NumLettMidDownDot(obj){
	if (isNumLettMidDownDot(obj.value)&&isLetterAhead(obj.value))
		return true;
	f_alert(obj,start_with_char_contain_char_num_underline_dot);//只能以字母开头，可以包含字母数字-_.
	return false;
}

/**
 * 校验字符串是否以字母、下划线开头 可以包含数字、字母、下划线
 * 验证通过返回true,否则返回false
 *
 */
function f_check_LetterDownAhead_NumLettDown(obj){
	if (isLetterDownAhead(obj.value) && isNumLettDown(obj.value))
		return true;
	f_alert(obj,start_with_char_underline_contain_char_num_underline);//只能以字母_开头，可以包含字母数字_
	return false;
}

/**
*校验字符串是否包含字母-_.
*验证通过返回true,否则返回false
**/
function f_check_NumLettMidDownDot(obj){
	if (isNumLettMidDownDot(obj.value))
		return true;
	f_alert(obj,only_contain_char_num_underline_dot);//只能包含字母数字-_.
	return false;
}

/**
*校验字符串是否以字母开头 可以包含字母-_
*验证通过返回true,否则返回false
**/
function f_check_LetterAhead_NumLettMidDown(obj){
	if (isNumLettMidDown(obj.value)&&isLetterAhead(obj.value))
		return true;
	f_alert(obj,start_with_char_contain_char_num_underline);//只能以字母开头，可以包含字母数字-_
	return false;
}

/**
*校验路径
*验证通过返回true,否则返回false
**/
function f_check_path(obj) {

	if(!/^[^\|\?\*<>"]+$/.test(obj.value)){
		f_alert(obj,path_condition);//路径中不能包含*?|\"<>
		return false;
	}
	return true;
}

/**
*用途：校验域名的格式 
*返回：通过验证返回true,否则返回false；
**/
function isDomain(str)
{
  if(typeof(str)=="object") str=str.value;
	if((/[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/.test(str))&&isNumLettMidDownDot(str))
	{
		return true;
	}
	return false;
}
/**
*用途：校验域名的格式 
**/
function f_check_domain(obj){
	if (isDomain(obj.value))
		return true;
	f_alert(obj,only_input_domain_name);//该项只能输入域名
	return false;
}
/**
*用途：校验域名的格式或者IP格式 
**/
function f_check_domainOrIP(obj){
	if (isDomain(obj.value)||isIP(obj.value))
		return true;
	f_alert(obj,only_input_domain_ip_adress);//该项只能输入域名或者IP地址
	return false;
}

/**
用途：检查输入对象的值是否符合java类名称（包括包名）
输入：str 输入的字符串
返回：如果通过验证返回true,否则返回false
*/
function f_check_javaClass(obj){
	if(isJavaClass( obj.value )) return true;
	f_alert(obj,must_be_valid_java_class_name);//必须是合法的java类名称
	return false;
}

/**
用途：检查输入对象的值是否符合java方法名称
输入：str 输入的字符串
返回：如果通过验证返回true,否则返回false
*/
function f_check_javaMethod(obj){
	if(isJavaMethod( obj.value )) return true;
	f_alert(obj,must_be_valid_java_method_name);//必须是合法的java方法名称
	return false;
}

/**
用途：检查输入对象的值是否是合法日志名称
输入：str 输入的字符串
返回：如果通过验证返回true,否则返回false
*/
function f_check_logName(obj){
	if(isLogName( obj.value )) return true;
	f_alert(obj,start_with_char_contain_char_num);//只能以字母开头，可以包含字母数字
	return false;
}


/**
重写了函数增加对00001这样的校验
*/
function f_check_integer(obj)
{
	if ((isInteger(obj))&&(obj.value=="0"||obj.value.indexOf("0")!=0))
	{
	   return true;
	}
	else
	{
		f_alert(obj,CHECK_IUPUT_INT);
	    return false;
	}
}
/**
重写了函数增加对00001这样的校验
*/
function f_check_naturalNumber(obj)
{
	var s = obj.value;
	if ((/^[0-9]+$/.test( s ))&&(String(Number(obj.value))==obj.value))
	{
	   return true;
	}
	else
	{
		f_alert(obj,CHECK_INPUT_NATURALNUMBER);
	    return false;
	}
}

