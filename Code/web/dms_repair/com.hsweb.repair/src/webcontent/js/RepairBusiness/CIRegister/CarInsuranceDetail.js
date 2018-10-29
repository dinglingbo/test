/**
* Created by Administrator on 2018/4/25.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var detailGrid = null;
var detailGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext"; 
var insuranceInfoUrl = baseUrl + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgid+"&params/isDisabled=0"; 
var servieIdEl = null;         
var searchNameEl = null;             
var searchKeyEl = null;    
var mtAdvisorIdEl = null; 
var insuranceComp = null; 
var insuranceForm = null; 
var saleManIds = null;
var fserviceId = 0;
 var fguestId = 0;
  var advancedCardTimesWin = null;
  var advancedMemCardWin = null;
  var carCheckInfo = null;
var detailData = [{insureTypeId:1,insureTypeName:"交强险"},{insureTypeId:2,insureTypeName:"商业险"},{insureTypeId:3,insureTypeName:"车船税"}];
$(document).ready(function ()  
{ 
    var yy = (new Date()).getFullYear();
    var mm = ((new Date()).getMonth() + 1);
    var dd = (new Date()).getDate();
    var db = yy + "-" + mm + "-" + dd; //本日
    basicInfoForm = new nui.Form("#basicInfoForm");
    insuranceForm = new nui.Form("#insuranceForm");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    saleManIds = nui.get("saleManIds");
    insuranceComp = nui.get("insureCompName");
    searchKeyEl = nui.get("search_key");   
    searchNameEl = nui.get("search_name"); 
    searchKeyEl = nui.get("search_key");
    //advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedCardTimesWin = nui.get("advancedCardTimesWin");
    //advancedPkgRateSetWin = nui.get("advancedPkgRateSetWin");
    //advancedItemPartRateSetWin = nui.get("advancedItemPartRateSetWin");
    advancedMemCardWin = nui.get("advancedMemCardWin");
        carCheckInfo = nui.get("carCheckInfo");

    searchKeyEl.setUrl(guestInfoUrl);
    insuranceComp.setUrl(insuranceInfoUrl);  
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
            var carModel = item.carModel||"";
            var sdata = {
                carNo:carNo,
                carVin:item.carVin,
                carId:item.carId,
                guestMobile:tel,
                contactName:item.contactName,
                contactorId:item.contactorId,
                guestId:item.guestId,
                enterKilometers:"",
                guestFullName:guestName,
                recordDate:db,
                mtAdvisorId:""
            };
            basicInfoForm.setData(sdata);
            
            if(tel){
                tel = "/"+tel;
            }
            if(guestName){
                guestName = "/"+guestName;
            }
            if(carVin){
                carVin = "/"+carVin;
            }            


            var sk = document.getElementById("search_key");
            sk.style.display = "none";
            searchNameEl.setVisible(true);
            var t = carNo + tel + guestName + carVin;
            searchNameEl.setValue(t);

        }
    });

    detailGrid = nui.get("detailGrid");
    detailGrid.setUrl(detailGridUrl);
    detailGrid.setData(detailData);
    detailGrid.on("drawcell",function(e){
        var field = e.field;
        var row = e.record;

    });

    
    detailGrid.on("cellcommitedit",function(e){
        var record = e.record;
        var value = e.value;
        var column = e.column;
        var field = e.field;  
        var editor = e.editor;
        if(column.field == "amt" ||column.field == "rtn_comp_amt" ||column.field == "rtn_guest_amt"){  
            editor.validate();  
            if (editor.isValid() == false) {
                showMsg("请输入有效数字！","W");
                e.cancel = true;
            }

        }
    });

    initMember("mtAdvisorId",function(){
        var memList = mtAdvisorIdEl.getData();
        saleManIds.setData(memList); 
    }); 

    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");


});


function drawSummaryCell(e){
    var data = e.data;
    var value = e.value;
    var column = e.column;
    var field = e.field;  
    var editor = e.editor;
    var rtn_comp_amt_sum = 0;
    var rtn_guest_amt_sum = 0;
    var amt = 0;
    var rtnCompRate = 0;
    var rtnGuestRate = 0;
    for (var i = 0; i < data.length; i++) {
        amt = data[i].amt || 0;
        rtnCompRate = data[i].rtnCompRate || 0;
        rtnGuestRate = data[i].rtnGuestRate || 0;
        rtn_comp_amt_sum +=(amt*rtnCompRate)/100;
        rtn_guest_amt_sum +=(amt*rtnGuestRate)/100;
    }
    if(column.field == "insureTypeName" ){  
        e.cellHtml = "合计";
        e.cellStyle = "text-align:center";
    }
    if(column.field == "amt" ){  
        e.cellHtml = value;
        e.cellStyle = "text-align:center";
    }

    if(column.field == "rtnCompRate" ){  
        e.cellHtml = rtn_comp_amt_sum.toFixed(4);
        e.cellStyle = "text-align:center";
    }

    if(column.field == "rtnGuestRate" ){  
        e.cellHtml = rtn_guest_amt_sum.toFixed(4);
        e.cellStyle = "text-align:center";
    }
}

function getMaintainById(id)
{
    var url = baseUrl+"com.hsapi.repair.repairService.insurance.getRpsInsuranceMainById.biz.ext";
    doPost({
        url : url,
        data : {
            params:{
                id:id,
                token:token
            }
        },
        success : function(data)
        {
            data = data||{};
            var main = data.main;
            basicInfoForm.setData(main);
            nui.get("guestId").setText(main.guestFullName);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.alert("网络出错，获取数据失败");
        }
    });
}

function loadDetailGridData(serviceId)
{
    detailGrid.load({
        serviceId:serviceId,
        token:token
    });
}

function insuranceChange(e){
    var selected = e.selected;
    nui.get("insureCompId").setValue(selected.id);
}
function saleManChange(e){
    var val = nui.get("saleManIds").text;
    nui.get("saleMans").setValue(val);
}



function setInitData(params){
    if(!params.id){
        return;
    }else{
       nui.mask({ 
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });

       var p = {
        data:{
            guestId: params.data.guestId||0,
            contactorId: params.data.contactorId||0
        }
    };
    getGuestContactorCar(p, function(text){
        var errCode = text.errCode||"";
        var guest = text.guest||{};
        var contactor = text.contactor||{};
        if(errCode == 'S'){
            $("#servieIdEl").html(params.data.serviceCode);
            var carNo = params.data.carNo||"";
            var tel = guest.mobile||"";
            var guestName = guest.fullName||"";
            var carVin = params.data.carVin||"";
            fguestId = params.data.guestId;
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

            $("#guestNameEl").html(params.data.guestName);
            $("#showCarInfoEl").html(params.data.carNo);
            $("#guestTelEl").html(params.data.mobile);
            var p1 = {
                interType: "package",
                data:{
                    serviceId: params.id||0
                }
            };
            var p2 = {
                interType: "item",
                data:{
                    serviceId: params.id||0
                }
            };
            var p3 = {
                interType: "part",
                data:{
                    serviceId: params.id||0
                }
            };
            //loadDetail(p1, p2, p3);
            var sdata = {
                id:params.data.id,
                carNo:params.data.carNo,
                carVin:params.data.carVin,
                carId:params.data.carId,
                guestMobile:params.data.mobile,
                //contactName:item.contactName,
                contactorId:params.data.contactorId,
                guestId:params.data.guestId,
                enterKilometers:params.data.enterKilometers,
                guestFullName:params.data.guestName,
                recordDate:params.data.recordDate,
                mtAdvisorId:"",
                insureCompId:params.data.insureCompId,
                insureCompName:params.data.insureCompName,
                saleMans:params.data.saleMans,
                saleManIds:params.data.saleManIds,
                date1:params.data.beginDate,
                date2:params.data.endDate
            };

            basicInfoForm.setData(sdata);
            insuranceForm.setData(sdata);
            detailGrid.load({serviceId:params.id,token:token});

            if(params.data.status != 0 ){
                $("#addBtn").hide();
                $("#save").hide();
                $("#pay").hide();
                searchNameEl.setWidth("200px");
            }
            if(params.data.settleTypeId == 1){
                $("#radio1").attr("checked", "checked"); 
            }
            if(params.data.settleTypeId == 2){
                $("#radio2").attr("checked", "checked"); 
            }
            if(params.data.settleTypeId == 3){
                $("#radio3").attr("checked", "checked"); 
            }

        }else{
            showMsg("数据加载失败,请重新打开工单!","W");
        }

    }, function(){
        nui.unmask(document.body);
    });
}
}


function delDetail(insuranceId)
{
    var main = basicInfoForm.getData();
    if(main.status != 0)
    {
        return;
    }
    var row = detailGrid.findRow(function(v){
        return v.insuranceId == insuranceId;
    });
    if(row)
    {
        detailGrid.removeRow(row);
    }
}

function addDetail(customid)
{
    var main = basicInfoForm.getData();
    if(main.status != 0)
    {
        return;
    }
    var old = detailGrid.findRow(function(v){
        return v.insuranceId == customid;
    });
    if(old)
    {
        return;
    }
    var row = {
        insuranceId:customid,
        dutyAmt:0,
        premium:0
    };
    detailGrid.addRow(row);
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


function showCardTimes(){
    if(!fguestId || advancedCardTimesWin.visible) {
        advancedCardTimesWin.hide();
        
        cardTimesGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("cardPackageEl");  
    advancedCardTimesWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedMemCardWin.hide();
    carCheckInfo.hide();
    memCardGrid.clearRows();

    doSearchCardTimes(fguestId);
}
function showCard(){
    if(!fguestId || advancedMemCardWin.visible) {
        advancedMemCardWin.hide();
        
        memCardGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("clubCardEl");  
    advancedMemCardWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedCardTimesWin.hide();
    carCheckInfo.hide();
    cardTimesGrid.clearRows();

    doSearchMemCard(fguestId);
}

function showCarCheckInfo(){
    if(!fguestId || carCheckInfo.visible) {
        advancedMemCardWin.hide();
        carCheckInfo.hide();
        advancedCardTimesWin.hide();
        return;
    }

    MemSelectCancel(1);
    SearchCheckMain(changeCheckInfoTab);
    advancedCardTimesWin.hide();
    advancedMemCardWin.hide();
}

/*function showHealth(){
    window.open("http://www.baidu.com?backurl="+window.location.href); 
}*/
function doSearchCardTimes(guestId)
{
    cardTimesGrid.clearRows();
    if(!guestId) return;

    var p = {};
    p.detailFinish = 0;  
    p.guestId = guestId;
    p.notPast = 1; 
    p.status = 2; 
    cardTimesGrid.load({
        token:token,
        p:p
    },function(){
        var data = cardTimesGrid.getData();
        var len = data.length||0;
        $("#showCardTimesEl").html("次卡套餐("+len+")");
        document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}
function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
        token:token,
        guestId:guestId
    },function(){
        var data = memCardGrid.getData();
        var len = data.length||0;
        $("#showCardEl").html("储值卡("+len+")");
    });
}

