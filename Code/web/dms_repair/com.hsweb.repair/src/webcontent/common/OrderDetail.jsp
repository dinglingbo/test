<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-19 10:18:19
  - Description:
-->
<head>
<title>工单详情页</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%--     <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script> --%>
    
</head>
<body>
	<div class="nui-fit"> 
		<div class="billForm" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
	            <input class="mini-hidden" id="empid" name="empid" />
	            <fieldset id="fd1" style="width:900px;">
	            	
	                <legend><span>工单信息</span></legend>
	                <table >
		                <input name="id" class="nui-hidden"/>
		                <input name="guestId" class="nui-hidden"/>
		                <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
		                <input class="nui-hidden" name="contactorId"/>
		                <input class="nui-hidden" name="carId"/>
		                <input class="nui-hidden" name="status"/>
		                <input class="nui-hidden" name="carVin"/>
		                <input class="nui-hidden" name="drawOutReport"/>
		                <input class="nui-hidden" name="contactorName"/>
		                <input class="nui-hidden" name="carModel"/>
		                <input class="nui-hidden" name="identity"/>
		                <input class="nui-hidden" name="billTypeId"/>
		                <input class="nui-hidden" name="status"/>
		                <input class="nui-hidden" name="isSettle"/>
		                <input class="nui-hidden" name="isOutBill"/>
	                    <tr>
	                        <td align="right">车牌号:</td>
	                        <td><input class="nui-textbox" required="false" id="carNo" name="carNo" enabled="false"/></td>
	                        <td align="right">品牌/车型：</td>
	                        <td><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
	                        <td align="right">业务类型：</td>
	                        <td> <input name="serviceTypeId"
                                   id="serviceTypeId"
                                   class="nui-combobox width1"
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100%"
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                             </td>
	                    </tr>
	
	                    <tr>
	                        <td align="right">服务顾问</td>
	                        <td><input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100%"
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                              </td>
	                        <td align="right">进厂油量：</td>
	                        <td>
	                            <input name="enterOilMass"
                                   id="enterOilMass"
                                   class="nui-combobox width1"
                                   textField="name"
                                   valueField="customid"
                                   emptyText="请选择..."
                                   url=""
                                   width="100%"
                                   allowInput="true"
                                   showNullItem="false"
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
	                    	</td>
	                    	<td align="right">进厂里程：</td>
	                    	<td>
	                    		<input class="nui-Spinner" minValue="0" maxValue="100000000" width="30%" id="enterKilometers" name="enterKilometers" allowNull="false" showButton="false" onvaluechanged="setEnterKilometers"/>
                                <label class="title">(上次里程：<span id="lastComeKilometers">0</span>)</label>
	                    	</td>
	                </tr>
	                <tr>
	                    <td align="right" ><font color="red">手机号码：</font></td>
	                    <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" /></td>
	                    <td align="right">是否服务技师：</td>
	                    <td><div  class="nui-checkbox" id="isArtificer" name="isArtificer" value="0" trueValue="1" falseValue="0" onvaluechanged="onChanged"></div>
	                    <input class="nui-combobox" id="memberLevelId" name="memberLevelId" required="false" style="width: 107px;display: none;" emptytext="选择技师等级" textField="name" valueField="id"/>
	                          <!--<div id="isArtificer" name="isArtificer" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
	                          textField="name" valueField="id" value="1"  width="100%"
	                          url="" > -->
	                      </div>
	                  </td>
	              </tr>
	
	              <tr>
	                <td align="right" >生日：</td>
	                <td><input class="nui-datepicker" id="birthday" name="birthday"/></td>
	                <td align="right">入职日期：<span></span></td>
	                <td><input class="nui-datepicker" id="recordDate" name="recordDate"/></td>
	            </tr>
	            <tr>
	                <td align="right"> <font color="red">身份证号码：</fpont></td>
	                <td ><input class="nui-textbox" width="200px" id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" /></td>
	                <td align="right">微信/QQ号：<span></span></td>
	                <td colspan="2"><input class="nui-textbox" name="wechat" id="wechat" vtype="maxLength:50"/></td>
	            </tr>
	            <tr>
	                        <td align="right">显示个人单据：</td>
	                        <td>
	                       		 <input class="nui-combobox"  required="false" id="isShowOwnBill" name="isShowOwnBill" textField="name"  value="0" valueField="id" />
	                       		 <input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" visible="false" emptyText="系统自动分配"/>
	                        </td>
	                        <td align="right">允许消息通知：</td>
	                        <td><input class="nui-combobox"  required="false" id="isAllowRemind" name="isAllowRemind" textField="name"  value="0" valueField="id" /></td>
	             </tr>
	            <tr>
	                <td align="right">紧急联系人：<span></span></td>
	                <td ><input class="nui-textbox" name="urgencyPerson" id="urgencyPerson" vtype="maxLength:20"/></td>
	                <td align="right"><font color="red">紧急联系人电话：</font></td>
	                <td colspan="2"><input class="nui-textbox" name="urgencyPersonPhone" id="urgencyPersonPhone" onvalidation="onMobileValidation" /></td>
	
	            </tr> 
	        </table>
	    </fieldset>
	    <fieldset id="fd1" style="width:600px;">
	        <legend><span>其它信息</span></legend>
	        <table>
	            <tr>
	                <td align="right">积分抵扣上限金额：<span></span></td>
	                <td><input class="nui-textbox" name="integralDiscountMax" id="integralDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
	            </tr>
	            <tr>
	                <td align="right">工时优惠率最高上限：</td>
	                <td><input class="nui-textbox" name="itemDiscountRate" id="itemDiscountRate" value="0" required="true"  vtype="range:0,1"/></td>
	            </tr>
	            <tr>
	                <td align="right">配件优惠率最高上限：</td>
	                <td><input class="nui-textbox" name="partDiscountRate" id="partDiscountRate" value="0" required="true"  vtype="range:0,1"/></td>
	            </tr>
	            <tr>
	                <td align="right">整单全免上限金额：<span></span></td>
	                <td><input class="mini-textbox" id="freeDiscountMax" name="freeDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
	            </tr>
	            <tr>
	                <td align="right">收银优惠上限金额：</td>
	                <td><input class="mini-textbox" name="cashDiscountMax" id="cashDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
	            </tr>
	        </table>
	    </fieldset>
	
	</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>