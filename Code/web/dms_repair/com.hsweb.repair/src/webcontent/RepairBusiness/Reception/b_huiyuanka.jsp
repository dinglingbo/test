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
  <title>工单-查车</title>
  <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.8"></script>
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
<div id="tabs1" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;"  borderStyle="border:0;padding:0">
    <div title="卡管理" >

          <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;开卡</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;导出</a>
          </td>
        </tr>
      </table>

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
          <div field="" name="" width="40" headerAlign="center" align="center" >客户姓名</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >手机号码</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >车牌号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡类型</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡名称</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡内余额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >发卡门店</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >销售人员</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >开卡日期</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >截止日期</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
        </div>
      </div>
    </div>
    </div>
    <div title="开卡单" iconCls="icon-cut" >
        



    </div>
    <div title="卡模板管理" showCloseButton="true">
        


          <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;开卡会员卡</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;开卡计次卡</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;开卡套餐卡</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;开卡储值卡</a>
          </td>
        </tr>
      </table>

  </div>

      <div class="nui-fit">
        <div id="" class="nui-datagrid" style="width:100%;height:100%;"
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
          <div field="" name="" width="40" headerAlign="center" align="center" >卡名称</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡类型</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >适用范围</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >卡说明</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >发卡金额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >有效期</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
        </div>
      </div>
    </div>



    </div>
</div>

</div>






 

</body>
</html>