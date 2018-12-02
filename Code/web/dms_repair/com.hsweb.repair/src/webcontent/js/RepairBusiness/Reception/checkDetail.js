var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";

 
var mainGrid = null;
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
var mainParams = {};
var isShowSave = null;
var checkTypeList=[];
var  fguestId =null;
var lastUrl=baseUrl+"com.hsapi.repair.baseData.query.queryLastCheckModel.biz.ext";
$(document).ready(function ()
{

	mainParams.isCheckMain ="Y";
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
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
    
    var dictDefs ={"checkTypeA":"10081"};
    initDicts(dictDefs, function(e){
    	checkTypeList=nui.get('checkTypeA').getData(); 
//    	nui.get('checkType').setData(checkTypeList);
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
        var row={status:-1};
        var nrow={nostatus:-1};
        var row2={status:1};
        var nrow2={nostatus:1};
        
        var row3={settleType:0};
        var nrow3 ={nosettleType :0};
        var row4={settleType:1};
        var nrow4 ={nosettleType :1};
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
        if(field == "settleType"){
            if(record.settleType == 1){
                mainGrid.updateRow(record,nrow3);
            }else{
                mainGrid.updateRow(record,nrow4);
            }
        }
        
        if(field == "nosettleType"){
            if(record.nosettleType == 1){
                mainGrid.updateRow(record,row3);
            }else{
                mainGrid.updateRow(record,row4);
            }
        }


    });

    mainGrid.on("load",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row2={settleType:1};
        var row3={nostatus:1};
        var row4={nosettleType:1};
        if(actionType == "new"){
            var row=mainGrid.findRow(function(row){
                mainGrid.updateRow(row,row2);
            });
        }else{
            var row=mainGrid.findRow(function(row){
                if(row.status == -1){

                   mainGrid.updateRow(row,row3);
                }
                if(row.settleType == 0){

                    mainGrid.updateRow(row,row4);
                }
            });
        }


    });
    
    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");


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
    lastCheckModel();

}



function ValueChanged(e) {
    var sdata = e.selected;
    checkMainName.setValue(sdata.name);
    mainGrid.setUrl(mainGridUrl);
    mainGrid.load({mainId:sdata.id,token:token});
}

function newCheckMainMore(){
    var cNo = nui.get("carNo").value;
    var item={};
    item.id = "2085";
    item.text = "检查开单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkMain.jsp";
    item.iconCls = "fa fa-cog";
    var params={
    		carNo:cNo
    };
    window.parent.activeTabAndInit(item,params);
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

////////////////////////////////////////////////////////////////////////////////////

function setInitData(params){
	mainParams = nui.clone(params);
	if(!params.id){
    	addNew();
    }else{
	    if(mainParams.isCheckMain == "Y"){
	        isCheckMainY();
	    }else{
	        isCheckMainN();
	    }   
}
}

function isCheckMainY(){
    if(mainParams.actionType == "new"){
        $("#history").hide();
        addNew();
    }else{
        var temp = SearchCheckMain(mainParams.id);
        var p = {
            data:{
                guestId: temp.guestId||0,
                contactorId: temp.contactorId||0
            }
        };

        getGuestContactorCar(p, function(text){
            var errCode = text.errCode||"";
            var guest = text.guest||{};
            var contactor = text.contactor||{};
            if(errCode == 'S'){
                $("#servieIdEl").html(temp.serviceCode);
                var carNo = temp.carNo||"";
                var tel = guest.mobile||"";
                var guestName = guest.fullName||"";
                var carVin = temp.carVin||"";
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

                temp.guestFullName = guest.fullName;
                temp.guestMobile = guest.mobile;
                temp.contactorName = contactor.name;
                temp.mobile = contactor.mobile;
                billForm.setData(temp);
                fguestId=temp.guestId;
                if(!temp.lastKilometers ||!temp.lastPoint){
                	
                	lastCheckModel();
                }
                
                if(mainParams.actionType == "view"){
                    billForm.setEnabled(false);
                    $("#saveData").hide();
                    $("#addBtn").hide();
                    mainGrid.setReadOnly(true);
                }
                if(temp.checkMainName){
                    if(actionType != "view"){
                        actionType = 'edit';
                    }
                    nui.get("checkMainId").setText(temp.checkMainName);
                    checkMainId.setEnabled(false);
                    mainGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                    mainGrid.load({mainId:mainParams.id,token:token});
                  
                    
                }
            }
        });
    }
}


function isCheckMainN(){
//    nui.get("checkMan").disable();
    //$("#addBtn").hide();
    $("#history").show();
    //$("#onPrint").hide();
    var mparams = {
        data: {
            id: mainParams.id
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

                    var temp = SearchCheckMain(mainParams.id);
                    mainParams.cmId = temp.id;//保存的时候用到
                    data.guestFullName = guest.fullName;
                    data.guestMobile = guest.mobile;
                    data.contactorName = contactor.name;
                    data.mobile = contactor.mobile;
                    data.enterKilometers = temp.enterKilometers;
                    data.lastKilometers = temp.lastKilometers;
                    data.lastPoint = temp.lastPoint;
                    data.checkMan = temp.checkMan;
                    data.checkPoint = temp.checkPoint;
                    data.isFinish =temp.isFinish;
                    data.checkStatus=temp.checkStatus;
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
                        mainGrid.load({mainId:mainParams.row.id,token:token});
                    }else{
                    	checkMainId.setEnabled(true);
                    	mainGrid.setData(null);
                    }
                }

            });
        }
    });
    
}

