var url = webPath + contextPath + "/repair/imag/select-path-back.png";
var baseUrl = apiPath + repairApi + "/";
var queryUrl = baseUrl + "com.hsapi.repair.repairService.svr.getMetalSprayItem.biz.ext";
var selectColor = [];
var pathOpacity = null;
var nowitemspecialflg = null;
var blankGrid = null;
var sellForm = null;
//var data = ["1":"拆装","2":"修复","3":"更换","4":"校正"];
//var statusList = [{id:1,name:"拆装"},{id:2,name:"修复"},{id:3,name:"更换"},{id:4,name:"校正"}];
//var statusHash = {1:"拆装",2:"修复",3:"更换",4:"校正"};
var codeHash = {};
var statusHash = {};
var statusList = {};
var allSpecialItemList = {};
var serviceIdF = null;
$(document).ready(function(){

	/*$("body").on("mouseenter","path",function(e){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});*/
	//初始化参数
	//获取当前页面中可喷漆的面
	sellForm = new nui.Form("#sellForm");
	var self = this;
	this.pathCount = $('#path-list-2').find('path').length;
	//绑定鼠标移动到元素上的事件
	$('path').mouseenter(function(){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});
	$('path').mouseout(function(){
		$(this).attr('stroke','none');
	});
	$("body").on("mouseenter","path",function(e){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});
	//绑定鼠标点击事件
	$('path').bind('click',function(){
		selectPath(this);
	});
	//刷新页面数据
	//self.refreshSpecialData();
	selectColor = ["","#879b08","#2f80af","","#2f80af"];//钣金、喷漆 对应的色值
	pathOpacity = 0.6;
	nowitemspecialflg = 2;//表示选中
	blankGrid = nui.get("blankGrid");
	blankGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
          	 case "blankOptBtn":
          		s =  ' <a class="optbtn" href="javascript:deletItem(\'' + uid + '\')">删除</a>';
                e.cellHtml = s;
                 break;
          	 case "typeCode":
          		 if (statusHash[e.value]) {
                     e.cellHtml = statusHash[e.value] || "";
                 } else {
                     e.cellHtml = "";
                 }
          	 case "itemNameo":
          		 if (e.value==null) {
                     e.cellHtml = record.itemNamet;
                 }
            default:
                break;
        }
    });
	//行选中时发生
	blankGrid.on("select",function(e){
		var row = e.record;
		var dictids= [row.nameId];
	    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+token,{},function(text){
		    if(text.data){
		    	statusList = text.data;
		    	nui.get("setAction").setData(statusList);
		        /*statusList = [{id:1,name:"拆装"},{id:2,name:"修复"},{id:3,name:"更换"}];*/
		    	
		    }
	    });
	});
	
	/*//查找动作接口
	initDicts({
    	chanceType:REPAIR_ACTION//商机
    },function(data){
    	statusList = nui.get("chanceType").value();
    	//statusList = data;
    });*/
	//查找维修动作接口
	var dictids= ['10321'];
    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+token,{},function(text){
	    if(text.data){
	    	statusList = text.data;
	    	for(var i = 0;i<text.data.length;i++){
	    		var temp = text.data[i]
	    		statusHash[temp.customid] = temp.name;
	    		var str = temp.property1 + temp.customid;
	    		codeHash[temp.customid]=str;
	    	}
	    	
	    }
    });
    //查找车对应的部位名称
    var parentid= 10281;
    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDictTree.biz.ext?parentid="+parentid+"&token="+token,{},function(text){
	    if(text.data){
	    	allSpecialItemList = text.data;
	    }
    });
	
});
var dataList = [];
function setData(main){
	serviceIdF = main.id;
	$("#imgShow").attr("src",url);
	//查找已经添加的项目
	var json = nui.encode({
		serviceId:serviceIdF,
		token:token
	});
	nui.ajax({
		url : queryUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			var data = returnJson.data;
			//设置表格数据
			
			/*blankGrid.accept();
			var rows = blankGrid.getData();
			for(var i=0;i<rows.length;i++){
				blankGrid.beginEditRow(rows[i]);
			}*/
			//设置图片数据
			if(data && data.length>0){
				for(var i = 0;i<data.length;i++){
					/*if(data[i].ido && data[i].ido>0){
						dataHash[data[i].ido] = data[i];
					}*/
					$('#path-list-1').find('path').each(function(){
						if($(this).attr('data-cpno') == data[i].msCode){
							 var itemData = getSpecialDataByParam(data[i].msCode);
							 data[i].nameId = itemData.id;
							//$(this).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
							$(this).attr({'fill':selectColor[nowitemspecialflg],'stroke':'none','fill-opacity':pathOpacity,'data-itemspecialflg':nowitemspecialflg});
							
						}
					});
				}
			}
			blankGrid.setData(data);
			dataList = nui.decode(data);
		}
	 });
}


