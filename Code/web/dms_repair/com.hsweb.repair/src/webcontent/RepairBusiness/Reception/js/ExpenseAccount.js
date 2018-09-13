var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
$(document).ready(function () {
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	rpsPartGrid = nui.get("rpsPartGrid");
	rpsPackageGrid.hideColumn("workers");
	rpsPackageGrid.hideColumn("saleMan");
	rpsItemGrid.hideColumn("workers");
	rpsItemGrid.hideColumn("saleMan");
	rpsPartGrid.hideColumn("saleMan");
	var params = {
            data: {
                id:1081
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

                    /*doSearchCardTimes(fguestId);
                    doSearchMemCard(fguestId);*/

                    billForm.setData(data);

                    var p1 = {
                        interType: "package",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    var p2 = {
                        interType: "item",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    var p3 = {
                        interType: "part",
                        data:{
                            serviceId: data.id||0
                        }
                    }
                    loadDetail(p1, p2, p3);

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
});

function checkFromBillPackage(data){
    var packageId= data.id;
    var rows = rpsPackageGrid.findRows(function(row){
        if(row && row.prdtId == packageId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}

function delFromBillPackage(data, callback){
    var pkg = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"package",
        data:{
        	pkg: pkg
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除套餐信息失败!","W");
            return;
        }
    });
}

function addToBillPackage(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var pkg = {
        serviceId:main.id,
        packageId:row.id,
        cardDetailId:0
    };
    data.pkg = pkg;
    data.serviceId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'package',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加套餐失败!","W");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}

function choosePackage(){
   /* var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存套餐!","S");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加套餐!","S");
        return;
    }*/
                                                       
    doSelectPackage(addToBillPackage, delFromBillPackage, checkFromBillPackage, function(text){
        var p1 = { 
    		interType: "package",
            data:{
                /*serviceId: main.id||0*/
            }
        };
        var p2 = {};
        var p3 = {};
        loadDetail(p1, p2, p3);
    });
}

function loadDetail(p1, p2, p3){
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