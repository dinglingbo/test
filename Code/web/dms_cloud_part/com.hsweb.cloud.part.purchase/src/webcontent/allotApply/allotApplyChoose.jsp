<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
    <title>调拨单选择</title>
    <script src="<%=webPath + contextPath%>/purchase/js/allotApply/allotApplyChoose.js?v=1.0.0"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">
    html,body {
       margin: 0;
       padding: 0;
       border: 0;
       width: 100%;
       height: 100%;
       overflow: hidden;
   }

   .form_label {
       width: 72px;
       text-align: right;
   }

</style>
</head>
<body>

    <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
        <!-- 上 -->
        <div size="50%" showCollapseButton="false">
         <div class="nui-fit">
            <div  class="nui-toolbar" style="padding:2px;border-bottom:1;">
                <table id="top"style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <label style="font-family:Verdana;" style="display:none;">申请日期 从：</label>
                            <input style="" class="nui-datepicker" id="sOrderDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <label style="font-family:Verdana;" style="display:none;">至</label>
                            <input style=""class="nui-datepicker" id="eOrderDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <input id="guestId"
                                   name="guestId"
                                   class="nui-buttonedit"
                                   emptyText="请选择调出方..."
                                   onbuttonclick="selectSupplier('guestId')"
                                   width="150px"
                                   selectOnFocus="true" />
                            <input class="nui-textbox" width="120px" id="serviceId" emptyText="申请单号" selectOnFocus="true" name="serviceId"/>
                            <a class="nui-button" iconCls="" plain="true" onclick="onSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            
                        </td>
                    </tr>
                </table>
            </div>
                    
            <div class="nui-fit">             
                <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
                borderStyle="border:1;"
                selectOnLoad="true"
                showPager="true"
                pageSize="20"
                sizeList=[20,50,100,200]
                dataField="pjAllotApplyMainList"
                url=""
                showModified="false"
                sortMode="client"
                ondrawcell=""
                onrowdblclick=""
                idField="id"
                totalField="page.count"
                allowCellSelect="true" 
                allowCellEdit="true"  
                multiSelect="false" 
                allowCellWrap = "false"
                showSummaryRow="true"
                contextMenu="#gridMenu"
                >
                <div property="columns">
                   <div type="checkcolumn" width="40" class="mini-radiobutton" header="选择"></div> 
                   <div type="indexcolumn" width="40" headerAlign="center">序号</div>
                   <div allowSort="true" field="serviceId" name="serviceId" width="150" headerAlign="center" header="申请单号" summaryType="count"></div>
                   <div allowSort="true" field="guestFullName" name="guestFullName" width="120" headerAlign="center" header="调出方"></div>
                   <div allowSort="true" field="status" name="status" width="50" headerAlign="center" header="状态"></div>
                   <div allowSort="true" field="orderMan" name="orderMan" width="50" headerAlign="center" header="申请人"></div>
                   <div allowSort="true" field="orderDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="申请日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
                   <div allowSort="true" field="auditor" name="auditor" width="50" headerAlign="center" header="提交人"></div>
                   <div allowSort="true" field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="提交日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
                   <div allowSort="true" field="remark" visible="true"  name="remark" width="150" headerAlign="center" header="备注">
                   </div>
           </div>
       </div>
   </div>
</div>
</div>


<!-- 下 -->
<div showCollapseButton="false">
    <div class="nui-fit">
       <div class="nui-fit">
        <div  id="detailGrid" dataField="data" class="nui-datagrid" style="width: 100%; height: 100%;"
         sortMode="client" showPager="false"
        totalField="page.count" allowSortColumn="true"   allowCellSelect="true" 
        allowCellEdit="true"  multiSelect="false" allowCellWrap = true showSummaryRow="true"
        frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div allowSort="true" type="indexcolumn" headerAlign="center" width="30">序号</div> 
            
            <div allowSort="true" field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码" summaryType="count"></div>
            <div field="partName" name="fullName" headerAlign="center" allowSort="true" visible="true" width="150" header="配件全称"></div>
            <div field="applyQty" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="申请数量"></div>
            <div field="hasAcceptQty" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="受理数量"></div>
            <div field="hasCancelQty" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="调整数量"></div>
            <div field="hasInQty" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="已入库数量"></div>
            <div field="remark" id="remark" name="remark" headerAlign="center" allowSort="true" visible="true" width="200" header="备注"></div>
           
       </div>
   </div>
</div>
</div>
</div>

</div>

</body>
</html>