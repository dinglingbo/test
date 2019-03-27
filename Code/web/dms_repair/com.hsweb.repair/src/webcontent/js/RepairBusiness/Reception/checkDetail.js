var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";

 
var mainGrid = null;
var checkManIdEl = null;  
var searchKeyEl = null; 
var servieIdEl = null;
var searchNameEl = null;
var billForm = null;
var sellGuest =null;
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
    checkManIdEl = nui.get("checkManId");
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
        params.isDisabled = 0;
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
    initMember("checkManId",function(){
        memList = checkManIdEl.getData();
    });

    checkManIdEl.on("valueChanged",function(e){
        var text = checkManIdEl.getText();
        nui.get("checkMan").setValue(text);
    });

    searchKeyEl.on("valuechanged",function(e){
        var item = e.selected;
        if(fserviceId){
            return;
        }
        if (item) {
       	   if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
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
        }

    });
    
    
    searchKeyEl.on("itemclick",function(e){
    	 var item = e.item;
         if(fserviceId){
             return;
         }
         if (item) {
        	 if(item.guestMobile == "10000"){
         		addOrEdit(item);
         	}else{
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
		         sellGuest = item;
           }
         }
     });
    
    
    
    
    
//    mainGrid.on("drawcell",function(e){
//        switch (e.field)
//        {
//            case "remark":
//                e.value="";
//                break;
//            case "checkRemark" :
//            	e.value=e.record.remark;
//            default:
//                break;
//        }
//
//    });

    mainGrid.on("cellbeginedit",function(e){
        var record = e.record;
        var remark=e.record.remark;
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
//            if(field =="checkRemark"){
//            	e.value=remark;
//            }
        }
    });

    mainGrid.on("cellendedit",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row={status:-1,nosettleType :1,settleType :1};
        var nrow={status:1,nostatus:-1,nosettleType :0,settleType:-1};
        var row2={status:0,nosettleType :0,settleType :-1};
        var nrow2={status:0,settleType :-1};
        
        var row3={status:-1,nostatus:1,settleType:1};
        var nrow3 ={status:-1,nostatus:1,nosettleType :0};
        var row4={status:-1,nostatus:1,settleType:0};
        var nrow4 ={status:-1,nostatus:1,nosettleType :1};
        var nrow5 ={status:1,settleType :-1 ,nosettleType :0}
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
        	if(record.status!=1){
	            if(record.settleType == 0 ){
	                mainGrid.updateRow(record,nrow3);
	            }else{
	                mainGrid.updateRow(record,nrow4);
	            }
        	}else{
        		mainGrid.updateRow(record,nrow5);
        	}
        }
        
        if(field == "nosettleType"){
        	if( record.status!=1){
	            if(record.nosettleType == 1 &&  record.status!=1){
	                mainGrid.updateRow(record,row3);
	            }else{
	                mainGrid.updateRow(record,row4);
	            }
        	}else{
        		mainGrid.updateRow(record,nrow5);
        	}
        }


    });

    mainGrid.on("load",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row2={status:0,settleType:-1};
        var row3={nostatus:1};
        var row4={nosettleType:1};
        var row5={settleType :0};
        if(actionType == "new"){
            var row=mainGrid.findRow(function(row){
                mainGrid.updateRow(row,row2);
            });
        }else{
            var row=mainGrid.findRow(function(row){
                if(row.status == -1){
                   mainGrid.updateRow(row,row3);
                   if(row.settleType == 0){
                      mainGrid.updateRow(row,row5);
                   }else{
                	   mainGrid.updateRow(row,row4);
                   }
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
    var maintain = billForm.getData(true);
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
    maintain.checkManId = currEmpId;
    maintain.checkMan = currUserName;
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
    
    nui.ajax({
        url: mainGridUrl,
        type:"post",
        async: false,
        data:{
        	mainId:sdata.id,
        	token:token
        },
        cache: false,
        success: function (text) {
            var list = text.list;
            if(list && list.length>0){
            	for(var i=0;i<list.length;i++){
            		list[i].checkRemark=list[i].remark;
            		list[i].remark=null;
            	}
            }
        	mainGrid.clearRows();
        	mainGrid.setData(list);
        	if(list.length==0){
        		showMsg("该检查模板无检查项目,请添加检查项目","W");
        		nui.get('checkMainId').setValue("");
        		nui.get('checkMainId').setText("");
        		return;
        	}
        }
    });
    
   
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
	
	var mainId= nui.get('id').value;
    var turl = "com.hsweb.print.checkCar.flow";
    var pa={
        baseUrl:baseUrl,
        mainId:mainId,
        currCompLogoPath: currCompLogoPath,
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
                contactorId: temp.contactorId||0,
                carId:temp.carId || 0,
            }
        };

        getGuestContactorCar(p, function(text){
            var errCode = text.errCode||"";
            var guest = text.guest||{};
            sellGuest = guest;
            var contactor = text.contactor||{};
            var car = text.car||{};
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
                if(mainParams.viewType){
                    temp.lastKilometers = mainParams.lastKilometers||0;
                    temp.enterKilometers = mainParams.enterKilometers || 0;
                    temp.mtdvisor = mainParams.mtdvisor;
                    temp.mtdvisorId = mainParams.mtdvisorId;
                }else if(mainParams.isCheckMain == "N"){
                temp.lastKilometers = mainParams.mainFormData.lastKilometers||0;
                temp.enterKilometers = mainParams.mainFormData.enterKilometers || 0;
                temp.mtdvisor = nui.get("mtdvisor").value;
                temp.mtdvisorId = nui.get("mtdvisorId").value;
                }else{
                temp.mtdvisor = nui.get("mtdvisor").value;
                temp.mtdvisorId = nui.get("mtdvisorId").value;
                }
                temp.guestFullName = guest.fullName;
                temp.guestMobile = guest.mobile;
                temp.contactorName = contactor.name;
                temp.mobile = contactor.mobile;
                temp.carModel = car.carModel;
                billForm.setData(temp);
               
                fguestId=temp.guestId;
//                if(!temp.lastKilometers && !temp.serviceId){
//                	
//                	lastCheckModel();
//                }
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
                    contactorId: data.contactorId||0,
                    carId:data.carId || 0, 
                }
            };
            getGuestContactorCar(p, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
                var contactor = text.contactor||{};
                var car = text.car||{};
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
                    data.carModel = car.carModel;
                    data.enterKilometers = temp.enterKilometers;
                    data.lastKilometers = temp.lastKilometers;
                    data.lastPoint = temp.lastPoint;
                    data.checkMan = temp.checkMan;
                    data.checkManId = temp.checkManId;
                    data.checkPoint = temp.checkPoint;
                    data.isFinish =temp.isFinish;
                    data.checkStatus=temp.checkStatus;
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
                t.carModel = text.car.carModel;
            }
        }
    });
    return t;
}

