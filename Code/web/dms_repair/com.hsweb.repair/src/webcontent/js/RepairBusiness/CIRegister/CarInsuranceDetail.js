/**
* Created by Administrator on 2018/4/25.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var detailGrid = null;

var mainListUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext";
var detailGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var insuranceInfoUrl = baseUrl + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgid+"&params/isDisabled=0";
var servieIdEl = null;
var searchNameEl = null; 
var searchKeyEl = null;
var mtAdvisorIdEl = null;
var mtAdvisorEl = null;
var insuranceComp = null;
var insuranceForm = null;
var saleManIds = null;
var fserviceId = 0;
var fguestId = 0;
var carCheckInfo = null;
var mainData = null;
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
    mtAdvisorEl = nui.get("mtAdvisor");
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
        var memArr = nui.clone(memList);
        saleManIds.setData(memArr);
    });

    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");


});

function ManChanged(e){
    var sel = e.selected;
    mtAdvisorEl.setValue(sel.empName);

}


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

/*function getMaintainById(id)
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
}*/

/*function loadDetailGridData(serviceId)
{
    detailGrid.load({
        serviceId:serviceId,
        token:token
    });
}*/

function insuranceChange(e){
    var selected = e.selected;
    nui.get("insureCompId").setValue(selected.id);
}
function saleManChange(e){
    var val = nui.get("saleManIds").text;
    nui.get("saleMans").setValue(val);
}


function searchMainData(tid){
    var val = null;
    nui.ajax({
        url:baseUrl + "com.hsapi.repair.repairService.insurance.QueryRpsInsuranceListById.biz.ext",
        tupe:"post",
        async:false, 
        data:{
            id:tid
        },
        success:function(text){
            if(text.errCode == "S"){
                val = text.list[0];
            }

        }

    });
    return val;
}


function setInitData(params){
    mainData= params;
    if(!params.id){
    	add();
    }else{
     nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
     var pid ={
        id:params.id
    };

    nui.ajax({
        url:mainListUrl,
        type:"post",
        data:{params:pid},
        success:function(text){
            var list = text.list;
            if (list.length == 1) {
                var ldata = list[0];
             var p = {
                data:{
                    guestId: ldata.guestId||0,
                    contactorId: ldata.contactorId||0
                }
            };
            getGuestContactorCar(p, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
                var contactor = text.contactor||{};
                if(errCode == 'S'){
                    $("#servieIdEl").html(ldata.serviceCode);
                    var carNo = ldata.carNo||"";
                    var tel = guest.mobile||"";
                    var guestName = guest.fullName||"";
                    var carVin = ldata.carVin||"";
                    fguestId = ldata.guestId;
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

                    $("#guestNameEl").html(ldata.guestName);
                    $("#guestCarEl").html(ldata.carNo);
                    $("#guestTelEl").html(ldata.mobile);
                    var sdata = {
                        id:ldata.id,
                        carNo:ldata.carNo,
                        carVin:ldata.carVin,
                        carId:ldata.carId,
                        guestMobile:ldata.mobile,
                        //contactName:item.contactName,
                        contactorId:ldata.contactorId,
                        guestId:ldata.guestId,
                        enterKilometers:ldata.enterKilometers,
                        guestFullName:ldata.guestName,
                        recordDate:ldata.recordDate,
                        mtAdvisorId:"",
                        insureCompId:ldata.insureCompId,
                        insureCompName:ldata.insureCompName,
                        saleMans:ldata.saleMans,
                        saleManIds:ldata.saleManIds,
                        date1:ldata.beginDate,
                        date2:ldata.endDate,
                        mtAdvisorId:ldata.mtAdvisorId,
                        mtAdvisor:ldata.mtAdvisor
                    };

            basicInfoForm.setData(sdata);
            insuranceForm.setData(sdata);
            detailGrid.load({serviceId:params.id,token:token});

            //if(ldata.status != 0 ){
                //$("#addBtn").hide();
                //$("#save").hide();
                //$("#pay").hide();
                //searchNameEl.setWidth("200px");
            //}
            if(ldata.settleTypeId == 1){
                $("#radio1").attr("checked", "checked");
            }
            if(ldata.settleTypeId == 2){
                $("#radio2").attr("checked", "checked");
            }
            if(ldata.settleTypeId == 3){
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
});


}
}

function add(){

	searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    $("#servieIdEl").html("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    insuranceForm.setData([]);
    basicInfoForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);

    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;

    $("#servieIdEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");
    detailGrid.setData([]);
    detailGrid.setData(detailData);
}

/*function delDetail(insuranceId)
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
}*/

/*function addDetail(customid)
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
}*/

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


/*function doSearchCardTimes(guestId)
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
        document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}*/

/*function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
        token:token,
        guestId:guestId
    },function(){
        var data = memCardGrid.getData();
        var len = data.length||0;
    });
}
*/
function saveData(e){
    var tid = nui.get("id").value;
    if(tid){
        var main = searchMainData(tid);
            if(main.status != 0){
            showMsg("该工单已转入预结算或已结算，不能再进行此操作！","W");
            return;
        }
    }
    var data1 = basicInfoForm.getData();
    var data2 = getData2();
    var gridData = detailGrid.getData();

    nui.ajax({
        url:baseUrl +"com.hsapi.repair.repairService.insurance.saveInsuranceMain.biz.ext",
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
    var tid = nui.get("id").value;
    if(!tid){
        showMsg("请先保存工单！","W");
        return;
    }
    var main = searchMainData(tid);
        if(main.status != 0){
        showMsg("该工单已转入预结算或已结算，不能再进行此操作！","W");
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





/*function doSearchCardTimes(guestId)
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
        document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}
*/
/*function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
        token:token,
        guestId:guestId
    },function(){
        var data = memCardGrid.getData();
        var len = data.length||0;
    });
}*/
/*function addGuest(){
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
*/

/*function SearchCheckMain(callback) {
    var data = basicInfoForm.getData();
    var  t = null;
    var ydata = {
        serviceId:data.id
    };
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
*/
/*function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
*/
/*
function newCheckMainMore() {
    var cNo = nui.get("carNo").value;
    var item={};
    item.id = "1103";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkMain.jsp?cNo="+cNo;
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);

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
}*/