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
  <div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;">

    <table class="table" id="table1"> 
      <tr>
        <td>
          <input class="nui-hidden" id="cNo" name="cNo" value='<b:write property="cNo"/>'/>
          <input class="nui-textbox" id="guestName" name="guestName" emptyText="输入客户姓名" width="120" />
          <input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="请输入单号" width="120" />
          <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="120" />
          <label class="form_label">开单日期&nbsp;从：</label>
          <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
          <label class="form_label">至：</label>
          <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
        
          <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
           <span class="fa fa-search fa-lg"></span>&nbsp;查询
        </a>
        <span class="separator"></span>
   <!--        <a class="nui-button" iconCls="" plain="true" onclick="newCheckPrecheck" id="">
     <span class="fa fa-plus fa-lg"></span>&nbsp;新建接车预检
 </a>-->
 <a class="nui-button" iconCls="" plain="true" onclick="add()" id="save">
   <span class="fa fa-plus fa-lg"></span>&nbsp;新增
</a> 
<a class="nui-button" iconCls="" plain="true" onclick="edit()" id="edit">
    <span class="fa fa-edit fa-lg"></span>&nbsp;修改
</a>
<!-- <a class="nui-button" iconCls="" plain="true" onclick="ToCheckDetail(3)" id="view">
    <span class="fa fa-file-text-o fa-lg"></span>&nbsp;查看
</a> -->
</td>
</tr>
</table> 
</div> 

<div class="nui-fit">
  <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
  totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
  onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
  <div property="columns">
    <div field="id" name="id" visible="false">id</div>
    <div field="serviceCode" name="serviceCode" width="40" headerAlign="center" align="center">单号</div>
    <div field="guestFullName" name="guestFullName" width="40" headerAlign="center" align="center">客户姓名</div>
    <div field="guestMobile" name="guestMobile" width="40" headerAlign="center" align="center">手机号码</div>
    <div field="carNo" name="carNo" width="40" headerAlign="center" align="center">车牌号</div>
    <div field="carModel" name="carModel" width="80" headerAlign="center" align="center">品牌/车型</div>
    <div field="mtAdvisor" name="mtAdvisor" width="40" headerAlign="center" align="center">维修顾问</div>
    <div field="recordDate" name="recordDate" width="40" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">查车日期</div>
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
  beginDateEl = nui.get("sRecordDate");
  endDateEl = nui.get("eRecordDate");
  var date = new Date();
  var sdate = new Date();
  sdate.setMonth(date.getMonth()-3);
  endDateEl.setValue(date);
  beginDateEl.setValue(sdate);

  onSearch();

  function onSearch(){
    var data = form.getData();
    data.orgid = currOrgId;
    data.sRecordDate = beginDateEl.getValue();
    data.eRecordDate = endDateEl.getValue();
    mainGrid.load({ 
      params:data,
      token:token
  });
}

/*  function selectModel(){
    nui.open({
      url:"com.hsweb.repair.DataBase.checkMainSelect.flow",
      title:"选择模板",
      height:"300px",
      width:"400px",
      onload:function(){ 

      },
      ondestroy:function(action){

      } 

    });
}*/

function setInitData(params){
    var pa={
      carNo:nui.get("cNo").value,
      orgid:currOrgId
  }; 
  mainGrid.load({ 
      params:pa, 

      token:token 
  });
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
    edit();
});

function add(){
    var part={};
    part.id = "checkPrecheckDetail";
    part.text = "检查开单详情";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {
        isCheckMain:"Y"
    };
    window.parent.activeTabAndInit(part,params);

}
function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var part={};
    part.id = "checkPrecheckDetail";
    part.text = "检查开单详情";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id,
        isCheckMain:"Y"
    };
    window.parent.activeTabAndInit(part,params);
}


</script>

</body>

</html>