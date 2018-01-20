/**
*@desc 全局提示变量
*/
var tips;
/**
*@desc 全局钻取路径
*/
var path = [
];


/**
*@desc 查询按钮点击事件
*/
function setSubmitItem() {
	hideTips();
	tips=null;
	var required=false;
	var form=document.forms['queryForm'];
	if(window.required){
		required=window.required(form);
	}
	path=[];
	if(!required){
		showLoading();
		return true;
	}else{
		showTips(required,3000);
		return false;
	}
}

function showLoading(){
	var language = document.forms["queryForm"].locale.value;
	var tips = 'Query ...';

	if(!window.loadingTips){
		var o=showOverlay();
		var l=showTips(tips);
		l.o=o;
		window.loadingTips=l;
	}else{
		var l=window.loadingTips;
		if(l.o){
			l.o.style.display='block';
		}
		l.style.display='block';
	}
}
function hideLoading(){
	var l=window.loadingTips;
	if(l){
		if(l.o){
			l.o.style.display='none';
		}
		l.style.display='none';
	}
}
function showOverlay(){
	var div = document.createElement('div');
	document.body.appendChild(div);
	var css = {
		position : 'absolute',
		width:'100%',
		height:'100%',
		left : '0',
		top : '0',
		background : 'none repeat scroll 0 0 #aaa',
		opacity:0.2,
		filter:"alpha(opacity=20)",
		zIndex : 999
	}
	for (var c in css) {
		div.style[c] = css[c];
	}
	return div;
}
/**
*@desc 初始化表单数据
*/
function initFormData(items) {
	var form=document.forms['queryForm'];
	for (var i = 0, len = items.length; i < len; i++) {
		var el=form[items[i]];
		if(el){
			el.value='';
		}
	}
	initTime();
}
/**
*@desc 显示提示器
*/
function showTips(tip,timeout) {
	var div = document.createElement('div');
	document.body.appendChild(div);
	var css = {
		position : 'absolute',
		height : '',
		left : '45%',
		top : '40%',
		lineHeight : '30px',
		padding : '5px 20px',
		border : 'solid 2px #79BDFE',
		background : 'none repeat scroll 0 0 #E6F7FE',
		color : '#FF6600',
		fontWeight : 'bold',
		zIndex : 1000
	}
	for (var c in css) {
		div.style[c] = css[c];
	}
	div.innerHTML = tip || '请先选择查询条件！';
	if(timeout){
		setTimeout(function(){
			document.body.removeChild(div);
		},timeout);
	}
	return div;
}
/**
*@desc 隐藏提示器
*/
function hideTips(t) {
	t = t || tips;
	if (t) {
		document.body.removeChild(t);
	}
}

/**
*@desc 初始化iframe
*/
function initiFrame() {
	
	initTime();
	
	//var tabs=document.getElementsByTagName('table');
	var tabs = document.body.children;
	for (var i = 0, len = tabs.length; i < len; i++) {
		var t = tabs[i];
		t.style.height = '100%';
	}
	var height = frameElement.parentNode.offsetHeight;
	if (isFF) {
		height -= 70;
	}
	frameElement.height = height - 10;
	
	frameElement.style.height = '100%';

	//initSubmit
	var form=document.forms['queryForm'];
	form['pageCond/length'].value=0;
	document.forms['queryForm'].submit();
	form['pageCond/length'].value=10;
}

/**
*@desc 转到
*/
function goTo(el) {
	path.pop();
	path.pop();
}
/**
*@desc 钻取
*/
function queryResult(pinfo) {
	showLoading();
	
	var doc = $id("queryResult").contentWindow.document;
	var form = doc.forms['resultForm'];
	pinfo=pinfo||[];
	var param = pinfo.param;
	
	var ps=['_eosFlowAction='+pinfo.fa];
	if (param) {
		for (var p in param) {
			ps.push(p+'='+param[p]);
		}
	}
	
	form.action=action+'?'+ps.join('&');
	//form.action = action + '?_eosFlowAction=' + pinfo.fa;
	if (form['pageCond/begin']) {
		form['pageCond/begin'].value = 0;
	}
	
	//form.action='com.primeton.bps.web.statistics.queryWorkload.flow?_eosFlowAction='+pinfo.fa;
	form.submit();
}
/**
*@desc 添加一条钻取记录，自动执行钻取的查询操作，供钻取的结果页面调用
*/
function addPath(_path) {
	path.push(_path);
}
/**
*@desc 创建钻取记录路径
*/
function createPath(doc) {
	var language = document.forms["queryForm"].locale.value;
	var pd = doc.getElementById('path');
	if(path.length>1){
		var btn='<input type="button" class="button" value="" style="background-image:url(\'../images/back.png\');background-position:center center;cursor:pointer;margin:0px 1px;" onclick="goTo(this);return false;" />';
		
		pd.innerHTML=btn;
	}else{
		pd.innerHTML='';
	}
}
/**
*@desc 创建select的option选项
*/s
function createOp(y, p) {
	p.options.add(new Option(y, y));
}
/**
*@desc 清除select控件的option选项
*/
function clearOptions(s) {
	var ops = s.options;
	while (ops.length) {
		ops.remove(0);
	}
}
/**
*@desc 初始化开始时间、结束时间的下拉选项
*/
function initTime() {
	var st = $id('startTime');
	var et = $id('endTime');
	if (!st || !et) {
		return;
	}
	
	clearOptions(st);
	clearOptions(et);
	
	var y = (new Date()).getFullYear();
	
	st.onchange = function () {
		clearOptions(et);
		
		var s = parseInt(st.value);
		var e = y+1;
		while (s < e) {
			createOp(s, et);
			s++;
		}
	}
	
	for (var i = -10; i < 1; i++) {
		createOp(y + i, st);
	}
	createOp(y, et);
	st.value = y;
	et.value = y;
	et.style.width = '100px';
	st.style.width = '100px';
}

