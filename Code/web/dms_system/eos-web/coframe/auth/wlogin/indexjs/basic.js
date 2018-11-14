//手机号码正则
PHONE_NUMBER = /^1(3|4|5|7|8)\d{9}$/;
//邮箱
CHECK_EMAIL = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
//车牌号码
CAR_NUM = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
 

//API接口测试地址
API_URL = 'http://14.23.35.20:81/service/'; 
//API接口正式地址
//API_URL = 'https://api.harsonserver.com/service/'; 
//图片地址域名
IMG_URL = 'http://qxdr.harsonserver.com';

var pageSize = parseInt(localStorage.pageSize) || 10,
	loginDialog = null;

//状态中文
var RESERVAT_STATE = {//预约单状态0待处理，1已处理，2已过期
		0: '待处理',
		1: '已处理',
		2: '已过期'
	},
	REPAIR_STATE = {//工单状态)
		0: '在预约',
		1: '在报价',
		2: '在维修', 
		3: '完工总检', 
		4: '预结算', 
		5: '待结算',
		6: '结算出厂',
		8: '报价未修'
	},
	RESERVAT_TENORSN = {//预约单状态)
		'0032001': '已预约',
		'0032002': '已来厂',
		'0032003': '已失效',
		'0032004': '已受理',
		'0032005': '已取消',
		'0032006': '预约已结算',
		'0032007': '已结算',
		'0032008': '对账申请',
		'0032009': '对账完成'
	},
	ORDER_STATE = {//订单状态
		0: '未支付',
		1: '已支付'
	},
	RETNSIGN = {//归库状态
		0: '未归库',
		1: '已归库'
	}
//类型中文
var P_DOWN_SORT = {//出库类型
		'C002': '维修出库',
		'C003': '本厂出库'	
	}
//性别
var SEX_TYPE = {	//0：女，1：男
	0: '女',
	1: '男'
}
//车牌
var CAR_BRAND = {}
/*
 * String扩展
 */

String.prototype.startsWith = function(str) {
	return new RegExp('^' + str).test(this);
};

String.prototype.endsWith = function(str) {
	return new RegExp(str + '$').test(this);
};

String.prototype.toDate = function() {
	return new Date(this.replace(/\-/g, '/'));
};

String.prototype.isMobileNumber = function() {
	return new RegExp('^1[34578]\\d{9}$').test(this);
};


/*
 * Number扩展
 */

Number.prototype.prepad = function(length) {
	var len = this.toString().length;
	if (length - len > 1) {
		return Array(length - len + 1).join('0') + this;
	} else if (length - len == 1) {
		return '0' + this;
	} else {
		return '' + this;
	}
};


/*
 * 数组扩展
 */

Array.prototype.insert = function(item, index) {
	return this.splice(index, 0, item);
};

Array.prototype.indexOf = function(item) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == item) {
			return i;
		}
	}
	return -1;
};

Array.prototype.removeAt = function(index) {
	if (isNaN(index) || index > this.length || index < 0) {
		return null;
	}
	return this.splice(index, 1)[0];
};

Array.prototype.remove = function(item) {
	var index = this.indexOf(item);
	if (index >= 0) {
		this.removeAt(index);
		return true;
	}
	return false;
};

Array.prototype.last = function() {
	if (this.length) {
		return this[this.length - 1];
	}
	return null;
};


/*
 * Date扩展
 */

Date.prototype.format = function(pattern) {
	if (!pattern) {
		pattern = 'yyyy-MM-dd HH:mm:ss';
	}
	var o = {
		'M+': this.getMonth() + 1,
		'd+': this.getDate(),
		'h+': this.getHours() % 12 == 0 ? 12 : this.getHours() % 12,
		'H+': this.getHours(),
		'm+': this.getMinutes(),
		's+': this.getSeconds(),
		'S': this.getMilliseconds()
	};
	var week = [ '日', '一', '二', '三', '四', '五', '六' ];
	if (/(y+)/.test(pattern)) {
		pattern = pattern.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
	}
	if (/(E+)/.test(pattern)) {
		pattern = pattern.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length > 2 ? '星期' : '周') : '') + week[this.getDay()]);
	}
	for (var k in o) {
		if (new RegExp('(' + k + ')').test(pattern)) {
			pattern = pattern.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)));
		}
	}
	return pattern;
};

Date.prototype.formatDate = function() {
	return this.format('M月d日');
};

Date.prototype.formatFullDate = function() {
	return this.format('yyyy-MM-dd');
};

Date.prototype.formatTime = function() {
	return this.format('HH:mm');
};

Date.prototype.formatDateTime = function() {
	return this.format('M月d日 HH:mm');
};

Date.prototype.formatFull = function() {
	return this.format('yyyy-MM-dd HH:mm:ss');
};




/*
 * 获取URL参数
 */

function getUrlParams(search) {
	if (!search) {
		search = location.search;
	}
	var param = {};
	if (search) {
		var regex = /[?&;](.+?)=([^&;]+)/g;
		var match;
		while (match = regex.exec(search)) {
			param[match[1]] = decodeURIComponent(match[2]);
		}
	}
	return param;
}

function getUrlParam(key, search) {
	return getUrlParams(search)[key];
}

/*
* 判断浏览器版本
*/
function browserMatch() {
	//判断浏览器版本
	var browser,
		version,
		userAgent = navigator.userAgent,
		ua = userAgent.toLowerCase(),   
		rMsie = /(msie\s|trident.*rv:)([\w.]+)/,   
		rFirefox = /(firefox)\/([\w.]+)/,   
		rOpera = /(opera).+version\/([\w.]+)/,   
		rChrome = /(chrome)\/([\w.]+)/,   
		rSafari = /version\/([\w.]+).*(safari)/;  

	function uaMatch(ua) {  
		var match = rMsie.exec(ua);  
		if (match != null) {  
			return { browser : "IE", version : match[2] || "0" };  
		}  
		var match = rFirefox.exec(ua);  
		if (match != null) {  
			return { browser : match[1] || "", version : match[2] || "0" };  
		}  
		var match = rOpera.exec(ua);  
		if (match != null) {  
			return { browser : match[1] || "", version : match[2] || "0" };  
		}  
		var match = rChrome.exec(ua);  
		if (match != null) {  
			return { browser : match[1] || "", version : match[2] || "0" };  
		}  
		var match = rSafari.exec(ua);  
		if (match != null) {  
			return { browser : match[2] || "", version : match[1] || "0" };  
		}  
		if (match != null) {  
			return { browser : "", version : "0" };  
		}  
	}  
	var browserMatch = uaMatch(userAgent.toLowerCase());  
	if (browserMatch.browser) {  
		browser = browserMatch.browser;  
		version = browserMatch.version;  
	}
	return browser+version;
}

/*
* ajax发送网络请求
*/

