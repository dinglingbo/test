/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var straGrid = null;
var rightGuestGrid = null;
var rightPartGrid = null;
//var rightUnifyGrid = null;
var mainTabs = null;
var priceList=[];
var priceHash={};
var straGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySellStrategyWithUnity.biz.ext";
var rightGuestGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStrategyGuest.biz.ext";
var rightPartGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStrategyStock.biz.ext";
var rightUnifyGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryUnifyPrice.biz.ext";
$(document).ready(function(v)
{
    mainTabs = nui.get("mainTabs");
	straGrid = nui.get("straGrid");
    straGrid.setUrl(straGridUrl);
    straGrid.load({token:token},function(){
    	var row= straGrid.getRow(0);
    	var guestInfo=mainTabs.getTab("guestInfo");
        if(row){
        	straGrid.select(row,true);
        	mainTabs.updateTab(guestInfo, { visible: false });
        	nui.get('saveStraPart').setVisible(false);
        	nui.get('saveUnifyPart').setVisible(true);
        	nui.get('deleteNode').disable();
        }
    });
    
    rightGuestGrid = nui.get("rightGuestGrid");
    rightGuestGrid.setUrl(rightGuestGridUrl);

    rightPartGrid = nui.get("rightPartGrid");
//    rightPartGrid.setUrl(rightPartGridUrl);

//    rightUnifyGrid = nui.get("rightUnifyGrid");
//    rightUnifyGrid.setUrl(rightUnifyGridUrl);
    
    rightPartGrid.on("drawcell",function(e){
    	var row=straGrid.getSelected();
    	var field=e.field;
    	var record=e.record;
    	var partId=record.partId;
    	if(row._id==1){
    		//不用处理
    	}else{
    		if(field=='strategyId' && priceHash[partId] && !e.value){
    			e.value=priceHash[partId].strategyId || null;
    			e.cellHtml=priceHash[partId].strategyId || '';
//    			record.strategyId=priceHash[partId].strategyId || null;
    		}
    		if(field=='sellPrice' && priceHash[partId] && !e.value){
    			e.value=priceHash[partId].sellPrice || null;
    			e.cellHtml=priceHash[partId].sellPrice || '';
//    			record.sellPrice=priceHash[partId].sellPrice || null;
    		}
    		if(field=='operator' && priceHash[partId] && !e.value){
    			e.value=priceHash[partId].operator || null;
    			e.cellHtml=priceHash[partId].operator || '';
//    			record.operator=priceHash[partId].operator || '';
    		}
			if(field=='operateDate' && priceHash[partId] && !e.value){
				e.value=priceHash[partId].operateDate || null;
				e.cellHtml=priceHash[partId].operateDate || '';
//				record.operateDate=priceHash[partId].operateDate || null;
    		}
    	}
    });
    $("#queryCode").bind("keydown", function (e) {
    	
        if (e.keyCode == 13) {
        	var row =straGrid.getSelected();
        	if(row._id==1){
        		 onUnifySearch();
        	}else{
        		
        		onPartSearch();
        	}
        }
        
    });
    $("#namePy").bind("keydown", function (e) {

        if (e.keyCode == 13) {
        	var row =straGrid.getSelected();
    		if(row._id==1){
    			 onUnifySearch();
        	}else{
        		onPartSearch();
        	}
        }
        
    });
    $("#fullName").bind("keydown", function (e) {

        if (e.keyCode == 13) {
        	var row =straGrid.getSelected();
    		if(row._id==1){
			  onUnifySearch();
        	}else{
        		onPartSearch();
        	}
        }
        
    });
    $("#queryCodeSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#namePySearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });
    $("#fullNameSearch").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            onUnifySearch();
        }
        
    });

});

var StrategyPriceUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStrategyPrice.biz.ext";
function getStrategyPrice(){
	priceList=[];
	priceHash={};

	var row=straGrid.getSelected();
	var strategyId=row.id;
	var data=rightPartGrid.getData();
	if(data.length<=0) return;

	if(strategyId == null || strategyId == "") {
		return;
	}
		
	var partIdList = data.map(function(obj,index){
	    return obj.partId;
	}).join(",");
	
	
	var params={
		strategyId:strategyId,
		partIdList: partIdList
	}
	nui.ajax({
		url :StrategyPriceUrl,
		data :{params:params,token:token,pageSize:50,pageIndex:0,page:{begin:0,length:50}},
		type : "post",
		async:false,
		success:function(data){
			nui.unmask(document.body);
			priceList = data.list || [];
			console.log(priceList);
			priceList.forEach(function(v){
				priceHash[v.partId]=v;
			});
			console.log(priceHash);
		}
	});
}

