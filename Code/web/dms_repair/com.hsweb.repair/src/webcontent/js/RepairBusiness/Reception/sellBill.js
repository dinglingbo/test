/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
var cardTimesGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext";
var memCardGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";

var billForm = null;

var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var memList = [];
var serviceTypeIdEl = null;
var currEmpIdEl = null;
var searchNameEl = null;
var servieIdEl = null;
var searchKeyEl = null;

var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var packageDetailGrid = null;
var packageDetailGridForm = null;

var advancedCardTimesWin = null;
var cardTimesGrid = null;
var advancedMemCardWin = null;
var memCardGrid = null;

var fserviceId = 0;
var fguestId = 0;
var fcarId = 0;
var mpackageRate = 0;
var mitemRate = 0;
var mpartRate = 0;
var x = 0;
var y = 0;

var prdtTypeHash = {
    "1":"套餐",
    "2":"工时",
    "3":"配件"
};

$(document).ready(function ()
{
    billForm = new nui.Form("#billForm");
    rpsPartGrid = nui.get("rpsPartGrid");
    
    serviceTypeIdEl = nui.get("serviceTypeId");
    currEmpIdEl = nui.get("mtAdvisorId");
    currEmpIdEl.setText(currUserName);
    initMember("mtAdvisorId",function(){
        memList = currEmpIdEl.getData();
        
    });
    
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    
    currEmpIdEl.on("valueChanged",function(e){
        var text = currEmpIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
    searchNameEl = nui.get("search_name");
    servieIdEl = nui.get("servieIdEl");
    searchKeyEl = nui.get("search_key");
    searchKeyEl.setUrl(guestInfoUrl);
    searchKeyEl.on("beforeload",function(e){
        if(fserviceId){
            e.cancel = true;
            return;
        }
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<3){
            e.cancel = true;
            return;
        }else{
            var reg = /^[0-9]*$/;//纯数字
            if(reg.test(value)){
                params.nums = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含字母
            var reg = /[a-z]/i;
            if(reg.test(value)){
                params.letters = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if(reg.test(value)){
                params.chis = value;

                data.params = params;
                e.data =data;
                return;
            }
        }
    });
    searchKeyEl.on("valuechanged",function(e){
        var item = e.selected;
        if(fserviceId){
            return;
        }
        if (item) { 

            var carNo = item.carNo||"";
            var tel = item.guestMobile||"";
            var guestName = item.guestFullName||"";
            var carVin = item.vin||"";

            var params = {
                carNo: carNo,
                isSettle: 0,
                orgid: currOrgId
            }
            checkRpsMaintain(params, function(text){
                var data = text.data||[];
                if(data && data.length>0){
                    nui.showMessageBox({
                        showHeader: true,
                        width: 255,
                        title: "工单",
                        buttons: ["继续", "查看"],
                        message: "该客户存在未结算记录",
                        iconCls: "mini-messagebox-warning",
                        callback: function (action) {
                            if(action == "继续"){
                                var sk = document.getElementById("search_key");
                                sk.style.display = "none";
                                searchNameEl.setVisible(true);
                                
                                if(tel){
                                    tel = "/"+tel;
                                }
                                if(guestName){
                                    guestName = "/"+guestName;
                                }
                                if(carVin){
                                    carVin = "/"+carVin;
                                }
                                var t = carNo + tel + guestName + carVin;
                                searchNameEl.setValue(t);
                                //searchNameEl.setEnabled(false);
                    
                                doSetMainInfo(item);
                            }else if(action == "查看"){
                                var opt={};
                                opt.iconCls="fa fa-desktop";
                                opt.id="1104";
                                opt.text="洗车开单";
                                opt.url=webPath + contextPath + "/repair/RepairBusiness/Reception/carWashMgr.jsp";
                                
                                var params = {
                                    type: 'view',
                                    carNo: carNo
                                };
                                window.parent.activeTabAndInit(opt,params);
                            }
                        }
                    });
                }else{
                    var sk = document.getElementById("search_key");
                    sk.style.display = "none";
                    searchNameEl.setVisible(true);
                    
                    if(tel){
                        tel = "/"+tel;
                    }
                    if(guestName){
                        guestName = "/"+guestName;
                    }
                    if(carVin){
                        carVin = "/"+carVin;
                    }
                    var t = carNo + tel + guestName + carVin;
                    searchNameEl.setValue(t);
                    //searchNameEl.setEnabled(false);
        
                    doSetMainInfo(item);
                }
            });
            
        }
    });
    searchKeyEl.focus();  
    rpsPartGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "partOptBtn":
                var s = ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                if (grid.isEditingRow(record)) {
                    s = ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                         
                }
                e.cellHtml = s;
                break;
            default:
                break;
        }
    });   
  
    /*rpsPartGrid.on("cellendedit", function (e) {
    	var row = rpsPartGrid.getSelected();
        switch (e.field) {
            case "qty":
            	if(row.qty==0){
            	   e.cellHtml = "KK0";
            	}  
                break;
            default:
                break;
        }
    }); */
    
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==78)&&(event.altKey))  {  //新建
			add();	
	    } 
	  
	    if((keyCode==83)&&(event.altKey))  {   //保存
			save();
	    } 
	  
	    // if((keyCode==80)&&(event.altKey))  {   //打印
		// 	onPrint();
	    // } 
	    // if((keyCode==113))  {  
		// 	addMorePart();
		// } 
	 
	};
});

