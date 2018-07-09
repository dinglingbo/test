/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.tenant.tenant.saveCompany.biz.ext";
var sex;
var isservice;
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '女'}, {id: 0, name: '男'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];
var list = null;
var provinceCode = null;
var provinceHash = null;
var cityHash = null;
var countyHash = null;
var provinceEl = null;
var cityEl = null;
var countyEl = null;
var streetAddressEl = null;
var addressEl = null;
$(document).ready(function(v) {
    provinceEl = nui.get("provinceId");
    cityEl = nui.get("cityId");
    countyEl = nui.get("countyId");
    streetAddressEl = nui.get("streetAddress");
    addressEl = nui.get("address");

    getRegion(null,function(data) {
        provinceHash = data.rs || [];
        provinceEl.setData(provinceHash);

    });

});
function SetInitData(data) {
    if (data.softopenDate) {
        data.softopenDate = format(data.softopenDate, 'yyyy-MM-dd');
    }
    if (data.recordDate) {
        data.recordDate = format(data.recordDate, 'yyyy-MM-dd HH:mm:ss');
    }
    if (data.modifyDate) {
        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd');
    }

	var form = new nui.Form("#basicInfoForm");
    form.setData(data);  

    setInitRegionData(provinceEl, null);
    if(data && data.provinceId){
        setInitRegionData(cityEl, data.provinceId);    
    }
    if(data && data.cityId){
        setInitRegionData(countyEl, data.cityId);    
    }
}

var requiredField = {
    code : "企业号",
    name : "公司全称",
    shortName : "公司简称",
    provinceId : "省份",
    cityId : "城市",
    streetAddress : "详细地址",
    tel : "公司电话"
};
function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();

    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");

            return;
        }
    }

    /*data.cityId = "";
    data.provinceId = "";
    data.countyId = "";*/
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	comd:data,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode && data.errCode == 'S'){
                showMsg("保存成功!","S");
            }else{
                showMsg(data.errMsg,"W");
            }
            
            if (data.errCode == 'S' && action != 'new') {
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	  nui.unmask();
            closeWindow("cal");
        }
    });
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}
function Oncancel(){
 	closeWindow("cal");
	
}

var getRegionUrl = apiPath + sysApi + "/" + "com.hs.common.region.getRegin.biz.ext";
function getRegion(parentId,callback) {
    nui.ajax({
        url : getRegionUrl,
        data : {
            token: token, 
            parentId: parentId
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setInitRegionData(el, value){
    getRegion(value,function(data) {
        hash = data.rs || [];
        el.setData(hash);
    });
}
function onProvinceChange(e){
    var value = e.value;
    cityEl.setValue(null);
    countyEl.setValue(null);
    getRegion(value,function(data) {
        cityHash = data.rs || [];
        cityEl.setData(cityHash);

    });
    setAddress();
}
function onCityChange(e){
    var value = e.value;
    countyEl.setValue(null);
    getRegion(value,function(data) {
        countyHash = data.rs || [];
        countyEl.setData(countyHash);

    });
    setAddress();
}
function onCountyChange(e){
    setAddress();
}
function onStreetChange(e){
    setAddress();
}
function setAddress() {
    var provinceT = provinceEl.getText()||'';
    var cityT = cityEl.getText()||'';
    var countyT = countyEl.getText()||'';
    var streetAddressT = streetAddressEl.getValue()||'';
    var address = provinceT + cityT + countyT + streetAddressT;
    addressEl.setValue(address);
    addressEl.getValue();
}