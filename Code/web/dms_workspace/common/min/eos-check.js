var Eos_All_Message=new Array();function isNull(b){if(typeof(b)=="object"){b=b.value}var a;if(b.length==0){return true}for(a=0;a<b.length;a++){if(b.charAt(a)!=" "){return false}}return true}function isIP(b){if(typeof(b)=="object"){b=b.value}var a=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;if(a.test(b)){if(RegExp.$1.length>3||RegExp.$2.length>3||RegExp.$3.length>3||RegExp.$4.length>3){return false}if(RegExp.$1>0&&RegExp.$1<256&&RegExp.$2<256&&RegExp.$3<256&&RegExp.$4<255){return true}}return false}function isInteger(a){if(typeof(a)=="object"){a=a.value}if(/^(\+|-)?\d+$/.test(a)){return true}else{return false}}function isPositiveInteger(a){if(typeof(a)=="object"){a=a.value}if(/^(\+)?\d+$/.test(a)){return true}else{return false}}function isURL(b){if(typeof(b)=="object"){b=b.value}if(b.indexOf("://")!=-1){var a=b.substr(0,b.indexOf("://"));if(a==""){return false}a=b.substr(b.indexOf("://")+3,a.length);if(a==""){return false}}else{return false}return true}function isDecimal(e,b,a){if(typeof(e)=="object"){e=e.value}if(/^(\+|-)?\d+($|\.\d+$)/.test(e)){var d=e.indexOf(".");if(b!=null){var c=e.length;if(d!=-1){c=c-1}if(b<c){return false}}if(a!=null){if(d==-1){return true}if(e.length-d-1>a){return false}}return true}else{return false}}function isPort(a){if(typeof(a)=="object"){a=a.value}if(/^\d+$/.test(a)){if(parseInt(a,10)>65535||parseInt(a,10)<=0){return false}return true}else{return false}}function isEmail(b){if(typeof(b)=="object"){b=b.value}var a=/^([-_A-Za-z0-9\.]+)@[A-Za-z0-9]{1}[_A-Za-z0-9\.]*\.[A-Za-z0-9]+$/;if(a.test(b)){return true}return false}function isLastMatch(c,b){if(typeof(c)=="object"){c=c.value}if(typeof(b)=="object"){b=b.value}var a=new RegExp(b+"$");if(a.test(c)){return true}else{return false}}function isFirstMatch(c,b){if(typeof(c)=="object"){c=c.value}if(typeof(b)=="object"){b=b.value}var a=new RegExp("^"+b);if(a.test(c)){return true}else{return false}}function isMatch(c,b){if(typeof(c)=="object"){c=c.value}if(typeof(b)=="object"){b=b.value}var a=new RegExp(b);if(a.test(c)){return true}else{return false}}function isChinaMobileNo(c){if(typeof(c)=="object"){c=c.value}var a=/(^[1][0-9]{10}$)|(^0[1][0-9]{10}$)/;var b=new RegExp(a);if(b.test(c)){return true}return false}function isPhoneNo(c){if(typeof(c)=="object"){c=c.value}var a=/(^([0][1-9]{2,3}[-])?\d{3,8}(-\d{1,6})?$)|(^\([0][1-9]{2,3}\)\d{3,8}(\(\d{1,6}\))?$)|(^\d{3,8}$)/;var b=new RegExp(a);if(b.test(c)){return true}return false}function isNumberOr_Letter(a){if(typeof(a)=="object"){a=a.value}if(/[^(\w*)]/.test(a)){return false}return true}function isNumberOrLetter(a){if(typeof(a)=="object"){a=a.value}if(/[^(a-z)*(A-Z)*(0-9)*]/.test(a)){return false}return true}function isFolder(c){if(typeof(c)=="object"){c=c.value}var a=/(^[^\.])/;var b=new RegExp(a);if(!b.test(c)){return false}a=/(^[^\\\/\?\*\"\<\>\:\|]*$)/;var b=new RegExp(a);if(b.test(c)){return true}return false}function isChinaOrNumbOrLett(c){if(typeof(c)=="object"){c=c.value}var a="^[0-9a-zA-Z\u4e00-\u9fa5]+$";var b=new RegExp(a);if(b.test(c)){return true}return false}function isChinaZipcode(a){if(typeof(a)=="object"){a=a.value}if(!isInteger(a)){return false}if(a.length!=6){return false}return true}function isChinaIDNo(h){if(typeof(h)=="object"){h=h.value}var e=EOS_CITY_LIST;var b=0;var a="";var j=h;var c=j.length;if(!/^\d{17}(\d|X|x)$/i.test(j)&&!/^\d{15}$/i.test(j)){return false}j=j.replace(/X|x$/i,"a");if(e[parseInt(j.substr(0,2))]==null){return false}if(c==18){sBirthday=j.substr(6,4)+"-"+Number(j.substr(10,2))+"-"+Number(j.substr(12,2));var g=new Date(sBirthday.replace(/-/g,"/"));if(sBirthday!=(g.getFullYear()+"-"+(g.getMonth()+1)+"-"+g.getDate())){return false}for(var f=17;f>=0;f--){b+=(Math.pow(2,f)%11)*parseInt(j.charAt(17-f),11)}if(b%11!=1){return false}}else{if(c==15){sBirthday="19"+j.substr(6,2)+"-"+Number(j.substr(8,2))+"-"+Number(j.substr(10,2));var g=new Date(sBirthday.replace(/-/g,"/"));var k=g.getFullYear().toString()+"-"+(g.getMonth()+1)+"-"+g.getDate();if(sBirthday!=k){return false}}}return true}function checkPeriod(b,a){if(typeof(b)=="object"){b=b.value}if(typeof(a)=="object"){a=a.value}if(!isDate(b)){return false}if(!isDate(a)){return false}if(a>=b){return true}else{return false}}function matchRegExp(d,c,a){if(typeof(d)=="object"){d=d.value}if(c==null||c==""){return false}var b;if(a==null||a==""){b=new RegExp(c)}else{if(/[^mig]/.test(a)){return false}b=new RegExp(c,a)}if(b.test(d)){return true}return false}function checkInput(obj){if(processExtAttr(obj)){return true}var is_Null=obj.getAttr("allowNull");if(is_Null=="false"){if(isNull(obj)){f_alert(obj,CHECK_MUST_INPUT);return false}else{}}else{if(isNull(obj)){f_alert_verify_successful(obj);return true}}var maxLength=obj.getAttr("maxLength");var minLength=obj.getAttr("minLength");if(maxLength!=null){if(obj.value.length>maxLength){f_alert(obj,CHECK_INPUT_LENGTH_CANNOT_MORE_THAN+maxLength);return false}}if(minLength!=null){if(obj.value.length<minLength){f_alert(obj,CHECK_INPUT_LENGTH_CANNOT_LESS_THAN+minLength);return false}}var type=obj.getAttr("type");if(type!=null){try{if(!eval("f_check_"+type+"(obj)")){return false}else{}}catch(o){alert(type+":"+CHECK_ERROROCCUR);return false}}var maxValue=obj.getAttr("maxValue");var minValue=obj.getAttr("minValue");if(!(maxValue==null&&minValue==null)){var inputValue;var oMinValue;var oMaxValue;if(isNaN(parseFloat(obj.value))){inputValue=obj.value}else{inputValue=parseFloat(obj.value)}if(maxValue!=null){if(isNaN(parseFloat(maxValue))||minValue==null||isNaN(parseFloat(minValue))||isNaN(parseFloat(obj.value))){oMaxValue=maxValue}else{oMaxValue=parseFloat(maxValue)}if(inputValue>oMaxValue){f_alert(obj,CHECK_NOT_MORE_THAN+maxValue);return false}}if(minValue!=null){if(isNaN(parseFloat(minValue))||maxValue==null||isNaN(parseFloat(maxValue))||isNaN(parseFloat(obj.value))){oMinValue=minValue}else{oMinValue=parseFloat(minValue)}if(inputValue<oMinValue){f_alert(obj,CHECK_NOT_LESS_THAN+minValue);return false}}}f_alert_verify_successful(obj);return true}function processExtAttr(h){if(h.EOS_extendedAttribute!=null){return false}var b=h.validateAttr||h.getAttribute("validateAttr");if(!b){return true}var f=new Object();var c=b.split(";");for(var e=0;e<c.length;e++){var a=c[e].split("=");if(a.length!=2){continue}var d=a[0];var g=a[1];f[d]=g}h.EOS_extendedAttribute=f;h.getAttr=function(i){return this.EOS_extendedAttribute[i]}}function f_check_number(a){if(/^\d+$/.test(a.value)){return true}else{f_alert(a,CHECK_INPUT_NUMBER);return false}}function f_check_naturalNumber(b){var a=b.value;if(a.length>1&&a.charAt(0)=="0"){f_alert(b,CHECK_INPUT_NATURALNUMBER);return false}if(/^[0-9]+$/.test(a)){return true}else{f_alert(b,CHECK_INPUT_NATURALNUMBER);return false}}function f_check_integer(a){if(isInteger(a)){return true}else{f_alert(a,CHECK_IUPUT_INT);return false}}function f_check_float(a){if(/^(\+|-)?\d+($|\.\d+$)/.test(a.value)){return true}else{f_alert(a,CHECK_INPUT_FLOAT);return false}}function f_check_zh(a){if(/^[\u4e00-\u9fa5]+$/.test(a.value)){return true}f_alert(a,CHECK_INPUT_ZH);return false}function f_check_letter(a){if(/^[A-Za-z]+$/.test(a.value)){return true}f_alert(a,CHECK_INPUT_LETTER);return false}function f_check_IP(a){if(isIP(a.value)){return true}f_alert(a,CHECK_INVALID_IP);return false}function f_check_port(a){if(isPort(a.value)){return true}f_alert(a,CHECK_INVALID_PORT);return false}function f_check_URL(a){if(isURL(a.value)){return true}f_alert(a,CHECK_INVALID_WEBSITE);return false}function f_check_email(a){if(isEmail(a.value)){return true}f_alert(a,CHECK_INVALID_EMAIL);return false}function f_check_folder(a){if(isFolder(a.value)){return true}f_alert(a,CHECK_INVALID_FOLDER);return false}function f_check_chinaMobile(a){if(isChinaMobileNo(a.value)){return true}f_alert(a,CHECK_INVALD_HANDPHONE);return false}function f_check_phone(a){if(isPhoneNo(a.value)){return true}f_alert(a,CHECK_INVALID_PHONE);return false}function f_check_chinaZipcode(a){if(!/^\d+$/.test(a.value)){f_alert(a,CHECK_POSTALCODE_MUST_NUMBER);return false}if(a.value.length!=6){f_alert(a,CHECK_INVAILID_POSTALCODE_LENGTH);return false}return true}function f_check_chinaIDNo(a){if(isChinaIDNo(a)){return true}else{f_alert(a,CHECK_INVALID_ID);return false}}function f_check_formatStr(b){var a=b.getAttr("regExpr");if(matchRegExp(b,a)){return true}f_alert(b,CHECK_INVALID_EXP);return false}function f_check_double(c){var b=c.getAttr("totalDigit");var a=c.getAttr("fracDigit");if(isDecimal(c,b,a)){return true}var d=CHECK_INPUT_NUMBER;if(b!=null){d=d+CHECK_LEGNT_NOT_THAN+b+CHECK_WEI}if(a!=null){d=d+CHECK_FRACTION_LENGTH_NOT_THAN+a+CHECK_WEI}f_alert(c,d);return false}function f_alert(c,d){try{checkTabPage(c)}catch(b){}var a;if(c.getAttr){a=c.getAttr("message")}if(a!=null){d=a}f_alert_verify_failure(c,d);f_alert_resetMessagePos()}function checkTabPage(f){var c=f.parentNode;while(c&&c.getAttribute){var a=c.eos_tabpage_id||c.getAttribute("eos_tabpage_id");if(a){var b=$id(a);if(b){try{b.getTabPane().selectTab(b)}catch(d){}}break}c=c.parentNode}}function checkForm(e){var d=true;var c=null;var a;for(a=e.elements.length-1;a>=0;a--){if((e.elements[a].validateAttr||e.elements[a].getAttribute("validateAttr"))+""=="undefined"){continue}if(e.elements[a].disabled==true){continue}if(e.elements[a].name==null||e.elements[a].name==""){if(!(e.elements[a].id!=null&&e.elements[a].id.indexOf("_input")!=-1)){continue}}if(checkInput(e.elements[a])==false){c=e.elements[a];d=false}}if(d){return d}var b=c.type;if(b=="text"||b=="TEXT"||b=="textarea"||b=="TEXTAREA"){c.select()}return d}function f_alert_getPosition(g){var a=g.id;if(a!=null){var c=a.indexOf("_input");if(c!=-1){g=$id(a.substr(0,c)+"_container")||g}}var f=parseInt(g.style.top?g.style.top:g.offsetTop);var e=parseInt(g.style.left?g.style.left:g.offsetLeft);var d=g;var b=true;while(d=d.offsetParent){if(d.tagName=="BODY"){continue}f+=parseInt(d.offsetTop)-parseInt(d.scrollTop);e+=parseInt(d.offsetLeft)-parseInt(d.scrollLeft);if(d.style.position.toLowerCase()=="absolute"){b=false}}e=parseInt(e)+parseInt(g.style.width?g.style.width:g.offsetWidth)+10+"px";f+="px";return{left:e,top:f}}function f_alert_create_Message_plane(b,a){var d=document.createElement("DIV");d.className="alert_message";var c=f_alert_getPosition(b);d.style.top=c.top;d.style.left=c.left;if(b.style.height==""){d.style.height=""}else{d.style.height=parseInt(b.style.height)-2}d.style.whiteSpace="nowrap";d.style.zindex=999;d.onclick=function(){this.hidden()};d.show=function(e){this.innerHTML="&nbsp;"+e+"&nbsp;";this.style.display="block";this.style.zindex=999;return;this.innerHTML="&nbsp;"+e+"&nbsp;";if(d.isLoading){if(d.timeout){clearTimeout(d.timeout)}d.timeout=setTimeout(function(){return _showMessage.apply(d,[d,e])},10)}else{if(!this.isShow){document.body.appendChild(this);this.isShow=true;this.isLoading=true;setOpacity(this,0);fx_fadeIn(this,function(){return loadingFinished.apply(d,[d])},500)}}};d.hidden=function(){this.style.display="none";return;if(d.isLoading){if(d.timeout){clearTimeout(d.timeout)}d.timeout=setTimeout(function(){return _hiddenMessage.apply(d,[d])},10)}else{this.isLoading=true;this.isShow=false;fx_fadeOut(this,function(){try{document.body.removeChild(d)}catch(f){}return loadingFinished.apply(d,[d])},400)}};d.setPos=function(e){this.style.top=e.top;this.style.left=e.left};document.body.appendChild(d);d.show(a);b.Eos_Message=d;Eos_All_Message[Eos_All_Message.length]=b}function loadingFinished(a){this.isLoading=false}function _hiddenMessage(a){if(a.isLoading){a.timeout=setTimeout(function(){return _hiddenMessage.apply(a,[a])},10)}else{a.hidden()}}function _showMessage(b,a){if(b.isLoading){b.timeout=setTimeout(function(){return _showMessage.apply(b,[b,a])},10)}else{b.show(a)}}function f_alert_show_message(b,a){if(b.Eos_Message!=null){f_alert_resetMessagePos();b.Eos_Message.show(a)}else{f_alert_create_Message_plane(b,a)}}function f_alert_hidden_message(a){if(a.Eos_Message){if(a.removeClass){a.removeClass("verify_failure");a.addClass("verify_successful")}a.Eos_Message.style.display="none"}return;if(a.Eos_Message!=null){a.Eos_Message.hidden()}}function f_alert_verify_failure(b,a){removeClass(b,"verify_successful");addClass(b,"verify_failure");f_alert_show_message(b,a)}function f_alert_verify_successful(a){removeClass(a,"verify_failure");addClass(a,"verify_successful");f_alert_hidden_message(a)}function f_alert_resetMessagePos(a){for(var b=0;b<Eos_All_Message.length;b++){var c=Eos_All_Message[b];var d=f_alert_getPosition(c);c.Eos_Message.setPos(d);if(a&&typeof(a)=="function"){a(c,d)}}return;for(var b=0;b<Eos_All_Message.length;b++){var d=f_alert_getPosition(Eos_All_Message[b]);Eos_All_Message[b].Eos_Message.setPos(d)}}function f_alert_hidden_all_message(){var b=document.forms[0];if(b){for(a=b.elements.length-1;a>=0;a--){if((b.elements[a].validateAttr||b.elements[a].getAttribute("validateAttr"))+""=="undefined"){continue}if(b.elements[a].disabled==true){continue}if(b.elements[a].name==null||b.elements[a].name==""){if(!(b.elements[a].id!=null&&b.elements[a].id.indexOf("_input")!=-1)){continue}}f_alert_hidden_message(b.elements[a])}}return;f_alert_resetMessagePos();for(var a=0;a<Eos_All_Message.length;a++){Eos_All_Message[a].Eos_Message.hidden()}}eventManager.add(window,"resize",f_alert_resetMessagePos);function regCheckEvent(c,d){if(c==null){return}d=d||"blur";var b;for(b=c.elements.length-1;b>=0;b--){if((c.elements[b].validateAttr||c.elements[b].getAttribute("validateAttr"))+""=="undefined"){continue}var a=c.elements[b];eventManager.add(a,d,function(e){e=eventManager.getEvent()||e;var f=e.srcElement||e.target;checkInput(f)})}}function checkOnblur(a){regCheckEvent(a)}function checkOnkeypress(a){regCheckEvent(a,"keyup");regCheckEvent(a,"focus")};