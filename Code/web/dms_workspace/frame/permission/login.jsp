<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.primeton.bps.workspace.frame.common.LocaleUtil"%>
<%@page import="com.primeton.bps.workspace.frame.processserver.bl.IWSProcessServerManager"%>
<%@page import="com.primeton.bps.workspace.frame.common.WSContributionHelper"%>
<%@page import="java.util.List"%>
<%@page import="com.primeton.bps.workspace.frame.processserver.ProcessServer"%>
<%@page import="com.primeton.bps.workspace.frame.common.LanguageInfo"%>
<%@include file="/frame/common/common.jsp"%>
<%
String contextPath = request.getContextPath();
List<ProcessServer> pss = IWSProcessServerManager.INSTANCE.getAllProcessServer();
request.setAttribute("pss", pss);
Map<String, Boolean> servers = ProcessServerHelper.getMultiServerMap(pss);
String json = JsonUtils.getJson(servers);
//在这里改写的，读localeUtil.xml配置文件
String language=LocaleUtil.getLocaleStr();
if(language==null||language.equals("")){
	language=request.getLocale().toString();
}
//设置默认语言为英语
boolean flag = true;
List<LanguageInfo> localesinfo = LocaleUtil.getSelectLocales(language);
for (LanguageInfo info : localesinfo) {
	if(language.equals(info.getValue())){
		flag = false;
		break;
	}
}
if (flag) language = "en_US";

String serverId = "";
if (pss.size() == 1) {
	ProcessServer ps = (ProcessServer) pss.get(0);
	serverId = ps.getId();
}

boolean hasBizComposer = WSContributionHelper.existContribution(WSContributionHelper.NAME_BIZRESOURCE);
request.setAttribute("hasBizComposer", Boolean.valueOf(hasBizComposer));

boolean isEmbeddedServer = WSContributionHelper.isEmbeddedServer();
request.setAttribute("isEmbeddedServer", Boolean.valueOf(isEmbeddedServer));
%>

<%@page import="com.primeton.bps.workspace.frame.processserver.ProcessServerHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.primeton.bps.workspace.frame.processserver.JsonUtils"%>
<html>
<head>
<title><b:message key="login_jsp.title1"/></title>
<script type="text/javascript">
var serverMap = eval("("+"<%=json %>"+")");

if(top!=window){
	top.location = window.location;
}

window.onload=function () {
	isMultiTenant();	
	document.getElementById("userName").focus();

	initFrame();
	setTipPosition();
	//setDefaultServer();
	setDefaultLanguage();
}

window.onresize = function() {
	setTipPosition();
}

function checklastopr(){
	document.getElementById("msg").innerHTML="&nbsp;";
}

var time = 100;
function fadeInTip(no){
	fx_fadeIn('tip'+no,'',time);
}

function fadeOutTip(no){
	fx_fadeOut('tip'+no,'',time);
}

function helpFadeInTip(no){
	if(no=="12"){
		if($id("userType").value=="1"){
			fadeInTip("12");
		}
		else if($id("userType").value=="2"){
			fadeInTip("13");
		}
	}
	else{
		fadeInTip(no);
	}
}

function helpFadeOutTip(no){
	if(no=="12"){
		if($id("userType").value=="1"){
			fadeOutTip("12");
		}
		else if($id("userType").value=="2"){
			fadeOutTip("13");
		}
	}
	else{
		fadeOutTip(no);
	}
}

function openUserDesc() {
	window.open("<%=contextPath%>/frame/permission/user_desc/"+"<b:message key='login_jsp.desc'/>");
}

</script>
<style>