function saveData(e){
    var data1 = basicInfoForm.getData();
    var data2 = getData2();
    var gridData = detailGrid.getData();

    nui.ajax({
        url:"com.hsapi.repair.repairService.insurance.saveInsuranceMain.biz.ext",
        type:"post",
        async: false,
        data:{
            data1:data1,
            data2:data2,
            detailData:gridData
        },
        success:function(text){
            var mainData = text.mainData;
            nui.get("id").setValue(mainData.id);
            detailGrid.load({serviceId:mainData.id,token:token});
            if(e == 1){
                showMsg("保存成功！","S");
                $("#servieIdEl").html(mainData.serviceCode);
            }

        }

    });
}

function getData2() {
    var data2 = insuranceForm.getData();
    var b1= document.getElementsByName('settleTypeId');
    for (var i = 0; i < b1.length; i++) {
        if (b1[i].checked == true) {//如果选中，
            data2.settleTypeId = b1[i].value;
        }

    }
    return data2;
}


function pay() {
    if(!nui.get("id").value){
        showMsg("请先保存工单！","W");
        return;
    }
    var msg = null;
    var moneyCost = 0;
    var sTypeId = null;

    var data1 = basicInfoForm.getData();
    var data2 = getData2();
    var gridData = detailGrid.getData();
    var b1= document.getElementsByName('settleTypeId');
    for (var i = 0; i < b1.length; i++) {
        if (b1[i].checked == true) {//如果选中，
            sTypeId = b1[i].value;
        }
    }
    t_amt= detailGrid.getSummaryCellEl("amt").textContent;
    t_rtnCompRate= detailGrid.getSummaryCellEl("rtnCompRate").textContent;
    t_rtnGuestRate= detailGrid.getSummaryCellEl("rtnGuestRate").textContent;
    if (sTypeId == 3){
        moneyCost = t_amt - t_rtnGuestRate;
    }else{
        moneyCost = t_amt;
    }
    var params ={
        data1:data1,
        data2:data2,
        gridData:gridData,
        t_amt:t_amt,
        t_rtnCompRate:t_rtnCompRate,
        t_rtnGuestRate:t_rtnGuestRate,
        moneyCost:moneyCost,
        sTypeId:sTypeId
    };
    saveData(2);//转入结算和预结算都要保存
    nui.open({
        url: webBaseUrl + "repair/RepairBusiness/CIRegister/insuranceBillUp.jsp?token="+token,
        title:"结算",
        height:"300px",
        width:"600px",
        allowResize:false,
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(params);
        },
        ondestroy:function(action){ 
         if(action == "ok"){
            $("#addBtn").hide();
            $("#save").hide();
            $("#pay").hide();
        }

    }

});

}



