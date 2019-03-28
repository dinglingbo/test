<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>

<head>
<title>配件出库分析表</title>
<script src="<%=webPath + contextPath%>/manage/js/report/repairOutForPartName.js?v=1.0.0"></script>
</head>

<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
        		<label style="font-family:Verdana;">出库日期 从：</label>
                <input class="nui-datepicker" id="sPickDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="ePickDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                
                <label style="font-family:Verdana;">结算日期日期 从：</label>
                <input class="nui-datepicker" id="sOutDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="eOutDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

            </td>
        </tr>
    </table>
</div>
  
  
   <div class="nui-fit">
      <div id="rightGrid" class="nui-datagrid"
        style="width: 100%; height: 100%;" showPager="false" pageSize="10"
         allowAlternating="true" 
          url="" dataField="manList" idField="empName" 
                ondrawcell="" sortMode="client"
                showSummaryRow="true"     allowCellWrap = true   
        parentField="parentId"> 
        <div property="columns" width="10">
            <div header="   ">
              <div property="columns" width="10">
                <div field="empName" allowSort="true" headerAlign="center"width="60"  >领料人</div>
                </div>
            </div>
            <div header="2018">
            <div property="columns" width="10">
            <div header="1">
            <div property="columns" width="10">
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >入库金额</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >退货数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >实际入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float"  >实际入库金</div>
                </div></div>
            <div header="2">
            <div property="columns" width="10">
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float" >入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >入库金额</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >退货数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float"  >实际入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float"  >实际入库金</div>
                </div></div></div></div>
              <div header="2018total">
              <div property="columns" width="10">
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >入库金额</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float"  >退货数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120" dataType="float"  >实际入库数量</div>
              <div field="rpCode" allowSort="true" headerAlign="center"
                width="120"  dataType="float" >实际入库金</div>
              
                
            </div>
            </div>
            </div>
        </div>
      </div>
  
    </div>

  
</body>
</html>