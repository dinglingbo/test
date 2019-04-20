
var gridUrl1 = apiPath + crmApi
+ "/com.hsapi.crm.basic.crmBasic.saveSell.biz.ext";
var statusList = [{id:"0",name:"尚未联系0%"},{id:"1",name:"有兴趣30%"},{id:"2",name:"意向明确50%"},{id:"3",name:"成交100%"},{id:"4",name:"输单0%"}];
var basicInfoForm = null;
var carNoEl = null;
var nextFollowDate = null;
var planFinishDate = null;
$(document).ready(function(v) {
	nextFollowDate = nui.get("nextFollowDate");
	planFinishDate = nui.get("planFinishDate");
    carNoEl = nui.get("carNo");
    carNoEl.focus();
    basicInfoForm = new nui.Form("#basicInfoForm");
    initDicts({
    	chanceType:SELL_TYPE//商机
    },function(){
        //hash.initDicts = true;
       // checkComplete();
    });
    
    //服务顾问
    initMember("chanceManId", function () {
        var data = nui.get("chanceManId").getData();
        data.forEach(function (v) {
            //mtAdvisorHash[v.id] = v;
        });
    });

	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
	 };
	 
	 nextFollowDate.setValue(addDate(getNowStartDate(),4));
	 planFinishDate.setValue(addDate(getNowEndDate(), 7));
});

function selectCustomer() {
	var carNo = nui.get("carNo").getText();
    openCustomerWindow(carNo,function (v) {
        basicInfoForm = new nui.Form("#basicInfoForm");	
        var main = basicInfoForm.getData();
        main.guestId = v.guestId;
        main.guestName = v.guestFullName;
        main.carId = v.carId;
        main.carNo = v.carNo;
        /*main.carVin = v.vin;*/
        main.carModel = v.carModel;
        main.carBrandId = v.carBrandId;
        main.carSeriesId = v.carSeriesId;
        main.contactorId = v.contactorId;
        main.guestMobile = v.mobile;


        SetData(main);
    });
}

function openCustomerWindow(carNo,callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        	if(carNo){
        	  var iframe = this.getIFrameEl();
        	  iframe.contentWindow.setCarNo(carNo);
        	}
        },
        ondestroy: function (action) {
        	carNoEl.focus();
            if ("ok" == action) {
              var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}

var requiredField = {
		carId : "车牌号",
		guestName : "客户姓名",
		guestMobile :"手机",
		chanceType : "商机类型",
		prdtName : "销售产品/项目",
		status : "销售阶段",
		nextFollowDate : "下次跟进时间"
};


var falg = null;
var type = null;




function onCancel() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}



function SetData(params) {
	if(params.type=="add"){
		params.id = null;
	}
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setData(params); 
    nui.get("prdtName").setText(params.prdtName||"");
}


function setData(params) {
	if(params.type=="add"){
		params.id = null;
	}
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setData(params);  
    nui.get("prdtName").setText(params.prdtName||"");
}


function selectItem() {
	var itemName = nui.get("prdtName").getText();
	openItemWindow(itemName,function (v) {
        nui.get("prdtName").setValue(v.name);
        nui.get("prdtName").setText(v.name);
    });
}
function openItemWindow(itemName,callback) {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemMain.flow?token=" + token,
        title: "项目选择", width: 1000, height: 560,
        onload: function () {
        	  var iframe = this.getIFrameEl();
        	  iframe.contentWindow.setItemName(itemName,1);//调用查询项目，传1代表销售机会
        },
        ondestroy: function (action) {
        	carNoEl.focus();
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var item = data.item;
                callback && callback(item);
            }
        }
    });
}

function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}

function onOk(){
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0){
			//当有效期没有输入月份时，判断单选框是否选择了
			if( key == "status" && data[key]==0){
	
			}else{
					showMsg(requiredField[key] + "不能为空!", "W");
					return;
				
				}

		}
	}
	saveData();
}

function onMTAdvisorIdChange(e){
    var chanceMan = e;
    nui.get("chanceMan").setValue(chanceMan);
}

function saveData() {


		var sell = basicInfoForm.getData();
		var json = nui.encode({
			sell:sell,
			token : token
		});
		
	    nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '处理中...'
	    });

		nui.ajax({
			url : gridUrl1,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				nui.unmask(document.body);
				if (returnJson.errCode == 'S') {
					showMsg("保存成功");
					CloseWindow("saveSuccess");
				} else {
					showMsg(returnJson.errMsg||"保存失败","W");
				}
			}
		});
	}