var basicsData = {},
	customerInfo = {},
	edit,
	clientcode = null,
	quoteno = null,
	serviceno = null,
	packageDialog = null,
	$mtadvisor,
	carModelID = '00000000',
	thisCarNo = null,
	listParam;
$(function () {
	isLogin();
	quoteno = getUrlParam("quoteno");
	serviceno = getUrlParam("serviceno");
	edit = {
		edit: getUrlParam("edit"),
		serviceno: getUrlParam("serviceno"),
		quoteno: getUrlParam("quoteno"),
		carno: getUrlParam("carno")
	}
	listParam = {
		page: 1,
		pageSize: pageSize
	};
	
	$mtadvisor = $("#mtadvisor");
	
	//获取技师列表
	getTechnician();
	//初始化保险公司下拉框
	getInsurerList();
	//初始化车牌输入框
	$('#carNo').carLicense();
	//初始化日期框
	$('#maturedate').datePicker({
		format: 'Y-m-d', 
		showClear: false, 
		direction: null
	});
	$('#firstenrol').datePicker({
		format: 'Y-m-d', 
		showClear: false, 
		direction: null
	});
	//弹出选择车型
	$("#carModelName").carModelName();
	
	//$("#recharge").click(openRecharge)
	
	//获取SA下接选项
	mtadvisor();
	
	$('#itemSelect').selection(function(text, value) {
		saveOrUpdateClientDetail(false, value, 1, 0);
		
	});
	$('#orderSelect').selection(function(text, value) {
		saveOrUpdateClientDetail(false, value, 3, 0);
		
	});
	$("#addPackage").click(function() {
		saveOrUpdateClientDetail('addPackage');
	})

	//通过车牌号码获取基础信息
	$("#carNo").blur(function() {
		var carno = $(this).val().trim();
		thisCarNo = carno
		if (carno){
			if (!CAR_NUM.test(carno)) {
				Dialog.popup('请输入正确的车牌号码！');
				$(this).focus();
				return false;
			}
			writeCustomerInfo(carno);
			getOrderList();
		}
		
	});
	//通过车架号获到车型
	$("#vin").blur(function() {
		var vin = $(this).val().trim();
		if (vin) {
			sendRequest({
				token: true,
		        action: 'clerk/common/getCarmodelbyvin',
		        data: {vin: $(this).val().trim()},
		        onSuccess: function(obj) {
					if (obj.status == 'success') {
						var data = obj.data;
						if (data.carmodelid) {
							carModelID = data.carmodelid
						}
						if (data.carbrandname) {
							$("#carModelName").val(CAR_BRAND[data.carbrandname]+ data.carmodelname)
								.attr('disabled', 'true')
								.data("carplate", data.carbrandname)
								.data("carmodel", data.carmodelname)
								.data("carline", data.carlinename)
								.data("carmodelid", data.carmodelid);
						}
					}
		        }
		    });	
		} else {
			$("#carModelName").removeAttr('disabled');
		}
		
	});
	
	if (edit.edit == 'true') {
		writeCustomerInfo(edit.carno);
		$("#carNo").attr("disabled","disabled");
	}
	getItemList();
	
	//项目工时全选/全不选
	$('#hoursList').on('change', ':checkbox', function() {
		var $tbody = $(this).closest('li').parent();
		$tbody.prev().find(':checkbox').prop('checked', $tbody.find(':checkbox').length == $tbody.find(':checked').length);
	}).prev().find(':checkbox').change(function() {
		$(this).closest('label').next().find(':checkbox').prop('checked', $(this).prop('checked'));
	});
	//提交工单,显示派工
	$("#dispatching").click(function() {
		
		saveOrUpdateClientDetail('saveMaintain');
	});
	
	$("#submitWords").click(function() {
		saveOrUpdateClientDetail("submitWords");
		
	})
	$("#jishi").on('click', '.jishi', saveTechnicianSub)
	$("#packageList").on('click', 'a.icon_shanchu', shanchuQuote)
					.on('change', '.decimal', modifyOrDeleteQuote)
	
	console.log(carModelID)
});
//获取保险公司
function getInsurerList() {
	var BxInsurerinfoList = sessionStorage.getItem("BxInsurerinfoList");
	if (BxInsurerinfoList === null) {
		sendRequest({
			token: true,
			action: 'clerk/common/getBxInsurerinfoList',
			data: {type: 3, shopId: 0},		//type 1私家客户，VIP客户等；2供应商；3保险公司
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [],
						topInsurComp = {
							insurercode: null,
							memo: '选择保险公司'
						};
					data.unshift(topInsurComp);
					sessionStorage.setItem( "BxInsurerinfoList", JSON.stringify(data));
					
					$("#insurercode").selection({
						items: data,
						text: 'memo',
						value: 'insurercode'
					}).val();
				}
			}
		});
	} else {
		$("#insurercode").selection({
			items: JSON.parse(BxInsurerinfoList),
			text: 'memo',
			value: 'insurercode'
		}).val();
	}
	
			
}

