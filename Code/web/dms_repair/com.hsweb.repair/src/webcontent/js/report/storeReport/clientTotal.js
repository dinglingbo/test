/**
* Created by Administrator on 2019年2月27日
*/
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
var mainGridUrl = apiPath + repairApi+'/com.hsapi.repair.report.dataStatistics.queryChainGuestSummary.biz.ext';
var list = [];
$(document).ready(function(v) {
	
   var mainGrid = nui.get("mainGrid");
   mainGrid.setUrl(mainGridUrl);
   var params = {
    token:token
  };
   mainGrid.load({params:params},function(){
	   mainGrid.setData(list);  
   });
   mainGrid.on("preload",function(e){
	   list = [];
	   var guestList = e.result.guestList;
	   var cardList = e.result.cardList;
	   var cardStoreList = e.result.cardStoreList;
	   var tenantList = e.result.tenantList;
	   for(var i=0;i<tenantList.length;i++){
	    var guest = 0;
	    var card = 0;
	    var cards = 0;
	    var temp = {};
	    for(var j=0;j<guestList.length;j++)
	    {
	        if(tenantList[i].orgid == guestList[j].orgid)
	        {
	            guest = 1;
	            temp.guestTotal = guestList[j].guestTotal;
	            break;
	        }
	    }
	
	    for(var j=0;j<cardList.length;j++)
	    {
	        if(tenantList[i].orgid == cardList[j].orgid)
	        {
	            card = 1;
	            temp.canUseTimesTotal = cardList[j].canUseTimesTotal;
	            temp.amtTotal = cardList[j].amtTotal;
	            break;
	            
	        }
	    }
	    
	     for(var j=0;j<cardStoreList.length;j++)
	    {
	        if(tenantList[i].orgid == cardStoreList[j].orgid)
	        {
	            cards = 1;
	            temp.balaAmtTotal = cardStoreList[j].balaAmtTotal;
	            break;
	            
	        }
	    }
	    
	    if(guest || card || cards){
	       temp.shortName = tenantList[i].shortName;
	       list.push(temp);
	    }
	    
	  } 
	});

});
function overShow(e,con) {
    var showDiv = document.getElementById('showDiv');
    var pos = e.getBoundingClientRect();
    $("#showDiv").css("top", pos.bottom); //设置提示div的位置
    $("#showDiv").css("left", pos.right);
    showDiv.style.display = 'block';
    showDiv.innerHTML = con;
}

function outHide() {
    var showDiv = document.getElementById('showDiv');
    showDiv.style.display = 'none';
    showDiv.innerHTML = '';
}

