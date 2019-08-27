/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var partGridUrl = baseUrl+"com.hsapi.part.invoice.partAllot.queryPjPchsOrderEnterDetailChkListBatch.biz.ext";
var queryStoreHouseUrl = apiPath + sysApi + "/" + "com.hsapi.system.tenant.employee.queryMemStoreBytenantId.biz.ext";
var data = {};
var resultData = {};
var queryForm = null;
var partBrandIdHash = {};
var rpsPartGrid = null;
var storehouseAll = [];
var storeHashAll = {};



/*var isChooseClose = 1;//默认选择后就关闭窗体
var resultData = {};
var tempGrid2 = null;*/

$(document).ready(function(v)
{
	queryForm = new nui.Form("#queryForm");
	rpsPartGrid = nui.get("rpsPartGrid");
	rpsPartGrid.setUrl(partGridUrl);
	getStorehouseAll();
	rpsPartGrid.on("rowdblclick",function(e){
		onCommon();
	});
    rpsPartGrid.on("drawcell",function(e)
    {
	  var grid = e.sender;
      var record = e.record;
      var uid = record._uid;
      var rowIndex = e.rowIndex;
      switch (e.field) {
          case "kqty":
          	e.cellHtml = record.qty - record.outReturnQty;
          	break;
          case "partBrandId":
    		 if(partBrandIdHash[e.value])
    	    {
//        	        e.cellHtml = partBrandIdHash[e.value].name||"";
    	    	if(partBrandIdHash[e.value].imageUrl){
    	    		
    	    		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
    	    	}else{
    	    		e.cellHtml =partBrandIdHash[e.value].name||"";
    	    	}
    	    }
    	    else{
    	        e.cellHtml = "";
    	    }
    	    break;
          case "storeId":
            	e.cellHtml = storeHashAll[e.value].name;
            	break;	
          default:
              break;
      }
    });
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        nui.get("partBrandId").setData(partBrandList);
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
   
});

function setData(p,ck,cck){
	callback = ck;
    checkcallback = cck;
	data = p;
	search();
}

function search(){
    var params = queryForm.getData();
    params.partCode = (params.code||"").replace(/\s+/g, "");
    params.partNameAndPY = (params.name||"").replace(/\s+/g, "");
    params.applyCarModel = (params.applyCarModel ||"").replace(/\s+/g, "");
    params.applyCarModel = nui.get("applyCarModel").getValue();
    params.orgid = data.guestOrgid;
	params.notShowAll = 1;
	params.outableQty = 0;
	params.storeId = data.outStoreId;
	rpsPartGrid.load({
		params:params,
		token:token
	});
}

function onCommon()
{
    var node = rpsPartGrid.getSelected();
    var nodec = nui.clone(node);

    if(!nodec)
    {
        return;
    }
   resultData = {
        part:nodec
    };
    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        //需要判断是否已经添加了此配件??
        var checkMsg = checkcallback(resultData);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        callback(resultData);
                    }else {
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            callback(resultData);
        }

    }
 
}


function onCancel(e) {
    CloseWindow("cancel");
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

function getStorehouseAll(){
	var json = {};
	nui.ajax({
 		url : queryStoreHouseUrl,
 		type : "post",
 		data : json,
 		async: false,
 		success : function(data) {
 			storehouseAll = data.storehouse;
 			storehouseAll.forEach(function(v){
                storeHashAll[v.id]=v;
            });
 			
 		},
 		error : function(jqXHR, textStatus, errorThrown) {
 			console.log(jqXHR.responseText);
 		}
 	});	
}




/*var partList = [];
function onOk(){
	var row = rpsPartGrid.getSelected();
	if(row)
	{
		if(ckcallback){
			var rs = ckcallback(row);
			if(rs){
				parent.showMsg("此配件已添加,请返回查看!","W");
				return;
			}else{
			   row.check = 1;
			   var rows= nui.clone(row);
			   tempGrid2.addRow(rows);
			   partList = tempGrid2.getData();
			}
		}
	}else{
		showMsg("请选择一个配件", "W");
	}
}
var callback = null;
var delcallback = null;
var ckcallback = null;
var guestId = null;
function setCkcallback(main,ck){
	isChooseClose = 1;
	ckcallback = ck;
	rpsPartGrid.setWidth("79%");
	tempGrid2.setStyle("display:inline");
	document.getElementById("splitDiv2").style.display="";
	var mainData = main;
	var params = {};
	params.guestId = mainData.guestId;
	guestId = mainData.guestId;
	rpsPartGrid.load({
		params:params,
		token:token
	});
}
function getData(){
    return resultData;
}

function setData(data,ck)
{
	data = data||{};
	list = data.list||[];
    callback = ck;
    
}
var checkcallback = null;
function setCloudPartData(type,ck,cck){
    chooseType = type;
    callback = ck;
    checkcallback = cck;
}



function setValueData(){
	nui.get("state").setValue(6);
	partGrid.showColumn("checkcolumn");
}
function onSearch(){
	var params = {};
	params.serviceCode = nui.get("search-serviceCode").getValue();
	params.partCode = nui.get("search-code").getValue();
	params.partName = nui.get("search-name").getValue();
	params.guestId = guestId;
	rpsPartGrid.load({
		params:params,
		token:token
	});
}

function getPartList(){
	return partList;
}*/
