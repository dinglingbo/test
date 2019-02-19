var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext";
var gridUrl1 = apiPath + repairApi
+ "/com.hsapi.repair.baseData.crud.syncTimesCard.biz.ext";
var tab = null;
var form = null;
var timesCardDetail = null;
var g = null;
var set = null;
var input = null;
var isSharex = null;
//页面标签加载完之后执行，但是修改的数据还没有设置
$(document).ready(function(v) {
	tab = nui.get("tab");
	form = new nui.Form("#dataform1");
	form.setChanged(false);
	
    set = mini.get("setMonth");
    input = mini.get("inputMonth");
    timesCardDetail = nui.get("timesCardDetail");
    mini.get("sellAmt").disable();
    mini.get("totalAmt").disable();
	if(currIsMaster=="1"){
		$("#isSharex").show();
		$("#isSharey").show();
	}else{
		$("#isSharex").hide();
		$("#isSharey").hide();
	}

    //编辑开始前发生
   timesCardDetail.on("cellbeginedit",function(e){
    	if(type =="VIEW")
    	{
    		e.cancel = true;
    	}
    	var row = timesCardDetail.getSelected();
    	if( row.prdtType && (row.prdtType == "2"  || row.prdtType == "1"))
    	{
    		switch (e.field)
    		{
    		   case "oldPrice":
    			   e.cancel = true;
    			   break;
    		   case "qty":
    			   e.cancel = true;
    			   break;
    		   default:
    			   break;
    		}
    	}
    });
   
	nui.get('x').focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
	 };
});



function onValueChangedTimes(e){
	oldAmt = null;
	sellAmt = null;
	var row = timesCardDetail.getSelected();
	/*if(row.prdtType && (row.prdtType == "2"  || row.prdtType == "1"))
	{
		
	}*/
	var oldPrice = isNaN(row.oldPrice);
	var b = isNaN(e.value);
	var sellPrice = isNaN(row.sellPrice);
	if(!oldPrice && !b)
	{
		sellAmt = row.sellPrice*e.value;
		sellAmt = parseFloat(sellAmt).toFixed(2);
	}
	if(!sellPrice && !b)
	{
		oldAmt = row.oldPrice*e.value;
		oldAmt = parseFloat(oldAmt).toFixed(2);
	}
	
	data = {
		sellAmt:sellAmt,
		oldAmt:oldAmt
	   };
	timesCardDetail.updateRow(row,data);	
	
}

function onValueChangedQty(e){
	oldAmt = null;
	sellAmt = null;
	var row = timesCardDetail.getSelected();
	if(row.prdtType==3){
		return;
	}
	var oldPrice = isNaN(row.oldPrice);
	var b = isNaN(e.value);
	var sellPrice = isNaN(row.sellPrice);
	if(!oldPrice && !b){
		oldAmt = row.oldPrice*e.value; 
		oldAmt = parseFloat(oldAmt).toFixed(2);
	}
	if(!sellPrice && !b)
	{
		sellAmt = row.sellPrice*e.value;
		sellAmt = parseFloat(sellAmt).toFixed(2);
	}	
	
	
	data = {
		oldAmt:oldAmt, 
		sellAmt:sellAmt
	};
    timesCardDetail.updateRow(row,data);
}


function onValueChangedOldPrice(e){
	oldAmt = null;
	sellAmt = null;	
	var row = timesCardDetail.getSelected();
	
	var times = isNaN(row.times);
	var b = isNaN(e.value);
	var sellPrice = isNaN(row.sellPrice);
	if(!times && !b)
	{
		oldAmt = row.times*e.value;
		oldAmt = parseFloat(oldAmt).toFixed(2);
	}
	
	if(!times && !sellPrice)
	{
		sellAmt =  row.sellPrice*row.times; 
		sellAmt = parseFloat(sellAmt).toFixed(2);
	}
				
	data = {
		oldAmt:oldAmt, 
		sellAmt:sellAmt
	   };
    timesCardDetail.updateRow(row,data);
}


