<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>维修接待</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.4"></script>
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
    <div class="">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch">制单</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch">维修</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch">完工</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch">待结算</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch">已结算</a>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="120" textField="name" valueField="id" value="0" data="typeList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                </td>
            </tr>
        </table>

        <div id="advancedMore" style="width:80%;height:65px;display:none;">

            <div id="advancedSearchForm" class="form">
                <table style="width:100%;">
                  <tr>
                        <td class="title">进厂日期:</td>
                        <td>
                            <input id="sOrderDate"
                                   name="sOrderDate"
                                   width="100%"
                                   class="nui-datepicker"/>
                        </td>
                        <td class="">至</td>
                        <td>
                            <input id="eOrderDate"
                                   name="eOrderDate"
                                   class="nui-datepicker"
                                   format="yyyy-MM-dd"
                                   timeFormat="H:mm:ss"
                                   showTime="false"
                                   showOkButton="false"
                                   width="100%"
                                   showClearButton="false"/>
                        </td>
                        <td class="title">
                            <label>维修顾问：</label>
                        </td>
                        <td>
                            <input name="billTypeId"
                                 id="billTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 valueFromSelect="true"
                                 onvaluechanged=""
                                 nullItemText="请选择..."/>
                        </td>
                        <td class="title">
                            <label>维修类型：</label>
                        </td>
                        <td>
                            <input name="billTypeId"
                                 id="billTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 valueFromSelect="true"
                                 onvaluechanged=""
                                 nullItemText="请选择..."/>
                        </td>
                        <td class="title">
                            <label>业务类型：</label>
                        </td>
                        <td>
                            <input name="billTypeId"
                                 id="billTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="customid"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 valueFromSelect="true"
                                 onvaluechanged=""
                                 nullItemText="请选择..."/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title">预计交车:</td>
                        <td>
                            <input id="sOrderDate"
                                   name="sOrderDate"
                                   width="100%"
                                   class="nui-datepicker"/>
                        </td>
                        <td class="">至</td>
                        <td>
                            <input id="eOrderDate"
                                   name="eOrderDate"
                                   class="nui-datepicker"
                                   format="yyyy-MM-dd"
                                   timeFormat="H:mm:ss"
                                   showTime="false"
                                   showOkButton="false"
                                   width="100%"
                                   showClearButton="false"/>
                        </td>
                        <td>
                            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;" plain="true">清空</a>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>


    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               sizeList=[20,50,100,200]
               dataField=""
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                  <div field="fullName" name="comPartCode" width="40" headerAlign="center" header="进程"></div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="车牌"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="品牌"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="车型"></div>
                  <div field="fullName" name="comPartCode" width="120" headerAlign="center" header="VIN码"></div>
                  <div field="fullName" name="comPartCode" width="50" headerAlign="center" header="客户姓名"></div>
                  <div field="fullName" name="comPartCode" width="80" headerAlign="center" header="联系方式"></div>
                  <div field="fullName" name="comPartCode" width="50" headerAlign="center" header="维修顾问"></div>
                  <div field="fullName" name="comPartCode" width="80" headerAlign="center" header="工单号"></div>
              </div>
          </div>
    </div>



</div>


<div id="editFormSellOutDetail" style="display:none;">
  <div id="innerSellOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
       showPager="false"
       dataField="pjSellOrderDetailList"
       idField="detailId"
       ondrawcell="onDrawCell"
       sortMode="client"
       url=""
       showSummaryRow="true">
      <div property="columns">
          <div type="indexcolumn">序号</div>
          <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
          <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
          <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
          <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
          <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
          <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
          <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
          <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
          <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
          <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
          <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
      </div>
  </div>
</div>


</body>
</html>