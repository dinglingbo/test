<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-29 15:00:37
  - Description:
-->
<head>
<title>数据处理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<%@include file="/common/sysCommon.jsp"%>
   <script src="<%= request.getContextPath() %>/dataProcessing/js/dataProcessing.js?v=1.0.1"></script>
    <style type="text/css">
    	.da{
    		font-weight:bold;
    		font-size: 16px;
    	}
    	.processing{
    		width: 180px;
			height: 40px;
			font-size: 18px;
			background: #578ccd;
			color: #fff;
			text-align: center;
			display: block;
			border-radius: 5px;
			text-decoration: none;
			line-height: 2;
			margin-top: 7px;
    	}
    </style>
</head>
<body>
            <div class="mini-splitter" vertical="false" style="width:100%;height:100%;">
                 <div size="50%" showCollapseButton="true">
                        <fieldset style="width:100%;border:solid 1px #aaa;margin-top:8px;position:relative;">
                            <legend>清除说明</legend>
                            	<div>
                            		<p><font color="red">所有根据orgid删除，只删除传入orgid所对应店的数据，勾选删除.</font></p>
	                            	<span class="da">售后业务数据:</span><br>
										1、工单相关业务数据，如：（wb_repair.rps_maintain：工单表，wb_repair.rps_insurance_main保险单）<br>
										2、储值卡、计次卡的业务、退款数据，如：（wb_repair.rps_card_stored，wb_repair.rps_card_times_invocing:计次流水表）<br>
										3、预约、车主变更、提成、开票、优惠券等类型。<br>
		                            <span class="da">售后库存数据:</span>	<br>
		                            	1、入库、出库、退货、盘点，如：（pj_enter_main、 pj_enter_detail、pj_enter_main_chk、pj_enter_detail_chk）<br>
										2、配件流水、库存、移仓、工单出库，如：（pj_part_stock，pj_part_store_stock）<br>
		                            <span class="da">售后客户数据:</span>	<br>
		                            	1、客户、车辆，如：（wb_common.com_guest、wb_repair.rpb_car）<br>
		                            	2、电销客户资料表、回访资料表、回访记录表	<br>
		                            <span class="da">售后供应商数据:</span>	<br>
		                            	1、采购、对账、供应商（wb_common.com_guest只删除供应商）	<br>
		                            <span class="da">售后基础数据:</span><br>
		                            	1、工时定义、配件定义、会员卡(储值)定义、套餐定义表、计次卡定义<br>
		                            <span class="da">售后汽贸数据:</span><br>
		                            	1、汽贸所有表（wb_sales）		<br>
		                            <span class="da">售后财务数据:</span><br>
		                            	1、财务所有表（wb_frm）	<br>		                            																																
                            	</div>
                            	
                            	
             	        </fieldset>
                 </div>
                <div size="50%" showCollapseButton="true">
                    <div class="nui-fit">                   
					         <div class="nui-toolbar" style="padding:0px;">
					            <table style="width:100%;">
					                <tr>
					                    <td style="width:100%;">
					                    	<input  class="nui-textbox" emptytext="清除门店orgid"  width="125px" style="margin-right:0px;" name="orgid" id="orgid"/>
<!-- 					                        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
					                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
					                        <!-- <a class="nui-button" iconCls="" plain="true" onclick="delet()" id="deletBtn"><span class="fa fa-trash-o fa-lg"></span>&nbsp;清空</a> -->
					                    </td>
					                </tr>
					            </table>
					        </div>
<!-- 					  <ul id="tree2" class="nui-tree"  style="width:200px;padding:5px;" 
					        checkRecursive="true"
					        showTreeIcon="true" textField="text" idField="id" parentField="pid" resultAsTree="false"  
					        showCheckBox="true"  _checkOnTextClick="true">
					  </ul> -->
					  <a  class="processing" href="javascript:void(0)" onclick="save('rpsMaintain')">清除工单数据</a>
				      <a  class="processing" href="javascript:void(0)" onclick="save(basisProcessing)">清除基础定义数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(employeesProcessing)">清除员工数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(guestProcessing)">清除客户与车辆数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(rpsCard)">清除客户办卡数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(supplierProcessing)">清除供应商数据</a>
					  <a  class="processing"  href="javascript:void(0)" onclick="save(wbFrm)">清除财务数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="wbPart)">清除库存数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(wbRepair)">清除杂项数据</a>
					  <a  class="processing" href="javascript:void(0)" onclick="save(wbSales)">清除汽贸数据</a>																																																							
                    </div>
                 </div>

            </div>
</body>
</html>