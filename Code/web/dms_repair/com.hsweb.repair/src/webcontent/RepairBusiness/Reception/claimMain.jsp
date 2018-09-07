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
  <title>工单-理赔单</title>
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
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="newClaimBill()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新建</a>
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
        url="com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext">
        <div property="columns">
          <div field="" name="" width="40" headerAlign="center" align="center" >套餐名称号</div>
          <div field="guestFullName" name="guestFullName" width="40" headerAlign="center" align="center" >客户姓名</div>
          <div field="guestMobile" name="guestMobile" width="40" headerAlign="center" align="center" >手机号码</div>
          <div field="carNO" name="carNO" width="40" headerAlign="center" align="center" >车牌号</div>
          <div field="carModel" name="carModel" width="40" headerAlign="center" align="center" >车型</div>
          <div field="carVin" name="carVin" width="40" headerAlign="center" align="center" >VIN码</div>
          <div field="insureCompName" name="insureCompName" width="40" headerAlign="center" align="center" >保险公司</div>
          <div field="insureNo" name="insureNo" width="40" headerAlign="center" align="center" >保险单号</div>
          <div field="mtAdvisor" name="mtAdvisor" width="40" headerAlign="center" align="center" >服务顾问</div>
          <div field="enterDate" name="enterDate" width="40" headerAlign="center" align="center" >进厂时间</div>
          <div field="planFinishDate" name="planFinishDate" width="40" headerAlign="center" align="center" >预计交车</div>
          <div field="packageAmt" name="packageAmt" width="40" headerAlign="center" align="center" >应收金额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >实收金额</div>
          <div field="status" name="status" width="40" headerAlign="center" align="center" >单据状态</div>
        </div>
      </div>
    </div>


    <script type="text/javascript">
      nui.parse();
  
      function newClaimBill() {
        var item={};
            item.id = "claimDetail";
            item.text = "理赔单";
            item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/claimDetail.jsp";
            item.iconCls = "fa fa-cog";
            window.parent.activeTab(item);
      }
     
    </script>

    

</body>
</html>