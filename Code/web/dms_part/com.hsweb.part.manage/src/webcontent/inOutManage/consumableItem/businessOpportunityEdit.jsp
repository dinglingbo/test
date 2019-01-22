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
	src="<%=request.getContextPath()%>/manage/js/inOutManage/consumableItem/businessOpportunityEdit.js?v=1.0.4"></script>
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
		
		<div id="basicInfoForm" style="padding-top: 5px;">
			<!-- hidden域 -->
			<input class="nui-hidden" name="id"  /> 
			<table style="width: 100%; table-layout: fixed;white-space: nowrap;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 15%;" align="right">车牌号</td>
					<td  style="width: 25%;">                            
						<input class="nui-buttonedit" id="carNo" name="carNo" textname="carNo" emptyText="请输入或选择..." onbuttonclick="selectCustomer" selectOnFocus="true" required="true" onenter="onenterSelect(this.value)"  />
                        <input class="nui-textbox" id="carId" name="carId" visible="false" />
                        <input class="nui-textbox" id="guestId" name="guestId" visible="false" /> 
                        <input class="nui-textbox" id="contactorId" name="contactorId" visible="false" /> 
                     </td>
					<td class="form_label" style="width: 20%;" align="right">客户名称:</td>
					<td  style="width: 28%;" >
					<input class="nui-textbox" id="guestName" name="guestName" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">手机号:</td>
					<td colspan="1">
						<input class="nui-textbox" name="guestMobile" id="guestMobile" required="true" />
					</td>
					<td class="form_label" align="right">商机类型:</td>
					<td colspan="1">
					<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"   />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售产品/项目:</td>
					<td colspan="1">
						<input class="nui-textbox" name="prdtName" id="prdtName"  />
					</td>
					<td class="form_label" align="right">预计金额:</td>
					<td colspan="1">
					<input class="nui-textbox" name="prdtAmt" id="prdtAmt"    />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">销售阶段:</td>
					<td colspan="1">
						<input class="nui-textbox" name="prdtName" id="prdtName"  />
					</td>
					<td class="form_label" align="right">商机所有者:</td>
					<td colspan="1">
					<input class="nui-textbox" name="prdtAmt" id="prdtAmt"    />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right">预计成单日期:</td>
					<td colspan="1">
						<input format="yyyy-MM-dd"   class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
					</td>
					<td class="form_label" align="right">下次跟进时间:</td>
					<td colspan="1">
						 <input format="yyyy-MM-dd"   class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
					</td>
				</tr>

					<tr>
					<td class="form_label" align="right">销售机会内容:</td>
					<td colspan="1"><input class="nui-TextArea" name="useRemark"
						style=" height: 50px;" /></td>
						
						<td class="form_label" align="right">备注:</td>
					<td colspan="1"><input class="nui-TextArea" name="remark"
						style=" height: 50px;" /></td>
				</tr>

			</table>
		</div>

</body>
</html>
