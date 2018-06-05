/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.primeton.tenant.comOrder.comOrderQuery.biz.ext";
var timeUrl = baseUrl + "com.hsapi.system.employee.comCompany.getTime.biz.ext";
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



$(document).ready(function(v) {

	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
    var request = {
    		"params":{
    			
    		}
    };   
    grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！");
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
    grid.load({
        params:params
    });
}








var closeUrl=baseUrl +"com.primeton.tenant.comOrder.closeComOrder.biz.ext";
function closeOrder(){
	
	s=grid.getSelected ();
	if(s==undefined){
		nui.alert("请选中一行")
		return;
	}
	else if(s.status==1){
		nui.alert("订单已付款，不能关闭")
		return;
	}
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '关闭中...'
    });
   nui.ajax({
       url: closeUrl,
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