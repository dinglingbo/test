<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 15:39:18
  - Description:
-->

<head>
    <title>编辑整车销售</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
<%-- <script src="<%= request.getContextPath() %>/sales/sales/js/editCarSales.js?v=1.1089" type="text/javascript"></script> --%>

</head>
<style type="text/css">
 
    </style>

    <body>
        <div class="nui-fit" style="padding-top:10px">
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" onactivechanged="activechangedmain()" id="mainTabs" name="mainTabs">
               <div title="购车计算" id="editForm" name="editForm">
                  <iframe id="caCalculation" src="" style="width: 100%;height: 100%; border:0px" ></iframe>
               </div>
               <div title="购车计算" id="editForm" name="editForm">
                  <iframe id="caCalculation" src="" style="width: 100%;height: 100%; border:0px" ></iframe>
              </div>
        </div>
     </div>
<script type="text/javascript">
   
</script>
 </body>
</html>