function sendRequest(ajaxParam) {

	if (!ajaxParam.type) {
		ajaxParam.type = 'GET'
	}
	if (ajaxParam.content) {
		ajaxParam.contentType = 'application/json;charset=UTF-8'
	}
	//填充默认请求参数
	ajaxParam = $.extend({
		dataType: 'json',
		cache: false,
		//contentType: 'application/json;charset=UTF-8',
		beforeSend: function() {
			if (ajaxParam.lock) {
				Dialog.loading(ajaxParam.lock);
			}
		},
		success: function(obj,textStatus,jqXHR) {
			if (jqXHR.status != 200) {
				ajaxParam.onError({code:-1, message: obj.message});
			}
			if (obj.status != 'success') {
				ajaxParam.onError({code:-1, message: obj.message});
			} else { //正确返回
				ajaxParam.onSuccess(obj);
			}
		},
		error: function(xhr, textStatus, error) {
			if (xhr.status == 401) {
				ajaxParam.onError({code:-2, message: '您的登陆已经超时，请重新登陆！'})
				if (loginDialog == null) {
					loginDialog = Dialog.open({
					    title: null,
					    closeable: false,
					    url: '/login.html',
					    width: '435',
					    height: '599'
					});
				}
				
				return false;
			} else {
				ajaxParam.onError({code:-2, message: xhr.responseJSON.message});
			}
		},
		onSuccess: $.noop,
		onError: function(obj) {
			Dialog.popup(obj.message);
			ajaxParam.afterError();
		},
		afterError: $.noop,
		complete: function() {
			if (ajaxParam.lock) {
				Dialog.loadingOff();
			}
		}
	}, ajaxParam);
	
	
	
	//默认data处理
	if(!ajaxParam.data) {
		ajaxParam.data = {};
	}
	ajaxParam.req = ajaxParam.data;
	//默认url处理
	var UrlParam = '',
		ajaxUrl = '';
	if (ajaxParam.token) {
		UrlParam += "&access_token=" + GetCookie("qixioudr", "accessToken");
		//UrlParam += "&access_token=27aa7399-423f-4937-b45e-b091cb";
		UrlParam += "&compcode=" + GetCookie("qixioudr", "compCode");
		UrlParam += "&compCode=" + GetCookie("qixioudr", "compCode");
		UrlParam += "&customid=" + GetCookie("qixioudr", "customId");
		UrlParam += "&mtadvisor=" + encodeURIComponent(GetCookie("qixioudr", "memberName"));
		UrlParam += "&mtadvisorid=" + GetCookie("qixioudr", "profileId");
		UrlParam += "&memberId=" + GetCookie("qixioudr", "profileId");
		UrlParam += "&duttype=" + GetCookie("qixioudr", "dutType");
	}
	
	
	if (ajaxParam.type == 'GET') {
		ajaxUrl = API_URL + ajaxParam.action + ".json?platform=25"+ UrlParam;
		var data = ajaxParam.data,
			get = '';
		for(var i in data){
			if (data[i] || data[i] == 0) {
				if (typeof(data[i]) != 'object') {
					get += '&'+ i + '=' + encodeURIComponent(data[i]);
				} else {
					get += '&'+ i + '=' + data[i];
				}
			}
		}
		ajaxUrl += get

		ajaxParam.data = {};

	} else {
		if (ajaxParam.suffix == 'no') {
			ajaxUrl = API_URL + ajaxParam.action;
		} else {
			ajaxUrl = API_URL + ajaxParam.action + ".json?platform=25"+ UrlParam;
		}
		
		ajaxParam.type ='POST'

		ajaxParam.data = ajaxParam.data;
		
	}
	if(!ajaxParam.url) {
		ajaxParam.url = ajaxUrl;
	}
	
 	//发送请求
	$.ajax(ajaxParam);
	
	
}

/*
* JS浮点数计算精度问题
* 加accAdd,减accMin,乘accMul,除accDiv
*/
//加
function accAdd(a, b) {
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch (f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch (f) {
		d = 0;
	}
	e = Math.pow(10, Math.max(c, d));
	return  (accMul(a, e) + accMul(b, e)) / e;
}
//减
function accMin(a, b) {
	var c, d, e;
	try {
		c = a.toString().split(".")[1].length;
	} catch (f) {
		c = 0;
	}
	try {
		d = b.toString().split(".")[1].length;
	} catch (f) {
		d = 0;
	}
	e = Math.pow(10, Math.max(c, d));
	return (accMul(a, e) - accMul(b, e)) / e;
}
//乘
function accMul(a, b) {
	var c = 0,
		d = a.toString(),
		e = b.toString();
	try {
		c += d.split(".")[1].length;
	} catch (f) {}
	try {
		c += e.split(".")[1].length;
	} catch (f) {}
	return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c).toFixed(3);
}
//除
function accDiv(a, b) {
	var c, d, e = 0,
		f = 0;
	try {
		e = a.toString().split(".")[1].length;
	} catch (g) {}
	try {
		f = b.toString().split(".")[1].length;
	} catch (g) {}
	c = Number(a.toString().replace(".", ""));
	d = Number(b.toString().replace(".", ""));
	return accMul(c / d, Math.pow(10, f - e)).toFixed(3);
}


/*
 * Pagination
 * 分页
 */

$.fn.pagination = function() {
	var $wrapper = $(this);
	var option = $wrapper.data('pagination');
	if (option === undefined) {
		option = {
			stretch: 4,
			backTop: true,
			pageSizeOption: [10, 20, 50, 100],
			onPageSelect: $.noop,
			onPageSizeChange: $.noop
		};
		$wrapper.data('pagination', option).on('click', '.page:not(.index)', function() {
			option.onPageSelect(parseInt($(this).text()));
			if (option.backTop) {
				$('html, body').animate({scrollTop:0}, 120);
			}
		}).on('click', 'a:not(.index)', function(e) {
			e.preventDefault();
			option.pageSize = parseInt($(this).text());
			option.onPageSizeChange(option.pageSize);
		});
	}
	if (arguments.length) {
		if ($.isPlainObject(arguments[0])) {
			$.extend(option, arguments[0]);
		} else if (typeof arguments[0] == 'number') {
			option.page = arguments[0];
			if (arguments.length > 1 && typeof arguments[1] == 'number') {
				option.total = arguments[1];
			}
		}
	}
	if (isNaN(option.page) || option.page < 1 || isNaN(option.pageSize) || option.pageSize < 1 || isNaN(option.total) || option.total < 0) {
		return $wrapper;
	}
	if (isNaN(option.stretch) || option.stretch < 1) {
		option.stretch = 1;
	}
	var pageCount = Math.ceil(option.total / option.pageSize);
	if (option.page >= pageCount+1) {
		return $wrapper;
	}
	var $inner = $('<ul class="pagination"/>');
	if (option.page > option.stretch + 3) {
		$inner.append('<li class="page">1</li>');
		$inner.append('<li class="omit">…</li>');
		for (var i = option.page - option.stretch; i < option.page; i++) {
			$inner.append('<li class="page">' + i + '</li>');
		}
	} else {
		for (var i = 1; i < option.page; i++) {
			$inner.append('<li class="page">' + i + '</li>');
		}
	}
	$inner.append('<li class="page index">' + (option.page) + '</li>');
	if (pageCount - option.page-2 > option.stretch + 2) {
		for (var i = option.page+1; i < option.page-1 + option.stretch + 2; i++) {
			$inner.append('<li class="page">' + i + '</li>');
		}
		$inner.append('<li class="omit">…</li>');
		$inner.append('<li class="page">' + pageCount + '</li>');
	} else {
		for (var i = option.page+1; i < pageCount + 1; i++) {
			$inner.append('<li class="page">' + i + '</li>');
		}
	}
	if (option.pageSizeOption && option.pageSizeOption.length) {
		var $pageSize = $('<li class="page-size">每页</li>');
		if (option.pageSizeOption.indexOf(option.pageSize) < 0) {
			$pageSize.append('<a href="#" class="index">' + option.pageSize + '</a>');
		}
		$(option.pageSizeOption).each(function() {
			if (this == option.pageSize) {
				$pageSize.append('<a href="#" class="index">' + this + '</a>');
			} else {
				$pageSize.append('<a href="#">' + this + '</a>');
			}
		});
		$pageSize.append('条').appendTo($inner);
	}
	return $wrapper.html($inner);
};