//获取送修人
function getPushPeople(data) {
		sendRequest({
			token: true,
			action: 'clerk/receive/senderItem',
			data: {clientcode: data},	
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var dataList = obj.data || [],
						len = dataList.length;
					for (var i=0;i<len;i++) {
						dataList[i].itemsName = dataList[i].clientident +' - ' + dataList[i].sender
					}

					$("#pushPeople").selection({
						items: dataList,
						text: 'itemsName',
						value: 'senderid'
					}).val();
				}
			}
		});		
}

//工时项目
function getItemList() {
	sendRequest({
		token: true,
        action: 'clerk/receive/getItemList',
        data: {dataId: 1, carModelID: carModelID, itemtypeId: '000184'},
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.page.items || [];
				$("#itemSelect").selection({
					items: data,
					text: 'itemname',
					value: 'itemid'
				}).val();
				
			}
        }
    });	
}

//订单项目
function getOrderList() {
	sendRequest({
		token: true,
        action: 'clerk/receive/getItemList',
        data: {dataId: 3, carModelID: carModelID, itemtypeId: '', carNo: thisCarNo, pageSize: 100},
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.page.items || [];
				if (data.length > 0) {
					$(".showOrder").show();
					$("#orderSelect").selection({
						items: data,
						text: 'itemname',
						value: 'itemid'
					}).val();
				}

			}
        }
    });	
}

//填写客户信息
function writeCustomerInfo(carno) {
	sendRequest({
		token: true,
		action: 'clerk/receive/getClientDetail',
		data: {carno: carno},
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data;
				if (data.carmodelid) {
					carModelID = data.carmodelid;
				}
				
				if (data.carno) {
					$("#carNo").val(data.carno);
					thisCarNo = data.carno
				} else {
					thisCarNo = carno
				}
				if (data.clientcode) {
					clientcode = data.clientcode
					//getCrmSavingsCard()
					$("#clientcode").val(data.clientcode);

					getPushPeople(data.clientcode)
				}
				//新增senderid参数
//				if (data.senderid) {
//					$("#senderid").val(data.senderid);
//				}
				if (data.clientname) {
					$("#clientname").val(data.clientname).attr('disabled', 'true');
				} else {
					$("#clientname").removeAttr('disabled');
				}
				if (data.mobile) {	
					$("#mobile").val(data.mobile).attr('disabled', 'true');
				} else {
					$("#mobile").removeAttr('disabled');
				}
				if (data.vin) {
					$("#vin").val(data.vin);
				}
				if (data.clientgrade) {
					$("#clientgrade").val(data.clientgrade);
				}
				
				if (data.carplate)  {
					$("#carModelName").val(CAR_BRAND[data.carplate]+ data.carmodel)
						.data("carplate", data.carplate)
						.data("carmodel", data.carmodel)
						.data("carline", data.carline);
						
					
				} else {
					$("#carModelName").removeAttr('disabled');
				}
				if (data.distance) {
					$("#distance").val(data.distance);
				}
				
				if (data.insurercode) {
					$("#insurercode").val(data.insurercode);
				}
					
				$("#maturedate").val(data.maturedate.slice(0, 10));
				$("#firstenrol").val(data.firstenrol.slice(0, 10));
				
				
				
				customerInfo = data
				//查询项目列表
				getItemList();
				getOrderList();
			}
		}
	});
	if (edit.edit == 'true') {
		getQuoteList(edit.quoteno);
	}
	
}

