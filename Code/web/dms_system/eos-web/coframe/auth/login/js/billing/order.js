var openUrlDialog,
	spendBillDialog,
	$wrapper,
	$page,
	$list,
	listParam,
	$content,
	goodsList = [],
	reservatDialog;

$(function () {
	//初始化
	isLogin();
	$wrapper = $('body');
	$list = $('#list');
	$page = $('#page');

	listParam = {
		page: 1,
		pageSize: pageSize,
		kindcode: '003'
	};

	$('#rangeDate').datePicker({
		range: true,
		rangeMax: 30, 
		onSelect: function(begin, end) {
			listParam.startDate = begin + ' 00:00:00';
			listParam.endDate = end + ' 23:59:59';
			getConsumptionList();
		},
		onClear: function() {
			listParam.startDate = listParam.endDate = null;
			getConsumptionList();
		}
	});
	
	getBxInsurerinfoList();
	getWxRolesmemberList();
	
	$("#carNo").carLicense();
	
	
	//搜索
	$('#searchKey').selection(function(text, value) {
		var $target = $(this).next();
		$target.attr("placeholder", text).val("");
		if (value == 0) {
			$target.attr("id", 'carNo').unbind();
			$("#carNo").carLicense();
		} else if ( value == 2 ) {
			$target.removeAttr("id").attr("class", 'number').unbind();
			$(':text').filterInput().placeholder();
		} else {
			$target.removeAttr("id").unbind();
		}
	});
	
	$('#search').click(function(r) {
		var $target =  $(this),
			selectID = $target.prev().prev().val(),
			selectText = $target.prev().val().trim() ? $target.prev().val().trim() : null;
		switch(selectID)
		{
		case 0:
			listParam.carno = selectText;
			listParam.serviceno = null;
			listParam.mobile = null;
			listParam.clientname = null;
			break;
		case 1:
			listParam.carno = null;
			listParam.serviceno = selectText;
			listParam.mobile = null;
			listParam.clientname = null;
			break;
		case 2:
			listParam.carno = null;
			listParam.serviceno = null;
			listParam.mobile = selectText;
			listParam.clientname = null;
			break;
		case 3:
			listParam.carno = null;
			listParam.serviceno = null;
			listParam.mobile = null;
			listParam.clientname = selectText;
			break;
		default:
			listParam.carno = selectText;
			listParam.serviceno = null;
			listParam.mobile = null;
			listParam.clientname = null;
		}
		getConsumptionList();
	}).prev().keydown(function(e) {
		if (e.keyCode == 10) {
			$('#search').click();
		}
	});
	//工单状态
	$("#mtStatusId").selection(function(text, value) {
		listParam.tenorsn = value;
		getConsumptionList();
	});
	
	$("#paymentState").selection(function(text, value) {
		
	});
	
	$("#paymentMode").selection(function(text, value) {
		
	});
	


	//初始化分页
	$page.pagination({
		pageSize: pageSize,
		onPageSelect: getConsumptionList,
		onPageSizeChange: function(pageSize) {
			localStorage.pageSize = pageSize;
			listParam.pageSize = pageSize;
			getConsumptionList();
		}
	});
	
	getConsumptionList();
	
	$("#spendBill").click(function () {
		location.href='/billing/new_work_order.html?jumpUrl=order';
	})
	//操作
	$list.on('click', 'a.icon_leimu', openOrderDetail)
		.on('click', 'a.icon_weixiu', isPushServiceno)
		.on('click', 'a.icon_xuanze', doneInspection);
		
	
	
});

//获取列表
function getConsumptionList(page) {
	if (isNaN(page)) {
        listParam.page = 1;
        $list.empty();
        $page.empty();
    } else {
        listParam.page = page;
    }
    sendRequest({
		token: true,
        action: 'carbeauty/getConsumptionList',
        data: listParam,
        target: $wrapper,
		lock: true,
        onSuccess: function(obj) {
			var data = obj.page.items || [],
				page = obj.page || [];
			if (page.total > 0) {
				$list.html($('#list1-tmpl').tmpl(data));
				orderNum();
				$page.pagination(listParam.page, page.total);
				return true;
			} else {
				Dialog.popup('暂无数据！');
			}
        }
    });	
}



//弹出工单详情
function openOrderDetail(e) {
	e.preventDefault();	
	var target = this,
		data = $.tmplItem(target).data;
	Dialog.open({
		title: '工单详情',
		height: 'auto',
		url: '/billing/work_detail.html?serviceno='+ data.serviceno + '&tenorsn=' + data.tenorsn
	});
}

