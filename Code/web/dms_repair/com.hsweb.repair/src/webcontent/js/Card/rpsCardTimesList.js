/**
 * Created by Administrator on 2018/4/27.
 */                                       
//var queryFormUrl = apiPath + repairApi + "/ com.hsapi.repair.baseData.cardTimes.test.biz.ext";
var queryFormUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.queryCardTimesList.biz.ext";
var CardUrl = webPath + contextPath + "/repair/DataBase/Card/rpsCardTimesBase.jsp?token="+token;
//var getTimes = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimesDe.biz.ext";
var grid = null;
var grid2 = null;
var queryForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var orgidsEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"},{id:"2",name:"客户电话"},{id:"3",name:"计次卡名称"}];
/*进来该页面，加载套餐列表数据*/
$(document).ready(function (v)
{
    grid  = nui.get("datagrid1");
    grid2 = nui.get("datagrid2");
    queryForm = new nui.Form("#queryForm");

    var startDate = mini.get("startDate");   
    var endDate = mini.get("endDate");
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
         
    startDate1 = getMonthStartDate();
    endDate1 = getMonthEndDate();
    startDate.setValue(startDate1);
    endDate.setValue(endDate1);
    
	  var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'fullName' },
	            { name: 'carNo' },
		            { name: 'mobile' },
	            { name: 'cardName' },
	            { name: 'prdtName' },
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
    
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    
    grid.setUrl(queryFormUrl);

    grid2.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        switch (e.field) {
           case "qty":
        	   if(!record.qty){
        		   e.cellHtml = 1;
        	   }
        	   break;
           case "serviceTypeId":
        	   e.cellHtml = servieTypeHash[e.value].name;
        	   break;
           default:
               break;
        }
    });
    grid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        switch (e.field) {
           case "buySource":
        	   if(record.buySource == 1){
        		   e.cellHtml = "pc";
        	   }
        	   if(record.buySource == 2){
        		   e.cellHtml = "微信";
        	   }
        	   if(record.buySource == 3){
        		   e.cellHtml = "APP";
        	   }
        	   break;
           default:
               break;
        }
    });
    search();
       
});


//查看
function searchOne() {

  var row = grid.getSelected();
  if (row) {
    nui.open({
      url:CardUrl,
      title: "计次卡基本信息",
      width: 1200,
      height: 620,
      onload: function () {
    	var iframe = this.getIFrameEl();
        var data = row;
        //直接从页面获取，不用去后台获取
		data.type = 'VIEW';
        iframe.contentWindow.setData(data);
        
        },
         
        });
      } else {
        nui.alert("请选中一条记录","提示");
      }
    }
    
 
//购买次卡套餐
var addcardTimeUrl = webPath + contextPath  + "/repair/DataBase/Card/timesCardList.jsp?token"+token;
function dealtWithCard(){	
 	nui.open({
 		url : addcardTimeUrl,
 		title : "次卡办理",
 		width : 965,
 		height : 573,
 		onload : function() {
 		    var iframe = this.getIFrameEl();
 			iframe.contentWindow.setStely();
 		},
 		ondestroy : function(action) {// 弹出页面关闭前
 			if (action == "saveSuccess") {
 				grid.reload();
 			}
 		}
 	});
 	
 }
 
 
  //重新刷新页面
