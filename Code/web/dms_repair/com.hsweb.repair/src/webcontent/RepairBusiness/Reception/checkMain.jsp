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
  <title>检查开单</title>  
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
  <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table class="table" id="table1">
      <tr>
        <td>
          <input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="请输入单号" width="120" />
          <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="120" />
          <input class="nui-textbox" id="guestName" id="guestName" emptyText="输入客户姓名" width="120" />
          <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
            <span class="fa fa-search fa-lg"></span>&nbsp;查询
          </a>
          <span class="separator"></span>
   <!--        <a class="nui-button" iconCls="" plain="true" onclick="newCheckPrecheck" id="">
     <span class="fa fa-plus fa-lg"></span>&nbsp;新建接车预检
   </a>
   <a class="nui-button" iconCls="" plain="true" onclick="selectModel" id="">
     <span class="fa fa-plus fa-lg"></span>&nbsp;新建查车单
   </a> -->
          <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="">
            <span class="fa fa-edit fa-lg"></span>&nbsp;查看
          </a>
        </td>
      </tr>
    </table> 

  </div> 

  <div class="nui-fit">
    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
    totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
    onshowrowdetail="onShowRowDetail" url="">
    <div property="columns">
      <div field="id" name="id" visible="false">id</div>
      <div field="serviceCode" name="serviceCode" width="40" headerAlign="center" align="center">单号</div>
      <div field="guestFullName" name="guestFullName" width="40" headerAlign="center" align="center">客户姓名</div>
      <div field="guestMobile" name="guestMobile" width="40" headerAlign="center" align="center">手机号码</div>
      <div field="car_no" name="carNo" width="40" headerAlign="center" align="center">车牌号</div>
      <div field="carModel" name="carModel" width="80" headerAlign="center" align="center">车型</div>
      <div field="mt_advisor" name="mtAdvisor" width="40" headerAlign="center" align="center">维修顾问</div>
      <div field="record_date" name="recordDate" width="40" headerAlign="center" align="center" dateFormat="yyyy-MM-dd">查车日期</div>
    </div>
  </div>
</div>

<script type="text/javascript">
  nui.parse();
    var form = new nui.Form("#table1");
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = baseUrl + "com.hsapi.repair.repairService.repairInterface.QueryCheckMainList.biz.ext";
    var mainGrid = nui.get("mainGrid"); 
    mainGrid.setUrl(gridUrl);


onSearch();

function onSearch(){
  var data = form.getData();
  mainGrid.load({
    params:data,
    
    token:token
  });
}

  

  function selectModel(){
 /*   nui.open({
      url:"com.hsweb.repair.DataBase.checkMainSelect.flow",
      title:"选择模板",
      height:"300px",
      width:"400px",
      onload:function(){

      },
      ondestroy:function(action){

      }

    });*/
  }



  function newCheckPrecheck() {
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "接车预检单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkPrecheckDetail.jsp";
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);
  }

  mainGrid.on("celldblclick",function(e){
    var field = e.field;
    var record = e.record;
    var column = e.column;
    var sid = record.id;
    newCheckMain(record);
  });


  function edit() {
    var row = mainGrid.getSelected();
    if(row){ 
        newCheckMain(row);
    }else{
      nui.alert("请先选择一条记录！");
    }
  }



  function newCheckMain(data) {  

    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp";
    item.iconCls = "fa fa-cog";
    //window.parent.activeTab(item);
    var params = {};
    params = { 
        id:data.service_id,
    };
    window.parent.activeTabAndInit(item,params);
}  

</script>

</body>

</html>