var tabs = null;


var mainServiceGrid = null;
var params = {};
var form = null; 
var datagrid1 = null;
var datagrid2 = null;
var datagrid3 = null;
var grid = null;
var grid1 = null;
var grid2 = null;
var grid3 = null;
var carSellPointGrid = null;
var baseUrl = apiPath + repairApi + "/";
var baseUrl2 = apiPath + wechatApi + "/";
var mainGrid2 = null;
var xyguest = {};
var sfData = {};
var editFormDetail = null; 
var innerItemGrid = null;
var contactdatagrid = null;
var onSearchParams = {};//现在用于查询本车或者客户全部
var rpsPackageGrid = null;
var rpsItemGrid = null;
var guestTypeList = [];
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
};
var sellHash = new Array("尚未联系", "有兴趣", "意向明确", "成交" ,"输单");
var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }, { id: 11, text: '其他' }];
var queryOldMaintain = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldMaintain.biz.ext";
var queryOldItemPart = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldItemPart.biz.ext";
var sellUrl = apiPath + crmApi
+ "/com.hsapi.crm.basic.crmBasic.querySellList.biz.ext";
var baseUrl = apiPath + repairApi + "/";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var grid3 = null;
var grid4 = null;
var servieTypeList = [];
var servieTypeHash = {};
var hash = {};
var identityList = {};
$(document).ready(function () {
	datagrid1 = nui.get("datagrid1");
	datagrid2 = nui.get("datagrid2");
	datagrid3 = nui.get("datagrid3");
	datagrid1.setUrl(queryOldMaintain);
	mainServiceGrid = nui.get("mainServiceGrid");
    form = new nui.Form("#editForm1");
    carSellPointGrid = nui.get("carSellPointGrid");
    carSellPointGrid.setUrl(sellUrl);
    contactdatagrid = nui.get("contactdatagrid");
    editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");
    innerItemGrid.setUrl(getRpsItemUrl);
    innerpackGrid.setUrl(getdRpsPackageUrl);
    rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	
    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");
    grid3 = nui.get("grid3");
    grid4 = nui.get("grid4");
    grid1.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext");
    grid2.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext");
    grid3.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryItemTimesByUsableWithPage.biz.ext");
    grid4.setUrl(baseUrl2 +"com.hsapi.wechat.autoServiceBackstage.weChatInterface.queryUserUseCouponChenDaoCarId.biz.ext");
    mainServiceGrid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
    mainGrid2 = nui.get("mainGrid2");

    grid2.on("load",function(e){
    	var data = e.data;
    	for(var i = 0;i<data.length;i++){
    		data[i].balaAmt=data[i].totalAmt-data[i].useAmt;
    		grid2.updateRow(data[i],i);
    	}
    });
    nui.get("carNo").focus();
    document.onkeyup=function(event){
    var e=event||window.event;
    var keyCode=e.keyCode||e.which;//38向上 40向下

    if((keyCode==27))  {  //ESC
        onCancel();
    }
    
    rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		var record = e.record;
		var uid = record._uid;
		if(field=="packageName"){
            var billPackageId = record.billPackageId || 0;
            if(billPackageId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "subtotal"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		
	});
    
    rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value,
		row = e.row;
		var record = e.record;
		var uid = record._uid;
		if(field=="itemName"){
            var billItemId = record.billItemId||0;
            if(billItemId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "itemTime" || field == "unitPrice"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "itemCode"){
			var billItemId = record.billItemId||0;
			if(billItemId == 0){
	            e.cellHtml = "--";
	        }
		}
	});
    
  };
 
  var tip = new nui.ToolTip();
  tip.set({
      target: document,
      selector: '#carModel .mini-textbox-input',
      onbeforeopen: function (e) {
          e.cancel = false;
      },
      onopen: function (e) {
          var el = e.element;
          
          var val = $(el).val();
          if (val == "") {
              tip.hide();
          } else {
              tip.setContent(val);
          }

      }
  });


  grid1.on("drawcell", function (e) {
      switch (e.field) {
          case "prdtType":
        	  e.cellHtml = prdtTypeHash[e.value];
        	  break;
          case "doTimes":
        	  var row = e.row;
              var balaTimes = row.balaTimes || 0;
              var canUseTimes = row.canUseTimes||0;
              e.cellHtml = balaTimes - canUseTimes;
          default:
              break;
      }
  });
  grid4.on("drawcell", function (e) {
	  var record = e.record;
	  var couponType = record.couponType;
      switch (e.field) {
          case "couponType":
        	  e.cellHtml = couponType==1?"通用券":"专属券";
        	  break;
          case "couponDescribe":
        	 var str = "";
        	 if(couponType==1){
        		 str = "(满"+record.couponConditionPrice+"元)";
        		 e.cellHtml = record.couponDescribe + str; 
        	 }
          case "userFile":
        	  var isCarUse = record.isCarUse || 0;//本车使用,0,是，1否
        	  var isStoreUse = record.isStoreUse || 0;//本店使用,0,是，1否
        	  var isTenantUse = record.isTenantUse || 0;//连锁使用,0,是，1否
        	  if(isCarUse){
        		  if(isStoreUse){
        			  e.cellHtml = "本店使用";
        		  }else{
        			  e.cellHtml = "连锁使用";
        		  }
        	  }else{
        		  e.cellHtml = "本车使用";
        	  }
        	  
          default:
              break;
      }
  });
  grid3.on("drawcell", function (e) {
      switch (e.field) {
          case "prdtType":
        	  e.cellHtml = prdtTypeHash[e.value];
        	  break;
          case "doTimes":
        	  var row = e.row;
              var balaTimes = row.balaTimes || 0;
              var canUseTimes = row.canUseTimes||0;
              e.cellHtml = balaTimes - canUseTimes;
          default:
              break;
      }
  });
  carSellPointGrid.on("drawcell", function(e) {
	switch (e.field) {
	case "status":
		e.cellHtml = sellHash[e.value];
		break;
	case "chanceType":
		for(var i=0;i<sfData.length;i++){
			if(e.value==sfData[i].customid){
				e.cellHtml =sfData[i].name;
				}
			}
		break;
	case "cardTimesOpt":
		e.cellHtml = '<a class="optbtn" href="javascript:void()" onclick="editSell()">跟进</a>';
		break;
	default:
		break;
	}
  });
 innerItemGrid.on("drawcell", function (e) {
  var grid = e.sender;
  var record = e.record;
  var uid = record._uid;
  var rowIndex = e.rowIndex;
  switch (e.field) {
      case "prdtName":
          var cardDetailId = record.cardDetailId||0;
          if(cardDetailId>0){
              e.cellHtml = e.value + "<font color='red'>(预存)</font>";
          }
          break;
      case "serviceTypeId":
          var type = record.type||0;
          if(type>2){
              e.cellHtml = "--";
              e.cancel = false;
          }else{
              e.cellHtml = servieTypeHash[e.value].name;
          }
          break;
      case "workers":
          var type = record.type||0;
          if(type != 2){
              e.cellHtml = "--";
          }else{
              e.cellHtml = e.value;
          }
          break;
      case "rate":
          var value = e.value||"";
          if(value&&value!="0"){
              e.cellHtml = e.value + '%';
          }
          break;
      case "prdtCode":
      	var type = record.type||0;
          if(type == 3){
          	e.cellHtml = e.value;
          }else{
          	e.cellHtml = "--";
          }
          break;
      default:
          break;
  }
  
  });
 innerpackGrid.on("drawcell", function (e) {
     var grid = e.sender;
     var record = e.record;
     var uid = record._uid;
     var rowIndex = e.rowIndex;
     switch (e.field) {
	   case "prdtName":
	        var cardDetailId = record.cardDetailId||0;
	        if(cardDetailId>0){
	            e.cellHtml = e.value + "<font color='red'>(预存)</font>";
	        }
         break;
        case "serviceTypeId":
            var type = record.type||0;
            if(type>1){
                e.cellHtml = "--";
            }else{
                e.cellHtml = servieTypeHash[e.value].name;
            }
         break;
         case "saleMan":
             var type = record.type||0;
             var cardDetailId = record.cardDetailId||0;
             if(type>1 || cardDetailId> 0){
                 e.cellHtml = "--";
             }
             break;
         case "workers":
             var type = record.type||0;
             var cardDetailId = record.cardDetailId||0;
             if(type != 2){
                 e.cellHtml = "--";
             }else{
                 e.cellHtml = e.value;
             }
             break;
         case "serviceTypeId":
             if(servieTypeHash[e.value])
             {
                 e.cellHtml = servieTypeHash[e.value].name;
             }
             break;
         case "rate":
             var value = e.value||"";
             if(value&&value!="0"){
                 e.cellHtml = e.value + '%';
             }
             break;
         case "type":
             if(e.value == 1){
                 e.cellHtml = "--";
             }else{
                 e.cellHtml = prdtTypeHash[e.value];
             }
             break;
         case "prdtCode":
         	var type = record.type||0;
             if(type == 3){
             	e.cellHtml = e.value;
             }else{
             	e.cellHtml = "--";
             }
             break;
         default:
             break;
     }
 });     
 initGuestType("guestTypeId",function(data) {
   	guestTypeList = nui.get("guestTypeId").getData();
   	guestTypeList.forEach(function(v) {
   		guestTypeHash[v.id] = v;
       });
   });    
initDicts({
   // visitMode: "DDT20130703000021",//跟踪方式
    chanceType:SELL_TYPE,//商机
      //carSpec:CAR_SPEC,//车辆规格
      //kiloType:KILO_TYPE,//里程类别
      //source:GUEST_SOURCE,//客户来源
      identity:IDENTITY //客户身份
  },function(){
	   identityList = nui.get("identity").getData();
	  sfData = nui.get("chanceType").getData();
  });
 initServiceType("serviceTypeId",function(data) {
    servieTypeList = nui.get("serviceTypeId").getData();
    servieTypeList.forEach(function(v) {
        servieTypeHash[v.id] = v;
    });
  });
});


