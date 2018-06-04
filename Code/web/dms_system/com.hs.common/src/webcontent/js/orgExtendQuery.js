/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.hsapi.system.employee.comCompany.comCompanyQuerys.biz.ext";
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
	    "0":"男",
	    "1":"女"
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
    params.name = nui.get("name").getValue();
   

    return params;
}

function doSearch(params) {
    grid.load({
        params:params
    });
}



function edit(action) {    
    
    var comCompay = {};

    if (action == 'new') {
    	nui.ajax({
            url: timeUrl,
            type: 'post',
            data: nui.encode({
            	
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	time=data.rs.time;
                	person=data.rs.person;
                    }else {
                
                    nui.alert("失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
    	});
    } else {
    	var row = grid.getSelected();
    	if (!row) {
    		alert("请选中一条记录");
    		return;
    		
    	}
  
    	
    	comCompay = row;  	
    }

    nui.open({
        url: baseUrl + "/common/orgExtendEdit_view0.jsp",
        width: 1200,      //宽度
        height: 600,    //高度
        title: "分店信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            if(time!=""){
            comCompay.recordDate=time;
            comCompay.recorder=person;
            comCompay.modifyDate=time;
            comCompay.modifier=person;
            }
            iframe.contentWindow.SetData(comCompay);
            time="";
            person="";
        },
        ondestroy: function (action) {  //弹出页面关闭前
        	grid.reload();
            if (action == "OK") {       //如果点击“确定”
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);    //必须。克隆数据。		               
                if(data){
                    btnEdit.setValue(data.value);
                    btnEdit.setText(data.text);
                }
            }
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
            	params: s
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	nui.alert("离职成功！");
                	grid.reload();
                    }else {
                    nui.unmask(document.body);
                    nui.alert("离职失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
        search();
	}
	else{
		  nui.alert("请选中一条数据！！");
	}
	
	
	
	
	
}

/*
*
*
*开通或关闭
*
*/
var stoporstartUrl=baseUrl +"com.hsapi.system.employee.employeeMgr.stopOrStartEmployee.biz.ext";
function stoporstart(){
	
    var emp = {};
    
 
    	var row = grid.getSelected();
    	if (!row) {
    		alert("请选中一条记录");
    		return;
    		
    	}
    	
    	emp = row;  	
    	emp.passWord='000000';
		  nui.open({
		        url: baseUrl + "/common/setAccount.jsp",
		        width: 530,      //宽度
		        height: 180,    //高度
		        title: "设置密码",      //标题 组织编码选择
		        allowResize:true,
		        onload: function () {
		            var iframe = this.getIFrameEl();
		            iframe.contentWindow.SetData(emp);
		        },
		        ondestroy: function (action) {  //弹出页面关闭前
		            if (action == "OK") {       //如果点击“确定”
		                alert('开通帐户成功！');
		                /*var iframe = this.getIFrameEl();
		                var data = iframe.contentWindow.GetData();
		                data = nui.clone(data);    //必须。克隆数据。		               
		                if(data){
		                    alert('1111');
		                }*/
		                
		            }
		        }
		    });	    
    
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
	
	
	