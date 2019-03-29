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
              	<a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate" style="display:none;">所有</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">所有</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">本日</li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                </ul>
              	<label style="font-family:Verdana;" style="display:none;">入库日期 从：</label>
                <input style="" class="nui-datepicker" id="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;" style="display:none;">至</label>
                <input style=""class="nui-datepicker" id="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <input class="nui-textbox" id="partCode" name="partCode" emptyText="按配件编码查询" width="80"  onenter="onSearch"/>
                <input class="nui-textbox" id="partNameAndPY" name="partName" emptyText="按名称查询" width="80"  onenter="onSearch"/>
                <input class="nui-textbox" id="storeShelf" name="storeShelf" emptyText="按仓位查询" width="90"  onenter="onSearch"/>
<!--                 <input class="nui-textbox" id="partNameAndPY" name="partNameAndPY" emptyText="输入查询条件" width="120"  onenter="onSearch"/> -->
                 <input id="storeId"
                           name="storeId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="仓库"
                           url="" width="80"
                           valueFromSelect="true"
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
                  <span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				<span class="separator"></span>
				<input id="mtAdvisorId"
					 name="mtAdvisorId" 
					class="nui-combobox" 
					textField="empName"
	                valueField="empId" 
	                emptyText="请选择领料人"
	                required="true"
	                url=""
	                width="80"
	                allowInput="true"
	                showNullItem="false" 
	                valueFromSelect="true"
	                nullItemText="请选择领料人"
	                width="80"
				/>
				<input class="nui-textbox" id="remark"  name="remark" emptyText="请填写备注" width="120" />
				<span class="separator"></span>
                  <a class="nui-button" iconCls="" plain="true" onclick="onOk">
                      <span class="fa fa-check fa-lg"></span>&nbsp;领料</a>
                  <a class="nui-button" iconCls="" plain="true" onclick="positions">
                      <span class="fa fa-edit fa-lg"></span>&nbsp;修改仓位</a>
                      
