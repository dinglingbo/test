<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-09-17 11:03:30
  - Description:
-->
<head>
<style type="text/css">
table{
	margin-top:10px;
}
</style>
<title>采购订单打印</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div style="margin: 0 10px;" class="printny">
        <div class="nui-fit">
        	<div>
        		<table id="" width="100%">
				  <tr style="font-size:25px;">
				    <td id="currOrgName"></td>
				    <td id="">采购订单</td>
				  </tr>
				  <tr>
				    <td id="">地址：湖南省长沙市长沙县中南汽配批发市场Y18栋110-112号</td>
				    <td id="">No:CGD2018090080</td>
				  </tr>
				  <tr>
				    <td id="">电话073186205120</td>
				    <td id="">订单日期 2018/09/07/13:49:45</td>
				    <td id="nowDate">打印日期 2018/09/07/13:49:45</td>
				  </tr>
				  <tr>
				    <td id="">供应商：杭州申令</td>
				    <td id="">联系人</td>
				    <td id="">联系方式</td>
				  </tr>
				  <tr>
				    <td id="">地址</td>
				    <td id="">票据类型：收费</td>
				    <td id="">结算方式现结</td>
				  </tr>
				</table>
        	</div> 
            <div>
				<table id="" width="100%" border="0">
					<tr>
						<td id="">配件编码</td>
						<td id="">配件名称</td>
						<td id="">品牌</td>
						<td id="">车型</td>
						<td id="">单位</td>
						<td id="">数量</td>
						<td id="">单价</td>
						<td id="">金额</td>
						<td id="">备注</td>
						<td id="">仓库</td>
						<td id="">仓位</td>
						<td id="">OEM码</td>
						<td id="">规格/方向/颜色</td>
					</tr>
					 <tbody id="tbodyId">
					 </tbody>
				</table>
			</div>
            <div>
            	<table id="" width="100%">
				  <tr>
				    <td id="">合计</td>
				    <td id="" >合计409.0</td>
				    <td id="">37337.0</td>
				  </tr>
				  <tr>
				    <td id="">打印人：系统管理员</td>
				    <td id="">送货人：</td>
				    <td id="">收货人：</td>
				  </tr>
				  <tr>
				    <td id="">备注</td>
				  </tr>
				   <tr>
				    <td id="">注(白联仓库   红联财务  黄联供应商)</td>
				  </tr>
				</table>
            </div>
        </div>
       </div>
	<script type="text/javascript">
		var date=new Date();
    	$(document).ready(function(){
    		$('#currOrgName').text(currOrgName);
    		$('#nowDate').text("打印日期"+format(date,"yyyy/MM/dd/HH:mm:ss"));
    	});
    </script>
</body>
</html>