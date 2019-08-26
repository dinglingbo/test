/**
 * Created by steven on 2018/1/31.
 */
var gridUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.querySysProduct.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var typeList = [{id:0,name:"功能模块"},{id:1,name:"接口调用"}];
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
    grid.load();
    grid.on("drawcell", function (e) {
        var record = e.record;
        if (e.field == "type") {
        	if(typeList && typeList[e.value])
            {
                e.cellHtml = typeList[e.value].name;
            }
        }
        if (e.field == "isDisabled") {
        	if(statusList && statusList[e.value])
            {
                e.cellHtml = statusList[e.value].name;
            }
        }    
    });

});

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


function save(e){
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
        url: webPath + contextPath + "/tenant/productManagerment_view.jsp",
        title: tit, 
        width: 630,  
        height: 250,
        onload: function(){
            var iframe = this.getIFrameEl();      
            iframe.contentWindow.setData(s);
        },
        ondestroy: function (action) {
            grid.load();
        }
    });


}