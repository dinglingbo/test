<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-03-16 16:23:49
  - Description:
-->
<head>
<title>辅助查询</title>
	<script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/embedJsp/srvBottom.js?v=2.0.3"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>

      <div class="nui-fit">
      
	      	<div id="mainTabs" class="nui-tabs" 
	      		 activeIndex="0" 
	      		 style="width:100%; height: 100%;" 
	      		 plain="false" 
	      		 onactivechanged="showTabInfo"
	      		 ontabload="onMainTabLoad"
	      		 >
			    <div title="本店库存" name="stockselect" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeStock" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>
			    <div title="库存分布" name="chainStock" url="">
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeStock" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>
			    <div title="库存明细" name="outableRecord" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeOutableRecord" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>
			    <div title="采购记录" name="pchsRecord" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframePchsRecord" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>  
			    <div title="销售记录" name="sellRecord" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeSellRecord" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div> 
			    <div title="客户销价" name="guestPrice" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeGuestPrice" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div> 
			    <div title="退货记录" name="rtnRecord" url="" visible="false">
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframeRtnRecord" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>
			    <div title="配件资料" name="partInfo" url="" visible="false" >
			      <!-- <div class="nui-fit">
			      		<iframe id="bottomFormIframePartInfo" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
			      </div> -->
			    </div>  
			</div>
      
      </div>



</body>
</html>