function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainServiceGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerItemGrid.setData([]);
    innerpackGrid.setData([]);
    var serviceId = row.id;
    innerItemGrid.load({
    	serviceId:serviceId,
        token: token
    });

    innerpackGrid.load({
    	serviceId:serviceId,
        token: token
    });
}


function onDrawCell(e) {
	var sexList = new Array("男", "女", "未知");
	var birthdayTypeList = new Array("农历", "阴历");
	switch (e.field) {
	case "sex":
		e.cellHtml = sexList[e.value];
		break;
	case "birthdayType":
		e.cellHtml = birthdayTypeList[e.value];
		break;

	}
	if(e.field=="identity"){
		for(var i=0;i<identityList.length;i++){
			if(e.value==identityList[i].customid){
				e.cellHtml =identityList[i].name;
			}
		}
	}
}
//取消
function onCancel() {
    CloseWindow("cancel");
}
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function SetData(params) {
	onSearchParams = params;
	nui.get("carId").setValue(params.carId);
	nui.get("guestId").setValue(params.guestId);
	xyguest=params;
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.report.queryCarByCarId.biz.ext",
        type : "post",
        data : {
        	carId:params.carId,
        	token:token
        },
        async:false,
        success: function (text) {
            var list = nui.decode(text.rpbCar);
            form.setData(list);
            var carExtend = {};
            carExtend.lastComeKilometers = list.lastComeKilometers;
            carExtend.careDueMileage = list.careDueMileage;
            carExtend.careDueDate = list.careDueDate;
            nui.get("editForm2").setData(carExtend);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "E");
        }
    });
    nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext",
        type : "post",
        data : {
        	guestId : params.guestId
        },
        success: function (data) {
        	var guest = data.guest||[{}];
            var form1 = new nui.Form("#editForm4");
            form1.setData(guest);
        	var contactList = data.contactList||[{}];
            //var form5 = new nui.Form("#editForm5");
            //form5.setData(contactList[0]);
            contactdatagrid.setData(contactList);
            
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "E");
            nui.unmask();
        }
    });
