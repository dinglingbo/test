<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-09 09:24:40
  - Description:
-->
<head>
<title>库存盘点</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/inventoryMgr/inventoryCheck.js?v=1.1.15"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.required {
	color: red;
}

fieldset {
	border: solid 1px #aaa;
	min-width: inherit;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="icon-add" plain="true" onclick="openCheckMain()">打开盘点单</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-add" plain="true" onclick="addStockCheck()" id="addCheckMainBtn">新增</a>
                    <a class="nui-button" iconCls="icon-remove" plain="true" onclick="removeStockCheck()" id="removeCheckMainBtn" enabled="true">删除</a>
                    <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()" id="saveCheckMainBtn" enabled="true">保存</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="audit()" id="auditBtn" enabled="false">生成盈亏单</a>
                </td>
            </tr>
        </table>
    </div>
    <fieldset id="fd1" style="width:calc(100% - 25px);">
        <legend><span>基本信息</span></legend>
        <div class="fieldset-body" id="basicInfoForm">
            <input class="nui-hidden" name="id"/>
            <input class="nui-hidden" name="orgid"/>
            <table class="form-table" border="0" cellpadding="1" cellspacing="2">
                <tr>
                    <td class="form-label required">盘点单号：</td>
                    <td>
                        <input name="checkCode" class="nui-textbox" enabled="false"/>
                    </td>
                    <td class="form-label required">盘点名称：</td>
                    <td>
                        <input name="checkName" class="nui-textbox" />
                    </td>
                    <td class="form-label required">仓库：</td>
                    <td>
                        <input id="storeId"
                               name="storeId"
                               class="nui-combobox width1"
                               textField="name"
                               valueField="id"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </td>
                    <td class="form-label required">盘点人：</td>
                    <td>
                        <input name="checker" class="nui-textbox" />
                    </td>
                    <td class="form-label">协助人：</td>
                    <td>
                        <input name="helpMan" class="nui-textbox" />
                    </td>
                </tr>
                <tr>
                    <td class="form-label">盘点日期：</td>
                    <td colspan="1" >
                        <input name="checkDate"
                               enabled="false"
                               allowInput="false"
                               class="nui-datepicker"/>
                    </td>
                    <td class="form-label">备注：</td>
                    <td colspan="3">
                        <input name="remark" class="nui-textbox" width="100%"/>
                    </td>
                    <td class="form-label">生成零库存：</td>
                    <td colspan="1">
                        <input name="generateZero" class="nui-checkbox" trueValue="1" falseValue="0"/>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    <div class="nui-fit">
        <div class="nui-splitter"
             allowResize="false"
             handlerSize="0"
             borderStyle="border:0"
             style="width:100%;height:100%;">
            <div size="185" showCollapseButton="true" style="border:0;">
                <fieldset id="fd2" style="width:160px;height:calc(100% - 20px);">
                    <legend><span>仓位列表</span></legend>
                    <div class="nui-fit">
                        <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             sortMode="client"
                             multiSelect="true"
                             dataField="locationList"
                             idField="id">
                            <div property="columns">
                                <div header="选择仓位盘点列表" headerAlign="center">
                                    <div property="columns">
                                        <div type="checkcolumn" width="30">选择</div>
                                        <div field="name" width="" headerAlign="center" header="仓位" allowSort="true"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="nui-toolbar" style="padding:2px;border-top:0;">
                        <table style="width:100%;">
                            <tr>
                                <td style="width:100%;">
                                    <a class="nui-button" iconCls="icon-add" plain="true" id="genreateBtn" onclick="generateSelected()">生成</a>
                                    <a class="nui-button" iconCls="icon-add" plain="true"  id="genreateAllBtn" onclick="generateAll()">生成所有</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
            </div>
            <div showCollapseButton="true" style="border:0;">
                <fieldset id="fd3" style="width:calc(100% - 25px);height:calc(100% - 20px);">
                    <legend><span>盘点列表</span></legend>
                    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                        <table style="width:100%;">
                            <tr>
                                <td style="width:100%;">
                                    <a class="nui-button" iconCls="icon-add" plain="true" onclick="addDetail()" id="addCheckDetailBtn">新增</a>
                                    <a class="nui-button" iconCls="icon-remove" plain="true" onclick="removeDetail()" id="removeCheckDetailBtn" enabled="true">删除</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             showPager="false"
                             sortMode="client"
                             dataField="list"
                             idField="detailId"
                             allowCellEdit="true"
                             allowCellSelect="true"
                             url="">
                            <div property="columns">
                                <div type="indexcolumn" width="30">序号</div>
                                <div header="零件信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="partCode" width="" headerAlign="center" header="零件编码" allowSort="true"></div>
                                        <div field="partName" width="" headerAlign="center" header="零件名称" allowSort="true"></div>
                                        <div field="partBrandName" width="" headerAlign="center" header="品牌" allowSort="true"></div>
                                        <div field="applyCarModel" width="" headerAlign="center" header="品牌车型 " allowSort="true"></div>
                                        <div field="unit" width="" headerAlign="center" header="单位" allowSort="true"></div>
                                        <div field="storeLocation" width="" headerAlign="center" header="仓位" allowSort="true"></div>
                                    </div>
                                </div>
                                <div header="数量" headerAlign="center">
                                    <div property="columns">
                                        <div field="paperQty" width="" headerAlign="center" header="库存数" allowSort="true"></div>
                                        <div field="trueQty" width="" headerAlign="center" header="盘点数" allowSort="true">
                                            <input property="editor" class="nui-spinner" minValue="0" maxValue="9999999999" style="width:100%;"/>
                                        </div>
                                    </div>
                                </div>
                                <div header="其他" headerAlign="center">
                                    <div property="columns">
                                        <div field="invtLossQty" width="" headerAlign="center" header="盈亏数" allowSort="true"></div>
                                        <div field="remark" width="150" headerAlign="center" header="备注" allowSort="true">
                                            <input property="editor" class="nui-textbox" style="width:100%;"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>


</body>
</html>