var statusHash = {
    "0" : "制单",
    "1" : "维修",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};
/*function advancedSearch(){
    if(document.getElementById("advancedMore").style.display=='block'){
        document.getElementById("advancedMore").style.display='none';
    }else{
        document.getElementById("advancedMore").style.display='block';
    }
    
}*/
function clear(){
    //advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerPartGrid.setData([]);

    var params = {};

    innerPartGrid.load({
        params:params,
        token: token
    });
}
function onApplyClick(){
    doApplyCustomer({},function(action){
        if(action == 'ok'){
            var iframe = this.getIFrameEl();
            var guest = iframe.contentWindow.getSaveData();
            if(guest){
                var maintain = billForm.getData();
                maintain.carId = guest.carId||0;recorder
                maintain.carNo = guest.carNo;
                maintain.carVin = guest.vin;
                maintain.engineNo = guest.engineNo;
                maintain.contactorId = guest.contactorId||0;
                maintain.contactorName = guest.contactName;
                maintain.identity = guest.identity;
                maintain.mobile = guest.mobile;
                maintain.guestFullName = guest.guestFullName;
                maintain.guestId = guest.guestId;
                maintain.carModel = guest.carModel;
                carNoEl.setText(guest.carNo);
                billForm.setData(maintain);

                fguestId = guest.guestId||0;
                fcarId = guest.carId||0;

                mpackageRate = 0;
                mitemRate = 0;
                mpartRate = 0;

                $("#carNoEl").html(car.carNo);
                $("#guestNameEl").html(car.guestFullName);
                $("#guestTelEl").html(car.mobile);
            }
        }
    });
}
function onSearchClick(){
    var maintain = billForm.getData();
    if(maintain.id){
        return;
    }
    selectCustomer(function (car) {
        doSetMainInfo(car);
    });
}
function doSetMainInfo(car){
    var maintain = billForm.getData();
    maintain.carId = car.id;
    maintain.carNo = car.carNo;
    maintain.carVin = car.vin;
    maintain.engineNo = car.engineNo;
    maintain.contactorId = car.contactorId;
    maintain.contactorName = car.contactName;
    maintain.identity = car.identity;
    maintain.mobile = car.mobile;
    maintain.guestMobile = car.guestMobile;
    maintain.guestFullName = car.guestFullName;
    maintain.guestId = car.guestId;
    maintain.carModel = car.carModel;
    maintain.billTypeId = 2;
    maintain.serviceTypeId = 3;
    maintain.mtAdvisorId = currEmpId;
    maintain.mtAdvisor = currUserName;
    maintain.recordDate = now;

    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;

    billForm.setData(maintain);

    fguestId = car.guestId||0;
    fcarId = car.id||0;

   // doSearchCardTimes(fguestId);
   // doSearchMemCard(fguestId);
    
    $("#guestNameEl").html(car.guestFullName);
    $("#showCarInfoEl").html(car.carNo);
    $("#guestTelEl").html(car.guestMobile);
}
function setInitData(params){

    if(!params.id){
        add();
    }else{
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });

        var params = {
            data: {
                id: params.id
            }
        }
        getMaintain(params, function(text){
            var errCode = text.errCode||"";
            var data = text.maintain||{};
            if(errCode == 'S'){
                var p = {
                    data:{
                        guestId: data.guestId||0,
                        contactorId: data.contactorId||0
                    }
                }
                getGuestContactorCar(p, function(text){
                    var errCode = text.errCode||"";
                    var guest = text.guest||{};
                    var contactor = text.contactor||{};
                    if(errCode == 'S'){
                        $("#servieIdEl").html(data.serviceCode);
                        var carNo = data.carNo||"";
                        var tel = guest.mobile||"";
                        var guestName = guest.fullName||"";
                        var carVin = data.carVin||"";
                        if(tel){
                            tel = "/"+tel;
                        }
                        if(guestName){
                            guestName = "/"+guestName;
                        }
                        if(carVin){
                            carVin = "/"+carVin;
                        }
                        var t = carNo + tel + guestName + carVin;

                        var sk = document.getElementById("search_key");
                        sk.style.display = "none";
                        searchNameEl.setVisible(true);

                        searchNameEl.setValue(t);
                        searchNameEl.setEnabled(false);
    
                        data.guestFullName = guest.fullName;
                        data.guestMobile = guest.mobile;
                        data.contactorName = contactor.name;
                        data.mobile = contactor.mobile;

                        $("#guestNameEl").html(guest.guestFullName);
                        $("#showCarInfoEl").html(data.carNo);
                        $("#guestTelEl").html(guest.mobile);

                        fguestId = data.guestId||0;
                        fcarId = data.carId||0;

                      //  doSearchCardTimes(fguestId);
                      //  doSearchMemCard(fguestId);
    
                        billForm.setData(data);

                       
                        var p3 = {
                            interType: "part",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        loadDetail(p3);

                    }else{
                        showMsg("数据加载失败,请重新打开工单!","W");
                    }
    
                }, function(){});
            }else{
                showMsg('数据加载失败!','W');
            }
        }, function(){
            nui.unmask(document.body);
        })
    }
}
function add(){
    // $("#servieIdEl").html("综合开单详情");
    // $("#carNoEl").html("");
    // //$("#wechatTag").css("color","#62b900");
    // $("#guestNameEl").html("");
    // $("#guestTelEl").html("");
    // $("#cardPackageEl").html("次卡套餐(0)");
    // $("#clubCardEl").html("会员卡(0)");
    // $("#creditEl").html("挂账:0");
    // $("#carHealthEl").html("车况:0");
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();


    //rpsPackageGrid.clearRows();
   // rpsItemGrid.clearRows();
    rpsPartGrid.clearRows();
    billForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    fguestId = 0;
    fcarId = 0;
    $("#servieIdEl").html("");
   /* document.getElementById("formIframe").contentWindow.doSetCardTimes([]);
    $("#servieIdEl").html("");
    $("#showCardTimesEl").html("次卡套餐(0)");
    $("#showCardEl").html("储值卡(0)");
    $("#showCarInfoEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");*/

}
function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){
 
        if(data.id){
            showMsg("保存成功!","S");

            var params = {
                data:{
                    guestId: data.guestId||0,
                    contactorId: data.contactorId||0
                }
            }
            getGuestContactorCar(params, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
                var contactor = text.contactor||{};
                if(errCode == 'S'){
                    $("#servieIdEl").html(data.serviceCode);
                    var carNo = data.carNo||"";
                    var tel = guest.mobile||"";
                    var guestName = guest.fullName||"";
                    var carVin = data.carVin||"";
                    if(tel){
                        tel = "/"+tel;
                    }
                    if(guestName){
                        guestName = "/"+guestName;
                    }
                    if(carVin){
                        carVin = "/"+carVin;
                    }
                    var t = carNo + tel + guestName + carVin;
                    searchNameEl.setValue(t);
                    searchNameEl.setEnabled(false);

                    data.guestFullName = guest.fullName;
                    data.guestMobile = guest.mobile;
                    data.contactorName = contactor.name;
                    data.mobile = contactor.mobile;

                    billForm.setData(data);

                    var p3 = {
                        interType: "part",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    loadDetail(p3);

                }else{
                    showMsg("数据加载失败,请重新打开工单!","W");
                }

            }, function(){});

            
            
        }
        
    },function(){ 
        nui.unmask(document.body);
    });
}
var requiredField = {
    carNo : "车牌号",
    guestId : "客户",
    /*serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问"*/
};
//?????????????
var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            unmaskcall && unmaskcall();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
    data.billTypeId = 2;
    data.serviceTypeId = 1 ;
    data.mtAdvisorId = currUserId;
    maintain.mtAdvisor = currUserName;
    var params = {
        data:{
            maintain:data
        }
    };
    svrSaveMaintain(params, function(text){
        var errCode = text.errCode||"";
        if(errCode == "S") {
            unmaskcall && unmaskcall();
            var main = text.data||{};
            fserviceId = main.id||0;
            callback && callback(main);
        } else {
            unmaskcall && unmaskcall();
            showMsg(data.errMsg || "保存单据失败","W");
        }
    }, function(){
        unmaskcall && unmaskcall();
    });
}
var loadMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function loadMaintain(callback,unmaskcall){
    var data = billForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            unmaskcall && unmaskcall();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
    data.billTypeId = 2;
    
    nui.ajax({
        url : saveMaintainUrl,
        type : "post",
        data : JSON.stringify({
            maintain : data,
            token : token
        }),
        success : function(data) {
            data = data || {};
            if (data.errCode == "S") {
                unmaskcall && unmaskcall();
                var main = data.data;
                fserviceId = main.id||0;
                callback && callback(main);
            } else {
                unmaskcall && unmaskcall();
                showMsg(data.errMsg || "保存单据失败","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            unmaskcall && unmaskcall();
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","E");
        return;
    }
    var type = data.type;
    var rtnRow = data.rtnRow||{};
    if(type == 0){
        if(rtnRow){
            var t = rtnRow.prdtType||0;
            var interType = "";
            if(t == 3){
                interType = "part";
            }
            if(!interType){
                showMsg("次卡类型有误!","W");
                return;
            }
            var data = {};
             if(interType == 'part'){
                var insPart = {
                    serviceId:main.id||0,
                    partId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0,
                    partCode:rtnRow.prdtCode
                };
                data.insPart = insPart;
                data.serviceId = main.id||0;
            }
            var params = {
                type:"insert",
                interType:interType,
                data:data
            };
            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){
    
                    var params = {
                        interType: interType,
                        data:{
                            serviceId: main.id||0
                        }
                    }
                    getBillDetail(params, function(text){
                        var errCode = text.errCode;
                        var data = text.data||[];
                        if(errCode == "S"){
                             if(interType == 'part'){
                                rpsPartGrid.clearRows();
                                rpsPartGrid.addRows(data);
                             }
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加预存信息失败!","W");
                    return;
                }
            });
        }else{
            showMsg("请选择记录!","W");
            return;
        }
    }else if(type == 3){
        var data = {};
        var insPart = {
            serviceId:main.id||0,
            partId:rtnRow.id,
            cardDetailId:0,
            partCode:rtnRow.code
        };
        data.insPart = insPart;
        data.serviceId = main.id||0;

        var params = {
            type:"insert",
            interType:'part',
            data:data
        };
        svrCRUD(params,function(text){
            var errCode = text.errCode||"";
            var errMsg = text.errMsg||"";
            if(errCode == 'S'){

                var params = {
                    interType: 'part',
                    data:{
                        serviceId: main.id||0
                    }
                }
                getBillDetail(params, function(text){
                    var errCode = text.errCode;
                    var data = text.data||[];
                    if(errCode == "S"){
                        rpsPartGrid.clearRows();
                        rpsPartGrid.addRows(data);
                    }
                }, function(){});
            }else{
                showMsg(errMsg||"添加预存信息失败!","W");
                return;
            }
        });
    }
}
function checkPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","E");
        return;
    }
    var type = data.type||-1;
    var rtnRow = data.rtnRow||{};
    if(type == 0){
        var prdtType = rtnRow.prdtType;
        var oldId = rtnRow.id;
        rtnRow.id = rtnRow.prdtId||0;
       if(prdtType == 3){
            var rs = checkFromBillPart(rtnRow);
            if(rs){
                return "此配件已经添加!";
            }
        }
        rtnRow.id = oldId;
    }else if(type == 3){
        var rs = checkFromBillPart(rtnRow);
        if(rs){
            return "此配件已经添加!";
        }
    }
}
/*function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}*/
/*function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}*/
function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}

function deletePartRow(row_uid){
   /* var data = rpsPartGrid.getData();
    var row = rpsPartGrid.getRowByUID(row_uid);
    if(data && data.length==1){
        row = data[0];
    }
    var part = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"part",
        data:{
            part: part
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            if(data && data.length==1){
                rpsPartGrid.removeRow(data[0]);
                //var newRow = {};
                //rpsPartGrid.addRow(newRow);
            }else{
                rpsPartGrid.removeRow(row);
            }
        }else{
            showMsg(errMsg||"删除配件信息失败!","W");
            return;
        }
    });*/
	
    var row = rpsPartGrid.getRowByUID(row_uid);
    rpsPartGrid.removeRow(row);


}


function addGuest(){
    doApplyCustomer({},function(adction){
        if("ok" == action)
        {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSaveData();
            var carNo = data.carNo||"";
            var mobile = data.mobile||"";
            var guestName = data.guestFullName||"";
            if(carNo){
                searchKeyEl.setValue(carNo);
                searchKeyEl.setText(carNo);
                searchKeyEl.doQuery();
                return;
            }
            if(mobile){
                searchKeyEl.setValue(mobile);
                searchKeyEl.setText(mobile);
                searchKeyEl.doQuery();
                return;
            }
            if(guestName){
                searchKeyEl.setValue(guestName);
                searchKeyEl.setText(guestName);
                searchKeyEl.doQuery();
                return;
            }

        }
    });
}
function onCloseClick(e){
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
    var row = rpsPackageGrid.getSelected();
    var newRow = {workerIds:"",workers:""};
    rpsPackageGrid.updateRow(row, newRow);

}
function onworkerChanged(e){
    var obj = e.sender;
    var rows = e.selecteds;
    var workerIds = "";
    var workerIdList = [];
    if(!rows || rows.length==0){
        workerIds = "";
    }else{
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var empId = row.empId;
            workerIdList.push(empId);
        }

        if(workerIdList&&workerIdList.length>0){
            workerIds = workerIdList.join(",");
        }else{
            workerIds = "";
        }
    }
   // var row = rpsPackageGrid.getSelected();
    var newRow = {workerIds:workerIds};
    __workerIds = workerIds;
}

