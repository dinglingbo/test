/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";

var billForm = null;
var editFormDetail = null;//
var servieTypeList = [];
var servieTypeHash = {};
//var memList = [];
var serviceTypeIdEl = null;
var currEmpIdEl = null;
var searchNameEl = null;
var servieIdEl = null;
var searchKeyEl = null;

var rpsPackageGrid = null;//
var rpsPartGrid = null;

var fserviceId = 0;
var fguestId = 0;
var fcarId = 0;
var mpackageRate = 0;
var mitemRate = 0;
var mpartRate = 0;
var x = 0;
var y = 0;
var chang = 0;
var prdtTypeHash = {
    "1":"套餐",
    "2":"项目",
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
        //memList = currEmpIdEl.getData();     
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
    	chang = 1;
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
        	if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
        		setGuest(item);
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
        		setGuest(item);
        	}
        	
        }
    });
    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");
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
    rpsPartGrid.on("cellbeginedit",function(e){
        var field=e.field; 
        var editor = e.editor;
        var row = e.row;
        var column = e.column;
        var editor = e.editor;

        /*if(field == 'qty'){
             e.cancel = true;
        }*/
    })
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==78)&&(event.altKey))  {  //新建
			add();	
	    } 
	  
	    if((keyCode==83)&&(event.altKey))  {   //保存
			save();
	    } 
	};
	nui.get("recordDate").setValue(now);
});

function setGuest(item){
	  var carNo = item.carNo||"";
      var tel = item.guestMobile||"";
      var guestName = item.guestFullName||"";
      var carVin = item.vin||"";
      var data = {
              carNo: carNo,
              isSettle: 0,
              orgid: currOrgId
          };
      var params = {	
          	"params":data
          };
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
                          doSetMainInfo(item);
                      }else if(action == "查看"){
                      	var list = data[0];
                      	var opt={};
                          opt.iconCls="fa fa-desktop";
                      	if(list.billTypeId == "0"){
                              opt.id="2082";
                              opt.text="综合开单";
                              opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.ReceptionMain.flow";
                      	}
                      	if(list.billTypeId == "2"){
                              opt.id="2083";
                              opt.text="洗车开单";
                              opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBillMgr.flow";
                      	}
                      	if(list.billTypeId == "4"){
                              opt.id="2084";
                              opt.text="理赔开单";
                              opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.claimMain.flow";
                      	}
                      	if(list.billTypeId == "3"){
                              opt.id="2087";
                              opt.text="销售开单";
                              opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.sellMain.flow";
                      	}
                      	if(list.billTypeId == "5"){
                              opt.id="2088";
                              opt.text="退货开单";
                              opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.sellReturn.flow";
                      	}
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
               doSetMainInfo(item);
          }
      });
}
var statusHash = {
    "0" : "制单",
    "1" : "维修",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};

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

  /*  innerPartGrid.setData([]);
    var params = {};
    innerPartGrid.load({
        params:params,
        token: token
    });*/
}
var sourceUrl = webBaseUrl+"com.hsweb.RepairBusiness.printSellBill.flow?token="+token;
function onPrint(){
	var main = billForm.getData();
	main.baseUrl = baseUrl;
	main.token = token;
	if(main.id){
		/*var params = {
            source : e,
            serviceId : main.id
		};*/
        //doPrint(params);	
	nui.open({
        url: sourceUrl,
        title: "销售单打印",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(main);
        },
        ondestroy: function (action){
        }
    });
	}else{
        showMsg("请先保存工单,再打印!","W");
        return;
    }
}
function onApplyClick(){
    doApplyCustomer({},function(action){
        if(action == 'ok'){
            var iframe = this.getIFrameEl();
            var guest = iframe.contentWindow.getSaveData();
            if(guest){
                var maintain = billForm.getData();
                maintain.carId = guest.carId||0;recorder;
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
    maintain.billTypeId = 3;
    maintain.serviceTypeId = 3;
    maintain.mtAdvisorId = currEmpId;
    maintain.mtAdvisor = currUserName;
    maintain.recordDate = now;

    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;

    billForm.setData(maintain);
    nui.get("mtAdvisorId").setText(currUserName);
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
            var status = data.status;
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
                        loadDetail(p3,status);

                    }else{
                        showMsg("数据加载失败,请重新打开工单!","E");
                    }
    
                }, function(){});
            }else{
                showMsg('数据加载失败!','E');
            }
        }, function(){
            nui.unmask(document.body);
        })
    }
}
function add(){
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
    rpsPartGrid.clearRows();
    billForm.setData([]);
 
    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisorId").setText(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    fguestId = 0;
    fcarId = 0;
    $("#servieIdEl").html("");
  
}
function save(){
	var data = billForm.getData();
	if(data.status==1){
		showMsg("工单已审核!","W");
        return;
	}
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
                    nui.get("mtAdvisorId").setText(data.mtAdvisor);
                    var p3 = {
                        interType: "part",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    loadDetail(p3);

                }else{
                    showMsg("数据加载失败,请重新打开工单!","E");
                }

            }, function(){});           
        }
        
    },function(){ 
        nui.unmask(document.body);
    });
}

