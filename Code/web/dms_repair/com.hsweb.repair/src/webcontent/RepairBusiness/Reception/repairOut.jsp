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
  <title>维修出库</title>  
  <style type="text/css">
  .title {
    width: 60px;
    text-align: right;
}
a {
    text-decoration: none;
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
            <input class="nui-combobox" id="status" name="status" emptyText="选择维修进程" data="con_data_status" valueField="id" textField="text" />
            <input class="nui-combobox" id="isSettle" name="isSettle" emptyText="选择结算状态"  data="con_data_isSettle" valueField="id" textField="text" />
            进场日期 从<input id="date1" name="" class="nui-datepicker" value=""/>
            至 <input id="date2" name="" class="nui-datepicker" value=""/>
            <a class="nui-button" iconCls="" plain="false" onclick="onSearch">
                <span class="fa fa-search fa-lg"></span>&nbsp;查询
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
        <div field="guestTel" name="guestMobile" width="40" headerAlign="center" align="center">手机号码</div>
        <div field="carNO" name="carNO" width="40" headerAlign="center" align="center">车牌号</div>
        <div field="carModel" name="carModel" width="80" headerAlign="center" align="center">车型</div>
        <div field="status" name="status" width="40" headerAlign="center" align="center" renderer="onGenderRenderer">维修进程</div>
        <div field="serviceTypeId" name="serviceTypeId" width="40" headerAlign="center" align="center">serviceTypeId</div>
        <div field="enterDate" name="recordDate" width="40" headerAlign="center" align="center" dateFormat="yyyy-MM-dd">进厂日期</div>
        <div field="action" name="action" width="40" headerAlign="center" header="操作" align="center" align="center"></div>
    </div> 
</div>
</div>

<script type="text/javascript">
    var con_data_status = [{id:"",text:"全部"},{id:0,text:"草稿"},{id:1,text:"施工中"},{id:2,text:"已完工"}];
    var con_data_isSettle = [{id:"",text:"全部"},{id:1,text:"已结算"},{id:0,text:"未结算"}];
    nui.parse();
    var mainGrid = nui.get("mainGrid");
    var status = nui.get("status");
    var isSettle = nui.get("isSettle");
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = baseUrl + "com.hsapi.repair.baseData.query.qyeryMaintainList.biz.ext";
    mainGrid.setUrl(gridUrl);
  
    var yy = (new Date()).getFullYear();
    var mm = ((new Date()).getMonth() + 1);
    var dd = (new Date()).getDate();
    var da = yy + "-" + mm; //本月月
    var db = yy + "-" + mm + "-" + dd; //本月月
    nui.get("date1").setValue(da);
    nui.get("date2").setValue(db);
    onSearch();
    function onSearch(){

        var fdate1 = nui.get("date1").value;
        var fdate2 = nui.get("date2").value;

        var sdate = nui.formatDate (fdate1,"yyyy-MM-dd");
        var edate = nui.formatDate (fdate2,"yyyy-MM-dd");
        var params ={
           // part :1,
            //sdate:sdate,
            //eEnterDate:edate,
            //status:status.value,
            //isSettle:isSettle.value
        };
        mainGrid.load({params:params});
    }

    function onGenderRenderer(e) {
        for (var i = 0, l = con_data_status.length; i < l; i++) {
            var g = con_data_status[i];
            if (g.id == e.value) return g.text;
        }
        return "";
    }
    function newrepairOut(mid,type,serviceCode) {
        var item={};
        item.id = "checkDetail";
        item.text = "出库单";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp?mid="+mid+"&actionType="+type+"&serviceCode="+serviceCode;
        item.iconCls = "fa fa-cog";
        window.parent.activeTab(item);
    } 


/*mainGrid.on("celldblclick",function(e){
    var field = e.field;
    var record = e.record;
    var column = e.column; 
    var sid = record.id;
    newrepairOut(sid,'view');
});
*/
mainGrid.on("drawcell",function(e){
    var field = e.field;
    var record = e.record;
    var column = e.column;
    var id = record.id;
    var ll = '<a  href="javascript:newrepairOut('+id+','+"'ll'"+ ')">&nbsp;&nbsp;&nbsp;&nbsp;领料</a>';//class="icon-collapse"
    var th = '<a  href="javascript:newrepairOut('+id+','+"'th'"+ ')">&nbsp;&nbsp;&nbsp;&nbsp;退货</a>';//class="icon-addnew"
    if(column.field == "action"){
        e.cellHtml = ll +"&nbsp;&nbsp;&nbsp;" + th;
    }
});

function edit() {
    var row = mainGrid.getSelected();
    if(row){ 
      newrepairOut(row.id,'edit',row.serviceCode);
  }else{
      nui.alert("请先选择一条记录！");
  }
}
</script>

</body>

</html>