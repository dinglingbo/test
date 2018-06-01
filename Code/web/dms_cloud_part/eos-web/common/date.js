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
	var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1);
	return formatDate(weekStartDate);
}

// 获得本周的结束日期
function getWeekEndDate() {
	var weekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek + 1));
	return formatDate(weekEndDate);
}

//获得上周的开始日期
function getLastWeekStartDate() {
    var weekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek - 7 + 1);
    return formatDate(weekStartDate);
}
//获得上周的结束日期
function getLastWeekEndDate() {
    var weekEndDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek - 1 + 1);
    return formatDate(weekEndDate);
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
	var lastMonthStartDate = new Date(nowYear, lastMonth, 1);
	return formatDate(lastMonthStartDate);
}
// 获得上月结束时间
function getLastMonthEndDate() {
	var lastMonthEndDate = new Date(nowYear, lastMonth, getMonthDays(lastMonth));
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

/**
 * 得到上季度的起始日期
 * year 这个年应该是运算后得到的当前本季度的年份
 * month 这个应该是运算后得到的当前季度的开始月份
 * */
function getPriorSeasonFirstDay(year, month) {
     var quarterMonthStart = 0;
     var spring = 0; //春  
     var summer = 3; //夏  
     var fall = 6;   //秋  
     var winter = 9; //冬  
     //月份从0-11  
     switch (month) {//季度的其实月份  
         case spring:
             //如果是第一季度则应该到去年的冬季  
             year--;
             month = winter;
             break;
         case summer:
             month = spring;
             break;
         case fall:
             month = summer;
             break;
         case winter:
             month = fall;
             break;


     };


     return new Date(year, month, 1);
 };


 /**
 * 得到上季度的起止日期
 * **/
function getPreviousSeason() {
     //起止日期数组  
     var startStop = new Array();
     //获得当前月份0-11  
     var currentMonth = now.getMonth();
     //获得当前年份4位年  
     var currentYear = now.getFullYear();
     //上季度的第一天  
     var priorSeasonFirstDay = this.getPriorSeasonFirstDay(currentYear, currentMonth);
     //上季度的最后一天  
     var priorSeasonLastDay = new Date(priorSeasonFirstDay.getFullYear(), priorSeasonFirstDay.getMonth() + 2, this.getMonthDays(priorSeasonFirstDay.getFullYear(), priorSeasonFirstDay.getMonth() + 2));
     //添加至数组  
     startStop.push(priorSeasonFirstDay);
     startStop.push(priorSeasonLastDay);
     return startStop;
 };
//上季开始日期
function getLastQuarterStart(){    
	var d = getPriorSeasonFirstDay(nowYear, getQuarterStartMonth());
       
    return formatDate(d);   
}
//上季开始日期
function getLastQuarterEnd(){    
	var dayMSec = 24 * 3600 * 1000;  
    //得到上一个季度的第一天    
    var lastQuarterFirstDay = new Date(now.getFullYear() , now.getMonth() - 3 , 1);    
    //得到本月第一天    
    var nowMonthFirstDay = new Date(now.getFullYear() , now.getMonth(), 1);    
    //得到上一个季度的最后一天的毫秒值    
    var lastQuarterLastDayMSec = nowMonthFirstDay.getTime() - 1 * dayMSec;    
    var lastQuarterLastDay = new Date(lastQuarterLastDayMSec);    
         
    return formatDate(lastQuarterLastDay);   
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
                date1 = stringToTime(date1);
            else if (date1.getTime)
                date1 = date1.getTime();
            if (type2 == 'string')
                date2 = stringToTime(date2);
            else if (date2.getTime)
                date2 = date2.getTime();
            //alert((date1 - date2) / (1000*60*60)); 
            return (date2 - date1) / (1000 * 60 * 60 * 24); //结果是小时 
        }
