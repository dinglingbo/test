/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.primeton.tenant.comProduct.comProductQuery.biz.ext";
var timeUrl = baseUrl + "com.hsapi.system.employee.comCompany.getTime.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var grid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var queryForm;
var provinceCode;
var productStatus;
var types;

var SignHash = {
	    "0":"否",
	    "1":"是"
	};



$(document).ready(function(v) {

	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
    var request = {
    		"params":{
    			
    		}
    };   
/*    grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！");
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
/*    grid.load({
        params:params
    });*/
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


function ViewType(e){
    var tit = null;
    var s;
    if(e == 1){
        tit="新增产品";
    }
    if(e == 2){
        tit="修改产品";
     	s=grid.getSelected ();
    	if(s==undefined){
    		nui.alert("请选中一行")
    		return;
    	}
    }

    nui.open({
        url: baseUrl +"tenant/productManagerment_view.jsp",
        title: tit, 
        width: 630,  
        height: 250,
        onload: function(){
            var iframe = this.getIFrameEl();
            
            iframe.contentWindow.SetInitData(s);
        },
        ondestroy: function (action) {
        	var request;
/*            grid.load(request,function(){
                //成功;
              
            	 nui.alert("数据成功！");
            },function(){
                //失败;
                nui.alert("数据失败！");
            });*/
        }
    });


}
var removetUrl=baseUrl +"com.primeton.tenant.comProduct.removeComProduct.biz.ext";
function remove(){
	
	s=grid.getSelected ();
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
/*                grid.load(request,function(){
                    //成功;
                  
                	 nui.alert("数据成功！");
                },function(){
                    //失败;
                    nui.alert("数据失败！");
                });*/
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



var upOrDownUrl=baseUrl +"com.primeton.tenant.comProduct.upOrdownProduct.biz.ext";
function upOrDown(types){
	
	s=grid.getSelected ();
	if(s==undefined){
		nui.alert("请选中一行")
		return;
	}
	if(types==1)
 	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '上架中...'
    });
	else
	 	nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '下架中...'
	    });
	   nui.ajax({
           url: upOrDownUrl,
           type: 'post',
           data: nui.encode({
           	params: s,
           	type:types
           }),
           cache: false,
           success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               	nui.alert("成功！");
              	var request;
/*                grid.load(request,function(){
                    nui.alert("数据成功！");
                },function(){
                    nui.alert("数据失败！");
                });*/
                   }else {
                   nui.unmask(document.body);
                   nui.alert("失败！");
                 
               }
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
		});
}