<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-09 16:22:55
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/commonPart/js/allotOutSelect.js?v=1.0.2"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div id="queryForm" class="form">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">昨日</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">上周</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">调出至：</label>
                    <input id="guestId"
                           name="guestId"
                           class="nui-combobox width1"
                           textField="orgname"
                           valueField="orgid"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <label style="font-family:Verdana;">调拨单号：</label>
                    <input class="nui-textbox" width="100" name="outId"/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>

                </td>
            </tr>
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()" id="okBtn">选择</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-no" plain="true" onclick="onCancel()" id="cancelBtn">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         ondrawcell="onPartGridDraw"
         dataField="ptsOutMainDetailList"
         idField="detailId"
         onrowdblclick="onOk"
         sortMode="client"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="零件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="outCode" width="100" headerAlign="center" header="调拨单号"></div>
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="零件编码"></div>
                    <div allowSort="true" field="partName" headerAlign="center" header="零件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="适用车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                </div>
            </div>
            <div header="数量金额信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="int" field="outQty" width="60" headerAlign="center" header="数量" align="right"></div>
                    <div allowSort="true" datatype="float" field="sellUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                    <div allowSort="true" datatype="float" field="sellAmt" width="60" headerAlign="center" header="金额" align="right"></div>
                </div>
            </div>
            <div header="调拨信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="outDate" width="80" headerAlign="center" header="调出日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="seller" width="100" headerAlign="center" header="经办人"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:300px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">调拨日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           format="yyyy-MM-dd"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="true"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">调拨单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height:90px;" name="outIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">零件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 90px;" name="partCodeList"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="mini-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="mini-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>




</body>
</html>
