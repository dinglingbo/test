/**
 * 获取本周、本季度、本月、上月的开始日期、结束日期
 */
var now = new Date(); // 当前日期
var nowDayOfWeek = now.getDay(); // 今天本周的第几天
var nowDay = now.getDate(); // 当前日
var nowMonth = now.getMonth(); // 当前月
var nowYear = now.getYear(); // 当前年
nowYear += (nowYear < 2000) ? 1900 : 0; //
var lastMonthDate = new Date(); // 上月日期
lastMonthDate.setDate(1);
lastMonthDate.setMonth(lastMonthDate.getMonth() - 1);
var lastYear = lastMonthDate.getYear();
var lastMonth = lastMonthDate.getMonth();
function addDate(date, days) {
    if (days == undefined || days == '') {
        days = 1;
    }
    var date = new Date(date);
    date.setDate(date.getDate() + days);
    var month = date.getMonth() + 1;
    var day = date.getDate();
	return date.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
}
// 日期月份/天的显示，如果是1位数，则在前面加上'0'
function getFormatDate(arg) {
    if (arg == undefined || arg == '') {
        return '';
    }

    var re = arg + '';
    if (re.length < 2) {
        re = '0' + re;
    }

    return re;
}
function format(time, format) {
	var t = new Date(time);
	var tf = function (i) { return (i < 10 ? '0' : '') + i; };
	return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
	switch (a) {
	case 'yyyy':
	return tf(t.getFullYear());
	break;
	case 'MM':
	return tf(t.getMonth() + 1);
	break;
	case 'mm':
	return tf(t.getMinutes());
	break;
	case 'dd':
	return tf(t.getDate());
	break;
	case 'HH':
	return tf(t.getHours());
	break;
	case 'ss':
	return tf(t.getSeconds());
	break;
	}
	});
}

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
}

// 格式化日期：yyyy-MM-dd
function formatDate(date) {
	var myyear = date.getFullYear();
	var mymonth = date.getMonth() + 1;
	var myweekday = date.getDate();

	if (mymonth < 10) {
		mymonth = "0" + mymonth;
	}
	if (myweekday < 10) {
		myweekday = "0" + myweekday;
	}
	return (myyear + "-" + mymonth + "-" + myweekday);
}
//格式化日期：yyyyMMdd
function formatDateYMD(date) {
	var myyear = date.getFullYear();
	var mymonth = date.getMonth() + 1;
	var myweekday = date.getDate();

	if (mymonth < 10) {
		mymonth = "0" + mymonth;
	}
	if (myweekday < 10) {
		myweekday = "0" + myweekday;
	}
	return (myyear.toString() + mymonth.toString() + myweekday.toString());
}
// 获得某月的天数
function getMonthDays(myMonth) {
	var monthStartDate = new Date(nowYear, myMonth, 1);
	var monthEndDate = new Date(nowYear, myMonth + 1, 1);
	var days = (monthEndDate - monthStartDate) / (1000 * 60 * 60 * 24);
	return days;
}

// 获得本季度的开始月份
function getQuarterStartMonth() {
	var quarterStartMonth = 0;
	if (nowMonth < 3) {
		quarterStartMonth = 0;
	}
	if (2 < nowMonth && nowMonth < 6) {
		quarterStartMonth = 3;
	}
	if (5 < nowMonth && nowMonth < 9) {
		quarterStartMonth = 6;
	}
	if (nowMonth > 8) {
		quarterStartMonth = 9;
	}
	return quarterStartMonth;
}

//获得本日的开始日期
function getNowStartDate() {
	var NowStartDate = new Date(nowYear, nowMonth, nowDay);
	return formatDate(NowStartDate);
}

// 获得本日的结束日期
function getNowEndDate() {
	var NowEndDate = new Date(nowYear, nowMonth, nowDay);
	return formatDate(NowEndDate);
}

//获得昨日的开始日期
function getPrevStartDate() {
	var NowStartDate = new Date(nowYear, nowMonth, nowDay-1);
	return formatDate(NowStartDate);
}

// 获得昨日的结束日期
function getPrevEndDate() {
	var NowEndDate = new Date(nowYear, nowMonth, nowDay-1);
	return formatDate(NowEndDate);
}

// 获得本周的开始日期
function getWeekStartDate() {
	
    var currentDate =  new Date();
    //返回date是一周中的某一天 
    var week = currentDate.getDay();
    //返回date是一个月中的某一天 
    var month = currentDate.getDate();

    //一天的毫秒数 
    var millisecond = 1000 * 60 * 60 * 24;
    //减去的天数 
    var minusDay = week != 0 ? week - 1 : 6;
    //alert(minusDay); 
    //本周 周一 
    var monday = new Date(currentDate.getTime() - (minusDay * millisecond));
    return formatDate(monday);
	
	//var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1);
	//return formatDate(weekStartDate);
}

