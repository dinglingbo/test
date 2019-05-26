<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>编辑来访记录</title>
<script src="<%= request.getContextPath() %>/sales/customer/js/addVisitRecords.js?v=1.0.0"></script>
<style type="text/css">
/* table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
} */
.dtable{
	table-layout: fixed;
	font-size: 12px;
	height: 100%;
	width: 100%;
}

.form_label {
	width: 120px;
	text-align: right;
}

.d_label {
	width: 80px;
	text-align: center;
}

.mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important;
}

  .nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}
.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;height:48px;position: relative;">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td class="btn">
                 
                <label style="font-family:Verdana;">工单号:</label>
                <label id="serviceCodeEl" style="font-family:Verdana;"></label>
                <br>
                <label style="font-family:Verdana;">客户名称:</label>
                <label id="nameEl" style="font-family:Verdana;"></label>
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <label style="font-family:Verdana;">意向车型:</label>
                <label id="carModelNameEl" style="font-family:Verdana;"></label>
            </td>     
            <td style="text-align:right;">
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;归档</a>
                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-mail-forward  fa-lg"></span>&nbsp;转销售</a>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-shopping-bag fa-lg"></span>&nbsp;精品加装</a>
                <a class="nui-button" onclick="buyCarCount" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
                          
            </td>
        </tr>
    </table>
</div>
<fieldset style="border: solid 1px #aaa; position: relative; margin: 0px 0px 0px 0px;height:100%;width: 100%;" id="guestComeForm">
            <!--  <input id="id" name="id" class="nui-hidden"/>
            <input name="specialCare"
                 id="specialCare"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 allowInput="true"
                 width="100%"
                 visible="false"
                />
              <input name="intentLevel"
                 id="intentLevel"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 allowInput="true"
                 width="100%"
                 visible="false"
                /> -->
            <input id="saleAdvisor" name="saleAdvisor" class="nui-hidden"/>
	        <input name="id" class="nui-hidden" id="mainId"/>
	        <input id="guestId" name="guestId" class="nui-hidden"/>
            <input name="specialCare"
                 id="specialCare"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 allowInput="true"
                 width="100%"
                 visible="false"
                />
              <input name="intentLevel"
                 id="intentLevel"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 allowInput="true"
                 width="100%"
                 visible="false"
                />
	<table class="nui-form-table" border=0 >
	        
			<tr>
				<!-- <td class="form_label">
					<label>单据编号：</label>
				</td>
				<td>
					<input class="nui-textbox" name="name" width="100%" maxlength="50" value="自动编号" enabled="false"/>
				</td> -->
				
				 <td class="form_label">
                  <label >来访时间：</label>
                </td>
                <td>
                     <input width="100%" id="comeDate" name="comeDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
               </td>
				<td class="form_label">
			  <label>来访方式：</label>
				</td>
				<td colspan="1">
                  <input name="comeTypeId"
                         id="comeTypeId"
                         class="nui-combobox"
                         textField="name"
                         valueField="id"
                         allowInput="true"
                         width="100%"
                         
                        />
		     	</td>
		     	<td class="form_label">
			        <label>业务员：</label>
		        </td>
		        <td colspan="1">
		            <input name="saleAdvisorId"
		             id="saleAdvisorId"
		             class="nui-combobox"
		             textField="empName"
		             valueField="empId"
		             allowInput="true"
		             width="100%"
		            />
     	        </td>
			</tr>
			<tr>
			<td class="form_label required">
				<label>客户名称：</label>
		    </td>
			<td colspan="1">
				<input class="nui-textbox" name="fullName" width="100%" maxlength="20"/>
			</td>
			<td class="form_label required">
			    <label>手机号码：</label>
			</td>
			<td colspan="1">
				<input class="nui-textbox" name="mobile" width="100%" maxlength="20"/>
			</td>
			<td class="form_label">
			     <label>客户性质：</label>
		     </td>
			<td>
			  <input class="nui-combobox" id="guestProperty" emptyText="个人" name="guestProperty" data="[{guestProperty:013902,text:'个人'},{guestProperty:013901,text:'单位'},{guestProperty:013903,text:'个体户'}]"
                width="100%"  onvaluechanged="onSearch" textField="text" valueField="guestProperty" value="013902"/>
			</td>
			</tr>
			<tr>			    
			<td class="form_label">
				<label>车身颜色：</label>
			</td>
			<td colspan="1">
	          <input name="frameColorId"
	                 id="frameColorId"
	                 class="nui-combobox"
	                 textField="name"
	                 valueField="id"
	                 allowInput="true"
	                 width="100%"
	                 
	                />
	        <td class="form_label">
				<label>内饰颜色：</label>
			</td>
			<td colspan="1">
	           <input name="interialColorId"
	                 id="interialColorId"
	                 class="nui-combobox"
	                 textField="name"
	                 valueField="id"
	                 allowInput="true"
	                 width="100%"
	                 
	                />
	      </td>          
		 <td class="form_label">
			 <label>是否试驾：</label>
		  </td>
		<td colspan="1">
			<input class="nui-combobox" id="isTestDrive" emptyText="是" name="isTestDrive" data="[{isTestDrive:1,text:'是'},{isTestDrive:0,text:'否'}]"
              width="98%"  textField="text" valueField="isTestDrive" value="1"/>
		</td>			     
	   </tr>
	    <tr>
		<td class="form_label required">
			<label>意向车型：</label>
		</td>
		<td colspan="3">
         <!-- <input id="carModelTypeFullNmae"
	         name="carModelTypeFullNmae"
	         class="nui-buttonedit"
	         emptyText=""
	         onbuttonclick="chooseCarModelType()"
	         placeholder=""
	         selectOnFocus="true" 
	         allowInput="false"
	         width="50%"
	        /> -->
	        <input id="carModelId" name="carModelId" class="nui-textbox" visible="false" style="width: 552px;"/>
           <input id="carModelName" name="carModelName" class="nui-buttonedit" style="width: 552px;" onbuttonclick="onButtonEdit"/>
        
        </td>
        
        
        <td class="form_label">
		 <label>预算金额：</label>
	   </td>
	   <td colspan="1">
		 <input class="nui-textbox" name="expectPrice" width="100%" maxlength="20"/>
	   </td>					    
	    </tr>
	   <tr>
	     <td class="form_label" align="right">车型配置:</td>
         <td colspan="5"><input class="nui-TextArea" name="configure"
       style="width: 100%; height: 50px;" />
       </td>
	   </tr>
	
    <tr>
        <td class="form_label"><label>关注重点：</label></td>
        <td colspan="5">
            <div id="specialCareId" name="specialCareId" class="nui-checkboxlist" repeatItems="15" 
            repeatLayout="flow"  value="" 
            textField="text" valueField="id" ></div>
        </td>
    </tr>
    
    <tr>
        <td class="form_label"><label>意向级别：</label></td>
        <td colspan="5">
            <div id="intentLevelId" name="intentLevelId" class="mini-radiobuttonlist" repeatItems="15" 
            repeatLayout="flow"  value="" 
            textField="text" valueField="id" ></div>
        </td>
    </tr>
    <tr>
	<td class="form_label" align="right">备注:</td>
    <td colspan="5"><input class="nui-TextArea" name="remark"
       style="width: 100%; height: 50px;" /></td>
	</tr>
    <tr>
	<td class="form_label">
			<!-- <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/><label>在</label> -->
		</td>
    <td colspan="5">
       <input id="nextVisitDate" name="nextVisitDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="30%"/>
         进行售前潜客回访
       </td>
	</tr>
