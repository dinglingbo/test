<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-25 15:20:44
  - Description:
-->
<head>
<title>总页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>

   <div showCollapseButton="false">
            <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%; height:900px;" plain="false" onactivechanged="">
                  
                    <div title="采购排行分析" >
                      <div class="nui-fit">
                      <%@ include file="purchase.jsp" %>
                      </div>
                    </div>
                    
                    <div title="门店汇总按月排行" >
                      <div class="nui-fit">
                      <%@ include file="mdmethon.jsp" %>
                      </div>
                    </div> 
                    
                        <div title="商品采购汇总按月排行" >
                      <div class="nui-fit">
                      <%@ include file="shopmethon.jsp" %>
                      </div>
                    </div> 
                    
                    <div title="供应商采购汇总按月排行" >
                      <div class="nui-fit">
                      <%@ include file="commodity.jsp" %>
                      </div>
                    </div>  
                    
                    <div title="品牌采购汇总按月排行" >
                      <div class="nui-fit">
                      <%@ include file="ppmethon.jsp" %>
                      </div>
                    </div> 
			</div>
    </div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>