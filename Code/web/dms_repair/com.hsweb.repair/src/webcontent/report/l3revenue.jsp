<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-31 08:47:43
  - Description:
-->
<head>
<title>L3运营报表-应用概况</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }


	</style>

</head>
<body bgcolor="#FOF8FF">


<div id="" class="mini-toolbar" style="padding:10px;" >
    <table style="width:100%;">
        <tr>
        <td style="width:100%;">
			<select name="" style="width:150px;height:25px;">
				 <option >请选择大区</option>
				 <option value ="东莞大区">东莞大区</option>
			</select >
			<span>&nbsp;&nbsp;</span>
			<select name="" style="width:150px;height:25px;">
			 	<option >请选择门店</option>
			  	<option value ="广州3号店">广州3号店</option>
			</select>
			<span>&nbsp;&nbsp;</span>
			<select name="" style="width:150px;height:25px;">
			 	<option >请选择员工</option>
			 	 <option value ="张三">张三</option>
			</select>
			<span>&nbsp;&nbsp;</span>
			<input class="nui-datepicker" name="" text="请选择日期" style="width:150px;" />
			<span>&nbsp;&nbsp;</span>
			<input type="button" value="查询">
        </td>
        </tr>
    </table>
</div>



<table cellspacing="70px" >
	<tr>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/3_1.jpg"/>
					</td>
					<td>
						<font size="4">使用人数   3250</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">使用率  30%</font>
					</td>
				</tr>
			</table>
		</td>
	    <td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/3_2.jpg"/>
					</td>
					<td>
						<font size="4">报价车次 853</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">报价率30%</font>
					</td>
				</tr>
			</table>
		</td>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/3_3.jpg"/>
					</td>
					<td>
						<font size="4">施工车次  9854</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">施工率  50%</font>
					</td>
				</tr>
			</table>
		</td>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/3_4.jpg"/>
					</td>
					<td>
						<font size="4">结算车次  6354</font>
					</td>	
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">结算率  60%</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div class="nui-fit">
 <div class="nui-panel"   showToolbar="false" showFooter="false"  style="width:100%;height:100%;" >
<div class="mini-grid-columns" style="display: block;">
	<div class="mini-grid-columns-lock" style="left: -10px; width: 0px; height: auto;">
		<table class="mini-grid-table" cellspacing="0" cellpadding="0" border="0" style="width: 0px;">
			<tbody>
				<tr style="height:0px;">
					<td style="height:0px;width:0;">
					</td><td style="width:0px;"></td>
				</tr>
			</tbody>
		</table>
<div class="mini-grid-topRightCell"></div>
</div>
<div class="mini-grid-columns-view" style="margin-left: 0px; width: 100%; height: auto;">
	<table class="mini-grid-table" cellspacing="0" cellpadding="0" border="0" style="width: 1021px;">
		<tbody>
			<tr style="height:0px;">
				<td style="height:0px;width:0;"></td>
				<td id="13" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="16" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="19" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="20" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="21" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="24" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="26" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="27" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				<td id="28" style="padding:0;border:0;margin:0;height:0px;width:200px"></td>
				
			</tr>
			<tr>
				<td style="width:0;"></td>
				<td id="mini-18$headerCell2$13" class="mini-grid-headerCell    mini-grid-bottomCell " style="text-align:center;" rowspan="2">
					<div class="mini-grid-headerCell-outer">
					<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">区域</div>
					<div id="13" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
				<td id="mini-18$headerCell2$13" class="mini-grid-headerCell    mini-grid-bottomCell " style="text-align:center;" rowspan="2">
					<div class="mini-grid-headerCell-outer">
					<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">门店</div>
					<div id="13" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
				<td id="mini-18$headerCell2$16" class="mini-grid-headerCell    mini-grid-bottomCell " style="text-align:center;" rowspan="2">
					<div class="mini-grid-headerCell-outer">
					<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">使用人数</div>
					<div id="16" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
				<td id="mini-18$headerCell2$18" class="mini-grid-headerCell   " style="text-align:center;" colspan="2">
					<div class="mini-grid-headerCell-outer">
					<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">报价</div>
					<div id="18" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
				<td id="mini-18$headerCell2$23" class="mini-grid-headerCell   " style="text-align:center;" colspan="2">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">施工</div>
					<div id="23" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
				<td id="mini-18$headerCell2$25" class="mini-grid-headerCell    mini-grid-rightCell " style="text-align:center;" colspan="2">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">结算</div>
					<div id="25" class="mini-grid-column-splitter">
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:0;"></td>
				<td id="mini-18$headerCell2$19" class="mini-grid-headerCell    mini-grid-bottomCell " style="text-align:center;">
					<div class="mini-grid-headerCell-outer">
						<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">报价次数</div>
						<div id="19" class="mini-grid-column-splitter"></div>
					</div>
				</td>
				<td id="mini-18$headerCell2$20" class="mini-grid-headerCell    mini-grid-bottomCell" style="text-align:center;">
					<div class="mini-grid-headerCell-outer">
					<div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">报价率</div>
					<div id="20" class="mini-grid-column-splitter"></div>
					</div>
				</td>
				<td id="mini-18$headerCell2$24" class="mini-grid-headerCell    mini-grid-bottomCell " style="text-align:center;">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">施工次数</div>
					<div id="24" class="mini-grid-column-splitter"></div>
					</div>
				</td>
				<td id="mini-18$headerCell2$26" class="mini-grid-headerCell    mini-grid-bottomCell" style="text-align:center;">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap " title="">施工率</div>
					<div id="26" class="mini-grid-column-splitter"></div>
					</div>
				</td>
				<td id="mini-18$headerCell2$27" class="mini-grid-headerCell    mini-grid-bottomCell" style="text-align:center;">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap " title="">结算次数</div>
					<div id="27" class="mini-grid-column-splitter"></div>
					</div>
				</td>
				<td id="mini-18$headerCell2$28" class="mini-grid-headerCell    mini-grid-bottomCell  mini-grid-rightCell " style="text-align:center;">
					<div class="mini-grid-headerCell-outer"><div class="mini-grid-headerCell-inner  mini-grid-headerCell-nowrap ">结算率</div>
					<div id="28" class="mini-grid-column-splitter"></div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
<div class="mini-grid-topRightCell"></div>
</div>
<div class="mini-grid-scrollHeaderCell"></div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>