<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
<head>
    <title>查看调度</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/workDispatch/js/workShopMain.js?v=1.0.3" type="text/javascript"></script>  
</head>
<body>
   <div class="nui-fit" >
    <div id="mainGrid" class="nui-datagrid" dataField="itemDispatchList" style="width: 100%; height: 100%;" 
     idField="id" 
        sizeList="[20,50,100]" 
        pageSize="20" 
        totalField="page.count" 
        showPager="false" 
        showPagerButtonIcon="true" >
        <div property="columns">
            <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
            <div field="remark" width="70" headeralign="left" visible="true"><strong>操作</strong></div>
            <div field="recorder" width="70" headeralign="left" visible="true"><strong>操作人</strong></div>
            <div field="recordDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH:mm"><strong>时间</strong></div>
        </div>
    </div> 
   </div>
   <script type="text/javascript">
    	nui.parse();
    	var mainGrid = null;
    	var mainGridUrl = apiPath + repairApi + "/" + "com.hsapi.repair.repairService.sureMt.queryItemdisPatch.biz.ext";
    	$(document).ready(function (){
		mainGrid = nui.get("mainGrid");
		mainGrid.setUrl(mainGridUrl);
        document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        if ((keyCode == 27)) { // ESC
	            CloseWindow('cancle');
	        }
	        
	    }
	});	
	function setData(data){
	    mainGrid.load({
		token : token,
		serviceId : data.serviceId,
		itemId:data.itemId
	});
	}
    </script>
</body>
</html>