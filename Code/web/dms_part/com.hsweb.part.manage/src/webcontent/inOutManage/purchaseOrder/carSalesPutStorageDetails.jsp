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
<title>验车入库添加</title>
<%--<script
	 src="<%=request.getContextPath()%>/repair/js/Card/timesCardSysn.js?v=1.1.20"></script> --%>
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
		<legend>入库单信息</legend>
		
		<div id="dataform1" style="padding-top: 5px;">
			<!-- hidden域 -->
			<input class="nui-hidden" name="id"  /> 
			<table style="width: 100%; "
				class="nui-form-table">
				<tr>
					<td class="form_label"  align="right">入库单号:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">供应商:</td>
					<td colspan="3" style="width:38%">
                      <input id="guestId"
                             name="guestId"
                             class="nui-buttonedit"
                             emptyText="请选择供应商..."
                             onbuttonclick="selectSupplier('guestId')"
                             onvaluechanged="onGuestValueChanged"
                             width="100%"
                             placeholder="请选择供应商"
                             selectOnFocus="true" />
                    </td>
					<td class="form_label"  align="right">入库日期:</td>
					<td>
	                   <input name="" id=""  showTime="true" class="nui-datepicker"  format="yyyy-MM-dd HH:mm"/>
					</td>
					<td class="form_label"  align="right">经手人:</td>
					<td>
	                   <input name="" id=""  showTime="true" class="nui-textbox" />
					</td>
				</tr>
				<tr>
					<td class="form_label"  align="right">车价（成本）:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">运输公司:</td>
					<td colspan="3" style="width:38%">
                      <input id="guestId"
                             name="guestId"
                             class="nui-buttonedit"
                             emptyText="请选择供应商..."
                             onbuttonclick="selectSupplier('guestId')"
                             onvaluechanged="onGuestValueChanged"
                             width="100%"
                             placeholder="请选择供应商"
                             selectOnFocus="true" />
                    </td>
					<td class="form_label"  align="right">物流专员:</td>
					<td>
	                   <input name="" id=""  showTime="true" class="nui-textbox" />
					</td>
					<td class="form_label"  align="right">运输费:</td>
					<td>
	                   <input name="" id=""  showTime="true" class="nui-textbox" />
					</td>
				</tr>				
			</table>
		</div>
	</fieldset>
	<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend>车辆信息</legend>
		
		<div id="dataform1" style="padding-top: 5px;">
			<!-- hidden域 -->
			<input class="nui-hidden" name="id"  /> 
			<table style="width: 100%; "
				class="nui-form-table">
				<tr>
					<td class="form_label"  align="right">车型:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">品牌:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">规格:</td>
	                <td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">排量:</td>
					<td> <input  class="nui-textbox" /></td>
					<td class="form_label"  align="right">缸数:</td>
					<td> <input  class="nui-textbox" /></td>					
				</tr>
				<tr>
					<td class="form_label"  align="right">驱动模式:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">变速箱:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">配置:</td>
	                <td colspan="3" ><input class="nui-textbox" width="100%"name="name" /></td>
					<td class="form_label"  align="right">车架号:</td>
					<td> <input  class="nui-textbox" /></td>					
				</tr>
				<tr>
					<td class="form_label"  align="right">发动机号:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">公里数:</td>
					<td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">车身颜色:</td>
	                <td ><input class="nui-textbox" width="100%"name="name" /></td>
					<td class="form_label"  align="right">内饰颜色:</td>
					<td> <input  class="nui-textbox" /></td>	
					<td class="form_label"  align="right">生产日期:</td>
					<td> <input name="" id=""  showTime="true" class="nui-datepicker"  format="yyyy-MM-dd HH:mm"/></td>									
				</tr>
				<tr>
					<td class="form_label"  align="right">车况备注:</td>
					<td colspan="9"> <input  class="nui-TextArea" width="50%"/></td>
				</tr>									
			</table>
		</div>
	</fieldset>
	<!-- 从表的修改 -->
	<div style="margin: 0px 2px 0px 2px;">
		<div class="nui-tabs" id="tab" activeIndex="0" style="width: 100%;height:59%">
			<div title="随车物品">
				<div class="nui-fit" >
				</div>
			</div>
			<div title="车辆检查">
				<div class="nui-fit" >
				</div>
			</div>			
		</div>
	</div>
</body>
</html>
