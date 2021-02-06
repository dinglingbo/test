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
  <title>工单-质检完工</title>
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

        <div id="" class="nui-datagrid" style="width:100%;height:100px;"
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
          <div field="" name="" width="40" headerAlign="center" align="center" >项目编号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >项目名称</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >维修技师</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >是否合格</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >备注</div>
        </div>
      </div>



        <div id="" class="nui-datagrid" style="width:100%;height:100px;"
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
          <div field="" name="" width="40" headerAlign="center" align="center" >材料编号</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >材料名称</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >领料人</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >数量</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >已领取</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >未领取</div>
        </div>
      </div>
    <div style="width:100%;margin-top: 10px;text-align: center;">
        <a class="nui-button" onclick=""   plain="false" >保存</a>
        <a class="nui-button" onclick=""   plain="false" >完工</a>
        <a class="nui-button" onclick=""   plain="false" >返回</a>
    </div>
</div>
</body>
</html>