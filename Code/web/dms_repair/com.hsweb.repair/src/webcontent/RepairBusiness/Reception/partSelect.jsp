<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description: 
-->

<head>
  <title>选择配件数量</title>  
  <style type="text/css">
  .title {
      width: 60px;
      text-align: right;
  }

  .form_label {
      width: 72px;
      text-align: right;
  }

  .required {
      color: red;
  }

  .rmenu {
      font-size: 14px;
      /* font-weight: bold; */
      text-align: left;
      margin: 0;
      padding-left: 25px;
      height: 18px;
      color: #fff;
      width: auto;
      margin-left: 20px;
      margin-top: 20px;
      background-size: 50%;
  }
</style>

</head>

<body>

  <div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" />
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
              <span class="fa fa-search fa-lg"></span>&nbsp;查询</a>


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
                                    dataField="partlist"
                                    url="com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext"
                                    showModified="false"
                                    sortMode="client"
                                    ondrawcell=""
                                    onrowdblclick=""
                                    idField="id"
                                    totalField="page.count"
                                    allowCellSelect="true" allowCellEdit="false">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                                    <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
                                    <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
                                    <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量"></div>
                                    <div allowSort="true" datatype="float" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
                                    <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
                                    <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
                                    <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
                                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                                    <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
                                    <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
                                    <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
                                    <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
                                    <div field="serviceId" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
                                    <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
                                </div>
                            </div>
</div>

<script type="text/javascript">
    nui.parse();
    var mainGrid = nui.get("mainGrid");

    function SetData(ids){
      var  id = ids[0];
      Search(id);
    }

function Search(pid) {
  var params = {
    partId:pid
  };
  mainGrid.load({params:params});
}
/*    
    mainGrid.on("rowdblclick",function(e){
        var record = e.record;
        var tid = record.id;
        newCheckBill(tid);
        CloseWindow("close");
    });
*/
/*
    function newCheckBill(tid) {
        var item={};
        item.id = "checkDetail";
        item.text = "查车单";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp?tid="+tid+"&actionType=new";
        item.iconCls = "fa fa-cog";
        window.parent.activeTab(item);
    }
*/

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

</body>

</html>