function refresh(){
    var form = new  nui.Form("#queryform");
    var json = form.getData(false,false);
    grid.load(json);//grid查询
    nui.get("update").enable();
	/*grid  = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.load();*/
  }

  
  var prdtTypeHash = {
	    "1":"套餐",
        "2":"项目",
        "3":"配件"
  };
  var hash = new Array("草稿","已提交","已结算");
  var isRefundList = new Array("未退款","已退款");
  //剩余次数
  var balaTimes = null;
  //总次数
  var totalTimes = null;
  //剩余可使用次数
  var canUseTimes = null;
  var id = null;
 function onDrawCell(e)
  {
	 var record = e.record;
    switch (e.field)
    {
        
    case "sellAmt":
        e.cellHtml = "￥"+e.value;
        break;
    case "status":
    /*e.cellHtml = e.value==1?"禁用":"启用";*/
    	e.cellHtml = hash[e.value];
        break; 
    case "periodValidity":
    	e.cellHtml = (e.value == -1 ? "永久有效":e.value);
    	break;
    case "isRefund":
    	e.cellHtml = isRefundList[e.value];
    	break;
    case "prdtType":
    	e.cellHtml = prdtTypeHash[e.value];
    	break;
    case "orgid":
    	for(var i=0;i<currOrgList.length;i++){
    		if(currOrgList[i].orgid==e.value){
    			e.cellHtml = currOrgList[i].shortName;
    		}
    	}
    	break;    	
    	

    default:
        break;
    }
}

 //快速查询
 
 function search(){
	var guestName =  null;
	var mobile = null;
	var cardName = null;
	var carNo = null;
	var startDate = nui.get("startDate").getFormValue();
	var endDate = nui.get("endDate").getValue();
	endDate = addDate(endDate, 1);
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
    	carNo = typeValue;
    }else if(type==1){
    	guestName = typeValue;
    }else if(type==2){
    	mobile = typeValue;
    }else if(type==3){
    	cardName = typeValue;
    }
	var params = {
			guestName:guestName,
			mobile:mobile,
			cardName:cardName,
			carNo:carNo,
			startDate:startDate,
			endDate:endDate
	};
	   var orgidsElValue = orgidsEl.getValue();
	    if(orgidsElValue==null||orgidsElValue==""){
	    	 params.orgids =  currOrgs;
	    }else{
	    	params.orgid=orgidsElValue;
	    }

	
	grid.load({
		query:params,
    	token : token
    });
}
 
 //查明细
 var searchDetialUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.cardTimes.getCardTimesDe.biz.ext";
 function searchDetial(id){
	 
	 var infor = null;
	 var json = nui.encode({
		 Id:id,
		 token:token
	 });
	 nui.ajax({
	        url : searchDetialUrl,
	        type : 'POST',
	        data : json,
	        cache : false,
	        contentType : 'text/json',
	        success : function(text) 
	        {
	            var object = nui.decode(text);
	            var cardTimeDe = object.cardTimDe;
	            if(cardTimeDe != null)
	            {
	            	for(var i = 0;i<cardTimeDe.length;i++)
	            	{
	            		infor = infor + cardTimeDe[i].prdtName + "总次数【"+ cardTimeDe[i].balaTimes+"】,剩余次数【"+cardTimeDe[i].balaTimes+"】"
	            	}
	            }
	        }
	 }); 
	 return infor;
 }
  
 //计次卡退款
 function refund(){
		var row = grid.getSelected();
		if(row){
			
		}else{
			//showMsg("请选一张储值卡!","W");
			return;
		}
		nui.open({
	        url: webPath + contextPath +"/com.hsweb.frm.manage.refundPay.flow?token="+token,
	         width: "100%", height: "100%", 
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            var data = {
	            		card:row,
	            		payAmt:row.sellAmt,
	            		typeCard:1
	            }
	            iframe.contentWindow.setData(data);
	        },
			ondestroy : function(action) {// 弹出页面关闭前
				if (action == "saveSuccess") {
					//showMsg("退款成功!", "S");
					var query = queryForm.getData();
					grid.load({
				    	query:query,
				    	token : token
				    });

				}
			}
	    });
}
 
 var queryCardUr2 = apiPath + repairApi +"/com.hsapi.repair.baseData.cardTimes.queryCardTimesMaintain.biz.ext";
 function selectionChanged() {
	    nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '数据加载中...'
	    });
		var row = grid.getSelected();
		var cardDetailId = row.cardDetailId;
		var params = {};
		params.cardDetailId = cardDetailId;
		params.type = row.prdtType;
		var json1 = {
				params:	params
		};
		nui.ajax({
			url : queryCardUr2,
			type : 'POST',
			data : json1,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				nui.unmask(document.body);
				grid2.setData(text.cardMaintain);
			}
		});
}


		
		
		function onExport(){
			
			
			var billTypeIdHash = [{name:"套餐",id:"1"},{name:"项目",id:"2"},{name:"配件",id:"3"}]; 

			var detail = grid.getData();
			
			for(var i=0;i<detail.length;i++){
				for(var j=0;j<billTypeIdHash.length;j++){
					if(detail[i].prdtType==billTypeIdHash[j].id){
						detail[i].prdtType=billTypeIdHash[j].name;
					}
				}
			}
			for(var i=0;i<detail.length;i++){

					if(detail[i].periodValidity==-1){
						detail[i].periodValidity="永久有效";
					}
			}

			
			if(detail && detail.length > 0){
				setInitExportData( detail);
			}
		}


		function setInitExportData( detail){
			

		    var tds = '<td  colspan="1" align="left">[fullName]</td>' +
		        "<td  colspan='1' align='left'>[carNo]</td>" +
		        "<td  colspan='1' align='left'>[mobile]</td>" +
		        "<td  colspan='1' align='left'>[cardName]</td>" +
		        "<td  colspan='1' align='left'>[periodValidity]</td>" +        
		        "<td  colspan='1' align='left'>[prdtType]</td>" +
		        "<td  colspan='1' align='left'>[prdtName]</td>" +		        
		        "<td  colspan='1' align='left'>[totalTimes]</td>" +
		        "<td  colspan='1' align='left'>[useTimes]</td>" +        
		        "<td  colspan='1' align='left'>[balaTimes]</td>" +
		        "<td  colspan='1' align='left'>[sellAmt]</td>" +
		        "<td  colspan='1' align='left'>[remainAmt]</td>" ;
		        
		        
		    var tableExportContent = $("#tableExportContent");
		    tableExportContent.empty();
		    for (var i = 0; i < detail.length; i++) {
		        var row = detail[i];
		        if(row.id){
		            var tr = $("<tr></tr>");
		            tr.append(tds.replace("[fullName]", detail[i].fullName?detail[i].fullName:"")
		                         .replace("[carNo]", detail[i].carNo?detail[i].carNo:"")
		                         .replace("[mobile]", detail[i].mobile?detail[i].mobile:"")
		                         .replace("[cardName]", detail[i].cardName?detail[i].cardName:"")
		                         .replace("[periodValidity]", detail[i].periodValidity?detail[i].periodValidity:"")
		                         .replace("[prdtType]", detail[i].prdtType?detail[i].prdtType:"")
		                         .replace("[prdtName]", detail[i].prdtName?detail[i].prdtName:"")
		                         .replace("[totalTimes]", detail[i].totalTimes?detail[i].totalTimes:0)
		                         .replace("[useTimes]", detail[i].useTimes?detail[i].useTimes:0)	
		                         .replace("[balaTimes]", detail[i].balaTimes?detail[i].balaTimes:0)
		                         .replace("[sellAmt]", detail[i].sellAmt?detail[i].sellAmt:0)		                         
		                         .replace("[remainAmt]", detail[i].remainAmt?detail[i].remainAmt:0));                        

		            tableExportContent.append(tr);
		        }
		    }

		 
		    method5('tableExcel',"客户计次卡明细表导出",'tableExportA');
		}