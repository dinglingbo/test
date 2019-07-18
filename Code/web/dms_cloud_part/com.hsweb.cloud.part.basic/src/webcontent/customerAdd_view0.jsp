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
<script src="<%=webPath + contextPath%>/basic/js/customerAdd.js?v=1.0.128"></script>
<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script> 
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
    width: 90px;
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

 <input class="nui-combobox" visible="false" id="managerDuty"/>
<div style="text-align: right;">
    <div id="isInternal" name="isInternal" visible="false" class="nui-checkbox" text="" onvaluechanged="onValueChanged" trueValue="1" falseValue="0"></div>
    <span>客户</span>
    <div id="isClient" name="isClient" class="nui-checkbox" text="" checked="true" enabled="false" trueValue="1" falseValue="0"></div>
    <span>供应商</span>
    <div id="isSupplier" name="isSupplier" class="nui-checkbox" text=""  enabled="true" trueValue="1" falseValue="0"></div>
    <span>是否禁用</span>
    <div id="isDisabled" name="isDisabled" class="nui-checkbox" text="" trueValue="1" falseValue="0"></div>
</div>
<div class="nui-fit">
<div id="tabs1" class="nui-tabs" activeIndex="0"  style="width:97%;height:100%;margin-left: 1.5%;"
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
                       <input id="tenantId" name="tenantId" width="100%" class="nui-hidden" >
                      <input id="guestType" name="guestType" width="100%" class="nui-hidden" >
                      <input id="modifier" name="modifier" width="100%" class="nui-hidden" >
                      <input id="modifyDate" name="modifyDate" width="100%" class="nui-hidden" >
                      <table class="tmargin">
                          <tr class="htr">
                              <td class=" right fwidtha required" style="display:none;">客户编码:</td>
                              <td  style="display:none;"><input id="code" name="code" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidtha required">客户属性:</td>
                              <td ><input id="guestProperty"
                                          allowInput="false" 
                              			  name="guestProperty" 
                              			  showNullItem="false"
                              			  onvaluechanged="onGuestPropertyChange"
                              			  class="nui-combobox" width="100%" 
                              			  textField="name"
                                          valueField="customid"
                              			  emptyText="请选择客户属性...">
                  			  </td>
                  			  <td class=" right fwidtha required">结算方式:</td>
                              <td >
                                  <input id="settTypeId"
                                 name="settTypeId"
                                 onvaluechanged="onSettTypeIdChange"
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
                          
                          <tr class="htr" style="display :none;" id="lince">
                          	  <td class=" right fwidthb required">上传营业执照:</td>
                      	      <td  colspan="" class="tabwidth" >
				                <div class="page-header" id="btn-uploader">
					                	<div class="div1" id="faker" >
								            <img id="xmTanImg" style="width: 80px;height: 80px" src="<%=contextPath%>/common/images/upload.png"/>
								        </div>
							        </div>
							        <input  class="nui-textbox" id="licenseUrl" name="licenseUrl"  style="display:none" >
							  </td>
							  <td class=" right fwidtha required">营业执照号:</td>
                              <td ><input id="licenseCode" name="licenseCode" width="100%" class="nui-textbox" ></td>
                            </tr>
                            <tr class="htr" style="display :none;" id="idNo">
                              <td class=" right fwidtha required" style="">上传身份证:</td>
                              <td  colspan="" class="tabwidth" >
				                <div class="page-header" id="idno-uploader">
					                	<div class="div1" id="up" >
								            <img id="idNoImg" style="width: 80px;height: 80px" src="<%=contextPath%>/common/images/upload.png"/>
								        </div>
							        </div>
							        <input  class="nui-textbox" id="idCardUrl" name="idCardUrl"  style="display:none" >
							  </td>
							  <td class=" right fwidtha required">身份证号:</td>
                              <td ><input id="idCard" name="idCard" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                          	  <td class=" right fwidthb required">客户简称:</td>
                              <td ><input id="shortName" name="shortName" width="100%" class="nui-textbox"  ></td>
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
                            
                          </tr>
                          </tr>                         
                          <tr class="htr" >
                          
                          	 <td class=" right fwidtha required">客户全称:</td>
                             <td colspan="4">
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
                              <td class=" right fwidthb required">联系人:</td>
                              <td ><input id="manager" name="manager" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidthb required">联系人手机:</td>
                              <td ><input id="mobile" name="mobile" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidtha required">省份:</td>
                              <td>
                                  <input id="provinceId" name="provinceId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onProvinceSelected('cityId')"
                                  url="" valueFromSelect="true" allowinput="true" width="100%"
                                  nullitemtext="选择省份..." emptytext="选择省份" shownullitem="true" ></td>
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
                              <td ><input id="contactorTel" name="contactorTel" width="100%" class="nui-textbox" ></td>
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
                              <td class=" right fwidtha">信誉额度:</td>
                              <td ><input id="creditLimit" name="creditLimit" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidthb">电话:</td>
                              <td colspan=""><input id="tel" name="tel" width="100%" class="nui-textbox" ></td>
                              <td class=" right fwidtha">QQ/微信:</td>
                              <td ><input id="instantMsg" name="instantMsg" width="100%" class="nui-textbox" ></td>
                          </tr>
                          <tr class="htr">
                              <td class=" right fwidtha">备注:</td>
                              <td >
                                  <input id="remark" name="remark" width="100%" class="nui-textbox" >
                              </td>
                              <td class=" right fwidtha">默认物流:</td>
                              <td >
                                  <input id="defaultLogistics" name="defaultLogistics" width="100%" class="nui-textbox" >
                              </td>
                          </tr>
                           <tr class="htr">
                              <td class=" right fwidtha"></td>
                              <td><input id="isNeedPack" name="isNeedPack" class="nui-checkbox" text="需要打包发货" onvaluechanged="onValueChanged" trueValue="1" falseValue="0"></td>
                          </tr>
                      </table>

                  </div>
              </div>

            </div>
        </div>
        <div name="tab2" title="其他信息">
            <div class="form" id= "otherForm">
              <div class="vpanel mainwidth" style="height:auto; ">
                  <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
                  <div class="vpanel_body vpanel_bodyww">

                      <table class="tmargin">
                          <tr class="htr">
                              <td class=" left fwidthb">财务信息</td>
                          </tr>
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
                              <td class=" right fwidthb">邮政编码:</td>
                              <td>
                                  <input id="postalCode" name="postalCode" width="100%" class="nui-textbox" >
                              </td>
                             
                          </tr>  
                          <tr class="htr" style="display :none;" id="otherPicture">
                              <td class=" right fwidthb">上传其他图片:</td>
                      	      <td  colspan="" class="tabwidth" >
				                <div class="page-header" id="other-uploader">
					                	<div class="div1" id="other" >
								            <img id="otherImg" style="width: 80px;height: 80px" src="<%=contextPath%>/common/images/upload.png"/>
								        </div>
							        </div>
							        <input  class="nui-textbox" id="otherPictueUrl" name="otherPictueUrl"  style="display:none" >
							  </td>
                          </tr>                     
                      </table>

                  </div>
              </div>

            </div>
        </div>
        <div name="tab3" title="收货地址">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" iconCls="" plain="true" onclick="newRow"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="editRow"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="delRow"><span class="fa fa-edit fa-lg"></span>&nbsp;删除</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit" id= "logisticsForm">

              <div class="vpanel mainwidth" style="height:auto;width:auto;">
                  
                  <div id="logisticsGrid" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
                       url=""  idField="id" multiSelect="true"
                       pageSize="20"
                       dataField="list"
                       onrowdblclick=""
                       sortMode="client"
                       showPager="false">
                      <div property="columns">
                          <div allowSort="true" field="receiveCompName" width="80" headerAlign="center">收货单位</div>
                          <div allowSort="true" field="receiveMan" width="40" headerAlign="center">收货人</div>
                          <div allowSort="true" field="receiveManTel" width="60" headerAlign="center">联系方式</div>
                          <div allowSort="true" field="address" width="120" headerAlign="center">收货地址</div>
                          <div type="checkboxcolumn" allowSort="true" field="isDefault" width="28" headerAlign="center" trueValue="1" falseValue="0">默认</div>
                      </div>
                  </div>

              </div>

            </div>
        </div>
         <div name="tab4" title="关联客户">
         	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                          	客户名称：<input id="guestName" name="guestName"class="nui-textbox"  >
                            <a class="nui-button" iconCls="" plain="true" onclick="searchGuest"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="selectGuest"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                        </td>
                    </tr>
                </table>
            </div>
             <div class="form" id= "guestConnectFrom">
              	<div class="vpanel mainwidth" style="height:auto;">
          			 <div id="guestGrid" class="nui-datagrid" allowResize="true" style="width:100%;height:40%;"
	                       url=""  idField="id" multiSelect="true"
	                       pageSize="20"
	                       dataField="customers"
	                       onrowdblclick=""
	                       sortMode="client"
	                       totalField="page.count"
	                       allowRowSelect="true"
	                       multiSelect="true"
	                       showPager="true">
	                      <div property="columns">
	                          <div allowSort="true" type="indexcolumn" headerAlign="center" width="30">序号</div> 
	                          <div type="checkcolumn" width="20"></div>
	                          <div allowSort="true" field="id" width="40" headerAlign="center" visible="false">主键</div>
	                          <div allowSort="true" field="shortName" width="70" headerAlign="center">客户简称</div>
	                          <div allowSort="true" field="fullName" width="120" headerAlign="center">客户全称</div>
	                          <div allowSort="true" field="recordDate" dateFormat="yyyy-MM-dd HH:mm" width="80" headerAlign="center">创建日期</div>
	                      </div>
	                  </div>
	                 <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
			                <table style="width:100%;">
			                    <tr>
			                        <td style="width:100%;">
			                        	<span>已选择的客户</span>
			                          	<a class="nui-button" iconCls="" plain="true" onclick="deleteRows"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
			                        </td>
			                    </tr>
			                </table>
			            </div>
	                  <div id="haveSelectGrid" class="nui-datagrid" allowResize="true" style="width:100%;height:40%;"
	                       url=""  idField="id" multiSelect="true"
	                       pageSize="20"
	                       dataField="data"
	                       onrowdblclick=""
	                       sortMode="client"
	                       totalField="page.count"
	                       allowRowSelect="true"
	                       multiSelect="true"
	                       allowUnselect="true"
	                       showPager="false">
	                      <div property="columns">
	                          <div allowSort="true" type="indexcolumn" headerAlign="center" width="30">序号</div> 
	                          <div type="checkcolumn" width="25"></div>
	                          <div allowSort="true" field="shortName" width="40" headerAlign="center">客户简称</div>
	                          <div allowSort="true" field="fullName" width="120" headerAlign="center">客户全称</div>
	                          <div allowSort="true" field="createDate" width="60" headerAlign="center">创建日期</div>
	                      </div>
	                   </div>
                  	
              	</div>
            </div>
		 </div>
