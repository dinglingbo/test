<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-04-03 15:51:24
  - Description:
-->
<head>
<title>优惠设置</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/discountSetting.js?v=1.0.3"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 74px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body style="padding:5px;">
<div id="basicInfoForm">
    <input class="nui-hidden" name="id"/>
    <div class="nui-panel" title="客户信息" style="width:calc(100% - 10px);" bodyStyle="padding:0;" borderStyle="border-bottom:0;" headerStyle="height:22px;">
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>客户名称：</label>
                </td>
                <td>
                    <input name="guestName" class="nui-textbox" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>会员等级：</label>
                </td>
                <td>
                    <input name="memName" class="nui-textbox" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>入会日期：</label>
                </td>
                <td>
                    <input name="joinDate" class="nui-datepicker" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>项目优惠率：</label>
                </td>
                <td>
                    <input name="itemDiscount" class="nui-textbox" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>材料优惠率：</label>
                </td>
                <td>
                    <input name="partDiscount" class="nui-textbox" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>到期日期：</label>
                </td>
                <td>
                    <input name="expiryDate" class="nui-datepicker" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-panel" title="快速优惠" style="width:calc(100% - 10px);">
        <table class="nui-form-table">
            <tr>
                <td>
                    <div id="normalDiscount" name="normalDiscount" class="nui-checkbox" readOnly="false" text="正常优惠" trueValue="1" falseValue="0"></div>
                    <div id="outDiscount" name="outDiscount" class="nui-checkbox" readOnly="false" text="出单优惠" trueValue="1" falseValue="0"></div>
                    <div id="itemDiscount" name="itemDiscount" class="nui-checkbox" readOnly="false" text="项目优惠" trueValue="1" falseValue="0"></div>
                    <input id="itemRate" class="nui-spinner"  minValue="0" maxValue="100" showButton="false" enabled="true" value="0" allowNull="false"/>
                    <div id="partDiscount" name="partDiscount" class="nui-checkbox" readOnly="false" text="项目优惠" trueValue="1" falseValue="0"></div>
                    <input id ="partRate" class="nui-spinner"  minValue="0" maxValue="100" showButton="false" enabled="true" value="0" allowNull="false"/>
                    <a class="nui-button" onclick="onSet" >应用</a>
                </td>
            </tr>
            <tr>
                <td>
                    <label>项目优惠率：</label>
                    <label id="itemAmtRate"></label>
                    <label>配件优惠率：</label>
                    <label id="partAmtRate"></label>
                    <label>优惠共计：</label>
                    <label id="discountAmt"></label>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-tabs" activeIndex="0" style="width:calc(100% - 10px);height:calc(100% - 10px);">
        <div title="项目优惠信息">
            <div id="itemGrid" class="nui-datagrid"
                 dataField="list"
                 sortMode="client"
                 showPager="false"
                 allowCellEdit="true" allowCellSelect="true" multiSelect="true"
                 style="width:100%;height:100%;">
                <div property="columns">
                    <div type="indexcolumn"></div>
                    <div field="itemName" width="120" headerAlign="center" allowSort="true" header="项目名称"></div>
                    <div field="receTypeName" width="120" headerAlign="center" allowSort="true" header="收费类型"></div>
                    <div field="amt" width="120" headerAlign="center" allowSort="true" header="金额" align="right" datatype="float"></div>
                    <div field="rate" width="120" headerAlign="center" allowSort="true" header="优惠率" align="right" datatype="float" numberFormat="p">
                        <input property="editor" class="nui-spinner"  minValue="0" maxValue="100" value="0" style="width:100%;"/>
                    </div>
                    <div field="discountAmt" width="120" headerAlign="center" allowSort="true" header="优惠金额" align="right" datatype="float"></div>
                    <div field="subtotal" width="120" headerAlign="center" allowSort="true" header="小计" align="right" datatype="float"></div>
                </div>
            </div>
        </div>
        <div title="材料优惠信息">
            <div id="partGrid" class="nui-datagrid"
                 sortMode="client"
                 dataField="list"
                 showPager="false"
                 allowCellEdit="true" allowCellSelect="true" multiSelect="true"
                 style="width:100%;height:100%;">
                <div property="columns">
                    <div type="indexcolumn"></div>
                    <div field="partName" width="120" headerAlign="center" allowSort="true" header="材料名称"></div>
                    <div field="receTypeName" width="120" headerAlign="center" allowSort="true" header="收费类型"></div>
                    <div field="qty" width="120" headerAlign="center" allowSort="true" header="数量" align="right" datatype="int"></div>
                    <div field="unitPrice" width="120" headerAlign="center" allowSort="true" header="单价" align="right" datatype="float"></div>
                    <div field="amt" width="120" headerAlign="center" allowSort="true" header="金额" align="right" datatype="float"></div>
                    <div field="rate" width="120" headerAlign="center" allowSort="true" header="优惠率" align="right" datatype="float" numberFormat="p">
                        <input property="editor" class="nui-spinner"  minValue="0" maxValue="100" value="0" style="width:100%;"/>
                    </div>
                    <div field="discountAmt" width="120" headerAlign="center" allowSort="true" header="优惠金额" align="right" datatype="float"></div>
                    <div field="subtotal" width="120" headerAlign="center" allowSort="true" header="小计" align="right" datatype="float"></div>
                    <div field="partCode" width="120" headerAlign="center" allowSort="true" header="材料编码"></div>
                </div>
            </div>
        </div>
        <div title="出单项目优惠">
            <div id="itemBillGrid" class="nui-datagrid"
                 sortMode="client"
                 dataField="list"
                 allowCellEdit="true" allowCellSelect="true" multiSelect="true"
                 style="width:100%;height:100%;">
                <div property="columns">
                    <div type="indexcolumn"></div>
                    <div field="itemName" width="120" headerAlign="center" allowSort="true" header="项目名称"></div>
                    <div field="itemName" width="120" headerAlign="center" allowSort="true" header="收费类型"></div>
                    <div field="amt" width="120" headerAlign="center" allowSort="true" header="金额" align="right" datatype="int"></div>
                    <div field="rate" width="120" headerAlign="center" allowSort="true" header="优惠率" align="right" datatype="float" numberFormat="p">
                        <input property="editor" class="nui-spinner"  minValue="0" maxValue="100" value="0" style="width:100%;"/>
                    </div>
                    <div field="discountAmt" width="120" headerAlign="center" allowSort="true" header="优惠金额" align="right" datatype="float"></div>
                    <div field="subtotal" width="120" headerAlign="center" allowSort="true" header="小计" align="right" datatype="float"></div>
                </div>
            </div>
        </div>
        <div title="出单材料优惠">
            <div id="partBillGrid" class="nui-datagrid"
                 sortMode="client"
                 dataField="list"
                 allowCellEdit="true" allowCellSelect="true" multiSelect="true"
                 style="width:100%;height:100%;">
                <div property="columns">
                    <div type="indexcolumn"></div>
                    <div field="partName" width="120" headerAlign="center" allowSort="true" header="材料名称"></div>
                    <div field="itemName" width="120" headerAlign="center" allowSort="true" header="收费类型"></div>
                    <div field="qty" width="120" headerAlign="center" allowSort="true" header="数量" align="right" datatype="int"></div>
                    <div field="unitPrice" width="120" headerAlign="center" allowSort="true" header="单价" align="right" datatype="float"></div>
                    <div field="amt" width="120" headerAlign="center" allowSort="true" header="金额" align="right" datatype="float"></div>
                    <div field="rate" width="120" headerAlign="center" allowSort="true" header="优惠率" align="right" datatype="float" numberFormat="p">
                        <input property="editor" class="nui-spinner"  minValue="0" maxValue="100" value="0" style="width:100%;"/>
                    </div>
                    <div field="discountAmt" width="120" headerAlign="center" allowSort="true" header="优惠金额" align="right" datatype="float"></div>
                    <div field="subtotal" width="120" headerAlign="center" allowSort="true" header="小计" align="right" datatype="float"></div>
                    <div field="partCode" width="120" headerAlign="center" allowSort="true" header="材料编码"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:right;padding:10px;">
    <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="nui-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>
</body>
</html>
