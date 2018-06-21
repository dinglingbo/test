/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var producegridUrl = baseUrl + "com.primeton.tenant.operations.produceSaleQuery.biz.ext";
var tenatgridUrl = baseUrl + "com.primeton.tenant.operations.tenantRnakQuery.biz.ext";
var salegridUrl = baseUrl + "com.primeton.tenant.operations.saleMankQuery.biz.ext";
var saveUrl = baseUrl + "com.primeton.tenant.operations.updateSaleMan.biz.ext";
var producegrid;
var tenatgrid;
var salegrid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var queryForm;
var provinceCode;
nui.parse();


var SignHash = {
	    "0":"否",
	    "1":"是"
	};

var sexSignHash = {
	    "0":"男",
	    "1":"女"
	};
$(document).ready(function(v) {
	
	producegrid = nui.get("grid1");
	producegrid.setUrl(producegridUrl);
	tenatgrid = nui.get("grid2");
	tenatgrid.setUrl(tenatgridUrl);
	salegrid = nui.get("grid3");
	salegrid.setUrl(salegridUrl);

    

	   getProvince(function(data) {
	        list = data.rs;
	        nui.get("provinceId").setData(list);
	        nui.get("provinceId1").setData(list);
	        nui.get("provinceId2").setData(list);
	        nui.get("provinceId3").setData(list);
	    });

/*    initProvince('provinceId',function(){
    	provinceList=nui.get('provinceId').getData();
    	 provinceList.forEach(function(v) {
    			provinceHash[v.code] = v;
    		});
    });
    initCity('cityId',function(){
    	 cityList=nui.get('cityId').getData();
    	 cityList.forEach(function(v) {
    			cityHash[v.code] = v;
    		});
    	 });
    grid.on("drawcell", function (e){
    	onDrawCell(e);
    });*/
});



function onDrawCell(e)
{
switch (e.field)
{
	case "provinceId":
    if(provinceHash && provinceHash[e.value])
    {
        e.cellHtml = provinceHash[e.value].name;
    }  
    break;
	case "cityId":
    if(cityHash && cityHash[e.value])
    {
        e.cellHtml = cityHash[e.value].name;
    }  
    break;
	default:
    break;
}
}

function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam() {
	queryForm = new nui.Form("#queryForm");
    var params = queryForm.getData();
    return params;
}

function doSearch(params) {
	producegrid.load({
        params:params
    });
}

function search1() {
    var param = getSearchParam1();
    param.salesManId=param.salesManId1;
    param.provinceId=param.provinceId1;
    param.cityId=param.cityId1;
    param.beginDate=param.beginDate1;
    param.endDate=param.endDate1;
    doSearch1(param);
}

function getSearchParam1() {
	queryForm = new nui.Form("#queryForm1");
    var params = queryForm.getData();
    return params;
}

function doSearch1(params) {
	tenatgrid.load({
        params:params
    });
}

function search2() {
    var param = getSearchParam2();
   
    param.provinceId=param.provinceId2;
    param.cityId=param.cityId2;
    param.beginDate=param.beginDate2;
    param.endDate=param.endDate2;
    doSearch2(param);
}

function getSearchParam2() {
	queryForm = new nui.Form("#queryForm2");
    var params = queryForm.getData();
    return params;
}

function doSearch2(params) {
	salegrid.load({
        params:params
    });
}

	
var getProvinceAndCityUrl = window._rootUrl
+ "com.hsapi.part.common.svr.getProvinceAndCity.biz.ext";
function getProvinceAndCity(callback) {
if (!provinceHash) {
	provinceHash = {};
}
if (!cityHash) {
	cityHash = {};
}
if (window.top._provinceList && window.top._cityList) {
	provinceList = window.top._provinceList;
	cityList = window.top._cityList;
	provinceList.forEach(function(v) {
		provinceHash[v.code] = v;
	});
	cityList.forEach(function(v) {
		cityHash[v.code] = v;
	});
	if (provinceEl) {
		provinceEl.setData(provinceList);
	}
	callback && callback({
		province : provinceList,
		city : cityList
	});
	console.log("getProvinceAndCity from client");
	return;
}
doPost({
	url : getProvinceAndCityUrl,
	data:{},
	success : function(data) {
		if (data && data.province) {
			window.top._provinceList = data.province;
			provinceList = window.top._provinceList;
			window.top._cityList = data.city;
			provinceList.forEach(function(v) {
				provinceHash[v.code] = v;
			});
			if (provinceEl) {
				provinceEl.setData(provinceList);
			}
			cityList = window.top._cityList;
			cityList.forEach(function(v) {
				cityHash[v.code] = v;
			});
			callback && callback(data);
		//	console.log("getProvinceAndCity from server");
		}
	},
	error : function(jqXHR, textStatus, errorThrown) {
		//  nui.alert(jqXHR.responseText);
		console.log(jqXHR.responseText);
	}
});
}

