<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description: 
-->
<head> 
  <title></title>
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
             <a class="nui-button" onclick=""   plain="false" >添加</a>
          </td>
        </tr>
      </table>

  </div>

      <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
        selectOnLoad="true"
        showPager="false"
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
          <div field="" name="" width="40" headerAlign="center" align="center" >工作组名</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >包含成员</div>
          <div field="" name="" width="40" headerAlign="center" align="center" >操作</div>
        </div>
      </div>
    </div>


  <div style="width:100%;margin-top: 10px;text-align: center;">
   
    <a class="nui-button" onclick=""   plain="false" >确认</a>
    <a class="nui-button" onclick=""   plain="false" >取消</a>
  </div>

  </div>

</body>
</html>