// 获得本周的结束日期
function getWeekEndDate() {
	
    var currentDate =  new Date();
    //返回date是一周中的某一天 
    var week = currentDate.getDay();
    //返回date是一个月中的某一天 
    var month = currentDate.getDate();

    //一天的毫秒数 
    var millisecond = 1000 * 60 * 60 * 24;
    //减去的天数 
    var minusDay = week != 0 ? week - 1 : 6;
    //本周 周日 
    var monday = new Date(currentDate.getTime() - (minusDay * millisecond));
    var sunday = new Date(monday.getTime() + (6 * millisecond));
    //添加本周时间 
    return formatDate(sunday);
	
//	var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek + 1));
//	return formatDate(weekEndDate);
}

//获得上周的开始日期
function getLastWeekStartDate() {
	
    var currentDate = new Date();
    //返回date是一周中的某一天 
    var week = currentDate.getDay();
    //返回date是一个月中的某一天 
    var month = currentDate.getDate();
    //一天的毫秒数 
    var millisecond = 1000 * 60 * 60 * 24;
    //减去的天数 
    var minusDay = week != 0 ? week - 1 : 6;
    //获得当前周的第一天 
    var currentWeekDayOne = new Date(currentDate.getTime() - (millisecond * minusDay));
    //上周最后一天即本周开始的前一天 
    var priorWeekLastDay = new Date(currentWeekDayOne.getTime() - millisecond);
    //上周的第一天 
    var priorWeekFirstDay = new Date(priorWeekLastDay.getTime() - (millisecond * 6));
	
    //var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek - 7 + 1);
    return formatDate(priorWeekFirstDay);
}
//获得上周的结束日期
function getLastWeekEndDate() {
    var currentDate = new Date();
    //返回date是一周中的某一天 
    var week = currentDate.getDay();
    //返回date是一个月中的某一天 
    var month = currentDate.getDate();
    //一天的毫秒数 
    var millisecond = 1000 * 60 * 60 * 24;
    //减去的天数 
    var minusDay = week != 0 ? week - 1 : 6;
    //获得当前周的第一天 
    var currentWeekDayOne = new Date(currentDate.getTime() - (millisecond * minusDay));
    //上周最后一天即本周开始的前一天 
    var priorWeekLastDay = new Date(currentWeekDayOne.getTime() - millisecond);
    //上周的第一天 
    var priorWeekFirstDay = new Date(priorWeekLastDay.getTime() - (millisecond * 6));	
    //var weekEndDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek - 1 + 1);
    return formatDate(priorWeekLastDay);
}

//获得下周的开始日期
function getNextWeekStartDate() {
    var weekStartDate = new Date(nowYear, nowMonth, nowDay + nowDayOfWeek + 6);
    return formatDate(weekStartDate);
}
//获得下周的结束日期
function getNextWeekEndDate() {
    var weekEndDate = new Date(nowYear, nowMonth, nowDay + nowDayOfWeek + 12);
    return formatDate(weekEndDate);
}

// 获得本月的开始日期
function getMonthStartDate() {
	var monthStartDate = new Date(nowYear, nowMonth, 1);
	return formatDate(monthStartDate);
}

// 获得本月的结束日期
function getMonthEndDate() {
	var monthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
	return formatDate(monthEndDate);
}
// 获得上月开始时间
function getLastMonthStartDate() {
	var tyear = nowYear;
	var tmonth = nowMonth;
    if (tmonth == 0) {
    	tmonth = 11; //月份为上年的最后月份 
    	tyear--; //年份减1 
       
    }else{
        //否则,只减去月份 
        tmonth--;
    }
	var lastMonthStartDate = new Date(tyear, tmonth, 1);
	return formatDate(lastMonthStartDate);
}
// 获得上月结束时间
function getLastMonthEndDate() {
	var tyear = nowYear;
	var tmonth = nowMonth;
    if (tmonth == 0) {
    	tmonth = 11; //月份为上年的最后月份 
    	tyear--; //年份减1 
       
    }else{
        //否则,只减去月份 
        tmonth--;
    }
	var lastMonthEndDate = new Date(tyear, tmonth, getMonthDays(lastMonth));
	return formatDate(lastMonthEndDate);
}

// 获得本季度的开始日期
function getQuarterStartDate() {

	var quarterStartDate = new Date(nowYear, getQuarterStartMonth(), 1);
	return formatDate(quarterStartDate);
}

// 或的本季度的结束日期
function getQuarterEndDate() {
	var quarterEndMonth = getQuarterStartMonth() + 2;
	var quarterStartDate = new Date(nowYear, quarterEndMonth,
			getMonthDays(quarterEndMonth));
	return formatDate(quarterStartDate);
}

//获得上年的开始日期
function getYearStartDate() {
	var NowStartDate = new Date(nowYear, 0, 1);
	return formatDate(NowStartDate);
}