//推修
function isPushServiceno(e) {
	e.preventDefault();	
	var target = this,
		data = $.tmplItem(target).data,
		$content = $('#push-serviceno-tmpl').tmpl(data),
		shopName = GetCookie("qixioudr", "compName");
	$content.find('#carNo').carLicense();
	
	$content.find('#pushStore').inputSelect().selection(function(text, value) {
		getRolesmemberList($content, value)
	});
	getSearchCompanyList($content, shopName)

	
	
	$content.find('#inputselect').keyup(function() {
		var value = $(this).val().trim();
		if (value) {
			getSearchCompanyList($content, value)
		}
		
	}).blur(function() {
		console.log(123)
	});
	getRolesmemberList($content, GetCookie("qixioudr", "compCode"));
	
	
	reservatDialog = new Dialog({
		closeable: false,
		width: '500',
		title: '推修',
		content: $content,
		operate: [{
			text: '确定',
			onClick: function() {
				confirmPush($content, data.serviceno);	//确定推修
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
function getSearchCompanyList(content, shopName) {
	sendRequest({
		token: true,		
		action: 'carbeauty/getSearchCompanyList',
		data: {shopName: shopName},
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				companyList = obj.page.items || [];
				content.find('#pushStore').inputSelect({
					items: companyList,
					text: 'shopName',
					value: 'shopCode'
				});
			}
		}
	});	
}

function getRolesmemberList(content, compcode) {
		sendRequest({
			token: false,
			action: 'carbeauty/getRolesmemberList',
			data: {access_token: GetCookie("qixioudr", "accessToken"), compcode: compcode},
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					if (data.length > 0) {
						content.find("#mtadvisor").selection({
							items: data,
							text: 'membername',
							value: 'membercode'
						});
					} else {
						content.find("#mtadvisor").selection({
							items: [{membername: '暂无SA', membercode: null}],
							text: 'membername',
							value: 'membercode'
						});
					}
					
				} else {
					Dialog.popup(obj.message);
				}
			}
		});
	}
//确定推修
function confirmPush(target, serviceno) {
	var basicsData = {
		origin: '00330013',
		mserviceno: serviceno,
		ispush: 1,
		access_token: GetCookie("qixioudr", "accessToken"),
		creator: GetCookie("qixioudr", "memberName"),
		customid: GetCookie("qixioudr", "customId"),
		
		duttype: GetCookie("qixioudr", "dutType")
	};
	
	//取值
	basicsData.compcode = target.find("#pushStore").val() || null;

	//basicsData.compcode = target.find("#pushStore").val() || null;
	basicsData.mtadvisor = target.find("#mtadvisor").text() || null;
	basicsData.mtadvisorid = target.find("#mtadvisor").val() || null;
	basicsData.carno = target.find("#carNo").val();	
	basicsData.mobile = target.find("#mobile").val();
	basicsData.clientname = target.find("#clientname").val();

	basicsData.cometime = target.find("#cometime").val();
	basicsData.mtreason = target.find("#mtreason").val();
		
			
	//判断
	if (!(CAR_NUM.test(basicsData.carno))) {
		Dialog.popup('请输入正确的车牌号码！');
		target.find("#carNo").focus();
		return false;
	}
	
	if (!PHONE_NUMBER.test(basicsData.mobile)) {
		Dialog.popup('请输入正确的手机号码！');
		$("#mobile").focus();
		return false;
	}
	
	if (basicsData.clientname == '' || basicsData.clientname == "undefined") {
		Dialog.popup('请输入客户姓名！');
		target.find("#clientname").focus();
		return false;
	}

	if (basicsData.compcode == null) {
		Dialog.popup('请选择推修门店！');
		target.find("#pushStore").focus();
		return false;
	}
	
	if (basicsData.cometime == '') {
		Dialog.popup('请选择预约时间！');
		target.find("#cometime").focus();
		return false;
	}
	
	if (basicsData.mtadvisorid == null) {
		Dialog.popup('请选择SA！');
		return false;
	}

	sendRequest({
		token: false,		
		action: 'clerk/appointment/saveAppointment',
		data: basicsData,
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				Dialog.popup('推修成功！');
				reservatDialog.close();
				getConsumptionList();
			} else {
				Dialog.popup(obj.message);
			}
		}
	});	
	return false;
}

//完工
function doneInspection(e) {
	e.preventDefault();	
	var target = this,
		data = $.tmplItem(target).data;
		
	Dialog.confirm({
		title: null,
	    content: '<i class="icon_tishi alertIcon"></i><h4>确定该单已完成领料出库并且已完工？</h4><span class="fa_red">（领料出库:库存管理-工单出库）</span>',
	    confirmText: '确定',
	    onConfirm: function() {			
			sendRequest({
				token: true,		
				action: 'carbeauty/doneInspection',
				data: {serviceno: data.serviceno},
				lock: true,
				onSuccess: function(obj) {
					if (obj.status == 'success') {
						Dialog.popup('操作成功！');
						getConsumptionList();
					} else {
						Dialog.popup(obj.message);
					}
				}
			});	
		}
	});
}

function openUrlClose() { 
	openUrlDialog.close();
}



