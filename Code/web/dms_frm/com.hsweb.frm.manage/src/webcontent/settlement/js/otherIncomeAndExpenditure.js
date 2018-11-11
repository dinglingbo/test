var baseUrl = apiPath + frmApi + "/";
var settleType = {};
var settleTypeOpen =[]
var cSettleTypeAmt = [];
var rSettleTypeAmt = [];
var color = "thisYear";//日，周，季，年按钮变色
$(document).ready(function(v) {
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
	nui.ajax({
		url : querySettleTypeAmtUrl,
		data : {
			p:{
					startDate:startDate,
					endData:endData,
					token: token
				},
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

	
