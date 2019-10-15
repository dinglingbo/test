<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>单据审核</title>
<script src="<%=webPath + contextPath%>/settlement/js/billServiceQuery.js?v=2.0.3"></script>
<style type="text/css">
.title {
    width: 90px;
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

.panelwidth{
    width: 300px;
}
.tmargin{
    margin-top: 10px;
    margin-left: 50px;
    margin-bottom: 10px;
}
.twidth{
    width:200px;
}

.vpanel{
    border:1px solid #d9dee9;
    margin:10px 0px 0px 20px;
    height:248px;
    float:left;
}
.vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
}
.vpanel_heading span{
    margin:0 0 0 20px;
    font-size:16px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}
</style>
</head>
<body>


    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                </ul>

                <label style="font-family:Verdana;">制单日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="serviceId" width="120px" emptyText="业务单号" class="nui-textbox"/>
                <input id="serviceMan" width="60px" emptyText="业务员" class="nui-hidden"/>
                <!-- <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择往来单位..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" /> -->
                <input class="nui-combobox" name="accountSign" id="accountSign" value="0"
                     nullitemtext="请选择..." emptyText="单据状态" data="accountList" width="60px" />
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                <a class="nui-button" iconCls="" plain="true" onclick="unAudit()"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;反审核</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         multiSelect="true"
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         onshowrowdetail="onShowRowDetail"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="checkcolumn" width="20"></div>
            <div type="expandcolumn" width="20" >#</div>
            <div field="fullName" width="150" headerAlign="center" header="往来单位名称"></div>
            <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
            <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
            <div field="enterTypeId" width="60" headerAlign="center" header="业务类型"></div>
            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div allowSort="true" field="billDate" headerAlign="center" header="单据日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="accountSign" width="60" headerAlign="center" header="审核状态"></div>
            <div field="accountor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true"width="120" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="remark" width="120" headerAlign="center" header="备注"></div>

        </div>
    </div>
</div>

<div id="editFormPchsEnterDetail" style="display:none;">
    <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjEnterDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="80" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName"width="140" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode" width="140"headerAlign="center" header="OE码"></div>
            <div allowSort="true" field="comPartBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="采购数量"></div>
            <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="采购单价"></div>
            <div allowSort="true" datatype="float" field="enterAmt" summaryType="sum" width="60" headerAlign="center" header="采购金额"></div>
            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div>
        </div>
    </div>
</div>

<div id="editFormPchsRtnDetail" style="display:none;">
    <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjSellOutDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName"width="140" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode"width="140" headerAlign="center" header="OE码"></div>
            <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="退货单价"></div>
            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
            <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="partId" width="60" summaryType="count" headerAlign="center" header="配件ID"></div>
        </div>
    </div>
</div>

<div id="editFormSellOutDetail" style="display:none;">
    <div id="innerSellOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjSellOutDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="90" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName"width="120" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode" width="140"headerAlign="center" header="OE码"></div>
            <div allowSort="true" field="comPartBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
            <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div>
        </div>
    </div>
</div>

<div id="editFormSellRtnDetail" style="display:none;">
    <div id="innerSellRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjEnterDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="80" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName"width="140" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode"width="150" headerAlign="center" header="OE码"></div>
            <div allowSort="true" field="comPartBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
            <div allowSort="true" datatype="float" field="rtnPrice" width="60" headerAlign="center" header="退货单价"></div>
            <div allowSort="true" datatype="float" field="rtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
            <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:250px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">出/入日期:</td>
                <td>
                    <input name="sBillDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eBillDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">制单日期:</td>
                <td>
                    <input name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eCreateDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    往来单位:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">业务单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">单据状态:</td>
                <td colspan="3">
                    <input class="nui-combobox" name="accountSign" value="0"
                     nullitemtext="请选择..." emptyText="单据状态" data="accountList" width="100%" />
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

<div id="auditWin" class="nui-window"
     title="单据审核" style="width:350px;height:300px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <div class="vpanel panelwidth" style="height:auto;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>应收</span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr>
                        <td style="text-align:center;width:25%">应收金额:</td>
                        <td id="pAmt" style="text-align:left;width:25%;color:blue;text-decoration:underline"></td>
                     
                        <td style="text-align:center;width:25%">审核金额:</td>
                        <td id="pAuditAmt" style="text-align:left;width:25%;color:blue;text-decoration:underline"></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="vpanel panelwidth" style="height:auto;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>应付</span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr>
                        <td style="text-align:center;width:25%">应付金额:</td>
                        <td id="rAmt" style="text-align:left;width:25%;color:blue;text-decoration:underline"></td>
                   
                        <td style="text-align:center;width:25%;">审核金额:</td>
                        <td id="rAuditAmt" style="text-align:left;width:25%;color:blue;text-decoration:underline"></td>
                    </tr>
                </table>

            </div>
        </div>

        <div class="vpanel panelwidth" style="height:auto;">
            <div class="vpanel_body">
                <table class="tmargin twidth">
                    <tr>
                        <td id="billCount" style="text-align:center;;width:100%;">审核单据数：</td>
                    </tr>
                </table>

            </div>
        </div>

        <!-- <table style="width:100%;" >
            <tr>
                <td id="billCount" style="text-align:left;">审核单据数：</td>
            </tr>
            <tr>
                <td style="text-align:left;width:50%">&nbsp;&nbsp;&nbsp;&nbsp;应收</td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%">应收金额:</td>
                <td id="pAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%">审核金额:</td>
                <td id="pAuditAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
            <tr>
                <td style="text-align:left;width:50%">&nbsp;&nbsp;&nbsp;&nbsp;应付</td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%">应付金额:</td>
                <td id="rAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%;">审核金额:</td>
                <td id="rAuditAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
        </table> -->
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="auditOK" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="auditCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>



</body>
</html>