function saveNoShowMsg(callback){
    saveMaintain(function(data){
        if(data.id){
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
                    nui.get("mtAdvisorId").setText(data.mtAdvisor);
                    billForm.setData(data);

                    var p3 = {
                        interType: "part",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    loadDetail(p3,data.status);
                    callback && callback();
                }else{
                    showMsg("数据加载失败,请重新打开工单!","E");
                }

            }, function(){});           
        }
        
    },function(){});
}

var requiredField = {
    carNo : "车牌号",
    guestId : "客户",
    /*serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问"*/
};

var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
	
    var data = billForm.getData(true);
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            unmaskcall && unmaskcall();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
	/*if(data.id) {
    	delete data.recordDate;
    }*/
	if(data.recordDate){
    	data.recordDate = format(data.recordDate, 'yyyy-MM-dd HH:mm:ss');
    }
    data.billTypeId = 3;
    data.serviceTypeId = 1 ;
    data.mtAdvisorId = currEmpId;
    data.mtAdvisor = currUserName;
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
            billForm.setData(main);
            callback && callback(main);
        } else {
            unmaskcall && unmaskcall();
            showMsg(data.errMsg || "保存单据失败","E");
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
    data.billTypeId = 3;
    
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
                showMsg(data.errMsg || "保存单据失败","E");
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
        showMsg("请先保存工单!","W");
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
                    showMsg(errMsg||"添加预存信息失败!","E");
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
                showMsg(errMsg||"添加预存信息失败!","E");
                return;
            }
        });
    }
}
function checkPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","W");
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

function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}

