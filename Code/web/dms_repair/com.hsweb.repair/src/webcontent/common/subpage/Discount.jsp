<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-05 11:47:39
  - Description:
-->
<head>
<title>优惠设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#d {
    		width:80px
    	}
    	#data{
    		width:110px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" style="width:98%;height:90px;margin:7px" title="工时信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;">
					<label>客户名称：</label>
				</td>
				<td >
					<input class="nui-textbox" id="data" allowInput="false" /> 
				</td>
				<td style="width:105px;">
					<label>会员等级：</label>
				</td>
				<td >
					<input class="nui-textbox" id="data" allowInput="false" /> 
				</td>
				<td style="width:72px;">
					<label>入会日期：</label>
				</td>
				<td >
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;">
					<label>项目优惠率：</label>
				</td>
				<td >
					<input class="nui-spinner" id="data"  format="0" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:105px;">
					<label>材料优惠率：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;">
					<label>到期日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:98%;height:70px;margin:7px" title="快速优惠">
		<table>
			<tr style="display: block;margin: -1px 0 ">
				<td >
					<input class="nui-checkbox"/> 
				</td>
				<td>
					<label>正常优惠：</label>
				</td>
				<td>
					<input class="nui-checkbox"/> 
				</td>
				<td>
					<label>出单优惠：</label>
				</td>
				<td>
					<input class="nui-checkbox" /> 
				</td>
				<td>
					<label>工时优惠：</label>
				</td>
				<td>
					<input class="nui-spinner" id="d"  format="0" showButton="false" maxValue="100000000"/> 
				</td>
				<td>
					<label>材料优惠：</label>
				</td>
				<td>
					<input class="nui-spinner" id="d"  format="0" showButton="false" maxValue="100000000"/> 
				</td>
				<td>
					<a class="nui-button" onclick="onOk" >取消(C)</a>    
				</td>
			</tr>
		</table>
	</div>
	
	<div class="nui-fit" >
		<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 98%; height: 100%;margin:0 7px"  plain="false" onactivechanged="">
			<div title="工时优惠信息" url="./discountSubpage/TimeDiscount.jsp"></div>
			<div title="材料优惠信息" url="./discountSubpage/MateriaPreference.jsp"></div>
			<div title="出单项目优惠" url="./discountSubpage/OutItem.jsp"></div>
			<div title="出单材料优惠 " url="./discountSubpage/OutMateria.jsp"></div>
		</div>
	</div>
	<div>
		<table>
			<tr style="display:block; margin-left: 5px">
				<td>
					<span >工时优惠率：
						<span id="total">
						</span>
					</span>
				</td>
				<td>
					<span>材料优惠率：
						<span id="total">
						</span>
					</span>
				</td>
				<td>
					<span >优惠共计：
						<span id="total" >
						</span>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-3px;">
			<tr>
				<td style="text-align:right;">
					<a class="nui-button" onclick="onSave()" style="margin-right:10px;">保存(S)</a>      
					<a class="nui-button" onclick="onCancel" style="margin-right:5px;">取消(C)</a>       
				</td>
			</tr>
		</table>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>