/*	//计次卡
    var pa = {
    		guestId:params.guestId,
    		token:token
    };
    grid1.load({p:pa});

    //线上订单
    var p3 = {};
    p3.detailFinish = 0;  
    p3.guestId = params.guestId;
    p3.notPast = 1; 
    p3.status = 2; 
    p3.isRefund = 0;
    grid3.load({
    	token:token,
        p:p3
    });
    //优惠券
    var paraMap = {};
    paraMap.orgid = currOrgId;  
    paraMap.tenantId = currTenantId;
    paraMap.userCarId = params.carId; 
    grid4.load({
    	token:token,
    	paraMap:paraMap
    });
    //服务记录
    var pa1 = {
    		carId:params.carId,
    		token:token
    };
    mainServiceGrid.load({params:pa1});
//储值卡
    grid2.load({guestId:params.guestId});

    // 回访记录根据联系人id查询
    if (params.contactorId || params.carId) {
        var p = {
            guestSource: 0
         };
     	if(params.carId){
    		p.carId = params.carId;
    	}else if(params.contactorId){
    		p.guestId = params.contactorId;
    	}
        loadVisitHis(p);
    }
    // 销售机会根据客户id查询
    if (params.guestId) {
        var p = {
            guestId:params.guestId
        };
        carSellPointGrid.load({ 
        	params:p,
        	token:token
        });
    }*/
}


