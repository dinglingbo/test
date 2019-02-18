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
<title>计次卡添加</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/timesCardSysn.js?v=1.1.20"></script>
</head>
<body>
		     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" id="save" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="onClose()" id="cancel" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
	<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 计次卡 </legend>
		
		<div id="dataform1" style="padding-top: 5px;">
			<!-- hidden域 -->
			<input class="nui-hidden" name="id"  /> 
			<table style="width: 100%; table-layout: fixed;white-space: nowrap;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 15%;" align="right">计次卡名称:</td>
					<td colspan="1" style="width: 35%;"><input class="nui-textbox"
						name="name" /></td>
					<td class="form_label" style="width: 13%;" align="right">有效期（月）:</td>
					<td colspan="1" style="width: 20%;" >
					<input class="nui-textbox" name="periodValidity" vtype="range:-1,1000" id = "inputMonth" />	
					</td>
					<td style="width: 22%;">
					<input type="checkbox" id="setMonth" class="mini-checkbox"  onclick="changed()" >
						<span >永久有效</span>
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售价格:</td>
					<td colspan="1"><input class="nui-textbox" name="sellAmt" id="sellAmt"
						vtype="float"  readonly="readonly" value="0"/></td>
					<td class="form_label" align="right">总价值:</td>
					<td colspan="2"><input class="nui-textbox" name="totalAmt" id = "totalAmt"
						vtype="float" readonly="readonly" value="0"/></td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售提成方式:</td>
					<td colspan="1"><input class="nui-combobox"
						data="[{value:'1',text:'按原价比例',},{value:'2',text:'按折后价比例'},{value:'3',text:'按产值比例',},{value:'4',text:'固定金额'}]"
						textField="text" valueField="value" name="salesDeductType"
						value="0" onvalidation="updateError()" id="x" /></td>
					<td class="form_label" align="right">销售提成值:</td>
					<td colspan="1" width="120px"><input class="nui-textbox"
						name="salesDeductValue" requiredErrorText="元" vtype="range:0,1000
						width="60%" /> <span id="y">&nbsp;%</span></td>
				</tr>
				<tr>
					<td class="form_label" align="right">状态:</td>
					<td colspan="1">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="status"
							textField="text" valueField="value"
							data="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
						</div>
					</td>	
					
				
					<td class="form_label" id="isSharex" align="right">是否共享:</td>
					<td colspan="1" id="isSharey">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="isShare"
							textField="text" valueField="value"
							data="[{value:'0',text:'不共享',},{value:'1',text:'共享'}]" value="0">
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
			<div title="卡项目">
				<div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height:33px" id = "toolbar1">
					<table style="width: 100%;">
						<tr >
							<td style="width: 15%;"><a class="nui-button"
								onclick="selectPackage()"  id = "addp"> <span class="fa fa-plus fa-lg"></span>添加套餐 </a></td>
							<td style="width: 15%;"><a class="nui-button"
								onclick="selectItem()"  id = "addi"> <span class="fa fa-plus fa-lg"></span>添加项目 </a></td>
							<td style="width: 15%;"><a class="nui-button"
								onclick="addDetail()"  id = "addr"> <span class="fa fa-plus fa-lg"></span>添加配件 </a></td>
							<td style="width: 55%;"><a class="nui-button "
								onclick="gridRemoveRow" id = "delect"> <span class="mini-button-text " style=""><i class="fa fa-trash-o"></i>&nbsp;删除</span> </a>
							</td>
						</tr>
					</table>
				</div>
				<div class="nui-fit" >
					<div id="timesCardDetail" class="nui-datagrid" style="width: 100%;height:100%"
						showPager="false" sortMode="client" allowCellEdit="true"
						allowCellSelect="true" multiSelect="true" showsummaryrow = "true"
						editNextOnEnterKey="true" onDrawCell="onDrawCell"  ondrawsummarycell="onDrawSummaryCell"
						onvaluechanged = "onValueChanged"			
						>
						<div property="columns">
							<!-- <div type="checkcolumn"></div> -->
							<div field="prdtId" class="nui-hidden" allowSort="true"
								align="left" headerAlign="center" width="" visible="false">
								项目ID <input class="nui-textbox" name="times" property="editor" />
							</div>
							<div field="prdtName" allowSort="true" align="left" summaryType="count" 
								headerAlign="center" width="">项目名称</div>
							<div field="times" allowSort="true" align="left"
								headerAlign="center" width="" dataType="int">
								次数 <input class="nui-spinner" name="times" property="editor" decimalPlaces="0"   minValue="1"  onvaluechanged ="onValueChangedTimes"/>
							</div>
							<div field="prdtType" allowSort="true" align="left"
								headerAlign="center" width="">项目类型</div>
							<div field="qty" allowSort="true" align="left"
								headerAlign="center" width="">
								工时/数量 <input class="nui-textbox" name="qty" property="editor" />
							</div>
							<div field="oldPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								原价 <input class="nui-textbox" name="oldPrice" property="editor" onvaluechanged ="onValueChangedOldPrice"/>
							</div>
							<div field="sellPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								销价 <input class="nui-textbox" name="sellPrice" property="editor" onvaluechanged ="onValueChangedSellPrice"/>
							</div>
							<div field="oldAmt" allowSort="true" align="left" summaryType="sum" 
								headerAlign="center" width="">
								原销售金额 
							</div>
							<div field="sellAmt" allowSort="true" align="left" summaryType="sum" 
								headerAlign="center" width="" >
								现销售金额 <input class="nui-textbox" name="sellAmt" property="editor" onvaluechanged ="onValueChangedSellAmt"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