var requiredField={
	enterKilometers :"本次里程",
	checkManId    	:"查车人"
};

function saveb(){
	
	var data=billForm.getData(true);
	billForm.validate();
	if(billForm.isValid()==false){
		showMsg("请正确填写本次里程！","W");
		return;
	}
	
	var lastKilometers =parseFloat(data.lastKilometers || 0);
	var enterKilometers = parseFloat(data.enterKilometers||0);
	if(enterKilometers <lastKilometers){
		showMsg("本次里程不能小于上次里程","W");
		return;
	}
	if(!(nui.get('search_name').value)){
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
    var mdata = billForm.getData(true);
    mainGrid.commitEdit();
    var grid_all = mainGrid.getData(true); //保存
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
        if(tem.settleType==undefined ){
        	tem.settleType=-1;
        }
        
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
            checkManId:mdata.checkManId,
            checkPoint:mdata.checkPoint,

        };
        if(actionType == "new"){
            mainData.checkMainId = checkMainId.value;
            mainData.checkMainName = checkMainName.value;
        }
    }
    nui.mask({
    	el : document.body,
		cls : 'mini-mask-loading',
        html:'保存中..'
    });
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
            var temp = SearchCheckMain(mainParams.id);
            billForm.setData(temp);
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
	var rex=/^\d+(\.\d+)?$/;
	  
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
    var mdata = billForm.getData(true);
    if(mdata.lastChekDate){
    	mdata.lastChekDate = format(mdata.lastChekDate, 'yyyy-MM-dd HH:mm:ss');
    }
    nui.mask({
    	el : document.body,
		cls : 'mini-mask-loading',
        html:'保存中..'
    });
    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMainA.biz.ext",
        type : "post",
        data : {
            data:mdata,
            token : token
        },
        success : function(data) {
            if(data.errCode == "S"){
            	nui.unmask();
                var mainData = data.mainData;
                
                nui.get("id").setValue(mainData.id);
                billForm.setData(mainData);
                $("#servieIdEl").html(mainData.serviceCode);
                if(gridData.length<=0){
                    showMsg(data.errMsg || "保存成功","S");
                }
                else{
                	saveDetailB();
                }
            }else{
                showMsg(data.errMsg,"E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        }
    });

}