function onValueChangedSellPrice(e){
	oldAmt = null;
	sellAmt = null;
	var row = timesCardDetail.getSelected();
	var b = isNaN(e.value);
	if(row.prdtType && (row.prdtType == "2"  || row.prdtType == "1" || row.prdtType == "3") )
	{
		if(!b)
		{
			
			sellAmt = row.times*e.value;
			sellAmt = parseFloat(sellAmt).toFixed(2);
		}
		
		oldAmt = row.oldPrice*row.times;
		oldAmt = parseFloat(oldAmt).toFixed(2);
		
		data = {
			sellAmt:sellAmt,
			oldAmt:oldAmt
		   };
		timesCardDetail.updateRow(row,data);	
	}else
	{
		var qty = isNaN(row.qty);
		var oldPrice = isNaN(row.oldPrice);
		if(!b && !qty)
		{
			sellAmt = e.value*row.qty;
			sellAmt = parseFloat(sellAmt).toFixed(2);
		}
		
		if(!qty && !oldPrice)
		{
			oldAmt = row.qty*row.oldPrice;			
			oldAmt = parseFloat(oldAmt).toFixed(2);
		}
		
		data = {
			oldAmt:oldAmt, 
			sellAmt:sellAmt
		   };
	    timesCardDetail.updateRow(row,data);
	 }
}

function onValueChangedSellAmt(e){
	oldAmt = null;
	sellAmt = null;
	var row = timesCardDetail.getSelected();
	var b = isNaN(e.value);
	if(row.prdtType && (row.prdtType == "2"  || row.prdtType == "1" || row.prdtType == "3") )
	{
		if(!b)
		{
			
			sellAmt = e.value/row.times;
			sellAmt = parseFloat(sellAmt).toFixed(2);
		}
		
		oldAmt = row.oldPrice*row.times;
		oldAmt = parseFloat(oldAmt).toFixed(2);
		
		data = {
			sellPrice:sellAmt,
			oldAmt:oldAmt
		   };
		timesCardDetail.updateRow(row,data);	
	}else
	{
		var qty = isNaN(row.qty);
		var oldPrice = isNaN(row.oldPrice);
		if(!b && !qty)
		{
			sellAmt = e.value/row.qty;
			sellAmt = parseFloat(sellAmt).toFixed(2);
		}
		
		if(!qty && !oldPrice)
		{
			oldAmt = row.qty*row.oldPrice;			
			oldAmt = parseFloat(oldAmt).toFixed(2);
		}
		
		data = {
			oldAmt:oldAmt, 
			sellPrice:sellAmt
		   };
	    timesCardDetail.updateRow(row,data);
	 }
}





/*function onDrawSummaryCell(e) {
	var rows = e.data;
    if (e.field == "sellAmt") {
        var total = 0;
        for (var i = 0, l = rows.length; i < l; i++) {
            var row = rows[i];
            var t = row.price * row.quantity;
            if (isNaN(t)) continue;
            total += t;
        }

        e.cellHtml = "总计: " + total;
    }
}
*/
function onDrawSummaryCell(e){ 
	  var rows = e.data;
	  var sumSell = null;
	  var sumOld = null;
	  if(e.field == "sellAmt" || e.field == "oldAmt") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  sumSell += parseFloat(rows[i].sellAmt);
			  sumOld  += parseFloat(rows[i].oldAmt);
		  }
	  } 
	  if(sumSell && sumSell>=0)
	  {   
		  sumSell = sumSell.toFixed(2);
		  nui.get("sellAmt").setValue(sumSell); 
	  }else{
		  nui.get("sellAmt").setValue("0");
	  }
	  if(sumOld && sumOld>=0)
	  {
		  sumOld = sumOld.toFixed(2);
		  nui.get("totalAmt").setValue(sumOld); 
	  }else{
		  nui.get("totalAmt").setValue("0");
	  }
	  
 }

var requiredField = {
	name : "计次卡名称:",
	sellAmt : "销售价格",
	totalAmt : "总价值",
	periodValidity : "有效期",
	salesDeductValue : "提成值"
};

var tcd = {
	times : "次数 :",
	qty : "工时/数量 ",
	oldPrice : "原价",
	sellPrice : "销价 ",
	oldAmt : "原销售金额 ",
	sellAmt : "现销售金额 "
};