function getYearEndDate() {
    //获得当前年份4位年
    //var currentYear=now.getFullYear();
    //本年最后
    //var currentYearLastDate=new Date(currentYear,11,31);
    //return formatDate(currentYearLastDate);
	var NowStartDate = new Date(nowYear+1, 0, 1);
	return formatDate(NowStartDate);
}

//获得上年的开始日期
function getPrevYearStartDate() {
	var NowStartDate = new Date(nowYear-1, 0, 1);
	return formatDate(NowStartDate);
}

function getPrevYearEndDate() {
	var NowStartDate = new Date(nowYear, 0, 1);
	return formatDate(NowStartDate);
}

//获得本年的结束日期
/*function getYearEndDate() {
	var NowStartDate = new Date(nowYear, 11, 31);
	return formatDate(NowStartDate);
}*/

//获取两个日期间的月份数
function getMonths(date1 , date2){
    //用-分成数组
    date1 = date1.split("-");
    date2 = date2.split("-");
    //获取年,月数
    var year1 = parseInt(date1[0]) , 
        month1 = parseInt(date1[1]) , 
        year2 = parseInt(date2[0]) , 
        month2 = parseInt(date2[1]) , 
        //通过年,月差计算月份差
        months = (year2 - year1) * 12 + (month2-month1) + 1;
    return months;    
}

//两个日期相减得到天数
function dateDiff(date1, date2) {
    var type1 = typeof date1, type2 = typeof date2;
    if (type1 == 'string')
        date1 = new Date(date1);//stringToTime(date1);
    else if (date1.getTime)
        date1 = date1.getTime();
    if (type2 == 'string')
        date2 = new Date(date2);//stringToTime(date2);
    else if (date2.getTime)
        date2 = date2.getTime();
    //alert((date1 - date2) / (1000*60*60)); 
    return (date2 - date1) / (1000 * 60 * 60 * 24); //结果是小时 
}


