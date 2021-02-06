<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/commonPart.jsp"%>	
<!-- 
  - Author(s): Administrator
  - Date: 2019-04-08 18:11:09
  - Description:
-->
<head>
<title>出库记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
  
    
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
                <div field="pickDate" name="pickDate"dateFormat="yyyy-MM-dd HH:mm" width="100" headerAlign="center" header="出库日期"></div>
                <div allowSort="true" visible="true" field="serviceCode" name ="serviceCode" width="160" headerAlign="center" header="工单号"></div>
                <div allowSort="true" visible="true" field="carNo" name ="carNo" width="80" headerAlign="center" header="车牌号"></div>
                <div   field="pickType" name="pickType" width="100" headerAlign="center" header="出库类别"></div>
                <div allowSort="true"  field="outQty" name="outQty" datatype="float"summaryType="sum" width="60"headerAlign="center" header="出库量"></div>
                <div  field="outReturnSign" name="outReturnSign" width="60" headerAlign="center" header="是否归库"></div>
                <div allowSort="true"  field="outReturnQty" name="outReturnQty" datatype="float" summaryType="sum" width="60" headerAlign="center" header="退货量"></div>
                <div allowSort="true" field="sellUnitPrice" name="sellUnitPrice" datatype="float" summaryType="sum" width="60" headerAlign="center" header="销售价"></div>
                <div allowSort="true" datatype="float" name="sellAmt" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
                <div field="pickMan" name ="pickMan" width="60" headerAlign="center" header="领料人"></div>
                <div field="storeId" name="storeId" width="50" headerAlign="center" header="仓库"></div>
              </div>
          </div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var outPartGrid =null;
    	var baseUrl = apiPath + partApi + "/";
    	var outPartGridUrl = baseUrl  +
    	 "com.hsapi.part.query.report.queryOutRecord.biz.ext";
	    var storehouse =[];
		var storeHash = {};
    	$(document).ready(function(v) {
    		outPartGrid =nui.get('outPartGrid');
    		outPartGrid.setUrl(outPartGridUrl);
    		outPartGrid.on("drawcell",function(e){
    			 switch (e.field){
    			 	case "outReturnSign":
    			 		if(e.value == 1){
    			 			e.cellHtml ="是";
    			 		}else{
    			 			e.cellHtml="否";
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
	            { name: 'pickMan' }
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