<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:24:24
  - Description:
-->
<head>
<title>销价行情</title>
<script src="<%=webPath + contextPath%>/baseDataPart/js/sellPrice/sellPrice.js?v=1.0.0"></script>
<style type="text/css">
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td>
                <span style="color: blue;">查询4S店最新销售价，给客户精准报价，提升工作效率，可按配件编码、配件名称、配件描述信息进行查询</span>
            </td>
        </tr>
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">品牌：</label>
                <input id="brand"
                       class="nui-combobox width1"
                       textField="text"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <label style="font-family:Verdana;">查询关键字：</label>
                <input class="nui-textbox" width="100" id="key"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
         url=""  idField="id" multiSelect="true"
         pageSize="50"
         idField="PartID"
         dataField="sellPriceList"
         sortMode="client"
         frozenStartColumn="0"
         frozenEndColumn="4">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <!--<div type="checkcolumn" ></div>-->
            <div header="配件进价信息" headerAlign="center">
                <div property="columns">
                    <div field="PartCode" width="100" headerAlign="center" header="配件编码"  allowSort="true"></div>
                    <div field="PartName" width="80" headerAlign="center" header="配件名称"  allowSort="true"></div>
                    <div field="CarPlate" width="100" headerAlign="center" header="品牌"  allowSort="true"></div>
                    <div field="CarModel" width="100" headerAlign="center" header="品牌车型"  allowSort="true"></div>
                </div>
            </div>
            <div header="配件基本信息" headerAlign="center">
                <div property="columns">
                    <div field="Price4S" width="80" headerAlign="center" header="4S含税销售价"  allowSort="true"></div>
                    <div field="SuggestionPrice" width="80" headerAlign="center" header="建议销价"  allowSort="true"></div>
                    <div field="WholesalePrice" width="100" headerAlign="center" header="4S批发价"  allowSort="true"></div>
                    <div field="Remark" headerAlign="center" header="备注"  allowSort="true"></div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