function onpartsalemanChanged(e){
    var obj = e.sender;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    var row = rpsPartGrid.getSelected();
    //var newRow = {saleManId:saleManId};
    //rpsPartGrid.updateRow(row, newRow);
    __saleManId = saleManId;
}


function loadDetail(p3){
    if(p3 && p3.interType){
        getBillDetail(p3, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPartGrid.clearRows();
                rpsPartGrid.addRows(data);
                rpsPartGrid.accept();
            }
        }, function(){});
    }

}
var __workerIds="";
var __saleManId="";
function editRpsPart(row_uid){
    var row = rpsPartGrid.getRowByUID(row_uid);
    if (row) {
        __workerIds = "";
        __saleManId = "";
        rpsPartGrid.cancelEdit();
        rpsPartGrid.beginEditRow(row);
        /*if(!row.rate){
        	var rate = nui.get("MML");
        	//rate.setReadOnly(true);
        	//row.rate.cancel(true);
        }*/
    }
}
function updateRpsPart(row_uid){
    var rowc = rpsPartGrid.getRowByUID(row_uid);
    if (rowc) {
        rpsPartGrid.commitEdit();
        var rows = rpsPartGrid.getChanges();

        if(rows && rows.length>0){
            var row = rows[0];
            var serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            
            var updList = [];
            if(cardDetailId > 0){ //预存的
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.serviceTypeId = row.serviceTypeId;
                updList.push(part);
            }else{
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.qty = row.qty;
                part.subtotal = row.subtotal;
                part.serviceTypeId = row.serviceTypeId;
                if(__saleManId){
                    part.saleMan = row.saleMan;
                    part.saleManId = __saleManId;
                }
                updList.push(part);
            }
            var params = {
                type:"update",
                interType:"part",
                data:{
                    serviceId: serviceId,
                    updList : updList
                }
            };

            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    __workerIds = "";
                    __saleManId = "";
                    rpsPartGrid.accept();
                }else{
                    rpsPartGrid.accept();
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}

function checkFromBillPart(data){
    var partId= data.id;
    var rows = rpsPartGrid.findRows(function(row){
        if(row && row.partId == partId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}
//配件
function choosePart(){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
     if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加配件!","S");
        return;
    }

    nui.open({
		targetWindow : window,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.partSelectView.flow?token=" + token,
		title : "配件管理",
		width : 1300,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            iframe.contentWindow.setCkcallback(checkFromBillPart);
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            data = iframe.contentWindow.getData();
            data = data.part;
            //把该传的字段对应好
            var part = {};
            //获取客户信息
         //   var main = billForm.getData();
            
            part={
            	serviceId:main.id,
            	serviceTypeId:main.serviceTypeId,
            	partId:data.id,
            	packageId:0,
            	partCode:data.code,
            	partName:data.name,
            	partNameId:data.partNameId,
            	partBrandId:data.partBrandId,
            	qty:1,
            	unitPrice:0,
            	unit:data.unit,
            	amt:0,
            }
            rpsPartGrid.addRow(part);
			/*var p3 = {
					 interType: "part",
		        };
		        loadDetail(p3);*/
		}
	});
    
    
    /*doSelectPart(addToBillPart, delFromBillPart, checkFromBillPart, function(text){
       
        var p3 = {
			 interType: "part",
	         data:{
	             serviceId: main.id||0
	         }
        };
        loadDetail(p3);
    });*/
}
function addToBillPart(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var insPart = {
        serviceId:main.id||0,
        partId:row.id,
        cardDetailId:0
    };
    data.insPart = insPart;
    data.serviceId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'part',
        data:data
    };
    
    //关闭处理中
    unmaskcall && unmaskcall();
    //生成一行信息，
    callback && callback(row);
    
    /*params = {};
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加配件失败!","W");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });*/
}
function delFromBillPart(data, callback){
    var part = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"part",
        data:{
        	part: part
        }
    };
    /*svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除配件信息失败!","W");
            return;
        }
    });*/
}


function setyouhuilu(){
	var rate = nui.get("rate");
	rate.disable(false);
}



//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	} else {
		var newRow = {};
		if (e.field == "qty") {
			var qty = e.value;
			var unitPrice = record.unitPrice;

			if (e.value == null || e.value == '') {
				e.value = 1;
				qty = 1;
			} else if (e.value < 0) {
				e.value = 1;
				qty = 1;
			}

			var amt = qty * unitPrice;

			newRow = {
				amt : amt
			};
			rpsPartGrid.updateRow(e.row, newRow);

			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "unitPrice") {
			var qty = record.qty;
			var unitPrice = e.value;
			
			if (e.value == null || e.value == '') {
				e.value = 0;
				unitPrice = 0;
			} else if (e.value < 0) {
				e.value = 0;
				unitPrice = 0;
			}

			var amt = qty * unitPrice;

			newRow = {
				amt : amt
			};
			rpsPartGrid.updateRow(e.row, newRow);		

		} else if (e.field == "amt") {
			var qty = record.qty;
			var amt = e.value;

			if (e.value == null || e.value == '') {
				e.value = 0;
				amt = 0;
			} else if (e.value < 0) {
				e.value = 0;
				amt = 0;
			}

			// e.cellHtml = enterqty * enterprice;
			var unitPrice = amt * 1.0 / qty;


			if (qty) {
				newRow = {
					unitPrice : unitPrice
				};
				rpsPartGrid.updateRow(e.row, newRow);
			}
		} 		
	}
}