//计算widget显示在窗口中央的坐标
$.fn.centerSet = function(offsetX, offsetY) {
	var left = $(window).width() - this.outerWidth() >> 1;
	var top = $(window).height() - this.outerHeight() >> 1;
	left += offsetX || 0;
	top += offsetY || 0;
	return {left: left, top: top};
};


//定位在窗口中央
$.fn.center = function(offsetX, offsetY) {
	return this.each(function() {
		$(this).css($(this).centerSet(offsetX, offsetY));
	});
};




//计算widget显示在target旁边的坐标
$.fn.roundSet = function(target, offsetX, offsetY) {
	var set = { left:0, top:0 };
	if (target) {
		if (!(target instanceof jQuery)) {
			target = $(target);
		}
		offsetX = offsetX || 0;
		offsetY = offsetY || 0;
		var widgetWidth = this.outerWidth();
		var widgetHeight = this.outerHeight();
		var targetWidth = target.outerWidth();
		var targetHeight = target.outerHeight();
		var targetOffset = target.offset();
		//左边有足够的空间，优先在左边
		if (targetOffset.left > widgetWidth + offsetX) {
			set.onLeft = true;
			set.left = targetOffset.left - widgetWidth + targetWidth / 2 - offsetX;
		} else {
			set.left = targetOffset.left + targetWidth / 2 + offsetX;
		}
		//上面有足够的空间，优先在上面
		if (targetOffset.top > widgetHeight + offsetY) {
			set.onTop = true;
			set.top = targetOffset.top - widgetHeight - offsetY;
		} else {
			set.top = targetOffset.top + targetHeight + offsetY;
		}
	}
	return set;
};




/*
 * 对话框
 */

//构造方法 (object)
function Dialog(option) {
	var dialog = this;
	dialog.option = $.extend({
		lock: true,
		moveable: true,
		closeable: true
	}, option);
	dialog.$wrapper = $('<div class="dialog"/>');
	dialog.$header = $('<header/>').prependTo(dialog.$wrapper);
	dialog.$body = $('<div class="body"/>').appendTo(dialog.$wrapper);
	dialog.$footer = $('<footer/>').appendTo(dialog.$wrapper);
	if (dialog.option.id) {
		dialog.$wrapper.attr('id', dialog.option.id);
	}
	if (dialog.option.type) {
		dialog.$wrapper.addClass(dialog.option.type);
	}
	if (dialog.option.closeable || dialog.option.onClose) {
		$('<span class="icon_guanbi close"/>').click(function(e) {
			e.preventDefault();
			dialog.close(dialog.option.onClose);
		}).appendTo(dialog.$wrapper);
	}
	if (dialog.option.moveable) {
		dialog.$header.css('cursor', 'move').on('mousedown', function(e) {
			e.preventDefault();
			if (dialog.$wrapper.is('.blur')) {
				return;
			}
			var position = dialog.$wrapper.position();
			var downX = e.pageX, downY = e.pageY;
			$(document).bind('mousemove.dialog', function(e) {
				var left = position.left + e.pageX - downX;
				var top = position.top + e.pageY - downY;
				var maxLeft = $(window).width() - dialog.$wrapper.outerWidth();
				var maxTop = $(window).height() - dialog.$wrapper.outerHeight();
				if (left < 0) {
					left = 0;
				} else if (left > maxLeft) {
					left = maxLeft;
				}
				if (top < 0) {
					top = 0;
				} else if (top > maxTop) {
					top = maxTop;
				}
				dialog.$wrapper.css({left: left, top: top});
			}).one('mouseup.dialog', function() {
				$(document).unbind('mousemove.dialog');
			});
		});
	}
	dialog.title(dialog.option.title);
	dialog.content(dialog.option.content);
	dialog.operate(dialog.option.operate);
}

//标题 (string|html|jdom)
Dialog.prototype.title = function(title) {
	if (title === null) {
		this.$header.empty();
	} else if (title) {
		this.$header.html(title);
	}
	return this.adjust();
};

//内容 (string|html|jdom)
Dialog.prototype.content = function(content) {
	if (content === null) {
		this.$body.empty();
	} else if (content) {
		this.$body.html(content);
	}
	return this.adjust();
};

//操作 ([object])
Dialog.prototype.operate = function(operate) {
	if (operate === null) {
		this.$footer.empty();
	} else if (operate) {
		if ($.isPlainObject(operate)) {
			$('<button class="btn btn_yellow"/>').text(operate.text).attr(operate.attr || {}).click(operate.onClick).prependTo(this.$footer);
		} else if ($.isArray(operate)) {
			for (var i = 0; i < operate.length; i++) {
				$('<button class="btn btn_yellow"/>').text(operate[i].text).attr(operate[i].attr || {}).click(operate[i].onClick).prependTo(this.$footer);
			}
		}
	}
	return this.adjust();
};

//改变大小
Dialog.prototype.resize = function() {
	var dialog = this;
	if (dialog.option.width || dialog.option.height) {
		dialog.$body.css('overflow', 'auto');
	}
	if (dialog.option.width === 'auto') {
		var windowWidth = $(window).width();
		var dialogWidth = windowWidth - Math.max(0, windowWidth - 640) / 2;
		dialog.$body.css({width: dialogWidth});
	} else if (!isNaN(dialog.option.width)) {
		if (dialog.option.width > 1) {
			dialog.$body.css({width: dialog.option.width});
		} else if (dialog.option.width > 0) {
			dialog.$body.css({width: $(window).width() * dialog.option.width});
		}
	}
	if (dialog.option.height === 'auto') {
		var windowHeight = $(window).height();
		var dialogHeight = windowHeight - Math.max(0, windowHeight - 480) / 2;
		var bodyHeigth = dialog.$body[0].firstChild.scrollHeight;

		dialog.$body.css({height: dialogHeight - dialog.$header.height() - dialog.$footer.height()});

	} else if (!isNaN(dialog.option.height)) {
		if (dialog.option.height > 1) {
			dialog.$body.css({height: dialog.option.height - dialog.$header.height() - dialog.$footer.height()});
		} else if (dialog.option.height > 0) {
			dialog.$body.css({height: $(window).height() * dialog.option.height - dialog.$header.height() - dialog.$footer.height()});
		}
	}
	return dialog;
};

//适应窗口变化
Dialog.prototype.adjust = function() {
	var dialog = this;
	if (dialog.$wrapper.is(':visible')) {
		dialog.resize();
		var centerSet = dialog.$wrapper.centerSet();
		if (centerSet.top > 0) {
			centerSet.top = centerSet.top * 2 * (1 - 0.618);
		} else {
			centerSet.top = 0;
		}
		dialog.$wrapper.stop(true, true).animate(centerSet, 120);
	}
	return dialog;
};