function onPrint(argument) {
    var params={
        comp:"",
        baseUrl:baseUrl,
        serviceId:nui.get("id").value,
        token:token
    };
    nui.open({
        url: webBaseUrl + "repair/RepairBusiness/Reception/insurnacePrint.jsp?token="+token,
        title:"打印",
        height:"100%",
        width:"100%",
        allowResize:false,
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(params);
        },
        ondestroy:function(action){ 

        }

    });
}

function showCardTimes(){
    if(!fguestId || advancedCardTimesWin.visible) {
        advancedCardTimesWin.hide();
        
        cardTimesGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("cardPackageEl");  
    advancedCardTimesWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedMemCardWin.hide();
    carCheckInfo.hide();
    memCardGrid.clearRows();

    doSearchCardTimes(fguestId);
}
function showCard(){
    if(!fguestId || advancedMemCardWin.visible) {
        advancedMemCardWin.hide();
        
        memCardGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("clubCardEl");  
    advancedMemCardWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedCardTimesWin.hide();
    carCheckInfo.hide();
    cardTimesGrid.clearRows();

    doSearchMemCard(fguestId);
}


function showCarCheckInfo(){
    if(!fguestId || carCheckInfo.visible) {
        advancedMemCardWin.hide();
        carCheckInfo.hide();
        advancedCardTimesWin.hide();
        return;
    }

    MemSelectCancel(1);
    SearchCheckMain(changeCheckInfoTab);
    advancedCardTimesWin.hide();
    advancedMemCardWin.hide();
}

/*function showHealth(){
    window.open("http://www.baidu.com?backurl="+window.location.href); 
}*/
function doSearchCardTimes(guestId)
{
    cardTimesGrid.clearRows();
    if(!guestId) return;

    var p = {};
    p.detailFinish = 0;  
    p.guestId = guestId;
    p.notPast = 1; 
    p.status = 2; 
    cardTimesGrid.load({
        token:token,
        p:p
    },function(){
        var data = cardTimesGrid.getData();
        var len = data.length||0;
        $("#showCardTimesEl").html("次卡套餐("+len+")");
        document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}
function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
        token:token,
        guestId:guestId
    },function(){
        var data = memCardGrid.getData();
        var len = data.length||0;
        $("#showCardEl").html("储值卡("+len+")");
    });
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
/*function loadDetail(p1, p2, p3){
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
            }
        }, function(){});
    }
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
            }
        }, function(){});
    }
}
*/
function newCheckMain() {  
    var data = basicInfoForm.getData();
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp";
    item.iconCls = "fa fa-cog";
    //window.parent.activeTab(item);
    var params = {};
    params = { 
        id:data.id,
        actionType:"",
        row: rdata
    };

    window.parent.activeTabAndInit(item,params);
    carCheckInfo.hide();
}  


function MemSelectOk(){ 
    var form = new nui.Form("#show2");
            form.validate();
            if (form.isValid() == false) {
                showMsg("请先选择被派工人！","W");
                return;
            }
    SaveCheckMain();
}

function SearchCheckMain(callback) {
    var data = basicInfoForm.getData();
    var  t = null;
    var ydata = {
        serviceId:data.id
    }
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.repairInterface.queryCheckMainbyServiceId.biz.ext",
        type:"post",
        async: false,
        data:{ 
            params:ydata
        },
        cache: false,
        success: function (text) {  
            callback && callback(text);
            checkMainData = text;
            isRecord = text.isRecord;
        }
    });

}


