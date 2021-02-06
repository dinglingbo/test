<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-04-24 11:24:42
  - Description:
-->
<head>
<title>客户索赔</title>
<script src="<%=request.getContextPath()%>/repair/js/claimsReturnPart.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 60px;
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
    <div class="nui-form1" id="queryInfoForm">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
                    <label style="font-family:Verdana;">索赔日期 从：</label>
                </td>
                <td>
                    <input class="nui-datepicker" format="yyyy-MM-dd"/>
                </td>
                <td>
                    <label style="font-family:Verdana;">至：</label>
                </td>
                <td>
                    <input class="nui-datepicker" format="yyyy-MM-dd"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存</a>
                <a class="nui-button" plain="true" iconCls="icon-ok" onclick="doReturn()">过账</a>
                <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;"
         borderStyle="border-top:0;"
         allowResize="false">
        <div size="300" showCollapseButton="false" style="border:0;">
            <div id="leftGrid" dataField="list" class="nui-datagrid"
                 style="width: 100%; height: 100%;"
                 pageSize="20"
                 totalField="page.count"
                 sortMode="client"
                 selectOnLoad="true"
                 allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="4">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" allowSort="false"
                         visible="true" width="30px">序号
                    </div>
                    <div header="基本信息" headerAlign="center">
                        <div property="columns">
                            <div field="carNo" headerAlign="center" allowSort="true"
                                 visible="true" width="80">车牌号
                            </div>
                            <div field="maintainServiceCode" headerAlign="center" allowSort="true"
                                 visible="true" width="">工单号
                            </div>
                            <div field="serviceCode" headerAlign="center" allowSort="true"
                                 visible="true" width="">索赔单号
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div  class="nui-panel" showToolbar="false" title="基本信息" showFooter="false" style="width:100%;height:100px;">
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
                                       valueField="customid" textField="name" enabled="false"
                                       name="claimsType"/>
                            </td>
                            <td>
                                <label>业务单号：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-buttonedit"  name="serviceId" id="serviceId"
                                       allowInput="false" enabled="false"
                                       onbuttonclick="repairCustomer()"/>
                            </td>
                            <td>
                                <label>维修顾问：</label>
                            </td>
                            <td>
                                <input class="nui-textbox"  enabled="false" name="mtAdvisor" id="mtAdvisor"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>车牌号：</label>
                            </td>
                            <td>
                                <input class="nui-textbox"   enabled="false" name="carNo" id="carNo"/>
                            </td>
                            <td>
                                <label>车辆厂牌：</label>
                            </td>
                            <td>
                                <input class="nui-combobox"  enabled="false"
                                       valueField="id" textField="nameCn"
                                       name="carBrandId" id="carBrandId"/>
                            </td>
                            <td>
                                <label>品牌车型：</label>
                            </td>
                            <td>
                                <input class="nui-textbox"  enabled="false" name="carModel" id="carModel"/>
                            </td>

                            <td >
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
                    <div title="配件出库">
                        <div  class="nui-splitter" style="width:100%;height:100%;" vertical="true"
                              borderStyle="border:0;"
                              allowResize="false">
                            <div size="50%" showCollapseButton="false" style="border: 0;">
                                <div class="nui-fit">
                                    <div id="repairOutGrid"
                                         dataField="list"
                                         class="nui-datagrid"
                                         style="width: 100%; height: 100%;"
                                         sortMode="client" showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div header="配件信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="partCode" headerAlign="center" allowSort="true" width="">配件编码</div>
                                                    <div field="partName" headerAlign="center" allowSort="true" width="">配件名称</div>
                                                    <div field="unit" headerAlign="center" allowSort="true" width="100px">单位</div>
                                                    <div field="outQty" headerAlign="center" allowSort="true" width="100px" datatype="int" align="right">数量</div>
                                                    <div field="stockLocation" headerAlign="center" allowSort="true" width="100px">仓位</div>
                                                </div>
                                            </div>
                                            <div header="成本信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="trueUnitPrice" headerAlign="center" allowSort="true" width="" datatype="float" align="right">单价</div>
                                                    <div field="trueCost" headerAlign="center" allowSort="true" width="" datatype="float" align="right">金额</div>
                                                </div>
                                            </div>
                                            <div header="销售信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="sellUnitPrice" headerAlign="center" allowSort="true" width="" datatype="float" align="right">单价</div>
                                                    <div field="sellAmt" headerAlign="center" allowSort="true" width="" datatype="float" align="right">金额</div>
                                                </div>
                                            </div>
                                            <div header="利润信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="grossProfit" headerAlign="center" allowSort="true" width="" datatype="float" align="right">毛利</div>
                                                </div>
                                            </div>
                                            <div header="领料信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="pickMan" headerAlign="center" allowSort="true" width="">领料人</div>
                                                    <div field="pickDate" headerAlign="center" allowSort="true" width="" dateFormat="yyyy-MM-dd">领料日期</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div showCollapseButton="false">
                                <div class="nui-toolbar"  style="border-bottom: 0;border-top: 0;">
                                    <table>
                                        <tr>
                                            <td>
                                                <a class="nui-button" iconCls="icon-ok" onclick="addClaimsRepariOut()" plain="true">选中归库</a>
                                                <a class="nui-button" iconCls="icon-remove" onclick="delClaimsRepariOut()" plain="true">删除</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-fit">
                                    <div id="claimsRepairOutGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                                         sortMode="client" showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div header="索赔归库配件" headerAlign="center">
                                                <div property="columns">
                                                    <div  field="id" headerAlign="center" allowSort="true" visible="true" width="70px">内码</div>
                                                    <div  field="partCode" headerAlign="center" allowSort="true"
                                                          visible="true" width="160px">配件编码</div>
                                                    <div  field="partName" headerAlign="center" allowSort="true"
                                                          visible="true" width="160px">配件名称</div>
                                                    <div  field="qty" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="int" align="right">数量</div>
                                                    <div  field="unit" headerAlign="center" allowSort="true" visible="true" width="70px">单位</div>
                                                    <div  field="costPrice" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">成本单价</div>
                                                    <div  field="costAmt" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">成本金额</div>
                                                    <div  field="sellPrice" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">销售单价</div>
                                                    <div  field="sellAmt" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">销售金额</div>
                                                </div>
                                            </div>
                                            <div header="退回信息" headerAlign="center">
                                                <div property="columns">
                                                    <div  field="backPrice" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">退回单价</div>
                                                    <div  field="backAmt" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">退回金额</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="索赔描述" >
                        <table style="width: 100%;">
                            <tr>
                                <td class="form_label">
                                    <label>客户描述：</label>
                                </td>
                                <td>
                                    <input class="nui-textarea" style="width: 100%;height: 120px;" id="clientDescription"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>处理描述：</label>
                                </td>
                                <td>
                                    <input class="nui-textarea" style="width: 100%;height: 120px;" id="processDescription"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>防范措施：</label>
                                </td>
                                <td>
                                    <input class="nui-textarea" style="width: 100%;height: 120px;" id="precautions"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div title="索赔项目" >
                        <div id="claimsItemGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="itemName" headerAlign="center" allowSort="true"
                                     visible="true" width="160px">项目名称</div>
                                <div field="itemKind" headerAlign="center"
                                     allowSort="true" visible="true">工种</div>
                                <div  field="className" headerAlign="center"
                                      allowSort="true" visible="true" width="80px">班组</div>
                                <div  field="worker" headerAlign="center"
                                      allowSort="true" visible="true">主修人</div>
                                <div  field="amt" headerAlign="center"
                                      allowSort="true" visible="true" width="90px" datatype="float" align="right">金额</div>
                                <div  field="remark" headerAlign="center"
                                      allowSort="true" visible="true" width="150px">备注</div>
                            </div>
                        </div>
                    </div>
                    <div title="索赔配件" >
                        <div id="claimsPartGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div  field="partName" headerAlign="center" allowSort="true"
                                      visible="true" width="160px">零件名称</div>
                                <div  field="qty" headerAlign="center" allowSort="true" visible="true" width="70px" datatype="int" align="right">数量</div>
                                <div  field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80px" datatype="float" align="right">单价</div>
                                <div  field="amt" headerAlign="center" allowSort="true" visible="true" width="100px" datatype="float" align="right">金额</div>
                                <div  field="remark" headerAlign="center" allowSort="true" visible="true" width="150px">备注</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
