/**
 * Created by lilium on 2018/5/27.
 */
var baseUrl = apiPath + sysApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var dgGrid;
var queryForm;
var msgCode=null;
var provinceCode = null;
var list = null;
var regionList =null;
var msgButton=null;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var assignStatus;
var beginDate;
var endDate;
var StatusSignHash = {
	    "0":"未审批",
	    "1":"审批通过",
	  };
var DisabledSignHash = {
	    "0":"否",
	    "1":"是"
	};
$(document).ready(function(v)
{	
	beginDate=nui.get("beginDate");
	endDate=nui.get("endDate");
	queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    assignStatus=nui.get("assignStatus");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
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
    init();
    query();   
});
	
   


function init(){
	
}


/*
 *查询
 *
 *
 **/
function query(){
   var data = queryForm.getData();
   var tmpstatus=assignStatus.getValue();
   var tmpbeginDate=beginDate.getValue();
   var tmpendDate=endDate.getValue();
   data.status=tmpstatus;
   data.beginDate=tmpbeginDate;
   data.endDate=tmpendDate;
   var request = {
    		"params":data
    };
   
    dgGrid.load(request,function(){
     
      
    });
    dgGrid.on("drawcell", function (e){
    	onDrawCell(e);
    });
}
function onDrawCell(e)
{
    switch (e.field)
    {
    	case "status":
        if(StatusSignHash && StatusSignHash[e.value])
        {
            e.cellHtml = StatusSignHash[e.value];
        }  
        break;
        case "isDisabled":
            if(DisabledSignHash && DisabledSignHash[e.value])
            {
                e.cellHtml = DisabledSignHash[e.value];
            }  
        break;
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
    	  nui.get("RegionList").setData(data.rs);
    });
}
var msgUrl = baseUrl + "com.primeton.tenant.reView.MsgReport.biz.ext";
function sendMsg(){
	
	var params={};
	params.phone=nui.get("phone").getValue();
    nui.ajax({
        url : msgUrl,
        data : {
        	params:params,
            token: token
        },
        type : "post",
        success : function(data) {
        	if(data.data.Code=="OK")
        		{
        		msgCode=data.data.msgCode;
        		settime(10);
        		}
        	else {
        		alert(data.data.Message);
        	}
        	
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
	
}
function submit(){
	var form = new mini.Form("#form1");            
	var formdata = form.getData();  
	formdata.msgCode=$("#msgCode").val();
	vaild(formdata);
	
}
function vaild(formdata){
	if(formdata.phone==""||formdata.phone.length!=11)
		nui.alert("请输入正确的手机号！");
	else if(formdata.msgCode==""||formdata.msgCode.length!=6)
		nui.alert("请输入正确的验证码！");
	else if(formdata.userName=="")
		nui.alert("请输入用户姓名！");
	else if(formdata.orgId=="")
		nui.alert("请输入公司！");
	else if(formdata.ProvinceList=="")
		nui.alert("请选择省份！");
	else if(formdata.RegionList=="")
		nui.alert("请选择区域！");
	else if(msgCode==null)
		nui.alert("请获取验证码！");
	else if(formdata.msgCode!=msgCode)
		nui.alert("验证码不匹配！");
	else {
		{
			save(formdata);
			msgCode=null;
		}
	}
}
var saveUrl = baseUrl + "com.primeton.tenant.reView.saveRegist.biz.ext";
function save(formdata){
	 nui.ajax({
	        url : saveUrl,
	        data : {
	        	params:formdata,
	            token: token
	        },
	        type : "post",
	        success : function(data) {
	        	if(data.errCode=='S'){
	        		nui.alert("成功");
	        	}else if(data.errCode=='E'){
	        		nui.alert("失败");
	        	}
	        	
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	           console.log(jqXHR.responseText);
	        }
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

/**
 * 
 * 审核
 * 
 */
var auditUrl = baseUrl + "com.hsapi.system.tenant.register.auditRegister.biz.ext";// com.primeton.tenant.reView.review
function auditPart(){
	var s=dgGrid.getSelected ();
	if(s){
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '认证中...'
        });

        nui.ajax({
            url : auditUrl,
            type : "post",
            data : JSON.stringify({
                reg: s,
                type :'PART',
                token:token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("认证成功!","",function(e){
                        dgGrid.reload();
                    });
                } else {
                    nui.alert(data.errMsg || "认证失败！");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });

	    
	}else{
		  nui.alert("请选中一条数据！！");
	}
	
}

function auditRepair(){
	var s=dgGrid.getSelected ();
	if(s){
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '认证中...'
        });

        nui.ajax({
            url : auditUrl,
            type : "post",
            data : JSON.stringify({
                reg: s,
                type :'REPAIR',
                token:token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("认证成功!","",function(e){
                        dgGrid.reload();
                    });
                } else {
                    nui.alert(data.errMsg || "认证失败！");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });

	    
	}else{
		  nui.alert("请选中一条数据！！");
	}
	
}
/*
 *设置时间菜单
 **/
function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
    query();    
}

/**
 * 
 * 审核
 * 
 */
var shUrl = baseUrl + "com.primeton.tenant.reView.stopUse.biz.ext";
function stopUse(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
		
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '禁用/启用中...'
	    });
        nui.ajax({
            url: shUrl,
            type: 'post',
            data: nui.encode({
            	params: s
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	nui.alert("禁用/启用成功！");
                	dgGrid.reload();
                    }else {
                    nui.unmask(document.body);
                    nui.alert("禁用/启用失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
	    dgGrid.reload();
	}
	else{
		  nui.alert("请选中一条数据！！");
	}
	
}
function changebutton(){
	var s=dgGrid.getSelected ();
	if(s!= undefined ){
	if(s.isDisabled==0){
		
		nui.get(jy).setVisible(true);
		nui.get(qy).setVisible(false);
	}else{
		nui.get(jy).setVisible(false);
		nui.get(qy).setVisible(true);
	}}
}