function searchOld(carNo){
	datagrid2.setData([]);
	datagrid3.setData([]);
	var params = {
			carNo:carNo
	}
	var json1 = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryOldMaintain,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			datagrid1.setData(text.oldMaintain);
					
		}
	});
}
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var row = datagrid1.getSelected();
	var serviceCode = row.serviceCode;
	var params = {};
	params.serviceCode = serviceCode;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryOldItemPart,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			datagrid2.setData(text.oldPart);
			datagrid3.setData(text.oldItem);
		}
	});
}

function addSell() {
	
	nui.open({
		url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
		title : "添加商机",
		width : 550,
		height : 410,
		onload : function() {
			var iframe = this.getIFrameEl();
			//工单页面添加商机信息直接带过去
			var data = xyguest;
			//新增页面商机的姓名字段是guestName
			if(data.guestName==null){
				data.guestName = data.guestFullName;
			}

			data.type = "add";
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
			if (action == "saveSuccess") {
		        var p = {
		                guestId:onSearchParams.guestId,
		            };
		        carSellPointGrid.load({ 
		        	params:p,
		        	token:token
		        });
			}
		}
	});
}


function editSell() {
	var row = carSellPointGrid.getSelected();
	if (row) {
		nui.open({
			url : webPath + contextPath
			+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
			+ token,
			title : "更新商机",
			width : 550,
			height : 410,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = row;
				data.type = 'editT';
				// 直接从页面获取，不用去后台获取
				iframe.contentWindow.setData(data);
			},
			ondestroy : function(action) {
		        var p = {
		                guestId:onSearchParams.guestId,
		            };
				if (action == "saveSuccess") {
			        carSellPointGrid.load({ 
			        	params:p,
			        	token:token
			        });
				}
			}
		});
	} else {
		showMsg("请选中一条记录!", "W");
	}
}

function onSearch(){
	var pa1 = {};
	if(nui.get("isAll").getValue()==0){
	     pa1 = {
	    		carId:onSearchParams.carId,
	    		token:token
	    };
	}else{
	     pa1 = {
	    		guestId:onSearchParams.guestId,
	    		token:token
	    };
	}

    mainServiceGrid.load({params:pa1});
}

function activechangedmain(){
	var tabs = nui.get("mainTabs").getActiveTab();
	if(tabs.name=="cardTimes"){
		//计次卡
	    var pa = {
	    		guestId:onSearchParams.guestId,
	    		orgid:currOrgid,
	    		token:token
	    };
	    grid1.load({p:pa});
	}else if(tabs.name=="order"){
	    //线上订单
	    var p3 = {};
	    p3.detailFinish = 0;  
	    p3.guestId = onSearchParams.guestId;
	    p3.notPast = 1; 
	    p3.status = 2; 
	    p3.isRefund = 0;
	    p3.orgid = currOrgId;
	    grid3.load({
	    	token:token,
	        p:p3
	    });
	}else if(tabs.name=="card"){
		//储值卡
	    grid2.load({guestId:onSearchParams.guestId,orgid:currOrgid});
	}else if(tabs.name=="coupons"){
	    //优惠券
	    var paraMap = {};
	    paraMap.orgid = currOrgId;  
	    paraMap.tenantId = currTenantId;
	    paraMap.userCarId = onSearchParams.carId; 
	    grid4.load({
	    	token:token,
	    	paraMap:paraMap
	    });
	}else if(tabs.name=="serviceRecord"){
	    //服务记录
	    var pa1 = {
	    		carId:onSearchParams.carId,
	    		token:token
	    };
	    mainServiceGrid.load({params:pa1});
	}else if(tabs.name=="serviceRecordOld"){
		searchOld(onSearchParams.carNo||"");
	}else if(tabs.name=="sales"){
	    // 销售机会根据客户id查询
	    if (onSearchParams.guestId) {
	        var p = {
	            guestId:onSearchParams.guestId
	        };
	        carSellPointGrid.load({ 
	        	params:p,
	        	token:token
	        });
	    }
	}else if(tabs.name=="visit"){
	    // 回访记录根据联系人id查询
	    if (onSearchParams.contactorId || onSearchParams.carId) {
	        var p = {
	            guestSource: 0
	         };
	     	if(onSearchParams.carId){
	    		p.carId = onSearchParams.carId;
	    	}else if(onSearchParams.contactorId){
	    		p.guestId = onSearchParams.contactorId;
	    	}
	        loadVisitHis(p);
	    }
	}
}

