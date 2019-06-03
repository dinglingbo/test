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
	/*var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1);
	return formatDate(weekStartDate);*/
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
	/*var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek + 1));
	return formatDate(weekEndDate);*/
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
    var weekStartDate = new Date(nowYear, nowMonth, nowDay + nowDayOfWeek + 7);
    return formatDate(weekStartDate);
}
//获得下周的结束日期
function getNextWeekEndDate() {
    var weekEndDate = new Date(nowYear, nowMonth, nowDay + nowDayOfWeek + 1);
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
function getYearEndDate() {
	var NowStartDate = new Date(nowYear, 11, 31);
	return formatDate(NowStartDate);
}

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
