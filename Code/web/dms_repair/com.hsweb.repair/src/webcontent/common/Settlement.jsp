<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 11:38:07
  - Description:
-->
<head>
<title>完工结算</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
    <style type="text/css">
    	#data{
    		width:110px
    	}
    	
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" style="width:99%;height:90px;margin:3px" title="工时信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label>总工时费：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000" /> 
				</td>
				<td style="width:72px;text-align: right">
					<label>免费工时：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>收费工时：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;text-align: right">
					<label>优惠率：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="0" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>优惠金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>工时小计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:99%;height:90px;margin:3px" title="材料信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label>总材料费：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>免费材料：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>收费材料：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;text-align: right">
					<label>优惠率：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="0"  changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>优惠金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>材料小计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:99%;height:70px;margin:3px" title="其他费用信息">
		<table>
			<tr style="display: block;margin: 0 ">
				<td style="width:105px;text-align: right">
					<label>辅料费：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>管理费用：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>其他费用：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" maxValue="100000000"/> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:99%;height:90px;margin:3px" title="出单信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label>开大金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">开大税款：</label>
				</td>
				<td >
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" style="color: #FF0000" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>返利：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;text-align: right">
					<label>出单优惠合计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>出单小计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">出单折让：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false"  style="color: #FF0000" maxValue="100000000"/> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:99%;height:118px;margin:3px" title="结算信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label>维修金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>优惠合计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false"  maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">折让金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" style="color: #FF0000" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin: 0">
				<td style="width:105px;text-align: right">
					<label>免费+优惠+折让：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>结算金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">发票金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" style="color: #FF0000" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;text-align: right">
					<label>计划税款：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>备注说明：</label>
				</td>
				<td>
					<input class="nui-textbox" width="300px" /> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" style="width:99%;height:90px;margin:3px" title="营业信息">
		<table>
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label style="color: #FF0000">预提费：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" style="color: #FF0000" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">预提费说明：</label>
				</td>
				<td >
					<input class="nui-textbox" width="300px" style="color: #FF0000;"/> 
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -5px 0 ">
				<td style="width:105px;text-align: right">
					<label>营业收入：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label style="color: #FF0000">应收金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false"  style="color: #FF0000" maxValue="100000000"/> 
				</td>
				<td style="width:72px;text-align: right">
					<label>真实收入：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  format="￥0.00" showButton="false" changeOnMousewheel="false" allowInput="false"  maxValue="100000000"/> 
				</td>
			</tr>
		</table>
	</div>
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-3px;">
			<tr >
				<td style="text-align:left;margin-left:3px;">
					<a class="nui-button" onclick="onDiscount()" >优惠设置</a>  		              
				</td>
				<td style="text-align:right;">
					<a class="nui-button" onclick="onSave()" style="margin-right:10px;">保存（S）</a>      
					<a class="nui-button" onclick="on()" style="margin-right:10px;">转单（F）</a>  
					<a class="nui-button" onclick="onCancel" >取消（C）</a>       
				</td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	
    	function onDiscount(){
    		nui.open({
    			url:"../../common/subpage/Discount.jsp",
    			title:"优惠设置",width:680,height:550,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"discount"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    </script>
</body>
</html>