*{margin:0;padding:0;}
body {font: 12px Arial, sans-serif;color: #333;}
a {text-decoration:none;}
a:hover {text-decoration: underline;}
li {list-style:none;}
/* 以下是图片+CSS圆角 */
.f_top,
.f_end {clear: both;height: 5px;overflow: hidden;background: url(<%=contextPath%>/images/fillet_bg.gif) right top;}
.f_end {background-position: right -5px;}
.f_t_l,
.f_e_l {width: 5px;height: 5px;overflow: hidden;background: url(<%=contextPath%>/images/fillet_bg.gif) left top;}
.f_e_l {background-position: left -5px;}
.box {border-right: 1px solid #ccc;border-left: 1px solid #ccc;}
/* 以上是图片+CSS圆角 */
.box h2 {height: 30px;font: bold 11px/30px Arial, sans-serif;margin: 0 10px;border-bottom: 1px dotted #ccc;}
.box h2 span {float: left;}
.box h2 a {font: 10px/30px Arial, sans-serif;float: right;color: #666;}
.box_inside {padding: 10px;line-height: 1.5em;}
.box_inside a {color: #666;}
li {}

#tip1,
#tip2,
#tip3,
#tip4,
#tip11,
#tip12,
#tip13,
#tip14,
#tip1 {width: 250px;background: #e5f1ff;}
#tip2 {width: 250px;background: #e5f1ff;}
#tip3 {width: 250px;background: #e5f1ff;}
#tip4 {width: 250px;background: #e5f1ff;}
#tip11 {width: 200px;background: #e5f1ff;}
#tip12 {width: 200px;background: #e5f1ff;}
#tip13 {width: 200px;background: #e5f1ff;}
#tip14 {width: 200px;background: #e5f1ff;}

/* 以下为纯CSS圆角 */
.divBox {padding: 10px;border-right: 1px solid #aaa;border-left: 1px solid #aaa; }
b, u, i {display: block;height: 1px;overflow: hidden;}
/* 第一种圆角 */
b.f1 {margin: 0 4px;background: #aaa;}
b.f2 {margin: 0 2px;border-right: 2px solid #aaa;border-left: 2px solid #aaa;}
b.f3 {height: 2px;margin: 0 1px;border-right: 1px solid #aaa;border-left: 1px solid #aaa;}
/* 第一种圆角结束 */

div.demoElement {
	width: 150px;
	height: 50px;
	border: 1px solid black;
	background-color: #f9f9f9;
	font-size: 12px;
	color: #000000;
	padding: 10px;
}

.tab1_bg {
	background:url(<%=contextPath%>/images/login_tab1.jpg) no-repeat;
}

.tab2_bg {
	background:url(<%=contextPath%>/images/login_tab2.jpg) no-repeat;
}
.gray{
	color:#f0f0f0;
}
</style>
<link rel="shortcut icon" href="<%=contextPath%>/favicon.ico" type="image/x-icon">
</head>

<body style="margin:0px;overflow:hidden;background-color:#e5f1ff;" >

<div style="position:absolute;width:100%;height:1017px;overflow:visible;">
	<div style="margin:0px;padding:0px;width:100%;height:51px;background:url(<%=contextPath%>/images/Bar_bg.jpg)">
		<div style="margin:0px;padding:0px;width:968px;height:51px;background:url(<%=contextPath%>/images/Bar.jpg)"></div>
	</div>

	<form id="loginForm" method="post" action="com.primeton.bps.workspace.frame.permission.Login.flow"	
		onsubmit="return login(this);" onkeydown="enter_submit()">	
	<h:hidden id="userType" property="userType" />
	<h:hidden name="_eosFlowAction"/>
	
	<div style="position:absolute;left:50%;top:51px;margin-left:-512px;margin-top:0px;width:1024px;height:941px;background:url(<%=contextPath%>/images/login_bg3.jpg)">

		<div style="text-align:center;border:0px red solid; width:450px; height:310px; margin-left:316px; margin-top:120px;">
			<table align="center" border="0" style="width:100%; height=100px;">
				<tr height="100px">
					<td style="width:81px;"></td>
					<td style="width:81px;"><img id="icon1" width="81px" height="78px"
						style="margin:10px;margin-top:20px;display:block;vertical-align:top"
						src="<%=contextPath%>/images/icon1.jpg" 
						onmouseover="fadeInTip(1);" onmouseout="fadeOutTip(1);"></td>
					<td style="width:81px;"><img id="icon2" width="80px" height="78px"
						style="margin:10px;margin-top:20px;display:block;vertical-align:top"
						src="<%=contextPath%>/images/icon2.jpg"
						onmouseover="fadeInTip(2);" onmouseout="fadeOutTip(2);"></td>
					<%if(hasBizComposer) {%>
					<td style="width:81px;"><img id="icon3" width="79px" height="78px"
						style="margin:10px;margin-top:20px;display:block;vertical-align:top"
						src="<%=contextPath%>/images/icon3.jpg"
						onmouseover="fadeInTip(3);" onmouseout="fadeOutTip(3);"></td>
					<%} else {%>
					<td style="width:81px;"><img id="icon3" width="79px" height="78px"
						style="margin:10px;margin-top:20px;display:block;vertical-align:top"
						src="<%=contextPath%>/images/icon3_gray.jpg"
						onmouseover="fadeInTip(3);" onmouseout="fadeOutTip(3);"></td>
					<%}%>
					<%if(isEmbeddedServer) {%>
					<td style="width:81px;"><img id="icon4" width="80px" height="78px"
						style="margin:10px;margin-top:20px;display:block;vertical-align:top"
						src="<%=contextPath%>/images/icon4.jpg"
						onmouseover="fadeInTip(4);" onmouseout="fadeOutTip(4);"></td>
					<%}%>
					<td style="width:81px;"></td>
				</tr>
			</table>

			<div id="main_tabpanel" class="tab1_bg">
			<table align="center" border="0" width="100%" height="170px">
				<tr id="main_tab1">
					<td align=right style="padding-top:3px;padding-left:45px"><b:message key="login_jsp.server"/>&nbsp;&nbsp;</td>
					<td style="padding-top:3px;">
						<h:select id="clientId" property="clientId" style="width:170px" onchange="changeTip(this);isMultiTenant();">
							<option title="<b:message key="login_jsp.pleaseSelectDescription"/>" value=""><b:message key="login_jsp.pleaseSelect"/></option>
							<l:iterate id="ps" property="pss">
								<h:option labelField="name" iterateId="ps" valueField="id" />
							</l:iterate>
						</h:select>
						<img id="help1" width="16px" height="16px" style="position:absolute;"
						src="<%=contextPath%>/images/help.gif"
						onmouseover="helpFadeInTip(11);" onmouseout="helpFadeOutTip(11);">
					</td>
					<td width="5px" align="left"></td>
				</tr>
				<tr id="main_lan">
					<td align=right style="padding-left:45px"><b:message key="login_jsp.language"/>&nbsp;&nbsp;</td>
					<td>
						<h:select id="language" property="language" style="width:170px" onchange="changeLanguage();">
							<%
							for (LanguageInfo info : localesinfo) {
	                            if(language.equals(info.getValue())){
	                              out.println("<option selected value="+"'"+info.getValue()+"'"+">"+info.getName()+"</option>");
	                            }else{
	                              out.println("<option value="+"'"+info.getValue()+"'"+">"+info.getName()+"</option>");
	                            }
							} %>
						</h:select>
					<td width="5px" align="left"></td>
				</tr>	
				<tr id="main_tab2" >
					<td id="main_lab2" align=right style="padding-left:45px"><b:message key="login_jsp.organizationName"/>&nbsp;&nbsp;</td>
					<td>
					<h:text  id="organizationName" property="organizationName" 
						style="width:170px" onchange="checklastopr();checkInput(this);"/>
						<img id="help3" width="16px" height="16px" style="position:absolute;"
						src="<%=contextPath%>/images/help.gif"
						onmouseover="helpFadeInTip(14);" onmouseout="helpFadeOutTip(14);" />
					</td>
					<td width="5px" align="left">
					</td>
				</tr>
				<tr>
					<td align=right style="padding-left:35px"><b:message key="login_jsp.userName"/>&nbsp;&nbsp;</td>
					<td><h:text  id="userName" property="userName"
						style="width:170px" onchange="checklastopr();checkInput(this);"
						validateAttr="allowNull=false;maxLength=20;minLength=1" />
						<img id="help2" width="16px" height="16px" style="position:absolute;cursor: pointer;"
						src="<%=contextPath%>/images/help.gif"
						onmouseover="helpFadeInTip(12);" onmouseout="helpFadeOutTip(12);" onclick="openUserDesc();">
					</td>
					<td width="5px" align="left">
						</td>
				</tr>
				<tr>
					<td align=right style="padding-left:45px"><b:message key="login_jsp.password"/>&nbsp;&nbsp;</td>
					<td><h:password property="password"
						style="width:170px" onchange="checklastopr();checkInput(this);"
						validateAttr="allowNull=true;maxLength=20;minLength=1" filter="true" /></td>
					<td width="5px" align="left"></td>
				</tr>
				<tr>
					<td colspan="3" align="center" style="margin:0px;margin-top:5px;vertical-align:top">
						<input type="submit" value='<b:message key="login_jsp.btnLogin"/>' class="button" />
						<input type="reset"	value='<b:message key="login_jsp.btnReset"/>' class="button" />
					</td>
				</tr>
			</table>
			</div>
			<div id="tab_btn_1" onclick="changeTab(1);return false;">
				&nbsp;<b:message key="login_jsp.tabComposer"/>&nbsp;
			</div>
			<div id="tab_btn_2" onclick="changeTab(2);return false;">
				&nbsp;<b:message key="login_jsp.tabConfig"/>&nbsp;
			</div>
			<div id="tab_btn_3">
			</div>
		</div>
					
		<div style="text-align:center;">
			<span id="msg" class="warn_msg_area">&nbsp;</span>

			<script type="text/javascript">
				if('<b:write property="result"/>' < 0) {
					document.getElementById("msg").innerHTML='<b:message key="login_jsp.loginError"/>';
				}
				if('<b:write property="result"/>' == 2) {
					document.getElementById("msg").innerHTML='<b:message key="login_jsp.loginError2"/>';
				}
				if('<b:write property="result"/>' == -3) {
					document.getElementById("msg").innerHTML='<b:message key="login_jsp.loginError3"/>';
				}
				if('<b:write property="result"/>' == -4) {
					document.getElementById("msg").innerHTML='<b:message key="login_jsp.loginError4"/>';
				}
			</script>
		</div>
	</div>
	</form>

	<div style="position:relative;top:941px;width:100%;height:25px;padding-top:0px;vertical-align:bottom;background:url(<%=contextPath%>/images/bottom_bg.gif)">
		<div style="position:relative;text-align:center;top:5px;">(c) Copyright Primeton 2011. All Rights Reserved.<div>
	</div>
	
</div>

<div id="tip1" style="display:none;position:absolute;top:-900px;left:360px;width:250px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip1"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip2" style="display:none;position:absolute;top:-900px;left:465px;width:250px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip2"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip3" style="display:none;position:absolute;top:-900px;left:570px;width:250px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip3"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip4" style="display:none;position:absolute;top:-900px;left:675px;width:250px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip4"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip11" style="display:none;position:absolute;top:-700px;left:780px;width:200px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip11"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip12" style="display:none;position:absolute;top:-650px;left:780px;width:200px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip12"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip13" style="display:none;position:absolute;top:-650px;left:780px;width:200px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip13"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>
<div id="tip14" style="display:none;position:absolute;top:-650px;left:780px;width:200px;">
  <b class="f1"></b><b class="f2"></b><b class="f3"></b>
  <div class="divBox"><b:message key="login_jsp.tip14"/></div>
  <b class="f3"></b><b class="f2"></b><b class="f1"></b>
</div>

<script>

function initFrame() {
	var isIE = navigator.userAgent.toLowerCase().indexOf("msie") != -1;
	var main_tabpanel = $id("main_tabpanel");
	var tab_btn_1 = $id("tab_btn_1");
	//var tab_btn_2 = document.getElementById("tab_btn_2");
	if(isIE&&!isIE10){
		main_tabpanel.style.position = "relative";
		main_tabpanel.style.left = "0px";
		main_tabpanel.style.top = "3px";
		main_tabpanel.style.width = "392px";
		main_tabpanel.style.height = "188px";
	
		tab_btn_1.style.position = "relative";
		tab_btn_1.style.textAlign = "left";
		tab_btn_1.style.cursor = "pointer";
		tab_btn_1.style.left = "55px";
		tab_btn_1.style.top = "-18px";
	
		tab_btn_2.style.position = "relative";
		tab_btn_2.style.textAlign = "left";
		tab_btn_2.style.cursor = "pointer";
		tab_btn_2.style.left = "170px";
		tab_btn_2.style.top = "-34px";
	
		tab_btn_3.style.position = "relative";
		tab_btn_3.style.textAlign = "left";
		tab_btn_3.style.left = "260px";
		tab_btn_3.style.top = "-60px";
	//	alert("IE");
	}
	else{
		main_tabpanel.style.position = "relative";
		main_tabpanel.style.left = "30px";
		main_tabpanel.style.top = "3px";
		main_tabpanel.style.width = "392px";
		main_tabpanel.style.height = "188px";
	
		tab_btn_1.style.position = "relative";
		tab_btn_1.style.textAlign = "left";
		tab_btn_1.style.cursor = "pointer";
		tab_btn_1.style.left = "55px";
		tab_btn_1.style.top = "-18px";
	
		tab_btn_2.style.position = "relative";
		tab_btn_2.style.textAlign = "left";
		tab_btn_2.style.cursor = "pointer";
		tab_btn_2.style.left = "170px";
		tab_btn_2.style.top = "-34px";
	
		tab_btn_3.style.position = "relative";
		tab_btn_3.style.textAlign = "left";
		tab_btn_3.style.left = "260px";
		tab_btn_3.style.top = "-52px";
	//	alert("Firefox");
	}
}

function setTipPosition() {
	var help1 = $id("help1");
	var help2 = $id("help2");
	var help3 = $id("help3");
	var tip11 = $id("tip11");
	var tip12 = $id("tip12");
	var tip13 = $id("tip13");
	var tip14 = $id("tip14");
	var bodyWidth = document.body.clientWidth;      //网页可见区域宽
	var offsetWidth = (bodyWidth - 1280) / 2;
	var offsetLeft1 = help1.offsetLeft - 300;
	var offsetLeft2 = help2.offsetLeft - 300;
	var offsetLeft3 = help3.offsetLeft - 300;
	tip11.style.left = 800 + offsetWidth + offsetLeft1 + "px";
	tip12.style.left = 800 + offsetWidth + offsetLeft2 + "px";
	tip13.style.left = 800 + offsetWidth + offsetLeft2 + "px";
	tip14.style.left = 800 + offsetWidth + offsetLeft3 + "px";
}

function setDefaultServer() {
	var clientNum = <%=pss.size()%>;
	if (clientNum==1){
		var select_clientId = $id("clientId");
		select_clientId.value = "<%=serverId%>";
	}
}

function setDefaultLanguage() {
	var select_language = $id("language");
	var locale = "<%=language%>";
	if (locale == "") {
			var language = navigator.language || navigator.userLanguage;
			language = language.toLowerCase();
			//alert(language);
			if (language) {
				if (language == "zh-cn") {
					select_language.value = "zh_CN";
				}
				else if (language == "en-us") {
					select_language.value = "en_US";
				}
				else if (language == "ja-jp") {
					select_language.value = "ja_JP";
				}
				else {
					select_language.value = "en_US";
				}
			}
	} else {
		select_language.value = locale;
	}
	//select_language.style.visibility="hidden";
}
function isMultiTenant(){
	var tab2 = $id("main_tab2");
	var lab2 = $id("main_lab2");
	if($id("clientId").value!=''){
		//var myAjax = new Ajax("com.primeton.bps.workspace.frame.common.EngineTenantModeMgr.queryEngineMode.biz");
		//myAjax.addParam("clientID", $id("clientId").value);
		//myAjax.submit();
		//var result = myAjax.getValue("root/data/isMultiTenant");
		var result = serverMap[$id("clientId").value];
		if(result=="false"){
			tab2.disabled=true;
			$id("organizationName").disabled=true;
			lab2.className = "gray";
		}else{
			$id("organizationName").disabled=false; 
			tab2.disabled=false;
			lab2.className = "";
		}
	}else{
		tab2.disabled=false;
		$id("organizationName").disabled=false;
		lab2.className = "";
	}
}


function changeLanguage() {
	var frm = $id("loginForm");
	$name("_eosFlowAction").value = "changeLanguage";
	frm.submit();
}

function enter_submit(eventobject) {
	if(window.event && window.event.keyCode==13) {
		loginWorkspace();
	}
}

function loginWorkspace() {
	var frm = $id("loginForm");
	$name("_eosFlowAction").value = "login";
	if(login(frm)) {
		frm.submit();
	}
}

var userType = $id("userType").value;
if (userType == 0)
	changeTab(1);
else
	changeTab(userType);

function changeTab(no){
	var tab=document.getElementById('main_tab1');
	var tab2=document.getElementById('main_tab2');
	var lan=document.getElementById('main_lan');
	window['TrLan'] = window['TrLan'] || lan;
	if(no==1){
		tab.style.visibility="visible";
		tab2.style.visibility="visible";
		changeTableCloseTr(tab2.parentNode, tab2, lan);
		$id("organizationName").disabled=false;
		$id("userType").value = "1";
		//恢复语言；修补IE特有的bug
		backLanguage();
		isMultiTenant();
	}else{
		//保存语言；修补IE特有的bug
		storeLanguage();
		tab.style.visibility="hidden";
		tab2.style.visibility="hidden";
		changeTableCloseTr(tab2.parentNode, lan, tab2);
		$id("organizationName").disabled=true;
		$id("userType").value = "2";
	}
	
	var main_tabpanel=document.getElementById('main_tabpanel');
	main_tabpanel.className="tab"+no+"_bg";
}

function login(obj){
	if($id("userType").value=="1"){
		if($id("clientId").value==""){
			f_alert($id("clientId"), '<b:message key="login_jsp.pleaseSelectDescription"/>');
			return false;
		}else if($id("organizationName").value==""&&$id("organizationName").disabled==false){
			f_alert($id("organizationName"), '<b:message key="login_jsp.formustfill"/>');
			return false;
		}
		return checkForm(obj);
	}
	else if($id("userType").value=="2"){
		return checkForm(obj);
	}
}

function storeLanguage(){
	var select_language = $id("language");
	window['language_selected'] = select_language.value;
}

function backLanguage(){
	var select_language = $id("language");
	var value = window['language_selected'];
	if(value){
		select_language.value = value;
	}
}

function changeTip(list){
	list.title = list.options[list.selectedIndex].title;
}

function changeTableCloseTr(table, topTr, buttonTr){
	var cloneNode = buttonTr.cloneNode(true);
	table.insertBefore(cloneNode, topTr);
	table.removeChild(buttonTr);
}

</script>
</body>
</html>
