/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var queryOldMaintain = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldMaintain.biz.ext";
var queryOldItemPart = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldItemPart.biz.ext";
var grid = null;
var grid2 = null;
var servieTypeList = [];
var servieTypeHash = {};
//var statusList = [{id:"0",name:"客户名称"},{id:"1",name:"客户电话"},{id:"2",name:"会员卡名称"}];
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid2 = nui.get("datagrid2");
	grid3 = nui.get("datagrid3");


   
  /*  var params = {
    		startDate:sdate,
    		endDate:date
    };*/ 
    grid.setUrl(queryOldMaintain);
    
/*    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
   
    grid2.on("drawcell", function (e) {
        switch (e.field) {
            case "serviceTypeId":
            	e.cellHtml = servieTypeHash[e.value].name;
                break;
            case "recordDate":
            	if(e.value.indexOf(".") > -1){
            		e.cellHtml = e.value.substring(0, e.value.indexOf(".")-3);
            	}
                break;
            default:
                break;
        }
    });*/
});

function search(){
	grid2.setData([]);
	grid3.setData([]);
	//var carNo = nui.get("carNo").getValue();
	var params = {
			carNo:carNo
	}
	var json1 = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryOldMaintain,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			grid.setData(text.oldMaintain);
					
		}
	});
}







// 当选择列时
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var row = grid.getSelected();
	var serviceCode = row.serviceCode;
	var params = {};
	params.serviceCode = serviceCode;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryOldItemPart,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			grid2.setData(text.oldPart);
			grid3.setData(text.oldItem);
		}
	});
}