function OnrpMainGridCellBeginEdit(e){
	 var row = e.row;
	 if(row._id==1){
		 e.cancel = true; 
	 }
}
function onStraGridClick(e){
    var row = e.row;
    var guestInfo=mainTabs.getTab("guestInfo");
    if(row._id==1){
    	mainTabs.updateTab(guestInfo, { visible: false });
    	nui.get('saveStraPart').setVisible(false);
    	nui.get('saveUnifyPart').setVisible(true);
    	nui.get('deleteNode').disable();
    	
    }else{
		mainTabs.updateTab(guestInfo, { visible: true });
		nui.get('saveStraPart').setVisible(true);
    	nui.get('saveUnifyPart').setVisible(false);
    	nui.get('deleteNode').enable();
    	
    }
    var tab = mainTabs.getActiveTab();
    var strategyId = row.id||0;
    var params = {strategyId: strategyId,token:token};
    if(tab.name == "guestInfo"){
        rightGuestGrid.load({params:params});
    }else if(tab.name == "partInfo"){
    	if(row._id ==1){
    		nui.get('onPartSearch').setVisible(false);
        	nui.get('onUnifySearch').setVisible(true);
    		rightPartGrid.setUrl(rightUnifyGridUrl);
    		rightPartGrid.load({params:{},token:token});
    		
    	}else{
    		rightPartGridLoad();
    		nui.get('onPartSearch').setVisible(true);
        	nui.get('onUnifySearch').setVisible(false);
    	}
    }
}

