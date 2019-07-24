<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>供应商资料</title>
<script src="<%=webPath + contextPath%>/basic/js/supplierDetail.js?v=1.1.9"></script>
<style type="text/css">
.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
}
.left{
    text-align: left;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 90px;
}
.fwidthb{
    width: 120px;
}
.htr{
    height: 20px;
}
.mainwidth{
    width: 500px;
}
.tmargin{
    margin-top: 10px;
    margin-bottom: 10px;
}

.vpanel{
    border:0px solid #d9dee9;
    margin:0px 0px 0px 0px;
    height:248px;
    float:left;
}
.vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
}
.vpanel_heading span{
    margin:0 0 0 20px;
    font-size:8px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}

.required {
    color: red;
}

</style>
</head>
<body>

<div style="text-align: right;">
		     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
    <div id="isInternal" class="nui-checkbox" name="isInternal" visible="false"  text="" onvaluechanged="" trueValue="1" falseValue="0"></div>
    <span>客户</span>
    <div id="isClient" name="isClient" class="nui-checkbox" text="" enabled="true" trueValue="1" falseValue="0"></div>
    <span>供应商</span>
    <div id="isSupplier" name="isSupplier" class="nui-checkbox" text="" checked="true" enabled="false" trueValue="1" falseValue="0"></div>
    <span>是否禁用</span>
    <div id="isDisabled" name="isDisabled" class="nui-checkbox" text="" trueValue="1" falseValue="0"></div>