function deletePartRow(row_uid){
	var main = billForm.getData();	
    var isSettle = main.isSettle||0;
    if(main.status==1){
		showMsg("工单已审核,不能删除配件!","W");
        return;
	} 
    if(isSettle == 1){
        showMsg("工单已结算,不能删除配件!","W");
        return;
    }
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
/*function onpartsalemanChanged(e){
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    var row = rpsPartGrid.getSelected();
    var newRow = {saleManId:saleManId};
    rpsPartGrid.updateRow(row, newRow);
}*/

function loadDetail(p3,status){
    if(p3 && p3.interType){
        getBillDetail(p3, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPartGrid.clearRows();
                rpsPartGrid.addRows(data);
                rpsPartGrid.accept();
                if(status<1){
                	var row = rpsPartGrid.findRow(function(row){
                		rpsPartGrid.beginEditRow(row);
                    });
                }
            }
        }, function(){});
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
    var status = main.status;
    var isSettle = main.isSettle||0;
    if(isSettle == 1){
        showMsg("工单已结算,不能添加配件!","W");
        return;
    }
    if(main.status == 1){
        showMsg("工单已审核,不能添加配件!","W");
        return;
    }
    if(main.status == 2){
        showMsg("工单已出库,不能添加配件!","W");
        return;
    }
     if(!main.id){
    	var data = billForm.getData();
		for ( var key in requiredField) {
			if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField[key] + "不能为空!","W");
				return;
			}
	    }
		nui.mask({
 	        el: document.body,
 	        cls: 'mini-mask-loading',
 	        html: '数据加载中...'
 	     });
		saveNoShowMsg(function(){
			  nui.open({
					url : webPath + contextPath + "/com.hsweb.repair.DataBase.partSelectView.flow?token=" + token,
					title : "配件管理",
					width : 1100,
					height : 560,
					allowDrag : true,
					allowResize : true,
					onload : function() {
						var iframe = this.getIFrameEl();
						var type = "sellPart";
			            iframe.contentWindow.setCkcallback(checkFromBillPart,type);
					},
					ondestroy : function(action) {
						var iframe = this.getIFrameEl();
			            var dataList = iframe.contentWindow.getPartList();
			            var setPartList = [];
			            if(dataList && dataList.length>0){
			            	for(var i = 0;i<dataList.length;i++){
			            		var data = dataList[i];
			            		var part = {};
			                    part={
			                   	serviceId:main.id,
			                   	serviceTypeId:main.serviceTypeId,
			                   	partId:data.id,
			                   	packageId:0,
			                   	partCode:data.code,
			                   	partName:data.name,
			                   	partNameId:data.partNameId,
			                   	partBrandId:data.partBrandId,
			                   	saleMan:data.saleMan,
			                   	saleManId:data.saleManId,
			                   	detailId:0,
			                   	qty:1,
			                   	unitPrice:0,
			                   	unit:data.unit,
			                   	amt:0,
			                   	subtotal:0,
			                   	rate:0,
			                   	partBrandId:data.partBrandId,
			                   	partNameId:data.partNameId,
			                   	partId:data.id,
			                   	outReturnQty:0
			                   }
			                   setPartList.push(part);
			            	}
			            }
			            //把该传的字段对应好
			            rpsPartGrid.addRows(setPartList); 
			            if(status<1){
			            	var row = rpsPartGrid.findRow(function(row){
			            		rpsPartGrid.beginEditRow(row);
			                });
			            }
					}
				});
			  nui.unmask(document.body);
		});
    }else{
    	rpsPartGrid.commitEdit();
        nui.open({
    		url : webPath + contextPath + "/com.hsweb.repair.DataBase.partSelectView.flow?token=" + token,
    		title : "配件管理",
    		width : 1100,
    		height : 560,
    		allowDrag : true,
    		allowResize : true,
    		onload : function() {
    			var iframe = this.getIFrameEl();
    			var type = "sellPart";
                iframe.contentWindow.setCkcallback(checkFromBillPart,type);
    		},
    		ondestroy : function(action) {
    			var iframe = this.getIFrameEl();
                var dataList = iframe.contentWindow.getPartList();
                var setPartList = [];
                if(dataList && dataList.length>0){
                	for(var i = 0;i<dataList.length;i++){
                		var data = dataList[i];
                		var part = {};
                        part={
                       	serviceId:main.id,
                       	serviceTypeId:main.serviceTypeId,
                       	partId:data.id,
                       	packageId:0,
                       	partCode:data.code,
                       	partName:data.name,
                       	partNameId:data.partNameId,
                       	partBrandId:data.partBrandId,
                       	saleMan:data.saleMan,
                       	saleManId:data.saleManId,
                       	detailId:0,
                       	qty:1,
                       	unitPrice:0,
                       	unit:data.unit,
                       	amt:0,
                       	subtotal:0,
                       	rate:0,
                       	partBrandId:data.partBrandId,
                       	partNameId:data.partNameId,
                       	partId:data.id,
                       	outReturnQty:0
                       }
                       setPartList.push(part);
                	}
                }
                //把该传的字段对应好
                rpsPartGrid.addRows(setPartList); 
                if(status<1){
                	var row = rpsPartGrid.findRow(function(row){
                		rpsPartGrid.beginEditRow(row);
                    });
                }
    		}
    	});
    }      
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
/*function onCellCommitEdit(e) {
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
				amt : amt,
				subtotal:amt
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
				amt : amt,
				subtotal:amt
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
			var unitPrice = 0;
			if(qty>0){
				unitPrice = amt * 1.0 / qty;
			} 
			// e.cellHtml = enterqty * enterprice;
			newRow = {
					unitPrice : unitPrice,
					subtotal:amt
				   };
		   rpsPartGrid.updateRow(e.row, newRow);
		} 		
	}
}*/

