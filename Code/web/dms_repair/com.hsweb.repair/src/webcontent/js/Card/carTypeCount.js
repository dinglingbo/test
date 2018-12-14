var baseUrl = apiPath + repairApi + "/";
var cardType = {};
var timesCardType = {};
var cardTypeOpen =[];
var timesCardTypeOpen =[];
var cardAmt = [];
var timesCardAmt = [];
var cardNum = [];
var timesCardNum = [];
var color = "thisYear";//日，周，季，年按钮变色
$(document).ready(function(v) {
	setData();

});


var querycardTypeUrl = baseUrl
+ "com.hsapi.repair.baseData.crud.queryCard.biz.ext";
var querytimesCardTypeUrl = baseUrl
+ "com.hsapi.repair.baseData.crud.queryTimesCard.biz.ext";
function setData(){
	nui.ajax({
		url : querycardTypeUrl,
		data : {
			pageSize:500,
			page:{
				length:500
			},
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.card) {
				cardType=data.card;

			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
	nui.ajax({
		url : querytimesCardTypeUrl,
		data : {
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.timesCard) {
				timesCardType=data.timesCard;
				queryC(getYearStartDate(),getYearEndDate());
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}

function settleOK(e){
	for(var i =0;i<cardType.length;i++){
		cardType[i].amt=0;
		cardType[i].num=0;

	}
	for(var i =0;i<timesCardType.length;i++){
		timesCardType[i].amt=0;
		timesCardType[i].num=0;

	}

	if(e==1){
		queryC(getNowStartDate(),getNowStartDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "today";
		document.getElementById("today").setAttribute("class", "n");
		
	}else if(e==2){
		queryC(getWeekStartDate(),getWeekEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisWeek";
		document.getElementById("thisWeek").setAttribute("class", "n");
		
	}else if(e==3){
		queryC(getMonthStartDate(),getMonthEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisMonth";
		document.getElementById("thisMonth").setAttribute("class", "n");
		
	}else if(e==4){
		queryC(getQuarterStartDate(),getQuarterEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisQuarter";
		document.getElementById("thisQuarter").setAttribute("class", "n");
		
	}else if(e==5){
		queryC(getYearStartDate(),getYearEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisYear";
		document.getElementById("thisYear").setAttribute("class", "n");
		
	}
}

var queryCUrl = baseUrl
+ "com.hsapi.repair.baseData.crud.queryC.biz.ext";

function queryC(startDate,endDate){
	nui.ajax({
		url : queryCUrl,
		data : {
			params:{
					startDate:startDate,
					endDate: addDate(endDate, 1)
				},
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.cardList && data.timesCardList) {
				if(data.cardList.length==0){
					for(var i = 0;i<cardType.length;i++){
						cardType[i].amt =0;
						cardType[i].num=0;
					}
				}else{
					for(var i = 0;i<cardType.length;i++){
						for(var j = 0;j<data.cardList.length;j++){
							if(cardType[i].id==data.cardList[j].id){
								cardType[i].amt=data.cardList[j].amt;
								cardType[i].num=data.cardList[j].num;
							}
						}

					}
				}
			if(data.timesCardList.length==0){
				for(var i = 0;i<timesCardType.length;i++){
					timesCardType[i].amt =0;
					timesCardType[i].num = 0;
				}
			}else{
				for(var i = 0;i<timesCardType.length;i++){
					for(var j = 0;j<data.timesCardList.length;j++){
						if(timesCardType[i].id==data.timesCardList[j].id){
							timesCardType[i].amt=data.timesCardList[j].amt;
							timesCardType[i].num=data.timesCardList[j].num;
						}
					}

				}
			}
				
			}
			open(cardType);
			open2(timesCardType);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});

}
function open(cardType){
	for(var i =0;i<cardType.length;i++){
		cardTypeOpen[i]=cardType[i].name;
		cardAmt[i]=cardType[i].amt;
		cardNum[i]=cardType[i].num;

	}

	option = {
			title : {
			    text: '储值卡统计表',
			    //subtext: '纯属虚构'
			},
			tooltip : {
			    trigger: 'axis'
			},
			legend: {
			    data:['数量','金额']
			},
			toolbox: {
			    show : true,
			    feature : {
			        mark : {show: true},
			        dataView : {show: true, readOnly: false},
			        magicType : {show: true, type: ['line', 'bar']},
			        restore : {show: true},
			        saveAsImage : {show: true}
			    }
			},
			calculable : true,

			xAxis : [
			    {
			        type : 'category',
			        data : cardTypeOpen,
			        barGap: '10px',            // 柱间距离，默认为柱形宽度的30%，可设固定值
			        barWidth: '30%',
			        barCategoryGap : '50px',   // 类目间柱形距离，默认为类目间距的20%，可设固定值
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'数量',
			        type:'bar',
			        data:cardNum,
			        markPoint : {
			            data : [
			                {type : 'max', name: '最大值'},
			                {type : 'min', name: '最小值'}
			            ]
			        },
			        markLine : {
			            data : [
			                {type : 'average', name: '平均值'}
			            ]
			        }
			    },
			    {
			        name:'金额',
			        type:'bar',
			        data:cardAmt,
	
			        markLine : {
			            data : [
			                {type : 'average', name : '平均值'}
			            ]
			        }
			    }
			]
			};
			var orgChart1 = echarts.init(document.getElementById('card'));
			            orgChart1.setOption(option);
}

function open2(timesCardType){
	for(var i =0;i<timesCardType.length;i++){
		timesCardTypeOpen[i]=timesCardType[i].name;
		timesCardAmt[i]=timesCardType[i].amt;
		timesCardNum[i]=timesCardType[i].num;


	}

	
	option = {
			title : {
			    text: '计次卡统计表',
			    //subtext: '纯属虚构'
			},
			tooltip : {
			    trigger: 'axis'
			},
			legend: {
			    data:['数量','金额']
			},
			toolbox: {
			    show : true,
			    feature : {
			        mark : {show: true},
			        dataView : {show: true, readOnly: false},
			        magicType : {show: true, type: ['line', 'bar']},
			        restore : {show: true},
			        saveAsImage : {show: true}
			    }
			},
			calculable : true,

			xAxis : [
			    {
			        type : 'category',
			        data : timesCardTypeOpen
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'数量',
			        type:'bar',
			        data:timesCardNum,
			        barWidth: '30%',
			        markPoint : {
			            data : [
			                {type : 'max', name: '最大值'},
			                {type : 'min', name: '最小值'}
			            ]
			        },
			        markLine : {
			            data : [
			                {type : 'average', name: '平均值'}
			            ]
			        }
			    },
			    {
			        name:'金额',
			        type:'bar',
			        data:timesCardAmt,
			        markPoint : {
			            data : [
			                {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183, symbolSize:18},
			                {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
			            ]
			        },
			        markLine : {
			            data : [
			                {type : 'average', name : '平均值'}
			            ]
			        }
			    }
			]
			};
			var orgChart1 = echarts.init(document.getElementById('timesCard'));
			            orgChart1.setOption(option);
}