//弹出套餐项目选框
function addPackage() {
	
	var $content = $('#package-table-tmpl').tmpl(),
		itemidList = [],
		orderIdList = [],
		itemListParam = {
			page: 1,
			pageSize: pageSize
		},
		activityParam = {};
		
	$content.find(".consume_tabs").on("click", 'li', function() {
		$(this).addClass('index').siblings().removeClass('index');
		var tableId = $(this).data("tableid")
		$content.find(tableId).show().siblings().hide()
		if (tableId === '#activityTable') {
			getActivityMainList($content)
		} else if (tableId === '#orderTable') {
			getItemOrderList($content);
		} else {
			getItemItemList($content);
		}
	});
	//初始化工时分页
	$content.find("#itemPage").pagination({
		pageSize: pageSize,
		onPageSelect: getItemItemList,
		onPageSizeChange: function(pageSize) {
			localStorage.pageSize = pageSize;
			itemListParam.pageSize = pageSize;
			getItemItemList();
		}
	});
	//初始化订单分页
	$content.find("#orderPage").pagination({
		pageSize: pageSize,
		onPageSelect: getItemOrderList,
		onPageSizeChange: function(pageSize) {
			localStorage.pageSize = pageSize;
			listParam.pageSize = pageSize;
			getItemOrderList();
		}
	});
	
	$content.find("#activityList").on("click", 'a.buy_activity_btn', function(e) {
		e.preventDefault();	
		var target = this,
		activitydata = $.tmplItem(target).data;
		if (quoteno) {
			//保存活动转订单
			var parame = {
					acitemtype: activitydata.acitemtype,
					actid: activitydata.actid,
					actitemid: activitydata.actitemid,
					amt: activitydata.amt,
					carno: thisCarNo,
					quoteno: quoteno,
					clientcode: clientcode
				}
				sendRequest({
					token: true,		
					action: 'clerk/activity/saveActivityMain',
					data: parame,
					onSuccess: function(obj) {
						if (obj.status == 'success') {
							//订单列表
							getItemOrderList($content)
							
						} else {
							Dialog.popup(obj.message);
						}
					}
				});
				$content.find(".consume_tabs > li:eq(1)").addClass('index').siblings().removeClass('index');
				$content.find("#orderTable").show().siblings().hide()
		} else {
			//建空报价单： itemid：-9， itemtype： -9
			sendRequest({
				token: true,
		        action: 'clerk/receive/saveOrDeleteQuote',
		        data: {
		        	carmodelid: carModelID,
		        	carno: basicsData.carno,
		        	sortcode: '003001',
		        	distance: basicsData.distance,
		        	itemid: -9, 
		        	itemstatus: 0, 
		        	itemtype: -9, 
		        	kindcode: '003', 
		        	itemnum: 1,
		        	serviceno: quoteno,
		        	quoteno: quoteno},
		        lock: true,
		        onSuccess: function(obj) {
					if (obj.status == 'success') {
						var data = obj.data || {};
						quoteno = data.serviceno
						//保存活动转订单
						var parame = {
								acitemtype: activitydata.acitemtype,
								actid: activitydata.actid,
								actitemid: activitydata.actitemid,
								amt: activitydata.amt,
								carno: thisCarNo,
								quoteno: quoteno,
								clientcode: clientcode
							}
							sendRequest({
								token: true,		
								action: 'clerk/activity/saveActivityMain',
								data: parame,
								onSuccess: function(obj) {
									if (obj.status == 'success') {
										//订单列表
										getItemOrderList($content)
										
									} else {
										Dialog.popup(obj.message);
									}
								}
							});
							$content.find(".consume_tabs > li:eq(1)").addClass('index').siblings().removeClass('index');
							$content.find("#orderTable").show().siblings().hide()
					} else {
						Dialog.popup(obj.message);
					}
		        }
		    });	
		}
	});

	//带选择框的table支持tr点击选中，全选/全不选
	$content.find('table.selectable > tbody').on('click', 'tr', function() {
		$(this).find('input:checkbox, input:radio').click();
	}).on('click', 'label>*', function(e) {
		e.stopPropagation();
	}).on('click', 'button, a, .clipboard, .number, .mechanic', function(e) {
		e.stopPropagation();
	}).on('change', ':checkbox', function() {
		var $tbody = $(this).closest('tbody');
		$tbody.prev().find(':checkbox').prop('checked', $tbody.find(':checkbox').length == $tbody.find(':checked').length);
	}).prev().find(':checkbox').change(function() {
		$(this).closest('thead').next().find(':checkbox').prop('checked', $(this).prop('checked'));
	});
	
	$content.find('#searchContent').click(function() {
		var $target =  $(this),
			selectText = $target.prev().val().trim() ? $target.prev().val().trim() : null;
			
		sendRequest({
			token: true,
	        action: 'clerk/receive/getItemList',
	        data: {dataId: 1, carModelID: carModelID, itemtypeId: '000184', itemname: selectText},
	        onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					$(".selectable").find("#check-all").prop('checked', false);
					$content.find("#packageList").html($('#package-list-tmpl').tmpl(data))
				}
	        }
	    });
	}).prev().keydown(function(e) {
		if (e.keyCode == 10) {
			$('#search').click();
		}
	});
	
	//工时列表
	getItemItemList($content);
    
    //订单列表
	getItemOrderList($content);
    
    //活动列表
    getActivityMainList($content);
	
	if (!packageDialog) {
		packageDialog = new Dialog({
			closeable: false,
			width: 'auto',
			height: 'auto',
			title: '添加项目',
			content: $content,
			operate: [{
				text: '确定',
				onClick: function() {
					
					$content.find('#manHourTable tbody > tr').each(function(){
						var $target = $(this);
						if($target.find(":checkbox").prop('checked') == true) {
							var data = $.tmplItem(this).data,
								itemid = data.itemid;
							itemidList.push(itemid);
						}
					});
					
					$content.find('#orderTable input[name="orderID"]:checked').each(function(){
						orderIdList.push(this.value);
						//console.log(this.value)
					})

					if (itemidList.length + orderIdList.length == 0) {
						Dialog.popup('请选择项目！');
						return false;
					}
					if (itemidList.length > 0) {
						saveOrUpdateClientDetail(false, itemidList, 1, 0);
					}
					if (orderIdList.length > 0) {
						saveOrUpdateClientDetail(false, orderIdList, 3, 0);
					}

					packageDialog.close();
					packageDialog = null;
				}
			}, {
				text: '取消',
				attr: {'class': 'btn btn_red'}, 
				onClick: function() {
					packageDialog.close();
					packageDialog = null;
				}
			}]
		}).show();
	}
	//获取工时列表
	function getItemItemList(page) {
		if (isNaN(page)) {
	        itemListParam.page = 1;
			$content.find("#packageList").empty();
        	$content.find("#itemPage").empty();
	    } else {
	        itemListParam.page = page;
	    }
	    itemListParam.dataId = 1
	    itemListParam.carModelID = carModelID
	    itemListParam.itemtypeId = '000184'
		sendRequest({
			token: true,
	        action: 'clerk/receive/getItemList',
	        data: itemListParam,
	        lock: true,
	        onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					$(".selectable").find("#check-all").prop('checked', false);
					$content.find("#packageList").html($('#package-list-tmpl').tmpl(data))
					$content.find("#itemPage").pagination(itemListParam.page, obj.page.total);
				}
	        }
	    });
	}

	//获取订单列表
	function getItemOrderList(page) {
		if (isNaN(page)) {
	        listParam.page = 1;
			$content.find("#orderList").empty();
        	$content.find("#orderPage").empty();
	    } else {
	        listParam.page = page;
	    }
	    listParam.dataId = 3
	    listParam.carModelID = carModelID
	    listParam.itemtypeId = ''
	    listParam.carNo = thisCarNo
		sendRequest({
			token: true,
	        action: 'clerk/receive/getItemList',
	        data: listParam,
	        onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					getOrderList();
					$content.find("#orderList").html($('#order-list-tmpl').tmpl(data))
					$content.find("#orderPage").pagination(listParam.page, obj.page.total);
				}
	        }
	    });
	}
	
	//获取活动列表
	function getActivityMainList(page) {
	    activityParam.carno = thisCarNo
		sendRequest({
			token: true,
	        action: 'clerk/activity/getActivityMainList',
	        data: activityParam,
	        onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					$content.find("#activityList").html($('#activity-list-tmpl').tmpl(data))
				}
	        }
	    });
	}
}






