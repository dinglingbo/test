/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPackByBillDetailId.biz.ext";

var basicInfoForm = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var billTypeIdEl = null;
var settleTypeIdEl = null;
var guestIdEl = null;
var receiveManEl = null;
var receiveManTelEl = null;
var addressEl = null;
var receiveCompNameEl = null;
var provinceIdEl = null;
var cityIdEl = null;
var countyIdEl = null;
var streetAddressEl = null;
var frow = {};
var fpack = {};
var fguestid = 0;

$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");

    settleTypeIdEl = nui.get("settleTypeId");
    sCreateDate = nui.get("sCreateDate");
    eCreateDate = nui.get("eCreateDate");
    guestIdEl = nui.get("guestId");
    receiveManEl = nui.get("receiveMan");
    receiveManTelEl = nui.get("receiveManTel");
    addressEl = nui.get("address");
    receiveCompNameEl = nui.get("receiveCompName");
    provinceIdEl = nui.get("provinceId");
    cityIdEl = nui.get("cityId");
    countyIdEl = nui.get("countyId");
    streetAddressEl = nui.get("streetAddress");

});
function setInitData(row, guestId, guestName, settList){
    frow = row;
    fguestid = guestId;
    //先查询是否存在已打包的信息
    //票据类型
    guestIdEl.setValue(guestId);
    guestIdEl.setText(guestName);
    settTypeIdList = settList||[];
    settTypeIdList.filter(function(v)
    {
        settTypeIdHash[v.customid] = v;
        return true;
    });

    nui.get("settleTypeId").setData(settTypeIdList);

    getPack(row.id);

}
function getPack(billMainId)
{
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
    });

    nui.ajax({
        url : leftGridUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
            billMainId : billMainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            var pack = data.pack || {};
            if (pack && pack.id) {
                basicInfoForm.setData(pack);
                fpack = pack;
                nui.get("logisticsGuestId").setText(pack.logisticsName);

                getLogistics(pack.guestId,function(data) {
                    var list = data.list || [];
                    receiveManEl.setData(list);
        
                }); 
                
            } else {
                
                getLogistics(fguestid,function(data) {
                    var list = data.list || [];
                    receiveManEl.setData(list);
                    nui.get("createDate").setValue(new Date());
            
                    //默认收货地址
                    list.filter(function(v){
                        if(v.isDefault && v.isDefault==1){
            
                            receiveManEl.setValue(v.receiveMan);
                            receiveManTelEl.setValue(v.receiveManTel);
                            receiveCompNameEl.setValue(v.receiveCompName);
                            provinceIdEl.setValue(v.provinceId);
                            cityIdEl.setValue(v.cityId);
                            countyIdEl.setValue(v.countyId);
                            streetAddressEl.setValue(v.streetAddress);
                            addressEl.setValue(v.address);
            
                            return true;
                        }
                    });
            
                }); 
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}
var supplier = null;    
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "客户选择", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isClient:1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var billTypeIdV = supplier.billTypeId;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if(elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);
                    nui.get("guestName").setValue(text);

                    setGuestLogistics(value,false);

                }
            }
        }
    });
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
    guestId : "客户",
    logisticsGuestId : "物流公司",
    logisticsNo : "物流单号",
    packMan : "发货员",
    createDate : "发货日期",
    receiveMan : "收货人",
    settleTypeId : "结算方式",
    packItem : "总包数",
    truePayAmt : "运费"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.savePjPack.biz.ext";
function onOk() {
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    if(fpack && fpack.id){
        if(fpack.auditSign == 1) {
            showMsg("此单发货信息已经审核，不能修改!","W");
            return;
        } 
    }    

    data = getMainData();

    var packDetailAdd = [];
    if(!data.id){
        var newRow = {
            billMainId:frow.id,
            billServiceId:frow.serviceId,
            billAmt:frow.orderAmt,
            settleTypeId:frow.settleTypeId,
            orderMan:frow.orderMan,
            billDate:frow.auditDate,
            remark:frow.remark
        };
        packDetailAdd.push(newRow);

        data.guestName = frow.guestFullName;
    }

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            packMain : data,
            packDetailAdd : packDetailAdd,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    setGuestInfo(params);

    var data = rightGrid.getData();
    rightGrid.removeRows(data);

}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    nui.ajax({
        url:getGuestInfo,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var supplier = text.suppliers;
                if(supplier && supplier.length>0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;
                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);

                    nui.get("guestName").setValue(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestName: text};
                    leftGrid.updateRow(row,newRow);

                    setGuestLogistics(value,false);
                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);
                    nui.get("guestName").setValue(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestName: null};
                    leftGrid.updateRow(row,newRow);

                    setGuestLogistics(null,true);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);
                nui.get("guestName").setValue(null);

                var row = leftGrid.getSelected();
                var newRow = {guestName: null};
                leftGrid.updateRow(row,newRow);

                setGuestLogistics(null,true);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setGuestLogistics(guestId,setNull){
    receiveManEl.setValue(null);
    receiveManTelEl.setValue(null);
    receiveCompNameEl.setValue(null);
    provinceIdEl.setValue(null);
    cityIdEl.setValue(null);
    countyIdEl.setValue(null);
    streetAddressEl.setValue(null);
    addressEl.setValue(null);
    if(setNull){
    }else{
        if(guestId){
            getLogistics(guestId,function(data) {
                list = data.list || [];
                receiveManEl.setData(list);

                //默认收货地址
                list.filter(function(v){
                    if(v.isDefault && v.isDefault==1){

                        receiveManEl.setValue(v.receiveMan);
                        receiveManTelEl.setValue(v.receiveManTel);
                        receiveCompNameEl.setValue(v.receiveCompName);
                        provinceIdEl.setValue(v.provinceId);
                        cityIdEl.setValue(v.cityId);
                        countyIdEl.setValue(v.countyId);
                        streetAddressEl.setValue(v.streetAddress);
                        addressEl.setValue(v.address);

                        return true;
                    }
                });

            });        
        }

    }
}
var getLogisticsUrl = apiPath + cloudPartApi + "/com.hsapi.cloud.part.baseDataCrud.crud.getLogisticsByGuestId.biz.ext";
function getLogistics(guestId,callback) {
    nui.ajax({
        url : getLogisticsUrl,
        data : {
            token: token, 
            guestId: guestId
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onReceiveManChanged(e) 
{
    var v = e.selected;
    //receiveManEl.setValue(v.receiveMan);
    receiveManTelEl.setValue(v.receiveManTel);
    receiveCompNameEl.setValue(v.receiveCompName);
    provinceIdEl.setValue(v.provinceId);
    cityIdEl.setValue(v.cityId);
    countyIdEl.setValue(v.countyId);
    streetAddressEl.setValue(v.streetAddress);
    addressEl.setValue(v.address);
}  
function selectLogisticsSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "物流公司选择", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier:1,
                guestType:'01020204'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                nui.get("logisticsName").setValue(text);

                settleTypeIdEl.setValue(settTypeIdV);

            }
        }
    });
}
function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}