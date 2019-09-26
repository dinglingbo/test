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
	
    nui.get("startDate").setValue(getMonthStartDate());
    nui.get("endDate").setValue(getMonthEndDate());
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);  
    grid.on("drawcell", function (e) {
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
    		case "status":
    			if(e.value == 0){
    		        e.cellHtml = "待支付"; 	
    			}else if(e.value == 1){
    		        e.cellHtml = "已支付"; 
    			}else{
    		        e.cellHtml = "已取消"; 
    			}

    		default:
    	    break;
    	}
    })
    search();

});

function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam() {
	queryForm = new nui.Form("#queryForm");
    var params = queryForm.getData();
    var status = nui.get("status").getValue();
    if(status!=999){   	
    	params.status = status;
    }else{
    	params.status = null;
    }
    
    return params;
}
function wfk(){
	var params={};
	params.status=0;
	doSearch(params);
	}
function doSearch(params) {
    grid.load({
        params:params,
        token:token
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
       	type:types,
       	token:token
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
function exprie(){
	var myDate = new Date();
	var params={};
	var tmp=parseInt(myDate.getMonth())+1;
	params.beginDate=(myDate.getFullYear()+'-'+tmp+'-'+myDate.getDate());
	params.endDate=getNextMonth(myDate);
	doSearch(params);
}
/**
 * 获取下一个月
 *
 * @date 格式为yyyy-mm-dd的日期，如：2014-01-25
 */        
function getNextMonth(date) {
	var date2;
	if(parseInt(date.getMonth())+2==12)
		{
		date2 =  new Date(parseInt(date.getFullYear())+1,1,date.getDate());
		}
		else
		{
		date2 =  new Date(date.getFullYear(),parseInt(date.getMonth())+1,date.getDate());
		}
	date2.setDate(date.getDate() + 30);
	return (date2.getFullYear()+'-'+date2.getMonth()+'-'+date2.getDate());
}