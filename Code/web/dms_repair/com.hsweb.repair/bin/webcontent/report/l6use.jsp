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
<title>L6运营报表-人员效应</title>
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
			<select name="month" style="width:150px;height:25px;" onclick="getMonth()">
			 	<option >请选择月份</option>
			 	<option value ="1">1月</option>
			 	<option value ="2">2月</option>
			 	<option value ="3">3月</option>
			 	<option value ="4">4月</option>
			 	<option value ="5">5月</option>
			 	<option value ="6">6月</option>
			 	<option value ="7">7月</option>
			 	<option value ="8">8月</option>
			 	<option value ="9">9月</option>
			 	<option value ="10">10月</option>
			 	<option value ="11">11月</option>
			 	<option value ="12">12月</option>
			</select>
			<span>&nbsp;&nbsp;</span>
			<input type="button" value="查询">
        </td>
        </tr>
    </table>
</div>

<div class="nui-form">
<table cellspacing="70px" >
	<tr>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/6_1.jpg"/>
					</td>
					<td>
						<font size="4">专职员工人数 </font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">500</font>
					</td>
				</tr>
			</table>
		</td>
	    <td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/6_2.jpg"/>
					</td>
					<td>
						<font size="4">人力费用</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">100,000</font>
					</td>
				</tr>
			</table>
		</td>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/6_3.jpg"/>
					</td>
					<td>
						<font size="4">工薪毛利占比</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">50%</font>
					</td>
				</tr>
			</table>
		</td>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/6_4.jpg"/>
					</td>
					<td>
						<font size="4">人效</font>
					</td>	
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">100,00</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div class="nui-fit">
 <div class="nui-panel"   showToolbar="false" showFooter="false"  style="width:100%;height:100%;" >

      <div class="nui-fit">
        <div id="datagrid1" dataField="ooperators" class="nui-datagrid" style="width:100%;height:100%;" url="" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
           <div field="" headerAlign="center" allowSort="true" >
            姓名
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              电话
            </div>
            <div field="" headerAlign="center" allowSort="true" >
            所属大区
            </div>
           <div field="" headerAlign="center" allowSort="true" >
         所属门店
            </div>
            <div field="" headerAlign="center" allowSort="true" >
            底薪
            </div>
            <div field="" headerAlign="center" allowSort="true" >
           提成
            </div>           <div field="" headerAlign="center" allowSort="true" >
            总额
            </div>
          </div>
        </div>
      </div>
    </div>
</div>
	<script type="text/javascript">
		nui.parse();	
 
    </script>
</body>
</html>