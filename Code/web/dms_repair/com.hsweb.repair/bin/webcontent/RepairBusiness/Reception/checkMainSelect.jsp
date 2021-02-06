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
  <title>工单-查车-选择模板</title>  
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
    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"  showPager="true" pageSize="50"
    totalField="page.count" sizeList=[20,50,100,200] dataField="list" allowCellSelect="true" 
    url="">
    <div property="columns">
        <div type="indexcolumn" width="10" headerAlign="center" align="center">序号</div>
        <div field="id" name="id" headerAlign="center" align="center" visible="false">模板名称ID</div>
        <div field="name" name="name" width="60" headerAlign="center" align="center">模板名称</div>
        <div field="modifier" name="modifier" width="40" headerAlign="center" align="center">说明</div>

    </div>
</div>
</div>

<script type="text/javascript">
    nui.parse();

    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCheckModel.biz.ext";
    var mainGrid = nui.get("mainGrid"); 
    mainGrid.setUrl(gridUrl);

    mainGrid.load();
    
    mainGrid.on("rowdblclick",function(e){
        var record = e.record;
        var tid = record.id;
        newCheckBill(tid);
        CloseWindow("close");
    });


    function newCheckBill(tid) {
        var item={};
        item.id = "checkDetail";
        item.text = "查车单";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp?tid="+tid+"&actionType=new";
        item.iconCls = "fa fa-cog";
        window.parent.activeTab(item);
    }


    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

</body>

</html>