<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>厂家订货详情</title>
<script src="<%=webPath + contextPath%>/sales/inventory/js/carSalesDetails.js?v=1.1.3"></script>
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
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
.mini-tabs-scrollCt{
	display:none;
}
.mini-tabs-body-top{
	padding:0px;
}

</style>

<body>
    <%@include file="/sales/inventory/carSalesDetail.jsp" %>
	<input name="frameColorId" id="frameColorId" class="nui-combobox" textField="name" valueField="id" allowInput="true" visible="false"/>
    <input name="interialColorId" id="interialColorId" class="nui-combobox" textField="name" valueField="id" allowInput="true" visible="false"/>

<div id="advancedMorePartWin" class="nui-window"
     title="配件选择" style="width:900px;height:550px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="4"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="code" name="code" width="100" headerAlign="center" header="车型编码"></div>
                <div field="fullName" name="fullName" width="150" headerAlign="center" header="车型名称"></div>
                <div field="carBrandId" name="carBrandId" width="80" headerAlign="center" header="品牌"></div>
                <div field="carSeriesId" name="carSeriesId" width="80" headerAlign="center" header="车系"></div>
                <div field="fyear" name="fyear" width="60" headerAlign="center" header="年款"></div>
                <div field="guidingPrice" name="guidingPrice" width="80" headerAlign="center" header="厂商指导价"></div>
                <div field="outputVolume" name="outputVolume" width="60" headerAlign="center" header="排量"></div>    
                <div field="engineModelNo" name="engineModelNo" width="100" headerAlign="center" header="发动机型号"></div>    
                <div field="inletType" name="inletType" width="80" headerAlign="center" header="进气形式"></div>    
<!--                 <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="缸数"></div> -->
                <div field="gearBox" name="gearBox" width="100" headerAlign="center" header="变速箱"></div>    
                <div field="driveMode" name="driveMode" width="100" headerAlign="center" header="驱动方式"></div>
                <div field="powerType" name="powerType" width="100" headerAlign="center" header="能源"></div>
                <div field="carStructureType" name="carStructureType" width="100" headerAlign="center" header="规格"></div>
                <div field="level" name="level" width="100" headerAlign="center" header="级别"></div>    
                <div field="isImported" name="isImported" width="100" headerAlign="center" header="是否进口"></div>  
                <div field="configure" name="configure" width="100" headerAlign="center" header="配置"></div>  
                <div field="chargingTime" name="chargingTime" width="100" headerAlign="center" header="充电时间"></div>  
                <div field="enduranceMileage" name="enduranceMileage" width="100" headerAlign="center" header="续航里程"></div>                                                                                 
                <div allowSort="true"  field="stockQty" name="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
              </div>
          </div>
    </div>
</div>

<div id="advancedAddWin" class="nui-window"
     title="快速录入配件" style="width:400px;height:200px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
<!--          <div class="nui-toolbar" style="padding:0px;border-bottom:0;"> -->
<!--             <table style="width:80%;"> -->
<!--                 <tr> -->
<!--                     <td style="width:80%;"> -->
<!--                         <a class="nui-button" iconCls="" plain="true" onclick="onAdvancedAddOk()"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a> -->
<!--                         <a class="nui-button" iconCls="" plain="true" onclick="onAdvancedAddCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
<!--                     </td> -->
<!--                 </tr> -->
<!--             </table> -->
<!--         </div> -->
    <div id="advancedAddForm" class="form">
        <table style="width:100%;">
          
            <tr>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="格式:编码*数量*单价" width="100%" style="height: 110px;" id="fastCodeList" name="fastCodeList"></textarea>
                </td>
            </tr>
            
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">供应商名称：</td>
            <td colspan="1" align="left"><span id="eGuestName"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">备注：</td>
            <td colspan="1" align="left"><span id="eRemark"></span></td>
        </tr>
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件全称</td>
            <td colspan="1" align="center">品牌车型</td>
            <td colspan="1" align="center">单位</td>
            <td colspan="1" align="center">数量</td>
            <td colspan="1" align="center">单价</td>
            <td colspan="1" align="center">金额</td>
            <td colspan="1" align="center">备注</td>
            <td colspan="1" align="center">仓库</td>
            <td colspan="1" align="center">仓位</td>
            <td colspan="1" align="center">OEM码</td>
            <td colspan="1" align="center">规格/方向/颜色</td> 
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  
    
<div id="advancedTipWin" class="nui-window"
        title="未成功导入配件" style="width:400px;height:200px;"
        showModal="true"
        allowResize="false"
        allowDrag="true">
        <div id="advancedTipForm" class="form">
            <table style="width:100%;height: 100%;">
            
                <tr>
                    <td colspan="3">
                        <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100%;" id="imprtPastCodeList" name="imprtPastCodeList"></textarea>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

</body>
</html>
