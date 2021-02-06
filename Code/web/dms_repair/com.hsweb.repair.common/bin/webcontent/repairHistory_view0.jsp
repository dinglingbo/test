<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-04-10 18:05:10
  - Description:
-->
<head>
<title>维修历史</title>
<script src="<%=request.getContextPath()%>/commonRepair/js/repairHistory.js?v=1.2.0"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="orgId" visible="false"/>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
<div class="nui-panel" title="客户基本信息" borderStyle="border-bottom: 0; " style="width: 100%; ">
    <div id="guestInfoForm">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>客户名称：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="guestName" id="guestName" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>联系人：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="contactorName"/>
                </td>
                <td class="form_label">
                    <label>联系电话：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="mobile"/>
                </td>
                <td class="form_label">
                    <label>身份：</label>
                </td>
                <td>
                    <input class="nui-combobox"
                           name="identity"
                           id="identity"
                           valueField="customid"
                           textField="name"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>车牌号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="carNo"/>
                </td>
                <td class="form_label">
                    <label>品牌：</label>
                </td>
                <td>
                    <input class="nui-combobox" name="carBrandId" id="carBrandId"
                           textField="nameCn"
                           valueField="id"/>
                </td>
                <td class="form_label">
                    <label>品牌车型：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="carModel"/>
                </td>
                <td class="form_label">
                    <label>底盘号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="underpanNo"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>发动机号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="engineNo"/>
                </td>
                <td class="form_label">
                    <label>来厂次数：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="chainComeTimes"/>
                </td>
                <td class="form_label">
                    <label>客户备注：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" name="remark" style="width: 100%;"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" vertical="false" handlerSize="0" borderStyle="border:0;">
        <div size="300" showCollapseButton="false" style="border:0">
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid"
                     style="width: 100%; height: 100%;"
                     dataField="list"
                     pageSize="20"
                     selectOnLoad="true"
                     totalField="page.count"
                     borderStyle="border-right:0;"
                     sortMode="client"
                     allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="5">
                    <div property="columns">
                        <div field="orgid" headerAlign="center" allowSort="true" visible="true" header="分店名称"></div>
                        <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" header="维修工单号"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-panel" title="车辆维修信息" borderStyle="border-bottom: 0; " style="width: 100%; ">
                <div id="basicInfoForm">
                    <table class="nui-form-table">
                        <tr>
                            <td class="form_label">
                                <label>业务类型：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" name="serviceTypeId"
                                       valueField="customid" textField="name"
                                       id="serviceTypeId"/>
                            </td>
                            <td class="form_label">
                                <label>维修类型：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" name="mtType"
                                       valueField="customid" textField="name"
                                       id="mtType"/>
                            </td>
                            <td class="form_label">
                                <label>维修顾问：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" name="mtAdvisorId" id="mtAdvisorId"
                                       valueField="empId" textField="empName"
                                       allowInput="false"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>里程数：</label>
                            </td>
                            <td>
                                <input class="nui-Spinner"
                                       minValue="0" maxValue="100000000"
                                       inputStyle="align:right;"
                                       name="enterKilometers" allowNull="false"
                                       showButton="false"/>
                            </td>
                            <td class="form_label">
                                <label>进厂日期：</label>
                            </td>
                            <td>
                                <input name="enterDate" class="nui-datepicker" value="" nullValue="null"
                                       format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                            </td>
                            <td class="form_label">
                                <label>离厂日期：</label>
                            </td>
                            <td>
                                <input name="outDate" class="nui-datepicker" value="" nullValue="null"
                                       format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-fit">
                <div id="mainTabs" class="nui-tabs" activeIndex="0"
                     style="width: 100%; height: 100%;" plain="false" onactivechanged="">
                    <div title="估算项目/材料">
                        <div class="nui-splitter" style="width: 100%; height: 100%"
                             borderStyle="border:0;"
                             handlerSizel="0"
                             vertical="false" allowResize="false">
                            <div size="50%" showCollapseButton="false">
                                <div class="nui-fit">
                                    <div id="rpsItemQuoteGrid"
                                         borderStyle="border-right:0;"
                                         class="nui-datagrid"
                                         dataField="list"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                            <div field="receTypeId" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">收费类型
                                            </div>
                                            <div field="itemKind" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">工种
                                            </div>
                                            <div field="itemTime" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">工时
                                            </div>
                                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                            <div field="itemCode" headerAlign="center"
                                                 allowSort="true" visible="true" width="">项目编码
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div showCollapseButton="false" style="border:0;">
                                <div class="nui-fit">
                                    <div id="rpsPartQuoteGrid"
                                         dataField="list"
                                         class="nui-datagrid"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额小计</div>
                                            <div field="receTypeId" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">收费类型
                                            </div>
                                            <div field="qty" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">数量
                                            </div>
                                            <div field="unitPrice" headerAlign="center"
                                                 allowSort="true" visible="true" width="80">单价
                                            </div>
                                            <div field="partCode" headerAlign="center"
                                                 allowSort="true" visible="true" width="">零件编码
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="维修项目/材料">
                        <div class="nui-splitter" style="width: 100%; height: 100%"
                             borderStyle="border:0;"
                             handlerSize="6"
                             allowResize="false" vertical="false">
                            <div size="50%" showCollapseButton="false" style="border:0;">
                                <div class="nui-fit">
                                    <div id="rpsItemGrid"
                                         class="nui-datagrid"
                                         dataField="list"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                            <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                            <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                            <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                            <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                            <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
                                            <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
                                            <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div showCollapseButton="false" style="border:0;">
                                <div class="nui-fit">
                                    <div id="rpsPartGrid"
                                         dataField="list"
                                         class="nui-datagrid"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                            <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                            <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                                            <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                            <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="出单项目/材料">
                        <div class="nui-splitter" style="width: 100%; height: 100%"
                             borderStyle="border:0;"
                             handlerSize="6"
                             allowResize="false" vertical="false">
                            <div size="50%" showCollapseButton="false" style="border:0;">
                                <div class="nui-fit">
                                    <div id="rpsItemBillGrid"
                                         class="nui-datagrid"
                                         dataField="list"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                            <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                            <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                            <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                            <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div showCollapseButton="false" style="border:0;">
                                <div class="nui-fit">
                                    <div id="rpsPartBillGrid"
                                         dataField="list"
                                         class="nui-datagrid"
                                         style="width: 100%; height: 100%;"
                                         showPager="false"
                                         allowSortColumn="true">
                                        <div property="columns">
                                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                            <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                                            <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                            <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="辅料清单">
						<div id="auxiliaryGrid" dataField="list" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             showPager="false"
                             sortMode="client"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="partCode" headerAlign="center" allowSort="true"
                                     visible="true" width="">辅料编码
                                </div>
                                <div field="partName" headerAlign="center" allowSort="true"
                                     visible="true" width="">辅料名称
                                </div>
                                <div field="outQty" headerAlign="center" datatype="int" align="right"
                                     allowSort="true" visible="true" width="">数量
                                </div>
                                <div field="trueUnitPrice" headerAlign="center" datatype="float" align="right"
                                     allowSort="true" visible="true" width="">单价
                                </div>
                                <div field="trueCost" headerAlign="center" datatype="float" align="right"
                                     allowSort="true" visible="true" width="">金额
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="出车报告">
                        <div class="nui-fit">
                            <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport" style="width:100%;height:100%;"></textarea>
                        </div>
                    </div>
                    <div title="描述信息">
                        <table class="nui-form-table" style="width: 100%;">
                            <tr>
                                <td>
                                    <label>客户描述：</label>
                                </td>
                                <td>
                                    <label>故障现象：</label>
                                </td>
                                <td>
                                    <label>解决措施：</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <textarea class="nui-textarea" name="guestDesc" id="guestDesc" style="width:100%;height:150px;"></textarea>
                                </td>
                                <td>
                                    <textarea class="nui-textarea" name="faultPhen" id="faultPhen" style="width:100%;height:150px;"></textarea>
                                </td>
                                <td>
                                    <textarea class="nui-textarea" name="solveMethod" id="solveMethod" style="width:100%;height:150px;"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