function selectPath(path){
	//选中操作
	var self = this;
	this.lastSelectPath = path;
	
	if(this.nowitemspecialflg == $(path).attr('data-itemspecialflg') && $(path).attr('data-itemspecialflg') != "0"){
		//已经选中，并且与当前选择模式相同（小钣金、大钣金），则取消选中
		$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
		self.removeSpecialForView(path);
	}else{
		//选中、并设置为当前选中模式
		$(path).attr({'fill':self.selectColor[self.nowitemspecialflg],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':self.nowitemspecialflg});
		addSpecialForView($(path).attr('data-cpno'));
	}
}

//删除钣金喷漆项目，点击图形删除
function removeSpecialForView(path){
	var deletRow = null; 
	var row = blankGrid.findRow(function(row){
		if(row.msCode == $(path).attr('data-cpno')){
			deletRow = row;
		}
		
    });
	blankGrid.removeRow(deletRow);
	/*if($(obj).attr('data-wispecialitemflg') == 2){
		//钣金
		$('.special-item-list1').each(function(){
			if(this.dataset.cpno == $(obj).attr('data-cpno')){
				$(this).remove();
			}
		});
	}else{
		//喷漆
		$('.special-item-list2').each(function(){
			if(this.dataset.cpno == $(obj).attr('data-cpno')){
				$(this).remove();
			}
		});
	}*/
	//计算钣金、喷漆总价
	//this.funcCostCal();
}

//添加项目
function addSpecialForView(cpno){
	var data = getSpecialDataByParam(cpno);
	var addItem = {};
	addItem.itemNameo = data.name;
	addItem.msCode = data.customid;
	addItem.nameId = data.id;
	addItem.isPaint = 0;
	addItem.subtotalo = 0;
	addItem.amto = 0;
	addItem.itemTimeo = 1;
	addItem.unitPriceo = 0;
	
	addItem.subtotalt = 0;
	addItem.amtt = 0;
	addItem.itemTimet = 1;
	addItem.unitPricet = 0;
	//addItem.action = null;
	/*var data = {};
	data.itemname = addItem.itemname*/
	blankGrid.addRow(addItem);
	/*var row = blankGrid.findRow(function(row){
		blankGrid.beginEditRow(row);
    });*/
}


//获取对应面的数据
function getSpecialDataByParam(cpno){
	for(var i = 0 ; i < this.allSpecialItemList.length ; i ++){
		if(cpno == this.allSpecialItemList[i].customid){
			return this.allSpecialItemList[i];
		}
	}
}

//列表数据删除
function deletItem(row_uid){
	 var row = blankGrid.getRowByUID(row_uid);
	$('#path-list-1').find('path').each(function(){
		if($(this).attr('data-cpno') == row.msCode){
			$(this).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
			/*if(wilifewealthflg){
				//如果是国寿财项目，删除时要扣除对应的优惠金额
				self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wirealgscdiscount")),"-",2);
			}*/
			blankGrid.removeRow(row);
		}
	});
}

/*循环遍历已有项目
 * $('#path-list-1').find('path').each(function(){
	if($(this).attr('data-cpno') == d[i].cpno && (d[i].riitemspecialflag == 1 || d[i].riitemspecialflag == 2)){
		self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(d[i].wirealgscdiscount),"+",2);
		self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,2,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
		$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg': d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'2'});
	}
});
*/

var updList = [];
var addList = [];
var delList = [];
var changList = [];
function insItem(){
	if(!isEditor){
		showMsg("请输入数字","W");
		return;
	}
	var rows = blankGrid.getData();
	var falg = false;
	for(var i = 0;i<rows.length;i++){
		if( (rows[i].typeCode == "" || rows[i].typeCode == null) && rows[i].isPaint == 0){
			falg = true ;
			break;
		}		
	}
	if(falg){
		showMsg("项目没有选择维修动作或者喷漆","W");
		return;
	}
	
	//获取所有新增行
	var rowAdd = blankGrid.getChanges("added");
	if(rowAdd && rowAdd.length>0){
		for(var i=0;i<rowAdd.length;i++){
			   var codeNum = rowAdd[i].typeCode || "";
			   if(codeNum != null && codeNum != ""){
				   var codeo = codeHash[codeNum];
				   codeo = codeo + rowAdd[i].msCode;
			  	   var insItemo = {
			  	        serviceId:serviceIdF,
			  	        code:codeo,
			  	        cardDetailId:0,
			  	        sourceId:3,
			  	        itemTime:1,
			  	        unitPrice:rowAdd[i].unitPriceo,
			  	        subtotal:rowAdd[i].subtotalo,
			  	        rate:rowAdd[i].rateo,
			  	        amt:rowAdd[i].amto
			  	    };  
			  	  addList.push(insItemo);
			   }
			    if(rowAdd[i].isPaint==1){
			    	var codet = "XTPQ005";
				  	codet = codet + rowAdd[i].msCode;
				    var insItemt = {
				        serviceId:serviceIdF,
				        code:codet,
				        cardDetailId:0,
				        sourceId:3,
				        itemTime:1,
				        unitPrice:rowAdd[i].unitPricet,
				        subtotal:rowAdd[i].subtotalt,
				        rate:rowAdd[i].ratet,
				        amt:rowAdd[i].amtt
				  };
				  addList.push(insItemt);
			    }
			}
	}
	
	//获取所有修改行
	var rowMod = blankGrid.getChanges("modified");
	//判断修改了维修动作的项目,dataList
	
	for(var n = 0;n<rowMod.length;n++){
		for(var k = 0;k<dataList.length;k++){
			if(dataList[k].ido && dataList[k].ido>0){
				if(dataList[k].ido==rowMod[n].ido){
					if(dataList[k].typeCode != rowMod[n].typeCode){
						changList.push(rowMod[n]);
					}
				}
			}
		}
	}
	if(rowMod && rowMod.length>0){
    	for(var i = 0;i<rowMod.length;i++){
    		var idt = rowMod[i].idt || 0;
    		if(idt>0){
    		   if(rowMod[i].isPaint==1){
    			   //修改喷漆
    				var row = rowMod[i];
    	    		serviceId = serviceIdF;
    	            var cardDetailId = 0;
    	            var itemt = {};
    	            itemt.id = row.idt;
    	            itemt.serviceId = serviceIdF;
    	            itemt.amt = row.amtt;
    	            itemt.subtotal = row.subtotalt;	
    	            itemt.rate = row.ratet;
    	            itemt.unitPrice = row.unitPricet;
    	            itemt.itemTime = row.itemTimet;
    	        	updList.push(itemt); 
    		   }else{
    			   //删除喷漆
    			   var itemto = {
    			     cardDetailId:0,
    			     id: idt,
    			     serviceId: serviceIdF
    			   };
    			   delList.push(itemto);
    		   }
    		 
    		}else{
    			if(rowMod[i].isPaint==1){
    				var row = rowMod[i];
    			   var codet = "XTPQ005";
			  	   codet = codet + row.msCode;
			  	   var insItemt = {
			  	        serviceId:serviceIdF,
			  	        code:codet,
			  	        cardDetailId:0,
			  	        sourceId:3,
			  	        itemTime:1,
			  	        unitPrice:row.unitPricet,
			  	        subtotal:row.subtotalt,
			  	        rate:row.ratet,
			  	        amt:row.amtt
			  	    };
			  	   addList.push(insItemt)
    			}
    		}
    		//修改项目,如果有修改动作的，先修改价格，然后执行修改项目接口，typeCodeHash里面的数据有可能是删除了的项目，所以这里需要重新找出真正修改了维修动作的项目
    		var rowo = rowMod[i];
    		serviceId = serviceIdF;
            var cardDetailId = 0;
            var itemo = {
             id:rowo.ido,
		     serviceId:serviceIdF,
		     amt:rowo.amto,
		     subtotal:rowo.subtotalo,	
		     rate:rowo.rateo,
		     unitPrice:rowo.unitPriceo,
		     itemTime:rowo.itemTimeo
            }
        	updList.push(itemo);
            
    	}
    }	
	//获取所有删除行
	var rowDel = blankGrid.getChanges("removed");
	if(rowDel && rowDel.length>0){
    	for(var i = 0;i<rowDel.length;i++){
    		var idt = rowDel[i].idt || 0;
    		if(idt>0){
			   //删除喷漆
			   var row = rowDel[i];
			   var item = {
			   cardDetailId: 0,
			   id: idt,
			   serviceId: serviceIdF
			   }
			   delList.push(item);
    		}
    		//删除项目
    		var rowo = rowDel[i];
    		var itemo = {
		        cardDetailId: 0,
		        id: rowo.ido,
		        serviceId: serviceIdF
    		};
		   delList.push(itemo);
    	}
    }	
  nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
	addItem(addList,function(){
		updItem(updList,function(){
			delItem(delList,function(){
				changedItem(changList,function(){
					CloseWindow("ok");
					nui.unmask(document.body);
				})
				
			})
		})
	});
}

var addF = "S";
function addItem(rows, callback){
	if(rows && rows.length>0){
		var len = rows.length;
    	var num = 0;
		//循环判断是否选择了喷漆
		var addItemList = rows;
		//循环调用接口
		var num = addItemList.length-1;
		for(var i=0;i<addItemList.length;i++){
		    var data = {};
		    data.insItem = addItemList[i];
		    data.serviceId = serviceIdF;
		    var params = { 
		        type:"insert",
		        interType:'item',
		        data:data
		    };
			svrCRUD(params,function(text){
				num = num + 1;
		        var errCode = text.errCode||"";
		        var errMsg = text.errMsg||"";
		        if(errCode == 'E'){
		        	addF = "E";
		        }
		        if(num==len){
			       callback && callback();	
			    }
	        
		    });
		}
	}else{
		callback && callback();
	}
}

var deleF = "S";
function delItem(rows, callback){
	if(rows && rows.length>0){
		var len = rows.length;
    	var num = 0;
		for(var n=0;n<rows.length;n++){
			var item = rows[n];
		    var params = {
		        type:"delete",
		        interType:"item",
		        data:{
		            item: item
		        }
		    };
		    svrCRUD(params,function(text){
		    	num = num + 1;
		        var errCode = text.errCode||"";
		        var errMsg = text.errMsg||"";
		        if(errCode == 'E'){   
		        	deleF = "E"
		        }
		        if(num==len){
		           callback && callback();	
		        }
		    });
		}
		
	}else{
		callback && callback();
	}
}

//修改
var itemF = "S"
function updItem(rows,callback){
	 if(rows && rows.length>0){
		 var params = {
	        type:"update",
	        interType:"item",
	        data:{
	            serviceId: serviceIdF,
	            updList : updList
	        }
	     };
		 svrCRUD(params,function(text){
	         var errCode = text.errCode||"";
	         var errMsg = text.errMsg||"";
	         if(errCode == 'S'){   
	        	 itemF = "S";
	         }else{
	        	 itemF = "E";
	         }
	         callback && callback();
	     });
	 }else{
		 callback && callback(); 
	 }
	
}
var changItF = "S";
var replaceItemUrl =  apiPath + repairApi + "/com.hsapi.repair.repairService.crud.replaceItem.biz.ext";
function changedItem(rows,callback){
	if(rows && rows.length>0){
		var len = rows.length;
    	var num = 0;
    	for(var i = 0;i<rows.length;i++){
    		var codeNum = rows[i].typeCode || "";
    		var ido = rows[i].ido || 0;
    		if(codeNum != null && codeNum != "" && ido>0){
    			var codeo = codeHash[codeNum];
    			codeo = codeo + rows[i].msCode;
    			if(codeo)
    			var rpbItem = {
    					"code":codeo
    			}
    			var json = nui.encode({
    				"rpbItem" :rpbItem,
    				"oldItemId":ido,
    				"serviceId":serviceIdF,
    				"sourceId":3,
    				token : token
    			});
    			nui.ajax({
    				url : replaceItemUrl,
    				type : "post",
    				data : json,
    				success : function(data) {
    					num = num + 1;
    					if (data.errCode == "E") {
    						changItF = "E";
    					} 
    					 if(num==len){
				           callback && callback();	
				        }
    				},
    				error : function(jqXHR, textStatus, errorThrown) {
    					console.log(jqXHR.responseText);
    				}
    			});
    		}
    		
    	}
	}else{
		 callback && callback(); 
	 }
	
}

/*
//修改原价，单价和优惠率改变，小计不改变
function onValueChangedAmtt(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var amtt = el.getValue();
	//var rowOld = blankGrid.getEditorOwnerRow(el);
	//var row = rowOld;
	var row = blankGrid.getSelected();
	var itemTimet = row.itemTimet;
	//var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(amtt<0){
		showMsg("金额不小于0","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(amtt == "" || amtt == null){
		//blankGrid.updateRow(rowOld,row); 
		return;
	}else{
		var ratet = 0;
		//小计
		var subtotalt = row.subtotalt;
		//计算优惠率
		var rateMun = amtt-subtotalt;
		if(rateMun>0){
			ratet = rateMun/amtt;
			ratet = ratet.toFixed(4);
		}
		row.ratet = ratet;
		//计算单价
		var unitPricet = row.unitPricet;
		if(itemTimet>0){
			unitPricet = amtt/itemTimet;
			unitPricet = unitPricet.toFixed(2);
		}
		row.amtt = amtt;
		row.unitPricet = unitPricet;
		//blankGrid.updateRow(rowOld,row);
	}
}

//修改小计，优惠率和单价改变，金额不改变
function onValueChangedSubtotalt(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var subtotalt = el.getValue();
	//var rowOld = blankGrid.getEditorOwnerRow(el);
	var row = blankGrid.getSelected();
	//var row = rowOld;
	var itemTimet = row.itemTimet;
	//var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(subtotalt<0){
		showMsg("金额不小于0","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(subtotalt == "" || subtotalt == null){
		//blankGrid.updateRow(rowOld,row); 
		return;
	}else{
		var ratet = 0;
		//小计
		var amtt = row.amtt;
		//计算优惠率
		var rateMun = amtt-subtotalt;
		if(rateMun>0){
			ratet = rateMun/amtt;
			ratet = ratet.toFixed(4);
		}
		row.ratet = ratet;
		row.subtotalt = subtotalt;
		//blankGrid.updateRow(rowOld,row);
	}
}


//修改原价，单价和优惠率改变，小计不改变
function onValueChangedAmto(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var amto = el.getValue();
	//var row = blankGrid.getEditorOwnerRow(el);
	var row = blankGrid.getSelected();
	//var row = rowOld;
	var itemTimeo = row.itemTimeo;
	//var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(amto<0){
		showMsg("金额不小于0","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(amto == "" || amto == null){
		//blankGrid.updateRow(rowOld,row); 
		return;
	}else{
		var rateo = 0;
		//小计
		var subtotalo = row.subtotalo;
		//计算优惠率
		var rateMun = amto-subtotalo;
		if(rateMun>0){
			rateo = rateMun/amto;
			rateo = rateo.toFixed(4);
		}
		row.rateo = rateo;
		//计算单价
		var unitPriceo = row.unitPriceo;
		if(itemTimeo>0){
			unitPriceo = amto/itemTimeo;
			unitPriceo = unitPriceo.toFixed(2);
		}
		row.amto = amto;
		row.unitPriceo = unitPriceo;
		//blankGrid.updateRow(rowOld,row);
	}
}

//修改小计，优惠率和单价改变，金额不改变
function onValueChangedSubtotalo(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var subtotalo = el.getValue();
	var row = blankGrid.getSelected();
	//var row = blankGrid.getEditorOwnerRow(el);
	//var setSubtotalo = blankGrid.getCellEditor("subtotalo", row);
	//var row = rowOld;
	var itemTimeo = row.itemTimeo;
	//var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(subtotalo<0){
		showMsg("金额不小于0","W");
		//blankGrid.updateRow(rowOld,row);
		return;
	}else if(subtotalo == "" || subtotalo == null){
		//blankGrid.updateRow(rowOld,row); 
		return;
	}else{
		var rateo = 0;
		//小计
		var amto = row.amto;
		//计算优惠率
		var rateMun = amto-subtotalo;
		if(rateMun>0){
			rateo = rateMun/amto;
			rateo = rateo.toFixed(4);
		}
		row.rateo = rateo;
		row.subtotalo = subtotalo;
		//setSubtotalo.setValue(subtotalo);
		//blankGrid.updateRow(rowOld,row);
	}
}*/

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
	CloseWindow("cancel");
}

var typeCodeHash = [];
//var dataHash = [];
//提交单元格编辑数据前激发
var isEditor = true;
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;
	if (e.field == "isPaint"){
		return;
	}
	if(e.field == "typeCode"){
		//处理修改了维修动作的项目
		if(row.ido && row.ido>0){
			typeCodeHash[row.ido] = row;
		}
	}
	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.value = 0;
		isEditor = false;
		e.cancel = true;
	} else {
		isEditor = true;
		var newRow = {};
		if (e.field == "amtt") {
			var amtt = e.value;
			//var orderPrice = record.orderPrice;
			var itemTimet = record.itemTimet;
			if (e.value == null || e.value == '') {
				e.value = 0;
			} else if (e.value < 0) {
				e.value = 0;
			}

			var ratet = 0;
			//小计
			var subtotalt = row.subtotalt;
			//计算优惠率
			var rateMun = amtt-subtotalt;
			if(rateMun>0){
				ratet = rateMun/amtt;
				ratet = ratet.toFixed(4);
			}
			row.ratet = ratet;
			//计算单价
			var unitPricet = row.unitPricet;
			if(itemTimet>0){
				unitPricet = amtt/itemTimet;
				unitPricet = unitPricet.toFixed(2);
			}
			row.amtt = amtt;
			row.unitPricet = unitPricet;
			
			/*var orderAmt = orderQty * orderPrice;

			newRow = {
				orderAmt : orderAmt
			};
			rightGrid.updateRow(e.row, newRow);*/

			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "subtotalt") {
			var subtotalt = e.value;
			if (e.value == null || e.value == ''){
				e.value = 0;
				isEditor = false;
			} else if (e.value < 0) {
				e.value = 0;
				isEditor = false;
			}

			var ratet = 0;
			//小计
			var amtt = row.amtt;
			//计算优惠率
			var rateMun = amtt-subtotalt;
			if(rateMun>0){
				ratet = rateMun/amtt;
				ratet = ratet.toFixed(4);
			}
			row.ratet = ratet;
			row.subtotalt = subtotalt;

		} else if (e.field == "amto") {
			var amto = e.value;
			var itemTimeo = record.itemTimeo;
			if (e.value == null || e.value == '') {
				e.value = 0;
			} else if (e.value < 0) {
				e.value = 0;
			}
			var rateo = 0;
			//小计
			var subtotalo = row.subtotalo;
			//计算优惠率
			var rateMun = amto-subtotalo;
			if(rateMun>0){
				rateo = rateMun/amto;
				rateo = rateo.toFixed(4);
			}
			row.rateo = rateo;
			//计算单价
			var unitPriceo = row.unitPriceo;
			if(itemTimeo>0){
				unitPriceo = amto/itemTimeo;
				unitPriceo = unitPriceo.toFixed(2);
			}
			row.amto = amto;
			row.unitPriceo = unitPriceo;
			

		}else if(e.field == "subtotalo"){
			var subtotalo = e.value;
			if (e.value == null || e.value == '') {
				e.value = 0;
			} else if (e.value < 0) {
				e.value = 0;
			}
			var rateo = 0;
			//小计
			var amto = row.amto;
			//计算优惠率
			var rateMun = amto-subtotalo;
			if(rateMun>0){
				rateo = rateMun/amto;
				rateo = rateo.toFixed(4);
			}
			row.rateo = rateo;
			row.subtotalo = subtotalo;
    		
		}
	}
}


