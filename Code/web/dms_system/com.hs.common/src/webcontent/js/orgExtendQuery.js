/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.hsapi.system.tenant.tenant.queryCompany.biz.ext";
var timeUrl = baseUrl + "com.hsapi.system.employee.comCompany.getTime.biz.ext";
var grid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
nui.parse();


var SignHash = {
	    "0":"否",
	    "1":"是"
	};

var sexSignHash = {
	    "1":"男",
	    "0":"女"
	};
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
    var request = {
    		"params":{
    			
    		}    
    }; 
	  var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'code' },
		            { name: 'name' },
	            { name: 'shortName' },
	            { name: 'recorder' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
    grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        showMsg("数据失败!","W");
    });
    initProvince('provinceId',function(){
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
    });
    

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
	case "isOpenSystem":
		e.cellHtml = e.value == 1 ? "禁用" : "启用";
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
    var params = {};
    params.name = nui.get("name").getValue().replace(/\s+/g, "");
   

    return params;
}

function doSearch(params) {
    grid.load({
        params:params
    });
}



function edit(action) {    
    
    var comCompay = {};

    if (action == 'edit') {
    	var comCompay = grid.getSelected();
        if (!comCompay) {
            showMsg("请选中一条记录","W");
            return;
            
        }
    }

    nui.open({
        url: webPath + contextPath + "/com.hs.common.orgExtendEdit.flow?token="+token,
        width: 1200,      //宽度
        height: 600,    //高度
        title: "公司信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetInitData(comCompay);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            grid.reload();
        }
    });	    
}


function openEle(){
	 var comCompay = {};
	 var comCompay = grid.getSelected();
     if (!comCompay) {
         showMsg("请选中一条记录","W");
         return;
         
     }
    nui.open({
        url: webPath + contextPath + "/com.hs.common.openElectronicArcgives.flow?token="+token,
        width: 1200,      //宽度
        height: 600,    //高度
        title: "开通电子档案",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetInitData(comCompay);
        },
        ondestroy: function (action) {  //弹出页面关闭前
	            grid.reload();
	        }
	});	    
}

/*
*
*
*离职
*
*/
var dimssionUrl=baseUrl +"com.hsapi.system.employee.employeeMgr.employeeDimssion.biz.ext";
function dimssion(){
	
	var s=grid.getSelected ();
	if(s!=undefined){
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '离职中...'
	    });
        nui.ajax({
            url: dimssionUrl,
            type: 'post',
            data: nui.encode({
            	params: s,
            	token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	showMsg("离职成功!","S");
                	grid.reload();
                    }else {
                    nui.unmask(document.body);
                    showMsg("离职失败!","S");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
		});
        search();
	}
	else{
		showMsg("请选中一条数据!","W");
	}
	
	
	
	
	
}


	
	

function changebutton(){
	var s=grid.getSelected ();
	if(s!= undefined ){
	if(s.isOpenAccount==0){
		nui.get(jy).setVisible(false);
		nui.get(qy).setVisible(true);
		
	}else{
		nui.get(jy).setVisible(true);
		nui.get(qy).setVisible(false);
	
	}}
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
var stoporstartUrl=baseUrl +"com.hsapi.system.employee.comCompany.stopOrStartCompany.biz.ext";
function stoporstart(i){
	
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
            	params: row,
            	token: token
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	showMsg("操作成功!","S");
                	grid.reload();
                    }else {
                    nui.unmask(document.body);
                    showMsg("操作失败!","W");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
            }
		});
    
	}


	