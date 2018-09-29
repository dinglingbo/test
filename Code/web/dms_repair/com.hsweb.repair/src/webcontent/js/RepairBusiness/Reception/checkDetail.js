var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";


var mainGrid = null;  
var mid = null;  
var mtAdvisorIdEl = null;        
var searchKeyEl = null;            
var servieIdEl = null;        
var searchNameEl = null;  
var billForm = null; 

var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var mainGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCheckModelDetail.biz.ext";
var checkMainIdUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCheckModel.biz.ext";
var fserviceId = 0; 
var actionType = 'new'; 
var checkMainId = null;  
var checkMainName = null;
var mainParams = null;
var isShowSave = null;


$(document).ready(function ()   
{


    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    mid = nui.get("mid").value;
    billForm = new nui.Form("#billForm");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    servieIdEl = nui.get("servieIdEl");
    searchKeyEl = nui.get("search_key");
    searchNameEl = nui.get("search_name");
    checkMainId = nui.get("checkMainId");
    checkMainId.setUrl(checkMainIdUrl);
    checkMainName = nui.get("checkMainName");
    searchKeyEl.setUrl(guestInfoUrl);

    searchKeyEl.on("beforeload",function(e){
/*        if(fserviceId){
            e.cancel = true;
            return;
        }*/
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
    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });

    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
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
            //searchNameEl.setEnabled(false);

            doSetMainInfo(item);
        }

    });

    mainGrid.on("cellbeginedit",function(e){
        var record = e.record;
        var field = e.field;
        var value = e.value;
        var editor = e.editor;
        if(actionType == "view"){
            e.cancel = true;
        }else{

            if (field == "remark") {
                var id = null;
                if(checkMainId.enabled){
                    id = record.id;
                }else{
                    id = record.checkId;
                }
                var url = baseUrl + "com.hsapi.repair.baseData.query.queryCheckModelDetailContent.biz.ext?checkId=" + id;
                editor.setUrl(url);
            } 
        }
    });

    mainGrid.on("cellendedit",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row={status:0};
        var nrow={nostatus:0};
        var row2={status:1};
        var nrow2={nostatus:1};
        if(field == "status"){
            if(record.status == 1){
                mainGrid.updateRow(record,nrow);
            }else{
                mainGrid.updateRow(record,nrow2);
            }
        }
        if(field == "nostatus"){
            if(record.nostatus == 1){
                mainGrid.updateRow(record,row);
            }else{
                mainGrid.updateRow(record,row2);
            }
        }


    });

    mainGrid.on("load",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row2={status:1};
        var row3={nostatus:1};

        if(actionType == "new"){
            var row=mainGrid.findRow(function(row){
                mainGrid.updateRow(row,row2);
            });
        }else{
            var row=mainGrid.findRow(function(row){
                if(row.status == 0){

                    mainGrid.updateRow(row,row3);
                }
            });
        }


    });

});





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
                //searchKeyEl.doQuery();
                return;
            }
            if(mobile){
                searchKeyEl.setValue(mobile);
                searchKeyEl.setText(mobile);
                //searchKeyEl.doQuery();
                return;
            }
            if(guestName){
                searchKeyEl.setValue(guestName);
                searchKeyEl.setText(guestName);
                //searchKeyEl.doQuery();
                return;
            }

        }
    });
    // var title = "新增客户资料";
    // nui.open({
    //     url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
    //     title: title, width: 560, height: 570,
    //     onload: function () {
    //         var iframe = this.getIFrameEl();
    //         var params = {};
    //         iframe.contentWindow.setData(params);
    //     },
    //     ondestroy: function (action)
    //     {

    //     }
    // });
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
    maintain.billTypeId = 1;
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

}



/*
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
            };

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

                    var sk = document.getElementById("search_key");
                    sk.style.display = "none";
                    searchNameEl.setVisible(true);


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

            
            
        }
        
    },function(){ 
        nui.unmask(document.body);
    });
}
*/



function saveb(){

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveDetail();
//var rMain={};
        //nui.ajax({
        //url : baseUrl + "com.hsapi.repair.repairService.repairInterface.updateCheckMainStatus.biz.ext",
        //type : "post",
        //data : {
        //    rpsMain:rMain,
        //    token : token
        //},
        //success : function(data) {
         //   var dd = mainParams.id;
        //   saveDetail(dd,function(data){

         //   });

        //},
        //error : function(jqXHR, textStatus, errorThrown) {
        //}
    //});


}
/*
var requiredField = {
    carNo : "车牌号",
    guestId : "客户",
    serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问"
};
*/

/*
var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
//var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveCheckDetail.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData();


    data.billTypeId = 1;

    data.status = 0;

    var params = {
        data:{
            maintain:data
        }
    };
    svrSaveMaintain(params, function(text){
        var errCode = text.errCode||"";
        var mtain = text.data;

        if(errCode == "S") {

            unmaskcall && unmaskcall();  
            var main = text.data||{};
            fserviceId = main.id||0;
            saveDetail(mtain,function(data){
                actionType = 'edit';
                var rid = data.data.id; 
                nui.get("id").setValue(rid);
                $("#servieIdEl").html(data.data.serviceCode);
                mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                mainGrid.load({mainId:rid,token:token});
                nui.unmask(document.body);
            });
            showMsg("保存成功！","S");
        } else {
            unmaskcall && unmaskcall();
            showMsg(data.errMsg || "保存单据失败","W");
        }
    }, function(){
        unmaskcall && unmaskcall();
    });
    

}

*/

