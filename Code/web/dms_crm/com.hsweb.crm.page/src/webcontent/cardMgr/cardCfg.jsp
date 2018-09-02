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
  <title>会员卡设置</title>
  <%-- <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.8"></script> --%>
  <script src="<%= request.getContextPath() %>/page/js/cardCfg.js?v=1.02"></script>
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
<div id="tabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;"  borderStyle="border:0;padding:0">
    <div title="计次卡" >

          <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
            <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;修改</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;禁用</a>
          </td>
        </tr>
      </table>

  </div>

      <div class="nui-fit">
        <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
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
        url="com.hsapi.crm.page.newcomponent.CardCfgJC.biz.ext">
        <div property="columns">
          <div field="name" name="name" width="40" headerAlign="center" align="center" >计次卡名称</div>
          <div field="periodValidity" name="periodValidity" width="40" headerAlign="center" align="center" >有效期(月)</div>
          <div field="sellAmt" name="sellAmt" width="40" headerAlign="center" align="center" >销售价格</div>
          <div field="salesDeductType" name="salesDeductType" width="40" headerAlign="center" align="center" >销售提成方式</div>
          <div field="salesDeductValue" name="salesDeductValue" width="40" headerAlign="center" align="center" >销售提成值</div>
          <div field="useRemark" name="useRemark" width="40" headerAlign="center" align="center" >使用说明</div>
          <div field="remark" name="remark" width="40" headerAlign="center" align="center" >卡说明</div>
          <div field="status" name="status" width="40" headerAlign="center" align="center" >状态</div>
        </div>
      </div>
    </div>
    </div>
    <div title="储值卡">
        


          <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table class="table" id="table1">
        <tr>
          <td>
            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
            <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
            <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;修改</a>
            <a class="nui-button" iconCls="" plain="true" onclick="newBill()" id="addBtn6"><span class="fa fa-plus fa-lg"></span>&nbsp;禁用</a>
          </td>
        </tr>
      </table>

  </div>

      <div class="nui-fit">
        <div id="grid2" class="nui-datagrid" style="width:100%;height:100%;"
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
        url="com.hsapi.crm.page.newcomponent.cardCfgCZ.biz.ext">
        <div property="columns">
          <div field="name" name="name" width="40" headerAlign="center" align="center" >卡名称</div>
          <div field="useRange" name="useRange" width="40" headerAlign="center" align="center" >适用范围</div>
          <div field="sellAmt" name="sellAmt" width="40" headerAlign="center" align="center" >销售价格</div>
          <div field="salesDeductType" name="salesDeductType" width="40" headerAlign="center" align="center" >销售提成方式</div>
          <div field="salesDeductValue" name="salesDeductValue" width="40" headerAlign="center" align="center" >销售提成值</div>
          <div field="useRemark" name="useRemark" width="40" headerAlign="center" align="center" >使用说明</div>
          <div field="remark" name="remark" width="40" headerAlign="center" align="center" >卡说明</div>
          <div field="status" name="status" width="40" headerAlign="center" align="center" >状态</div>
          <div field="periodValidity" name="periodValidity" width="40" headerAlign="center" align="center" >有效期</div>
        </div>
      </div>
    </div>



    </div>
</div>

</div>

<script type="text/javascript">
   nui.parse();
	
</script>





 

</body>
</html>