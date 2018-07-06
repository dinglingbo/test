<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-03 20:45:07
  - Description:
--> 
<head>   
<title>客户休息区看板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
      <style type="text/css">
  body {  
   margin: 0;     
   padding: 0;
   border: 0;
   width: 100%;
   height: 100%;
   overflow: hidden;
 }

.mini-grid-border{
   background: #000;
}
 .mini-panel-border{
  border: 0px;
 }
 .mini-grid-headerCell{
      background: #000;
    border-color: #000;
 }
 .mini-grid-viewport{
  background: #000;
 }
 .mini-grid-table{
  background: #000;
 }

 body .mini-grid-headerCell-nowrap{
      color: white;
    font-size: 18px;
 }

 html body .mini-grid-row-selected {
    background: #262626;  
}
 html body .mini-grid-row-hover{
  background :#8c8c8c;
}
.mini-grid-newRow {
    background: #201f35;
} 
.mini-grid-cell {
    border-color: #000; 
}
.mini-grid-cell-inner{ 
    color: white;
}
</style>
</head>
<body>
<div style="height: 40px;background-color: #fa8c16">
<table style="width: 100%;line-height: 2;">
<tr>
  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff">维修车间看板</td>
  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff">2018年7月3日20:57:53</td>
  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff"></td>

</tr>
</table>

</div>
<div class="nui-fit" style="background-color: #000">
    <div id="datagrid1" class="nui-datagrid" showPager="false">
        <div property="columns">
            <div field="no" width="100" headerAlign="center" align="center">车牌号</div>
            <div field="" width="100" headerAlign="center" align="center">接车时间</div>
            <div field="" width="100" headerAlign="center" align="center">预计完工时间</div>
            <div field="" width="100" headerAlign="center" align="center">施工状态</div>

        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
      var row = {no:"桂B 12345"};
      var grid = nui.get("datagrid1");
      grid.addRow(row);
    </script>
</body>
</html>