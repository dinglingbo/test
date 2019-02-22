var baseUrl = apiPath + frmApi + "/";
var settleType = {};
var settleTypeOpen =[]
var cSettleTypeAmt = [];
var rSettleTypeAmt = [];
var orgidsEl = null;
var color = "thisYear";//日，周，季，年按钮变色
$(document).ready(function(v) {
	
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
	setData();

});


var querySettleTypeUrl = baseUrl
+ "com.hsapi.frm.setting.querySettleType.biz.ext";
function setData(){
	nui.ajax({
		url : querySettleTypeUrl,
		data : {
			dictId: 'DDT20130703000031',
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.list) {
				settleType=data.list;
				for(var i =0;i<settleType.length;i++){
					settleType[i].cAmt=0;
					settleType[i].rAmt=0;

				}
				queryAmt(getYearStartDate(),getYearEndDate());
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}

function settleOK(e){
	if(e==1){
		queryAmt(getNowStartDate(),getNowStartDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "today";
		document.getElementById("today").setAttribute("class", "n");
		
	}else if(e==2){
		queryAmt(getWeekStartDate(),getWeekEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisWeek";
		document.getElementById("thisWeek").setAttribute("class", "n");
		
	}else if(e==3){
		queryAmt(getMonthStartDate(),getMonthStartDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisMonth";
		document.getElementById("thisMonth").setAttribute("class", "n");
		
	}else if(e==4){
		queryAmt(getQuarterStartDate(),getQuarterEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisQuarter";
		document.getElementById("thisQuarter").setAttribute("class", "n");
		
	}else if(e==5){
		queryAmt(getYearStartDate(),getYearEndDate());
		document.getElementById(color).setAttribute("class", "m");
		color = "thisYear";
		document.getElementById("thisYear").setAttribute("class", "n");
		
	}
}

var querySettleTypeAmtUrl = baseUrl
+ "com.hsapi.frm.setting.querySettlementAmt.biz.ext";

function queryAmt(startDate,endData){
	var params = {};
	params.startDate = startDate;
	params.endData = endData;
	var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
	nui.ajax({
		url : querySettleTypeAmtUrl,
		data : {
			p:params,
			token: token
		},
		type : "post",
		success : function(data) {
			if (data && data.rlist) {
				if(data.rlist.length==0){
					for(var i = 0;i<settleType.length;i++){
						settleType[i].rAmt =0;
					}
				}else{
					for(var i = 0;i<settleType.length;i++){
						for(var j = 0;j<data.rlist.length;j++){
							if(settleType[i].customid==data.rlist[j].code){
								settleType[i].rAmt=data.rlist[j].rAmt;
							}
						}

					}
				}
			if(data.clist.length==0){
				for(var i = 0;i<settleType.length;i++){
					settleType[i].cAmt =0;
				}
			}else{
				for(var i = 0;i<settleType.length;i++){
					for(var j = 0;j<data.clist.length;j++){
						if(settleType[i].customid==data.clist[j].code){
							settleType[i].cAmt=data.clist[j].cAmt;
						}
					}

				}
			}
				
			}
			open(settleType);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});

}
function open(settleType){
	for(var i =0;i<settleType.length;i++){
		settleTypeOpen[i]=settleType[i].name;
		cSettleTypeAmt[i]=settleType[i].cAmt;
		rSettleTypeAmt[i]=settleType[i].rAmt;
	}

	
	option = {
			title : {
			    text: '经营收支统计汇总表',
			    //subtext: '纯属虚构'
			},
			tooltip : {
			    trigger: 'axis'
			},
			legend: {
			    data:['经营收入','经营支出']
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
			        data : settleTypeOpen
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'经营收入',
			        type:'bar',
			        data:rSettleTypeAmt,
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
			        name:'经营支出',
			        type:'bar',
			        data:cSettleTypeAmt,
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
			var orgChart1 = echarts.init(document.getElementById('chartContainer'));
			            orgChart1.setOption(option);
}