/*
 * 修改维修主表的信息
 * */
var SaveUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.saveAndUpdReturnRpsPart.biz.ext";
var saveMaintain2 = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";

function saveBatch(){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(main.status==1){
		showMsg("工单已审核!","W");
        return;
	} 
    if(isSettle == 1){
        showMsg("工单已结算!","W");
        return;
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
	//保存工单
	if(!main.id){
	 var data = billForm.getData();
		for ( var key in requiredField) {
			if (!data[key] || $.trim(data[key]).length == 0) {
	            showMsg(requiredField[key] + "不能为空!","W");
				return;
			}
	    }
	    data.billTypeId = 3;
	    data.serviceTypeId = 1 ;
	    data.mtAdvisorId = currEmpId;
	    data.mtAdvisor = currUserName;
	    var json = nui.encode({
			"maintain" : data,
			token : token
		});
	    
		nui.ajax({
			url : saveMaintain2,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				nui.unmask(document.body);
				if (returnJson.errCode == "S") {
					showMsg("保存成功","S");
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
			                    data.addr = guest.addr;
			                    billForm.setData(data);
			                    nui.get("mtAdvisorId").setText(data.mtAdvisor);

			                }else{
			                    showMsg("数据加载失败,请重新打开工单!","E");
			                }

			            }, function(){});
								
				} else {
					//数据改回原本来的数据
					//rpsPartGrid.reject();
					showMsg(returnJson.errMsg || "保存失败","E");
				}
			}
		});
	    
	}else{		
		var maintain = billForm.getData(true);
	   /* delete maintain.recordDate;*/  
		if(maintain.recordDate){
			maintain.recordDate = format(maintain.recordDate, 'yyyy-MM-dd HH:mm:ss');
	    }
	    total = null;
		//var addSellPart = nui.get("rpsPartGrid").getData();
		//var sellPartAdd = rpsPartGrid.getChanges("added");
		//var sellPartUpdate = rpsPartGrid.getChanges("modified");
		var sellPartAdd = [];
		var sellPartUpdate = [];
		var sellPartDelete = rpsPartGrid.getChanges("removed");
		var row = rpsPartGrid.findRow(function(row){
			if(!row.id){
				total += parseFloat(row.amt);
				sellPartAdd.push(row);
			}else{
				total += parseFloat(row.amt);
				sellPartUpdate.push(row);
			}
        });
		maintain.partAmt = total;
		var json = nui.encode({
			"maintain" : maintain,
			//"addSellPart" : addSellPart,
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
					var p3 = {
	                        interType: "part",
	                        data:{
	                            serviceId: maintain.id||0
	                        }
	                    }
	                loadDetail(p3,maintain.status);
					showMsg("保存成功","S");
					nui.unmask(document.body);								
				} else {
					nui.unmask(document.body);
					//rpsPartGrid.reject();
					showMsg(returnJson.errMsg || "保存失败","E");
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
	/*if(b == 1){
		main.status = 1;
	}*/
    var isSettle = main.isSettle||0;
     if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    if(main.status==1){
 		showMsg("工单已确认开单!","W");
         return;
 	} 
    if(isSettle == 1){
        showMsg("工单已结算,不能审核!","W");
        return;
    }
	
	if(main.status==2){
		showMsg("工单已出库,不能审核!","W");
        return;
	}
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '审核中...'
	});
	var maintain = billForm.getData(true);
    //delete maintain.recordDate;
	if(maintain.recordDate){
		maintain.recordDate = format(maintain.recordDate, 'yyyy-MM-dd HH:mm:ss');
    }
	total = null;
	var sellPartAdd = [];
	var sellPartUpdate = [];
	var sellPartDelete = rpsPartGrid.getChanges("removed");
	var row = rpsPartGrid.findRow(function(row){
		if(!row.id){
			total += parseFloat(row.amt);
			sellPartAdd.push(row);
		}else{
			total += parseFloat(row.amt);
			sellPartUpdate.push(row);
		}
     });
	maintain.partAmt = total;
	var json = nui.encode({
		"main" : maintain,
		"sellPartAdd" : sellPartAdd,
		"sellPartUpdate" : sellPartUpdate,
		"sellPartDelete" : sellPartDelete,
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
			nui.unmask(document.body);
			if (returnJson.errCode == "S") {
				main.status = 1;
				billForm.setData(main);
				nui.get("mtAdvisorId").setText(main.mtAdvisor);
				var p3 = {
                        interType: "part",
                        data:{
                            serviceId: main.id||0
                        }
                    };
                loadDetail(p3);
				showMsg("开单成功","S");
				
			} else {
				showMsg(returnJson.errMsg || "开单失败","E");
			}
				
		}
	});
}

