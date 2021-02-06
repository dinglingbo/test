<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 09:57:49
  - Description:
-->
<head>
<title>索赔登记</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerClaim/subpage/ClaimRegister.js?v=1.0.4"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 60px;;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <a class="nui-button" iconCls="icon-save" onclick="save()" plain="true" id="saveBtn">保存</a>
    <a class="nui-button" iconCls="icon-ok" onclick="onOk()" plain="true" id="okBtn">过账</a>
    <a class="nui-button" iconCls="icon-no" onclick="onCancel()" plain="true">关闭</a>
</div>
<div class="nui-panel" showToolbar="false" title="基本信息" showFooter="false" style="width:100%;height:110px;">
    <div id="basicInfoForm">
        <input class="nui-hidden" name="id" id="id"/>
        <table>
            <tr>
                <td>
                    <label>索赔单号：</label>
                </td>
                <td>
                    <input class="nui-textbox" enabled="false" id="serviceCode" name="serviceCode"/>
                </td>
                <td>
                    <label>索赔类型：</label>
                </td>
                <td>
                    <input class="nui-combobox" id="claimsType"
                           valueField="customid" textField="name"
                           name="claimsType"/>
                </td>
                <td>
                    <label>业务单号：</label>
                </td>
                <td colspan="3">
                    <input class="nui-buttonedit" name="serviceId" id="serviceId"
                           allowInput="false"
                           onbuttonclick="repairCustomer()" style="width: 100%"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>车牌号：</label>
                </td>
                <td>
                    <input class="nui-textbox" enabled="false" name="carNo" id="carNo"/>
                </td>
                <td>
                    <label>车辆厂牌：</label>
                </td>
                <td>
                    <input class="nui-combobox" enabled="false"
                           valueField="id" textField="nameCn"
                           name="carBrandId" id="carBrandId"/>
                </td>
                <td>
                    <label>品牌车型：</label>
                </td>
                <td>
                    <input class="nui-textbox" enabled="false" name="carModel" id="carModel"/>
                </td>
                <td>
                    <label>维修顾问：</label>
                </td>
                <td>
                    <input class="nui-textbox" enabled="false" name="mtAdvisor" id="mtAdvisor"/>
                </td>
                <td>
                    <label>联系人：</label>
                </td>
                <td>
                    <input class="nui-textbox" enabled="false" name="contactorName" id="contactorName"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="mainTabs" class="nui-tabs" activeIndex="0"
         style="width:100%; height:100%;" plain="false">
        <div title="索赔描述">
            <table style="width: 100%;">
                <tr>
                    <td class="form_label">
                        <label>客户描述：</label>
                    </td>
                    <td>
                        <input class="nui-textarea" style="width: 100%;height: 150px;" id="clientDescription"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>处理描述：</label>
                    </td>
                    <td>
                        <input class="nui-textarea" style="width: 100%;height: 150px;" id="processDescription"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>防范措施：</label>
                    </td>
                    <td>
                        <input class="nui-textarea" style="width: 100%;height: 150px;" id="precautions"/>
                    </td>
                </tr>
            </table>
        </div>
        <div title="索赔项目">
            <div class="nui-splitter" style="width:100%;height:100%;" vertical="true"
                 borderStyle="border:0;"
                 allowResize="false">
                <div size="50%" showCollapseButton="false" style="border: 0;">
                    <div class="nui-fit">
                        <div id="rpsItemGrid"
                             dataField="list"
                             class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">
                                    项目名称
                                </div>
                                <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">
                                    收费类型
                                </div>
                                <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">
                                    工种
                                </div>
                                <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80"
                                     datatype="float" align="right">工时
                                </div>
                                <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80"
                                     datatype="float" align="right">金额小计
                                </div>
                                <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">
                                    班组
                                </div>
                                <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">
                                    承修人
                                </div>
                                <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">
                                    项目编码
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false">
                    <div class="nui-toolbar" style="border-bottom: 0;border-top: 0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" iconCls="icon-ok" onclick="addItem()" plain="true">选择索赔</a>
                                    <a class="nui-button" iconCls="icon-remove" onclick="delItem()" plain="true">删除</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="claimsItemGrid" dataField="list" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="itemName" headerAlign="center" allowSort="true"
                                     visible="true" width="160px">项目名称
                                </div>
                                <div field="itemKind" headerAlign="center"
                                     allowSort="true" visible="true">工种
                                </div>
                                <div field="className" headerAlign="center"
                                     allowSort="true" visible="true" width="80px">班组
                                </div>
                                <div field="worker" headerAlign="center"
                                     allowSort="true" visible="true">主修人
                                </div>
                                <div field="amt" headerAlign="center"
                                     allowSort="true" visible="true" width="90px">金额
                                </div>
                                <div field="remark" headerAlign="center"
                                     allowSort="true" visible="true" width="150px">备注
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div title="索赔配件">
            <div class="nui-splitter" style="width:100%;height:100%;" vertical="true"
                 borderStyle="border:0;"
                 allowResize="false">
                <div size="50%" showCollapseButton="false" style="border: 0;">
                    <div class="nui-fit">
                        <div id="rpsPartGrid" dataField="list" class="nui-datagrid"
                             sortMode="client" showPager="false"
                             style="width: 100%; height: 100%;"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">
                                    零件名称
                                </div>
                                <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">
                                    收费类型
                                </div>
                                <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80"
                                     datatype="int" align="right">数量
                                </div>
                                <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80"
                                     datatype="float" align="right">单价
                                </div>
                                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80"
                                     datatype="float" align="right">金额
                                </div>
                                <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">
                                    零件编码
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false">
                    <div class="nui-toolbar" style="border-bottom: 0;border-top: 0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" iconCls="icon-ok" onclick="addPart()" plain="true">选择索赔</a>
                                    <a class="nui-button" iconCls="icon-remove" onclick="delPart()" plain="true">删除</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="claimsPartGrid" dataField="list" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="partName" headerAlign="center" allowSort="true"
                                     visible="true" width="160px">零件名称
                                </div>
                                <div field="qty" headerAlign="center" allowSort="true" visible="true" width="70px">数量
                                </div>
                                <div field="unitPrice" headerAlign="center" allowSort="true" visible="true"
                                     width="80px">单价
                                </div>
                                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="100px">金额
                                </div>
                                <div field="remark" headerAlign="center" allowSort="true" visible="true" width="150px">
                                    备注
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</html>