//显示
Dialog.prototype.show = function() {
	var dialog = this;
	if (Dialog.dialogs.indexOf(dialog) < 0) {
		if (dialog.option.lock) {
			if (Dialog.$cover.is(':hidden')) {
				//显示遮罩
				Dialog.$cover.show();
				//隐藏滚动条
				Dialog.htmlStyleBak = $('html').attr('style');
				var windowWidth = $(window).width();
				$('html').css('overflow', 'hidden');
				var differ = $(window).width() - windowWidth;
				if (differ) {
					$('html').css('marginRight', differ);
				}
				//如果当前页面是frame弹窗则失去焦点
				if (parent.window != window && parent.Dialog) {
					var topDialog = parent.Dialog.dialogs.last();
					if (topDialog && topDialog.option.type === 'page') {
						topDialog.$wrapper.prepend('<div class="cover"/>');
					}
				}
			}
			Dialog.$cover.css({zIndex: 100 + Dialog.dialogs.length * 2 + 1});
		}
		Dialog.dialogs.push(dialog);
		dialog.$wrapper.css({zIndex: 100 + Dialog.dialogs.length * 2}).appendTo('body');
		var centerSet = dialog.resize().$wrapper.centerSet();
		dialog.$wrapper.css(centerSet);
		if (centerSet.top > 0) {
			centerSet.top = centerSet.top * 2 * (1 - 0.618);
		} else {
			centerSet.top = 0;
		}
		dialog.$wrapper.animate({opacity: 1, top: centerSet.top}, 240);
	}
	return dialog;
};

//关闭并移除 (function)
Dialog.prototype.close = function(onClose) {
	var dialog = this;
	if (Dialog.dialogs.indexOf(dialog) >= 0) {
		if ($.isFunction(onClose) && onClose.call(dialog) === false) {
			return;
		}
		Dialog.dialogs.remove(dialog);
		dialog.$wrapper.stop(true, true).animate({opacity: 0, top: '+=24'}, 240, function() {
			dialog.$wrapper.remove();
		});
		var lock = false;
		for (var i = 0; i < Dialog.dialogs.length; i++) {
			var d = Dialog.dialogs[i];
			d.$wrapper.css({zIndex: 100 + (i + 1) * 2});
			if (d.option.lock) {
				Dialog.$cover.css({zIndex: parseInt(d.$wrapper.css('zIndex')) - 1});
				lock = true;
			}
		}
		if (!lock) {
			//隐藏遮罩
			Dialog.$cover.hide();
			//显示滚动条
			if (Dialog.htmlStyleBak) {
				$('html').attr('style', Dialog.htmlStyleBak);
			} else {
				$('html').removeAttr('style');
			}
			//如果当前页面是frame弹窗则获取焦点
			if (parent.window != window && parent.Dialog) {
				var topDialog = parent.Dialog.dialogs.last();
				if (topDialog && topDialog.option.type === 'page') {
					topDialog.$wrapper.find('.cover').remove();
				}
			}
		}
		if ($.isFunction(dialog.option.onDismiss)) {
			dialog.option.onDismiss();
		}
	}
	return dialog;
};

//弹消息
Dialog.popup = function(content, onDismiss) {
	if (content && typeof content === 'string') {
		var popupDialog = new Dialog({
			type: 'popup',
			closeable: false,
			lock: false,
			content: content,
			onDismiss: onDismiss
		}).show();
		popupDialog.$body.click(function() {
			clearTimeout(popupDialog.timer);
			popupDialog.close();
		});
		popupDialog.timer = setTimeout(function() {
			popupDialog.close();
		}, content.length * 80 + 2000);
	}
};

//加载器 (string|html|jdom)
Dialog.loading = function(content) {
	content = (typeof content === 'string') ? content : '';
	if (Dialog.loaderDialog) {
		Dialog.loaderDialog.content(content).adjust();
	} else {
		Dialog.loaderDialog = new Dialog({
			type: 'loader',
			closeable: false,
			content: content
		}).show();
	}
};

//关闭加载器
Dialog.loadingOff = function() {
	if (Dialog.loaderDialog) {
		Dialog.loaderDialog.close();
		Dialog.loaderDialog = null;
	}
};

//提示对话框 (string, [function] | object)
Dialog.alert = function() {
	var option = {
		title: '温馨提示',
		content: null,
		confirmText: '确定',
		onConfirm: $.noop
	};
	if (arguments.length) {
		if ($.isPlainObject(arguments[0])) {
			$.extend(option, arguments[0]);
		} else {
			option.content = arguments[0];
			if ($.isFunction(arguments[1])) {
				option.onConfirm = arguments[1];
			}
		}
	}
	var dialog = new Dialog({
		type: 'alert',
		closeable: false,
		title: option.title,
		content: option.content,
		operate: {
			text: option.confirmText,
			attr: {'class': 'btn btn_yellow btn_alert'},
			onClick: function() {
				dialog.close(option.onConfirm);
			}
		}
	}).show();
	return dialog;
};

//确认对话框 (string, [function] | object)
Dialog.confirm = function() {
	var option = {
		title: '温馨提示',
		content: null,
		confirmText: '确定',
		onConfirm: $.noop,
		cancelText: '取消',
		onCancel: $.noop
	};
	if (arguments.length) {
		if ($.isPlainObject(arguments[0])) {
			$.extend(option, arguments[0]);
		} else {
			option.content = arguments[0];
			if ($.isFunction(arguments[1])) {
				option.onConfirm = arguments[1];
			}
		}
	}
	var dialog = new Dialog({
		type: 'alert',
		closeable: false,
		title: option.title,
		content: option.content,
		operate: [{
			text: option.confirmText,
			onClick: function() {
				dialog.close(option.onConfirm);
			}
		}, {
			text: option.cancelText,
			attr: {'class': 'btn btn_red btn_small'},
			onClick: function() {
				dialog.close(option.onCancel);
			}
		}]
	}).show();
	return dialog;
};

//输入对话框 (object)
Dialog.input = function(option) {
	option = $.extend({
		title: '输入框',
		attr: {},
		select: true,
		confirmText: '确定',
		onConfirm: $.noop,
		cancelText: '取消',
		onCancel: $.noop
	}, option);
	var $input = $('<input type="text"/>').attr(option.attr).filterInput().placeholder().keydown(function(e) {
		if (e.keyCode == 13) {
			$(this).parent().next().children(':last').click();
		}
	}).blur(function() {
		$(this).hideTip();
	});
	var dialog = new Dialog({
		type: 'input',
		closeable: false,
		title: option.title,
		content: $input,
		operate: [{
			text: option.confirmText,
			onClick: function() {
				var input = $input.val().trim();
				if ($input.prop('required') && !input) {
					$input.select().showTip('此项不能为空');
					return;
				}
				if (option.onConfirm.call(dialog, input) === true) {
					dialog.close();
				}
			}
		}, {
			text: option.cancelText,
			attr: {'class': 'negative'},
			onClick: function() {
				dialog.close(option.onCancel);
			}
		}]
	}).show();
	dialog.$input = $input;
	if (option.select) {
		$input.select();
	} else {
		$input.focus();
	}
	return dialog;
};

