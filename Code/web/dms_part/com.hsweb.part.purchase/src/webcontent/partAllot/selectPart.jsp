<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
  <%@include file="/common/commonRepair.jsp"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2018-09-30 17:18:32
  - Description:
-->

    <head>
      <title>选择配件</title>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
      <script src="<%=webPath + contextPath%>/purchasePart/js/partAllot/selectPart.js?v=1.0.1"></script>
    </head>
    <body>
      <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <div class="form" id="queryForm">
          <table class="table" id="table1">
            <tr>
               <td>
                   <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <input class="nui-textbox" width="100" id="search-code" name="code" onenter="search" emptyText="编码"/>
                    <!-- <label style="font-family:Verdana;">配件名称/拼音：</label> -->
                    <input class="nui-textbox" width="100" id="search-name" name="name" onenter="search" emptyText="配件名称/拼音"/>
                   <!--  <label style="font-family:Verdana;">品牌车型：</label> -->
                     <input id="applyCarModel" width="120px"  emptyText="" class="nui-textbox" onenter="search" emptyText="品牌车型"/>
                    <!--  <label style="font-family:Verdana;">品牌：</label> -->
                     <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择品牌"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择品牌"/>
                    <input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="nameCn"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           style="display:none;"
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
               </td>
              <td style="width:500px">
                 <a class="nui-button" iconCls="" plain="true" onclick="search"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                 <a class="nui-button" iconCls="" plain="true" onclick="onOk" id="onOk">
                 <span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                 <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
              </td>
            </tr>
          </table>
          </div>
       </div>
        <div class="nui-fit">
          <div id="rpsPartGrid" dataField="detailList" class="nui-datagrid" 
               style="float:left;height:100%;" 
               showPager="true" 
               showModified="false"
               editNextOnEnterKey="true" 
               allowSortColumn="true" 
               allowCellSelect="true" 
               allowCellEdit="true" 
               allowCellWrap = "true"
               totalField="page.count" 
               >
            <div property="columns">
                <div width="40" type="indexcolumn">序号</div>
	            <div header="配件信息" headerAlign="center">
	                <div property="columns">
	                    <div allowSort="true" field="comPartCode" headerAlign="center" header="配件编码"></div>
	                    <div allowSort="true"width="100" field="comPartName" headerAlign="center" header="配件名称"></div>
	                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
	                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌"></div>
	                    <div allowSort="true" field="applyCarModel" name="applyCarModel" width="140" headerAlign="center" header="品牌车型"></div>
	                    <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
	                </div>
	            </div>
                <div header="库存信息" headerAlign="center">
		            <div property="columns">
		                <div allowSort="true" datatype="float" summaryType="sum" field="outableQty" width="60" headerAlign="center" header="数量"></div>
		                <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="单价"></div>
		                <div allowSort="true" datatype="float" summaryType="sum" field="totalAmt" width="60" headerAlign="center" header="金额"></div>
		                <!-- <div allowSort="true" field="detailRemark" width="120" headerAlign="center" header="备注"></div> -->
		            </div>
              </div>
              <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="storeId" width="90" headerAlign="center" header="仓库"></div>
                    <div allowSort="true" field="storeShelf" width="60" headerAlign="center" header="仓位"></div>
                   <!--  <div allowSort="true" field="chainStockAge" width="60" headerAlign="center" header="库龄"></div> -->
                    <div field="guestFullName" name="guestFullName" width="180" headerAlign="center" header="供应商" allowSort="true"></div>
                    <!-- <div field="orderMan" name="orderMan" width="60" headerAlign="center" header="采购员"></div>
                    <div field="taxSign" name="taxSign" width="60" headerAlign="center" header="是否含税"></div>
                    <div allowSort="true" field="enterDate"width="140" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="manualCode" width="180" summaryType="count" headerAlign="center" header="入库单号"></div> -->			                    
                </div>
            </div>
          </div>
      </div>
   </div>
 
</div>
      <script type="text/javascript">
        nui.parse();
      </script>
    </body>

    </html>