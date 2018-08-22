<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
<head>
<title>计次卡购买</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/buyCardTimes.js?v=1.0.7"></script>
</head>
<body>
	<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 计次卡 </legend>
		<div id="dataform2" style="padding-top: 5px;" >	
		<table style="width: 100%; table-layout: fixed;"
				class="nui-form-table">	
				<input class="nui-hidden" name="guestId" id="guestId" />	
				 <tr>
				 <!-- hidden域 -->
			        
			
                        <td class="form_label" style="width:15%;" align="right">
                            <label>客户名称:</label>
                        </td>
                        <td style="width:25%;">
                            <input class="nui-buttonedit" id="contactorName" name="contactorName" textname="contactorName" 
                            emptyText="请选择..." onbuttonclick="selectCustomer"  allowInput="false"
                            selectOnFocus="true" required="true" />
                        </td>
                    
                    <td class="form_label" align="right">结算方式:</td>
					<td colspan="2">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="payType"
							textField="text" valueField="value"
							data="[{value:'020101',text:'现金',},{value:'020102',text:'刷卡'},{value:'020104',text:'微信/支付宝'}]" value="020101" >
						</div> 
					</td>	
                 </tr>
          </table>
		
		</div>
			
		<div id="dataform1" style="padding-top: 5px;" >
			
			<table style="width: 100%; table-layout: fixed;"
				class="nui-form-table">
				<input class="nui-hidden" name="id" id="Id" />
				<tr>
					<td class="form_label" style="width: 15%;" align="right">计次卡名称:</td>
					<td colspan="1" style="width: 35%;"><input class="nui-textbox"
						name="name" /></td>
					<td class="form_label" style="width: 13%;" align="right">有效期（月）:</td>
					<td colspan="1" style="width: 20%;" >
					<input class="nui-textbox" name="periodValidity" vtype="float" id = "inputMonth" />	
					</td>
					<td style="width: 22%;">
					<input type="checkbox" id="setMonth" class="mini-checkbox"  >
						<span >永久有效</span>
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售价格:</td>
					<td colspan="1"><input class="nui-textbox" name="sellAmt"
						vtype="float" /></td>
					<td class="form_label" align="right">总价值:</td>
					<td colspan="2"><input class="nui-textbox" name="totalAmt"
						vtype="float" /></td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售提成方式:</td>
					<td colspan="1"><input class="nui-combobox"
						data="[{value:'0',text:'按原价比例',},{value:'1',text:'按折后价比例'},{value:'2',text:'按产值比例',},{value:'3',text:'固定金额'}]"
						textField="text" valueField="value" name="salesDeductType"
						value="0"  id="x"  /></td>
					<td class="form_label" align="right">销售提成值:</td>
					<td colspan="1" width="120px"><input class="nui-textbox"
						name="salesDeductValue" requiredErrorText="元" vtype="float"
						width="60%" /> <span id="y">&nbsp;%</span></td>
				</tr>
				<tr>
					<td class="form_label" align="right">状态:</td>
					<td colspan="2">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="status"
							textField="text" valueField="value"
							data="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0"  >
						</div>
					</td>	
				</tr>
				<tr>
					<td class="form_label" align="right">使用条款:</td>
					<td colspan="1"><input class="nui-TextArea" name="useRemark"
						style="width: 330px; height: 50px;" /></td>
						
						<td class="form_label" align="right">卡说明:</td>
					<td colspan="1"><input class="nui-TextArea" name="remark"
						style="width: 330px; height: 50px;" /></td>
				</tr>
				<!-- <tr>
					<td class="form_label" align="right">卡说明:</td>
					<td colspan="1"><input class="nui-TextArea" name="remark"
						style="width: 330px; height: 50px;" /></td>
				</tr> -->
				<tr>
			</table>
		</div>
	</fieldset>
	<!-- 从表的修改 -->
	<div style="margin: 0px 2px 0px 2px;">
		<div class="nui-tabs" id="tab" activeIndex="0" style="width: 100%;height:59%">
			<div title="卡项目" >
				<div class="nui-fit" >
					<div id="timesCardDetail" class="nui-datagrid" style="width: 100%;height:100%"
						showPager="false" sortMode="client" allowCellEdit="true"
						allowCellSelect="true" multiSelect="true"
						editNextOnEnterKey="true" onDrawCell="onDrawCell" >
						<div property="columns">
							<div type="checkcolumn"></div>
							<div field="prdtId" class="nui-hidden" allowSort="true"
								align="left" headerAlign="center" width="" visible="false">
								项目ID <input class="nui-textbox" name="times" property="editor" />
							</div>
							<div field="prdtName" allowSort="true" align="left"
								headerAlign="center" width="">项目名称</div>
							<div field="times" allowSort="true" align="left"
								headerAlign="center" width="">
								次数 <input class="nui-textbox" name="times" property="editor" />
							</div>
							<div field="prdtType" allowSort="true" align="left"
								headerAlign="center" width="">项目类型</div>
							<div field="qty" allowSort="true" align="left"
								headerAlign="center" width="">
								工时/数量 <input class="nui-textbox" name="qty" property="editor" />
							</div>
							<div field="oldPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								原价 <input class="nui-textbox" name="oldPrice" property="editor" />
							</div>
							<div field="sellPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								销价 <input class="nui-textbox" name="sellPrice" property="editor" />
							</div>
							<div field="oldAmt" allowSort="true" align="left"
								headerAlign="center" width="">
								原销售金额 <input class="nui-textbox" name="oldAmt" property="editor" />
							</div>
							<div field="sellAmt" allowSort="true" align="left"
								headerAlign="center" width="">
								现销售金额 <input class="nui-textbox" name="sellAmt"
									property="editor" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
			<table width="100%">
				<tr >
				<td style="text-align:center;" colspan="1"  >
					<a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					<spand>&nbsp;&nbsp;&nbsp;</spand>
					<a class="nui-button" iconCls="icon-save" onclick="payOk()" id = "payOk">结算收款</a> 
				</td>
					<!-- <td style="text-align:center;" colspan="1"  >
					<spand>&nbsp;&nbsp;&nbsp;</spand>
					<a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					
					</td>
					
					<td style="text-align:left;" colspan="1" >
					<spand>&nbsp;&nbsp;&nbsp;</spand>
						<a class="nui-button" iconCls="icon-save" onclick="payOk()" id = "payOk">结算收款</a> 
					</td> -->
				</tr>
			</table>
		</div>
	</div>

</body>
</html>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>