//页面对话框 (string, [string] | object)
Dialog.open = function() {
	var option = {
		type: 'page',
		width: 'auto',
		height: 'auto'
	};
	if (arguments.length) {
		if ($.isPlainObject(arguments[0])) {
			$.extend(option, arguments[0]);
		} else if (typeof arguments[0] === 'string') {
			option.url = arguments[0];
			if (arguments.length > 1) {
				option.title = arguments[1];
			}
		}
	}
	if (!option.url || typeof option.url !== 'string') {
		throw new Error('Dialog.open() need a string argument named "url".');
	}
	option.content = $('<iframe/>').attr({name: 'dialog_window', src: option.url});
	var dialog = new Dialog(option);
	if (!option.width || !option.height) {
		option.content.css({visibility: 'hidden'}).load(function() {
			if (!option.width) {
				dialog.option.width = this.contentWindow.document.body.scrollWidth;
				if (option.height) {
					dialog.option.width += 20;
				}
			}
			if (!option.height) {
				dialog.option.height = this.contentWindow.document.body.scrollHeight;
				dialog.option.height += dialog.$header.height() + dialog.$footer.height();
			}
			option.content.removeAttr('style');
			dialog.adjust();
		});
	}
	return dialog.show();
};

Dialog.$cover = $('<div id="cover"/>').appendTo('body');

Dialog.dialogs = [];

//窗口大小变化时弹窗自动居中
$(window).on('resize.dialog', function() {
	$(Dialog.dialogs).each(function() {
		this.adjust();
	});
});



/*
 * 下接选框
 */

$.fn.selection = function(opt) {
	return this.each(function() {
		var $target = $(this);
		if (!$target.is('.select')) {
			return;
		}
		var option = $target.data('option');
		
		if (!option) {
			option = {};
			console.log(123)
			$target.wrapInner('<b/>').prepend('<span></span>').hover(function() {
				if (!$target.is('.disabled')) {
					option.timer = setTimeout(function() {
						$target.addClass('open');
					}, 120);
				}
			}, function() {
				clearTimeout(option.timer);
				$target.removeClass('open');
			}).on('click', 'i', function() {
				var $item = $(this).addClass('selected').siblings('.selected').removeClass('selected').end();
				$target.removeClass('open').children('span').text($item.text());
				if (option.onChange) {
					option.onChange.call($target.get(0), $item.text(), $item.data('value'));
				}
			}).data('option', option);
			if ($target.find('.selected').length) {
				$target.children('span').text($target.find('.selected').text());
			} else if ($target.find('i').length) {
				$target.children('span').text($target.find('i:first').addClass('selected').text());
			}
		}
		var oldItems = option.items;
		if ($.isPlainObject(opt)) {
			$.extend(option, opt);
		} else if ($.isFunction(opt)) {
			option.onChange = opt;
		} else if ($.isArray(opt)) {
			option.items = opt;
		} else {
			return;
		}
		if (option.items && option.items !== oldItems) {
			var oldText = $target.text();
			var oldValue = $target.val();
			var $b = $target.children('span').empty().next().empty();
			for (var i = 0; i < option.items.length; i++) {
				var item = option.items[i];
				if (typeof item === 'string' || typeof item === 'number') {
					$('<i/>').text(item).appendTo($b);
				} else if (typeof item === 'object' && option.text) {
					var text;
					if (typeof option.text === 'string') {
						text = item[option.text];
					} else if (typeof option.text === 'function') {
						text = option.text.call(item);
					}
					if (text) {
						var $item = $('<i/>').text(text).appendTo($b);
						if (typeof option.value === 'string') {
							$item.data('value', item[option.value]);
						} else if (typeof option.value === 'function') {
							$item.data('value', option.value.call(item));
						} else {
							$item.data('value', item);
						}
					}
				}
			}
			if ($b.children().length) {
				if (oldValue) {
					$target.val(oldValue);
				} else if (oldText) {
					$target.text(oldText);
				}
				if (!$b.find('.selected').length) {
					$target.children('span').text($b.children(':first').addClass('selected').text());
				}
			}
		}
	});
};

/*
 * 可输入下接选框
 */

$.fn.inputSelect = function(opt) {

	return this.each(function() {
		var $target = $(this);
		if (!$target.is('.select')) {
			return;
		}
		
		var option = $target.data('option');
		if (!option) {
			option = {};
			$target.wrapInner('<b/>').prepend('<input id="inputselect" />').hover(function() {
				if (!$target.is('.disabled')) {
					option.timer = setTimeout(function() {
						$target.addClass('open');
					}, 120);
				}
			}, function() {
				clearTimeout(option.timer);
				$target.removeClass('open');
			}).on('click', 'i', function() {
				var $item = $(this).addClass('selected').siblings('.selected').removeClass('selected').end();
				$target.removeClass('open').children('input').val($item.text());
				if (option.onChange) {
					option.onChange.call($target.get(0), $item.text(), $item.data('value'));
				}
			}).data('option', option);
			if ($target.find('.selected').length) {
				$target.children('input').val($target.find('.selected').text());
			} else if ($target.find('i').length) {
				$target.children('input').val($target.find('i:first').addClass('selected').text());
			}
		}
		var oldItems = option.items;
		if ($.isPlainObject(opt)) {
			$.extend(option, opt);
		} else if ($.isFunction(opt)) {
			option.onChange = opt;
		} else if ($.isArray(opt)) {
			option.items = opt;
		} else {
			return;
		}
		if (option.items && option.items !== oldItems) {
			var oldText = $target.text();
			var oldValue = $target.val();
			var $b = $target.children('input').empty().next().empty();
			for (var i = 0; i < option.items.length; i++) {
				var item = option.items[i];
				if (typeof item === 'string' || typeof item === 'number') {
					$('<i/>').text(item).appendTo($b);
				} else if (typeof item === 'object' && option.text) {
					var text;
					if (typeof option.text === 'string') {
						text = item[option.text];
					} else if (typeof option.text === 'function') {
						text = option.text.call(item);
					}
					if (text) {
						var $item = $('<i/>').text(text).appendTo($b);
						if (typeof option.value === 'string') {
							$item.data('value', item[option.value]);
						} else if (typeof option.value === 'function') {
							$item.data('value', option.value.call(item));
						} else {
							$item.data('value', item);
						}
					}
				}
			}
			if ($b.children().length) {
				if (oldValue) {
					$target.val(oldValue);
				} else if (oldText) {
					$target.text(oldText);
				}
				if (!$b.find('.selected').length) {
					//$target.children('input').val($b.children(':first').addClass('selected').text());
				}
			}
		}
	});
};



var originalJqueryChangeFunction = $.fn.change;

$.fn.change = function() {
	if (!this.is('.select')) {
		return originalJqueryChangeFunction.apply(this, arguments);
	}
	if (!arguments.length) {
		return this.each(function() {
			var $target = $(this);
			var option = $target.data('option');
			if (option && option.onChange && $target.text()) {
				option.onChange.call(this, $target.text(), $target.val());
			}
		});
	} else if ($.isFunction(arguments[0])) {
		return this.selection(arguments[0]);
	}
};


var originalJqueryTextFunction = $.fn.text;

