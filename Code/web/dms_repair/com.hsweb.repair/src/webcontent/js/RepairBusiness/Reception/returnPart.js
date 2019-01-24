/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var partGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.qyeryMaintainPartList.biz.ext";
var isChooseClose = 1;//默认选择后就关闭窗体

var rpsPartGrid = null;
var resultData = {};
var tempGrid2 = null;
$(document).ready(function(v)
{
	tempGrid2=nui.get("tempGrid2");
	rpsPartGrid = nui.get("rpsPartGrid");
	rpsPartGrid.setUrl(partGridUrl);
	/*params.guestId = mainData.guestId;
	rpsPartGrid.load({
		params:params,
		token:token
	});*/
	rpsPartGrid.on("rowdblclick",function(e){
		onOk();
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
      }
    });
    nui.get("onOk").focus();
    tempGrid2.on("cellclick",function(e){ 
		var field=e.field;
		var row = e.row;
        if(field=="check" ){
			tempGrid2.removeRow(row);
			partList = tempGrid2.getData();
        }
    });
	document.onkeyup=function(event){
      var e=event||window.event;
      var keyCode=e.keyCode||e.which;//38向上 40向下

      if((keyCode==27))  {  //ESC
          onCancel();
      }
    };
   
});

function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
function getDataAll(){
	var row = partGrid.getSelecteds();
	return row;
}

/*function onOk()
{
	var row = rpsPartGrid.getSelected();
	if(row)
	{
		if(ckcallback){
			var rs = ckcallback(row);
			if(rs){
				 parent.showMsg("此配件已添加,请返回查看!","W");
				return;
			}else{
				if(callback){
					nui.mask({
						el: document.body,
						cls: 'mini-mask-loading',
						html: '处理中...'
					});
                    //把工时的ID绑定上
					row.itemId = itemId;
					callback(row,function(data){
						if(data){
							data.check = 1;
							tempGrid.addRow(data);
						}
					},function(){
						nui.unmask(document.body);
					})
				}
			}
		}else{
			if(callback){
				callback(row,function(data){
					if(data){
						data.check = 1;
						tempGrid.addRow(data);
					}
				})
			}
		}
		resultData.part = row;
		if(isChooseClose == 1){
			CloseWindow("ok");
		}
	}
	else{
		 parent.showMsg("请选择一个配件", "W");
	}
}*/
var partList = [];
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
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel(e) {
    CloseWindow("cancel");
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
}