function saveDetail(){
    //var mainGrid = nui.get("mainGrid");
    var mdata = billForm.getData();
    mainGrid.commitEdit();
    var grid_all = mainGrid.getData(); //保存
    var gridData = [];
    var detailid = null;
    for(var i=0;i<grid_all.length;i++){
        var tem = {};

        tem.serviceId = mainParams.id;
        tem.mainId = checkMainId.value;
        tem.checkName = grid_all[i].checkName;
        tem.checkType = grid_all[i].checkType;
        tem.status = grid_all[i].status;
        tem.remark = grid_all[i].remark;

        if(actionType == "new"){
            tem.checkId = grid_all[i].id;
            tem.id = null;
        } else{
            tem.id = grid_all[i].id;;
        }
        gridData.push(tem);
    }
    var mainData = {};
    if(!mainParams.row){

    }else{

        mainData = {
            id:mainParams.row.id,
            enterKilometers:mdata.enterKilometers,
            lastKilometers:mdata.lastKilometers,
            lastPoint:mdata.lastPoint,
            checkMan:mdata.checkMan,
            checkPoint:mdata.checkPoint,

        };
        if(actionType == "new"){
            mainData.checkMainId = checkMainId.value;
            mainData.checkMainName = checkMainName.value;
        }
    }
    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.crud.saveCheckDetail.biz.ext",
        type : "post",
        data :{
            listall:gridData,
            token : token
        },
        success : function(data) {

            updateCheckMain(mainData);

            actionType = 'edit';
            var rid = mainParams.id; 
            nui.get("id").setValue(rid);
            $("#servieIdEl").html(data.data.serviceCode);
            mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
            mainGrid.load({mainId:rid,token:token});
            nui.unmask(document.body);
            checkMainId.setEnabled(false);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

}


function updateCheckMain(mData){

    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.repairInterface.updateCheckMainStatus.biz.ext",
        type : "post",
        data :{
            rpsMain:mData,
            token : token
        },
        success : function(data) {
            if(data.errCode == "S"){

                showMsg("数据保存成功!","S");
            }else{
                showMsg("数据保存成失败!","E");
            }
        }
    });
}

/*
function setAllData(){

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext",
        type:"post",
        data:{ 
            id:mid   
        },
        cache: false,
        success: function (text) {  
            if(text.list){ 
                var list = text.list[0];
                billForm.setData(list);

            }else{
                showMsg("数据加载失败,请重新打开工单!","W");
            }
        }
    });

    mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
    mainGrid.load({mainId:mid,token:token});
}
*/

function setInitData(params){
    //s$("#saveData").hide();
    mainParams = nui.clone(params);
    if(mainParams.actionType && mainParams.actionType == "view"){

        actionType = mainParams.actionType;
    }

    
    if(!params.id){
        //add();  
    }else{
        nui.mask({
            el: document.body,  
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        }); 

        var mparams = {   
            data: {
                id: params.id
            }
        };
        getMaintain(mparams, function(text){
            var errCode = text.errCode||"";
            var data = text.maintain||{};
            if(errCode == 'S'){
                var p = {
                    data:{
                        guestId: data.guestId||0,
                        contactorId: data.contactorId||0
                    }
                };
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

                        //$("#guestNameEl").html(guest.guestFullName);
                        //$("#showCarInfoEl").html(data.carNo);
                        //$("#guestTelEl").html(guest.mobile);

                        //fguestId = data.guestId||0;
                        //fcarId = data.carId||0;

                       // doSearchCardTimes(fguestId);
                        //doSearchMemCard(fguestId);
                        var temp = SearchCheckMain(params.id);
                        //data.checkMainId = temp.checkMainId;
                        data.enterKilometers = temp.enterKilometers;
                        data.lastKilometers = temp.lastKilometers;
                        data.lastPoint = temp.lastPoint;
                        data.checkMan = temp.checkMan;
                        data.checkPoint = temp.checkPoint;
                        billForm.setData(data);
                        if(actionType == "view"){
                            billForm.setEnabled(false);
                            $("#saveData").hide();
                        }
                        if(temp.checkMainName){
                            if(actionType != "view"){
                                actionType = 'edit';
                            }
                            nui.get("checkMainId").setText(temp.checkMainName);
                            checkMainId.setEnabled(false);
                            mainGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                            mainGrid.load({mainId:params.id,token:token});
                        }
                        nui.get("guestFullName").setEnabled(false);
                        nui.get("guestMobile").setEnabled(false);
                        nui.get("carNo").setEnabled(false);
                        

                    }else{
                        showMsg("数据加载失败,请重新打开工单!","W");
                    }
                    
                }, function(){}); 
            }else{ 
                showMsg('数据加载失败!','W');
            }   
        }, function(){     
            nui.unmask(document.body);  
        });
    }
}  



function ValueChanged(e) {
    var sdata = e.selected;
    checkMainName.setValue(sdata.name);
    mainGrid.setUrl(mainGridUrl);
    mainGrid.load({mainId:sdata.id,token:token});
}



function SearchCheckMain(sId) { 
    var  t = {};
    var pa ={
        serviceId:sId
    };
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.repairInterface.queryCheckMainbyServiceId.biz.ext",
        type:"post",
        async: false,
        data:{ 
            params:pa
        },
        cache: false,
        success: function (text) {  
            var te = text;
            if(text.list.length > 0){
                t = text.list[0];
            }
        }
    });
    return t;
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



function tprint(){

    var turl = "com.hsweb.print.checkCar.flow";
    var pa={
        baseUrl:baseUrl,
        serviceId:mainParams.id,
        token:token
    };

    nui.open({
        url: webBaseUrl + turl,
        title:"打印查车单",
        height:"100%",
        width:"100%",
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(pa);
        },
        ondestroy:function(action){
        }

    });
}