function onMoreTabChanged(e){
    var row = straGrid.getSelected();
    if(!row)return;
	var tab = e.tab;
    var name = tab.name;
    if(row.id){
    	var strategyId=row.id;
    }
    var params = {strategyId: strategyId,token:token};
    if(name == "guestInfo"){
        rightGuestGrid.load({params:params});
    }else if(name == "partInfo"){
    	if(row._id ==1){
    		nui.get('onPartSearch').setVisible(false);
        	nui.get('onUnifySearch').setVisible(true);
    		rightPartGrid.setUrl(rightUnifyGridUrl);
    		rightPartGrid.load({params:{},token:token});
    	}else{
    		rightPartGridLoad();
    		nui.get('onPartSearch').setVisible(true);
        	nui.get('onUnifySearch').setVisible(false);
    	}
    }
}
function rightPartGridLoad(){
	var row=straGrid.getSelected();
	var strategyId=row.id;
	var params = {strategyId: strategyId,token:token};
	
	rightPartGrid.setUrl(rightPartGridUrl);
	rightPartGrid.load({params:params},function(){
		getStrategyPrice();
		var data=rightPartGrid.getData();
		var list=[];
		var newRow={};
		for(var i=0;i<data.length;i++){
			newRow.sellPrice="";
			for(var j=0;j<priceList.length;i++){
				if(data[i].partId==priceList[j].partId){
					newRow.strategyId=priceList[j].strategyId;
					newRow.sellPrice=priceList[j].sellPrice;
					newRow.operator=priceList[j].operator;
					newRow.operateDate=priceList[j].operateDate;
				}
			}	
			rightPartGrid.updateRow(data[i],newRow);
			newRow={};	
		}
	});     	
}
function onGuestSearch() {
    var row = straGrid.getSelected();
    if(row && row.id){
        var params = {};
        params.strategyId = row.id;
        params.namePy = nui.get("GuestNamePy").getValue().replace(/\s+/g, "");
        params.fullName = nui.get("GuestFullName").getValue().replace(/\s+/g, "");
        rightGuestGrid.load({params:params,token:token});
    }
}
function onPartSearch() {
	
    var row = straGrid.getSelected();
    if(row && row.id){
        var params = {};
        params.strategyId = row.id;
        params.queryCode = nui.get("queryCode").getValue().replace(/\s+/g, "");
        params.namePy = nui.get("namePy").getValue().replace(/\s+/g, "");
        params.fullName = nui.get("fullName").getValue().replace(/\s+/g, "");
        rightPartGrid.load({params:params,token:token},function(){
        	getStrategyPrice();
        	var data=rightPartGrid.getData();
			var list=[];
			var newRow={};
			for(var i=0;i<data.length;i++){
				newRow.sellPrice=priceList[j].sellPrice;
				for(var j=0;j<priceList.length;i++){
					if(data[i].partId==priceList[j].partId){
						newRow.strategyId=priceList[j].strategyId;
						newRow.sellPrice=priceList[j].sellPrice;
						newRow.operator=priceList[j].operator;
						newRow.operateDate=priceList[j].operateDate;
					}
				}	
				rightPartGrid.updateRow(data[i],newRow);
				newRow={};	
			}
        });
    }
}
function onUnifySearch() {
    var params = {};
    params.queryCode = nui.get("queryCode").getValue().replace(/\s+/g, "");
    params.namePy = nui.get("namePy").getValue().replace(/\s+/g, "");
    params.fullName = nui.get("fullName").getValue().replace(/\s+/g, "");
    rightPartGrid.load({params:params,token:token});
 
}
function onAddNode()
{
    var newRow = {};
    straGrid.addRow(newRow);
}
var saveStraUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveSellStrategy.biz.ext";
function onSaveNode(){
    var data = straGrid.getChanges();
    if(data.length<=0) return;
    var addList = straGrid.getChanges("added");
    var updateList = straGrid.getChanges("modified");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraUrl,
        type : "post",
        data : JSON.stringify({
            addList : addList,
            updateList : updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                straGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
//删除策略价格节点
var delNodeUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.deleteSellStratefy.biz.ext";
function onDeleteNode(){
	var data = straGrid.getSelected();
	if(data._id==1) return;
	var id=data.id;
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '删除中...'
    });
	
	nui.ajax({
        url : delNodeUrl,
        type : "post",
        data : JSON.stringify({
            id : id,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("删除成功!","S");
                straGrid.reload();
                
            } else {
                showMsg(data.errMsg || "删除失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
	
}
var supplier = null;
function selectSupplier(elId) {
    var row = straGrid.getSelected();
    if(!row) {
        showMsg("请选择对应级别再添加客户!","W");
        return;
    }
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                
                //判断是否已经添加
                var strategyId = checkStraGuest(value);
                if(strategyId<=0){
                    var row = straGrid.getSelected();
                    var newRow = {
                        strategyId : row.id,
                        guestId: value,
                        fullName: text,
                        shortName: supplier.shortName
                    };
                    rightGuestGrid.addRow(newRow);
                }else{
                    var row = straGrid.findRow(function(row){
                        if(row.id == strategyId){
                            return true;
                        }
                    });
                    var name = "";
                    if(row && row.name){
                        name = '--'+row.name;
                    }
                    showMsg("此客户已经添加"+name+"!","W");
                } 

            }
        }
    });
}
var checkStraGuestUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getSellPriceGuest.biz.ext";
function checkStraGuest(guestId){
    var row = rightGuestGrid.findRow(function(row){
        if(row.guestId == guestId) {
            return true;
        }
        return false;
    });
    if(row){
        return row.strategyId||0;
    }

    var strategyId = 0;
    nui.ajax({
        url : checkStraGuestUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
            guestId : guestId,
            token: token
        }),
        success : function(data) {
            data = data || {};
            var guest = data.guest;
            if (guest && guest.length>0) {
                strategyId = guest[0].strategyId;
            } else {
                strategyId = 0;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            strategyId = 0;
        }
    });
    return strategyId;
}
var saveStraGuestUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStrategyGuest.biz.ext";
function saveStraGuest(){
    var row = straGrid.getSelected();
    if(!row) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }
    var data = rightGuestGrid.getChanges();
    if(data.length<=0) return;
    
    var addList = rightGuestGrid.getChanges("added");
    var deleteList = rightGuestGrid.getChanges("removed");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraGuestUrl,
        type : "post",
        data : JSON.stringify({
            stragegyId: row.id,
            addList : addList,
            deleteList : deleteList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                rightGuestGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function delStraGuest(){
    var row = straGrid.getSelected();
    if(!row.id) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }

    var rows = rightGuestGrid.getSelecteds();
    if(rows && rows.length>0){
        rightGuestGrid.removeRows(rows);
    }
}
function importPart(){
    var row = straGrid.getSelected();
    row = row||{};
    if(!row || !row.id) {
//        showMsg("请先选择对应级别再操作!","W");
//        return;
    	importUnifyPart();
    	return;
    }

    var changes = rightPartGrid.getChanges();
    if(changes.length>0){
        showMsg("请先保存数据!","W");
        return;
    }

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.importPartPrice.flow?token="+token,
        title: "价格导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {};
            data.strategyId = row.id;
            data.type = "strategy";
            iframe.contentWindow.initData(data);
        },
        ondestroy: function (action)
        {
            rightPartGrid.reload();
        }
    });
}
function selectPart(callback, checkcallback) {
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,
        title : "配件选择",
        width : 930,
        height : 560, 
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setCloudPartData("cloudPart",callback,checkcallback);
        },
        ondestroy : function(action) {
        }
    });
}
function addPart() {

    var row = straGrid.getSelected();
    if(!row) {
        showMsg("请选择对应级别再添加配件!","W");
        return;
    }

    selectPart(function(data) {
        var part = data.part;
        addPartDetail(part, row.id);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        var rtn = checkPartIDExists(partid);
        return rtn;
    });
}
function checkPartIDExists(partid){
    // var row = rightUnifyGrid.findRow(function(row){
    //     if(row.partId == partid) {
    //         return true;
    //     }
    //     return false;
    // });
    
    // if(row) 
    // {
    //     return "配件ID："+partid+"在列表中已经存在，是否继续？";
    // }
    
    return null;
    
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    } 
}
//function addPartDetail(row, strategyId){
//    var crow = rightUnifyGrid.findRow(function(row){
//        if(row.partId == row.id) {
//            return true;
//        }
//        return false;
//    });
//    if(crow) return;
//
//    var check = checkStraPart(strategyId, row.id);
//    if(check > 0) {
//        //showMsg("此配件已经添加，可直接查询出来修改!","W");
//        return;
//    }
//
//    var newRow = {
//        strategyId : strategyId,
//        partId: row.id,
//        partCode: row.code,
//        fullName: row.fullName
//    };
//    rightPartGrid.addRow(newRow);
//}
var checkStraPartUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getSellPricePart.biz.ext";
function checkStraPart(strategyId, partId){
    var check = 0;
    nui.ajax({
        url : checkStraPartUrl,
        async:false,
        type : "post",
        data : JSON.stringify({
            strategyId: strategyId,
            partId : partId,
            token: token
        }),
        success : function(data) {
            data = data || {};
            var part = data.part;
            if (part && part.length>0) {
                check = 1;
            } else {
                check = 0;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            check = 0;
        }
    });
    return check;
}
function delStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }

    var rows = rightPartGrid.getSelecteds();
    if(rows && rows.length>0){
        rightPartGrid.removeRows(rows);
    }
}
var saveStraPartUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStrategyPart.biz.ext";
function saveStraPart(){
    var row = straGrid.getSelected();
    if(!row.id) {
        showMsg("请先选择对应级别再操作!","W");
        return;
    }
    var addList=[];
    var updateList=[];
    var deleteList=[];
    var data = rightPartGrid.getChanges();
    if(data.length<=0) return;
    for(var i=0;i<data.length;i++){
    	if(! priceHash[data[i].partId]){
    		data[i].strategyId =row.id;
    		addList.push(data[i]);
    	}else if(priceHash && priceHash[data[i].partId]){
    		data[i].strategyId =row.id;
    		updateList.push(data[i]);
    	}
    }
//    var addList = rightPartGrid.getChanges("added");
//    var deleteList = rightPartGrid.getChanges("removed");
//    var updateList = rightPartGrid.getChanges("modified");

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveStraPartUrl,
        type : "post",
        data : JSON.stringify({
            stragegyId: row.id,
            addList : addList,
            deleteList : deleteList,
            updateList: updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                rightPartGridLoad();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addUnifyPart() {

    selectPart(function(data) {
        var part = data.part;
        addUnifyDetail(part);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        

    });
}
//function addUnifyDetail(row){
//    var newRow = {
//        partId: row.id,
//        partCode: row.code,
//        fullName: row.fullName
//    };
//    rightUnifyGrid.addRow(newRow);
//}
function delStraGuest(){

    var rows = rightGuestGrid.getSelecteds();
    if(rows && rows.length>0){
        rightGuestGrid.removeRows(rows);
    }
}
var saveUnifyUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePartPrice.biz.ext";
function saveUnifyPart(){

    var data = rightPartGrid.getChanges();
    if(data.length<=0) return;
    var addList = [];
    var deleteList = [];
    var updateList = [];
//    var addList = rightUnifyGrid.getChanges("added");
//    var deleteList = rightUnifyGrid.getChanges("removed");
//    var updateList = rightUnifyGrid.getChanges("modified");
    for(var i=0;i<data.length;i++){
    	if(data[i].operateDate==null){
    		addList.push(data[i]);
    	}else{
    		updateList.push(data[i]);
    	}
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveUnifyUrl,
        type : "post",
        data : JSON.stringify({
            addList : addList,
            deleteList : deleteList,
            updateList: updateList,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                rightPartGrid.reload();
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
//function delUnifyPart(){
//    var rows = rightUnifyGrid.getSelecteds();
//    if(rows && rows.length>0){
//        rightUnifyGrid.removeRows(rows,true);
//    }
//}
function importUnifyPart(){
    
    var changes = rightPartGrid.getChanges();
    if(changes.length>0){
        showMsg("请先保存数据!","W");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.importPartPrice.flow?token="+token,
        title: "价格导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {};
            data.type = "unify";
            iframe.contentWindow.initData(data);
        },
        ondestroy: function (action)
        {
        	rightPartGrid.reload();
        }
    });
}