//判断是否闰年
//参数        intYear 代表年份的值
//return    true: 是闰年   false: 不是闰年
function IsLeapYear(intYear) {
  if (intYear % 100 == 0) {
      if (intYear % 400 == 0) { return true; }
  }
  else {
      if ((intYear % 4) == 0) { return true; }
  }
  return false;
};
//日期加年，加月，加天的方法
//加年日期功能 OK
function AddYearNumsDate(p_date, YearNums) {
  if (!YearNums && YearNums == '') {
      YearNums = 0;
  }
  YearNums = parseInt(YearNums);
  var monthNums = YearNums * 12;
  return AddMonthNumsDate(p_date, monthNums);
};
//加月 日期功能 OK
function AddMonthNumsDate(p_date, MonthNums) {
  if (!MonthNums && MonthNums == '') {
      MonthNums = 0;
  }
  MonthNums = parseInt(MonthNums);
  var t_date = new Date(p_date);
  //记录开始月日
  var M = t_date.getMonth() + 1;
  var D = t_date.getDate();
  //获取当前月最大天数
  var s_max_D =GetMaxDays(t_date.getFullYear(), t_date.getMonth(), 0); 
  var isMaxDay = false;
  if (D == s_max_D) isMaxDay = true;
  //
  t_date.setMonth(t_date.getMonth() + parseInt(MonthNums));       
  //
  //ShowAlert(isMaxDay + " " + s_max_D + " " + D);
  if (isMaxDay == true) {
      var e_max_D = GetMaxDays(t_date.getFullYear(), t_date.getMonth(), 0);        
      t_date.setDate(e_max_D);            
  }    
  if (0 != MonthNums) {
      t_date.setDate(t_date.getDate() - 1);  //减一天
  }
  //
  return t_date.Format('yyyy-MM-dd');
};
//获取年月的最大天数 OK
function GetMaxDays(year, month, day_0) {
  //2月
  if (IsLeapYear(year) == true) {
      if (1 == month) return 29;   //是闰年2月29天
  }
  else {
      if (1 == month) return 28;   //是平年2月28天
  }
  if (0 == month) return 31;   //1月
  if (2 == month) return 31;   //3月
  if (3 == month) return 30;   //4月
  if (4 == month) return 31;   //5月
  if (5 == month) return 30;   //6月
  if (6 == month) return 31;   //7月
  if (7 == month) return 31;   //8月
  //
  if (8 == month) return 30;   //9月
  if (9 == month) return 31;   //10月
  if (10 == month) return 30;   //11月
  if (11 == month) return 31;   //12月
}
//加天 日期功能 OK
function AddDayNumsDate(p_date, DayNums) {
  if (!DayNums && DayNums == '') {
      DayNums = 1;
  }
  DayNums = parseInt(DayNums);
  var t_date = new Date(p_date);
  //
  DayNums -= 1;
  t_date.setDate(t_date.getDate() + parseInt(DayNums));
  //
  return t_date.Format('yyyy-MM-dd');
};
//Date类原型扩展方法
Date.prototype.Format = function (fmt) { //author: meizz   
    var o = {
        "M+": this.getMonth() + 1,                 //月份   
        "d+": this.getDate(),                    //日   
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时           
        "H+": this.getHours(), //小时 
        "m+": this.getMinutes(),                 //分   
        "s+": this.getSeconds(),                 //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds()             //毫秒   
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

function showtime(el)   
{   
	var today;  
	var hour;  
	var second;  
	var minute;  
	var year;  
	var month;  
	var date;  
	var strDate;   
	today=new Date();   
	var n_day = today.getDay();   
	switch (n_day)   
	{   
		case 0:   
			strDate = "星期日"; 
			break;   
		case 1:   
			strDate = "星期一";   
			break;   
		case 2:   
			strDate = "星期二";   
			break;   
		case 3:   
			strDate = "星期三";   
			break;   
		case 4:   
			strDate = "星期四";   
			break;   
		case 5:  
			strDate = "星期五";   
			break;   
		case 6:   
			strDate = "星期六";   
			break;   
		case 7:   
			strDate = "星期日";   
			break;   
	}   
	year = today.getYear();   
	year += (year < 2000) ? 1900 : 0;
	month = today.getMonth()+1;   
	date = today.getDate();   
	hour = today.getHours();   
	minute =today.getMinutes();   
	second = today.getSeconds();   
	if(month<10) month="0"+month;   
	if(date<10) date="0"+date;   
	if(hour<10) hour="0"+hour;   
	if(minute<10) minute="0"+minute;   
	if(second<10) second="0"+second; 
	if(el){
		document.getElementById(el).innerHTML = year + "年" + month + "月" + date + "日 " + strDate +" " + hour + ":" + minute + ":" + second;
	}   
}

var getDiffYmdBetweenDate = function(sDate1,sDate2){
    var fixDate = function(sDate){
        var aD = sDate.split('-');
        for(var i = 0; i < aD.length; i++){
            aD[i] = fixZero(parseInt(aD[i]));
        }
        return aD.join('-');
    };
    var fixZero = function(n){
        return n < 10 ? '0'+n : n;
    };
    var fixInt = function(a){
        for(var i = 0; i < a.length; i++){
            a[i] = parseInt(a[i]);
        }
        return a;
    };
    var getMonthDays = function(y,m){
        var aMonthDays = [0,31,28,31,30,31,30,31,31,30,31,30,31];
        if((y%400 == 0) || (y%4==0 && y%100!=0)){
            aMonthDays[2] = 29;
        }
        return aMonthDays[m];
    };
    var checkDate = function(sDate){
    };
    var y = 0;
    var m = 0;
    var d = 0;
    var sTmp;
    var aTmp;
    sDate1 = fixDate(sDate1);
    sDate2 = fixDate(sDate2);
    if(sDate1 > sDate2){
        sTmp = sDate2;
        sDate2 = sDate1;
        sDate1 = sTmp;
    }
    var aDate1 = sDate1.split('-');
        aDate1 = fixInt(aDate1);
    var aDate2 = sDate2.split('-');
        aDate2 = fixInt(aDate2);
    //计算相差的年份
    /*aTmp = [aDate1[0]+1,fixZero(aDate1[1]),fixZero(aDate1[2])];
    while(aTmp.join('-') <= sDate2){
        y++;
        aTmp[0]++;
    }*/
    y = aDate2[0] - aDate1[0];
    if( sDate2.replace(aDate2[0],'') < sDate1.replace(aDate1[0],'')){
        y = y - 1;
    }
    //计算月份
    aTmp = [aDate1[0]+y,aDate1[1],fixZero(aDate1[2])];
    while(true){
        if(aTmp[1] == 12){
            aTmp[0]++;
            aTmp[1] = 1;
        }else{
            aTmp[1]++;
        }
        if(([aTmp[0],fixZero(aTmp[1]),aTmp[2]]).join('-') <= sDate2){
            m++;
        } else {
            break;
        }
    }
    //计算天数
    aTmp = [aDate1[0]+y,aDate1[1]+m,aDate1[2]];
    if(aTmp[1] > 12){
        aTmp[0]++;
        aTmp[1] -= 12;
    }
    while(true){
        if(aTmp[2] == getMonthDays(aTmp[0],aTmp[1])){
            aTmp[1]++;
            aTmp[2] = 1;
        } else {
            aTmp[2]++;
        }
        sTmp = ([aTmp[0],fixZero(aTmp[1]),fixZero(aTmp[2])]).join('-');
        if(sTmp <= sDate2){
            d++;
        } else {
            break;
        }
    }
    return {y:y,m:m,d:d};
};
