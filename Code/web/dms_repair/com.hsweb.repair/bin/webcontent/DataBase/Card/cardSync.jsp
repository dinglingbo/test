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
<title>储值卡录入</title>
<script src="<%=request.getContextPath()%>/repair/js/Card/cardSysn.js?v=1.3.19"></script>
</head>
<body>
	<div class="nui-fit">
		<div id="dataform1" >
			<!-- hidden域 -->
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width:100%;">
				<tr>
					<td colspan="" align="left"><a  class="nui-button"
						iconCls="" onclick="onOk()" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
						<a class="nui-button" plain="true" onclick="CloseWindow()">
						<span style="display: inline-block; "><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a></td>		
				</tr>
			</table>
			</div>
			<input class="nui-hidden" id="id" />
			<table style="width: 100%;  table-layout: fixed;margin-bottom: 15px;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 25%" align="right">
						储值卡名称:</td>
					<td colspan="1" style="width: 25%"><input class="nui-textbox"
						name="name" /> <input class="nui-hidden" name="id"
						readonly="readonly" /></td>
									
					<td class="form_label" style="" align="right">有效期（月）:</td>
					<td colspan="1"><input class="nui-textbox"
						name="periodValidity" vtype="range:-1,1000" id="inputMonth"
						width="120%" /></td>
					<td style="padding-left: 23px;"><input  type="checkbox" id="setMonth" class="mini-checkbox"
						onclick="changed()"> <span>永久有效</span></td>
				</tr>

				<tr>
					<td class="form_label" align="right">充值金额:</td>
					<td colspan="1"><input class="nui-textbox" name="rechargeAmt"
						onvalidation="vaild" /></td>
					<td class="form_label" align="right">赠送金额:</td>
					<td colspan="2"><input class="nui-textbox" name="giveAmt"/></td>
				</tr>
				<tr>
					<td class="form_label" align="right" colspan="1">销售提成方式:</td>
					<td colspan="1"><input class="nui-combobox"
						data="[{value:'1',text:'按原价比例',},{value:'2',text:'按折后价比例'},{value:'3',text:'按产值比例',},{value:'4',text:'固定金额'}]"
						textField="text" valueField="value" name="salesDeductType"
						value="1" onvalidation="updateError()" id="x" /></td>
					<td class="form_label" align="right" colspan="1">销售提成值:</td>
					<td colspan="1" style="width: 40%"><input class="nui-textbox" style="width: 60%"
						name="salesDeductValue" requiredErrorText="元" vtype="range:0,1000" style="width: 40%" /> <span id="y">&nbsp;%</span></td>
				</tr>
				<tr>
					</td>
					<td class="form_label" align="right">是否允许修改金额:</td>
					<td colspan="1">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="canModify"
							textField="text" valueField="value"
							data="[{value:'0',text:'否',},{value:'1',text:'是'}]" value="0">
						</div>

					</td>
					<td class="form_label" align="right">状态:</td>
					<td colspan="2">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="status"
							textField="text" valueField="value"
							data="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
						</div>
					</td>
				</tr>
				<tr>
					<td class="form_label" id="isSharex" align="right">是否共享:</td>
					<td colspan="1" id="isSharey">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="isShare"
							textField="text" valueField="value"
							data="[{value:'0',text:'不共享',},{value:'1',text:'共享'}]" value="0">
						</div>
					</td>
				</tr>
				
				</table>
				<div style="height: 180px;margin-bottom: 15px">              
                <div id="contentGrid" class="nui-datagrid" style="width: 80%; height: 100%; margin-left: 10%; "
                        showPager="false"
                        dataField="resList"
                        sortMode="client"
                        allowCellSelect="true"
                        allowCellEdit="true"
                        showModified="false"
                        url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div allowSort="true" field="serviceTypeName" width="80" headerAlign="center" align="center" header="业务类型"></div>
                        <div allowSort="true" field="packageDiscountRate" headerAlign="center" header="套餐优惠(0-100)">
                                <input property="editor" decimalPlaces="0" class="nui-spinner" format="0"  value="0" maxValue="100" showButton="false"/>
                        </div>
                        <div allowSort="true" field="itemDiscountRate" headerAlign="center" header="项目优惠(0-100)">
                                <input property="editor" decimalPlaces="0"  class="nui-spinner" format="0"  value="0" maxValue="100" showButton="false"/>
                        </div>
                        <div allowSort="true" field="partDiscountRate" headerAlign="center" header="配件优惠(0-100)">
                                <input property="editor" decimalPlaces="0"  class="nui-spinner" format="0"  value="0" maxValue="100" showButton="false"/>
                        </div>
                    </div>
                </div>
            </div>
				<table style="width: 100%;">
				<tr>
					<td class="form_label" align="right">使用条款:</td>
					<td colspan="2"><input class="nui-TextArea" name="useRemark"
						style="width:200px;" /></td>
				
					<td class="form_label" align="right">卡说明:</td>
					<td colspan="2"><input class="nui-TextArea" name="remark"
						style="width:200px;" /></td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>
