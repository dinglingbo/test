<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonPart.jsp"%>


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
                  <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox"
                           style="display:none;"
                           width="100px"
                           textField="name"
                           valueField="id"
                           valueFromSelect="true"
                           emptyText="品牌"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="品牌"/>
              	<input id="billTypeId" visible="false" class="nui-combobox" textField="name" valueField="customid" />
                <input class="nui-textbox" id="partNameAndPY" name="partNameAndPY" emptyText="输入查询条件" width="120" />
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
                  <span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

                  <a class="nui-button" iconCls="" plain="true" onclick="onOk">
                      <span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                  </td>
              </tr>
          </table>

      </div>

      <div class="nui-fit">

        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
        url=""
        dataField="partlist"
        idField="id" 
        showModified="false"
        allowResize="true" 
        showSummaryRow="true"
        pageSize="20"
        totalField="page.count"
        sizeList=[20,50,100,200]
        allowCellEdit="true" allowCellSelect="true" 
        editNextOnEnterKey="true"  editNextRowCell="true"

        >
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="id" name="id" width="100" headerAlign="center" header="id" visible="false"></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center"align="center"  header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" align="center" header="OEM码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div field="stockQty" name="stockQty" allowSort="true"  width="60" headerAlign="center" align="center" header="库存数量" datatype="float" summaryType="sum"></div>
            <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" align="center" header="库存单价"></div>
            <div field="outQty" name="outQty" width="100" headerAlign="center" align="center" header="领料数量" datatype="float" summaryType="sum">
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="billTypeId" width="55px" headerAlign="center" align="center" allowSort="true" header="票据类型"></div>
            <div field="storeId" width="60" headerAlign="center" align="center"  allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="55px" headerAlign="center" align="center" allowSort="true" header="仓位"></div>
            <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
            <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
            <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
            <div field="serviceCode" align="left" width="120px" headerAlign="center" align="center" allowSort="true" header="入库单号"></div>
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
    var gridUrl = apiPath + partApi + "/com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";
    var mainGrid = nui.get("mainGrid"); 
    mainGrid.setUrl(gridUrl);
    var mrecordId = null;//
    var mainRow = null;
    var selectRow = null;

    var storehouse = null;
    var storeHash = {};
    var brandHash = {};
    var brandList = [];
    var billTypeHash = {};

    function SetData(par,type,id,mRow,srow){
        //id= 9522; 
        onSearch(par,type);
        mrecordId = id;
        mainRow = mRow;
        selectRow = srow;

    } 

	var dictDefs = {
		"billTypeId" : "DDT20130703000008"
	};
	initDicts(dictDefs, function(e) {
		var billTypeList = nui.get("billTypeId").getData();
		billTypeList.forEach(function(v) {
			billTypeHash[v.customid] = v;
		});
	});
    

     getStorehouse(function(data) {
        storehouse = data.storehouse || [];
        if (storehouse && storehouse.length > 0) {
            FStoreId = storehouse[0].id;
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }
    }); 


    getAllPartBrand(function(data) {
        brandList = data.brand;
        nui.get('partBrandId').setData(brandList);
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
 
    function onSearch(par,type) {  
        var params = {};
        params.partNameAndPY = nui.get("partNameAndPY").value;
        if(type == "Id"){
            params .partId = par;
        }
        if(type == "Code"){
            params.partCode = par;
        } 
        //nui.alert(nui.encode(params));
        mainGrid.load({params:params,token:token});
    }


    mainGrid.on("drawcell", function(e) { 
        switch (e.field) {
            case "partBrandId":
            if (brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
            case "storeId":
            if (storeHash[e.value]) { 
                e.cellHtml = storeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
            case "billTypeId":
            if (billTypeHash[e.value]) {
                e.cellHtml = billTypeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
            default:
            break;
        }

    });

    mainGrid.on("load",function(e){
        var tdata = mainGrid.getData();
        if(tdata.length < 1){
            showMsg('该配件没有剩余库存!','W');
        }
    });
    function onOk(){
        var sum_out = 0;
        var data =  mainGrid.getChanges('modified');
        if(data.length > 0){

            for (var i = 0; i < data.length; i++) {
                if(data[i].outQty){
                    sum_out +=parseFloat(data[i].outQty);
                }if(data[i].outQty==0){
                    showMsg('领料数量不能为0!','W');
                    return;
                }
                
            }

            if(!sum_out){
                showMsg('请先填写领料数量!','W');
                return;
            }
            if(sum_out>selectRow.qty-selectRow.pickQty){
            	showMsg('超过可领料数量','W');
            	 return;
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
                        var iframe = this.getIFrameEl();
                        var childdata = iframe.contentWindow.GetFormData();
                    savePartOut(childdata);     //如果点击“确定”
                    //window.parent.tt(333);
                    
                }

            }

        });

        }else{
            showMsg('没有需要出库的配件!','W');
        }
    }


    function  savePartOut(childdata){
        var data = mainGrid.getChanges('modified');
        if(data){
            var paramsDataArr = [];
            //var paramsData = nui.clone(data); 
            for (var i = 0; i < data.length; i++) { 
                var paramsData = {};
                paramsData.serviceId = '';
                paramsData.id = '';
                paramsData.mainId = mrecordId;
                paramsData.sourceId = data[i].id;
                paramsData.serviceId = mainRow.id;
                paramsData.serviceCode = mainRow.serviceCode;
                paramsData.guestId = mainRow.guestId;
                paramsData.guestName = mainRow.guestFullName;
                paramsData.carNo = mainRow.carNO;
                paramsData.vin = mainRow.carVin;
                paramsData.partId = data[i].partId;
                paramsData.partCode = data[i].partCode;
                paramsData.oemCode = data[i].oemCode;
                paramsData.partName = data[i].partName;
                paramsData.partNameId = data[i].partNameId;
                paramsData.partFullName = data[i].partFullName;
                paramsData.stockQty = data[i].stockQty;
                paramsData.outQty = data[i].outQty;
                paramsData.enterPrice = data[i].enterPrice;
                paramsData.billTypeId = '050206';
                paramsData.storeId = data[i].storeId;
                paramsData.unit = data[i].systemUnitId;
                paramsData.pickMan = childdata.mtAdvisor;
                paramsData.remark = childdata.remark;
                paramsData.pickType = "维修出库-领料";
                paramsData.taxUnitPrice = data[i].taxUnitPrice;
                paramsData.taxAmt = data[i].taxAmt;
                paramsData.noTaxUnitPrice = data[i].noTaxUnitPrice;
                paramsData.noTaxAmt = data[i].noTaxAmt;
                paramsData.trueUnitPrice = data[i].trueUnitPrice;
                paramsData.trueCost = data[i].trueCost;
                paramsData.sellUnitPrice = parseFloat(selectRow.unitPrice);
                paramsData.sellAmt = parseFloat(selectRow.unitPrice * data[i].outQty);
                if(!paramsData.partNameId){ 
                    paramsData.partNameId = "0";  
                }
                paramsDataArr.push(paramsData);
            } 

            //console.log(paramsData);
            //console.log(tdata);
            //return;  
            nui.ajax({
                url:baseUrl + "com.hsapi.repair.repairService.work.repairOut.biz.ext",
                type:"post",
                async: false,
                data:{ 
                    data:paramsDataArr,
                    billTypeId:"050206",
                    serviceId:mainRow.id,
                    token:token   
                },   
                success:function(text){   
                    var errCode = text.errCode;
                    var errMsg = text.errMsg;
                    if(errCode == "S"){
						nui.unmask(document.body);
                        showMsg('领料成功!','S'); 
                        CloseWindow("ok");
                    }else{ 
                    	nui.unmask(document.body);
                        showMsg(errMsg,'E'); 
                    }
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