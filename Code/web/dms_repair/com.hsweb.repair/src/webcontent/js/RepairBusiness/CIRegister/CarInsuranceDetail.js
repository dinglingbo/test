/**
* Created by Administrator on 2018/4/25.
*/
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
        e.cellHtml = rtn_comp_amt_sum.toFixed(2);
        e.cellStyle = "text-align:center";
    }

    if(column.field == "rtnGuestRate" ){  
        e.cellHtml = rtn_guest_amt_sum.toFixed(2);
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

function saveData(){
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
            showMsg("保存成功！","S");

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

