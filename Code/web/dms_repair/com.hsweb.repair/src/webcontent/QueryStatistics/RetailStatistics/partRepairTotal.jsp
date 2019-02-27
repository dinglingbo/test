<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>配件维修统计分析</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/partRepairTotal.js?v=1.2.15"></script>
<style type="text/css">
.title {
  width: 60px;
  text-align: right;
}

.title.required {
  color: red;
}
.title.tip {
  color: blue;
}

.title.wide {
  width: 100px;
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
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>

                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本月</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本季</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上季</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本年</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上年</li>
                </ul>

                <label style="font-family:Verdana;">开单日期 从：</label>
                <input class="nui-datepicker" id="sRecordDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="eRecordDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                <input id="partName" width="100px" emptyText="配件名称" class="nui-textbox"/>
                <input id="partBrandId" width="100px" textField="name" valueField="id" emptyText="配件品牌" class="nui-combobox" allowinput="true" valueFromSelect="true" onvaluechanged="onSearch()"/>
                <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择客户..." onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
                <input id="guestType" width="100px" textField="name" valueField="customid" emptyText="客户分类" visible="false" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
				<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
				
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="mainTabs" class="nui-tabs" name="mainTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="true" 
           onactivechanged="">

        <div title="按商品排行" id="partGridTab" name="partGridTab" >
            
            <div id="partGrid" class="nui-datagrid" style="width:1000px;height:100%;"
                 showPager="false"
                 dataField="list"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="partCode" summaryType="count" width="80" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="80" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="配件品牌"></div>
                    <div allowSort="true" field="oemCode" width="80" headerAlign="center" header="OEM码"></div>
                    <div field="trueQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float" >出库数量</div>
                    <div field="trueAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float">出库金额</div>
                    <!-- <div field="sellQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >销售数量</div>
                    <div field="sellAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum"  >销售金额</div>
                    <div field="sellRtnQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >退货数量</div>
                    <div field="sellRtnAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >退货金额</div>
                    <div field="trueQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销数量</div>
                    <div field="trueAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销金额</div>
                    <div field="trueCost" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销毛利</div> -->
                      
                </div>
            </div>

        </div>



        <div title="按配件类型排行" name="partTypeGridTab" url="" >
          
            <div id="partTypeGrid" class="nui-datagrid" style="width:800px;height:100%;"
                 showPager="false"
                 dataField="list"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="carTypeIdF" summaryType="count" width="80" headerAlign="center" header="配件类型"></div>
                    <div field="trueQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float" >出库数量</div>
                    <div field="trueAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float">出库金额</div>
                </div>
            </div>

        </div>


        <div title="按品牌排行" name="partBrandGridTab" url="" >
            <div id="partBrandGrid" class="nui-datagrid" style="width:800px;height:100%;"
                 showPager="false"
                 dataField="list"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="partBrandId" summaryType="count" width="80" headerAlign="center" header="配件品牌"></div>
                    <div field="trueQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float" >出库数量</div>
                    <div field="trueAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float">出库金额</div>
                </div>
            </div>
        </div>

        <div title="按业务类型排行" id="clientGridTab" name="clientGridTab" url="" >
            <div id="clientGrid" class="nui-datagrid" style="width:800px;height:100%;"
                 showPager="false"
                 dataField="list"
                 idField="guestId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="serviceTypeName" summaryType="count" width="100" headerAlign="center" header="业务类型"></div>
                    <div field="trueQty" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum"  dataType="float">出库数量</div>
                    <div field="trueAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" dataType="float">出库金额</div>
                </div>
            </div>

        </div> 
    </div>
</div>

<div id="exportSupplierDiv" style="display:none">  
    <table id="tableSupplierExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
            <td colspan="1" align="center">供应商名称</td>
            <td colspan="1" align="center">供应商编码</td>
            <td colspan="1" align="center">供应商类型</td>
            <td colspan="1" align="center">入库数量</td>
            <td colspan="1" align="center">入库金额</td>
            <td colspan="1" align="center">退货数量</td>
            <td colspan="1" align="center">退货金额</td>
            <td colspan="1" align="center">实际入库数量</td>
            <td colspan="1" align="center">实际入库金额</td>
        </tr>
        <tbody id="tableExportSupplierContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  

<div id="exportPartDiv" style="display:none">  
    <table id="tablePartExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件名称</td>
            <td colspan="1" align="center">配件品牌</td>
            <td colspan="1" align="center">OEM码</td>
            <td colspan="1" align="center">入库数量</td>
            <td colspan="1" align="center">入库金额</td>
            <td colspan="1" align="center">退货数量</td>
            <td colspan="1" align="center">退货金额</td>
            <td colspan="1" align="center">实际入库数量</td>
            <td colspan="1" align="center">实际入库金额</td>
        </tr>
        <tbody id="tableExportPartContent">
        </tbody>
    </table>  
    <a href="" id="tableExportB"></a>
</div>  

<div id="exportPartBrandDiv" style="display:none">  
    <table id="tablePartBrandExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
            <td colspan="1" align="center">配件品牌</td>
            <td colspan="1" align="center">入库数量</td>
            <td colspan="1" align="center">入库金额</td>
            <td colspan="1" align="center">退货数量</td>
            <td colspan="1" align="center">退货金额</td>
            <td colspan="1" align="center">实际入库数量</td>
            <td colspan="1" align="center">实际入库金额</td>
        </tr>
        <tbody id="tableExportPartBrandContent">
        </tbody>
    </table>  
    <a href="" id="tableExportC"></a>
</div>  

<div id="exportPartTypeDiv" style="display:none">  
    <table id="tablePartTypeExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
            <td colspan="1" align="center">配件类型</td>
            <td colspan="1" align="center">入库数量</td>
            <td colspan="1" align="center">入库金额</td>
            <td colspan="1" align="center">退货数量</td>
            <td colspan="1" align="center">退货金额</td>
            <td colspan="1" align="center">实际入库数量</td>
            <td colspan="1" align="center">实际入库金额</td>
        </tr>
        <tbody id="tableExportPartTypeContent">
        </tbody>
    </table>  
    <a href="" id="tableExportD"></a>
</div> 

</body>
</html>