function finish(){
	
	var data = billForm.getData(true);
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
	var grid_all = mainGrid.getData(); //保存
	var sellList=[];
	for(var i = 0;i<grid_all.length;i++){
		if(grid_all[i].settleType==0){
			var sell = {};
			sell.carId = data.carId;
			sell.carNo = data.carNo;
			sell.guestId = data.guestId;
			if(sellGuest.fullName){
				sell.guestName = sellGuest.fullName
			}else{
				sell.guestName = sellGuest.guestFullName
			}
			if(sellGuest.mobile){
				sell.guestMobile = sellGuest.mobile;
			}else{
				sell.guestMobile = sellGuest.guestMobile;
			}
			sell.status = 1;
			sell.prdtName = grid_all[i].partName;
			sell.chanceType = '043005';
			sell.nextFollowDate = grid_all[i].careDueDate;
			sell.chanceContent =grid_all[i].checkName;
			sell.prdtName =grid_all[i].checkName;
			sellList.push(sell);
		}

	}

	 nui.mask({
		 	el : document.body,
			cls : 'mini-mask-loading',
	        html:'处理中..'
	    });

	nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMainA.biz.ext",
        type : "post",
        data : {
            data:data,
            isFinish :1,
            token : token
        },
        success : function(data) {
        	nui.unmask();
            if(data.errCode == "S"){
                var mainData = data.mainData;
                nui.get("id").setValue(mainData.id);
                billForm.setData(mainData);
                $("#servieIdEl").html(mainData.serviceCode);
                showMsg(data.errMsg ||"保存成功","S");
        		nui.ajax({
        	        url : apiPath + crmApi + "/com.hsapi.crm.basic.crmBasic.saveSellList.biz.ext",
        	        type : "post",
        	        data : {
        	        	sell:sellList,
        	            token : token
        	        },
        	        success : function(data) {
        	        	nui.unmask();
        	            if(data.errCode == "S"){
        	                showMsg("已生成客户商机","S");
        	            }else{
        	                showMsg(data.errMsg,"E");
        	            }
        	        },
        	        error : function(jqXHR, textStatus, errorThrown) {
        	        }
        	    });
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
        if(tem.settleType==undefined ){
        	tem.settleType=-1;
        }
        
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
    nui.mask({
    	el : document.body,
		cls : 'mini-mask-loading',
        html:'保存中..'
    });
    nui.ajax({
        url : baseUrl + "com.hsapi.repair.repairService.crud.saveCheckDetail.biz.ext",
        type : "post",
        data :{
            listall:gridData,
            mainId : gridData[0].mainId,
            token : token
        },
        success : function(data) {
        	nui.unmask();
            if(data.errCode == "S"){
                actionType = 'edit';
                var temp = SearchCheckMain(nui.get("id").value||0);
                billForm.setData(temp);
                mainGrid.setUrl(baseUrl + "com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                mainGrid.load({mainId:mmid,token:token});
                nui.unmask(document.body);
                checkMainId.setEnabled(false);
                showMsg("保存成功!","S");
            }
            else{
            	nui.unmask();
            	showMsg(data.errMsg,"E");
            	return;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
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
    var temp={};
    temp.mtdvisor = currUserName;
    temp.mtdvisorId = currEmpId;
    billForm.setData(temp);
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
    var settleType=e.record.settleType;
    var enterKilometers =nui.get('enterKilometers').value;
	if(editor!=null){
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}else{
			if (e.field == "careDueMileage") {
				var careDueMileage = e.value;
				 var settleType=e.record.settleType;
				if (e.value == null || e.value == '' || settleType==1 || settleType== -1) {
					e.value = 0;
					careDueMileage = 0;
					showMsg("请选择下次处理!","W");
					return;
				}
				if(e.value<=enterKilometers){
					e.value = 0;
					careDueMileage = 0;
					showMsg('下次处理里程不能比本次里程少!',"W");
					return;
				}
				if (e.value < 0) {
					e.value = 0;
					careDueMileage = 0;
					showMsg("请输入正确的里程数!","W");
					return;
				}
			}
			if(e.field == 'careDueDate'){
				var careDueDate =e.value;
				if(settleType==1 || settleType== -1){
					e.value='';
					careDueDate = '';
					showMsg("请选择下次处理!","W");
				}
			}
			
		}
	}
	
}
function lastCheckModel(){
	var fromData=billForm.getData(true);
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

function setNormal(){
	var data=mainGrid.getData();
	var nrow={status:1,nostatus:-1,nosettleType :0,settleType:-1};
	var row2={status:0,nosettleType :0,settleType :-1};
	var count=0;
		for(var i=0;i<data.length;i++){
			if(data[i].status==1){
				count++;
			}
		}
		for(var i=0;i<data.length;i++){
			if(count==data.length){
				mainGrid.updateRow(data[i],row2) ;
			}				
			else{
				mainGrid.updateRow(data[i],nrow) ;
			}
				
		}
}


function addOrEdit(item)
{
    title = "完善散客信息";
    var guest = {};
    guest.guestId = item.guestId;
    guest.carNo = item.carNo;
    if(!item.guestId){
    	showMsg("数据获取失败,请重新操作!","W");
    	return;
    }
    nui.open({
        url:"com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:560,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            params.guest = guest;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {  
            	var params = {};
            	params.carNo = item.carNo;
            	var json = nui.encode({
            		params:params
            	});
            	 //查找上次里程
                nui.ajax({
            		url :guestInfoUrl,
            		type : 'POST',
            		data : json,
            		cache : false,
            		contentType : 'text/json',
            		success : function(text) {
            			var returnJson = nui.decode(text);
            			if (returnJson.errCode == "S") {
            				var data = returnJson.list;
            				if(data && data.length>0){
            					var item = data[0];
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
            			}else {
            				showMsg("数据加载失败,请重新操作!","E");
            				return;
            		    }
            		}
            	 });
            }
        }
    });
}