function changeCheckInfoTab(resultdata) {

    var data = basicInfoForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","E");
        return;
    }
    var atEl = document.getElementById("carHealthEl");  
    carCheckInfo.showAtEl(atEl, {xAlign:"left",yAlign:"below"});
    SearchLastCheckMain();

    $("#checkStatus1").css("color","#9e9e9e");
    $("#checkStatus2").css("color","#9e9e9e");
    $("#checkStatus3").css("color","#9e9e9e");
    $("#checkStatus4").css("color","#9e9e9e");
    
    if(resultdata.list.length > 0){
        var detailList =  resultdata.list[0];
        rdata= detailList;
    }

    //detailList.checkMan  =1;
    //detailList.checkStatus = 0;

    if(resultdata.list.length < 1){
        $("#checkStatus1").css("color","#32b400");
        $("#checkStatusButton1").show();
        $("#checkStatusButton2").hide();
    }else{
        if((detailList.checkMan || detailList.checkManId)&& detailList.checkStatus == 0){
            $("#checkStatus2").css("color","#32b400");
            $("#checkStatusButton1").hide(); 
            $("#checkStatusButton2").show();

        }
        if((detailList.checkMan || detailList.checkManId) && detailList.checkStatus == 1){
            $("#checkStatus3").css("color","#32b400");
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show();
        }
        if((detailList.checkMan || detailList.checkManId) && detailList.checkStatus == 2){ 
            $("#checkStatus4").css("color","#32b400");   
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show(); 
        }
    }
}

