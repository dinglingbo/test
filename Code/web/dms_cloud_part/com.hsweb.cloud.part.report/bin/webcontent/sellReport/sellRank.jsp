<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>销售排行</title>
<script src="<%=webPath + contextPath%>/report/js/sellRank.js?v=1.2.1"></script>
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
                	<li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">本季</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">上季</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(8)" id="type8">本年</li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">上年</li>
                </ul>

                <label style="font-family:Verdana;">出库日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                <input id="searchStoreId"
                           name="searchStoreId" emptyText="仓库"
                           dataField="storehouse" valueField="id" textField="name" data="storehouse"
                           class="nui-combobox"  allowInput="true"
                           width="100px"/>
                <input name="searchOrgCarBrandId"
                       id="searchOrgCarBrandId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       valueFromSelect="true"
                       emptyText="厂牌"
                       url=""
                       width="100px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100px"
                       nullItemText="请选择..."/>
                <input id="searchOrderMan" emptyText="业务员"
                           name="searchOrderMan"
                           class="nui-textbox" 
                           width="100px"/>
                <input name="businessTypeId" visible="false"
                       id="businessTypeId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       valueFromSelect="true"
                       emptyText="销售类型"
                       url=""
                       width="100px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100px"
                       nullItemText="请选择..."/>
                <!-- 
                <input id="partName" width="100px" emptyText="配件名称" class="nui-textbox"/>
                <input id="partBrandId" width="100px" textField="name" valueField="id" emptyText="配件品牌" class="nui-combobox" allowinput="true" valueFromSelect="true"/> -->
                <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择客户..." onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
                <input id="guestType" width="100px" textField="name" valueField="customid" emptyText="客户分类" visible="false" class="nui-combobox" allowinput="true" valueFromSelect="true"/>

                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
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

        <div title="按客户排行" id="clientGridTab" name="clientGridTab" url="" >
            <div id="clientGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="clientList"
                 idField="guestId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="shortName" summaryType="count" width="100" headerAlign="center" header="客户简称"></div>
                    <div allowSort="true" field="provinceId" width="50" headerAlign="center" header="省份"></div>
                    <div allowSort="true" field="cityId" width="50" headerAlign="center" header="城市"></div>
                    <div allowSort="true" field="clientCode" width="50" headerAlign="center" header="客户编码"></div>
                    <div allowSort="true" field="guestType" width="80" headerAlign="center" header="客户类型"></div>
                    <div allowSort="true" field="fullName" width="100" headerAlign="center" header="客户全称"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
                </div>
            </div>

        </div> 
        <div title="按业务员排行" id="manGridTab" name="manGridTab" url="" >
            <div id="manGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="manList"
                 idField="orderMan"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="name" summaryType="count" width="100" headerAlign="center" header="业务员"></div>
                    <div allowSort="true" field="deptName" width="50" headerAlign="center" header="部门"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                </div>
            </div>

        </div> 
        <div title="按商品排行" id="partGridTab" name="partGridTab" >
            
            <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="partList"
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
                    <div allowSort="true" field="oemCode" width="80" headerAlign="center" header="OE码"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
                </div>
            </div>

        </div>
        <div title="按仓库排行" id="storeGridTab" name="storeGridTab" >
            <div id="storeGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="storeList"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="storeId" summaryType="count" width="80" headerAlign="center" header="仓库"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
                </div>
            </div>

        </div>
        <div title="按销售类型排行" id="businessTypeGridTab" name="businessTypeGridTab" >
            <div id="businessTypeGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="typeList"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="businessTypeId" summaryType="count" width="80" headerAlign="center" header="销售类型"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
                </div>
            </div>

        </div>
        <div title="按品牌排行" name="partBrandGridTab" url="" >
          
            <div id="partBrandGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="brandList"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="partBrandId" summaryType="count" width="80" headerAlign="center" header="配件品牌"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
                </div>
            </div>

        </div>
        <div title="按配件类型排行" name="partTypeGridTab" url="" >
          
            <div id="partTypeGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="typeList"
                 idField="detailId"
                 ondrawcell="onDrawCell"
                 sortMode="client"
                 url="" 
                 showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="carTypeIdF" summaryType="count" width="80" headerAlign="center" header="配件类型"></div>
                    <div field="sellQty" allowSort="true" headerAlign="center"
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
                    <div field="trueEnterAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >实销成本</div>
                    <div field="trueProfitAmt" allowSort="true" headerAlign="center"
                      width="60" summaryType="sum" >毛利</div>
                    <div field="trueProfitRate" allowSort="true" headerAlign="center"
                      width="60" >毛利率</div>
                      
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
            <td colspan="1" align="center">OE码</td>
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
<div id="exportDiv" style="display:none"> 
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:450px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">出库日期:</td>
                <td>
                    <input id="sAuditDate" name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eAuditDate" name="eAuditDate"
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
                    <span style="letter-spacing: 6px;">客户</span>:
                </td>
                <td colspan="3">
                    <input id="advanceGuestId"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择客户..."
                           onbuttonclick="selectSupplier('advanceGuestId')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">省份:</td>
                <td>
                    <input id="provinceId"
                           name="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="code"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                </td>
                <td class="title">城市:</td>
                <td>
                    <input id="cityId"
                           name="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="code"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
                <td class="title">仓库:</td>
                <td colspan="3">
                    <input id="elStoreId"
                           name="elStoreId"
                           dataField="storehouse" valueField="id" textField="name" data="storehouse"
                           class="nui-combobox"  allowInput="true"
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">厂牌:</td>
                <td colspan="3">
                    <input name="orgCarBrandId"
                       id="orgCarBrandId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       valueFromSelect="true"
                       emptyText="请选择..."
                       url=""
                       width="100%"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
                <td class="title">部门:</td>
                <td colspan="3">
                    <input id="elPartment"
                           name="elPartment"
                           dataField="" valueField="id" textField="deptName" data=""
                           class="nui-combobox"  allowInput="true"
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">业务员:</td>
                <td colspan="3">
                	<input id="elOrderMan"
                           name="elOrderMan"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">配件ID:</td>
                <td colspan="3">
                    <input id="partId"
                           name="partId"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>
