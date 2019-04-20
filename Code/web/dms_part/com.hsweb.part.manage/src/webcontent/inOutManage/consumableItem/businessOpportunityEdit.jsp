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
<title>商机添加</title>
<script
	src="<%=request.getContextPath()%>/manage/js/inOutManage/consumableItem/businessOpportunityEdit.js?v=1.2.5"></script>
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
			<input class="nui-hidden" name="id" /> 
			<table style="width: 100%; table-layout: fixed;white-space: nowrap;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 15%;" align="right"><font color="red">车牌号</font></td>
					<td  style="width: 25%;">                            
						<input class="nui-buttonedit" id="carNo" name="carNo" textname="carNo" emptyText="请输入或选择..." onbuttonclick="selectCustomer" selectOnFocus="true" required="true" onenter="onenterSelect(this.value)"  />
                        <input class="nui-textbox" id="carId" name="carId" visible="false" />
                        <input class="nui-textbox" id="guestId" name="guestId" visible="false" /> 
                        <input class="nui-textbox" id="contactorId" name="contactorId" visible="false" /> 
                     </td>
					<td class="form_label" style="width: 20%;" align="right"><font color="red">客户名称:<font></td>
					<td  style="width: 28%;" >
					<input class="nui-textbox" id="guestName" name="guestName" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right"><font color="red">手机号:</font></td>
					<td colspan="1">
						<input class="nui-textbox" name="guestMobile" id="guestMobile" required="true" />
					</td>
					<td class="form_label" align="right"><font color="red">商机类型:</font></td>
					<td colspan="1">
					<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"   />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right"><font color="red">销售产品/项目:</font></td>
					<td colspan="1">
					    <input class="nui-buttonedit" id="prdtName" name="prdtName" textname="itemName" onbuttonclick="selectItem" 
                            onenter="selectItem"  />
					</td>
					<td class="form_label" align="right">预计金额:</td>
					<td colspan="1">
					<input class="nui-textbox" name="prdtAmt" id="prdtAmt"    />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right"><font color="red">销售阶段:</font></td>
					<td colspan="1">
						<input class="nui-combobox" name="status" id="status" textField="name" valueField="id" value="1" data="statusList"  />
					</td>
					<td class="form_label" align="right">商机所有者:</td>
					<td colspan="1">
					 <input class="nui-combobox" id="chanceManId" name="chanceManId" value="" textField="empName" valueField="empId" onvaluechanged="onMTAdvisorIdChange(this.text)" required="true"/>
                     <input class="nui-textbox" id="chanceMan" name="chanceMan" visible="false" />
					</td>
				</tr>
				<tr>
					<td class="form_label" align="right"><font color="red">下次跟进时间:</font></td>
					<td colspan="1">
						 <input format="yyyy-MM-dd"   class="mini-datepicker"  allowInput="false" name="nextFollowDate" id = "nextFollowDate" value=""/>
					</td>
					<td class="form_label" align="right">预计成单日期:</td>
					<td colspan="1">
						<input format="yyyy-MM-dd"   class="mini-datepicker"  allowInput="false" name="planFinishDate" id = "planFinishDate" value=""/>
					</td>
				</tr>

					<tr>
					<td class="form_label" align="right">销售机会内容:</td>
					<td colspan="3"><input class="nui-TextArea" name="chanceContent"
						style=" height: 50px;width: 100%" /></td>
						
				</tr>
				<tr>
					<td class="form_label" align="right">备注:</td>
					<td colspan="3"><input class="nui-TextArea" name="remark"
						style=" height: 50px;width: 100%" /></td>
				</tr>

			</table>
		</div>

</body>
</html>
