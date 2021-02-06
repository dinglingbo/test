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
  <title>工单-维修单历史</title>
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
    <div title="工单历史" >
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
          <div field="" name="" width="40" headerAlign="center" align="center" >日期</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >单号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >消费金额</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >结算状态</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >结构名称</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >里程</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >备注</div>
        </div>
      </div>
    </div>
    <div title="项目历史" >
       
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

                <div field="" width="100" headerAlign="center" align="center">项目名称</div>
                <div field="" width="100" headerAlign="center" align="center">业务分类</div>
                <div field="" width="100" headerAlign="center" align="center">工时</div>
                <div field="" width="100" headerAlign="center" align="center">单价</div>
                <div field="" width="100" headerAlign="center" align="center">工时费</div>
                <div field="" width="100" headerAlign="center" align="center">折扣</div>
                <div field="" width="100" headerAlign="center" align="center">折后金额</div>
                <div field="" width="300" headerAlign="center" align="center">服务技师</div>
                <div field="" width="100" headerAlign="center" align="center">备注</div>
        </div>
      </div>
    </div>

    </div>
    <div title="材料历史" >
       
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

                <div field="" width="100" headerAlign="center" align="center">项目名称</div>
                <div field="" width="100" headerAlign="center" align="center">业务分类</div>
                <div field="" width="100" headerAlign="center" align="center">工时</div>
                <div field="" width="100" headerAlign="center" align="center">单价</div>
                <div field="" width="100" headerAlign="center" align="center">工时费</div>
                <div field="" width="100" headerAlign="center" align="center">折扣</div>
                <div field="" width="100" headerAlign="center" align="center">折后金额</div>
                <div field="" width="300" headerAlign="center" align="center">服务技师</div>
                <div field="" width="100" headerAlign="center" align="center">备注</div>
        </div>
      </div>
    </div>

    </div>
</div>
</body>
</html>