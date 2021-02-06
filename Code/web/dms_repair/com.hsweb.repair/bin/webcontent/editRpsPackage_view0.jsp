<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-26 18:46:53
  - Description:
-->
<head>
<title>修改套餐</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/editRpsPackage.js?v=1.0.2"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="border-bottom:0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-save" onclick="onOk()">保存</a>
                <a class="nui-button" plain="true" iconCls="icon-no" onclick="onCancel()">关闭</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-panel" title="套餐项目" style="border-bottom: 0;width: 100%;">
    <div id="basicInfoForm">
        <input class="nui-hidden" name="id"/>
        <input class="nui-hidden" name="status"/>
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>套餐名称：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" name="packageName" enabled="false" width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>套餐金额：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="amt" enabled="false" width="100%"/>
                </td>
                <td class="form_label">
                    <label>套餐小计：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="subtotal" enabled="true"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit" style="padding-top:10px;">
    <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 100%;"
         plain="false">
        <div title="项目">
            <div id="itemGrid" class="nui-datagrid"
                 style="width: 100%;height: 100%;"
                 dataField="list"
                 showPager="false"
                 allowCellSelect="true"
                 allowCellEdit="true"
                 allowSortColumn="true">
                <div property="columns">
                    <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                    <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="">项目名称</div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" width="100" header="备注">
                        <input property="editor" class="nui-textbox" style="width:100%;"/>
                    </div>
                    <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                    <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80">工时</div>
                    <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" header="项目金额" align="right">
                        <input property="editor" class="nui-spinner"  minValue="0" maxValue="100000000" showButton="false" style="width:100%;"/>
                    </div>
                    <div field="itemIsNeed" headerAlign="center" allowSort="true" visible="true" width="80">必要性</div>
                </div>
            </div>
        </div>
        <div title="配件">
            <div id="partGrid"
                 dataField="list"
                 class="nui-datagrid"
                 style="width: 100%; height: 100%;"
                 showPager="false"
                 allowCellSelect="true"
                 allowCellEdit="true"
                 allowSortColumn="true">
                <div property="columns">
                    <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                    <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">配件名称</div>
                    <div field="partBrandName" headerAlign="center" allowSort="true" visible="true" width="">品牌</div>
                    <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">配件编码</div>
                    <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80">数量</div>
                    <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" header="单价">
                        <input property="editor" class="mini-spinner"  minValue="0" maxValue="100000000" showButton="false" style="width:100%;"/>
                    </div>
                    <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" header="金额">
                        <input property="editor" class="mini-spinner"  minValue="0" maxValue="100000000" showButton="false" style="width:100%;"/>
                    </div>
                    <div field="partIsNeed" headerAlign="center" allowSort="true" visible="true" width="80">状态</div>
                </div>
            </div>
        </div>
    </div>
</div>



</body>
</html>
