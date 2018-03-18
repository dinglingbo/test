<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-03-16 16:23:49
  - Description:
-->
<head>
<title>辅助查询</title>
	<script src="<%=webPath + cloudPartDomain%>/common/js/embed/srvBottom.js?v=1.0.1"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>

      <div class="nui-fit">
      
	      	<div id="mainTabs" class="nui-tabs" 
	      		 activeIndex="0" 
	      		 style="width:100%; height: 100%;" 
	      		 plain="false" 
	      		 onactivechanged="showTabInfo">
			    <div title="库存明细" name="stockselect" >
			      <div class="nui-fit">
			      		<div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                     showPager="true"
		                 	 pageSize="50"
		                 	   sizeList=[20,50,100,200]
		                     selectOnLoad="true"
		                     showModified="false"
		                     ondrawcell="onLeftGridDrawCell"
		                     onrowdblclick=""
		                     onselectionchanged="onLeftGridSelectionChanged"
		                     dataField="pjPchsOrderMainList"
		                     url="">
		                    <div property="columns">
		                    	<div type="indexcolumn">序号</div>
		                        <div field="serviceId" headerAlign="center" width="150" header="订单单号"></div>
		                        <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
		                        <div field="auditSign" width="35" headerAlign="center" header="状态"></div>
		                        <div field="guestFullName" width="80" headerAlign="center" header="供应商"></div>
		                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
		                    </div>
		                </div>
			      </div>
			    </div>
			    <div title="采购记录" name="pchsRecord" >
			      <div class="nui-fit">
			      </div>
			    </div>  
			    <div title="销售记录" name="sellRecord" >
			      <div class="nui-fit">
			      </div>
			    </div> 
			    <div title="客户销价" name="guestPrice" >
			      <div class="nui-fit">
			      </div>
			    </div> 
			    <div title="退货记录" name="rtnRecord" >
			      <div class="nui-fit">
			      </div>
			    </div>
			    <div title="配件资料" name="partInfo" >
			      <div class="nui-fit">
			      </div>
			    </div>  
			</div>
      
      </div>



</body>
</html>