$.fn.text = function() {
	if (!this.is('.select')) {
		return originalJqueryTextFunction.apply(this, arguments);
	}
	if (!arguments.length) {
		return this.eq(0).children('span').text();
	} else if (typeof arguments[0] === 'string' && arguments[0]) {
		var text = arguments[0];
		return this.each(function() {
			var $target = $(this);
			var option = $target.data('option');
			if (option) {
				var $item = $target.find('i').filter(function() {
					return $(this).text() === text;
				});
				if ($item.length && !$item.is('.selected')) {
					$item.addClass('selected').siblings('.selected').removeClass('selected');
					$target.children('span').text($item.text());
				}
			}
		});
	} else {
		return this;
	}
};

$.fn.watch = function (callback) {
    return this.each(function () {
        //缓存以前的值  
        $.data(this, 'originVal', $(this).val());

        $(this).on('input', function () {
            var originVal = $.data(this, 'originVal');
            var currentVal = $(this).val();

            if (originVal !== currentVal) {
                $.data(this, 'originVal', $(this).val());
                callback(currentVal);
            }
        });
    });
};

var originalJqueryValFunction = $.fn.val;

$.fn.val = function() {
	if (!this.is('.select')) {
		return originalJqueryValFunction.apply(this, arguments);
	}
	if (!arguments.length) {
		return this.eq(0).find('.selected').data('value');
	} else {
		var value = arguments[0];
		return this.each(function() {
			var $target = $(this);
			var option = $target.data('option');
			if (option) {
				var $item = $target.find('i').filter(function() {
					return $(this).data('value') === value;
				});
				if ($item.length && !$item.is('.selected')) {
					$item.addClass('selected').siblings('.selected').removeClass('selected');
					$target.children('span').text($item.text());
				}
			}
		});
	}
};

//显示tip
$.fn.showTip = function(content) {
	return this.each(function() {
		if (content === undefined || content === null) {
			return;
		}
		var $target = $(this);
		var $tip = $target.data('$tip');
		if ($tip) {
			$target.setTip(content);
			return;
		}
		$tip = $('<div class="tip"/>').html(content)
			.wrapInner((typeof content === 'string' && !content.startsWith('<')) ? '<p/>' : '<div/>')
			.appendTo('body');
		$target.data('$tip', $tip);
		var set = $tip.roundSet($target, -18, 8 + 16);
		$tip.addClass(set.onLeft ? 'left' : 'right')
			.addClass(set.onTop ? 'top' : 'bottom')
			.css(set).stop(false).animate({opacity: 0.9, top: (set.onTop ? '+=16' : '-=16')}, 200);
	});
};

//更新tip
$.fn.setTip = function(content) {
	return this.each(function() {
		if (content === undefined || content === null) {
			return;
		}
		var $target = $(this);
		var $tip = $target.data('$tip');
		if ($tip) {
			var set = $tip.html(content)
				.wrapInner((typeof content === 'string' && !content.startsWith('<')) ? '<p/>' : '<div/>')
				.removeClass('left right top bottom').roundSet($target, -18, 8);
			$tip.stop(true, true).css(set).addClass(set.onLeft ? 'left' : 'right').addClass(set.onTop ? 'top' : 'bottom');
		}
	});
};

//关闭tip
$.fn.hideTip = function() {
	return this.each(function() {
		var $tip = $(this).data('$tip');
		if ($tip) {
			$(this).removeData('$tip');
			$tip.stop(false).animate({opacity: 0, top: ($tip.is('.top') ? '-=16' : '+=16')}, 200, function() {
				$tip.remove();
			});
		}
	});
};

//鼠标滑动提示
$.fn.tip = function() {
	var args = arguments;
	return this.off('.tip').on('mouseenter.tip', function() {
		var $target = $(this).data('timer', setTimeout(function() {
			if (args.length) {
				if ($.isFunction(args[0])) {
					$target.showTip(args[0].call($target.get(0)));
				} else {
					$target.showTip(args[0]);
				}
			} else if ($target.data('tip') !== undefined) {
				$target.showTip($target.data('tip').replace(/\|/g, '<br />'));
			}
		}, 80));
	}).on('mouseleave.tip', function() {
		clearTimeout($(this).data('timer'));
		$(this).hideTip();
	});
};




//输入过滤
$.fn.filterInput = function() {
	return this.each(function() {
		if ($(this).is('.number')) {
			//无小数点数字
			$(this).keydown(function(e) {
				var c = e.keyCode;
				if (c == 8 || c == 9 || c == 13 || (c > 47 && c < 58) || (c > 95 && c < 106)) {
					return true;
				}
				return false;
			}).keyup(function() {
				var val = isNaN(this.value),
					judge = /^[0-9]*$/;
				if (judge.test(val)) {
					this.value = val;
				} else {
					this.value = this.value.replace(/\D/g, '');
				}
			});
		} else if ($(this).is('.decimal')) {
			//有小数点的数字
			$(this).keydown(function(e) {
				var c = e.keyCode;
				if (c == 8 || c == 9 || c == 13 || c == 110 || c == 190 || (c > 47 && c < 58) || (c > 95 && c < 106)) {
					return true;
				}
				return false;
			}).keyup(function() {
				if (isNaN(this.value)) {
					this.value = this.value.replace(/[^\d.]/g, '');
				}
			});
		}
	});
};

//滚动监听
$.fn.onScroll = function(option) {
	return this.scroll(function() {
		var top = $(this).data('top') || 0;
		var scrollTop = $(this).scrollTop();
		if (scrollTop > top) {
			if (option.down) {
				option.down.call($(this), scrollTop);
			}
		} else {
			if (option.up) {
				option.up.call($(this), scrollTop);
			}
		}
		if (scrollTop == 0) {
			if (option.top) {
				option.top.call($(this), scrollTop);
			}
		} else if (scrollTop + $(this).height() - (this.scrollHeight || document.body.scrollHeight) >= -2) {
			if (option.bottom) {
				option.bottom.call($(this), scrollTop);
			}
		}
		$(this).data('top', scrollTop);
	});
};

//关闭警告窗口
$.fn.closeAlert = function() {
	return this.click(function() {
		var $this = $(this),
		state = $this.data("close");
		if (state) {
			$this.parent().remove();
		}
	});
};

//显示下接框
function dropdown(e) {
	var $this = $(this),
		$parent  = $this.parent(),
		isActive = $parent.hasClass('open');

	if ($this.is('.disabled, :disabled')) return;
	
	clearMenus();
	
	if (!isActive) {
		$parent.trigger(e = $.Event('show'));
		$parent.toggleClass('open').trigger('shown');
		$this.focus();
	}
	return false;
}
//隐藏所有下拉框
function clearMenus() {
	$('[data-toggle=dropdown]').each(function (e) {
		var $this = $(this),
			$parent  = $this.parent();

		if (!$parent.hasClass('open')) return;

		$parent.trigger(e = $.Event('hide'));

		if (e.isDefaultPrevented()) return;
		
		$parent.removeClass('open').trigger('hidden');
	})
}