function SearchCheckMain(sId) {
    var  t = {};
    var pa = null;

    if(mainParams.isCheckMain == "Y"){
        pa ={
            id:sId
        };
    }else{
        pa ={
            serviceId:sId
        };
    }

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

var requiredField={
	enterKilometers :"本次里程",
	mtAdvisorId    	:"服务顾问"
};

function saveb(){
	
	var data=billForm.getData();
	billForm.validate();
	if(billForm.isValid()==false){
		showMsg("请正确填写本次里程！","W");
		return;
	}
	
	if(!(nui.get('guestFullName').value) && !(nui.get('search_name').value)){
		showMsg("请先添加客户","W");
		return;
	}
	
    if(!(nui.get("checkMainId").value||nui.get("checkMainId").text)){
        showMsg("请先选择模板!","W");
        return;
    }
    
    for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg("请填写"+requiredField[key] + "!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
    if(data.isFinish==1 || data.checkStatus==1){
    	showMsg("本单已完成，不能再修改!","W");
    	return;
    }
    
    
    if(mainParams.isCheckMain == "Y"){
        saveCheckMain();
    }else if(mainParams.isCheckMain == "N"){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
        saveDetail();
    }else{
    	saveCheckMain();
    }

}


function saveDetail(){ //√  isCheckMain == "N"
    //var mainGrid = nui.get("mainGrid");
    var mdata = billForm.getData();
    mainGrid.commitEdit();
    var grid_all = mainGrid.getData(); //保存
    var gridData = [];
    var detailid = null;
    for(var i=0;i<grid_all.length;i++){
        var tem = {};

        tem.serviceId = mainParams.id;
        tem.mainId = mainParams.row.id;
        tem.checkName = grid_all[i].checkName;
        tem.checkType = grid_all[i].checkType;
        tem.checkRemark=grid_all[i].checkRemark;
        tem.status = grid_all[i].status;
        tem.settleType=grid_all[i].settleType;
        tem.remark = grid_all[i].remark;
        tem.careDueMileage=grid_all[i].careDueMileage;
        tem.careDueDate=grid_all[i].careDueDate;

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
            mainId :gridData[0].mainId, //主表Id
            token : token
        },
        success : function(data) {

            updateCheckMain(mainData);

            actionType = 'edit'; 
            nui.get("id").setValue(mainParams.cmId);
            $("#servieIdEl").html(data.data.serviceCode);
            mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
            mainGrid.load({mainId:mainParams.row.id,token:token});
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
        async: false,
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


function saveCheckMain(){//isCheckMain == "Y"
	var gridData=mainGrid.getData();
	var rex=/^\d+(\.\d+)?$/
	  
	for(var i=0;i<gridData.length;i++){
		if(gridData[i].settleType==0){
			 var careDueMileage=gridData[i].careDueMileage;
    	     if(!rex.test(careDueMileage)){
	    		  showMsg("请正确填写下次里程","W");
	    		  return;
    	     }  
			if(!gridData[i].careDueMileage){
				showMsg("项目 "+gridData[i].checkName+" 请填写下次保养里程","W");
				return;
			}
			if(!gridData[i].careDueDate){
				showMsg("项目 "+gridData[i].checkName+" 请填写下次保养时间","W");
				return;
			}
		}
	}
    var mdata = billForm.getData();
    mdata.checkPoint=100;
    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMainA.biz.ext",
        type : "post",
        data : {
            data:mdata,
            token : token
        },
        success : function(data) {
            if(data.errCode == "S"){
                var mainData = data.mainData;
                nui.get("id").setValue(mainData.id);
                billForm.setData(mainData);
                $("#servieIdEl").html(mainData.serviceCode);
                saveDetailB();
            }else{
                showMsg(data.errMsg,"E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        }
    });

}

function finish(){
	
	var data = billForm.getData();
	if(data.isFinish != 1){		
		saveDetailB();
	}
	if(data.isFinish ==1){
		showMsg("本单已完成，不能再修改！","W");
		return;
	}
	if(!data.id){
		showMsg('请先保存查车开单!',"W");
		return;
	}
	nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMainA.biz.ext",
        type : "post",
        data : {
            data:data,
            isFinish :1,
            token : token
        },
        success : function(data) {
            if(data.errCode == "S"){
                var mainData = data.mainData;
                nui.get("id").setValue(mainData.id);
                billForm.setData(mainData);
                $("#servieIdEl").html(mainData.serviceCode);
                showMsg("保存成功","S");
            }else{
                showMsg(data.errMsg,"E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        }
    });
}
function saveDetailB(){
    var grid_all = mainGrid.getData(); //保存
    var gridData = [];
    var mmid = nui.get("id").value;
    for(var i=0;i<grid_all.length;i++){
        var tem = {};

        tem.serviceId = '';
        tem.mainId = mmid;
        tem.checkName = grid_all[i].checkName;
        tem.checkType = grid_all[i].checkType;
        tem.checkRemark=grid_all[i].checkRemark;
        tem.status = grid_all[i].status;
        tem.settleType=grid_all[i].settleType;
        tem.remark = grid_all[i].remark;
        tem.careDueMileage=grid_all[i].careDueMileage;
        tem.careDueDate=grid_all[i].careDueDate;

        if(actionType == "new"){
            tem.checkId = grid_all[i].id;
            tem.id = null;
        } else{
            tem.id = grid_all[i].id;
        }
        gridData.push(tem);
    }
    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.crud.saveCheckDetail.biz.ext",
        type : "post",
        data :{
            listall:gridData,
            mainId : gridData[0].mainId,
            token : token
        },
        success : function(data) {
            if(data.errCode == "S"){
                actionType = 'edit';
                mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                mainGrid.load({mainId:mmid,token:token});
                nui.unmask(document.body);
                checkMainId.setEnabled(false);
                showMsg("保存成功!","S");
            }
            else{
            	showMsg(data.errMsg,"E");
            	return;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}


function addNew(){
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    $("#servieIdEl").html("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
    billForm.setData([]);
    mainGrid.setData([]);
    nui.get('checkMainId').setEnabled(true);
    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;
    actionType = 'new';

}

function onCellCommitEdit(e){
	var editor = e.editor;
	var record = e.record;
	var row = e.row;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	}else{
		if (e.field == "careDueMileage") {
			var careDueMileage = e.value;
			if (e.value == null || e.value == '') {
				e.value = 0;
				careDueMileage = 0;
			} else if (e.value < 0) {
				e.value = 0;
				careDueMileage = 0;
			}
		}
		
	}
}
function lastCheckModel(){
	var fromData=billForm.getData();
	var params={};
	params.guestId=fguestId;

    nui.ajax({
        url : lastUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var data = data.data;
            fromData.lastChekDate=data[0].checkDate;
            fromData.lastKilometers=data[0].enterKilometers;
            fromData.lastPoint=data[0].checkPoint;
            billForm.setData(fromData);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

	
}