//获取技师列表
function getTechnician() {
	sendRequest({
		token: true,
        action: 'clerk/receive/getTechnician',
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.page.items || [];
				$("#jishi").html($('#jishi-list-tmpl').tmpl(data));
			}
        }
    });	
}

//第一步。保存客户档案。
function saveOrUpdateClientDetail(paigong, itemid, itemtype, itemstatus) {
	//paigong: 是否派工（false, true）
	//取值客户信息
	basicsData.clientcode = $("#clientcode").val().trim();
	
	basicsData.carno = $("#carNo").val().trim();
	thisCarNo = $("#carNo").val().trim();
	basicsData.clientname = $("#clientname").val().trim();
	basicsData.mobile = $("#mobile").val().trim();
	
	
	basicsData.vin = $("#vin").val().trim();
	
	//stdCarModelId 0开头的车型ID，carModelId显示用的车型ID
	basicsData.carModelName = $("#carModelName").val().trim();
	basicsData.carplate = $("#carModelName").data("carplate");
	basicsData.carmodel = $("#carModelName").data("carmodel");
	basicsData.carline = $("#carModelName").data("carline");

	
	basicsData.stdCarModelName = $("#carModelName").val().trim();
	
	basicsData.distance = $("#distance").val().trim();
	basicsData.insurercode = $("#insurercode").val();
	
	basicsData.senderid = $("#pushPeople").val() || null;
	
	var maturedate = $("#maturedate").val(),
		firstenrol = $("#firstenrol").val();
	basicsData.maturedate = maturedate ? maturedate + ' 00:00:00' : null;
	basicsData.firstenrol = firstenrol ? firstenrol + ' 00:00:00' : null;
	
	//新增sendid参数
	//basicsData.senderid = $("#senderid").val().trim();
	
	if (!(CAR_NUM.test(basicsData.carno))) {
		Dialog.popup('请输入正确的车牌号码！');
		$("#carNo").focus();
		return false;
	}
	if (basicsData.clientname == '' || basicsData.clientname == "undefined") {
		Dialog.popup('请输入客户姓名！');
		$("#clientname").focus();
		return false;
	}

	if (!PHONE_NUMBER.test(basicsData.mobile)) {
		Dialog.popup('请输入正确的手机号码！');
		$("#mobile").focus();
		return false;
	}
	
	if (basicsData.vin == '') {
		Dialog.popup('请输入VIN号码！');
		$("#vin").focus();
		return false;
	}
	
	if (basicsData.carModelName == '') {
		Dialog.popup('请输入车型！');
		$("#carModelName").focus();
		return false;
	}
	
	if (basicsData.distance == '') {
		Dialog.popup('请输入车架号行驶公里数！');
		$("#distance").focus();
		return false;
	}
	console.log(9999, basicsData.senderid)
//	if (basicsData.senderid === '' || basicsData.senderid === null) {
//		Dialog.popup('请选择送修人！');
//		$("#pushPeople").focus();
//		return false;
//	}

	sendRequest({
		token: true,
		action: 'clerk/receive/saveOrUpdateClientDetail',
		data: basicsData,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data || {};
				$("#clientcode").val(data)
				clientcode = data
				console.log('保存客户信息成功', basicsData)
				getPushPeople(data)
				if (paigong == 'saveMaintain') {
					console.log('转成工单')
					//转成工单
					saveMaintain();
				} else if (paigong == 'saveTechnician') {
					//派工
					console.log('派工')
					saveTechnician();
				} else if (paigong == 'addPackage') {
					//弹出套餐选项
					addPackage();
				} else if (paigong == 'submitWords') {
					//提交跳转
					Dialog.popup('操作成功！');
					
					location.href='/billing/order.html?jumpUrl=order';
				} else if (paigong == 'recharge') {
					console.log('保存成功')
					clientcode = data
					openRecharge()
					
				} else {
					//报价
					console.log('报价')
					saveOrDeleteQuote(itemid, itemtype, itemstatus)
				}
			} else {
				Dialog.popup(obj.message);
			}
		}
	});

}

