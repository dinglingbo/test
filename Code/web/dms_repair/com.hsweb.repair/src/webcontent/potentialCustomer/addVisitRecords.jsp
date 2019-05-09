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
<script src="<%= request.getContextPath() %>/repair/js/potentialCustomer/addVisitRecords.js?v=1.0.0"></script>
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
	width: 60px;
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

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-fit">
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;归档</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;精品加装</a>
                            <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
                            <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;转销售</a>
                            <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;客户档案</a>
                            <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-search fa-lg"></span>&nbsp;库存查询</a>
                        </td>
                    </tr>
                </table>
            </div>
	
	
	<div class="nui-panel" showToolbar="false"  showFooter="false"
						style="width:calc(100% - 20px);">
						<table class="nui-form-table" border=0>
							<tr>
								
								<td class="form_label">
									<label>单据编号：</label>
								</td>
								<td>
									<input class="nui-textbox" name="name" width="100%" maxlength="50" value="自动编号" enabled="false"/>
								</td>
								
								 <td class="form_label">
                                  <label >来访时间：</label>
                                </td>
                                <td>
                                     <input id="enterDate" name="enterDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
                               </td>
								
								<td class="form_label">
									<label>业务员：</label>
								</td>
								<td colspan="1">
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="100%"
			                             
			                            />
						     	</td>
							</tr>
							<tr>
							<td class="form_label">
							  <label>来访方式：</label>
								</td>
								<td colspan="1">
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="100%"
			                             
			                            />
						     	</td>
						     	<!-- <td class="form_label required">
									<label>意向级别：</label>
								</td>
								<td colspan="1">
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="85%"
			                             
			                            />
	                              <input id="contactorName"
			                         name="contactorName"
			                         class="nui-buttonedit"
			                         emptyText=""
			                         onbuttonclick="chooseContactor()"
			                         placeholder=""
			                         selectOnFocus="true" 
			                         allowInput="false"
			                         width="30px"
			                         />
						     	</td> -->
							<!-- <td class="form_label required">
									<label>项目类型：</label>
								</td>
								<td colspan="1">
								
									<input class="nui-combobox" name="type" id="type"
											valueField="customid"
											textField="name"
											valueFromSelect="true"
											allowInput="true"
											width="100%"/>
						     	</td>
								<td class="form_label required">
									<label>项目编码：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
								</td> -->
							<td class="form_label required">
								<label>客户名称：</label>
						    </td>
							<td colspan="1">
								<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
							</td>
							<td class="form_label">
								<label>客户性质：</label>
							</td>
							<td>
								<input class="nui-combobox" id="billTypeId" emptyText="个人客户" name="billTypeId" data="[{billTypeId:5,text:'个人客户'},{billTypeId:0,text:'单位客户'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/>
               
							</td>
							</tr>
							
							<tr>
							
							
							</tr>
							<tr>
								<td class="form_label">
									<label>联系人：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
								</td>
								<td class="form_label required">
									<label>手机号码：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
								</td>
								<td class="form_label">
									<label>联系电话：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<td class="form_label required">
									<label>意向车型：</label>
								</td>
								<td colspan="3">
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="100%"
			                             
			                            />
						     </td>
						     <td class="form_label">
									<label>车身颜色：</label>
								</td>
								<td colspan="1">
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="100%"
			                             
			                            />
						     </td>
						    </tr>
							<tr>
							<td class="form_label" align="right">车型配置:</td>
					        <td colspan="5"><input class="nui-TextArea" name="useRemark"
						       style="width: 98%; height: 50px;" /></td>
							</tr>
							<tr>
								<td class="form_label">
									<label>内饰颜色：</label>
								</td>
								<td colspan="1">
			                       <input name="serviceTypeId"
			                             id="serviceTypeId"
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
									<input class="nui-combobox" id="billTypeId" emptyText="是" name="billTypeId" data="[{billTypeId:1,text:'是'},{billTypeId:0,text:'否'}]"
                          width="98%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
               
						     </td>
						     <td class="form_label">
									<label>预算金额：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
								</td>
						    </tr>
					        <tr>
					            <td class="form_label"><label>关注重点：</label></td>
					            <td colspan="5">
					                <div id="important" name="important" class="nui-checkboxlist" repeatItems="15" 
					                repeatLayout="flow"  value="" 
					                textField="text" valueField="id" ></div>
					            </td>
					        </tr>
					        
					        <tr>
					            <td class="form_label"><label>意向级别：</label></td>
					            <td colspan="5">
					                <div id="levelOfIntent" name="levelOfIntent" class="nui-checkboxlist" repeatItems="15" 
					                repeatLayout="flow"  value="" 
					                textField="text" valueField="id" ></div>
					            </td>
					        </tr>
						    <tr>
							<td class="form_label" align="right">备注:</td>
					        <td colspan="5"><input class="nui-TextArea" name="useRemark"
						       style="width: 98%; height: 50px;" /></td>
							</tr>
						    <tr>
							<td class="form_label">
									<input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/><label>在</label>
								</td>
					        <td colspan="5">
					           <input id="enterDate" name="enterDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="30%"/>
                                 进行售前潜客回访
						       </td>
							</tr>
						</table>
					</div>
       </div>

</body>
</html>