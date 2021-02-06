<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!-- 
  - Author(s): Administrator
  - Date: 2019-04-08 18:10:41
  - Description:
-->
<head>
<title>占用记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    

    
</head>
<body>
	    <div class="nui-fit">
          <div id="enterPartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="true"
               dataField="list"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               sortMode="client"
               totalField="page.count"
               showSummaryRow="true"
               pageSize="50"
			   sizeList="[20,50,100]"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="serviceId" name="serviceId" width="130" headerAlign="center" header="单号"></div>
                <div field="storeId" name="storeId" width="100" headerAlign="center" header="仓库"></div>
                <div field="partCode" name="partCode" width="130" headerAlign="center" header="配件编码"></div>
                <div  field="billQty" name="billQty" width="50" headerAlign="center" header="数量"></div>
                <div  field="lockStockQty" name="lockStockQty" width="50" headerAlign="center" header="占用数量"></div>
                <div field="createDate" name="createDate" width="120" headerAlign="center" header="操作时间" dateFormat="yyyy-MM-dd HH:mm"></div>
              </div>
          </div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var enterPartGrid =null;
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var enterGridUrl = baseUrl  +
    	 "com.hsapi.cloud.part.report.stock.querySellRecord.biz.ext";
    	 
	    var billTypeIdHash = {
			"050101" :"采购入库",
			"050103" :"盘盈入库",
			"050105" :"期初入库",
			"050107" : "耗材入库",
			"050110" :"移仓入库",
			"050108" :"退货归库",
		    "050109" :"成品入库"
		};
		var storehouse =[];
		var storeHash = {};
    	$(document).ready(function(v) {
    		enterPartGrid =nui.get('enterPartGrid');
    		enterPartGrid.setUrl(enterGridUrl);
    		enterPartGrid.on("drawcell",function(e){
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
    	
    	
		 /* var filter = new HeaderFilter(enterPartGrid, {   
	        columns: [
	            { name: 'guestName' },
	            { name: 'orderMan' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    }); */
	    
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
			enterPartGrid.load({params :params,token:token});
		}
    </script>
</body>
</html>