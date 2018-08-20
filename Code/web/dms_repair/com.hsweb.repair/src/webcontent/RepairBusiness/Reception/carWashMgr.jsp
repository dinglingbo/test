<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description: 
-->
<head> 
  <title>工单-洗车</title>
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
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
             <a  onclick="" id="">更多筛选条件</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="newCheckBill()" id="newBill"><span class="fa fa-plus fa-lg"></span>&nbsp;新建</a>
            <a class="nui-button" iconCls="" plain="true" onclick="newCheckBill()" id="editBill"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
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
          <div field="" name="" width="40" headerAlign="center" align="center" >单号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >客户姓名</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >手机号码</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >车牌号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >车型</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >服务顾问</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >应收金额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >实收金额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >洗车类型</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >单据状态</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >结算状态</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
        </div>
      </div>
    </div>

     <script type="text/javascript">
      nui.parse();
  
      function newCheckBill() {
        var item={};
            item.id = "checkDetail";
            item.text = "洗车单";
            item.url = webPath + sysDomain + "/repair/RepairBusiness/Reception/carWashBill.jsp";
            item.iconCls = "fa fa-cog";
            window.parent.activeTab(item);
      }
      
    </script>

</body>
</html>