function onValueChangedQty(e){
	var row = rpsPartGrid.getSelected();
    var data ={};
    if(e.value == null ||e.value == '') {
       data.qty = 0;
    }
	var amt = null;
	if(row.unitPrice){
		amt = row.unitPrice * e.value;
		amt = parseFloat(amt).toFixed(2);
	}else{
		amt = 0;
	}	
	data.amt = amt;
	rpsPartGrid.updateRow(row,data);
	
}

function onValueChangedUnitPrice(e){
	var row = rpsPartGrid.getSelected();
	var amt = null;
	if(row.qty){
		amt = row.qty * e.value;
		amt = parseFloat(amt).toFixed(2);
	}else{
		amt = 0;
	}	
	data = {
			amt:amt
		 };
	rpsPartGrid.updateRow(row,data);
	
}

/*
 * 修改维修主表的信息
 * */
var SaveUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveAndUpdRpsPart.biz.ext";
var saveMaintain = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";

function saveBatch(){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(isSettle == 1){
        showMsg("此单已结算,不能修改!","S");
        return;
    }
	if(main.status==1){
		showMsg("此单已审核,不能修改!","S");
        return;
	} 
	//保存工单
	if(!main.id){
	 var data = billForm.getData();
		for ( var key in requiredField) {
			if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField[key] + "不能为空!","W");
				return;
			}
	    }
	    data.billTypeId = 2;
	    data.serviceTypeId = 1 ;
	    data.mtAdvisorId = currUserId;
	    data.mtAdvisor = currUserName;
	    var json = nui.encode({
			"maintain" : data,
			token : token
		});
	    
		nui.ajax({
			url : saveMaintain,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.errCode == "S") {
					showMsg("保存成功");
					data = returnJson.data;
					 var params = {
				                data:{
				                    guestId: data.guestId||0,
				                    contactorId: data.contactorId||0
				                }
				         }
					
					 getGuestContactorCar(params, function(text){
			                var errCode = text.errCode||"";
			                var guest = text.guest||{};
			                var contactor = text.contactor||{};
			                if(errCode == 'S'){
			                    $("#servieIdEl").html(data.serviceCode);
			                    var carNo = data.carNo||"";
			                    var tel = guest.mobile||"";
			                    var guestName = guest.fullName||"";
			                    var carVin = data.carVin||"";
			                    if(tel){
			                        tel = "/"+tel;
			                    }
			                    if(guestName){
			                        guestName = "/"+guestName;
			                    }
			                    if(carVin){
			                        carVin = "/"+carVin;
			                    }
			                    var t = carNo + tel + guestName + carVin;
			                    searchNameEl.setValue(t);
			                    searchNameEl.setEnabled(false);

			                    data.guestFullName = guest.fullName;
			                    data.guestMobile = guest.mobile;
			                    data.contactorName = contactor.name;
			                    data.mobile = contactor.mobile;

			                    billForm.setData(data);

			                }else{
			                    showMsg("数据加载失败,请重新打开工单!","W");
			                }

			            }, function(){});
								
				} else {
					showMsg(returnJson.errMsg);
				}
			}
		});
	    
	   	}else{
		
		var maintain = billForm.getData();
		var addSellPart = nui.get("rpsPartGrid").getData();
		var sellPartAdd = rpsPartGrid.getChanges("added");
		var sellPartUpdate = rpsPartGrid.getChanges("modified");
		var sellPartDelete = rpsPartGrid.getChanges("removed");
		maintain.partAmt = sumSell;
		var json = nui.encode({
			"maintain" : maintain,
			"addSellPart" : addSellPart,
			"sellPartAdd" : sellPartAdd,
			"sellPartUpdate" : sellPartUpdate,
			"sellPartDelete" : sellPartDelete,
			token : token
		});	
		nui.ajax({
			url : SaveUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.errCode == "S") {
					showMsg("保存成功");
													
				} else {
					showMsg(returnJson.errMsg);
				}
			}
		});

		
	}
}

//审核
var updUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updateMainStatus.biz.ext";
var b = null;
function finish(){
	
	var main = billForm.getData();
	if(b == 1){
		main.status = 1;
	}
    var isSettle = main.isSettle||0;
     if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能审核!","S");
        return;
    }
	if(main.status==1){
		showMsg("此单已审核,不能重复审核!","S");
        return;
	} 
	
	var json = nui.encode({
		"main" : main,
		token : token
	});
	
	nui.ajax({
		url : updUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				b = 1;
				showMsg("审核成功");
				
			} else {
				showMsg(returnJson.errMsg);
			}
				
		}
	});
}

var sumSell = null;
function onDrawSummaryCell(e){	
	  var rows = e.data;
	  if(e.field == "amt") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  sumSell += parseFloat(rows[i].amt);
		  }
	  } 
}
