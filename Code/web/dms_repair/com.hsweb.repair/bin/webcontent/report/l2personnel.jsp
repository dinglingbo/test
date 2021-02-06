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
<title>L2运营报表-营收分析</title>
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


<div id="" class="mini-toolbar" style="padding:10px;">
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



<table cellspacing="20px" >
	<tr>
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/2_1.jpg"/>
					</td>
					<td>
						<font size="4">营业额  100,000</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="red">环比   2%↓</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">同比  5%↑</font>
					</td>
				</tr>
			</table>

		</td>
		
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/2_2.jpg"/>
					</td>
					<td>
						<font size="4">成本 100,000</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="red">环比   2%↓</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">同比  5%↑</font>
					</td>
				</tr>
			</table>
		</td>
		
		<td width="300px" height="100px" bgcolor="#FFFFFF">
			<table>
				<tr>
					<td rowspan="3">
						<input  type="image" src="<%= request.getContextPath() %>/nuisample/img/2_3.jpg"/>
					</td>
					<td>
						<font size="4">毛利  100,000</font>
					</td>
					
				</tr>
				<tr>
					<td>
						<font size="2" color="red">环比   2%↓</font>
					</td>
				</tr>
				<tr>
					<td>
						<font size="2" color="#00BFFF">同比  5%↑</font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table cellspacing="20px" bgcolor="#FOF8FF">  
<div id="tabs1" class="mini-tabs" activeIndex="0" style="width:1380px;height:100px;" plain="false" >
    <div title="工单收入表" >
		<form action="">
        <input placeholder="车牌号/工单号/客户电话" />
        <a  class="nui-button" onclick="" >
    		搜索
		</a>
		    <input  type="radio" name="sj" value="1" />今天
		    <input  type="radio" name="sj" value="2" />7天
		    <input  type="radio" name="sj" value="1" />30天
        	自定义时间<input />
    	</form>
    	</div>
    
    
    	<div title="项目收入表"  >
	        <form action="">
	        <input placeholder="项目编号/项目名称" />
	        <a  class="nui-button" onclick="" >
	    		搜索
			</a>
			    <input  type="radio" name="sj" value="1" />今天
			    <input  type="radio" name="sj" value="2" />7天
			    <input  type="radio" name="sj" value="1" />30天
	        	自定义时间<input />
	    	</form>
   	 	</div>
</div>
</table>
<div class="nui-fit">
 <div class="nui-panel"   showToolbar="false" showFooter="false"  style="width:100%;height:100%;" >

      <div class="nui-fit">
        <div id="datagrid1" dataField="ooperators" class="nui-datagrid" style="width:100%;height:100%;" url="" pageSize="10" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
           <div field="" headerAlign="center" allowSort="true" >
            序号
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              项目编号
            </div>
            <div field="" headerAlign="center" allowSort="true" >
            项目名称
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              数量
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              合计金额
            </div>
            <div field="" headerAlign="center" allowSort="true" >
              操作
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