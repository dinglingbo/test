<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>

<head>
<title>配件类型汇总按月排行</title>
<script src="<%=webPath + contextPath%>/manage/js/report/partTypePchsForMonth.js?v=1.1.11"></script>
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

        <label style="font-family:Verdana;">开始日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                <input id="partName" width="100px" emptyText="配件名称" class="nui-textbox"/>
                <input id="partBrandId" width="100px" textField="name" valueField="id" emptyText="配件品牌" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="兼职公司" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

            </td>
        </tr>
    </table>
</div>
  
  
    <div class="nui-fit">
    <!-- 供应商排行  -->
      <div id="rightGrid" class="nui-datagrid"
        style="width: 100%; height: 100%;" showPager="false" pageSize="10"
        sizeList="[10,20,50]" allowAlternating="true" 
          url="" dataField="typeList" idField="carTypeIdF" 
                ondrawcell="onRightGridDraw" sortMode="client"
                showSummaryRow="true"     allowCellWrap = true   
        parentField="parentId"> 
        <div property="columns" width="10">
            <div header="   ">
              <div property="columns" width="10">
                <div field="partBrandId" allowSort="true" headerAlign="center"width="60"  >配件类型</div>
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