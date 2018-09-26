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
  <script
	src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/partSelect.js?v=1.0.4"></script> 
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
                <!-- <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" />
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
                  <span class="fa fa-search fa-lg"></span>&nbsp;查询</a> -->

                  <a class="nui-button" iconCls="" plain="true" onclick="onOk">
                      <span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                  </td>
              </tr>
          </table>

      </div>

      <div class="nui-fit">

        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
        url=""
        dataField="partlist"
        idField="id" 
        showModified="false"
        allowResize="true" 
        showSummaryRow="true"
        pageSize="20"
        sizeList=[20,50,100,200]
        allowCellEdit="true" allowCellSelect="true" 
        editNextOnEnterKey="true"  editNextRowCell="true"

        >
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="id" name="id" width="100" headerAlign="center" header="id" visible="false"></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div field="stockQty" name="stockQty" allowSort="true"  width="60" headerAlign="center" header="库存数量" datatype="float" summaryType="sum"></div>
            <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
            <div field="outQty" name="outQty" width="100" headerAlign="center" header="领料数量" datatype="float" summaryType="sum">
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
            <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
            <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
            <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
            <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
            <div field="serviceId" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
            <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
            <div field="partId" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件id"></div> 
            <div field="partNameId" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件nameid"></div>         
            <div field="partFullName" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件fullname"></div>         
        </div> 
    </div>
</div>

</body>

</html>