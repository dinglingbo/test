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
  <title>工单-预约首页</title>
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
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            起始日期<input class="nui-textbox" id="" emptyText="起始日期" width="120"/>
            结束日期<input class="nui-textbox" id="" emptyText="结束日期" width="120"/>
            服务顾问<input class="nui-combobox" id="" emptyText="服务顾问" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新建</a>
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
          <div field="" name="" width="40" headerAlign="center" align="center" >预约号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >预约门店</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >到店时间</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >品牌车型</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >联系人</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >联系电话</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >服务顾问</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
        </div>
      </div>
    </div>




 

</body>
</html>