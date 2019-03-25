<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!--  
  - Author(s): Administrator 
  - Date: 2018-01-25 14:17:08 
  - Description:      
--> 

<head>
  <title>维修出库</title>  
  	    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    	<script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
  <style type="text/css">
  .title {
    width: 60px;
    text-align: right;
}
a { 
    text-decoration: none;
}
 a#service{
	text-decoration:underline
}
a#car{
	text-decoration:underline
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
    	 <label style="font-family:Verdana;">快速查询：</label>
                    
<!--                     <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a> -->

<!--                 <ul id="popupMenuDate" class="nui-menu" style="display:none;"> -->
<!--                 <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li> -->
<!--                 <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li> -->
<!--                 <li class="separator"></li> -->
<!--                 <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li> -->
<!--                 <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li> -->
<!--                 <li class="separator"></li> -->
<!--                 <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li> -->
<!--                 <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li> -->
<!--                 <li class="separator"></li> -->
<!--                 <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li> -->
<!--                 <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li> -->
<!--             </ul> -->
                
            <input class="nui-textbox" id="name" name="name" emptyText="输入客户姓名" width="120" />
            <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="120" />
<!--             <input class="nui-combobox" id="status" name="status" emptyText="选择维修进程" data="con_data_status" valueField="id" textField="text" showNullItem="true" nullItemText="所有"/> -->
<!--             <input class="nui-combobox" id="isSettle" name="isSettle" emptyText="选择结算状态"  data="con_data_isSettle" valueField="id" textField="text" showNullItem="true" nullItemText="所有"/> -->
            <input name="serviceTypeId"
            id="serviceTypeId"
            class="nui-combobox width1"
            textField="name"
            valueField="id"
            emptyText="请选择业务类型"
            url=""
            allowInput="true"
            showNullItem="true"
            width="120"
            valueFromSelect="true"
            onvaluechanged=""
            nullItemText="请选择..."/>
<!--             开单日期 从<input id="date1" name="" class="nui-datepicker" value=""/> -->
<!--             至 <input id="date2" name="" class="nui-datepicker" value=""/> -->
			<input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="按工单号查询" width="120" />
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
    onshowrowdetail=""  allowCellWrap = true url="">
    <div property="columns">
    	<div type="indexcolumn" width="15">序号</div>
        <div field="id" name="id" visible="false">id</div>
        <div field="serviceCode" name="serviceCode" width="110" headerAlign="center" align="center">单号</div>
        <div field="guestFullName" name="guestFullName" width="80" headerAlign="center" align="center">客户姓名</div>
<!--         <div field="guestMobile" name="guestMobile" width="40" headerAlign="center" align="center">手机号码</div> -->
        <div field="carNo" name="carNo" width="80" headerAlign="center" align="center">车牌号</div>
        <div field="boxModel" name="boxModel" width="80" headerAlign="center" align="center" visible="false">波箱型号</div>
        <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" align="center">服务顾问</div>
        <div field="carModel" name="carModel" width="100" headerAlign="center" align="center">品牌车型</div>
        <div field="billTypeId" name="billTypeId" width="80" headerAlign="center" align="center">工单类型</div>
        <div field="serviceTypeName" name="serviceTypeName" width="100" headerAlign="center" align="center">业务类型</div>
<!--         <div field="isSettle" name="isSettle" width="30" headerAlign="center" align="center">结算状态</div> -->
        <div field="enterDate" name="recordDate" width="100" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">进厂日期</div>
        <div field="action" name="action" width="80" headerAlign="center" header="操作" align="center" align="center"></div>
    </div> 
</div>
</div>
   
<script type="text/javascript">
	var webBaseUrl = webPath + contextPath + "/";
    var con_data_status = [{id:0,text:"草稿"},{id:1,text:"施工中"},{id:2,text:"已完工"}];
    var con_data_isSettle = [{id:1,text:"已结算"},{id:0,text:"未结算"}];
    nui.parse();
    var servieTypeList = [];
    var servieTypeHash = {};
    var mainGrid = nui.get("mainGrid");
    var tstatus = nui.get("status");
    var isSettle = nui.get("isSettle");
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
    mainGrid.setUrl(gridUrl);
    