//第二步：新增/修改/删除报价项目
function saveOrDeleteQuote(itemid, itemtype, itemstatus) {
	//itemid： 项目ID
	//itemstatus: 操作类型（0:新增,1:修改2:删除）
	//itemtype: 项目类型（0:套餐.1:工时,2:配件,3：线上订单4.喷漆.）
	//kindcode: 业务类型 001：普通，002：事故, 003洗美
	console.log(25, serviceno, quoteno)
	var saveOrDeleteData = {
        	carmodelid: carModelID,
        	carno: basicsData.carno,
        	sortcode: '003001',
        	distance: basicsData.distance,
        	itemid: itemid, 
        	itemstatus: itemstatus, 
        	itemtype: itemtype, 
        	kindcode: '003', 
        	itemnum: 1,
        	serviceno: quoteno,
        	quoteno: quoteno || serviceno}

	if (itemstatus === 2) {
		saveOrDeleteData.serviceno = serviceno || quoteno
		saveOrDeleteData.quoteno = quoteno
	}
	sendRequest({
		token: true,
        action: 'clerk/receive/saveOrDeleteQuote',
        data: saveOrDeleteData,
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data || {};
				quoteno = data.serviceno
				$("#dispatching").show();
				$(".dispatching").hide();
				console.log('执行报价成功')
				if (itemstatus === 2) {
					Dialog.popup('删除项目报价成功！');
					quoteno = data.quoteno
				} else {
					Dialog.popup('编辑项目报价成功！');
				}
				//显示已选项目列表
				console.log(68, quoteno)
				getQuoteList(quoteno);
				
				//saveMaintain();
			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
	
}
//删除报价项目
function shanchuQuote(e) {
	e.preventDefault();
	var data = $.tmplItem(this).data,
		itemid = data.itemcode,
		itemtype = 1;
	//itemid： 项目ID
	//没有工时ID取套餐ID	
	//itemtype: 项目类型（0:套餐.1:工时,2:配件,3：线上订单4.喷漆.）
	if (!itemid) {
		itemid = data.packageid
		itemtype = 0
	}
	
	saveOrUpdateClientDetail(false, itemid, itemtype, 2)
	
}

//已选报价项目列表接口
function getQuoteList(serviceno) {
	sendRequest({
		token: true,
        action: 'clerk/receive/getQuoteList',
        data: {serviceno: serviceno},
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data,
					itemquotelist = data.itemquotelist || [],
					packagequotelist = data.packagequotelist || [],
					onlineorderquotelist = data.onlineorderquotelist || [],
					pqquotelist = data.pqquotelist || [];
				for (var i=0;i<pqquotelist.length;i++) {
					itemquotelist.push(pqquotelist[i])
				}

				$("#packageList").html($('#quote-list-tmpl').tmpl(itemquotelist)).append($('#onlineorder-show-tmpl').tmpl(onlineorderquotelist));
				$("#packageList").find(':text').filterInput();
				$("#packageListTotal").text(data.quoteprice);
				console.log('已选报价项目列表接口')
				//getMaintain();
			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
}


//获取店面SA列表
function mtadvisor() {
	
		sendRequest({
			token: true,
			action: 'carbeauty/getWxRolesmemberList',
			data: {type: 3, shopId: 0},		//type 1私家客户，VIP客户等；2供应商；3保险公司
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					
					$mtadvisor.selection({
						items: data,
						text: 'membername',
						value: 'membercode'
					}).val(GetCookie("qixioudr", "mtadvisorid"));
				} else {
					Dialog.popup(obj.message);
				}
			}
		});

}

//提交工单,显示派工
function saveMaintain() {
	//编辑工单，报价单转成工单
	if (quoteno) {
		var accomplishdate = $("#accomplishdate").val(),
			mtadvisor = $mtadvisor.val();
			
		//$("#dispatching").hide().parent().next(".dispatching").show();
		
		sendRequest({
			token: true,
			action: 'clerk/receive/saveMaintain',
			data: {quoteno: quoteno, tenorsn: 2, carno: basicsData.carno, serviceno: serviceno, phoneType: 'iphone'},
			lock: true,
			onSuccess: function(obj) {
				serviceno = obj.data.serviceno
				if (serviceno) {
					$("#dispatching").hide();
					$(".dispatching").show();
					console.log('提交工单成功')
					getMaintain()
				} else {
					Dialog.popup(obj.message);
				}
			}
		});
	} else {
		Dialog.popup('请选择消费项目！');
	}
}

function getMaintain() {
	//获取工单详情的套餐工时和普通工时
	if (serviceno) {
	sendRequest({
		token: true,
		action: 'clerk/receive/getMaintain',
		data: {serviceno: serviceno},
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data,
					itemquotelist = data.itemlist || [],
					packagequotelist = data.packagelist || [],
					onlineorderlist = data.onlineorderlist || [],
					pqlist = data.pqlist || [],
					itemList = [];
				for (var i=0;i<itemquotelist.length;i++) {
					if (itemquotelist[i]) {
						itemList.push(itemquotelist[i])
					}
				}

				for (var key=0; key<packagequotelist.length;key++) {
					var pkgitemlist = packagequotelist[key].pkgitemlist
					for (var j=0;j<pkgitemlist.length;j++) {
						if (pkgitemlist[j]) {
							itemList.push(pkgitemlist[j])
						}
						
					}
				}
				
				for (var i=0;i<pqlist.length;i++) {
					if (pqlist[i]) {
						itemList.push(pqlist[i])
					}
				}
				
				for (var onl=0;onl<onlineorderlist.length;onl++) {
					var onlItemlist = onlineorderlist[onl].pkgitemlist
					for (var y=0;y<onlItemlist.length;y++) {
						if (onlItemlist[y]) {
							itemList.push(onlItemlist[y])
						}
						
					}
				}
				$("#accomplishdate").val(data.accomplishdate)
				$mtadvisor.val(data.mtadvisorid)
				console.log('获取工单详情的套餐工时和普通工时')
				
				$("#hoursList").html($('#hours-list-tmpl').tmpl(itemList));
			} else {
				Dialog.popup(obj.message);
			}
			
			
			//派工
		}
	});
	} else {
		console.log('没有工单号')
	}
}
//派工
function saveTechnicianSub(e) {
	e.preventDefault();
	saveTechnician.itemcode = [];
	saveTechnician.id = $(this).data("id");
	saveTechnician.accomplishdate = $("#accomplishdate").val();
	saveTechnician.mtadvisor = $mtadvisor.text();
	saveTechnician.mtadvisorid = $mtadvisor.val();
	$("#hoursList").find('li').each(function(){
		var $target = $(this);
		if($target.find(":checkbox").prop('checked') == true) {
			saveTechnician.itemcode.push($(this).find(":checkbox").val())
		}
	});
	if (!saveTechnician.accomplishdate) {
		Dialog.popup('请选择计划交车时间！');
		return false;
	}
	if (!saveTechnician.mtadvisor) {
		Dialog.popup('请选择SA！');
		return false;
	}
	if (saveTechnician.itemcode.length == 0) {
		Dialog.popup('请选择工时项目！');
		return false;
	}
	
	saveOrUpdateClientDetail('saveTechnician');
	

}
//
function saveTechnician() {
	console.log(saveTechnician.accomplishdate)
	sendRequest({
		token: false,
		action: 'clerk/receive/saveTechnician',
		data: {
			access_token: GetCookie("qixioudr", "accessToken"),
			id: saveTechnician.id, 
			itemid: saveTechnician.itemcode, 
			serviceno: serviceno, 
			accomplishdate: saveTechnician.accomplishdate,
			mtadvisor: saveTechnician.mtadvisor,
			mtadvisorid: saveTechnician.mtadvisorid
		},
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				$('#check-all').attr('checked', false);
				getMaintain();
			} else {
				Dialog.popup(obj.message);
			}
			
		}
	});
}


