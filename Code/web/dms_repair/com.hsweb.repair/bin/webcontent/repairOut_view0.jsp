<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-31 18:09:37
  - Description:
-->
<head>
<title>维修出库</title>
<script src="<%=request.getContextPath()%>/repair/js/repairOut/repairOut.js?v=1.0.10"></script>
<style type="text/css">

.form_label {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" plain="true" onclick="quickSearch(2)" id="type2">在修的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(3)" id="type3">已总检的车</a>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">车牌号：</label>
                    <input class="nui-textbox" name="id">
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-reload" plain="true" onclick="reloadLeftGrid()" enabled="true">刷新</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="audit()" enabled="false" id="auditBtn">领料审核</a>
                <a class="nui-button" iconCls="icon-undo" plain="true" onclick="antiAudit()" enabled="false" id="antiAuditBtn">领料反审核</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%;height:100%;"
         borderStyle="border:0;"
         allowResize="false">
        <div size="300" showCollapseButton="false" style="border:0;">
            <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 dataField="list"
                 pageSize="20"
                 showPageInfo="true"
                 multiSelect="true"
                 showPageIndex="true"
                 showPage="true"
                 showPageSize="false"
                 selectOnLoad="true"
                 showReloadButton="false"
                 showPagerButtonIcon="true"
                 totalField="page.count"
                 allowSortColumn="true">
                <div property="columns">
                    <div field="carNo" width="60" headerAlign="center" allowSort="true">车牌号</div>
                    <div field="status" width="70" headerAlign="center" allowSort="true">单据状态</div>
                    <div field="serviceCode" width="" allowSort="true" headerAlign="center" allowSort="true">工单号</div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;">
                <div title="基本信息" showCloseButton="false">
                    <div id="panel1" class="nui-panel" title="维修信息" iconCls="" style="width:100%;"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="basicInfoForm" >
                            <input name="id" class="nui-hidden" />
                            <input name="carNo" class="nui-hidden" />
                            <input name="serviceCode" class="nui-hidden" />
                            <input name="status" class="nui-hidden" />
                            <input name="partAuditSign" class="nui-hidden" />
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
                                        <input class="nui-textbox" name="mtAdvisorId" id="mtAdvisorId"
                                               allowInput="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>油量：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="enterOilMass"
                                               valueField="customid" textField="name"
                                               id="enterOilMass" allowInput="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>里程数：</label>
                                    </td>
                                    <td>
                                        <input class="nui-Spinner"
                                               minValue="0" maxValue="100000000"
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
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>报价日期：</label>
                                    </td>
                                    <td>
                                        <input name="quoteDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
                                               nullValue="null" timeFormat="HH:mm:ss" showTime="true"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>预计交车：</label>
                                    </td>
                                    <td>
                                        <input name="planFinishDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
                                               nullValue="null" timeFormat="HH:mm:ss" showTime="true"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>维修日期：</label>
                                    </td>
                                    <td>
                                        <input name="sureMtDate" class="nui-datepicker" enabled="false" format="yyyy-MM-dd"
                                               timeFormat="HH:mm:ss" showTime="false"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>品牌车型：</label>
                                    </td>
                                    <td colspan="1">
                                        <input class="nui-textbox" name="carModel" enabled="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>底盘号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="carVin" enabled="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>发动机号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="engineNo" enabled="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>完工日期：</label>
                                    </td>
                                    <td>
                                        <input name="checkDate" class="nui-datepicker" enabled="false"
                                               format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>备注：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" name="remark" style="width: 100%;"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="nui-fit">
                        <div id="panel2" class="nui-panel" title="描述信息" iconCls=""
                             style="width:100%;height:100%;"
                             borderStyle="border-top:0"
                             bodyStyle="padding:0"
                             showToolbar="false" showCollapseButton="false" showFooter="true" allowResize="false" collapseOnTitleClick="false">
                            <div class="nui-splitter" style="width:100%;height:100%;"
                                 borderStyle="border:0;"
                                 allowResize="false">
                                <div size="220" showCollapseButton="false" style="border:0;overflow:auto;">
                                    <div id="queryInfoForm">
                                        <table>
                                            <tr>
                                                <td>
                                                    <label>仓库：</label>
                                                </td>
                                                <td>
                                                    <input name="storeId"
                                                           id="storeId"
                                                           showNullItem="false"
                                                           class="nui-combobox"
                                                           textField="name"
                                                           valueField="id" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>尾号：</label>
                                                </td>
                                                <td>
                                                    <input id=""  name="endOfCode"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>采购单号：</label>
                                                </td>
                                                <td>
                                                    <input name="enterCode"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>编码：</label>
                                                </td>
                                                <td>
                                                    <input name="partCode"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>名称：</label>
                                                </td>
                                                <td>
                                                    <input name="name"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>仓位：</label>
                                                </td>
                                                <td>
                                                    <input name="storeLocation"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>拼音：</label>
                                                </td>
                                                <td>
                                                    <input name="py"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>品牌：</label>
                                                </td>
                                                <td>
                                                    <input id="carBrand"
                                                           name="carBrand"
                                                           class="nui-combobox width1"
                                                           textField="carBrandZh"
                                                           valueField="id"
                                                           emptyText="请选择..."
                                                           url=""
                                                           allowInput="false"
                                                           showNullItem="true"
                                                           nullItemText="请选择..."/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>品牌车型：</label>
                                                </td>
                                                <td>
                                                    <input name="carModel"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>备注：</label>
                                                </td>
                                                <td>
                                                    <input name="remark"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>编码列表：</label>
                                                </td>
                                                <td>
                                                    <input name="username"
                                                           class="nui-textbox"  />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div showCollapseButton="false" style="border:0;">
                                    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                         showPager="true"
                                         totalField="page.count"
                                         pageSize="20"
                                         dataField="list"
                                         borderStyle="border-top:0;border-right:0;border-bottom:0"
                                         frozenStartColumn="0"
                                         frozenEndColumn="6">
                                        <div property="columns">
                                            <div type="indexcolumn">序号</div>
                                            <div header="配件基本信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="partId" width="50" header="内码" headerAlign="center"></div>
                                                    <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                                    <div field="outableQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                                    <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                                    <div field="price" width="60" allowSort="true" header="入库单价" headerAlign="center" align="center"></div>
                                                    <div field="suggestPrice" width="60" allowSort="true" header="建议售价" headerAlign="center" align="center"></div>
                                                </div>
                                            </div>
                                            <div header="配件辅助信息" headerAlign="center">
                                                <div property="columns">
                                                    <div field="qualityTypeId" width="120" header="品质" headerAlign="center"></div>
                                                    <div field="partBrandId" width="100" header="品牌" headerAlign="center"></div>
                                                    <div field="guestFullName" width="100" allowSort="true" header="供应商" headerAlign="center"></div>
                                                    <div field="storeLocation" width="100" header="仓位"></div>
                                                    <div field="applyCarModel" width="100" allowSort="true" header="品牌车型" headerAlign="center"></div>
                                                    <div field="partTypeId" width="100" allowSort="true" header="类别" headerAlign="center"></div>
                                                    <div field="produceFactory" width="100" allowSort="true" header="生产厂家" headerAlign="center"></div>
                                                    <div field="detailRemark" width="100" allowSort="true" header="入库分配" headerAlign="center"></div>
                                                    <div field="commonCode" width="100" allowSort="true" header="通用编码" headerAlign="center"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--footer-->
                            <div property="footer">
                                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch2(0)">查询</a>
                                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch2(1)">今日入库</a>
                                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch2(2)">本车订购</a>
                                <label>领料人：</label>
                                <input name="pickMan"
                                       id="pickMan"
                                       nullItemText="请选择..."
                                       emptyText="请选择..."
                                       showNullItem="true"
                                       class="nui-combobox"
                                       valueField="empName" textField="empName"/>
                                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="repairOut()" enabled="true" id="selectOut">选择出库</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="成本/销售清单" iconCls="" showCloseButton="false">
                    <div id="panel3" class="nui-panel" title="" iconCls="" style="margin-bottom:3px;width:100%;height:calc(40% - 3px);"
                         showHeader="false"
                         bodyStyle="padding:0"
                         borderStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="rightGrid1" class="nui-datagrid"
                             style="width:100%;height:100%;"
                             showPager="true"
                             dataField="list"
                             idField="id"
                             totalField="page.count"
                             pageSize="20"
                             frozenStartColumn="0"
                             frozenEndColumn="1"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div header="" headerAlign="center">
                                    <div property="columns">
                                        <div field="action" width="60" headerAlign="center" header="退回"></div>
                                    </div>
                                </div>
                                <div header="零件信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                        <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                        <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                        <div field="outQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                        <div field="stockLocation" width="100" header="仓位" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="成本信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="trueUnitPrice" width="80" headerAlign="center" header="单价"></div>
                                        <div field="trueCost" width="80" headerAlign="center" header="金额"></div>
                                    </div>
                                </div>
                                <div header="销售信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="sellUnitPrice" width="80" headerAlign="center" header="销售单价"></div>
                                        <div field="sellAmt" width="80" headerAlign="center" header="销售金额"></div>
                                    </div>
                                </div>
                                <div header="利润信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="grossProfit" width="80" header="毛利" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="领料信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="pickMan" width="120" header="领料人" headerAlign="center"></div>
                                        <div field="pickDate" width="100" header="领料日期" headerAlign="center" dateFormat="yyyy-MM-dd"></div>
                                        <div field="remark" width="100" allowSort="true" header="备注" headerAlign="center"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="panel4" class="nui-panel" title="" iconCls="" style="width:100%;height:60%;"
                         showHeader="false"
                         bodyStyle="padding:0"
                         borderStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="true" allowResize="false" collapseOnTitleClick="false">
                        <div id="rpsPartGrid"
                             dataField="list"
                             class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">配件编码</div>
                                <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">配件名称</div>
                                <div field="status" headerAlign="center" allowSort="true" visible="true" width="80">状态</div>
                                <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80">数量</div>
                                <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80">单价</div>
                                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额</div>
                            </div>
                        </div>
                        <!--footer-->
                        <div property="footer">
                            <a class="nui-button" iconCls="icon-add" plain="true" onclick="onAddMaterial()">添加</a>
                            <a class="nui-button" iconCls="icon-edit" plain="true" onclick="onEditMaterial()">修改</a>
                            <a class="nui-button" iconCls="icon-remove" plain="true" onclick="onDeleteMaterial()">删除</a>
                        </div>
                    </div>
                </div>
                <div title="估算材料/维修项目" showCloseButton="false">
                    <div id="panel5" class="nui-panel" title="估算材料" iconCls="" style="width:100%;height:50%;"
                         showHeader="true"
                         bodyStyle="padding:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="rpsPartQuoteGrid"
                             borderStyle="border:0;"
                             dataField="list"
                             class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                <div field="partCode" headerAlign="center"
                                     allowSort="true" visible="true" width="">零件编码
                                </div>
                                <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                <div field="status" headerAlign="center"
                                     allowSort="true" visible="true" width="80">状态
                                </div>
                                <div field="qty" headerAlign="center"
                                     allowSort="true" visible="true" width="80">数量
                                </div>
                                <div field="unitPrice" headerAlign="center"
                                     allowSort="true" visible="true" width="80">单价
                                </div>
                                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额</div>
                            </div>
                        </div>
                    </div>
                    <div id="panel6" class="nui-panel" title="维修项目" iconCls="" style="width:100%;height:50%;"
                         showHeader="true"
                         bodyStyle="padding:0"
                         borderStyle="border-top:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="itemGrid" dataField="list" class="nui-datagrid" style="width: 100%; height:100%;"
                             showPager="false"
                             allowRowSelect="true"
                             multiSelect="true"
                             borderStyle="border:0"
                             allowSortColumn="true">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="itemCode" width="80" header="项目编码" headerAlign="center"></div>
                                <div field="itemName" headerAlign="center" allowSort="true" visible="true"
                                     width="100">项目名称
                                </div>
                                <div field="status" headerAlign="center" allowSort="true" visible="true">状态
                                </div>
                                <div field="itemKind" headerAlign="center" allowSort="true" visible="true">工种
                                </div>
                                <div field="itemTime" headerAlign="center" allowSort="true" visible="true">工时
                                </div>
                                <div field="amt" width="60" allowSort="true" header="金额小计" headerAlign="center" align="center"></div>
                                <div field="className" headerAlign="center" allowSort="true" visible="true">班组
                                </div>
                                <div field="worker" headerAlign="center" allowSort="true" visible="true">承修人
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="辅料清单" showCloseButton="false" enabled="true">
                    <div id="rightGrid5" class="nui-datagrid" style="width:100%;height:100%;"
                         showPager="false"
                         frozenStartColumn="0"
                         frozenEndColumn="0"
                         url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div field="partCode" width="80" header="辅料编码" headerAlign="center"></div>
                            <div field="partName" width="80" header="辅料名称" headerAlign="center"></div>
                            <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                            <div field="noTaxUnitPrice" width="60" allowSort="true" header="单价" headerAlign="center" align="center"></div>
                            <div field="partCode" width="80" header="金额" headerAlign="center"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
