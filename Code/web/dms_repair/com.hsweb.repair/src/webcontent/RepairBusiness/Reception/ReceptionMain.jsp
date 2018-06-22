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
<title>综合开单</title>
<script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.7"></script>
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
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)">制单</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)">维修</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)">完工</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)">待结算</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)">已结算</a>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                </td>
            </tr>
        </table>

        <div id="advancedMore" style="width:80%;height:40px;display:none;">

            <div id="advancedSearchForm" class="form">
                <table style="width:100%;">
                  <tr>
                        <td class="title">进厂日期:</td>
                        <td style="width:100">
                            <input id="sEnterDate"
                                   name="sEnterDate"
                                   width="100%"
                                   class="nui-datepicker"/>
                        </td>
                        <td style="width:15">至</td>
                        <td style="width:100">
                            <input id="eEnterDate"
                                   name="eEnterDate"
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
                        <td style="width:100">
                            <input name="mtAdvisorId"
                                 id="mtAdvisorId"
                                 class="nui-combobox width1"
                                 textField="empName"
                                 valueField="empId"
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
                        <td style="width:100">
                            <input name="serviceTypeId"
                                 id="serviceTypeId"
                                 class="nui-combobox width1"
                                 textField="name"
                                 valueField="id"
                                 emptyText="请选择..."
                                 url=""
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 valueFromSelect="true"
                                 onvaluechanged=""
                                 nullItemText="请选择..."/>
                        </td>
                        <td>
                            <a class="nui-button" onclick="clear()" style="width:60px;" plain="true">清空</a>
                        </td>
                        <td style="display:none;">
                            <input name="carBrandId"
                                 id="carBrandId"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="id"/>
                            <input name="receTypeId"
                                 id="receTypeId"
                                 class="nui-combobox"
                                 textField="name"
                                 valueField="customid"/>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>


    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                  <div field="status" name="status" width="40" headerAlign="center" header="进程"></div>
                  <div field="carNO" name="carNO" width="60" headerAlign="center" header="车牌"></div>
                  <div field="carBrandId" name="carBrandId" width="60" headerAlign="center" header="品牌"></div>
                  <div field="carModel" name="carModel" width="160" headerAlign="center" header="车型"></div>
                  <div field="carVin" name="carVin" width="120" headerAlign="center" header="VIN码"></div>
                  <div field="guestFullName" name="guestFullName" width="50" headerAlign="center" header="客户姓名"></div>
                  <div field="guestTel" name="guestTel" width="80" headerAlign="center" header="联系方式"></div>
                  <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="维修顾问"></div>
                  <div field="serviceTypeId" name="serviceTypeId" width="50" headerAlign="center" header="业务类型"></div>
                  <div field="serviceCode" name="serviceCode" width="120" headerAlign="center" header="工单号"></div>
              </div>
          </div>
    </div>



</div>

<div id="editFormDetail" style="display:none;padding:5px;position:relative;">
  <div id="innerItemGrid"
       borderStyle="border-bottom:0;"
       class="nui-datagrid"
       dataField="list"
       style="width: 100%; height:100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
          <div headerAlign="center" type="indexcolumn" width="30">序号</div>
          <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
          <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
          <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
          <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
          <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">小计</div>
          <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
          <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
          <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
          <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
          <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
      </div>
  </div>
  <div id="innerPartGrid"
       dataField="list"
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
          <div headerAlign="center" type="indexcolumn" width="30">序号</div>
          <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
          <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
          <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
          <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
          <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
          <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
          <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
      </div>
  </div>
</div>


</body>
</html>