//     beginDateEl = nui.get("date1");
//     endDateEl = nui.get("date2");
	if(currCompType == "GEARBOX"){
		mainGrid.showColumn("boxModel");
	}
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
          servieTypeHash[v.id] = v;
      });
    });
	onSearch();

//     var yy = (new Date()).getFullYear();
//     var mm = ((new Date()).getMonth() + 1);
//     var dd = (new Date()).getDate();
//     var da = yy + "-" + mm; //本月月
//     var db = yy + "-" + mm + "-" + dd; //本月月
//     nui.get("date1").setValue(da);
//     nui.get("date2").setValue(db);
//     quickSearch(4);
    
//     var currType = 2;
// 	function quickSearch(type){
// 	    var params = {};
// 	    var querysign = 1;
// 	    var queryname = "本日";
// 	    var querystatusname = "草稿";
// 	    switch (type)
// 	    {
// 	        case 0:
// 	            params.today = 1;
// 	            params.sRecordDate = getNowStartDate();
// 	            params.eRecordDate = addDate(getNowEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "本日";
// 	            break;
// 	        case 1:
// 	            params.yesterday = 1;
// 	            params.sRecordDate = getPrevStartDate();
// 	            params.eRecordDate = addDate(getPrevEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "昨日";
// 	            break;
// 	        case 2:
// 	            params.thisWeek = 1;
// 	            params.sRecordDate = getWeekStartDate();
// 	            params.eRecordDate = addDate(getWeekEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "本周";
// 	            break;
// 	        case 3:
// 	            params.lastWeek = 1;
// 	            params.sRecordDate = getLastWeekStartDate();
// 	            params.eRecordDate = addDate(getLastWeekEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "上周";
// 	            break;
// 	        case 4:
// 	            params.thisMonth = 1;
// 	            params.sRecordDate = getMonthStartDate();
// 	            params.eRecordDate = addDate(getMonthEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "本月";
// 	            break;
// 	        case 5:
// 	            params.lastMonth = 1;
// 	            params.sRecordDate = getLastMonthStartDate();
// 	            params.eRecordDate = addDate(getLastMonthEndDate(), 1);
// 	            querysign = 1;
// 	            queryname = "上月";
// 	            break;
// 	        case 10:
// 	            params.thisYear = 1;
// 	            params.sRecordDate = getYearStartDate();
// 	            params.eRecordDate = getYearEndDate();
// 	            querysign = 1;
// 	            queryname = "本年";
// 	            break;
// 	        case 11:
// 	            params.lastYear = 1;
// 	            params.sRecordDate = getPrevYearStartDate();
// 	            params.eRecordDate = getPrevYearEndDate();
// 	            querysign = 1;
// 	            queryname = "上年";
// 	            break;
// 	        default:
// 	            break;
// 	    }
// 	    beginDateEl.setValue(params.sRecordDate);  
// 	    endDateEl.setValue(addDate(params.eRecordDate,-1));
// 	    currType = type;
// 	    if(querysign == 1){
// 	    	var menunamedate = nui.get("menunamedate");
// 	    	menunamedate.setText(queryname); 	
// 	    }
	    
