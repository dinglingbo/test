<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>	
<!-- 
  - Author(s): Administrator
  - Date: 2019-04-08 18:11:09
  - Description:
-->
<head>
<title>出库记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <link href="<%=webPath + contextPath%>/common/js/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/common/js/HeaderFilter.js" type="text/javascript"></script>
  
    
</head>
<body>
	
	<div class="nui-fit">
          <div id="outPartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="true"
               dataField="list"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               sortMode="client"
               totalField="page.count"
               showSummaryRow="true"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="outDate" name="outDate"dateFormat="yyyy-MM-dd HH:mm" width="100" headerAlign="center" header="出库日期"></div>
                <div field="storeId" name="storeId" width="50" headerAlign="center" header="仓库"></div>
                <div allowSort="true" visible="true" field="code" name ="code" width="160" headerAlign="center" header="工单号"></div>
                <div   field="enterTypeId" name="enterTypeId" width="100" headerAlign="center" header="出库类别"></div>
                <div allowSort="true"  field="sellQty" name="sellQty" datatype="float"summaryType="sum" width="60"headerAlign="center" header="出库量"></div>           
<!--                <div allowSort="true" field="sellPrice" name="sellUnitPrice" datatype="float" summaryType="sum" width="60" headerAlign="center" header="销售价"></div>
                <div allowSort="true" datatype="float" name="sellAmt" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>-->
                <div field="auditor" name ="auditor" width="60" headerAlign="center" header="出库人"></div>
                
              </div>
          </div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var outPartGrid =null;
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var outPartGridUrl = baseUrl  +
    	 "com.hsapi.cloud.part.report.report.queryOutRecord.biz.ext";
	    var storehouse =[];
		var storeHash = {};
		 var billTypeIdHash = {
			"050201" :"采购退货",
			"050202" :"销售订单",
			"050203" :"盘亏出库",
			"050204" :"调拨出库",
			"050207" :"移仓出库",
			"050211" :"调入退货"
		
		};
    	$(document).ready(function(v) {
    		$.ajaxSettings.async = false;
    		outPartGrid =nui.get('outPartGrid');
    		outPartGrid.setUrl(outPartGridUrl);
    		outPartGrid.on("drawcell",function(e){
    			 switch (e.field){
    			 	case "enterTypeId":
    			 		if(billTypeIdHash[e.value]){
    			 			e.cellHtml =billTypeIdHash[e.value] ||"";;
    			 		}else{
    			 			e.cellHtml="";
    			 		}
    			 	break;
    			 	case "storeId":
    			 		if(storeHash[e.value]){
    			 			e.cellHtml =storeHash[e.value].name || "";
    			 		}else{
    			 			e.cellHtml="";
    			 		}
    			 	break;
    			 }
    		});
		 var filter = new HeaderFilter(outPartGrid, {   
	        columns: [
	            { name: 'auditor' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
	    
	    getStorehouse(function(data) {
			storehouse = data.storehouse || [];
			storehouse.forEach(function(v){
    			storeHash[v.id]=v;
        		});
        	});
	    
		});
		
		function SetData(params) {
			params = nui.clone(params);
			onSearch(params);
		    
		}
		function onSearch(params){
			outPartGrid.load({params :params});
		}
    </script>
</body>
</html>