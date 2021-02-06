<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
    <title>移仓单主界面</title>
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/shiftPosition/shiftPositionOrderMain.js?v=1.1.22"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
                    
                    <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                     	<li iconCls="" onclick="quickSearch(14)" id="type14">所有</li>
                        <li iconCls="" onclick="quickSearch(12)" id="type12">草稿</li>
                        <li iconCls="" onclick="quickSearch(13)" id="type13">已审</li>
                    </ul>


                    <label style="font-family:Verdana;">移仓日期 从：</label>
                    <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                    <label style="font-family:Verdana;">至</label>
                    <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                    <span class="separator"></span> 


                    <input id="serviceId" width="130px" emptyText="移仓单号" class="nui-textbox"/>
                    <input id="storeId"
                       name="storeId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择移出仓库"
                       url=""
                       dataField="storehouse"
                       valuefromselect="true"
                       allowInput="true"
                       selectOnFocus="true"
                       showNullItem="false"
                       width="8%"
                       nullItemText="请选择..."
                       />
        			
        			<input id="receiveStoreId"
                       name="receiveStoreId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择移入仓库"
                       url=""
                       dataField="storehouse"
                       valuefromselect="true"
                       allowInput="true"
                       selectOnFocus="true"
                       showNullItem="false"
                       width="8%"
                       nullItemText="请选择..."
                       />

                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <!--                 <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <input class="nui-hidden" name="auditSign" id="auditSign"/>
    <input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list"
    idField="detailId"
    ondrawcell="onDrawCell"
    sortMode="client"
    url=""
    pageSize="10000"
    sizeList="[1000,5000,10000]"
    selectOnLoad="true"
    onshowrowdetail="onShowRowDetail"
    allowCellWrap = true
    showSummaryRow="true">
    <div property="columns">
        <!--             <div header="订单信息" headerAlign="center"> -->
            <div type="indexcolumn" width="20">序号</div>
            <div type="expandcolumn" width="15" ><span class="fa fa-plus fa-lg"></span></div>
			<div field="auditSign" name="auditSign" width="60" headerAlign="center" header="状态"></div>
            <div allowSort="true" field="serviceId" width="160" summaryType="count" headerAlign="center" header="订单单号"></div>
            <div allowSort="true" field="storeId" width="90" headerAlign="center" header="移出仓库"></div>
            <div allowSort="true" field="receiveStoreId" width="90" headerAlign="center" header="移入仓库"></div>
            <div allowSort="true" field="createDate" headerAlign="center" header="移仓日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="orderMan" name="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div field="auditor" name="auditor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
        </div>
        <!--             </div> -->
        

    </div> 
</div>


<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid"
   dataField="detailList"
   allowCellWrap = true
   class="nui-datagrid"
   style="width: 100%; height: 100px;"
   showPager="false"
   allowSortColumn="true">
   <div property="columns">
       <div headerAlign="center" type="indexcolumn" width="20">序号</div>
       <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
       <div field="comPartName" headerAlign="center" header="配件名称"></div>
       <div field="comPartBrandId" id="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
       <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
       <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量"></div>
       <div field="orderQty" name="stockOutQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="缺货数量"></div>
       <div field="comOemCode" width="100" headerAlign="center" allowSort="true" header="OEM码"></div>
       <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>
       <div field="comApplyCarModel" id="comApplyCarModel" width="140" headerAlign="center" header="品牌车型"></div>
   </div>
</div>
</div>


</body>
</html>
