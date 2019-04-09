<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/commonPart.jsp"%>
<!-- 
  - Author(s): Administrator
  - Date: 2019-04-08 18:10:41
  - Description:
-->
<head>
<title>入库记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>

    
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
                <div  field="enterDate" name="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div allowSort="true"  field="enterQty" name="enterQty"  datatype="float"  summaryType="sum" width="40" headerAlign="center" header="入库数量"></div>
                <div allowSort="true"  field="returnQty" name="returnQty"  datatype="float"  summaryType="sum" width="40" headerAlign="center" header="退货数量"></div>
                <div field="code" name="code" width="100" headerAlign="center" header="入库单号"></div>
                <div   field="guestName" name="guestName" width="100" headerAlign="center" header="供应商"></div>
                <div datatype="float" name="enterTypeId" field="enterTypeId"  width="60" headerAlign="center" header="入库类别"></div>
                <div  field="orderMan" name ="orderMan"  width="60" headerAlign="center" header="采购员"></div>>
              </div>
          </div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    	var enterPartGrid =null;
    	var baseUrl = apiPath + partApi + "/";
    	var enterGridUrl = baseUrl  +
    	 "com.hsapi.part.query.report.queryEnterRecord.biz.ext";
    	 
	    var billTypeIdHash = {
			"050101" :"采购入库",
			"050103" :"盘盈入库",
			"050105" :"期初入库",
			"050107" : "耗材入库",
			"050104" :"移仓入库",
			"050108" :"退货归库",
		    "050109" :"成品入库"
		};
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
		});
		
		function SetData(params) {
			params = nui.clone(params);
			onSearch(params);
		    
		}
		function onSearch(params){
			enterPartGrid.load({params :params});
		}
    </script>
</body>
</html>