</div>		
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


<div id="editLogisticsForm" style="display:none;padding:5px;position:relative;">
    <input class="mini-hidden" name="id"/>
    <table class="tmargin">
        <tr class="htr">
            <td class="right fwidthb required">收货单位:</td>
            <td colspan="3"><input id="receiveCompName" name="receiveCompName" width="100%" class="nui-textbox" ></td>
        </tr>
        <tr class="htr">
            <td class=" right fwidthb required">收货人:</td>
            <td ><input id="receiveMan" name="receiveMan" width="100%" class="nui-textbox" ></td>
            <td class=" right fwidthb required">联系方式:</td>
            <td ><input id="receiveManTel" name="receiveManTel" width="100%" class="nui-textbox" ></td>
        </tr>
        <tr class="htr">
            <td class=" right fwidthb required">省份:</td>
            <td>
                <input id="aprovinceId" name="provinceId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onProvinceChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择省份..." emptytext="选择省份" shownullitem="true">
            </td>
            <td class=" right fwidtha required">城市:</td>
            <td>
                <input id="acityId" name="cityId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onCityChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择市..." emptytext="选择市" shownullitem="true">
            </td>
        </tr>
        <tr class="htr">
            <td class=" right fwidthb">地区:</td>
            <td>
                <input id="acountyId" name="countyId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onCountyChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择乡/镇..." emptytext="选择乡/镇" shownullitem="true">
            </td>
            <td class=" right fwidthb required">街道:</td>
            <td>
                <input id="astreetAddress" onvaluechanged="onStreetChange" name="streetAddress" width="100%" class="nui-textbox" >
            </td>
        </tr>
        <tr class="htr">
            <td class=" right fwidthb">详细地址:</td>
            <td colspan="3">
              <input id="addressA" enabled="false" name="address" width="100%" class="nui-textbox" >
            </td>
        </tr>
        <tr class="htr">
            <td class=" right fwidthb">备注:</td>
            <td colspan="2"><input id="remark" name="remark" width="100%" class="nui-textbox" ></td>
            <td><input id="isDefault" name="isDefault" class="nui-checkbox" text="是否默认" onvaluechanged="onValueChanged" trueValue="1" falseValue="0"></td>
        </tr> 
        <tr class="htr">
            <td style="text-align:right;padding-top:5px;padding-right:20px;" colspan="4">
                <a class="nui-button" href="javascript:updateRow();">确定</a> 
                <a class="nui-button" href="javascript:cancelRow();">取消</a>
            </td>
        </tr>                    
    </table>
</div>

</body>
</html>