var falg = null;
function onOk() {
	falg =  null;
	//var qtyTest = "^[0-9]*[1-9][0-9]*$";
	var yz = /^(\d*)(\.\d{1,2})?$/;
	//var zz = new RegExp(yz);
	g = nui.get("timesCardDetail");
	var data1 = g.getData();
	var data = form.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0)
		{
			//当有效期没有输入月份时，判断单选框是否选择了
			if( key == "periodValidity" && set.checked )
			{
				//跳过本次循环，执行下一次循环,把有效期赋值为-1
				//input.setValue("-1");
				falg = 1;
				continue;
			}else{
				showMsg(requiredField[key] + "不能为空!", "W");
				return;
			}
			
		}

	}
	for ( var key in tcd)
	{
		for (var i = 0; i < data1.length; i++)
		{
			if (data1[i][key] == "" || $.trim(data1[i][key]).length == 0)
			{
				showMsg(tcd[key] + "不能为空!", "W");
				return;
			}

		    if (!yz.test(data1[i][key]))
		    {
				showMsg(tcd[key] + "必须为正数,小数点后最多两位!", "W");
				return;
			}
		}
	}
	saveData();
}
var type = null;
function setData(data) {
	// 跨页面传递的数据对象，克隆后才可以安全使用
	var json = nui.clone(data);
	// 如果是点击编辑类型页面
	if (json.id != null)
	{
		
		if(json.periodValidity==-1){
			json.periodValidity = "";
			input.disable();
			set.setValue(true);
		}
		form.setData(json);
		form.setChanged(false);
		// 计次卡明细查询
		var json1 = nui.encode({
			id : json.id,
			token:token
		});
		nui.ajax({
			url : gridUrl,
			type : 'POST',
			data : json1,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.exception == null) {
					g = nui.get("#timesCardDetail");
					g.setData(returnJson.timesCardDetail);
				} else {
					nui.alert("获取明细失败", "系统提示", function(action) {
						if (action == "ok" || action == "close") {
							// CloseWindow("saveFailed");
							
						}
					});
				}
			}
		});
	}
	if(json && json.type){
		type = json.type;
	}


}

function gridAddRow(datagrid) {
	var grid = nui.get(datagrid);
	grid.addRow();
}

function gridRemoveRow(datagrid) {
	g = nui.get("#timesCardDetail");
	var rows = g.getSelecteds();
	if (rows.length > 0) {
		g.removeRows(rows, true);
	}
}

function setGridData(datagrid, dataid) {
	var grid = nui.get(datagrid);
	var grid_data = grid.getChanges();
	nui.get(dataid).setValue(grid_data);
}

function saveData() {
/*	if(currIsMaster != "1"){
		showMsg("请向总部申请计次卡定义!","W");
		return;
	}*/
	g = nui.get("#timesCardDetail");
	form.validate();
	if (form.isValid() == false)
		return;
	g.validate();
	if (g.isValid() == false)
		return;
	
	var pchsOrderDetailAdd = g.getChanges("added");
	var pchsOrderDetailUpdate = g.getChanges("modified");
	var pchsOrderDetailDelete = g.getChanges("removed");
	var data = form.getData(false, true);
	//设置有效期的值
	if(falg == 1){
		data.periodValidity = -1;
	}
	var time = nui.get("timesCardDetail").getData();
	var json = nui.encode({
		"timesCard" : data,
		"timesCardDetail" : time,
		"pchsOrderDetailAdd" : pchsOrderDetailAdd,
		"pchsOrderDetailUpdate" : pchsOrderDetailUpdate,
		"pchsOrderDetailDelete" : pchsOrderDetailDelete,
		token : token
	});
	
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

	nui.ajax({
		url : gridUrl1,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			nui.unmask(document.body);
			if (returnJson.errCode == 'S') {
				showMsg("保存成功");
				CloseWindow("saveSuccess");
			} else {
				showMsg(returnJson.errMsg||"保存失败","W");
			}
		}
	});
}

function onReset() {
	form.reset();
	form.setChanged(false);
}

function onCancel() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function updateError(e) {

	if (nui.get('x').getValue() == "4") {
		document.getElementById('y').innerHTML = "元";
	} else {

		document.getElementById('y').innerHTML = "%";
	}
}

