<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>采购排行</title>
<script src="<%=webPath + contextPath%>/manage/js/report/purchaseRank.js?v=1.0.0"></script>
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

                <label style="font-family:Verdana;">入库日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                <input id="partName" width="100px" emptyText="配件名称" class="nui-textbox"/>
                <input id="partBrandId" width="100px" textField="name" valueField="id" emptyText="配件品牌" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
                <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
                <input id="supplierType" width="100px" textField="name" valueField="customid" emptyText="供应商分类" visible="false" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
				
				<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				<a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
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

        <div title="按供应商排行" id="supplierGridTab" name="supplierGridTab" url="" >
            <div id="supplierGrid" class="nui-datagrid" style="width:1300px;height:100%;"
                 showPager="false"
                 dataField="supplierList"
                 idField="guestId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                  allowCellWrap = true
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="shortName" summaryType="count" width="100" headerAlign="center" header="供应商简称"></div>
                    <div allowSort="true" field="supplierCode" width="150" headerAlign="center" header="供应商编码"></div>
                    <div allowSort="true" field="supplierType" width="100" headerAlign="center" header="供应商类型"></div>
                    <div allowSort="true" field="fullName" width="220" headerAlign="center" header="供应商全称"></div>
                    <div allowSort="true" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="入库数量" dataType="float"></div>
                    <div allowSort="true" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="入库金额" dataType="float"></div>
                    <div allowSort="true" field="orderRtnQty" summaryType="sum" width="60" headerAlign="center" header="退货数量" dataType="float"></div>
                    <div allowSort="true" field="orderRtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额" dataType="float"></div>
                    <div allowSort="true" field="trueQty" summaryType="sum" width="100" headerAlign="center" header="实际入库数量" dataType="float"></div>
                    <div allowSort="true" field="trueAmt" summaryType="sum" width="100" headerAlign="center" header="实际入库金额" dataType="float"></div>
                   
                </div>
            </div>

        </div> 
        <div title="按商品排行" id="partGridTab" name="partGridTab" >
            
            <div id="partGrid" class="nui-datagrid" style="width:1300px;height:100%;"
                 showPager="false"
                 dataField="partList"
                 idField="partId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                  allowCellWrap = true
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="partCode" summaryType="count" width="180" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="140" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="配件品牌"></div>
                    <div allowSort="true" field="oemCode" width="180" headerAlign="center" header="OEM码"></div>
                    <div allowSort="true" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="入库数量" dataType="float"></div>
                    <div allowSort="true" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="入库金额" dataType="float"></div>
                    <div allowSort="true" field="orderRtnQty" summaryType="sum" width="60" headerAlign="center" header="退货数量" dataType="float"></div>
                    <div allowSort="true" field="orderRtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额" dataType="float"></div>
                    <div allowSort="true" field="trueQty" summaryType="sum" width="100" headerAlign="center" header="实际入库数量" dataType="float"></div>
                    <div allowSort="true" field="trueAmt" summaryType="sum" width="100" headerAlign="center" header="实际入库金额" dataType="float"></div>
                     
                </div>
            </div>

        </div>
        <div title="按品牌排行" name="partBrandGridTab" url="" >
          
            <div id="partBrandGrid" class="nui-datagrid" style="width:1000px;height:100%;"
                 showPager="false"
                 dataField="brandList"
                 idField="partBrandId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 allowCellWrap = true
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="partBrandId" summaryType="count" width="80" headerAlign="center" header="配件品牌" dataType="float"></div>
                    <div allowSort="true" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="入库数量" dataType="float"></div>
                    <div allowSort="true" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="入库金额" dataType="float"></div> 
                    <div allowSort="true" field="orderRtnQty" summaryType="sum" width="60" headerAlign="center" header="退货数量" dataType="float"></div>
                    <div allowSort="true" field="orderRtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额" dataType="float"> </div>
                    <div allowSort="true" field="trueQty" summaryType="sum" width="100" headerAlign="center" header="实际入库数量" dataType="float"></div>
                    <div allowSort="true" field="trueAmt" summaryType="sum" width="100" headerAlign="center" header="实际入库金额" dataType="float"></div>
                    
                </div>
            </div>

        </div>
        <div title="按配件类型排行" name="partTypeGridTab" url="" >
          
            <div id="partTypeGrid" class="nui-datagrid" style="width:1000px;height:100%;"
                 showPager="false"
                 dataField="typeList"
                 idField="carTypeIdF"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 allowCellWrap = true
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="carTypeIdF" summaryType="count" width="80" headerAlign="center" header="配件类型" dataType="float"></div>
                    <div allowSort="true" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="入库数量" dataType="float"></div>
                    <div allowSort="true" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="入库金额" dataType="float"></div>
                    <div allowSort="true" field="orderRtnQty" summaryType="sum" width="60" headerAlign="center" header="退货数量" dataType="float"></div>
                    <div allowSort="true" field="orderRtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额" dataType="float"></div>
                    <div allowSort="true" field="trueQty" summaryType="sum" width="100" headerAlign="center" header="实际入库数量" dataType="float"></div>
                    <div allowSort="true" field="trueAmt" summaryType="sum" width="100" headerAlign="center" header="实际入库金额" dataType="float"></div>
               
                </div>
            </div>

        </div>    
    </div>
</div>

<div id="exportDiv"  style="display:none">  

</div>  

</body>
</html>
