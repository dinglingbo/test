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
  <title>选择配件数量</title>  
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

              <a class="nui-button" iconCls="" plain="true" onclick="onOk">
                  <span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
              </td>
          </tr>
      </table>

  </div>

  <div class="nui-fit">
<!--     <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
borderStyle="border:1;"
selectOnLoad="false"
showPager="true"
pageSize="20"
sizeList=[20,50,100,200]
dataField="partlist"
url="com.hsapi.cloud.part.invoicing.stockcal.queryOutableEnterGridWithPage.biz.ext"
showModified="false"
sortMode="client"
ondrawcell=""
onrowdblclick=""
idField="id"
totalField="page.count"
allowCellSelect="true" allowCellEdit="true"> -->


<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
url=""
dataField="partlist"
idField="id" 
showModified="false"
allowResize="true" 
showSummaryRow="true"
pageSize="20"
sizeList=[20,50,100,200]
allowCellEdit="true" allowCellSelect="true" 
editNextOnEnterKey="true"  editNextRowCell="true"

>
<div property="columns">
    <div type="indexcolumn">序号</div>
    <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
    <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
    <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
    <div field="stockQty" name="stockQty" allowSort="true"  width="60" headerAlign="center" header="库存数量" datatype="float" summaryType="sum"></div>
    <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
    <div field="outQty" name="outQty" width="100" headerAlign="center" header="领料数量" datatype="float" summaryType="sum">
        <input property="editor" class="nui-textbox" vtype="float"/> 
    </div> 
    <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
    <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
    <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
    <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
    <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
    <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
    <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
    <div field="serviceId" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
    <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
    <div field="partId" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件id"></div> 
    <div field="partNameId" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件nameid"></div>         
    <div field="partFullName" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件fullname"></div>         
</div> 
</div>
</div>

<script type="text/javascript">
    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = baseUrl + "com.hsapi.cloud.part.invoicing.stockcal.queryOutableEnterGridWithPage.biz.ext";
    var mainGrid = nui.get("mainGrid"); 
    mainGrid.setUrl(gridUrl);

    function SetData(par,type){
        //id= 9522; 
        onSearch(par,type);  
    } 

    function onSearch(par,type) {  
        if(type == "Id"){
            var params = {
                partId:par
            };

        }
        if(type == "Code"){
            var params = {
                partCode:par
            };

        }
        mainGrid.load({params:params});
    }

    function onOk(){
        var data = mainGrid.getData();
        if(data.length > 0){

            for (var i = 0; i < data.length; i++) {
                if(!data[i].outQty){
                    showMsg('请先填写领料数量!','W');
                    return;
                }
            }
            nui.open({
                url:webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
                title:"选择领料人",
                height:"300px",
                width:"600px", 
                onload:function(){ 
                    var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData("ll");
                },
                ondestroy:function(action){
                    if (action == "ok") {  
                    savePartOut();     //如果点击“确定”
                    //CloseWindow("close");
                }

            }

        });

        }else{
            showMsg('没有需要出库的配件!','W');
        }
    }


    function  savePartOut(){
        var data = mainGrid.getData();
        alert("1");
        if(data){
            var paramsData = [];
            paramsData = data;
            for (var i = 0; i < data.length; i++) {
                paramsData[i]= data[i];
                paramsData[i].serviceId = '';
                paramsData[i].id = '';
                paramsData[i].unit = data[i].systemUnitId;
            }
            nui.ajax({
                url:baseUrl + "com.hsapi.part.invoice.partInterface.partToOut.biz.ext",
                type:"post",
                data:{ 
                    list:paramsData,
                    token:token   
                }, 
                success:function(text){ 
                    showMsg('成功!','S');
                }
            });
        }else{
            showMsg('没有需要出库的配件!','W');
        }
    }




    mainGrid.on("cellcommitedit",function(e){
        var record = e.record;
        var value = e.value;
        var column = e.column;
        var field = e.field;
        var editor = e.editor;
        var sumData = gridData();
        if(column.field == "outQty"){
            editor.validate();
            if (editor.isValid() == false) {
                showMsg("请输入有效数字！","W");
                e.cancel = true;
            }

            if(record.stockQty < value){
                e.cancel = true;
                showMsg("该配件领料数量不能大于库存数量！","W");
            } 

            if(sumData.sum_stock < sumData.sum_outQty){
                e.cellHtml = "0";
                showMsg("总领料数量不能大于库存数量！","W");
            } 
        }
    });

/*
    mainGrid.on("cellendedit",function(e){
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var sumData = gridData();




        if(column.field == "outQty"){
            if(record.stockQty < record.outQty){
                e.cellHtml = "0";
                showMsg("该配件领料数量不能大于库存数量！","W");
            } 
            if(sumData.sum_stock < sumData.sum_outQty){
                e.cellHtml = "0";
                showMsg("总领料数量不能大于库存数量！","W");
            } 
        }

    });
    */
function gridData(){//获取汇总的数据
    var sum_stock = 0;
    var sum_outQty = 0;
    var girdData = mainGrid.getData();
    for (var i = 0; i < mainGrid.length; i++) {
        sum_stock += mainGrid[i].stockQty;
        sum_outQty += mainGrid[i].outQty;
    }

    var reData = {
        sum_stock:sum_stock,
        sum_outQty:sum_outQty
    };
    return reData;
}


/*
    function newCheckBill(tid) {
        var item={};
        item.id = "checkDetail";
        item.text = "查车单";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp?tid="+tid+"&actionType=new";
        item.iconCls = "fa fa-cog";
        window.parent.activeTab(item);
    }
    */

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
</script>

</body>

</html>