function addDetail() {
	oldAmt = null;
	sellAmt = null;
	nui.open({
		//// targetWindow: window,,
		url : webPath + contextPath
				+ "/com.hsweb.part.common.partSelectView.flow?token=" + token,
		title : "配件选择",
		width : 1000,
		height : 500,
		allowDrag : true,
		allowResize : false,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.part;
                var times = 1;
				if (part) {
					var prdtId = part.id;
					var prdtName = part.name;
					var prdtType = 3;
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						times:times,
						qty :1,
						oldPrice:0,
						sellPrice:0,
						oldAmt:0,
						sellAmt:0,
						
					};
					grid.addRow(newRow);
				}

			}
		}
	});
}

// 本店套餐录入
function selectPackage() {
	oldAmt = null;
	sellAmt = null;
	nui.open({
		//// targetWindow: window,,
		url : webPath + contextPath
				+ "/com.hsweb.repair.DataBase.packageList.flow?token=" + token,
		title : "本店套餐",
		width : 1000,
		height : 600,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list,
				type:"pkg"
			};
			// params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.package1;
                var times = 1;
                var qty = 1;
				if (part) {
					var prdtId = part.id;
					var oldPrice = part.total;
					var sellPrice = part.amount;
					var prdtName = part.name;
					var prdtType = 1;
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						times:times,
						oldPrice:sellPrice,
						sellPrice:sellPrice,
						oldAmt:sellPrice,
						sellAmt:sellPrice,
						qty:qty,
					};
					grid.addRow(newRow);
				}
			}
		}
	});
}

function selectItem(callback) {
	oldAmt = null;
	sellAmt = null;
	nui.open({
		//// targetWindow: window,,
		url : webPath + contextPath
				+ "/com.hsweb.repair.DataBase.RepairItemMain.flow?token="
				+ token,
		title : "维修项目",
		width : 1000,
		height : 550,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
			// params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.item;

				if (part) {
					var prdtId = part.id;
					var prdtName = part.name;
					var prdtType = 2;
					var itemTime = part.itemTime;
					var amt = part.amt;
					var times = 1;
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						prdtTypeName : prdtType,
						qty :itemTime,
						times:times,	
						oldPrice:amt,
						sellPrice:amt,
						oldAmt:amt,
						sellAmt:amt,
					};
					grid.addRow(newRow);
				}
			}
		}
	});
}

function onDrawCell(e) {
	var hash = new Array("套餐", "项目", "配件");
	
	switch (e.field) {
	case "prdtType":
		e.cellHtml = hash[e.value - 1];
		break;

	}
}



/*
 * 看保存的逻辑流时怎么样的，如果没有值，是否赋值了-1
 * */
function changed(e){
	
	if(set.checked){	
		//把输入框的值清除掉
		 input.setValue("");
		 input.disable();
	}else{
		 
		 input.enable();
	}
	
}


function disableHtml(){
	mini.get("addp").setVisible(false);
	mini.get("addi").setVisible(false);
	mini.get("addr").setVisible(false);
	mini.get("delect").setVisible(false);
	mini.get("save").setVisible(false);	
	mini.get("cancel").setVisible(false);
	//mini.get("toolbar1").
	//添加样式 addClass("miniui");
	//mini.get("tab").addClass("style='width: 100%;height:100%'");
	//表单不可读
	var controls=mini.getChildControls(form);
	for(var i=0,length=controls.length;i<length;i++){
	       controls[i].setReadOnly(true);
	}
}

function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}

//点击发生
/*rpsPartGrid.on("cellclick",function(e){
 var record = e.record;
 //点击的某一列
 var column = e.column;
 var row = rpsPartGrid.getSelected();
 if(column.field == "partName"){
*/

/*
 * function addItem() {
 * 
 * selectItem(function(data) { var item = data.item; var packageItem = { itemId :
 * item.id, itemCode : item.code, itemName : item.name, itemTime :
 * item.itemTime, itemKind : item.itemKind, itemKindName : item.itemKindName,
 * unitPrice : item.unitPrice, amt : item.amt };
 * rightItemGrid.addRow(packageItem); }); }
 */
