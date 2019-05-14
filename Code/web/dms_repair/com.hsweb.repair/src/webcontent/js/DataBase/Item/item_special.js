//工单钣金喷漆逻辑
/*	
		$(document).ready(function(){
		
			$("#imgShow").attr("src","http://127.0.0.1:8080/default/repair/imag/blank.png");
			
		});*/
var woSpecial = {};
woSpecial.prototype = {
	lastSelectPath : null,//最后一次选中元素
	nowitemspecialflg : 2,//1：小钣金 2：大钣金
	itemspecialflg : 0,//1：小钣金 2：大钣金 4：喷漆
	selectColor : ["","#879b08","#2f80af","","#2f80af"],//钣金、喷漆 对应的色值
	pathList1 : [],//选中的钣金LIST
	pathList2 : [],//选中的喷漆LIST
	pathCount : 0,//可喷漆面的总数
	pathOpacity : 0.6,//路径选中的颜色透明度
	specialItemList:[],//项目中已经包含的钣金、喷漆
	allSpecialItemList:[],//所有钣金、喷漆的项目
	allSpecialItemPrice:0,//全车喷漆的原价
	AllSpecialWiid:0,//全车喷漆WIID
	cpno103wiid:0,//前保险杠wiid
	cpno900wiid:0,//后保险杠wiid
	mindiscount1:0,//总价修改不能低于  mindiscount 数值（钣金）
	mindiscount2:0,//总价修改不能低于  mindiscount 数值（喷漆）
	
	selectPath:function(path){
		//选中操作
		var self = this;
		this.lastSelectPath = path;
		if(path.parentNode.parentNode.dataset.pathtype == "1"){
			//钣金
			if(this.nowitemspecialflg == $(path).attr('data-itemspecialflg') && $(path).attr('data-itemspecialflg') != "0"){
				//已经选中，并且与当前选择模式相同（小钣金、大钣金），则取消选中
				$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
				self.removeSpecialForView(path);
			}else{
				//选中、并设置为当前选中模式
				$(path).attr({'fill':self.selectColor[self.nowitemspecialflg],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':self.nowitemspecialflg});
				self.addSpecialForView($(path).attr('data-name'),$(path).attr('data-cpno'),self.nowitemspecialflg,2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),"itemprice"),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'wiid'));//添加钣金
				if(!$('#all-special-btn').hasClass('selected')){
					$('#path-list-2').find('path').each(function(){
						if($(this).attr('data-code') == $(path).attr('data-code')){
							$(this).attr({'class':'selectPath','fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'4'});
							self.addSpecialForView($(this).attr('data-name'),$(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),$(this).attr('data-wispecialitemflg'),self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemprice'),self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'wiid'));
							self.checkSpecialGroup();
						}
					});
				}
			}
		}else{
			//喷漆
			if($(path).attr('data-itemspecialflg') == "4"){
				//取消选中
				$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
				self.removeSpecialForView(path);
			}else{
				//选中
				$(path).attr({'fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'4'});
				self.addSpecialForView($(path).attr('data-name'),$(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),$(path).attr('data-wispecialitemflg'),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemprice'),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'wiid'));
			}
			self.checkSpecialGroup();
		}
		//self.addSpecialForPath(path,$(path).attr('data-itemprice'),$(path).attr('data-itemdiscountprice'));//添加钣金、喷漆项目至列表
	},
	showPathList1:function(){

	},
	showPathList2:function(){

	},
	changeWorkHour:function(eobj){
		if (eobj.id == "bsworkhouradjust") {
			var n = 1;
		} else {
			var n = 2;
		}
		if($(eobj).hasClass("checked")){
			$(eobj).removeClass("checked");
			$(eobj).attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
			$("#sp-itemlist-" + n).css({
				"width": "291px",
				"overflow-x": "hidden",
				"position": "absolute",
				"top": "26px",
				"left": 0,
				"z-index": 0
			});
			$("#sp-itemlist-"+ n +"-title").css({
				"overflow-x": "hidden",
				"position": "absolute",
				"z-index": 0
			});
		}else{
			$(eobj).addClass("checked");
			$(eobj).attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
			$("#sp-itemlist-" + n).css({
				"width": "auto",
				"overflow-x": "auto",
				"position": "absolute",
				"top": "26px",
				"left": 0,
				"z-index": 99
			});
			$("#sp-itemlist-"+ n +"-title").css({
				"width": "auto",
				"position": "absolute",
				"overflow-x": "auto",
				"top": 0,
				"z-index": 99
			});
		}
	},
	changeSelectType:function(type){
		this.nowitemspecialflg = type;
		$('.bsradio').attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
		$('#bsradio'+type).attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
	},
	allSpecial:function(obj){
		var self = this;
		$('.special-item-list2').remove();
		if($(obj).hasClass('selected')){
			$(obj).removeClass('selected');
			$(obj).attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
			$('#path-list-2').find('path').attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
		}else{
			$(obj).addClass('selected');
			$(obj).attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
			$('#path-list-2').find('path').attr({'fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'4'});
			self.addSpecialForView("全车喷漆",1600,4,1,self.allSpecialItemPrice,self.allSpecialItemPrice,1,self.AllSpecialWiid);//添加全车喷漆
		}
		this.funcCostCal();
	},
	//绑定cpno
	bindCpno:function(){

		//this.loadSpecialItem();
		//初始化页面数据
		$('.special-tool').find('input').val(0);
		$('#sp-itemlist-1').empty();
		$('#sp-itemlist-2').empty();
		$('#path-select-fixed-div').find('path').removeAttr('data-itemid');
		$('#path-select-fixed-div').find('path').attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
		$('#path-list-1').find('path').attr({'data-wispecialitemflg':'2'});
		$('#path-list-2').find('path').attr({'data-wispecialitemflg':'1'});
		$('#all-special-btn').attr({'src':contextRoot+'/resources/assets/img/checkbox-0.png'});
		$('#all-special-btn').removeClass('selected');
		$('#bsradio2').attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
		$('#bsradio1').attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
		this.nowitemspecialflg = 2;
		this.allSpecialItemPrice = 0;
		this.specialItemList = [];
		this.allSpecialItemList = [];
		this.AllSpecialWiid = 0;
		this.mindiscount1 = 0;
		this.mindiscount2 = 0;
		var self = this;
		var d = new Object();
		d.carplate = carplate;
		d.orderid = orderid;
		$.ajax({
			url: contextRoot+'/ajax/erp03/orderitemlist1',
			type: "POST",
			async: false,
			data: {jsondata:JSON.stringify(d)},
			dataType: "json",
			timeout:4000,
			error: function (res,stauts) {
				alert("您的网络有问题，请重新加载！");
				throw new Error("ajax异常");
			},
			success: function (data) {
				if(data.rtncd == "0"){
					var d = data.listdata;
					self.allSpecialItemList = d;
					var cpno1600 = null;//全车喷漆
					for(var i = 0 ; i < d.length ; i ++){
						d[i].itemname = d[i].itemname.replace(/大钣金（/gm,'').replace(/小钣金（/gm,'').replace(/喷漆（/gm,'').replace(/点漆（/gm,'').replace(/）/gm,'');
						if(d[i].riitemspecialflag == "0")continue;//非钣金喷漆项目，跳过
						if(d[i].riitemspecialflag == "4" && d[i].cpno != 103 && d[i].cpno != 900 && d[i].cpno != 1600){
							//喷漆项目
							self.allSpecialItemPrice = floatCal(self.allSpecialItemPrice,d[i].itemprice,"+",2);
						}
						if(d[i].wiid == 0)continue;//未在项目中的跳过
						self.specialItemList.push(d[i]);
						if(d[i].cpno == 103){
							//前保险杠
							if(d[i].riitemspecialflag == 1 || d[i].riitemspecialflag == 2){
								//小钣金
								$('#path-list-1').find('path').each(function(){
									if($(this).attr('data-cpno') == "101"){
										self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,2,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
										$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg': d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'2'});
									}
								});
							}else if(d[i].riitemspecialflag == 4){
								//喷漆
								$('#path-list-2').find('path').each(function(){
									if($(this).attr('data-cpno') == "101"){
										self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,1,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
										$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'1'});
									}
								});
							}
						}
						if(d[i].cpno == 900){
							//后保险杠
							if(d[i].riitemspecialflag == 1 || d[i].riitemspecialflag == 2){
								//小钣金
								$('#path-list-1').find('path').each(function(){
									if($(this).attr('data-cpno') == "102"){
										self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,2,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
										$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg': d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'2'});
									}
								});
							}else if(d[i].riitemspecialflag == 4){
								//喷漆
								$('#path-list-2').find('path').each(function(){
									if($(this).attr('data-cpno') == "102"){
										self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,1,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
										$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'1'});
									}
								});
							}
						}
						if(d[i].cpno == 1600){
							cpno1600 = d[i];
							self.AllSpecialWiid = d[i].wiid;
						}
						//遍历并绑定已有的钣金项目
						$('#path-list-1').find('path').each(function(){
							if($(this).attr('data-cpno') == d[i].cpno && (d[i].riitemspecialflag == 1 || d[i].riitemspecialflag == 2)){
								self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(d[i].wirealgscdiscount),"+",2);
								self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,2,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
								$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg': d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'2'});
							}
						});
						//遍历并绑定已有的喷漆项目
						$('#path-list-2').find('path').each(function(){
							if($(this).attr('data-cpno') == d[i].cpno && d[i].riitemspecialflag == 4){
								self.mindiscount2 = floatCal(self.mindiscount2,parseFloat(d[i].wirealgscdiscount),"+",2);
								self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,1,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
								$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'1'});
							}
						});
					}
					if(cpno1600){
						//全车喷漆
						$('#path-list-2').find('path').each(function(){
							$(this).attr({'fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':4,'data-itemid':cpno1600.itemid,'data-wispecialitemflg':'1'});
						});
						$("#all-special-btn").addClass('selected');
						$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
						self.addSpecialForView("全车喷漆","1600","4",1,self.allSpecialItemPrice,self.allSpecialItemPrice,1,self.AllSpecialWiid);
					}
					//woMain.prototype.initPathSelectDiv();
					$('#special-total-price-input1').attr("disabled","disabled");
					$('#special-total-price-input2').attr("disabled","disabled");
					woMain.prototype.showView('path-select-fixed-div');
				}
			}
		});
	},
	//点击视图添加钣金、喷漆至列表   -- 整体刷新
	addSpecialForPath:function(obj){
		//钣金
		var self = this;
		/*$('#sp-itemlist-1').empty();
		$('#path-list-1').find('path').each(function(){
			if($(this).attr('data-itemspecialflg') == "1" || $(this).attr('data-itemspecialflg') == "2"){
				var html ='<div class="special-item-list1" data-cpno="'+ $(this).attr('data-cpno') +'" data-wispecialitemflg="2" data-itemspecialflg="'+$(this).attr('data-itemspecialflg')+'">'+
					'<div style="float:left;width:140px;;height:42px;text-indent:8px;">'+ ($(this).attr('data-itemspecialflg') == "1" ? "小" : "大" )+$(this).attr('data-name')+'</div><div style="float:left;width:100px;;height:42px;text-indent:8px;"><input class="disabled special-price-input1" disabled value="'+ self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemprice') +'" /><input value="'+ self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemdiscountprice') +'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" class="special-discount-input1"/></div>'+
					'<div style="float:left;text-align:center;">'+
					'<img src="'+contextRoot+'/resources/assets/img/path-type-'+ $(this).attr('data-itemspecialflg') +'.png" style="height:25px;margin:0 auto;cursor:pointer;"onclick=\"woSpecial.prototype.changeSpecialType(this);\"/>'+
					'</div>'+
					'<div style="float:right;width:40px;height:42px;text-align:center;margin-right:10px;">'+
					'<img src="'+contextRoot+'/resources/assets/img/del-s-btn.png" style="height:20px;margin:0 auto;;cursor:pointer;" onclick="woSpecial.prototype.removeSpecial(this);"/>'+
					'</div>'+
					'</div>';
				$('#sp-itemlist-1').append(html);
			}
		});*/
		//喷漆
		$('#sp-itemlist-2').empty();
		$('#path-list-2').find('path').each(function(){
			if($(this).attr('data-itemspecialflg') == "4" ) {
				var html = self.getNewSpecialItemDiv($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'));
				$('#sp-itemlist-2').append(html);
			}
		});
		if($('.special-item-list2').length == this.pathCount){
			$('#sp-itemlist-2').empty();
			$("#all-special-btn").addClass('selected');
			$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
			this.addSpecialForView("全车喷漆",1600,4,1,self.allSpecialItemPrice,self.allSpecialItemPrice,1,self.AllSpecialWiid);//添加全车喷漆
		}
		this.funcCostCal();
	},
	//添加钣金、喷漆项目列表（用于联动添加） -- 逐个添加
	addSpecialForView:function(cpname,cpno,itemspecialflg,wispecialitemflg,itemprice,itemdiscountprice,appendtype,wiid){
		var self = this;
		var wipriceeditable = false;
		wipriceeditable = self.getSpecialDataByParam(cpno,itemspecialflg,"wipriceeditable") == 1;//1：金额不能修改
		if(wispecialitemflg == 2){
			//钣金
			$('.special-item-list1').each(function(){
				if(this.dataset.cpno == cpno){
					//列表中已存在，删除
					$(this).remove();
					return;
				}
			});
			var html =self.getNewSpecialItemDiv(cpno,itemspecialflg);
			$('#sp-itemlist-1').prepend(html);
			/*if(appendtype == 1){
				$('#sp-itemlist-1').append(html);
			}else{
				$('#sp-itemlist-1').prepend(html);
			}*/
		}else{
			//喷漆
			var isexist = false;
			$('.special-item-list2').each(function(){
				if(this.dataset.cpno == cpno){
					isexist = true;
				}
			});
			if(isexist)return;//已存在列表中，不添加
			var html =self.getNewSpecialItemDiv(cpno,itemspecialflg);
			$('#sp-itemlist-2').prepend(html);
		}
		this.funcCostCal();
	},
	//保存钣金喷漆项目
	addSpecial:function(){
		var self = this;
		//喷漆项目的材料类型
		var wipaintmtmodifytype1 = 0;
		if($(".item-mat-line[data-issubitemflg=1]").length > 0){
			if ($(".item-mat-line[data-issubitemflg=1]").find(".item-mat-modify-type-checkbox")[0] == undefined) {
				wipaintmtmodifytype1 = 0;
			} else {
				wipaintmtmodifytype1 = $(".item-mat-line[data-issubitemflg=1]").find(".item-mat-modify-type-checkbox")[0].checked ? 1 : 0;
			}

		}
		//钣金项目的材料类型
		var wipaintmtmodifytype2 = 0;
		if($(".item-mat-line[data-issubitemflg=2]").length > 0){
			if ($(".item-mat-line[data-issubitemflg=2]").find(".item-mat-modify-type-checkbox")[0] == undefined) {
				wipaintmtmodifytype1 = 0;
			} else {
				wipaintmtmodifytype1 = $(".item-mat-line[data-issubitemflg=2]").find(".item-mat-modify-type-checkbox")[0].checked ? 1 : 0;
			}
		}

		var d = new Object();
		d.carplate = carplate;
		d.orderid = orderid;
		d.itemlist = [];
		d.workid = woMain.prototype.WORKID;
		var itemlist2 = [];
		$('.special-item-list1').each(function(){
			var item = new Object();
			item.wiid = $(this).attr("data-wiid");
			item.cpno =  parseInt($(this).attr('data-cpno'));
			item.itemspecialflg = parseInt($(this).attr('data-itemspecialflg'));
			item.wispecialitemflg = parseInt($(this).attr('data-wispecialitemflg'));
			//item.itemprice = isNaN(parseFloat($(this).find('.special-price-input1')[0].value)) ? 0 : parseFloat($(this).find('.special-price-input1')[0].value);
			item.itemdiscountprice = isNaN(parseFloat($(this).find('.special-discount-input1')[0].value)) ? 0 : parseFloat($(this).find('.special-discount-input1')[0].value);
			item.wipaintmtmodifytype = wipaintmtmodifytype1;
			item.riworkhour1 = isNaN(parseFloat($(this).find('.special-workhour-input1').val())) ? 0 : parseFloat($(this).find('.special-workhour-input1').val());
			item.riwhprice1 = isNaN(parseFloat($(this).find('.special-singleprice-input1').val())) ? 0 : parseFloat($(this).find('.special-singleprice-input1').val());
			item.riworkinnerhour = isNaN(parseFloat($(this).find('.special-innerworkhour-input1').val())) ? 0 : parseFloat($(this).find('.special-innerworkhour-input1').val());
			d.itemlist.push(item);
		});
		$('.special-item-list2').each(function(){
			var item = new Object();
			item.wiid = $(this).attr("data-wiid");
			item.cpno =  parseInt($(this).attr('data-cpno'));
			item.itemspecialflg = parseInt($(this).attr('data-itemspecialflg'));
			item.wispecialitemflg = parseInt($(this).attr('data-wispecialitemflg'));
			//item.itemprice = isNaN(parseFloat($(this).find('.special-price-input2')[0].value)) ? 0 : parseFloat($(this).find('.special-price-input2')[0].value);
			item.itemdiscountprice = isNaN(parseFloat($(this).find('.special-discount-input2')[0].value)) ? 0 : parseFloat($(this).find('.special-discount-input2')[0].value);
			item.wipaintmtmodifytype = wipaintmtmodifytype2;
			item.riworkhour1 = isNaN(parseFloat($(this).find('.special-workhour-input2').val())) ? 0 : parseFloat($(this).find('.special-workhour-input2').val());
			item.riwhprice1 = isNaN(parseFloat($(this).find('.special-singleprice-input2').val())) ? 0 : parseFloat($(this).find('.special-singleprice-input2').val());
			item.riworkinnerhour = isNaN(parseFloat($(this).find('.special-innerworkhour-input2').val())) ? 0 : parseFloat($(this).find('.special-innerworkhour-input2').val());
			d.itemlist.push(item);
		});

		var addItemList = [];//需要添加的钣金、喷漆
		var delItemList = [];//需要删除的钣金、喷漆
		for(var i = 0 ; i < this.specialItemList.length ; i ++){
			var isdel = true;//是否删除，默认删除
			for(var j = 0 ; j < d.itemlist.length ; j ++){
				if(this.specialItemList[i].cpno == d.itemlist[j].cpno && this.specialItemList[i].riitemspecialflag == d.itemlist[j].itemspecialflg){
					//【当前选择的面】中包含【原来的面】，则标记为不删除
					isdel = false;
					//d.itemlist = d.itemlist.del(j);//删除，不重复添加（添加WIID后，可以重复添加，用于修改价格）
					break;
				}
			}
			if(isdel){
				delItemList.push(this.specialItemList[i].wiid);
			}else{

			}
		}
		var delItemListStr = "";
		for(var i = 0 ; i < delItemList.length ; i ++){
			delItemListStr += delItemList[i]+",";
		}
		delItemListStr = delItemListStr.substring(0,delItemListStr.length-1);



		//console.log(JSON.stringify(delItemList));
		//console.log(JSON.stringify(d.itemlist));
		//woMain.prototype.startLoading();
		//删除项目钣金喷漆
		$.ajax({
			type:"POST",
			url: getremindcntroot+"/ajax/erp03/delrimul",
			data:{wiids:delItemListStr},
			dataType: "json",
			success: function(data){
				if(data.rtncd==0){
					//添加钣金喷漆
					$.ajax({
						url: contextRoot+'/ajax/erp03/additemforsp',
						type: "POST",
						async: false,
						data: {jsondata:JSON.stringify(d)},
						dataType: "json",
						timeout:4000,
						error: function (res,stauts) {
							self.refreshSpecialData();
							//alert("您的网络有问题，请重新加载！");
							throw new Error("ajax异常");
						},
						success: function (data) {
							if(data.rtncd == "0"){
								//查询钣金喷漆
								self.refreshSpecialData();
								woMain.prototype.loadCupList();
								//woMain.prototype.funcItemMatListRender();
							}else{
								alert(data.message);
							}
						}
					});
				}else{
					alert(data.message);
					woMain.prototype.endLoading();
				}
			}
		})
	},
	//刷新主页面上的数据
	refreshSpecialData:function(){
		var self = this;
		$.ajax({
			url: contextRoot+'/ajax/erp03/orderitemlist1',
			type: "POST",
			async: false,
			data: {jsondata:JSON.stringify({carplate:carplate,orderid:orderid})},
			dataType: "json",
			timeout:4000,
			error: function (res,stauts) {
				alert("您的网络有问题，请重新加载！");
				throw new Error("ajax异常");
			},
			success: function (d) {
				if(d.rtncd == "0"){
					//console.log(d);
					var isexist1 = false;//判断是否有喷漆项目
					var isexist2 = false;//判断是否有钣金项目
					var li = d.listdata;
					var itemtotalprice1 = 0;
					var itemtotalprice2 = 0;
					var itemlist1 = [];
					var itemlist2 = [];
					var itemTableHtml1 = "";//喷漆
					var itemTableHtml2 = "";//钣金
					for(var i= 0 ; i < li.length ; i++){
						if(li[i].riitemspecialflag == 4 && li[i].wiid != 0){
							itemlist1.push(li[i]);
							itemtotalprice1 = floatCal(itemtotalprice1,li[i].itemdiscountprice,"+",2);
						}else if((li[i].riitemspecialflag == 1 || li[i].riitemspecialflag == 2) && li[i].wiid != 0){
							itemlist2.push(li[i]);
							itemtotalprice2 = floatCal(itemtotalprice2,li[i].itemdiscountprice,"+",2);
						}
					}
					if(itemlist1 && itemlist1.length > 0){
						isexist1 = true;
					}
					if(itemlist2 && itemlist2.length > 0){
						isexist2 = true;
					}
					if($('#special-item1').html() && !isexist1){
						$('#special-item1').parent().parent().remove();
					}
					if($('#special-item2').html() && !isexist2){
						$('#special-item2').parent().parent().remove();
					}
					if(!$('#special-item1').html() && isexist1){
						//没有喷漆行，但有数据
						var data = {};
						data.wiid = 0;
						data.fcid = "";
						data.fcname = "";
						data.ricost = "";
						data.riitemid = "";
						data.itemname = "喷漆";
						data.riitempricetype = "";
						data.riprice = "";
						data.ritotalprice = "";
						data.ritypename = "";
						data.riworkhour = "";
						data.riworkinnerhour = "";
						data.itemoriginalprice = "";
						data.deductionflag = "";
						data.coupondeductionflag = "";
						data.itemcost = "";
						data.itemprice = "";
						data.itemprofit = "";
						data.itemdiscountprice = "";
						data.itemid = "";
						data.itembzflag = 0;
						data.issubitemflg = 1;
						data.subitems = "";
						data.wiidstr = "";
						data.discountprice = 0;
						data.itemcardstaff = [];
						data.itemstaff = [];
						data.wiitemname = "";
						$('.item-mat-table-tbody').append(self.funcAddItem(data));
					}
					if(!$('#special-item2').html() && isexist2){
						//没有钣金行，但有数据
						var data = {};
						data.wiid = 0;
						data.fcid = "";
						data.fcname = "";
						data.ricost = "";
						data.riitemid = "";
						data.itemname = "钣金";
						data.riitempricetype = "";
						data.riprice = "";
						data.ritotalprice = "";
						data.ritypename = "";
						data.riworkhour = "";
						data.riworkinnerhour = "";
						data.itemoriginalprice = "";
						data.deductionflag = "";
						data.coupondeductionflag = "";
						data.itemcost = "";
						data.itemprice = "";
						data.itemprofit = "";
						data.itemdiscountprice = "";
						data.itemid = "";
						data.itembzflag = 0;
						data.issubitemflg = 2;
						data.subitems = "";
						data.wiidstr = "";
						data.discountprice = 0;
						data.itemcardstaff = [];
						data.itemstaff = [];
						data.wiitemname = "";
						$('.item-mat-table-tbody').append(self.funcAddItem(data));
					}
					woMain.prototype.funcIndexRemap("item");

					//喷漆
					for(var i = 0 ; i <itemlist1.length ; i ++){
						itemTableHtml1 += "<div class=\"special-item-div\" style=\"float:left;margin-left:10px;/*margin-top:5px;*/\" data-wiid=\""+ itemlist1[i].wiid +"\" data-itemprice=\""+itemlist1[i].itemdiscountprice+"\">" +
							"<div style=\"display:table;float:left;padding-left:5px;height:24px;line-height:24px;\">"+itemlist1[i].cpstr+"</div>" +
							/*"<input style=\"width:100px;float:left;\" class='disabled' disabled value=\""+it\emlist1[i].wiitemname+"\" title=\""+ itemlist1[i].wiitemname +"\"/>" +*/
							"<img src=\""+contextRoot+"/resources/assets/img/del-s-btn.png\" class=\"del-s-btn\" onclick=\"woSpecial.prototype.funcDelItem(this);\"/><!--<div class=\"item-special-info-split\"></div>-->" ;
						/*if(i+1 == itemlist1.length){
							itemTableHtml1 += "<img src=\""+contextRoot+"/resources/assets/img/add-s-btn.png\" style=\"height:20px;cursor:pointer;float:left;margin-left:5px;margin-top:3px;\" onclick=\"woMain.prototype.showSpecialAddView();\"/>" ;
						}*/
						itemTableHtml1 += "</div>" ;
					}
					//钣金
					for(var i = 0 ; i <itemlist2.length ; i ++){
						itemTableHtml2 += "<div class=\"special-item-div\" style=\"float:left;margin-left:10px;/*margin-top:5px;*/\" data-wiid=\""+ itemlist2[i].wiid +"\" data-itemprice=\""+itemlist2[i].itemdiscountprice+"\">" +
							/*"<img style=\"width:16px;float:left;margin-top:5px;\" src=\""+contextRoot+"/resources/assets/img/"+(itemlist2[i].riitemspecialflag == 1 ? "small-icon" : "big-icon")+".png\"/>" +*/
							"<div style=\"display:table;float:left;padding-left:3px;height:24px;line-height:24px;\">"+itemlist2[i].cpstr+"</div>" +
							"<img src=\""+contextRoot+"/resources/assets/img/del-s-btn.png\" class=\"del-s-btn\" onclick=\"woSpecial.prototype.funcDelItem(this);\"/><!--<div class=\"item-special-info-split\"></div>-->" ;
						/*if(i+1 == itemlist2.length){
							itemTableHtml2 += "<img src=\""+contextRoot+"/resources/assets/img/add-s-btn.png\" style=\"height:20px;cursor:pointer;float:left;margin-left:5px;margin-top:3px;\" onclick=\"woMain.prototype.showSpecialAddView();\"/>" ;
						}*/
						itemTableHtml2 += "</div>" ;
					}
					$('#special-item1').parent().parent().find('.hc-rmb-input input').first().val(itemtotalprice1);
					$('#special-item2').parent().parent().find('.hc-rmb-input input').first().val(itemtotalprice2);
					$('#special-item1').html(itemTableHtml1);
					$('#special-item2').html(itemTableHtml2);
					woMain.prototype.hideView('path-select-fixed-div');
					$("#all-special-btn").removeClass('selected');
					$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
					woMain.prototype.endLoading();
					woMain.prototype.funcCostCal();
                    wholeDiscountStatus();
				}else{
					alert(d.message);
				}
			}
		});
	},
	//删除钣金喷漆项目，点击图形删除
	removeSpecialForView:function(obj){
		if($(obj).attr('data-wispecialitemflg') == 2){
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
		}
		this.funcCostCal();
	},
	//删除钣金喷漆项目，从列表中删除
	removeSpecial:function(obj){
		var self = this;
		if(obj.parentNode.parentNode.dataset.cpno == "1600"){
			$('.special-item-list2').remove();
			$('#path-list-2').find('path').attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
			$("#all-special-btn").removeClass('selected');
			$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
			return;
		}
		var wilifewealthflg = false;
		wilifewealthflg = self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wilifewealthflg") == 1;//1：为国寿财项目
		if($(obj).parent().parent().attr('data-wispecialitemflg') == '2'){
			//钣金
			$('#path-list-1').find('path').each(function(){
				if($(this).attr('data-cpno') == $(obj).parent().parent().attr('data-cpno')){
					$(this).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
					if(wilifewealthflg){
						//如果是国寿财项目，删除时要扣除对应的优惠金额
						self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wirealgscdiscount")),"-",2);
					}
				}
			});
		}else{
			//喷漆
			$('#path-list-2').find('path').each(function(){
				if($(this).attr('data-cpno') == $(obj).parent().parent().attr('data-cpno')){
					$(this).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
					if(wilifewealthflg){
						//如果是国寿财项目，删除时要扣除对应的优惠金额
						self.mindiscount2 = floatCal(self.mindiscount2,parseFloat(self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wirealgscdiscount")),"-",2);
					}
				}
			});
		}
		$(obj).parent().parent().remove();
		//this.checkSpecialGroup();
		this.funcCostCal();
	},
	//加载项目列表
	loadSpecialItem:function(){
		$.ajax({
			url: contextRoot+'/ajax/erp03/getorderspecialitem',
			type: "POST",
			async: false,
			data: {jsondata:JSON.stringify({orderid:orderid})},
			dataType: "json",
			timeout:4000,
			error: function (res,stauts) {
				alert("您的网络有问题，请重新加载！");
				throw new Error("ajax异常");
			},
			success: function (data) {
				if(data.rtncd == "0"){


				}else{
					alert(data.message);
				}
			}
		});
	},
	//主页面中初始化钣金喷漆项目
	funcAddItem:function(d){
		var itemMatTableHtml = "";
		itemMatTableHtml += "<ul class=\"item-mat-line special-div\" data-wiid=\""+d.wiid+"\" data-originprice=\""+d.originprice+"\" " +
			" data-pkgfree=\""+d.deductionflag+"\" data-coupfree=\""+d.coupondeductionflag+"\" data-itemcost=\""+d.itemcost+"\" "+
			" data-itemprice=\""+d.itemprice+"\" data-itemprofit=\""+d.itemprofit+"\" " +
			" data-discountprice=\""+d.discountprice+"\" data-itemid=\""+d.itemid+"\" data-wiitemstatus=\""+ d.wiItemStatus+"\" data-itembzflag=\""+ d.itembzflag+"\" data-wiinsuranceself=\"" + d.wiinsuranceself + "\"  data-issubitemflg=\"" + d.issubitemflg + "\" data-wipaintmtmodifytype=\""+ (d.wipaintmtmodifytype ? d.wipaintmtmodifytype : 0) +"\">"+
			"<li class=\"item-mat-tr clearfix\">"+
				"<div class=\"item-context\" style=\"/*width:1000px;*/border-bottom:0;\">"+
					"<div class=\"item-checkbox\" data-wiItemStatus=\""+ d.wiItemStatus+"\" >"+
						"<input type=\"checkbox\" style=\"width:14px;height: 14px;\"/>"+
						"<span></span>"+
					"</div>"+
				"<div class=\"item-bussiness-tag\">"+
				"<select style=\"height: 25px;\" onchange=\"woMain.prototype.funcItemTagChange(this);\">" ;
		if(d.itembzflag == 3){
			itemMatTableHtml += "<option value=\"3\" >返修</option>";
		}else{
			itemMatTableHtml += "<option value=\"0\" "+(d.itembzflag == 0 ? 'selected' :'')+">常规</option>"+
				"<option value=\"1\" "+(d.itembzflag == 1 ? 'selected' :'')+">保险</option>"+
				"<option value=\"4\" "+(d.itembzflag == 4 ? 'selected' :'')+">外包</option>";
		}
		itemMatTableHtml +="</select>"+
				"</div>"+
			"<div class=\"item-name\">"+
				"<input disabled type=\"text\" style=\"width:100px;float:left;\" readonly class=\"disabled item-name-input\" " +
				"value=\""+d.itemname+"\"/ data-orgvalue=\""+d.itemname+"\">"+
				"<div class=\"item-btn-bar\">" +
					"<a class=\"wo-remove-obj-btn item-remove-mark\" onclick=\"woSpecial.prototype.functionDelItemMain(this);\"></a>" +
				"</div>"+
			"</div>"+
			"<div class=\"item-man-hour-cost\">"+
				"<div class=\"hc-rmb-input\">"+
					"<div class=\"hc-rmb-icon\">￥</div>"+
					"<input type=\"text\" disabled='disabled' class=\"item-man-hour-cost-input banpen-item-cost-input\" style=\"width:60px;\" value=\""+d.discountprice+"\" "+
					"data-orgvalue=\""+d.discountprice+"\" onchange=\"woSpecial.prototype.setTotalPrice(this);\"' onfocus=\"inputOnFocus(this);\" onblur=\"inputOnBlur(this);\"/>"+
				"</div>"+
				"<a href='javascript:void(0);' onclick=\"woMain.prototype.showSpecialAddView();\" style=\"float:right;margin-top:3px;color:#006CD8;cursor:pointer;margin-left:3px;'\" data-data0=\""+d.data0+"\" data-data1=\""+d.data1+"\" data-data2=\""+d.data2+"\" data-data3=\""+d.data3+"\" data-data4=\""+d.data4+"\" data-data5=\""+d.data5+"\" data-data6=\""+d.data6+"\">修改</a>"+
				"<a href='javascript:void(0);' onclick=\"woMain.prototype.itemDetailShow(this);\" style=\"float:right;margin-top:3px;color:#006CD8;display:none;\">价格详情</a>"+
				//"<a class=\"item-mat-detail-btn\" title=\"详情\" onclick=\"woMain.prototype.itemDetailShow(this);\"></a>"+
			"</div>";

		if(d.itemcardstaff && d.itemcardstaff.length > 0){
			//已领工
			var stafflist = "";
			var staffname = d.itemcardstaff.length > 1 ? d.itemcardstaff[0].staffname + "等"+d.itemcardstaff.length+"人" : d.itemcardstaff[0].staffname;
			for(var k = 0 ; k < d.itemcardstaff.length ; k ++){
				stafflist += d.itemcardstaff[k].staffname+"\r\n";
			}
			itemMatTableHtml += "<div class=\"mat-work-staff\" title=\""+stafflist+"\" data-itemcardstaff=\"1\">"+
				"<a style=\"width:65px;color:#006CD8;cursor:pointer;position:relative;z-index:101;\" onclick=\"woMain.prototype.dispathViewInit(this);\">"+staffname+"</a>"+
				"</div>";
		}else{
			//未领工
			var staffisliststr = "";
			for(var s = 0 ; s < d.itemstaff.length ; s ++){
				staffisliststr += d.itemstaff[s].staffid +",";
			}
			staffisliststr = staffisliststr.substr(0,staffisliststr.length -1);
			itemMatTableHtml += "<div class=\"mat-work-staff\" "+((d.workerdesc != "" && d.workerdesc != undefined) ? " title=\""+d.workerdescdetail+"\"" : "")+" data-itemcardstaff=\"0\">"+
				((d.workerdesc != "" && d.workerdesc != undefined) ? "<a style=\"width:65px;color:#006CD8;cursor:pointer;position:relative;z-index:101;\" data-authority=\"178\" fid=\"19\" onclick=\"woMain.prototype.dispathViewInit(this);\" data-staffid=\""+staffisliststr+"\">"+d.workerdesc+"</a>" : "<a style=\"width:65px;color:#006CD8;cursor:pointer;position:relative;z-index:101;\" data-authority=\"178\" fid=\"19\" data-staffid=\"\" onclick=\"woMain.prototype.dispathViewInit(this);\">去派工</a>")+
				"</div>";
		}
		itemMatTableHtml +=	"<div class=\"item-flag-div\"><img class=\"finished_icon\" src=\""+contextRoot+"/resources/assets/img/new_finished_icon.png\" style=\"margin:0 auto;height:100%;display:none;\"></div>"+
			"<div class=\"item-default-mat-add\"><div class=\"wo-add-mt-btn mat-add-mark\" style=\"float:right;"+(!d.mtlist || d.mtlist.length == 0 ? "" : "display:none;")+"\" onclick=\"woMain.prototype.funcMatAddFirst(this);\">加材料</div></div>" +
			"<div class=\"item-mat-total-price\">" +
				"<div class=\"item-mat-modify-type\" style=\""+(!d.mtlist || d.mtlist.length == 0 ? "display:none;" : "")+"\">" +
					"<input type=\"checkbox\" class=\"item-mat-modify-type-checkbox\" onchange=\"woMain.prototype.funcSetMatModyfiType(this);\" "+(d.wipaintmtmodifytype == 1 ? "checked" : "")+"/>材料打包价"+
				"</div>"+
				"<div class=\"item-mat-total-cost-edit\" style=\"" + (!d.mtlist || d.mtlist.length == 0 || d.wipaintmtmodifytype == 0 ? "display:none;" : "") + "\">" +
					"<div class=\"mat-cost\">" +
						"<div class=\"hc-rmb-input\">" +
							"<div class=\"hc-rmb-icon\">￥</div>" +
							"<input type=\"text\" class=\"mat-cost-input item-mat-total-price-input\" onfocus=\"inputOnFocus(this);\" onblur=\"inputOnBlur(this);\" onchange=\"woMain.prototype.funcSetMatTotalPrice(this);\" " +
							"value=\"0.0\">" +
						"</div>" +
					"</div>" +
				"</div>"+
				"<div class=\"item-mat-total-cost-noedit\" style=\"" + (!d.mtlist || d.mtlist.length == 0 || d.wipaintmtmodifytype == 1? "display:none;" : "") + "\">￥<span class=\"item-mat-total-price-span\">0.0</span></div>" +
			"</div>" +
			"<div><div class=\"item-total-cost on\" style=\"position:absolute;left:1072px;\">￥<span class=\"item-total-cost-input\">0</span></div></div>" +
			"</div>"+
			"<div class=\"special-mat-li\">" +
				"<div class=\"item-special-btn-div\"><div class=\"wo-add-special-btn\"' onclick=\"woMain.prototype.showSpecialAddView();\">"+(d.issubitemflg == 1 ? "喷漆面" : "钣金面")+"</div></div>" +
				"<div class=\"item-special-info\" id=\"special-item"+ d.issubitemflg+"\">";

		var namelist = d.subitems.split(',');
		var idlist = d.wiidstr.split(',');
		for(var i = 0 ; i <namelist.length ; i ++){
			itemMatTableHtml += "<div class=\"special-item-div\" style=\"float:left;margin-left:10px;/*margin-top:5px;*/\" data-wiid=\""+ idlist[i] +"\" >" +
                "<div style=\"display:table;float:left;padding-left:5px;height:24px;line-height:24px;\">"+namelist[i]+"</div>" +
                "<img src=\""+contextRoot+"/resources/assets/img/del-s-btn.png\" class=\"del-s-btn\" onclick=\"woSpecial.prototype.funcDelItem(this);\"/>"+
				"</div>" ;
		}

		itemMatTableHtml+="</div></div>"+
			"<div class=\"mat-context\">" ;
		if(!d.mtlist || d.mtlist.length == 0){
			itemMatTableHtml += "<div class=\"mat-li no-mat\" style=\"display:none;\">" +
									"<div class=\"mat-name\">" +
										"<div class=\"mat-btn-bar\"style=\"margin-left:130px;\" >" +
											"<div class=\"wo-add-mt-btn mat-add-mark\" style=\"display:none;\" onclick=\"woMain.prototype.funcMatAdd(event, this);\">加材料</div>" +
										"</div>" +
									"</div>" +
								"</div>";
		}else{
			for(var m = 0 ; m < d.mtlist.length ; m ++){
				var mtinfo = d.mtlist[m];
				itemMatTableHtml += "<div class=\"mat-li\" data-miid=\"" + mtinfo.miid + "\" data-wmid=\"" + mtinfo.wmid + "\" " +
					" data-mtcost=\"" + mtinfo.mtcost + "\" data-mtprofit=\"" + mtinfo.mtprofit + "\" data-wmsampleflg=\"" + mtinfo.wmsampleflg + "\" data-mtaddflag=\"" + mtinfo.mtaddflag + "\" data-mthideflag=\"" + mtinfo.mthideflag + "\" data-wmownbring=\"" + mtinfo.wmownbring + "\" data-origintotalprice=\"" + mtinfo.origintotalprice + "\" data-wmadditional=\"" + mtinfo.wmadditional + "\" data-pickflg=\"" + (mtinfo.pickflg1) + "\" data-mitakeamount=\"" + mtinfo.takeamount + "\">" +
					"<div class=\"mat-name\">" +
					"<div class=\"mat-no\">" + (m + 1) + ".</div>" +
					"<input type=\"text\" style=\"width:110px;float:left;\" class=\"mat-name-input\" " +
					"value=\"" + mtinfo.miname.replace(/\"/gm, '\'') + "\"/ data-orgvalue=\"" + mtinfo.miname.replace(/\"/gm, '\'') + "\"onkeyup=\"nameKeyUp(this,event);\">" +
					"<div class=\"mat-btn-bar\">";
				var tempmatL = d.mtlist.length - 1;

				if (m == tempmatL) {  //判断是否是最后一行 最后一行才有加号
					itemMatTableHtml += "<div class=\"wo-add-mt-btn mat-add-mark\" onclick=\"woMain.prototype.funcMatAdd(event, this);\">加材料</div>" +
						"<a class=\"wo-remove-mt-btn mat-remove-mark\" onclick=\"woMain.prototype.funcMatRemove(this);\"></a>" +
						"</div>";
				} else {
					itemMatTableHtml += "<a class=\"wo-remove-mt-btn mat-remove-mark\" onclick=\"woMain.prototype.funcMatRemove(this);\"></a>" +
						"</div>";
				}
				itemMatTableHtml += "</div>" +
					"<div class=\"mat-amount\">" +
					"<input type=\"text\" style=\"width:37px;float: left;\" class=\"mat-amount-input\" onfocus=\"inputOnFocus(this);\" onblur=\"inputOnBlur(this);\" onchange=\"woMain.prototype.funcWoInputValChange(this);\" " +
					"value=\"" + mtinfo.usedamount + "\"/ data-orgvalue=\"" + mtinfo.usedamount + "\" data-mitakeamount=\"" + mtinfo.takeamount + "\">" +
					"<div class=\"mat-amount-count\">" +
					"/<span class=\"mat-amount-count-span\" data-orgvalue=\"" + mtinfo.stockamount + "\" >" + mtinfo.stockamount + "</span>" +
					"</div>" +
					"</div>" +
					"<a href='javascript:void(0);' onclick=\"woMain.prototype.showEditMatView(this);\" style=\"float:left;margin-top:3px;color:#006CD8;cursor:pointer;margin-left:3px;'\" >修改</a>" +
					"<div style=\"width:50px;height:25px;line-height:25px;text-align:center;\">";
				itemMatTableHtml += "<a class=\"h1-span\" onclick=\"woMain.prototype.doPurchaseNew_Wj(this);\" style=\"color:#006CD8;cursor:pointer;z-index:103;position:relative;" + (mtinfo.wmadditional == 1 || mtinfo.wmsampleflg == 1 || mtinfo.miid == 0 || (mtinfo.usedamount - mtinfo.takeamount <= mtinfo.stockamount) ? 'display:none;' : '') + "\">去采购</a>";
				/*if(mtinfo.pickflg1 == 0 && mtinfo.wmadditional != 1){
				 itemMatTableHtml += "<a class=\"h1-span\" onclick=\"woMain.prototype.doPurchaseNew_Wj(this);\" style=\"color:#006CD8;cursor:pointer;z-index:103;position:relative;"+(mtinfo.wmsampleflg==1 || mtinfo.miid == 0  ? 'display:none;' : '')+"\">去采购</a>";
				 }*/

				itemMatTableHtml += "</div>" +
					"<div class=\"mat-cost\">" +
					"<div class=\"hc-rmb-input\">" +
					"<div class=\"hc-rmb-icon\">￥</div>" +
					"<input type=\"text\" class=\"mat-cost-input "+(d.wipaintmtmodifytype == 1 ? "disabled" : "")+"\" onfocus=\"inputOnFocus(this);\" onblur=\"inputOnBlur(this);\" onchange=\"woMain.prototype.funcWoInputValChange(this);\" " +
					"value=\""+(d.wipaintmtmodifytype == 1 ? "0.00" : mtinfo.finaltotalprice)+"\" data-orgvalue=\"" + mtinfo.finaltotalprice + "\" "+(d.wipaintmtmodifytype == 1 ? "disabled" : "")+" />" +
					"</div>" +
					"</div>" +
					"<div class=\"mat-status\" style=\"\">";
				if (mtinfo.miid != 0 && mtinfo.wmadditional != 1) {
					if (mtinfo.pickflg1 == 0) {
						if (mtinfo.inputstatus == 1) {
							itemMatTableHtml += "<a class=\"h3-span\" style=\"color:#006CD8;cursor:pointer;z-index:103;position:relative;\" onclick=\"toWoimList(this);\">去入库</a>";
						} else {
							itemMatTableHtml += "<a class=\"h2-span\" style=\"" + (mtinfo.wmsampleflg == 1 || mtinfo.stockamount <= 0 ? 'display:none;' : '') + "\" onclick=\"toWoimList(this);\">去领料</a>";
						}
					} else if (mtinfo.pickflg1 == 1) {
						itemMatTableHtml += "<a class=\"h2-span disabled\" style=\"" + (mtinfo.wmsampleflg == 1 ? 'display:none;' : '') + "\" onclick=\"toWoimList(this);\">已领料</a>";
					}
				} else {
					itemMatTableHtml += "<span class=\"h2-span disabled\">" + (mtinfo.wmownbring == 1 ? "自带材料" : mtinfo.wmadditional == 1 ? "附加材料" : mtinfo.wmsampleflg == 1 ? "临时材料" : "") + "</span>";
				}
				itemMatTableHtml += "</div></div>";
			}
		}
		itemMatTableHtml +=	"</div>" +
			"</li>"+
			"</ul>";
		return itemMatTableHtml;
	},
	setTotalPrice:function(obj){
		var d = new Object();
		d.orderid = orderid;
		d.oriprice = obj.dataset.orgvalue;
		d.newprice = obj.value;
		if($(obj).parent().parent().parent().parent().parent().find('.item-special-info').attr('id') == "special-item1"){
			d.wispecialitemflg = 1;//喷漆
		}else{
			d.wispecialitemflg = 2;//钣金
		}
		$.ajax({
			type:"POST",
			url: getremindcntroot+"/ajax/erp03/setorderspecialitemtotalprice",
			data:{jsondata:JSON.stringify(d)},
			dataType: "json",
			success: function(data){
				if(data.rtncd==0){
					woMain.prototype.funcCostCal();
				}else{
					alert(data.message);
				}
			}
		});
	},
	//主页面上删除铂金喷漆项目
	functionDelItemMain:function(obj){
		var wiids = "";
		$(obj).parent().parent().parent().parent().parent().find('.special-item-div').each(function(){
			wiids += this.dataset.wiid+",";
		});
		wiids = wiids.substring(0,wiids.length - 1)
		if(wiids && wiids.length > 0){
			$.ajax({
				type:"POST",
				url: getremindcntroot+"/ajax/erp03/delrimul",
				data:{wiids:wiids},
				dataType: "json",
				success: function(data){
					if(data.rtncd==0){
						$(obj).parent().parent().parent().parent().parent().remove();
						woMain.prototype.funcCostCal();
                        wholeDiscountStatus();
					}else{
						alert(data.message);
					}
				}
			});
		}
	},
	//删除钣金、喷漆项目
	funcDelItem:function(obj){
		var self = this;
		$.ajax({
			type:"POST",
			url: getremindcntroot+"/ajax/erp03/delri",
			data:{wiid:obj.parentNode.dataset.wiid},
			dataType: "json",
			success: function(data){
				if(data.rtncd==0){
					var mainobj = $(obj).parent().parent();
					/*if($(obj).parent().find('img').length == 2){
						//有删除和添加按钮
						$(obj).parent().prev().append("<img src=\""+contextRoot+"/resources/assets/img/add-s-btn.png\" style=\"height:20px;cursor:pointer;float:left;margin-left:5px;margin-top:3px;\" onclick=\"woMain.prototype.showSpecialAddView();\"/>");
					}*/
					$(obj).parent().remove();
					var totalItemPrice = 0;
					mainobj.find('.special-item-div').each(function(){
						totalItemPrice = floatCal(totalItemPrice,parseFloat(this.dataset.itemprice),"+",2);
					});
					mainobj.parent().parent().find('.item-man-hour-cost-input')[0].value = totalItemPrice;
					$('.item-special-info').each(function(){
						if($(this).find('.special-item-div').length == 0){
							$(this).parent().parent().remove();
						}
					});
					//self.refreshSpecialData();
					woMain.prototype.funcCostCal();
				}else{
					alert(data.message);
				}
			}
		});
	},
	//计算钣金、喷漆总价
	funcCostCal:function(){
		var self = this;
		var itemPrice1 = 0;//钣金原价
		var itemPrice2 = 0;//喷漆原价
		var itemTotalPrice1 = 0;//钣金实收
		var itemTotalPrice2 = 0;//喷漆实收
		var itemDiscountPrice1 = 0;//钣金优惠
		var itemDiscountPrice2 = 0;//喷涂优惠
		$('#sp-itemlist-1').find('.special-discount-input-disabled').each(function(){
			if(!isNaN(parseFloat(this.value))){
				itemPrice1 = floatCal(itemPrice1,parseFloat(this.value),"+",2);
			}
		});
		$('#sp-itemlist-1').find('.special-workhour-input1').each(function(){
			if(!isNaN(parseFloat(this.value))){
				var singleprice = $(this).parent().parent().find(".special-singleprice-input1").val();
				var discountprice = floatCal(singleprice,parseFloat(this.value),"*");
				$(this).parent().parent().find(".special-discount-input1").first().val(discountprice);
			}
		});
		$('#sp-itemlist-2').find('.special-discount-input-disabled').each(function(){
			if(!isNaN(parseFloat(this.value))){
				itemPrice2 = floatCal(itemPrice2,parseFloat(this.value),"+",2);
			}
		});
		$('#sp-itemlist-2').find('.special-workhour-input2').each(function(){
			if(!isNaN(parseFloat(this.value))){
				var singleprice = $(this).parent().parent().find(".special-singleprice-input2").val();
				var discountprice = floatCal(singleprice,parseFloat(this.value),"*");
				$(this).parent().parent().find(".special-discount-input2").first().val(discountprice);
			}
		});
		$('.special-discount-input1').each(function(){
			if(!isNaN(parseFloat(this.value))){
				itemTotalPrice1 = floatCal(itemTotalPrice1,parseFloat(this.value),"+",2);
			}
		});
		$('.special-discount-input2').each(function(){
			if(!isNaN(parseFloat(this.value))){
				itemTotalPrice2 = floatCal(itemTotalPrice2,parseFloat(this.value),"+",2);
			}
		});
		itemDiscountPrice1 = floatCal(itemPrice1,itemTotalPrice1,"-",10);
		itemDiscountPrice2 = floatCal(itemPrice2,itemTotalPrice2,"-",10);
		//原价
		$('#special-total-price-input1').attr('data-oldprice',itemPrice1);
		$('#special-total-price-input2').attr('data-oldprice',itemPrice2);
		//优惠
		$('#special-discount-input1').val(Math.max(floatCal(Math.max(this.mindiscount1,0),itemDiscountPrice1,"+",1),0));
		$('#special-discount-input1').attr("data-itemprice",Math.max(floatCal(Math.max(this.mindiscount1,0),itemDiscountPrice1,"+",1),0));
		$('#special-discount-input1').attr("title",Math.max(floatCal(Math.max(this.mindiscount1,0),itemDiscountPrice1,"+",1),0));
		$('#special-discount-input2').val(Math.max(floatCal(Math.max(this.mindiscount2,0),itemDiscountPrice2,"+",1),0));
		$('#special-discount-input2').attr("data-itemprice",Math.max(floatCal(Math.max(this.mindiscount2,0),itemDiscountPrice2,"+",1),0));
		$('#special-discount-input2').attr("title",Math.max(floatCal(Math.max(this.mindiscount2,0),itemDiscountPrice2,"+",1),0));
		//实收
		/*$('#special-total-price-input1').val(floatCal(itemTotalPrice1,this.mindiscount1,"-",2));
		$('#special-total-price-input1').attr("data-itemprice",floatCal(itemTotalPrice1,this.mindiscount1,"-",2));
		$('#special-total-price-input2').val(floatCal(itemTotalPrice2,this.mindiscount2,"-",2));
		$('#special-total-price-input2').attr("data-itemprice",floatCal(itemTotalPrice2,this.mindiscount2,"-",2));*/
		$('#special-total-price-input1').val(floatCal(itemTotalPrice1,0,"-",2));
		$('#special-total-price-input1').attr("data-itemprice",floatCal(itemTotalPrice1,0,"-",2));
		$('#special-total-price-input1').attr("title",floatCal(itemTotalPrice1,0,"-",2));
		$('#special-total-price-input2').val(floatCal(itemTotalPrice2,0,"-",2));
		$('#special-total-price-input2').attr("data-itemprice",floatCal(itemTotalPrice2,0,"-",2));
		$('#special-total-price-input2').attr("title",floatCal(itemTotalPrice2,0,"-",2));

		/*if(this.mindiscount1 > 0){
			$('#special-mindiscount-input1').val(this.mindiscount1);
			$('.special-mindiscount1').show();
		}else{
			$('.special-mindiscount1').hide();
		}
		if(this.mindiscount2 > 0){
			$('#special-mindiscount-input2').val(this.mindiscount2);
			$('.special-mindiscount2').show();
		}else{
			$('.special-mindiscount2').hide();
		}*/
	},
	//总价改变，计算其余项目金额
	totalPriceCal:function(type) {
		var self = this;
		var totalPriceInputId = "#special-total-price-input" + type;
		var itemListDivId = ".special-item-list" + type;
		var itemPriceInput = ".special-discount-input"+type;
		var specialDiscountInput = "#special-discount-input"+type;
		var specialPriceInput = "#special-price-input"+type;
		var mindiscount = type == 1 ? this.mindiscount1 : this.mindiscount2;
		if (!$(itemListDivId).length) {
			//如果没有对应的（钣金、喷漆）项目，不能修改总价
			$(totalPriceInputId).val(0);
			return;
		}
		if(isNaN(parseFloat($(totalPriceInputId).val())) || parseFloat($(totalPriceInputId).val()) < 0){
			//总金额格式不正确
			$(totalPriceInputId).val($(totalPriceInputId).attr('data-itemprice'));
			return;
		}
		if(parseFloat($(totalPriceInputId).val()) < mindiscount){
			//总金额不能小于国寿财优惠
			alert("总金额不能小于国寿财优惠");
			$(totalPriceInputId).val($(totalPriceInputId).attr('data-itemprice'));
			return;
		}
		//所有待计算的钣金喷漆面
		// （原价、现价都为0的排除）
		// （不能编辑的排除）
		var itemList = [];//待计算的项目
		var itemListZero = [];//金额为0的项目
		var disabledList = [];//不能编辑的项目
		$(itemListDivId).find(itemPriceInput).each(function(){
			var il = {};
			il.obj = this;
			//以原价优先，原价为0按现价，现价为0排除，不做为待计算对象
			il.price = parseFloat($(this).parent().parent().find('.special-discount-input-disabled').val() == 0 ?  this.value == 0 ? 0 : this.value : $(this).parent().parent().find('.special-discount-input-disabled').val());
			if(self.getSpecialDataByParam(this.parentNode.parentNode.dataset.cpno,this.parentNode.parentNode.dataset.itemspecialflg,"wipriceeditable") == 1){
				//不能编辑
				disabledList.push(il);
			}else if(il.price <= 0){
				//金额为0
				itemListZero.push(il);
			}else{
				//待计算项目
				itemList.push(il);
			}
		});
		//console.log(itemList);
		//原总价（统计所有项目总价）
		var oldTotalPrice = 0;
		for(var i = 0 ; i < itemList.length ; i ++){
			oldTotalPrice = floatCal(oldTotalPrice,parseFloat(itemList[i].price),"+",1);
		}
		//输入框内新的总金额
		var newTotalPrice = parseFloat($(totalPriceInputId).val());
		//国寿财项目金额
		var noEditPrice = 0;
		//减去所有国寿财项目金额（不能修改，所以总金额不能小于国寿财项目总金额）
		for(var i = 0 ; i < disabledList.length ; i ++){
			newTotalPrice = floatCal(newTotalPrice,parseFloat(disabledList[1].obj.value),"-",2);
			noEditPrice = floatCal(noEditPrice,parseFloat(disabledList[1].obj.value),"+",2);
		}

		var resultList = [];
		if(itemListZero.length != 0 && itemList.length == 0){
			//所有项目金额都为0，对所有项目进行金额分摊
			var ap = floatCal(newTotalPrice,itemListZero.length,"/",0);
			var lsnewTotalPrice = 0;//计算完后的总价
			for(var i = 0 ; i < itemListZero.length ; i ++){
				itemListZero[i].price = ap;
				lsnewTotalPrice = floatCal(lsnewTotalPrice,itemListZero[i].price,"+",0);
			}
			//判断分配完的金额是否与输入的金额相等
			if(lsnewTotalPrice != newTotalPrice ){
				//最后一个项目，处理剩余的金额
				itemListZero[itemListZero.length - 1].price = floatCal(parseFloat(floatCal(newTotalPrice,lsnewTotalPrice,"-",2)),parseFloat(itemListZero[itemListZero.length - 1].price),"+");
			}
			resultList = itemListZero;
		}else if(disabledList.length != 0 && itemList.length == 0){
			//所有项目都不能编辑，不允许修改总价
			$(totalPriceInputId).val($(totalPriceInputId).attr('data-ovalue'));
			return;
		}else{
			//计算每个项目平均增加或减少的金额
			var discount = floatCal(newTotalPrice, oldTotalPrice, "/", 5);//调整的总金额比例
			var lsnewTotalPrice = 0;//计算完后的总价
			for(var i = 0 ; i < itemList.length ; i ++){
				itemList[i].price = parseFloat(floatCal(parseFloat(itemList[i].price),discount,"*",2));
				lsnewTotalPrice = floatCal(lsnewTotalPrice,itemList[i].price,"+",2);
			}
			//判断分配完的金额是否与输入的金额相等
			if(lsnewTotalPrice != newTotalPrice ){
				//最后一个项目，处理剩余的金额
				itemList[itemList.length - 1].price = floatCal(parseFloat(floatCal(newTotalPrice,lsnewTotalPrice,"-",2)),parseFloat(itemList[itemList.length - 1].price),"+");
			}
			resultList = itemList;
		}
		//将计算完的值放回各自的输入框中
		if(parseFloat(newTotalPrice) < 0){
			for(var i = 0 ; i < resultList.length ; i ++){
				$(resultList[i].obj).val("0");
				$(resultList[i].obj).attr('data-ovalue',"0");
				$(resultList[i].obj).attr('title',"0");
			}
		}else{
			for(var i = 0 ; i < resultList.length ; i ++){
				$(resultList[i].obj).val(resultList[i].price);
				$(resultList[i].obj).attr('data-ovalue',resultList[i].price);
				$(resultList[i].obj).attr('title',resultList[i].price);
			}
		}
		self.funcCostCal();
	},
	//大小钣金切换
	changeSpecialType:function(obj){
		var self = this;
		if(obj.parentNode.parentNode.dataset.itemspecialflg == "2"){
			//大 切换 小
			$(obj).parent().parent().attr({'data-itemspecialflg':'1'});
			var itemprice = $(obj).parent().parent().attr('data-itemprice-1');
			var itemdiscountprice = $(obj).parent().parent().attr('data-itemdiscountprice-1');
			var workhour = $(obj).parent().parent().attr('data-riworkhour1-1');
			var singleprice = $(obj).parent().parent().attr('data-riwhprice1-1');
			var innerworkhour = $(obj).parent().parent().attr('data-riworkinnerhour-1');
            $(obj).parent().parent().find(".special-discount-input-disabled").val(itemprice);
            $(obj).parent().parent().find(".special-discount-input1").val(itemdiscountprice);
            $(obj).parent().parent().find(".special-workhour-input1").val(workhour);
            $(obj).parent().parent().find(".special-singleprice-input1").val(singleprice);
            $(obj).parent().parent().find(".special-innerworkhour-input1").val(innerworkhour);
			//$(obj).attr('src',contextRoot+'/resources/assets/img/path-type-1.png');
			$(obj).find('.change-btn-block2').attr('class','change-btn-block1');
			$($(obj).find('div')[0]).attr('class','change-btn-text1');
			$($(obj).find('div')[1]).attr('class','change-btn-text2');
			$('#path-list-1').find('path').each(function(){
				if($(this).attr('data-cpno') == obj.parentNode.parentNode.dataset.cpno){
					$(this).attr({'class':'selectPath','fill':self.selectColor[1],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'1'});
					return;
				}
			});
		}else{
			//小 切换 大
			$(obj).parent().parent().attr({'data-itemspecialflg':'2'});
            var itemprice = $(obj).parent().parent().attr('data-itemprice-2');
            var itemdiscountprice = $(obj).parent().parent().attr('data-itemdiscountprice-2');
            var workhour = $(obj).parent().parent().attr('data-riworkhour1-2');
            var singleprice = $(obj).parent().parent().attr('data-riwhprice1-2');
            var innerworkhour = $(obj).parent().parent().attr('data-riworkinnerhour-2');
            $(obj).parent().parent().find(".special-discount-input-disabled").val(itemprice);
            $(obj).parent().parent().find(".special-discount-input1").val(itemdiscountprice);
            $(obj).parent().parent().find(".special-workhour-input1").val(workhour);
            $(obj).parent().parent().find(".special-singleprice-input1").val(singleprice);
            $(obj).parent().parent().find(".special-innerworkhour-input1").val(innerworkhour);
			//$(obj).attr('src',contextRoot+'/resources/assets/img/path-type-2.png');
			$(obj).find('.change-btn-block1').attr('class','change-btn-block2');
			$($(obj).find('div')[0]).attr('class','change-btn-text2');
			$($(obj).find('div')[1]).attr('class','change-btn-text1');
			$('#path-list-1').find('path').each(function(){
				if($(this).attr('data-cpno') == obj.parentNode.parentNode.dataset.cpno){
					$(this).attr({'class':'selectPath','fill':self.selectColor[2],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'2'});
					return;
				}
			});
		}
		var wiid = self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wiid");
		obj.parentNode.parentNode.dataset.wiid = wiid;
		this.funcCostCal();
	},
	//检查是否选中了所有喷漆面、是否选中了组合面
	checkSpecialGroup:function(){
		var self = this,
			selectSpecialCount = 0;
		//检查是否选择中所有喷漆
		$('#path-list-2').find('path').each(function(){
			if($(this).attr('data-itemspecialflg') != "0"){
				selectSpecialCount ++;
			}
		});
		if(selectSpecialCount == self.pathCount){
			//全车喷漆
			$("#all-special-btn").addClass('selected');
			$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-1.png');
			$('#sp-itemlist-2').empty();
			self.addSpecialForView("全车喷漆",1600,4,1,self.allSpecialItemPrice,self.allSpecialItemPrice,1,self.AllSpecialWiid);//添加全车喷漆
		}else{
			//非全车喷漆
			if($("#all-special-btn").hasClass('selected')){
				$("#all-special-btn").removeClass('selected');
				$("#all-special-btn").attr('src',contextRoot+'/resources/assets/img/checkbox-0.png');
				$('#sp-itemlist-2').empty();
				self.addSpecialForPath();
			}
		}

		/*
		*
		* 页面显示界面前保险杠、后保险杠合并
		*
		* */
		/*//检查是否选中前、后保险杠组合
		//钣金部分
		var group103 = [];//前保险杠DOM
		var group900 = [];//后保险杠DOM
		$('.special-item-list1').each(function(){
			if(this.dataset.cpno == "101" || this.dataset.cpno == "102"){
				group103.push(this);
			}
			if(this.dataset.cpno == "800" || this.dataset.cpno == "850"){
				group900.push(this);
			}
		});
		if(group103 == 2){
			//选中前保险杠组合，判断是否是相同类型的钣金
			//如果是，删除原有数据，添加组合数据
			if($(group103[0]).attr('data-itemspecialflg') == $(group103[1]).attr('data-itemspecialflg')){
				for(var i = 0 ; i < group103.length ; i ++){
					$(group103[i]).remove();
				}
				self.addSpecialForView((self.nowitemspecialflg == 1 ? "小" : "大")+"钣金（前保险杠）",103,$(group103[0]).attr('data-itemspecialflg'),1,self.getSpecialDataByParam('103',$(group900[0]).attr('data-itemspecialflg'),"itemprice"),self.getSpecialDataByParam('103',$(group103[0]).attr('data-itemspecialflg'),"itemdiscountprice"),1,self.getSpecialDataByParam('103',$(group103[0]).attr('data-itemspecialflg'),"wiid"));//添加全车喷漆
			}
		}
		if(group900 == 2){
			//选中后保险杠组合，判断是否是相同类型的钣金
			//如果是，删除原有数据，添加组合数据
			if($(group900[0]).attr('data-itemspecialflg') == $(group900[1]).attr('data-itemspecialflg')){
				for(var i = 0 ; i < group900.length ; i ++){
					$(group900[i]).remove();
				}
				self.addSpecialForView(($(group900[0]).attr('data-itemspecialflg') == 1 ? "小" : "大")+"钣金（后保险杠）",900,$(group900[0]).attr('data-itemspecialflg'),1,self.getSpecialDataByParam('900',$(group900[0]).attr('data-itemspecialflg'),"itemprice"),self.getSpecialDataByParam('103',$(group900[0]).attr('data-itemspecialflg'),"itemdiscountprice"),1,self.getSpecialDataByParam('900',$(group900[0]).attr('data-itemspecialflg'),"itemprice"),self.getSpecialDataByParam('900',$(group900[0]).attr('data-itemspecialflg'),"wiid"));//添加全车喷漆
			}
		}

		//喷漆部分
		group103 = [];//前保险杠DOM
		group900 = [];//后保险杠DOM
		$('.special-item-list2').each(function(){
			if(this.dataset.cpno == "101" || this.dataset.cpno == "102"){
				group103.push(this);
			}
			if(this.dataset.cpno == "800" || this.dataset.cpno == "850"){
				group900.push(this);
			}
		});
		if(group103 == 2){
			//选中前保险杠组合，删除原有数据，添加组合数据
			for(var i = 0 ; i < group103.length ; i ++){
				$(group103[i]).remove();
			}
			self.addSpecialForView("喷漆（前保险杠）",103,$(group103[0]).attr('data-itemspecialflg'),1,self.getSpecialDataByParam('103',4,"itemprice"),self.getSpecialDataByParam('103',4,"itemdiscountprice"),1,self.getSpecialDataByParam('103',4,"itemprice"),self.getSpecialDataByParam('103',4,"wiid"));
		}
		if(group900 == 2){
			//选中后保险杠组合，删除原有数据，添加组合数据
			for(var i = 0 ; i < group900.length ; i ++){
				$(group900[i]).remove();
			}
			self.addSpecialForView("喷漆（后保险杠）",900,$(group900[0]).attr('data-itemspecialflg'),1,self.getSpecialDataByParam('900',4,"itemprice"),self.getSpecialDataByParam('900',4,"itemdiscountprice"),1,self.getSpecialDataByParam('900',4,"itemprice"),self.getSpecialDataByParam('900',4,"wiid"));
		}*/

	},
	//获取对应面的数据
	getSpecialDataByParam:function(cpno,itemspecialflg,param){
		for(var i = 0 ; i < this.allSpecialItemList.length ; i ++){
			if(cpno == this.allSpecialItemList[i].cpno && itemspecialflg == this.allSpecialItemList[i].riitemspecialflag){
				return this.allSpecialItemList[i][param];
			}
		}
	},
	//生成钣金喷漆列表中的HTML
	getNewSpecialItemDiv:function(cpno,itemspecialflg){
		/*
		* riitempricetype 0：作業價格  1：工時價格
		* riworkhour1 外部工时
		* riwhprice1 工时单价
		* riworkinnerhour 内部工时
		* */
		var wiid = this.getSpecialDataByParam(cpno,itemspecialflg,'wiid'),
			itemname = this.getSpecialDataByParam(cpno,itemspecialflg,'itemname'),
			itemdiscountprice = this.getSpecialDataByParam(cpno,itemspecialflg,'itemdiscountprice'),
			itemprice = this.getSpecialDataByParam(cpno,itemspecialflg,'itemprice'),
			riitempricetype = this.getSpecialDataByParam(cpno,itemspecialflg,'riitempricetype'),
            riworkhour1 = this.getSpecialDataByParam(cpno,itemspecialflg,'riworkhour1'),
            riwhprice1 = this.getSpecialDataByParam(cpno,itemspecialflg,'riwhprice1'),
            riworkinnerhour = this.getSpecialDataByParam(cpno,itemspecialflg,'riworkinnerhour'),
			riworkhour1_1 = this.getSpecialDataByParam(cpno,1,'riworkhour1'),
			riwhprice1_1 = this.getSpecialDataByParam(cpno,1,'riwhprice1'),
            riworkhour1_2 = this.getSpecialDataByParam(cpno,2,'riworkhour1'),
            riwhprice1_2 = this.getSpecialDataByParam(cpno,2,'riwhprice1'),
			riworkinnerhour1 = this.getSpecialDataByParam(cpno,1,'riworkinnerhour'),
            riworkinnerhour2 = this.getSpecialDataByParam(cpno,2,'riworkinnerhour'),
            itemdiscountprice1 = this.getSpecialDataByParam(cpno,1,'itemdiscountprice'),
            itemprice1 = this.getSpecialDataByParam(cpno,1,'itemprice'),
            itemdiscountprice2 = this.getSpecialDataByParam(cpno,2,'itemdiscountprice'),
            itemprice2 = this.getSpecialDataByParam(cpno,2,'itemprice'),
			self = this;
		var html = "";
		console.log(riitempricetype);
		var wipriceeditable = false;
		wipriceeditable = self.getSpecialDataByParam(cpno,itemspecialflg,"wipriceeditable") == 1;//1：不能修改金额
		if(itemspecialflg == 1) {
            //钣金
            html = '<div class="special-item-list1" data-cpno="'+cpno+'" data-itemspecialflg="'+itemspecialflg+'" data-wispecialitemflg="2" ' +
				' data-wiid="'+wiid+'" data-itemprice-1="'+itemprice1+'" data-itemdiscountprice-1="'+itemdiscountprice1+'" data-itemprice-2="'+itemprice2+'"' +
				' data-itemdiscountprice-2="'+itemdiscountprice2+'" data-riworkhour1-1="'+ riworkhour1_1 +'" data-riworkhour1-2="'+ riworkhour1_2 +'"' +
				' data-riwhprice1-1="'+ riwhprice1_1 + '" data-riwhprice1-2="'+ riwhprice1_2 +'" data-riworkinnerhour-1="'+ riworkinnerhour1 +'"' +
				' data-riworkinnerhour-2="'+ riworkinnerhour2 +'">'+
                '<div class="special-item-change">' +
                '<div class="special-change-btn" onclick="woSpecial.prototype.changeSpecialType(this);">' +
                '<div class="change-btn-text'+itemspecialflg+'">大</div><div class="change-btn-text'+(itemspecialflg == 1 ? 2 : 1)+'" style="left:22px;">小</div>' +
                '<div class="change-btn-block'+itemspecialflg+'"></div>' +
                '</div>' +
                '</div>'+
                '<div class="special-item-name">'+itemname+'</div>'+
                '<div class="special-item-price-input-div">'+
                '<input disabled value="'+itemprice1+'" title="'+itemprice1+'" class="special-discount-input-disabled"/>'+
                '</div>'+
                '<div class="special-item-price-input-div">'+
                '<input value="'+itemdiscountprice1+'" title="'+itemdiscountprice1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-discount-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+' '+(riitempricetype == 1 ? 'disabled' : '')+'/>'+
                '</div>'+
                '<div class="special-item-del-div">'+
                '<img src="'+contextRoot+'/resources/assets/img/del-r-btn1.png" onclick="woSpecial.prototype.removeSpecial(this);"/>' +
                '</div>';
            if (riitempricetype == 1) {
                html +=	'<div class="special-item-price-input-div">'+
                    '<input value="'+riworkhour1_1+'" title="'+riworkhour1_1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-workhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riwhprice1_1+'" title="'+riwhprice1_1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-singleprice-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riworkinnerhour1+'" title="'+riworkinnerhour1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>';
            } else {
                html +=	'<div class="special-item-price-input-div">'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riworkinnerhour1+'" title="'+riworkinnerhour1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>';
            }
            html += '</div>';
		}else if (itemspecialflg == 2){
            //钣金
            html = '<div class="special-item-list1" data-cpno="'+cpno+'" data-itemspecialflg="'+itemspecialflg+'" data-wispecialitemflg="2"' +
                ' data-wiid="'+wiid+'" data-itemprice-1="'+itemprice1+'" data-itemdiscountprice-1="'+itemdiscountprice1+'" data-itemprice-2="'+itemprice2+'"' +
                ' data-itemdiscountprice-2="'+itemdiscountprice2+'" data-riworkhour1-1="'+ riworkhour1_1 +'" data-riworkhour1-2="'+ riworkhour1_2 +'"' +
                ' data-riwhprice1-1="'+ riwhprice1_1 + '" data-riwhprice1-2="'+ riwhprice1_2 +'" data-riworkinnerhour-1="'+ riworkinnerhour1 +'"' +
                ' data-riworkinnerhour-2="'+ riworkinnerhour2 +'">'+
                '<div class="special-item-change">' +
                '<div class="special-change-btn" onclick="woSpecial.prototype.changeSpecialType(this);">' +
                '<div class="change-btn-text'+itemspecialflg+'">大</div><div class="change-btn-text'+(itemspecialflg == 1 ? 2 : 1)+'" style="left:22px;">小</div>' +
                '<div class="change-btn-block'+itemspecialflg+'"></div>' +
                '</div>' +
                '</div>'+
                '<div class="special-item-name">'+itemname+'</div>'+
                '<div class="special-item-price-input-div">'+
                '<input disabled value="'+itemprice2+'" title="'+itemprice2+'" class="special-discount-input-disabled"/>'+
                '</div>'+
                '<div class="special-item-price-input-div">'+
                '<input value="'+itemdiscountprice2+'" title="'+itemdiscountprice2+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-discount-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+' '+(riitempricetype == 1 ? 'disabled' : '')+'/>'+
                '</div>'+
                '<div class="special-item-del-div">'+
                '<img src="'+contextRoot+'/resources/assets/img/del-r-btn1.png" onclick="woSpecial.prototype.removeSpecial(this);"/>' +
                '</div>';
            if (riitempricetype == 1) {
                html +=	'<div class="special-item-price-input-div">'+
                    '<input value="'+riworkhour1_2+'" title="'+riworkhour1_2+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-workhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riwhprice1_2+'" title="'+riwhprice1_2+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-singleprice-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riworkinnerhour2+'" title="'+riworkinnerhour2+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>';
            } else {
                html +=	'<div class="special-item-price-input-div">'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '</div>'+
                    '<div class="special-item-price-input-div">'+
                    '<input value="'+riworkinnerhour2+'" title="'+riworkinnerhour2+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input1" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
                    '</div>';
            }
            html += '</div>';
		}else if(itemspecialflg == 4){
			//喷漆
			html = '<div class="special-item-list2" data-cpno="'+cpno+'" data-itemspecialflg="'+itemspecialflg+'" data-wispecialitemflg="1" data-wiid="'+wiid+'">'+
						'<div class="special-item-name" style="width:140px;text-indent:10px;">'+itemname+'</div>'+
						'<div class="special-item-price-input-div">'+
							'<input disabled value="'+itemprice+'" title="'+itemprice+'" class="special-discount-input-disabled"/>'+
						'</div>'+
						'<div class="special-item-price-input-div">'+
							'<input value="'+itemdiscountprice+'" title="'+itemdiscountprice+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();" class="special-discount-input2" '+(wipriceeditable == 1 ? 'disabled' : '')+' '+(riitempricetype == 1 ? 'disabled' : '')+'/>'+
						'</div>'+
						'<div class="special-item-del-div">'+
							'<img src="'+contextRoot+'/resources/assets/img/del-r-btn1.png" onclick="woSpecial.prototype.removeSpecial(this);"/>'+
						'</div>';
			if (riitempricetype == 1) {
				html +=	'<div class="special-item-price-input-div">'+
							'<input value="'+riworkhour1+'" title="'+riworkhour1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-workhour-input2" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
						'</div>'+
						'<div class="special-item-price-input-div">'+
							'<input value="'+riwhprice1+'" title="'+riwhprice1+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-singleprice-input2" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
						'</div>'+
						'<div class="special-item-price-input-div">'+
							'<input value="'+riworkinnerhour+'" title="'+riworkinnerhour+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input2" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
						'</div>';
			} else {
				html +=	'<div class="special-item-price-input-div">'+
						'</div>'+
						'<div class="special-item-price-input-div">'+
						'</div>'+
						'<div class="special-item-price-input-div">'+
							'<input value="'+riworkinnerhour+'" title="'+riworkinnerhour+'" onfocus="inputOnFocus(this);" onblur="inputOnBlur(this);" onkeyup="woSpecial.prototype.funcCostCal();" onchange="woSpecial.prototype.funcCostCal();"class="special-innerworkhour-input2" '+(wipriceeditable == 1 ? 'disabled' : '')+'/>'+
						'</div>';
			}
			html += '</div>';
		}else if(itemspecialflg == 3){
			//点喷，暂时没有
		}
		return html;
	},
	/*init:function(){
		//初始化参数
		//获取当前页面中可喷漆的面
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
			self.selectPath(this);
		});
		self.refreshSpecialData();
	}*/
};
	