<!--                   <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')">
                      <span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
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
            <div field="guestName" width="100px" headerAlign="center" allowSort="true" header="供应商"></div>
            <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
             
            <div field="partCode" name="partCode" width="100" headerAlign="center"align="center"  header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" align="center" header="OEM码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div field="stockQty" name="stockQty" allowSort="true"  width="60" headerAlign="center" align="center" header="库存数量" datatype="float" summaryType="sum"></div>
            <div field="enterPrice" width="60px" headerAlign="center" allowSort="true" align="center" header="库存单价"></div>
            <div field="outQty" name="outQty" width="60"  headerAlign="center" align="center" header="领料数量" datatype="float" summaryType="sum">
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="sellUnitPrice" name="sellUnitPrice" width="60"  headerAlign="center" align="center" header="销售单价" datatype="float" visible="false" >
                <input property="editor" class="nui-textbox" vtype="float"/> 
            </div> 
            <div field="suggSellPrice" width="60px" headerAlign="center" allowSort="true" align="center" header="建议售价"></div>
            <div field="billTypeId" width="60px" headerAlign="center" align="center" allowSort="true" header="票据类型"></div>
            <div field="storeId" width="60" headerAlign="center" align="center"  allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="60px" headerAlign="center" align="center" allowSort="true" header="仓位"></div>
            <div field="partBrandId" name="partBrandId" width="90" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="120" headerAlign="center" header="品牌车型"></div>
            <div field="enterUnitId" width="35" headerAlign="center" header="单位"></div>
             
            <div field="enterCode" align="left" width="120px" headerAlign="center" align="center" allowSort="true" header="入库单号"></div>
            <div field="fullName" name="fullName" width="300" headerAlign="center" header="配件全称"></div> 
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
    var settleType = "";

    var storehouse = null;
    var storeHash = {};
    var brandHash = {};
    var brandList = [];
    var billTypeHash = {};
    var sEnterDateEl=null;
    var eEnterDateEl=null;
    var par;
    var type;
    var id;
    var mRow;
    var srow;
    var pickType;
	nui.get('partCode').focus();
	$(document).ready(function(v){
		sEnterDateEl = nui.get('sEnterDate');
		eEnterDateEl = nui.get('eEnterDate');
	});
	document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
    function SetData(par,type,id,mRow,srow,pickType){
    	//用于修改仓位成功返回刷新
    	par = par;
    	type = type;
    	id = id;
    	mRow = mRow;
    	srow = srow;
    	pickType = pickType;
        //id= 9522; 
        onSearch(par,type);
        mrecordId = id;
        mainRow = mRow;
        selectRow = srow;
        settleType = pickType;
        nui.get('mtAdvisorId').setValue(currEmpId);
        nui.get('mtAdvisorId').setText(currUserName);
        
        if(pickType == "ADD") {
        	mainGrid.showColumn("sellUnitPrice");
        }
        
        getStockman(function(text){
        	var data = text.data||[];
	    	if(data && data.length>0) {
	    		nui.get("mtAdvisorId").setData(data);
	    	}else {
				showMsg("请在【员工管理】中设置仓库人员，用于领料人选择！","W");   	
	    	}
	    });
		
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
    
	/* initMember("mtAdvisorId",function(){

    }); */
    
     getStorehouse(function(data) {
        storehouse = data.storehouse || [];
        if (storehouse && storehouse.length > 0) {
            FStoreId = storehouse[0].id;
            nui.get("storeId").setData(storehouse);
            if(currRepairStoreControlFlag == "1") {
            	nui.get("storeId").setValue(FStoreId);
            }else {
            	nui.get("storeId").setAllowInput(true);
            }
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
 

 function quickSearch(type){
    var queryname = "所有";
    var params={};
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sEnterDate = null;
            params.eEnterDate = null;
            queryname = "所有";
            sEnterDateEl.setValue(null);
    		eEnterDateEl.setValue(null);
    		onSearch();
            break;
        case 1:
            params.today = 1;
            params.sEnterDate = getNowStartDate();
            params.eEnterDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            sEnterDateEl.setValue(params.sEnterDate);
    		eEnterDateEl.setValue(addDate(params.eEnterDate,-1));
    		onSearch();
            break;
        case 2:
            params.thisWeek = 1;
            params.sEnterDate = getWeekStartDate();
            params.eEnterDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            sEnterDateEl.setValue(params.sEnterDate);
    		eEnterDateEl.setValue(addDate(params.eEnterDate,-1));
    		onSearch();
            break;
        default:
            break;
    }

    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
}
    function onSearch(par,type) {  
        var params = {};
        params.partName= nui.get("partNameAndPY").value;
        params.partCode = nui.get("partCode").value;
        params.storeShelf = nui.get("storeShelf").value;
        params.storeId = nui.get("storeId").value;
        if(eEnterDateEl.getFormValue()){ 
    	    params.eEnterDate= addDate(eEnterDateEl.getFormValue(),1);
        }
        params.sEnterDate = nui.get('sEnterDate').getFormValue();
        
        //value = value.replace(/\s+/g, "");
        //包含中文
        var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
        if(!reg.test(params.partName)){
            params.namePy = params.partName;
            params.partName = null;
        }
        
        if(type == "Id"){
            params.partId = par;
        }
        if(type == "Code"){
            params.partCode = par;
        } 
        if(type == "Name") {
        	params.partName = par;
        }
        //nui.alert(nui.encode(params));
        mainGrid.load({params:params,token:token});
    }


    mainGrid.on("drawcell", function(e) { 
        switch (e.field) {
            case "partBrandId":
             if(brandHash[e.value])
                {
//                    e.cellHtml = brandHash[e.value].name||"";
                	if(brandHash[e.value].imageUrl){
                		
                		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
                	}else{
                		e.cellHtml = brandHash[e.value].name||"";
                	}
                }
                else{
                    e.cellHtml = "";
                }
                break;;
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
            case "outQty" :
            	e.cellStyle = "background:#54FF9F";
            break;
            case "sellUnitPrice" :
            	e.cellStyle = "background:#54FF9F";
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
        for(var i=0;i<data.length;i++){
        	if(!data[i].outQty || data[i].outQty==="0" ){
        		data.splice(i,1);
        		i=i-1;
        	}
        }
        var mtAdvisorId=nui.get('mtAdvisorId').getValue();
        var mtAdvisor=nui.get('mtAdvisorId').getText();
        var remark=nui.get('remark').getValue();
        var childdata={};
        childdata.mtAdvisor=mtAdvisor;
        childdata.remark=remark;
        if(!mtAdvisorId){
        	showMsg("请选择领料人!","W");
        	return;
        }
//         if(!remark){
//         	showMsg("请填写备注!","W");
//         	return;
//         }
        if(data.length > 0){

            for (var i = 0; i < data.length; i++) {
                if(data[i].outQty){
                    sum_out +=parseFloat(data[i].outQty);
                }
                if(data[i].outQty==0){
                    showMsg('请填写领料数量!','W');
                    return;
                }
                if(data[i].outQty>0 && settleType == "ADD") {
                	if(data[i].sellUnitPrice == null || data[i].sellUnitPrice == "") {
                		showMsg('请填写销售单价!','W');
                    	return;
                	}
                }
            }

            if(!sum_out){
                showMsg('请先填写领料数量!','W');
                return;
            }
            if(settleType == "PICK") {
	            if(sum_out>selectRow.qty-selectRow.pickQty){
	            	showMsg('超过待领数量','W');
	            	 return;
	            }
            }
//             nui.open({
//                 url:webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
//                 title:"选择领料人",
//                 height:"300px",
//                 width:"600px", 
//                 onload:function(){ 
//                     var iframe = this.getIFrameEl();
//                     iframe.contentWindow.SetData("ll");
//                 },
//                 ondestroy:function(action){
//                     if (action == "ok") {  
//                         var iframe = this.getIFrameEl();
//                         var childdata = iframe.contentWindow.GetFormData();
//                     savePartOut(childdata);     //如果点击“确定”
//                     //window.parent.tt(333);
                    
//                 }

//             }

//         });

        }else{
            showMsg('没有填写需要出库的配件!','W');
            return;
        }
        savePartOut(data,childdata);
    }


    function  savePartOut(data,childdata){
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
                if(settleType == "PICK") {
                	paramsData.sellUnitPrice = parseFloat(selectRow.unitPrice);
                	paramsData.sellAmt = parseFloat(selectRow.unitPrice * data[i].outQty);
                }else if(settleType == "ADD") {
                	paramsData.sellUnitPrice = parseFloat(data[i].sellUnitPrice);
                	paramsData.sellAmt = parseFloat(data[i].sellUnitPrice) * parseFloat(data[i].outQty);
                }
                if(!paramsData.partNameId){ 
                    paramsData.partNameId = "0";  
                }
                paramsDataArr.push(paramsData);
            } 
            
            var url = "";
            var data = {};
            if(settleType == "PICK") {
	            url = baseUrl + "com.hsapi.repair.repairService.work.repairOut.biz.ext";
	            data.data = paramsDataArr;
	            data.billTypeId = "050206";
	            data.serviceId = mainRow.id;
	            data.token = token;
            }else if(settleType == "ADD") {
            	url = baseUrl + "com.hsapi.repair.repairService.work.repairPickOut.biz.ext";
	            data.data = paramsDataArr;
	            data.billTypeId = "050206";
	            data.serviceId = mainRow.id;
	            data.itemId = mrecordId;
	            data.token = token;
            }

            nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '处理中...'
	        });
            nui.ajax({
                url:url,
                type:"post",
                async: false,
                data:data,   
                success:function(text){   
                    var errCode = text.errCode;
                    var errMsg = text.errMsg;
                    if(errCode == "S"){
						nui.unmask(document.body);
                        showMsg('领料成功!','S'); 
                        if(settleType == "ADD") {
                        	mainGrid.reload();
                        }else {
                        	CloseWindow("ok");
                        }
                        //CloseWindow("ok");
                    }else{ 
                    	nui.unmask(document.body);
                        showMsg(errMsg,'E'); 
                    }
                }  
            }); 
        }else{  
            showMsg('请填写需要出库的配件数量!','W'); 
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
    
    function positions(){
    	var row = mainGrid.getSelected();
    	if(row){
		    	nui.open({
				url: webBaseUrl + "com.hsweb.repair.repoart.editPositions.flow?token="+token,
				title:"快速修改仓位",
				height:"200px",
				width:"300px",
				onload:function(){
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData(row);
				},
				ondestroy:function(action){ 
					if (action == "saveSuccess") {
							onSearch(row.partId,"Id");
						}
		        }
		
		    });
    	}else{
    		showMsg('请选择一条记录!','W');
    	}
    }
</script>

</body>

</html>