var $wrapper,
	$page,
	$list,
	listParam,
	reservatDialog;
	
$(function () {
	//初始化
	isLogin();
	$wrapper = $('body');
	$list = $('#list');
	$page = $('#page');
	
	listParam = {
		page: 1,
		pageSize: pageSize
	};

	$('#rangeDate').datePicker({
		range: true,
		rangeMax: 30, 
		onSelect: function(begin, end) {
			listParam.startDate = begin + ' 00:00:00';
			listParam.endDate = end + ' 23:59:59';
			getBespeakList();
		},
		onClear: function() {
			listParam.startDate = listParam.endDate = null;
			getBespeakList();
		}
	});
	
	getBxInsurerinfoList();
	//搜索
	$('#searchKey').selection(function(text, value) {
		var $target = $(this).next();
		$target.attr("placeholder", text).val("");
		if ( value == 2 ) {
			$target.attr("class", 'number').unbind();
			$(':text').filterInput().placeholder();
		} else {
			$target.removeAttr("id").unbind();
		}
	});

	$('#search').click(function() {
		var $target =  $(this),
			selectID = $target.prev().prev().val(),
			selectText = $target.prev().val().trim() ? $target.prev().val() : null;
			
		switch(selectID)
		{
		case 1:
			listParam.serviceno = selectText;
			listParam.mobile = null;
			listParam.clientname = null;
			break;
		case 2:
			listParam.serviceno = null;
			listParam.mobile = selectText;
			listParam.clientname = null;
			break;
		case 3:
			listParam.serviceno = null;
			listParam.mobile = null;
			listParam.clientname = selectText;
			break;
		default:
			listParam.serviceno = selectText;
			listParam.mobile = null;
			listParam.clientname = null;
		}
		getBespeakList();
	}).prev().keydown(function(e) {
		if (e.keyCode == 10) {
			$('#search').click();
		}
	});
	
	//订单状态
	$("#status").selection(function(text, value) {
		listParam.tenorsn = value;
		getBespeakList();
	});
	
	//初始化分页
	$page.pagination({
		pageSize: pageSize,
		onPageSelect: getBespeakList,
		onPageSizeChange: function(pageSize) {
			localStorage.pageSize = pageSize;
			listParam.pageSize = pageSize;
			getBespeakList();
		}
	});
	
	getBespeakList();
	
	//操作
	$("#newsReservat").click(newsReservat);
	$list.on('click', 'a.icon_leimu', reservatDetail)
		.on('click', 'a.chanjian', saveOrUpDateBespeak);
});

//获取列表
function getBespeakList(page) {
	if (isNaN(page)) {
        listParam.page = 1;
        $list.empty();
        $page.empty();
    } else {
        listParam.page = page;
    }
    sendRequest({
        action: 'carbeauty/getWxBespeakList',
		token: true,
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
//获取保险公司
function getInsurerList(content) {
	var data = JSON.parse(sessionStorage.getItem("BxInsurerinfoList"));
	content.find("#insurercode").selection({
		items: data,
		text: 'memo',
		value: 'insurercode'
	});		
}

//创建工单
function saveOrUpDateBespeak(e) {
	e.preventDefault();	
	var data = $.tmplItem(this).data;
	sendRequest({
		token: true,		
		action: 'ar/bespeak/saveOrUpDateBespeak',
		data: {id: data.id, statusId: 1},
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				location.href='/billing/new_work_order.html?jumpUrl=works&sourceID='+ data.id;
			}
		}
	});	
}

//弹出新建预约单
function newsReservat(e) {
	e.preventDefault();	
	var $content = $('#news-reservat-tmpl').tmpl();
	getInsurerList($content);
	
	$content.find('#carNo').carLicense();
	
	$content.find('#maturedate').datePicker({
		format: 'Y-m-d', 
		showClear: false, 
		direction: null
	});
	$content.find('#yearCheckDate').datePicker({
		format: 'Y-m-d', 
		showClear: false, 
		direction: null
	});
	//弹出选择车型
	$content.find("#carModelName").carModelName();
	//通过车牌号码获取基础信息
	$content.find("#carNo").blur(function() {
		var carno = $(this).val().trim();
		
		if (carno){
			if (!CAR_NUM.test(carno)) {
				Dialog.popup('请输入正确的车牌号码！');
				$(this).focus();
				return false;
			}
			sendRequest({
				token: true,
				action: 'clerk/receive/getClientDetail',
				data: {carno: carno},
				onSuccess: function(obj) {
					if (obj.status == 'success') {
						var data = obj.data;
						
						if (data.carno) {
							$content.find("#carNo").val(data.carno);
						}
						if (data.clientname) {
							$content.find("#clientname").val(data.clientname);
						}
						if (data.mobile) {
							$content.find("#mobile").val(data.mobile);
						}
						if (data.carplate) {
							$content.find("#carModelName").val(CAR_BRAND[data.carplate]+ data.carmodel)
						}
						if (data.sex == 0 || data.sex == 1) {
							$content.find("input[name='sex'][value='"+data.sex+"']").prop("checked", "checked"); 
						}
						
						
					}
				}
			});
		}
		
	});
	$content.find(':text').filterInput().placeholder();
	$content.find('.select').selection();

	reservatDialog = new Dialog({
		closeable: false,
		width: 'auto',
		height: 'auto',
		title: '新建预约单',
		content: $content, 
		operate: [{
			text: '确定',
			onClick: function() {
				var target = $(this).parents(".dialog");
				nextStep(target);
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

//确定提交
function nextStep(target) {
	var basicsData = {};
	
	//取值
	basicsData.creator = GetCookie("qixioudr", "memberName");
	basicsData.origin = '00330012';

	basicsData.carno = target.find("#carNo").val();	
	basicsData.mobile = target.find("#mobile").val();
	basicsData.clientname = target.find("#clientname").val();
	basicsData.sex = target.find("input[name='sex']:checked").val(); 
	basicsData.carmodel = target.find("#carModelName").data("carmodel");
	basicsData.carplate = target.find("#carModelName").data("carplate");
	basicsData.carmodelname = target.find("#carModelName").val();
	basicsData.cometime = target.find("#cometime").val();
	basicsData.mtreason = target.find("#mtreason").val();
		
	console.log(basicsData)	
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
	
	
	
	if (basicsData.cometime == '') {
		Dialog.popup('请选择预约时间！');
		target.find("#cometime").focus();
		return false;
	}

	sendRequest({
		token: true,		
		action: 'clerk/appointment/saveAppointment',
		data: basicsData,
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				Dialog.popup('新建成功！', getBespeakList);
				reservatDialog.close();
			} else {
				Dialog.popup(obj.message);
			}
		}
	});	
	return false;
}

//弹出详情
function reservatDetail(e) {
	e.preventDefault();
	var data = $.tmplItem(this).data;
	sendRequest({
		token: true,
		action: 'carbeauty/getWxBespeakDetail',
		data: { serviceno: data.serviceno, duttype: 1 },
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data || [],
					$content = $('#reservat-detail-tmpl').tmpl(data);
				
				new Dialog({
					width: 'auto',
					title: '预约单详情',
					content: $content
				}).show();
			} else {
				Dialog.popup(obj.message);
			}
		}
	});	
	
	
}