//单独修改价格
function modifyOrDeleteQuote() {
	var target = this,
		data = $.tmplItem(target).data,
		itemtotal = $(target).val();
	//itemstatus: 操作类型（0:新增,1:修改2:删除）
	//itemtype: 项目类型（0:套餐.1:工时,2:配件,3：线上订单4.喷漆.）
	//kindcode: 业务类型 001：普通，002：事故, 003洗美
	
	if (itemtotal == '') {
		Dialog.popup('请输入项目目价格！');
		$(target).focus().val(data.itemsum);
		return false;
	}
	
	sendRequest({
		token: true,
        action: 'clerk/receive/saveOrDeleteQuote',
        data: {carno: basicsData.carno, 
        	distance: basicsData.distance,
        	itemtotal: itemtotal,
        	itemid: data.itemcode, 
        	itemstatus: 1, 
        	itemtype: 1, 
        	kindcode: '003', 
        	serviceno: data.serviceno},
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data || {};
				quoteno = data.serviceno
				console.log('执行报价成功')
				Dialog.popup('修改项目报价成功！');
				//显示已选项目列表
				getQuoteList(quoteno);
				
				//saveMaintain();
			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
}
//获取允值卡详情
function getCrmSavingsCard() {
	sendRequest({
		token: true,		
		action: 'carbeauty/getCrmSavingsCard',
		data: {clientcode: clientcode},
		lock: false,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				customerInfo.balance = obj.data.balance
				$("#balance").val(customerInfo.balance)
			}
		}
	});	
}


