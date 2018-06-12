/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var storeUrl = baseUrl + "com.hsapi.system.confi.paramSet.getStoreList.biz.ext";


var grid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var queryForm;
var provinceCode;
nui.parse();
var productStatus;
var types;

var SignHash = {
	    "0":"否",
	    "1":"是"
	};

accountTypeList = [{ id: 1, name: "启用" },{ id: 0, name: "不启用" }];



$(document).ready(function(v) {
	

	getStoreList(function(data) {
		var storeList=[];
		storeList = data.data;
		nui.get("defaultStore").setData(storeList);
	});
	getProvince(function(data) {
	        list = data.rs;
	        nui.get("provinceId").setData(list);

	    });
			
});


/*
 * 
 * 获取仓库列表*/
var storeUrl = baseUrl + "com.hsapi.system.confi.paramSet.getStoreList.biz.ext";
function getStoreList(callback){
    nui.ajax({
        url: storeUrl,
        type: 'post',
        data: nui.encode({
        }),
        cache: false,
        success: function (data) {
            if (data) {
             callback(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
	
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
    grid.load({
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
  
/*    getProvince(function(data) {
    	  nui.get("cityId").setData(data.rs);
    });*/
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
            grid.load(request,function(){
                //成功;
              
            	 nui.alert("数据成功！");
            },function(){
                //失败;
                nui.alert("数据失败！");
            });
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
                grid.load(request,function(){
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



var upOrDownUrl=baseUrl +"com.primeton.tenant.comProduct.upOrdownProduct.biz.ext";
function upOrDown(types,iscopy){
	
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
                grid.load(request,function(){
                    nui.alert("数据成功！");
                },function(){
                    nui.alert("数据失败！");
                });
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

/*

*
*免责条款处理
*/
var orderPrintUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveDisclaimer.biz.ext";
function orderPrintSet(type,iscopy){
	
	var content;
	var keyidId;
	var s={};
	var e;
	keyidId=type;
	if(type=='repair_sett_print_content'){
		
		e=$("#settArea");//获取textarea的id  
		content=e.val();
		if(content==''){
			nui.alert('不能保存空内容');
			return ;
		}
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存结算打印单中...'
	    });
		}
	else{
		
		 e=$("#entrustArea");//获取textarea的id  
		content=e.val();
		if(content==''){
			nui.alert('不能保存空内容');
			return ;
		}
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存委托打印单中...'
	    });
		}
	
	s.content=content;
	s.keyidId=keyidId;
	nui.ajax({
		url:orderPrintUrl,
		type:"post",
		data:{
			params:s
		},
		success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               	if(iscopy==0)
               	nui.alert("保存成功！");
               	}
				else{
				nui.unmask(document.body);
				if(iscopy==0)
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
	if(iscopy==1){
		
	    e.select(); //选择textarea的文本内容  
	    document.execCommand("Copy"); //执行浏览器复制命令  
	    nui.alert("保存并复制成功！");
	}
}
/*
showForm
显示设置操作
*
*
*/
var showFormUrl=baseUrl + "com.hsapi.system.confi.paramSet.saveShowSet.biz.ext";
function showFormSet(){
	
	var form1=new nui.Form("#showForm");
	var formData=form1.getData();
	var s=[{
		keyidId:"repair_careAlarm_default_show",
		keyidValue:formData.repair_careAlarm_default_show
		},{
		keyidId:"repair__service_default_show",
		keyidValue:formData.repair__service_default_show	
		},{
		keyidId:"repair__worklist_default_show",
		keyidValue:formData.repair__worklist_default_show	
		},{
		keyidId:"repair__settorder_print_show",
		keyidValue:formData.repair__settorder_print_show				
		},
		{
		keyidId:"repair__default_store",
		keyidValue:formData.defaultStore				
		}
		];
	nui.ajax({
		url:showFormUrl,
		type:"post",
		data:{
			params:s
		},
		success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               
               	nui.alert("保存成功！");
               	}
				else{
				nui.unmask(document.body);
				
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
}

/*
returnForm
回返操作
*
*
*/
var returnFormUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveReturn.biz.ext";
function returnFormSet(){
	
	var form1=new nui.Form("#returnForm");
	var formData=form1.getData();
	nui.ajax({
		url:returnFormUrl,
		type:"post",
		data:{
			params:formData
		},
		success: function (data) {
               if (data.errCode == "S"){
               
              
               	nui.alert("保存成功！");
               	}
				else{
				
			
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
}
