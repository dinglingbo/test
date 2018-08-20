<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>零零汽注册</title>


<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/eos/css/register.css"
	rel="stylesheet" type="text/css" />
<script src="<%=webPath + contextPath%>/eos/js/register.js?v=1.0"
	type="text/javascript"></script>
</head>
<body>
	<div style="width: 100%; height: 7%; border-bottom:1px solid black; box-shadow: 0px 0px 2px 0px rgba(0, 0, 0, 0.12), 0px 2px 2px 0px rgba(0, 0, 0, 0.24);"> 

	<span style=" float: right; margin-right: 85%; margin-top: 1%;">注册配思账号</span>
	<span style="float: right; margin-right: 3%; margin-top: -1.7%; ">我已注册现在就   <a href="https://007vin.com/">登入</a> </span>
	</div>
	<div style="width: 100%; height: 30%;" id="form1">
		<form style="margin-left: 36%; margin-top: 10%;margin-top: 3%;">
			<table style="border-spacing:0px 20px;">
				<tr>
					<td>
						<div class="nui-textbox width2"  id="phone" name="phone"  emptyText="手机号码" vtype="rangeLength:11,11;float" ></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="width2">
						<input type="text" id="msgCode" name="msgCode"  style="border:none; width: 65%; height: 100%;" placeholder="验证码" maxlength="6"><a href="javascript:sendMsg();" name="msgButton" id="msgButton" style="color: blue;  cursor: pointer; ">点击发送验证码</a>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nui-textbox width2" name="userName" emptyText="用户姓名" ></div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="nui-textbox width2" name="orgId" emptyText="公司名称"></div>
					</td>
				</tr>
				<tr>
					<td>
						<input  property="editor" enabled="true" id="ProvinceList" name="ProvinceList" data="list"  class="nui-combobox width2" valueField="code" onvaluechanged="onProvinceChange" textField="name" url="" emptyText="请选择省份"  vtype="required"/>
					</td>
				</tr>
				<tr>
					<td>
						<input  property="editor" enabled="true" id="RegionList" name="RegionList" data="list"  class="nui-combobox width2" valueField="code" textField="name" url="" emptyText="请选择区域"  vtype="required"/>
					</td>
				</tr>
				<tr>
				<td><div class="nui-checkbox"></div>我已阅读并同意   <a href="javascript:agree();">《配思TM云平台用户注册协议》</a> </td>
				</tr>
				<tr>
				<td>
				<div class="nui-button style1" onclick="submit()"  style="cursor: pointer;"><span style="margin-top: 20px; ">注册</span></div>
				</td>
				</tr>
				<tr><td align="right">
					已有账号， <a href="https://007vin.com/">立即登录</a>
				</td></tr>
			</table>
		</form>
	</div>	
	<div>
	<center>
	<img alt="" src="<%=webPath + contextPath%>/eos/img/img_logo2.png" style="height:300px;width: 250px; margin-top: 20%;">
	</center>
	</div>
	<div style="background-color:#3F424D; height: 7%; width: 100%;">
	<a href="http://www.peipeiyun.com/" style="color: white; text-decoration: none; cursor: pointer;    padding-left: 10px; ">关于我们</a>
	<a href="#" style="color: white; text-decoration: none; cursor: pointer;     padding-left: 20px;">用户协议</a>
	<br>
	<span  style="color: white;   padding-left: 10px;">© 2016-2017 XXXX.com</span>
	<a href="http://www.miitbeian.gov.cn/state/outPortal/loginPortal.action;jsessionid=kCCX4iL1IiTGxiGcbJBlvE_mgo1IX7wko34RKj_7FBgKwVYB6HJT!1316315234" style="color: white; text-decoration: none; cursor: pointer;">版权所有 ICP证：XXXXXXXX</a>
	</div>
	
</body>
<script type="text/javascript">
function agreement(){
		 nui.open({
             url: "agreementPage.jsp",
             title: "", width: 600, height: 400,
             onload: function () {
                 var iframe = this.getIFrameEl();
                 var param = { action: "edit", data: s };
                 iframe.contentWindow.SetData(param);
             },
             ondestroy: function (action) {
                 //var iframe = this.getIFrameEl();

            	 dgGrid.reload();

             }
         });

}
function agree(){
	nui.parse();
		function isalter(){
		if($("#agree").is(":hidden"))
			$("#agree").show();
		else
			$("#agree").hide();
		}

}

</script>
</html>