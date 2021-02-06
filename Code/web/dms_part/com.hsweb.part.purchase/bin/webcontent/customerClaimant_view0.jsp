<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-08 16:10:26
  - Description:
-->
<head>
<title>客户索赔</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/repairMgr/customerClaimant.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 70px;
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
    <div id="queryForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">索赔日期 从:</td>
                <td style="white-space:nowrap;width: 100px;">
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="" style="width:20px;">至:</td>
                <td style="white-space:nowrap;width: 100px;">
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd HH:mm"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
                <td>
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
                <a class="nui-button" iconCls="icon-save" plain="true" onclick="onSave()" enabled="true">保存</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onPost()" enabled="false" id="reViewBtn">过账</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <div class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
        <div size="260" showCollapseButton="false" style="border:0;">
            <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 borderStyle="border;0"
                 url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">车牌号</div>
                    <div field="salary" width="" allowSort="true" headerAlign="center" allowSort="true">工单号</div>
                    <div field="position_name" width="" headerAlign="center" allowSort="true">索赔单号</div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0">
            <div id="panel1" class="nui-panel" title="基本信息" iconCls="" style="width:100%;height:90px;"
                 showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
                <div id="basicInfoForm" >
                    <input name="id" class="nui-hidden" />
                    <table>
                        <tr>
                            <td>
                                <label>索赔单号：</label>
                            </td>
                            <td>
                                <input enabled="false"
                                       name="username" class="nui-textbox"  />
                            </td>
                            <td>
                                <label>索赔类型：</label>
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
                                <label>业务单号顾问：</label>
                            </td>
                            <td colspan="3">
                                <input id="textbox3"
                                       enabled="false" width="100%"
                                       name="username" class="nui-textbox"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>车牌号：</label>
                            </td>
                            <td>
                                <input enabled="false"
                                       name="username" class="nui-textbox"  />
                            </td>
                            <td>
                                <label>车辆厂牌：</label>
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
                                <label>品牌车型：</label>
                            </td>
                            <td>
                                <input enabled="false"
                                       name="username" class="nui-textbox"  />
                            </td>
                            <td>
                                <label>维修顾问：</label>
                            </td>
                            <td>
                                <input enabled="false"
                                       name="username" class="nui-textbox"  />
                            </td>
                            <td>
                                <label>联系人：</label>
                            </td>
                            <td>
                                <input enabled="false"
                                       name="username" class="nui-textbox"  />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-fit">
                <div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;" bodyStyle="border-right:0">
                    <div title="配件出库" showCloseButton="false">
                        <div id="panel2" class="nui-panel" title="" iconCls="" style="width:100%;height:70%;border:0;"
                             showHeader="false"
                             showToolbar="false" showCollapseButton="false" showFooter="true" allowResize="false" collapseOnTitleClick="false">
                            <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                 showPager="false"
                                 frozenStartColumn="0"
                                 frozenEndColumn="5"
                                 borderStyle="border:0"
                                 sortMode="client"
                                 url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div header="配件信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                            <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                            <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                            <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="right"></div>
                                            <div field="stockLocation" width="60" header="仓位" headerAlign="center" align="center"></div>
                                        </div>
                                    </div>
                                    <div header="成本信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="qualityTypeId" width="60" header="单价" headerAlign="center" align="center"></div>
                                            <div field="partBrandId" width="60" header="金额" headerAlign="center" align="center"></div>
                                        </div>
                                    </div>
                                    <div header="销售信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="qualityTypeId" width="60" header="销售单价" headerAlign="center" align="center"></div>
                                            <div field="partBrandId" width="60" header="销售金额" headerAlign="center" align="center"></div>
                                        </div>
                                    </div>
                                    <div header="利润信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="qualityTypeId" width="60" header="毛利" headerAlign="center" align="center"></div>
                                        </div>
                                    </div>
                                    <div header="领料信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="qualityTypeId" width="60" header="领料人" headerAlign="center" align="center"></div>
                                            <div field="partBrandId" width="100" header="领料日期" dateFormat="yyyy-MM-dd" headerAlign="center" align="center"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--footer-->
                            <div property="footer">
                                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="true">选中归库</a>
                                <a class="nui-button" iconCls="icon-remove" plain="true" onclick="review()" enabled="true">删除</a>
                            </div>
                        </div>
                        <div class="nui-fit">
                            <div id="rightGrid1" class="nui-datagrid" style="width:100%;height:100%;"
                                 showPager="false"
                                 frozenStartColumn="0"
                                 frozenEndColumn="0"
                                 borderStyle="border-top:0"
                                 url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div header="索赔归库配件" headerAlign="center">
                                        <div property="columns">
                                            <div field="partId" width="80" header="内码" headerAlign="center"></div>
                                            <div field="partCode" width="80" header="配件编码" headerAlign="center"></div>
                                            <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                            <div field="unit" width="40" header="单位" headerAlign="center" align="center"></div>
                                            <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="right"></div>
                                            <div field="noTaxUnitPrice" width="80" header="成本单价" headerAlign="center" align="right"></div>
                                            <div field="noTaxAmt" width="80" header="成本金额" headerAlign="center" align="right"></div>
                                            <div field="sellUnitPrice" width="80" header="销售单价" headerAlign="center"></div>
                                            <div field="sellAmt" width="80" header="销售金额" headerAlign="center"></div>
                                        </div>
                                    </div>
                                    <div header="退回信息" headerAlign="center">
                                        <div property="columns">
                                            <div field="sellUnitPrice" width="80" header="退回单价" headerAlign="center"></div>
                                            <div field="sellAmt" width="80" header="退回金额" headerAlign="center"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="索赔描述" iconCls="" showCloseButton="false">
                        <div id="claimantDetailForm" >
                            <table style="width: 100%">
                                <tr>
                                    <td class="title">
                                        <label>客户描述：</label>
                                    </td>
                                    <td>
                                        <textarea name="username"
                                               style="height: 150px;" width="100%"
                                               class="nui-textarea"  ></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="title">
                                        <label>处理描述：</label>
                                    </td>
                                    <td>
                                        <textarea id=""  name="username"
                                                  style="height: 150px;" width="100%"
                                                  class="nui-textarea"  ></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="title">
                                        <label>防范措施：</label>
                                    </td>
                                    <td>
                                        <input name="username" width="100%"
                                               class="nui-textbox"  />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div title="索赔项目" showCloseButton="false">
                        <div id="rightGrid2" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="0"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <!--<div field="partCode" width="80" header="项目编码" headerAlign="center"></div>-->
                                <div field="partName" width="80" header="项目名称" headerAlign="center"></div>
                                <!--<div field="partCode" width="80" header="状态" headerAlign="center"></div>-->
                                <div field="partCode" width="80" header="工种" headerAlign="center"></div>
                                <div field="partCode" width="80" header="班组" headerAlign="center"></div>
                                <div field="partCode" width="80" header="主修人" headerAlign="center"></div>
                                <!--<div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>-->
                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="金额" headerAlign="center" align="center"></div>
                                <div field="partCode" width="80" header="备注" headerAlign="center"></div>
                            </div>
                        </div>
                    </div>
                    <div title="索赔配件" showCloseButton="false" enabled="true">
                        <div id="rightGrid3" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             frozenStartColumn="0"
                             frozenEndColumn="0"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partName" width="80" header="配件名称" headerAlign="center"></div>
                                <div field="enterQty" width="60" allowSort="true" header="数量" headerAlign="center" align="center"></div>
                                <div field="noTaxUnitPrice" width="60" allowSort="true" header="单价" headerAlign="center" align="center"></div>
                                <div field="partCode" width="80" header="金额" headerAlign="center"></div>
                                <div field="remark" width="80" header="备注" headerAlign="center"></div>
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