</table>
</fieldset>
<div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
    <div id="statustable" style="float: left;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
    	<table  style='height: 100%'>
    		<tbody>
    			<tr>
    				<tr>
    					<td  style='height: 100%;font-size:18px'>
					      <label style="font-family:Verdana;">服务进度:</label>
					      <label style="font-family:Verdana;"><span id="addStatus" name="statusvi" class="nvstatusview">草稿</span></label>
					      <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
					      <label style="font-family:Verdana;"><span id="repairStatus" name="statusvi" class="nvstatusview">归档</span></label>
					      <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
					      <label style="font-family:Verdana;"><span id="finishStatus" name="statusvi" class="nvstatusview">转销售</span></label>
    					</td>
    				</tr>
    		</tbody>
    	</table>
    </div>
    <!-- <div id="sellForm" class="form"  style="float:right;height: 100%;padding-right: 20px;">
    	<table style='height: 100%'>
    		<tbody>
    			<tr>
    				<td  style='height: 100%'>
			        <label>总金额：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			        <label>优惠金额：</label>
 			          <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalPrefAmt" name="totalPrefAmt"/>        
 			        <label>小计金额：</label>
 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalSubtotal" name="totalSubtotal"/>
 					<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"  visible="false" />
                      <div style='display: none'>
			          <input class="nui-hidden" enabled="false" id="packageSubtotal" name="packageSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="packagePrefAmt" name="packagePrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="itemSubtotal" name="itemSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="itemPrefAmt" name="itemPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="partSubtotal" name="partSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="partPrefAmt" name="partPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="ycAmt" name="ycAmt"/>
			        </div>
    				</td>
    			</tr>
    		</tbody>
    	</table>
    </div> -->
</div>
</body>
</html>