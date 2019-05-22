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
<script
	 src="<%=request.getContextPath()%>/manage/js/inOutManage/purchaseOrder/carSalesPutStorageDetails.js?v=1.0.0"></script> 
	 <style type="text/css">
		.btn .mini-buttonedit
{
    height:39px;
}
.btn .mini-buttonedit-border
{
    height:36px;
}
.btn .mini-buttonedit-input
{
    height:36px;
    line-height:25px;
}
.btn .mini-buttonedit-button
{
    height:33px;
}
.btn .mini-buttonedit-icon
{
       
    width:15px;
    height:34px;
} 
	 </style>
</head>
<body>
		     <div class="nui-toolbar" style="padding:0px;height: 50px">
                <table style="width:100%;">
                    <tr>
                    	<td class="btn">      
                    		<input id="" name="" class="nui-buttonedit" emptyText="选择待验车辆..."  onbuttonclick="check()" width="300px" onvaluechanged=""   selectOnFocus="true"/>                 		                 		                                		
                    	</td>
                        <td align="right">
                        	<a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" onclick="onOk()"  plain="true" ><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick=""  plain="true" ><span class="fa fa-automobile fa-lg"></span>&nbsp;验车入库</a>
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
	                   <input name="" id=""  showTime="true"  class="nui-datepicker"  format="yyyy-MM-dd HH:mm"/>
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
					<td class="form_label"  align="right">车架号:</td>
					<td> <input  class="nui-textbox" /></td>					
					<td class="form_label"  align="right">公里数:</td>
					<td ><input class="nui-textbox" name="name" /></td>
				</tr>
				<tr>
					<td class="form_label"  align="right">车身颜色:</td>
	                <td ><input class="nui-textbox" name="name" /></td>
					<td class="form_label"  align="right">内饰颜色:</td>
					<td> <input  class="nui-textbox" /></td>	
					<td class="form_label"  align="right">生产日期:</td>
					<td> <input name="" id=""  showTime="true" class="nui-datepicker"  format="yyyy-MM-dd HH:mm"/></td>									
				</tr>
				<tr>
					<td class="form_label"  align="right">车况备注:</td>
					<td colspan="5"> <input  class="nui-TextArea" width="50%"/></td>
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
