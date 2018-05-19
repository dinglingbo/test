<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:35:46
  - Description:
-->
<head>
<title>添加采购车/销售车</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + cloudPartDomain%>/common/js/shopCartPop.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="" plain="true" onclick="onOk" id="chooseBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel" id="cancelBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="mainTabs" class="nui-tabs" name="mainTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="false" 
           onactivechanged="">

        <div title="单个添加" id="singleTab" name="singleTab" visible="true" >
            <div id="oneInfoForm" class="form">
                <table style="width: 100%" id="list_table">
                    <tr>
                        <td class="title">
                            <label>配件编码：</label>
                        </td>
                        <td>
                            <input name="code" class="nui-textbox" enabled="false" width="100%"/>
                        </td>
                        <td class="title">
                            <label>配件全称：</label>
                        </td>
                        <td>
                            <input name="name" class="nui-textbox width1" enabled="false" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title required">
                            <label>供应商：</label>
                        </td>
                        <td colspan="3">
                            <input id="guestId"
                                 name="guestId"
                                 class="nui-buttonedit"
                                 emptyText="请选择供应商..."
                                 onbuttonclick="selectSupplier('guestId')"
                                 onvaluechanged="onGuestValueChanged"
                                 width="100%"
                                 placeholder="请选择供应商"
                                 selectOnFocus="true" />
                        </td>
                    </tr>
                    <tr>
                        <td class="title required">
                          <label>票据类型：</label>
                        </td>
                        <td>
                          <input name="billTypeId"
                                 id="billTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 onvaluechanged="onBillTypeIdChanged"
                                 nullItemText="请选择..."
                                 onvalidation="onComboValidation"/>
                        </td>
                        <td class="title required">
                          <label>结算方式：</label>
                        </td>
                        <td>
                          <input name="settleTypeId"
                                 id="settleTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 nullItemText="请选择..."
                                 onvalidation="onComboValidation"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title required">
                            <label>数量：</label>
                        </td>
                        <td>
                            <input id="qty" name="qty" class="nui-textbox" onvaluechanged="calc('qty')" vtype="float" selectOnFocus="true" width="100%" value="1"/>
                        </td>
                        <td class="title required">
                            <label>单价：</label>
                        </td>
                        <td>
                            <input id="price" name="price" class="nui-textbox width1" onvaluechanged="calc('price')" vtype="float" selectOnFocus="true" enabled="true" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title">
                            <label>备注：</label>
                        </td>
                        <td>
                            <input id="remark" name="remark" class="nui-textbox" selectOnFocus="true" enabled="true" width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div> 
        <div title="多个添加" id="batchTab" name="batchTab" visible="true" >
            <div id="batchInfoForm" class="form">
                <table style="width: 100%" id="list_table">
                    <tr>
                        <td class="title required">
                            <label>供应商：</label>
                        </td>
                        <td colspan="3">
                            <input id="guestId"
                                 name="guestId"
                                 class="nui-buttonedit"
                                 emptyText="请选择供应商..."
                                 onbuttonclick="selectSupplier('guestId')"
                                 onvaluechanged="onGuestValueChanged"
                                 width="100%"
                                 placeholder="请选择供应商"
                                 selectOnFocus="true" />
                        </td>
                    </tr>
                    <tr>
                        <td class="title required">
                          <label>票据类型：</label>
                        </td>
                        <td>
                          <input name="billTypeId"
                                 id="billTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 onvaluechanged="onBillTypeIdChanged"
                                 nullItemText="请选择..."
                                 onvalidation="onComboValidation"/>
                        </td>
                        <td class="title required">
                          <label>结算方式：</label>
                        </td>
                        <td>
                          <input name="settleTypeId"
                                 id="settleTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 nullItemText="请选择..."
                                 onvalidation="onComboValidation"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     selectOnLoad="true" showPager="false"
                     dataField="" idField="id" allowCellSelect="true" allowCellEdit="true"
                     showModified="false" showColumnsMenu="true" editNextOnEnterKey="true" url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div field="operateBtn" width="30" headerAlign="center" header="删除"></div>
                        <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                        <div field="comPartName" headerAlign="center" header="配件名称"></div>
                        <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
                            <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="orderPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
                            <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="remark" width="80" headerAlign="center" allowSort="true">
                            备注<input property="editor" class="nui-textbox"/>
                        </div>

                    </div>
                </div>
            </div>
          



        </div> 
    </div>
</div>



</body>
</html>
