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
	src="<%=request.getContextPath()%>/repair/js/Card/timesCardSysn.js?v=1.0.5"></script>
</head>
<body>
	<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 计次卡 </legend>
		<div id="dataform1" style="padding-top: 5px;">
			<!-- hidden域 -->
			<input class="nui-hidden" name=""
				id="" /> <input class="nui-hidden"
				name="id" id="id" />
			<table style="width: 100%; table-layout: fixed;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 15%;">计次卡名称:</td>
					<td colspan="1" style="width: 35%;"><input class="nui-textbox"
						name="name" /></td>
					<td class="form_label" style="width: 13%;">有效期（月）:</td>
					<td colspan="2" style="width: 37%;"><input class="nui-textbox"
						name="periodValidity" /></td>
				</tr>
				<tr>
					<td class="form_label">销售价格:</td>
					<td colspan="1"><input class="nui-textbox"
						name="sellAmt" /></td>
					<td class="form_label">总价值:</td>
					<td colspan="2"><input class="nui-textbox"
						name="totalAmt" /></td>
				</tr>
				<tr>
					<td class="form_label">销售提成方式:</td>
					<td colspan="1"><input class="nui-combobox"
						data="[{value:'0',text:'按原价比例',},{value:'1',text:'按折后价比例'},{value:'2',text:'按产值比例',},{value:'3',text:'固定金额'}]"
						textField="text" valueField="value" name="salesDeductType"
						value="0" onvalidation="updateError()" id="x" /></td>
					<td class="form_label">销售提成值:</td>
					<td colspan="1"><input class="nui-textbox"
						name="salesDeductValue" requiredErrorText="元" vtype="float" /></td>
					<td colspan="1"><div style="display: none;" id="y">&nbsp元</div>
						<div style="display: block;" id="b">&nbsp%</div></td>
				</tr>
				<tr>
					<td class="form_label">状态:</td>
					<td colspan="2">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="status"
							textField="text" valueField="value"
							data="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
						</div>
				</tr>
				<tr>
					<td class="form_label">使用条款:</td>
					<td colspan="2"><input class="nui-TextArea" name="useRemark"
						style="width: 330px; height: 50px;" /></td>
				</tr>
				<tr>
					<td class="form_label">卡说明:</td>
					<td colspan="1"><input class="nui-TextArea" name="remark"
						style="width: 330px; height: 50px;" /></td>
				</tr>
				<tr>
			</table>
		</div>
	</fieldset>
	<!-- 从表的修改 -->
	<div style="margin: 0px 2px 0px 2px;">
		<div class="nui-tabs" id="tab" activeIndex="0"
			style="width: 100%;" >
			<div title="卡项目">
				<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
					<table style="width: 100%;">
						<tr>
							<td style="width: 15%;"><a class="nui-button"
								onclick="selectPackage()" iconCls="icon-add"> 添加套餐 </a></td>
							<td style="width: 15%;"><a class="nui-button"
								onclick="addItem()" iconCls="icon-add"> 添加工时 </a></td>
							<td style="width: 15%;"><a class="nui-button"
								onclick="addDetail()" iconCls="icon-add"> 添加配件 </a></td>
							<td style="width: 55%;">
                <a class="nui-button " iconCls="icon-remove" onclick="gridRemoveRow('grid_0')"   >
                    &nbsp;删除
                  </a>
							</td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="timesCardDetail" class="nui-datagrid"
						style="width: 100%; " showPager="false"
						sortMode="client" allowCellEdit="true" allowCellSelect="true"
						multiSelect="true" editNextOnEnterKey="true">
						<div property="columns">
              <div type="checkcolumn"></div>
              <div field="prdtId" class="nui-hidden" allowSort="true" align="left"
              headerAlign="center" width="">
              项目ID <input class="nui-textbox" name="times" property="editor" />
            </div>
							<div field="prdtName" allowSort="true" align="left"
								headerAlign="center" width="">
								项目名称 <input class="nui-textbox" name="prdtName" property="editor"
								 />
							</div>
							<div field="times" allowSort="true" align="left"
								headerAlign="center" width="">
								次数 <input class="nui-textbox" name="times" property="editor" />
							</div>
							<div field="prdtType" allowSort="true" align="left"
								headerAlign="center" width="">
								项目类型 <input class="nui-textbox" name="prdtType" property="editor"
									 />
							</div>
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
								现销售金额 <input class="nui-textbox" name="sellAmt" property="editor" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
			<table width="100%">
				<tr>
					<td style="text-align: center;" colspan="4"><a
						class="nui-button" iconCls="icon-save" onclick="onOk()"> 保存 </a> <span
						style="display: inline-block; width: 25px;"> 
				</tr>
			</table>
		</div>
	</div>

</body>
</html>
