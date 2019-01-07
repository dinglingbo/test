/**
 * Created by Administrator on 2018/4/27.
 */                                       

var queryFormUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.queryRefundRecord.biz.ext";

var grid = null;
var queryForm = null;
var statusList = [{id:"0",name:"客户名称"},{id:"1",name:"客户电话"}];

$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    queryForm = new nui.Form("#queryForm");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
   
    var startDate = mini.get("startDate");
    //startDate.setValue(sdate);
    
    var endDate = mini.get("endDate");
    endDate.setValue(date);
    
    
    var params = {
    		startDate:sdate,
    		endDate:date
    }; 
    grid.setUrl(queryFormUrl);
    grid.load({
    	params:params,
    	token : token
    });
       
});


    

var hash = new Array("计次卡退款","储值卡退款");

 function onDrawCell(e)
  {

    switch (e.field)
    {
        

    case "type":
    	e.cellHtml = hash[e.value-1];
        break; 

    default:
        break;
    }
}

 //快速查询
 
 function search(){
	    nui.mask({
	        el : document.body,
		    cls : 'mini-mask-loading',
		    html : '查询中...'
	    });
		var guestName =  null;
		var mobile = null;
		var cardName = null;
		var startDate = nui.get("startDate").getFormValue();
		var endDate = nui.get("endDate").getValue();
		endDate = addDate(endDate, 1);
	    var type = nui.get("search-type").getValue();
	    var typeValue = nui.get("carNo-search").getValue();
	    if(type==0){
	    	guestName = typeValue;
	    }else if(type==1){
	    	mobile = typeValue;
	    }else if(type==2){
	    	cardName = typeValue;
	    }
		var params = {
				guestName:guestName,
				mobile:mobile,
				cardName:cardName,
				startDate:startDate,
				endDate:endDate
		}
		var json1 = {
				params:params,
				token:token
		}
		nui.ajax({
			url : queryFormUrl,
			type : 'POST',
			data : json1,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				grid.setData(text.data);
				nui.unmask(document.body);
				
				
			}
		});
	}

 

  

