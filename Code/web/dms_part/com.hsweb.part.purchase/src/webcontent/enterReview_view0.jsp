<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 15:40:23
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchase/js/reviewMgr/enterReview.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
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
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">入库单号：</label>
                    <input class="nui-textbox" name="id">
                    <label style="font-family:Verdana;">入库日期：</label>
                    <input name="startDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat=""/>
                    <label style="font-family:Verdana;">至：</label>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat=""
                           showTime="false"
                           showOkButton="false"
                           showClearButton="true"/>
                    <span class="separator"></span>
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
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="false" id="reViewBtn">审核</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         allowResize="false"
         style="width:100%;height:100%;">
        <div size="210" showCollapseButton="false">
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id" parentField="parentid" resultAsTree="false">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-fit" >
                <div id="rightGrid1" class="nui-datagrid" style="width:100%;height:50%;"
                     showPager="false"
                     dataField="ptsEnterMainList"
                     idField="id"
                     ondrawcell="onRightGrid1DrawCell"
                     onrowclick="onRightGrid1RowClick"
                     sortMode="client"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="id" width="150" headerAlign="center" header="工单号"></div>
                                <div allowSort="true" field="guestFullName" width="150" headerAlign="center" header="往来单位"></div>
                                <div allowSort="true" field="enterDate" headerAlign="center" width="80"  header="入库日期" dateFormat="yyyy-MM-dd"></div>
                                <!--<div field="billStatus" width="60" headerAlign="center" header="单据状态"></div>-->
                                <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                                <div allowSort="true" field="settType" width="60" headerAlign="center" header="结算方式"></div>
                                <div allowSort="true" field="auditor" width="100" headerAlign="center" header="审核人"></div>
                            </div>
                        </div>
                        <div header="金额信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="payableAmt" width="80" headerAlign="center" header="应付金额" align="right"></div>
                            </div>
                        </div>
                        <div header="操作信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="auditor" width="100" headerAlign="center" header="操作员"></div>
                                <div allowSort="true" field="auditDate" headerAlign="center" width="80" header="操作日期" dateFormat="yyyy-MM-dd"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="rightGrid2" class="nui-datagrid" style="width:100%;height:50%;"
                     showPager="false"
                     dataField="enterDetailList"
                     idField="detailId"
                     sortMode="client"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="零件信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="partCode" width="60" headerAlign="center" header="零件编码"></div>
                                <div allowSort="true" field="partName" headerAlign="center" header="零件名称"></div>
                                <div allowSort="true" field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
                                <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="车型"></div>
                                <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                                <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>
                            </div>
                        </div>
                        <div header="数量单价" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="noTaxUnitPrice" width="40" headerAlign="center" header="单价" align="right"></div>
                                <div allowSort="true" datatype="float" field="taxRate" width="40" headerAlign="center" header="税率" align="right"></div>
                                <div allowSort="true" datatype="float" field="noTaxAmt" width="40" headerAlign="center" header="金额" align="right"></div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="suggestPrice" width="80" headerAlign="center" header="建议销价/退货价" align="right"></div>
                                <div allowSort="true" datatype="float" field="suggestAmt" width="100" headerAlign="center" header="建议销销售金额/退货金额" align="right"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
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