function changebutton(){
	var s=grid.getSelected ();
	if(s!= undefined ){
	if(s.isOpenSystem==1){
		nui.get(jy).setVisible(false);
		nui.get(qy).setVisible(true);
		
	}else{
		nui.get(jy).setVisible(true);
		nui.get(qy).setVisible(false);
	
	}}
}


/*
*
*
*开通或关闭
*
*/
var stoporstartUrl=baseUrl +"com.primeton.tenant.comTenant.stopOrStartComtenant.biz.ext";
function stoporstart(){
	
    	var row = grid.getSelected();
    	if (!row) {
    		alert("请选中一条记录");
    		return;
    		
    	}
    	
    	nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '禁用中...'
	    });
        nui.ajax({
            url: stoporstartUrl,
            type: 'post',
            data: nui.encode({
            	params: row
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	nui.alert("禁用成功！");
                	grid.reload();
                    }else {
                    nui.unmask(document.body);
                    nui.alert("禁用失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
    
	}
	
var queryUrl = baseUrl + "com.hs.common.region.getRegin.biz.ext";
function getProvince(callback) {

    nui.ajax({
        url : queryUrl,
        data : {
        	parentId:provinceCode,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
}
function onProvinceChange(e){
    var se = e.selected;
    provinceCode = se.code;
  
    getProvince(function(data) {
    	  nui.get("cityId").setData(data.rs);
    });
}
function onProvinceChange1(e){
    var se = e.selected;
    provinceCode = se.code;
  
    getProvince(function(data) {
    	  nui.get("cityId1").setData(data.rs);
    });
}

function onProvinceChange2(e){
    var se = e.selected;
    provinceCode = se.code;
  
    getProvince(function(data) {
    	  nui.get("cityId2").setData(data.rs);
    });
}
function onProvinceChange3(e){
    var se = e.selected;
    provinceCode = se.code;
  
    getProvince(function(data) {
    	  nui.get("cityId3").setData(data.rs);
    });
}



var removetUrl=baseUrl +"com.primeton.tenant.operations.removeSaleMan.biz.ext";
function remove(){
	
	s=salegrid.getSelected ();
	if(s==undefined){
		nui.alert("请选中一行")
		return;
	}
 	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '删除中...'
    });
	   nui.ajax({
           url: removetUrl,
           type: 'post',
           data: nui.encode({
           	params: s
           }),
           cache: false,
           success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               	nui.alert("删除成功！");
              	var request;
              	salegrid.load(request,function(){
                    //成功;
                  
                	 nui.alert("数据成功！");
                },function(){
                    //失败;
                    nui.alert("数据失败！");
                });
                   }else {
                   nui.unmask(document.body);
                   nui.alert("删除失败！");
                 
               }
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
		});
}



function onOk() {
    
    var s=new nui.Form("#form1").getData();
    saveData(s);
}

var savetUrl=baseUrl +"com.primeton.tenant.operations.updateSaleMan.biz.ext";
function saveData(row){

nui.mask({
    el : document.body,
    cls : 'mini-mask-loading',
    html : '保存中...'
});
nui.ajax({
    url: savetUrl,
    type: 'post',
    data: nui.encode({
    	params: row
    }),
    cache: false,
    success: function (data) {
        if (data.errCode == "S"){
        	nui.unmask(document.body);
        	nui.alert("保存成功！");
        	 form1.hide();
            }else {
            nui.unmask(document.body);
            nui.alert("保存失败！");
            form1.hide();
        }
    },
    error: function (jqXHR, textStatus, errorThrown) {
        nui.alert(jqXHR.responseText);
    }
});

}
