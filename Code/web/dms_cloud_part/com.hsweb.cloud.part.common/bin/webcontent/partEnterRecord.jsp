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
<title>入库记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <link href="<%=webPath + contextPath%>/common/js/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/common/js/HeaderFilter.js" type="text/javascript"></script>

    
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
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div  field="auditDate" name="auditDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div field="storeId" name="storeId" width="50" headerAlign="center" header="仓库"></div>
                <div allowSort="true"  field="enterQty" name="enterQty"  datatype="float"  summaryType="sum" width="40" headerAlign="center" header="入库数量"></div>
<!--                <div allowSort="true"  field="enterPrice" name="enterPrice"  datatype="float"  summaryType="sum" width="40" headerAlign="center" header="入库价"></div>
                <div allowSort="true"  field="enterAmt" name="enterAmt"  datatype="float"  summaryType="sum" width="40" headerAlign="center" header="入库金额"></div>-->
                <div field="code" name="code" width="130" headerAlign="center" header="入库单号"></div>
                <div   field="guestName" name="guestName" width="130" headerAlign="center" header="供应商"></div>
                <div datatype="float" name="enterTypeId" field="enterTypeId"  width="60" headerAlign="center" header="入库类别"></div>
                <div  field="orderMan" name ="orderMan"  width="60" headerAlign="center" header="采购员"></div>>
              </div>
          </div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var enterPartGrid =null;
    	
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var enterGridUrl = baseUrl  +
    	 "com.hsapi.cloud.part.report.report.queryEnterRecord.biz.ext";
    	 
	    var billTypeIdHash = {
			"050101" :"采购入库",
			"050102" :"销售退货",
			"050103" :"盘盈入库",
			"050104" :"调拨入库",
			"050105" :"期初入库",
			"050107" :"移仓入库",
			"050111" : "调出退货"
		
		};
		/* "050204" :"调拨出库",
	    "050212" :"组装出库",
	    "050213" :"拆分出库" */
		var storehouse =[];
		var storeHash = {};
    	$(document).ready(function(v) {
    		$.ajaxSettings.async = false;
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
    	
    	
		 var filter = new HeaderFilter(enterPartGrid, {   
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
			enterPartGrid.load({params :params,token:token});
		}
    </script>
</body>
</html>