function activechangedmain2(){
	var row = mainServiceGrid.getSelected();
	var tabs = nui.get("mainTabs2").getActiveTab();
	if(row){
		var serviceId = row.id;
		if(tabs.name=="item"){//项目
			innerItemGrid.setUrl(getRpsItemUrl);
			innerItemGrid.setData([]);
		    innerItemGrid.load({
		    	serviceId:serviceId,
		        token: token
		    });
		}else if(tabs.name=="pack"){//套餐
			innerpackGrid.setUrl(getdRpsPackageUrl);
		    innerpackGrid.setData([]);
		    innerpackGrid.load({
		    	serviceId:serviceId,
		        token: token
		    });
		}else if(tabs.name=="expense"){
			var serviceId = row.id;
			rpsPackageGrid.setData([]);
			rpsItemGrid.setData([]);
			rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpensePkgBill.biz.ext");
			rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext");
			rpsPackageGrid.load({serviceId : serviceId,type:1,token : token},function(e){
			});
			rpsItemGrid.load({serviceId : serviceId,type:1,token : token});
		}else if(tabs.name=="finish"){
			nui.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '加载中...'
		    });
			var row = mainServiceGrid.getSelected();
		    //完工信息
			var getdRpsMaintainUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext";
			var main = {};
			var car = {};
			var guest = {};
			var conta = {};
			var carExd = {};
			nui.ajax({
                url : getdRpsMaintainUrl,
                type : "post",
                data : JSON.stringify({
                	id : row.id,
                    token : token
                }),
                cache: false,
                async: false,
                success : function(data) {
                	data = data || {};
                    if (data.errCode == "S") {
                       main = data.maintain;
                    } else {
                        showMsg("获取完工信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
			var getGuestContactorCarUrl =  window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext";
			nui.ajax({
                url : getGuestContactorCarUrl,
                type : "post",
                data : JSON.stringify({
                	guestId: main.guestId||0,
                    contactorId: main.contactorId||0,
                    carId:main.carId || 0,
                    carExtendId:main.carId,
                    token : token
                }),
                cache: false,
                async: false,
                success : function(data) {
                	data = data || {};
                    if (data.errCode == "S") {
                        car = data.car;
                        guest = data.guest;
                        conta = data.contactor;
                        carExd = data.carExtend;
                    } else {
                        showMsg("获取完工信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
			 var billForm = new nui.Form("#billForm");
			 var setData = {};
			 var lastComeKilometers2 = 0;
			 if(main){
				 setData.carNo2 = main.carNo;
				 setData.enterDate2 = main.enterDate;
				 setData.enterOilMass2 = main.enterOilMass;
				 setData.enterKilometers2 = main.enterKilometers;
				 lastComeKilometers2 = main.lastEnterKilometers || 0;
				 setData.planFinishDate2 = main.planFinishDate;
				 setData.mtAdvisor2 = main.mtAdvisor;
				 setData.guestDesc2 = main.guestDesc;
				 setData.faultPhen2 = main.faultPhen;
				 setData.solveMethod2 = main.solveMethod; 
				 if(main.serviceTypeId){
					 setData.serviceTypeId2= servieTypeHash[main.serviceTypeId].name;
				 }
			 }
			
			 if(car){
				 setData.carModel2 = car.carModel;
				 setData.carVin2 = car.vin;
				 setData.annualInspectionDate2 = car.annualInspectionDate || "";
				 setData.annualInspectionCompName2 = car.annualInspectionCompName || "";
				 setData.insureCompName2 = car.insureCompName || "";
				 setData.insureDueDate2 = car.insureDueDate || "";
			 }
			 
			 /*if(carExd){
				 setData.annualInspectionDate2 = carExd.annualInspectionDate || "";
				 setData.annualInspectionCompName2 = carExd.annualInspectionCompName || "";
				 setData.insureCompName2 = carExd.insureCompName || "";
				 setData.insureDueDate2 = carExd.insureDueDate || "";
			 }*/
			 if(conta){
				 setData.contactorName2 = conta.name;
				 setData.contactorMobile2 = conta.mobile;
				 setData.idNo2 = conta.idNo;
				 setData.sex2 = conta.sex; 
			 }
			
			 billForm.setData(setData);
			 $("#lastComeKilometers2").html(lastComeKilometers2);
			 nui.unmask(document.body);
		}
	}
	
}

function onLeftGridSelectionChanged(){
	activechangedmain2();
}