//快速充值
function openRecharge () {
	var kehuInfo = customerInfo
	if (!clientcode) {
		saveOrUpdateClientDetail("recharge")
		return false;
	}
	if (!customerInfo.carno) {
		kehuInfo = basicsData
		console.log(basicsData)
	}
	var $content = $('#push-serviceno-tmpl').tmpl(kehuInfo);
	
	if (Number(kehuInfo.balance) >= 99999.99) {
		Dialog.popup('储值卡满额！');
		return false
	}
	
	$content.find(':text').filterInput().placeholder();
	
	reservatDialog = new Dialog({
		closeable: false,
		width: '600',
		title: '储值卡充值',
		content: $content,
		operate: [{
			text: '确定',
			onClick: function() {
				confirmPush($content);	//确定充值
			}
		}, {
			text: '取消',
	        attr: {'class': 'btn btn_red'}, 
	        onClick: function() {
	        	reservatDialog.close();
	        }
		}]
	}).show();
}

//确定充值
function confirmPush(target) {
	var recharge = {
		kindcode: '003',
		clientcode: $("#clientcode").val()
	};
	
	//取值
	recharge.balance = target.find("#balance").val();
	recharge.carno = target.find("#carNo").val();
	var balance = target.find("#balanceYu").data("balance")
		
	//判断
	if (!(CAR_NUM.test(recharge.carno))) {
		Dialog.popup('请选择正确的车牌号码！');
		target.find("#carNo").focus();
		return false;
	}
	console.log(Number(recharge.balance) + balance)
	if (Number(recharge.balance) <= 0 || Number(recharge.balance) > 99999) {
		Dialog.popup('充值金额0~99999！');
		target.find("#balance").focus();
		return false;
	}
	
	if (Number(recharge.balance) + Number(balance) > 99999.99) {
		Dialog.popup('储值卡余额额过大！');
		return false;
	}
	
	sendRequest({
		token: true,		
		action: 'carbeauty/saveCrmSavingsCardRecharge',
		data: recharge,
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				Dialog.popup('充值成功！');
				//getCrmSavingsCard()
				reservatDialog.close();
			} else {
				Dialog.popup(obj.message);
			}
		}
	});	
	return false;
}