</div>
<!-- <div class="nui-fit"> -->
<div id="tabs1" class="nui-tabs" activeIndex="0"  style="width:97%;height:87%;margin-left: 1.5%;"
         arrowPosition="side" showNavMenu="true">
        <div name="tab1" title="基本信息">
            <div class="form" id= "mainForm">
              <div class="vpanel mainwidth" style="height:auto;">
                  <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
                  <div class="vpanel_body vpanel_bodyww">
                      <input id="id" name="id" width="100%" class="nui-hidden" >
                      <input id="orgid" name="orgid" width="100%" class="nui-hidden" ><!-- 
                      <input id="recordDate" name="recordDate" width="100%" class="nui-hidden" >
                      <input id="recorder" name="recorder" width="100%" class="nui-hidden" > -->
                      <input id="modifier" name="modifier" width="100%" class="nui-hidden" >
                      <input id="modifyDate" name="modifyDate" width="100%" class="nui-hidden" >
                      <table class="tmargin">
                          <tr class="htr">
                              <td class=" right fwidtha required">供应商编码:</td>
                              <td ><input id="code" name="code" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidthb required">供应商简称:</td>
                              <td ><input id="shortName" name="shortName" width="100%" class="nui-textbox" maxLength="50" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidtha required">供应商全称:</td>
                              <td colspan="3">
                                  <input name="fullName"
                                 id="fullName"
                                 class="nui-textbox" width="100%"/>
                                  <input name="fullName1" class="nui-buttonedit width3" width="100%"
                                         id="fullName1"
                                         emptyText="请选择公司..."
                                         allowInput="false"
                                         onbuttonclick="selectOrg('fullName1','code')" selectOnFocus="true"
                                         visible="false"/>
                              </td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb required">票据类型:</td>
                              <td >
                                  <input id="billTypeId"
                                 name="billTypeId"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 width="100%"
                                 allowInput="true"
                                 showNullItem="false"
                                 nullItemText="请选择..."/>
                              </td>
                              <td class=" right fwidtha required">结算方式:</td>
                              <td >
                                  <input id="settTypeId"
                                 name="settTypeId"
                                 class="nui-combobox width2"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 width="100%"
                                 allowInput="true"
                                 showNullItem="false"
                                 nullItemText="请选择..."/>
                              </td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb required">联系人:</td>
                              <td ><input id="manager" name="manager" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidthb required">选择手机/固定电话:</td>
                              <td ><input id="mobile" name="mobile" width="100%" vtype="int" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidtha required">省份:</td>
                              <td>
                                  <input id="provinceId" name="provinceId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onProvinceSelected('cityId')"
                                  url="" valueFromSelect="true" allowinput="true" width="100%"
                                  nullitemtext="选择省份..." emptytext="选择省份" shownullitem="true"></td>
                              <td class=" right fwidthb required">城市:</td>
                              <td>
                                  <input id="cityId" name="cityId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onCitySelected('cityId')"
                                  url="" valueFromSelect="true" allowinput="true" width="100%"
                                  nullitemtext="选择市..." emptytext="选择市" shownullitem="true">
                              </td>
                          </tr>
                          <tr class="htr">
                          	  <td class=" right fwidtha">地址:</td>
                              <td colspan="3"><input id="addr" name="addr" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">业务员:</td>
                              <td ><input id="contactor" name="contactor" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidtha">业务员手机:</td>
                              <td ><input id="contactorTel" name="contactorTel" width="100%" class="nui-textbox" vtype="int" ></td>
                          </tr>
                         
                          <tr class="htr">
                              
                              <td class=" right fwidtha">职务:</td>
                              <td >
                                  <input id="managerDuty"
                                 name="managerDuty"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 width="100%"
                                 allowInput="true"
                                 showNullItem="true"
                                 nullItemText="请选择..."/>
                              </td>
                              <td class=" right fwidthb">邮政编码:</td>
                              <td>
                                  <input id="postalCode" name="postalCode" width="100%" class="nui-textbox" vtype="rangeChar:6,6" >
                              </td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">供应类型:</td>
                              <td >
                                  <input id="supplierType"
                                 name="supplierType"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 width="100%"
                                 allowInput="true"
                                 showNullItem="true"
                                 nullItemText="请选择..."/>
                              </td>
                              <td class=" right fwidtha">优势品牌/产品:</td>
                              <td ><input id="advantageCarbrandId" name="advantageCarbrandId" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">信用等级:</td>
                              <td >
                                 <input id="tgrade"
                                 name="tgrade"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 width="100%"
                                 allowInput="true"
                                 showNullItem="true"
                                 nullItemText="请选择..."/>
                              </td>                         
                              <td class=" right fwidthb">电话:</td>
                              <td colspan=""><input id="tel" name="tel" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">邮箱:</td>
                              <td ><input id="email" name="email" width="100%" class="nui-textbox" vtype="email"></td>
                              <td class=" right fwidtha">QQ/微信:</td>
                              <td ><input id="instantMsg" name="instantMsg" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidtha">备注:</td>
                              <td colspan="3">
                                  <input id="remark" name="remark" width="100%" class="nui-textbox" >
                              </td>
                          </tr>
                      </table>

                  </div>
              </div>

            </div>
        </div>
        <div name="tab2" title="其他信息">
            <div class="form" id= "otherForm">
              <div class="vpanel mainwidth" style="height:auto;">
                  <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
                  <div class="vpanel_body vpanel_bodyww">

                      <table class="tmargin">

                          <tr class="htr">
                              <td class=" right fwidthb">银行帐号:</td>
                              <td colspan="3"><input id="accountBankNo" name="accountBankNo" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">开户银行:</td>
                              <td colspan="3"><input id="accountBank" name="accountBank" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">纳税人编码:</td>
                              <td ><input id="taxpayerCode" name="taxpayerCode" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidtha">纳税人电话:</td>
                              <td ><input id="taxpayerTel" name="taxpayerTel" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">纳税人名称:</td>
                              <td colspan="3"><input id="taxpayerName" name="taxpayerName" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" left fwidthb">其他信息</td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">网址:</td>
                              <td colspan="3"><input id="website" name="website" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">传真:</td>
                              <td colspan="3"><input id="fax" name="fax" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">经营地址:</td>
                              <td colspan="3"><input id="manageAddr" name="manageAddr" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">会员卡号:</td>
                              <td colspan="3"><input id="memCarNo" name="memCarNo" width="100%" class="nui-textbox" ></td>
                          </tr>     
                          <tr class="htr">
                              <td class=" right fwidthb">会员等级:</td>
                              <td ><input id="memLevel" name="memLevel" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidtha">信誉额度:</td>
                              <td ><input id="creditLimit" name="creditLimit" width="100%" class="nui-textbox" ></td>
                          </tr>                     
                      </table>

                  </div>
              </div>

            </div>
        </div>
</div>
<!-- </div> -->

</body>
</html>
