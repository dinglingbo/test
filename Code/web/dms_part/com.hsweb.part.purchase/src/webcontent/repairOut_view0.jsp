<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-07 16:38:09
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchasePart/js/repairMgr/repairOut.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
}

.mini-panel-body {
	padding: 0;
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
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(14)" id="type0">在修的车</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(15)" id="type2">已总检的车</a>
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
                <a class="nui-button" iconCls="icon-reload" plain="true" onclick="refresh()" enabled="true">刷新</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="false" id="reViewBtn">领料审核</a>
                <a class="nui-button" iconCls="icon-undo" plain="true" onclick="review2()" enabled="false" id="reView2Btn">领料反审核</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
        <div size="260" showCollapseButton="false" style="border:0;">
            <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 url="">
                <div property="columns">
                    <!--<div type="indexcolumn"></div>-->
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">车牌号</div>
                    <div field="position_name" width="70" headerAlign="center" allowSort="true">单据状态</div>
                    <div field="salary" width="" allowSort="true" headerAlign="center" allowSort="true">工单号</div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;"
                 bodyStyle="border:0">
                <div title="基本信息" showCloseButton="false">
                    <div id="panel1" class="nui-panel" title="维修信息" iconCls="" style="width:100%;height:170px;"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="basicInfoForm" >
                            <input name="id" class="nui-hidden" />
                            <table>
                                <tr>
                                    <td>
                                        <label>业务类型：</label>
                                    </td>
                                    <td>
                                        <input name="Country"
                                               showNullItem="true"
                                               class="nui-combobox"
                                               url=""
                                               enabled="false"
                                               textField="text"
                                               valueField="id" />
                                    </td>
                                    <td>
                                        <label>维修类型：</label>
                                    </td>
                                    <td>
                                        <input name="Country"
                                               showNullItem="true"
                                               class="nui-combobox"
                                               url=""
                                               enabled="false"
                                               textField="text"
                                               valueField="id" />
                                    </td>
                                    <td>
                                        <label>维修顾问：</label>
                                    </td>
                                    <td>
                                        <input id="textbox3"
                                               enabled="false"
                                               name="username" class="nui-textbox"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>油量：</label>
                                    </td>
                                    <td>
                                        <input name="Country"
                                               showNullItem="true"
                                               class="nui-combobox"
                                               url=""
                                               enabled="false"
                                               textField="text"
                                               valueField="id" />
                                    </td>
                                    <td>
                                        <label>里程数：</label>
                                    </td>
                                    <td>
                                        <input id="textbox2"  name="username"
                                               enabled="false"
                                               class="nui-textbox"  />
                                    </td>
                                    <td>
                                        <label>进厂日期：</label>
                                    </td>
                                    <td>
                                        <input id="date2" name="BirthDay"
                                               enabled="false"
                                               class="nui-datepicker" value="2010-10-12"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>报价日期：</label>
                                    </td>
                                    <td>
                                        <input id="date3" name="BirthDay"
                                               enabled="false"
                                               class="nui-datepicker" value="2010-10-12"  />
                                    </td>
                                    <td>
                                        <label>预计交车：</label>
                                    </td>
                                    <td>
                                        <input id="date4" name="BirthDay"
                                               enabled="false"
                                               class="nui-datepicker" value="2010-10-12"  />
                                    </td>
                                    <td>
                                        <label>维修日期：</label>
                                    </td>
                                    <td>
                                        <input id="date5" name="BirthDay"
                                               enabled="false"
                                               class="nui-datepicker" value="2010-10-12"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>车型：</label>
                                    </td>
                                    <td>
                                        <input id="textbox4"
                                               enabled="false"
                                               name="username" class="nui-textbox"  />
                                    </td>
                                    <td>
                                        <label>底盘号：</label>
                                    </td>
                                    <td>
                                        <input id="textbox5"
                                               enabled="false"
                                               name="username" class="nui-textbox"  />
                                    </td>
                                    <td>
                                        <label>发动机号：</label>
                                    </td>
                                    <td>
                                        <input id="textbox6"
                                               enabled="false"
                                               name="username" class="nui-textbox"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>完工日期：</label>
                                    </td>
                                    <td>
                                        <input id="date6" name="BirthDay"
                                               enabled="false"
                                               class="nui-datepicker" value="2010-10-12"  />
                                    </td>
                                    <td>
                                        <label>备注：</label>
                                    </td>
                                    <td colspan="3">
                                        <input id="textbox1"  name="username"
                                               enabled="false"
                                               class="nui-textbox"  width="100%"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="panel2" class="nui-panel" title="描述信息" iconCls="" style="width:100%;height:380px;border:0;"
                         showToolbar="false" showCollapseButton="false" showFooter="true" allowResize="false" collapseOnTitleClick="false">
                        <div class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
                            <div size="200" showCollapseButton="false" style="border:0;">
                                <div id="queryInfoForm" >
                                    <table>
                                        <tr>
                                            <td>
                                                <label>仓库：</label>
                                            </td>
                                            <td>
                                                <input name="storeId"
                                                       id="storeId"
                                                       showNullItem="true"
                                                       class="nui-combobox"
                                                       url=""
                                                       textField="text"
                                                       valueField="id" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>尾号：</label>
                                            </td>
                                            <td>
                                                <input id=""  name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>采购单号：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>编码：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>名称：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>仓位：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>拼音：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>品牌：</label>
                                            </td>
                                            <td>
                                                <input name="carBrandId"
                                                       id="carBrandId"
                                                       showNullItem="true"
                                                       class="nui-combobox"
                                                       url=""
                                                       textField="text"
                                                       valueField="id" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>车型：</label>
                                            </td>
                                            <td>
                                                <input name="username"
                                                       class="nui-textbox"  />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label>备注：</label>
                                            </td>
                                            <td>
                                                <input name="username"
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
                                     showPager="false"
                                     frozenStartColumn="0"
                                     frozenEndColumn="6"
                                     url="">
                                    <div property="columns">
                                        <div type="indexcolumn">序号</div>
                                        <div header="配件基本信息" headerAlign="center">
                                            <div property="columns">
                                                <div field="partId" width="80" header="内码" headerAlign="center"></div>
                                                <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                                <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                                <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="入库单价" headerAlign="center" align="center"></div>
                                                <div field="suggestPrice" width="60" allowSort="true" header="建议售价" headerAlign="center" align="center"></div>
                                            </div>
                                        </div>
                                        <div header="配件辅助信息" headerAlign="center">
                                            <div property="columns">
                                                <div field="qualityTypeId" width="120" header="品质" headerAlign="center"></div>
                                                <div field="partBrandId" width="100" header="品牌" headerAlign="center"></div>
                                                <div field="guestFullName" width="100" allowSort="true" header="供应商" headerAlign="center"></div>
                                                <div field="stockLocation" width="100" header="仓位"></div>
                                                <div field="applyCarModel" width="100" allowSort="true" header="车型" headerAlign="center"></div>
                                                <div field="applyCarModel" width="100" allowSort="true" header="类别" headerAlign="center"></div>
                                                <div field="suggestPrice" width="100" allowSort="true" header="生产厂家" headerAlign="center"></div>
                                                <div field="remark" width="100" allowSort="true" header="入库分配" headerAlign="center"></div>
                                                <div field="suggestPrice" width="100" allowSort="true" header="通用编码" headerAlign="center"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--footer-->
                        <div property="footer">
                            <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch1()">查询</a>
                            <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch1()">今日入库</a>
                            <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch1()">本车订购</a>
                            <label>领料人：</label>
                            <input name="storeId"
                                   id="aa"
                                   showNullItem="true"
                                   class="nui-combobox"
                                   url=""
                                   textField="text"
                                   valueField="id" />
                            <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="true">选择出库</a>
                        </div>
                    </div>
                </div>
                <div title="成本/销售清单" iconCls="" showCloseButton="false">
                    <div id="panel3" class="nui-panel" title="" iconCls="" style="margin-bottom:3px;width:100%;height:calc(40% - 3px);"
                         showHeader="false"
                         bodyStyle="border:0"
                         headerStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="rightGrid1" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="6"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div header="操作" headerAlign="center">
                                    <div property="columns">
                                        <div field="partId" width="80" header="" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="配件基本信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                        <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                        <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                        <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                        <div field="stockLocation" width="100" header="仓位"></div>
                                    </div>
                                </div>
                                <div header="成本信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="noTaxUnitPrice" width="80" header="单价" headerAlign="center"></div>
                                        <div field="noTaxAmt" width="80" header="金额" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="销售信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="sellUnitPrice" width="80" header="销售单价" headerAlign="center"></div>
                                        <div field="sellAmt" width="80" header="销售金额" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="利润信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="sellUnitPrice" width="80" header="毛利" headerAlign="center"></div>
                                    </div>
                                </div>
                                <div header="领料信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="qualityTypeId" width="120" header="领料人" headerAlign="center"></div>
                                        <div field="partBrandId" width="100" header="领料日期" headerAlign="center"></div>
                                        <div field="guestFullName" width="100" allowSort="true" header="备注" headerAlign="center"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="panel4" class="nui-panel" title="" iconCls="" style="width:100%;height:60%;"
                         showHeader="false"
                         bodyStyle="border:0"
                         headerStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="true" allowResize="false" collapseOnTitleClick="false">
                        <div id="rightGrid2" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="6"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                <div field="partCode" width="80" header="状态" headerAlign="center"></div>
                                <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="单价" headerAlign="center" align="center"></div>
                                <div field="noTaxAmt" width="60" allowSort="true" header="金额" headerAlign="center" align="center"></div>
                            </div>
                        </div>
                        <!--footer-->
                        <div property="footer">
                            <a class="nui-button" iconCls="icon-add" plain="true" onclick="onSearch1()">添加</a>
                            <a class="nui-button" iconCls="icon-edit" plain="true" onclick="onSearch1()">修改</a>
                            <a class="nui-button" iconCls="icon-remove" plain="true" onclick="onSearch1()">删除</a>
                            <a class="nui-button" iconCls="icon-save" plain="true" onclick="onSearch1()">保存</a>
                        </div>
                    </div>
                </div>
                <div title="估算材料/维修项目" showCloseButton="false">
                    <div id="panel5" class="nui-panel" title="估算材料" iconCls="" style="width:100%;height:50%;"
                         showHeader="true"
                         bodyStyle="border:0"
                         headerStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="rightGrid3" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="0"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                <div field="partCode" width="80" header="状态" headerAlign="center"></div>
                                <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="单价" headerAlign="center" align="center"></div>
                                <div field="noTaxAmt" width="60" allowSort="true" header="金额" headerAlign="center" align="center"></div>
                            </div>
                        </div>
                    </div>
                    <div id="panel6" class="nui-panel" title="维修项目" iconCls="" style="width:100%;height:50%;"
                         showHeader="true"
                         bodyStyle="border:0"
                         headerStyle="border:0"
                         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                        <div id="rightGrid4" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="0"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partCode" width="80" header="项目编码" headerAlign="center"></div>
                                <div field="partName" width="80" header="项目名称" headerAlign="center"></div>
                                <div field="partCode" width="80" header="状态" headerAlign="center"></div>
                                <div field="partCode" width="80" header="工种" headerAlign="center"></div>
                                <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="金额小计" headerAlign="center" align="center"></div>
                                <div field="partCode" width="80" header="班组" headerAlign="center"></div>
                                <div field="partCode" width="80" header="承修人" headerAlign="center"></div>
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