function SaveCheckMain() {
    var data = basicInfoForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","E");
        return;
    }
    if(isRecord == "0"){
    var temp ={
        serviceId:data.id, 
        carId:data.carId,
        carNo:data.carNo,
        checkStatus:0,
        enterKilometers:data.enterKilometers,
        mtAdvisorId:data.mtAdvisorId,
        mtAdvisor:data.mtAdvisor,
        checkManId:nui.get("checkManId").value,
        checkMan:nui.get("checkManId").text
    };
    var mtemp = {
        id:data.id
    } ;

    nui.ajax({
        url:baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMain.biz.ext",
        type:"post",
        async: false,
        data:{ 
            data:temp,
            rpsMain:mtemp,
            token:token   
        },   
        success:function(text){   
            var errCode = text.errCode;
            if(errCode == "S"){
                rdata  = text.mainData;
                //newCheckMain();
                //CloseWindow('close');
                carCheckInfo.hide();
                showMsg('派工成功!','S'); 
            }else{
                //showMsg('保存失败!','E'); 
            }
        }  
    }); 
    }else{
        newCheckMain();
        carCheckInfo.hide();
}
}


function MemSelectCancel(e) {
    if(e == 1){
        $("#show1").show();
        $("#show2").hide();
    }

    if(e == 2){
        $("#show1").hide();
        $("#show2").show();
    }
}


    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }


function SearchLastCheckMain() { 

    $("#lastCheckInfo1").html('');
    $("#lastCheckInfo2").html('');
    $("#lastCheckInfo3").html("");
    $("#lastCheckInfo4").hide();

    var  tempParams = {
        carNo:nui.get("carNo").value,
        endDate:nui.get("recordDate").text
    };
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.repairInterface.QueryLastCheckMain.biz.ext",
        type:"post",
        //async: false,
        data:{ 
            params:tempParams
        },
        cache: false,
        success: function (text) {  
            
            var isRec = text.isRecord;
            if(isRec == "1"){
                var ldata = text.list[0];
                var score = ldata.check_point || 0;
                var rdate = nui.formatDate(nui.parseDate(ldata.record_date),"yyyy-MM-dd HH:mm:ss")

                $("#lastCheckInfo1").html('上次检查');
                $("#lastCheckInfo2").html(score+"分");
                $("#lastCheckInfo3").html(rdate);
                $("#lastCheckInfo4").show();
            }else{
                $("#lastCheckInfo1").html('暂无相关历史检查数据！');
            }

        }
    });
 
}

function newCheckMainMore() {  
    var cNo = nui.get("carNo").value;
    var item={};
    item.id = "1103";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkMain.jsp?cNo="+cNo;
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);

}  

function showHealth(){
    showCarCheckInfo();
    //window.open(webBaseUrl+"repair/RepairBusiness/Reception/checkDetail.jsp")
    /*nui.open({
        url: webBaseUrl+"repair/RepairBusiness/Reception/checkDetail.jsp",
        width: "800",
        height: "1000",
        showMaxButton: false,
        allowResize: false,
        showHeader: true,
        onload: function() {
            var iframe = this.getIFrameEl();
        },
    });*/
}

function showBillInfo(){
    var main = basicInfoForm.getData();
    var params = {
        carId : main.carId,
        guestId : main.guestId
    };
    if(main.id){
        doShowCarInfo(params);
    }
}