function onDrawSummaryCellItem(e){
	  var rows = e.data;
	  var data = {};
	  /*var itemTotalAmt = 0;
	  var itemTotalPrefAmt = 0;*/
	  var itemAmtt = 0;
      var discountAmtt = 0;
      var subtotalt = 0;
	 /* var partTotalAmt = 0;
	  var partTotalPrefAmt = 0;*/
	  var itemAmto = 0;
	  var discountAmto = 0;
	  var subtotalo = 0;
	  if(e.field == "subtotalo") 
	  {   
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].amtt){
				  itemAmtt += parseFloat(rows[i].amtt);
			  }
			  if(rows[i].subtotalt){
				  subtotalt += parseFloat(rows[i].subtotalt); 
			  }
			  
			  if(rows[i].amto){
				  itemAmto += parseFloat(rows[i].amto);
			  }
			  if(rows[i].subtotalo){
				  subtotalo += parseFloat(rows[i].subtotalo);
			  }
			  
			   
		  }
		  discountAmtt = parseFloat(itemAmtt) - parseFloat(subtotalt);
		  discountAmtt = discountAmtt.toFixed(2);
		  discountAmto = parseFloat(itemAmto) - parseFloat(subtotalo);
		  discountAmto = discountAmto.toFixed(2);
		  data.totalAmtt = itemAmtt;
		  data.totalAmto = itemAmto;
		  data.discountAmto = discountAmto;
		  data.discountAmtt = discountAmtt;
		  sellForm.setData(data);
	  }
}