//页面预处理
$(function() {
	
	//为body元素添加窗口类型标识，以方便样式控制
	$(document.body).addClass(window.name ? window.name.replace('_window', '-body') : '');
	 
	
	//防止点击空白a标签页面回滚
	$('a[href=#]').click(function(e) {
		e.preventDefault();
	});
	
	//关闭警告窗口
	$('.close').closeAlert();

	//弹窗页面
	$('a[target=dialog]').click(function(e) {
		e.preventDefault();
		Dialog.open(this.href, this.title || $(this).text());
	});

	//输入过滤，IE9 placeholder支持

	$(':text').filterInput().placeholder();

	//IE9 placeholder支持
	$('textarea').placeholder();

	//tip显示处理
	$('[data-tip]').tip();

	//下拉选择
	//$('.select').selection();

	//导行处理
	$('.nav > li').click(function() {
		$(this).addClass('active').siblings().removeClass('active');
	});
	$(".head_bread").on("click", 'li', function() {
		$(this).addClass('active').siblings().removeClass('active');
	});
	$("nav > a").click(function() {
		$(this).addClass('index').siblings().removeClass('index');
	});
	
	
	//添加搜索自动显示删除按钮
	var isFocus = false
	$('.search_label').on('focus', 'input', function () {
		if ($(this).val() !== '') {
			isFocus = true;
		} else {
			isFocus = false;
		}
	}).on('keyup', 'input', function () {
		if ($(this).val() == '' && isFocus) {
			$('#search').click();
		}
	})
	
	
	//tab处理
	$(".tabs > li").click(function() {
		var $target = $(this),
			dome = $target.data("dome");
			
		//空li不能点击
		if ($target.is('.disabled, :disabled')) return;
		
		$target.addClass('active').siblings().removeClass('active');
		$(dome).addClass('tab_active').siblings().removeClass('tab_active');
	});

	//带按钮的输入框回车触发按钮点击事件
	$(':text + button').prev().keydown(function(e) {
		if (e.keyCode == 13) {
			$(this).next().click();
		}
	});
	
	//显示导航内容
	showNav();
	
	//导行样式
	var url = window.location.pathname,
		urlArray = url.split('/'),
		len = urlArray.length,
		urlName = "/" + urlArray.pop(),
		$html,
		jumpUrl = getUrlParam("jumpUrl"),
		jumpID = getUrlParam("id");

	if (jumpUrl) {
		urlName = "/"+jumpUrl+".html";
	} else if (urlName == "/") {
		urlName = "/manage_index.html";
	}
	
	if (jumpID =='userNav') {
		$html = $("#userNav").find('a');	
	} else if (len <= 2) {
		$html = $(".head_nav").find('a');
	} else {
		$html = $(".vice_nav").find('a');
	}
	
	$html.each(function() {
		var $target = $(this),
			href = $target.attr("href");
		
		if ( href.indexOf(urlName) >= 0) {
			$target.parent("li").addClass("active");
			$target.parents(".vice_nav").show().siblings(".vice_nav").remove();
			var dome = $target.parents(".vice_nav").data('dome');
			$("#"+dome).addClass("active");
		}
	});

	//快速复制到剪贴板
	$('table > tbody').on('click', '.clipboard', function() {
		var $target = $(this),
			content = $target.text();
		if (window.clipboardData && clipboardData.setData('Text', content)) {
			Dialog.popup('已复制到剪贴板');
			return;
		}
		if (content) {
			$target.html($('<input type="text" />').attr('title', '按Ctrl+C复制到剪贴板').val(content).click(function() {
				$(this).hideTip();
				$target.text(content);
			}).keyup(function() {
				$(this).hideTip();
				$target.text(content);
			}).blur(function() {
				$(this).hideTip();
				$target.text(content);
			})).children().select().showTip('按Ctrl+C复制到剪贴板');
		}
	});
	
	

	//带选择框的table支持tr点击选中，全选/全不选
	$('table.selectable > tbody').on('click', 'tr', function() {
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
	
	//展开内联表格
	$("#packageList").on('click', '.shouqi', function(e) {
		e.preventDefault();
		var $target = $(this),
			$table = $target.parents("tr"),
			$innerTable = $table.next();

		if ($target.text() == "展开") {
			$target.text("收起").removeClass("icon_xiangxia").addClass("icon_xiangshang");
			//$target.parent().parent().css('border-bottom', '1px solid #00B7EE');
		} else {
			$target.text("展开").removeClass("icon_xiangshang").addClass("icon_xiangxia");
			$target.parent().parent().css('background-color', 'none');
		}

		if($innerTable.is(":hidden")){
			$innerTable.show().css('background-color', '#f0f0f0');
		}else{
			$innerTable.hide(); 
		}

	}).on('click', 'a.icon_xiangshang,input', function(e) {
		e.stopPropagation();
	});	
	
	//初始化下拉按钮
	$(document).on('click', clearMenus).on('click', '[data-toggle=dropdown]', dropdown);

	
	//弹出修改密码//清空cookie
	$(".head_bread").on("click", '#modify', changePass).on("click", '#exitLogin', function() {
		Dialog.confirm({
			title: null,
		    content: '<i class="icon_tishi alertIcon"></i><h4>您确定要退出登录吗？</h4>',
		    confirmText: '确定',
		    onConfirm: function() {
				if (!GetCookie("qixioudr", "username")) {
					$.cookie('qixioudr', '',{"path":"/", expires: -1 });	
				}
				location = "/";
			}
		});		
	});
	
	//厂牌写入sessionStorage
	getWxCarBrandList();
	var CAR_brand = JSON.parse(sessionStorage.getItem("WxCarBrandList"));

//	for (let key in CAR_brand) {
//		if (CAR_brand[key].pycode) {
//			CAR_BRAND[CAR_brand[key].pycode]  =  CAR_brand[key].namecn;
//		}
//	}
	
});

//显示导航内容
function showNav() {
	//导行内容
	var navData = [
		{name: "首页", url: "/manage_index.html"},
		{name: "开单管理", url: "/billing/order.html", 
			nav:[{name: "开单管理", url: "/billing/order.html"},
				{name: "预约单管理", url: "/billing/reservat.html"}]
		},
		{name: "客户管理", url: "/client/info.html",
			nav:[{name: "客户信息", url: "/client/info.html"},
				{name: "消费记录", url: "/client/consume.html"}]
		},
		{name: "库存管理", url: "/stock/order_delivery.html",
			nav:[{name: "工单出库", url: "/stock/order_delivery.html"},
				{name: "耗材出库", url: "/stock/material_delivery.html"}]
		},
		//{name: "卡片管理", url: "/card/stored_card.html",
			//nav:[{name: "储值卡管理", url: "/card/stored_card.html"}]
		//},
		{name: "综合统计", url: "/statistics/statistic_income.html", 
			nav:[{name: "收入统计", url: "/statistics/statistic_income.html"},
				{name: "单量统计", url: "/statistics/statistic_single.html"},
				{name: "推修转化率统计", url: "/statistics/statistic_repair.html"}]
		}
	],

	userNavData = [
		{name: "头像", url: localStorage.getItem("faceImage")},
		{name: GetCookie("qixioudr", "memberName"), url: "#"},
		{name: "员工管理", url: "/staff_manage.html?id=userNav"},
		{name: "退出登录", url: "#", id: "exitLogin"}
	],
	navHtml = "",
	viceNav = "",
	len = navData.length,
	userLen = userNavData.length,
	userHtml = "";
	//导行模板
	for (var i = 0; i < len; i++) {
		var nav = navData[i].nav,
			dome = "";
		if (nav) {
			var navLen = nav.length,
				navTwoHtml = "";
				
			dome = 'id="dome'+[i+1] + '"';
			
			for (var j = 0; j<navLen; j++) {
				navTwoHtml += '<li><a href="' + nav[j].url + '">' + nav[j].name + '</a></li>';
			}
			
			viceNav += '<div class="grid vice_nav" data-dome="dome'+ [i+1] +'"><ul class="nav grid_12">' + navTwoHtml + '</ul></div>';
		}
		
			navHtml += '<li ' + dome + '><a href="' + navData[i].url + '">' + navData[i].name + '</a></li>';
		
		
			
	}
	$("#nav").html(navHtml);
	$(".head_nav").after(viceNav);
	
	for (var h = 0; h < userLen; h++) {
		var nextNav = userNavData[h].nav,
			nextHtml = "",
			ID = userNavData[h].id ? 'id="' + userNavData[h].id + '"' : '',
			dataToggle = '';
		if (nextNav) {
			var nextLen = nextNav.length;
			for (var g=0; g<nextLen; g++) {
				var nextID = nextNav[g].id ? 'id="' + nextNav[g].id + '"' : '';
				nextHtml += '<li '+ nextID +'><a href="' + nextNav[g].url + '">' + nextNav[g].name + '</a></li>';
			}
			nextHtml = '<ul class="dropdown_menu">' + nextHtml + '</ul>'
			dataToggle = "data-toggle=dropdown";
		}

		if (userNavData[h].name == '头像') {
			userHtml += '<img class="user_head" src="' + userNavData[h].url + '" />'
		} else {
			userHtml += '<li '+ ID +'><a href="' + userNavData[h].url +'"' + dataToggle +'>' + userNavData[h].name + '</a>'+nextHtml+'</li>';
		}
	}
	$("#userNav").html(userHtml);
}

//获取Cookie字段值
function GetCookie(mname, sname) {
	if ($.cookie(mname)){
		var cookies = $.cookie(mname).split('&');
		var res = '';
		for (var i = 0; i < cookies.length; i++) {
			var one = cookies[i].split(':');
			if (one[0] == sname) {
				res = one[1];
				break;
			}
		}
		return res;
	}
}

//修改密码
function changePass() {
	var changePassDig = new Dialog()
    .title('修改密码')
    .content('<div class="change_pass"><label><span>原密码：</span><input type="text" id="password" maxlength="20" /></label>'
			+'<label><span>新密码：</span><input type="password" id="newPass" maxlength="20" /></label>'
			+'<label><span>确认新密码：</span><input type="password" id="newPassword" maxlength="20" /></label></div>')
    .operate({
        text: '确定',
        onClick: function() {
            var $target = $(this).parents(".dialog"),
				password = $target.find("input").eq(1).val().trim();
				changePass = {};
				changePass.id = GetCookie("qixioudr", "id")
				changePass.password = $target.find("input").eq(0).val().trim();
				changePass.newPassword = $target.find("input").eq(2).val().trim();
			if (changePass.password == '' || changePass.password.length < 6) {
				Dialog.popup('请输入原密码！');
				$target.find("input").eq(0).focus();
				return false;
			}
			if (password == '' || password.length < 6) {
				Dialog.popup('请输入新密码！');
				$target.find("input").eq(1).focus();
				return false;
			}
			if (password != changePass.newPassword) {
				Dialog.popup('两次输入密码不同！');
				return false;
			}
			sendRequest({
				token: false,
				action: 'ar/member/updatePassward',
				data: changePass,
				lock: true,
				onSuccess: function(obj) {
					if (obj.status == 'success') {
						Dialog.popup('密码修改成功！');
						changePassDig.close();
					} 
				}
			});
        }
    }).show();
}

//判断登录
function isLogin() {
	var userCookie = GetCookie("qixioudr", "accessToken");
	if (userCookie == "" || userCookie == null) {
		location = "/";
		return false;
	}
}

//序号
function orderNum() {
	var $orderNum = $('.order_num'),
		len = $orderNum.length;
	for(var i = 0;i <= len; i++){
		$orderNum.eq(i).text(i+1);
	}
}

//圆形进度条
function DrowProcess(x,y,radius,process,backColor,proColor, canvasId){
	//x,y 坐标,radius 半径,process 百分比,backColor 进度底色, proColor 进度颜色, canvasId 画布区域ID

	if (canvasId.getContext) {
		var cts = canvasId.getContext('2d');
	}else{
		return;
	}
	
	cts.beginPath();  
	// 坐标移动到圆心  
	cts.moveTo(x, y);  
	// 画圆,圆心是24,24,半径24,从角度0开始,画到2PI结束,最后一个参数是方向顺时针还是逆时针  
	cts.arc(x, y, radius, 0, Math.PI * 2, true);  
	cts.closePath();  
	// 填充颜色  
	cts.fillStyle = backColor;  
	cts.fill();

	cts.beginPath();  
	// 画扇形的时候这步很重要,画笔不在圆心画出来的不是扇形  
	cts.moveTo(x, y);  
	// 跟上面的圆唯一的区别在这里,不画满圆,画个扇形  
	cts.arc(x, y, radius, Math.PI * 1.5, Math.PI * 1.5 +  Math.PI * 2 * process / 100, false);  
	cts.closePath();  
	cts.fillStyle = proColor;  
	cts.fill(); 
	
	//填充背景白色
	cts.beginPath();  
	cts.moveTo(x, y); 
	cts.arc(x, y, radius - (radius * 0.26), 0, Math.PI * 2, false);  
	cts.closePath();
	cts.fillStyle = 'rgba(255,255,255,1)';  
	cts.fill(); 

	// 画一条线  
	cts.beginPath();  
	cts.arc(x, y, radius-(radius * 0.30), 0, Math.PI * 2, false);  
	cts.closePath();  
	// 与画实心圆的区别,fill是填充,stroke是画线  
	cts.strokeStyle = backColor;  
	cts.stroke();  

}


//字典表写入sessionStorage
//获取保险公司
function getBxInsurerinfoList() {
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
				}
			}
		});
	}
}
//获取店面ＳＡ
function getWxRolesmemberList() {
var WxRolesmemberList = sessionStorage.getItem("WxRolesmemberList");
	if (WxRolesmemberList === null) {
		sendRequest({
			token: true,
			action: 'carbeauty/getWxRolesmemberList',
			data: {type: 3, shopId: 0},		//type 1私家客户，VIP客户等；2供应商；3保险公司
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					sessionStorage.setItem( "WxRolesmemberList", JSON.stringify(data));
				}
			}
		});
	}
}

//获取厂牌
function getWxCarBrandList() {
var WxCarBrandList = sessionStorage.getItem("WxCarBrandList");

	if (WxCarBrandList === null) {
		sendRequest({
			token: false,
			action: 'common/standard/getWxCarBrandList',
			data: { phoneType: 'pc' },
			onSuccess: function(obj) {
				if (obj.status == 'success') {
					var data = obj.page.items || [];
					var carBrand = '';
					sessionStorage.setItem( "WxCarBrandList", JSON.stringify(data));
				}
			}
		});
	}
}

//关闭弹出登录框
function closeLoginDialog() {
	var urlName = window.location.pathname,
		urlParam = window.location.search
	location = urlName + urlParam;
	loginDialog.close();
}

function toUnicode(s){ 
	return s.replace(/([\u4E00-\u9FA5]|[\uFE30-\uFFA0])/g,function(){
  return "\\u" + RegExp["$1"].charCodeAt(0).toString(16);
    });
}