// 	    onSearch();
// 	}
    function onSearch(){

//         var fdate1 = nui.get("date1").value;
//         var fdate2 = nui.get("date2").value;
        //fdate2.setDate(fdate2.getDate()+1);

//         var sdate = nui.formatDate (fdate1,"yyyy-MM-dd");
//         var edate = nui.formatDate (fdate2,"yyyy-MM-dd");
//         edate = edate + " 23:59:59";
        var params ={
            // part :1,
            carNo:nui.get("carNo").value,
            name:nui.get("name").value,
            serviceCode :nui.get("serviceCode").value,
//             sRecordDate:sdate,
//             eRecordDate:edate,
            status:1,
            serviceTypeId:nui.get("serviceTypeId").value,
//             isSettle:isSettle.value,
            token:token
        };
        mainGrid.load({params:params,token:token});
    }
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // Enter
			onSearch();
		}

	}
	$("#name").bind("keydown", function(e) {
		if (e.keyCode == 13) {
			var carNo = nui.get("carNo");
			carNo.focus();
			onSearch();
		}
	});

    mainGrid.on("celldblclick",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;  
        var sid = record.id;
        newrepairOut("ll"); 
    });


    mainGrid.on("drawcell", function (e) {
        var value = e.value;
        if (e.field == "serviceTypeId") {
            if (servieTypeHash && servieTypeHash[e.value]) {
                e.cellHtml = servieTypeHash[e.value].name;
            }
        }else if (e.field == "status") {
            if (value == 0) {
                e.cellHtml = "草稿";
            }else if(value == 1){
            	e.cellHtml = "施工中";
            }else if(value == 2){
            	e.cellHtml = "已完工";
            }
        }else if (e.field == "isSettle") {
            if (value == 0) {
                e.cellHtml = "未结算";
            }else if(value == 1){
            	e.cellHtml = "已结算";
            }
        }else if (e.field == "serviceTypeName") {
                e.cellHtml = retSerTypeStyle(e.cellHtml);
        }else if(e.field == "billTypeId"){
        	if (value == 0) {
                e.cellHtml = "综合开单";
            }else if(value == 1){
            	e.cellHtml = "检查开单";
            }else if (value == 2) {
                e.cellHtml = "洗美开单";
            }else if(value == 3){
            	e.cellHtml = "销售开单";
            }else if (value == 4) {
                e.cellHtml = "理赔开单";
            }else if(value == 5){
            	e.cellHtml = "退货开单";
            }else{
            	e.cellHtml = "波箱开单";
            }
        }
    });
var headerHash = [{ name: '综合开单', id: '0' }, { name: '检查开单', id: '1' }, {name: '洗美开单' , id: '2' }, { name: '销售开单', id: '3' }, { name: '理赔开单', id: '4' }, { name: '退货开单', id: '5' }, { name: '波箱开单', id: '6' }];
    function newrepairOut(type) {
        var row = mainGrid.getSelected();
        if(row){ 
            var item={};
            item.id = "checkDetail";
            item.text = "配件出库详情";
            item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp";
            item.iconCls = "fa fa-file-text";
            //window.parent.activeTab(item);
            var params = {
                id:row.id,
                row: row
            };
            window.parent.activeTabAndInit(item,params);
        }else{
            nui.alert("请先选择一条记录！");
        }
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
    var ll = '<a  href="javascript:newrepairOut('+"'ll'"+ ')">&nbsp;&nbsp;&nbsp;&nbsp;领料</a>';//class="icon-collapse"
    var th = '<a  href="javascript:newrepairOut('+"'th'"+ ')">&nbsp;&nbsp;&nbsp;&nbsp;退货</a>';//class="icon-addnew"
    if(column.field == "action"){
        e.cellHtml = ll +"&nbsp;&nbsp;" + th;
    }
    if(column.field == "serviceCode"){
       e.cellHtml ='<a id="service" href="##" onclick="newrepairOut('+"'ll'"+ ')">'+e.value+'</a>';
    }
  	if(column.field == "carNo"){
    	e.cellHtml ='<a id="car" href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
    }

});

function showCarInfo(row_uid){
	var row = mainGrid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.carId,
				carNo : row.carNo,
				guestId : row.guestId,
				contactorId:row.contactorId
		};
		doShowCarInfo(params);
	}
}

var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'guestFullName' },
            { name: 'billTypeId' }
        ],
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    		case "billTypeId"://预约来源
	    			value = headerHash;
	    			break;
	    	}
        	return value;
        }
    });
/*function edit() {
    var row = mainGrid.getSelected();
    if(row){ 
      newrepairOut(row,'edit');
  }else{
      nui.alert("请先选择一条记录！");
  }
}*/
</script>

</body>

</html>