var total = null;
/*function onDrawSummaryCell(e){	
	  var rows = e.data;
	  var sum = null;
	  if(e.field == "amt") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  sum += parseFloat(rows[i].amt);
			  total = sum;
		  }
	  } 
}*/

//转结算
payUrl = webPath + contextPath +"/com.hsweb.RepairBusiness.billSettle.flow?token="+token;
function pay(){	
	var main = billForm.getData();
	if(main.isSettle == 1){
        showMsg("工单已结算!","W");
        return;
    }
	if(main.status != 2){
		 showMsg("工单未出库,不能结算!","W");
	     return;
	}
	nui.open({
		url:payUrl,
		width:"100%",
		height:"100%",
		//加载完之后
		onload: function(){	
			//把值传递到支付页面
		    var iframe = this.getIFrameEl();
		    var data = {
		    	"itemPrefAmt":0,
		    	"itemSubtotal":0,
		    	"packagePrefAmt":0,
		    	"packageSubtotal":0,
		    	"partPrefAmt":total,
		    	"partSubtotal":total,
		    	"mtAmt":total,
		    	"ycAmt":0
		    };
		    var params = {
		    	"carNo":main.carNo,
		    	"guestId":main.guestId,
		    	"guestName":main.guestFullName,
		    	"serviceId":main.id,
		    	"data":data,
		    	"typeUrl" :1
		    };
		    iframe.contentWindow.setData(params);			
		},
	   ondestroy : function(action) {
               if(action == "ok"){
            	   main.isSettle=1;
            	   billForm.setData(main);
                   showMsg("结算成功!","S");
               }else if(action == "onok"){
            	   main.isSettle=1;
            	   billForm.setData(main);
                   showMsg("转预结算成功!","S");
               }else{
                   if(data.errCode){
                       showMsg("结算失败!","E");
                       return;
                   }
               }
	   }
	});		
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
            {   //var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getSaveData();
            	//setGuest(item);
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
            					setGuest(data[0]);
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



function onValueChangedComQty(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsPartGrid.getEditorOwnerRow(el);
	var setItemTime = rpsPartGrid.getCellEditor("qty", rowtime);
	var qty = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
	}else if(qty<0){
		showMsg("数量不能小于0","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(qty == "" || qty == null){	
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{		
		//获取指定列和行的编辑器控件对象
		var setAmt = rpsPartGrid.getCellEditor("amt", rowtime);
		var setUnitPrice = rpsPartGrid.getCellEditor("unitPrice", rowtime);
		var unitPrice = setUnitPrice.getValue()||0;
		var amt = 0
		//设置工时总金额
		if(unitPrice>0 && qty>0){
		   amt = qty*unitPrice;
		   amt = amt.toFixed(2);
		}
		setAmt.setValue(amt);
		setItemTime.setValue(qty);
		rowtime.subtotal = amt;
		rowtime.qty = qty;
		rowtime.unitPrice = unitPrice;
		rowtime.amt = amt;
  }
}

function onValueChangedUnitPrice(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsPartGrid.getEditorOwnerRow(el);
	var setUnitPrice = rpsPartGrid.getCellEditor("unitPrice", rowtime);
	var unitPrice = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
	}else if(unitPrice<0){
		showMsg("数量不能小于0","W");
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(unitPrice == "" || unitPrice == null){	
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{		
		//获取指定列和行的编辑器控件对象
		var setAmt = rpsPartGrid.getCellEditor("amt", rowtime);
		var setQty = rpsPartGrid.getCellEditor("qty", rowtime);
		var qty = setQty.getValue()||0;
		var amt = 0
		//设置工时总金额
		if(unitPrice>0 && qty>0){
		   amt = qty*unitPrice;
		   amt = amt.toFixed(2);
		}
		setAmt.setValue(amt);
		setUnitPrice.setValue(unitPrice);
		rowtime.subtotal = amt;
		rowtime.qty = qty;
		rowtime.unitPrice = unitPrice;
		rowtime.amt = amt;
  }
}

function onValueChangedAmt(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsPartGrid.getEditorOwnerRow(el);
	var setAmt = rpsPartGrid.getCellEditor("amt", rowtime);
	var amt = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setAmt.setValue(e.oldValue);
		e.cancel = true; 
	}else if(amt<0){
		showMsg("数量不能小于0","W");
		setAmt.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(amt == "" || amt == null){	
		setAmt.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{		
		//获取指定列和行的编辑器控件对象
		var setUnitPrice = rpsPartGrid.getCellEditor("unitPrice", rowtime);
		var setQty = rpsPartGrid.getCellEditor("qty", rowtime);
		var unitPrice = setUnitPrice.getValue()||0;
		var qty = setQty.getValue()||0;
		//设置工时总金额
		if(qty>0){
			unitPrice = amt/qty;
			unitPrice = unitPrice.toFixed(2);	
		}
		setAmt.setValue(amt);
		setUnitPrice.setValue(unitPrice);
		rowtime.subtotal = amt;
		rowtime.unitPrice = unitPrice;
		rowtime.amt = amt;
  }
}

function openItemSaleMans(e){
	var el = e.sender;
    var row = rpsPartGrid.getEditorOwnerRow(el);
	var saleMan = rpsPartGrid.getCellEditor("saleMan", row);
    var data = {};
    data = {
    	saleMan:row.saleMan,
    	saleManId:row.saleManId
    };
 	 $('.mini-textbox-input').blur();
     nui.open({
 		url :  webPath + contextPath + "/com.hsweb.repair.DataBase.Salesperson.flow?token="+token,
 		title : "设置销售员",
 		width : 600,
 		height : 380,
 		allowResize: false,
 		onload : function() {
 			var iframe = this.getIFrameEl(); 
 			iframe.contentWindow.setData(data);
 		},
 		ondestroy : function(action) {// 弹出页面关闭前
 			if (action == "ok") {
 			    var iframe = this.getIFrameEl();
		        var data = iframe.contentWindow.getData();
		       // __saleManId = data.emlpszId;
		        saleMan.setValue(data.emlpszName);
		        row.saleManId = data.emlpszId;
		        row.saleMan = data.emlpszName;
 			}
 		}
 	});
}

//var saleManNameBat = null;

function setPartSaleMans(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	//saleManIdBat = "";
        	//saleManNameBat = "";
        	nui.open({
        		url :  webPath + contextPath + "/com.hsweb.repair.DataBase.Salesperson.flow?token="+token,
        		title : "批量设置销售员",
        		width : 600,
        		height : 380,
        		allowResize: false,
        		onload : function() {
        			var iframe = this.getIFrameEl(); 
        			var data = {
        			};// 传入页面的json数据
        			iframe.contentWindow.setData(data);
        		},
        		ondestroy : function(action) {// 弹出页面关闭前
        			if (action == "ok") {
        				var iframe = this.getIFrameEl();
        	        	var data = iframe.contentWindow.getData();
        	        	//saleManNameBat = data.emlpszName;
        	        	//saleManIdBat = data.emlpszId;
        	        	var row = rpsPartGrid.findRow(function(row){
                    			var saleMan = rpsPartGrid.getCellEditor("saleMan", row);
                    			saleMan.setValue(data.emlpszName);
                		        row.saleManId = data.emlpszId;
                		        row.saleMan = data.emlpszName;
                        });
        	        	//surePkgSaleMansSetWin(main);
        			}
        		}
        	});
        }
    }
}

function onDrawSummaryCellPart(e){ 	  
	  var data = billForm.getData();
	  var rows = e.data;
	  var sumPamt = 0;
	  //|| e.field == "amt"
	  if(e.field == "amt") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  
			  if(rows[i].billPackageId=="0"){
				  sumPamt  += parseFloat(rows[i].amt);
			  }
		  }
		  total = sumPamt;
		  
	  } 
}



