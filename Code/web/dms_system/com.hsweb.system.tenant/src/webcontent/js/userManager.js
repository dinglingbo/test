/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";             
var gridUrl = baseUrl + "com.primeton.tenant.comTenant.comTenantQueryBySql.biz.ext";
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
//租户类型：1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店
var tenantTypeHash = {
		"1":"汽修店",
		"2":"汽配店",
		"3":"变速箱维修店",
		"4":"汽贸店",
		"5":"汽贸汽修综合店"
}
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
	
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
    /*var request = {
    		"params":{
    			
    		}
    }; */  
    /*grid.load(request,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！"); 
    });*/
	   getProvince(function(data) {
	        var  list = data.rs;
	        nui.get("provinceId").setData(list);

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
	   search();
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
	case "managerIdentity":
		e.cellHtml = e.value==0?"老板":"员工";
		break;
	case "tenantType":
		e.cellHtml = tenantTypeHash[e.value];
		break;
	default:
    break;
}
}

function search() {
    var param = getSearchParam();
    if(isPay==1){
    	param.isPay = 1;
    }else if(isPay == 0){
    	param.isPay = 0;
    }
   if(isDisabled==1){
    	param.isDisabled = 1;
    }else if(isDisabled == 0){
    	param.isDisabled = 0;
    }
   if(param.endDatet==1){//一周内
	   param.endDates = nui.formatDate(new Date(), 'yyyy-MM-dd');
	   param.endDates = param.endDates + ' 00:00:00';
	   param.endDatee = addDate(param.endDates,7);
   }else if(param.endDatet==2){//一个月内,按照三十天算
	   param.endDates = nui.formatDate(new Date(), 'yyyy-MM-dd');
	   param.endDates = param.endDates + ' 00:00:00';
	   param.endDatee = addDate(param.endDates,30);
   }
   
   if(param.startDatet==1){//本周
	   param.startDates = getWeekStartDate();
	   param.startDatee = addDate(getWeekEndDate(), 1);
   }else if(param.startDatet==2){//本月
	   param.startDates = getMonthStartDate();
	   param.startDatee =addDate(getMonthEndDate(), 1);
   }else if(param.startDatet==3){//本年
	   param.startDates = getYearStartDate();
	   param.startDatee =getYearEndDate();
   }else if(param.startDatet==4){//上年
	   param.startDates = getPrevYearStartDate();
	   param.startDatee = getPrevYearEndDate();
   }
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


var isPay = 1;
function quickSearch1(type) {
    var params = getSearchParam();
    var queryname = "付费";
    switch (type) {
        case 0:
            params.isPay = 0;
            queryname = "免费";
            isPay = 0;
            break;
        case 1:
        	params.isPay =1;
        	isPay = 1;
            queryname = "付费";
            break;
        case 2:
            queryname = "所有";
            isPay = 2;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamedate1");
    menunamedate.setText(queryname);
    search();
}
var isDisabled = 0;
function quickSearch(type) {
    var params = getSearchParam();
    var queryname = "在用";
    switch (type) {
        case 1:
            params.isDisabled = 1;
            queryname = "停用";
            isDisabled = 1;
            break;
        case 0:
        	params.isDisabled =0;
        	isDisabled = 0;
            queryname = "在用";
            break;
        case 2:
            queryname = "所有";
            isDisabled = 2;
            break;
        default:
            break;
    }
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    search();
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
    		//alert("请选中一条记录");
    		showMsg("请选中一条记录","W");
    		return;
    		
    	}
    	if(row.isDisabled == 0){
    		nui.mask({
    	        el : document.body,
    	        cls : 'mini-mask-loading',
    	        html : '禁用中...'
    	    });
    	}else{
    		nui.mask({
    	        el : document.body,
    	        cls : 'mini-mask-loading',
    	        html : '启用中...'
    	    });
    	}
    	
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
                	//nui.alert("禁用成功！");
                	if(row.isDisabled == 0){
                		showMsg("禁用成功","S");
                	}else{
                		showMsg("启用成功","S");
                	}
                	search();
                    }else {
                    nui.unmask(document.body);
                    //nui.alert("禁用失败！");
                    if(row.isDisabled == 0){
                		showMsg("禁用失败","E");
                	}else{
                		showMsg("启用失败","E");
                	}
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
    var view_w = 800;
    var view_d = 400;
    var s;
    if(e == 1){
        tit="查看产品";
    }
    if(e == 2){
        tit="查看订单";
        view_w = 1000;
    }
    if(e == 3){
        tit="查看费用";
    }
    if(e == 4){
        tit="查看发票";
    }
    if(e == 5){
        tit="修改用户";
        var view_w = 580;
        var view_d = 380;
    	s=grid.getSelected();
    	if(s==undefined){
    		//nui.alert("请选中一行")
    		showMsg("请选中一行","W");
    		return;
    	}
    
    }
    nui.open({
        url: webPath + contextPath + "/tenant/userManagerment_view.jsp",
        title: tit, 
        width: view_w, 
        height: view_d,
        onload: function () {
          var iframe = this.getIFrameEl();	
            iframe.contentWindow.ShowGrid(e);
            iframe.contentWindow.SetInitData(s);
        },
        ondestroy: function (action) {  //弹出页面关闭前
       
        	  if(action=="ok"){
        		  showMsg("修改成功","S")
        		  search();
        	  }
           	   // var params;
           	   
               // nui.alert("修改成功！");
               /* grid.load(params,function(){
                    //成功;
                   // nui.alert("数据成功！");
                },function(){
                    //失败;
                    nui.alert("数据失败！");
                });*/
           	    
            
        }
    });


}

function recharge(){
	s=grid.getSelected();
	if(s==undefined){
		//nui.alert("请选中一行")
		showMsg("请选中一行","W");
		return;
	}
	nui.open({
        url: webPath + contextPath + "/tenant/recharge.jsp",
        title: "充值", 
        width: 300, 
        height: 150,
        onload: function () {
          var iframe = this.getIFrameEl();	
            iframe.contentWindow.ShowGrid(e);
            iframe.contentWindow.SetInitData(s);
        },
        ondestroy: function (action) {  //弹出页面关闭前
       
        	  if(action=="ok"){
        		  showMsg("修改成功","S")
        		  search();
        	  }
        }
    });

}
function dataProcessing(){
    nui.open({
        url: webPath + contextPath + "/com.hsweb.system.dataProcessing.dataProcessing.flow?token="+token,
        title: "数据清除", 
        width: "90%", 
        height: "90%",
        onload: function () {

        },
        ondestroy: function (action) {  //弹出页面关闭前    
        	  if(action=="ok"){
        		  showMsg("清除成功！","S")
        	  }
           	   // var params;
           	   
               // nui.alert("修改成功！");
               /* grid.load(params,function(){
                    //成功;
                   // nui.alert("数据成功！");
                },function(){
                    //失败;
                    nui.alert("数据失败！");
                });*/
           	    
            
        }
    });
}