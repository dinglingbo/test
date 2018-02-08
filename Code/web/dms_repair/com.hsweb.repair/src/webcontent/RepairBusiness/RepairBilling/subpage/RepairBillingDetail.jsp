<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 17:14:45
  - Description:
-->
<head>
<title>维修开单（弹窗）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#combo{
    		width:140px
    	}
    	#basetd1{
    		width:140px
    	}
    	#basetd2{
    		width:350px
    	}
    	#text1{
    		width:166px
    	}
    	#text2{
    		width:400px
    	}
    	#textarea{
    		width: 212px;
    		height: 100px;
    	}
    	#data{
    		width:150px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%;">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-5px 0">
					<td>
						<a class="nui-button" iconCls="icon-save" onclick="save()" plain="true">保存</a>
						<a class="nui-button" iconCls="icon-addnew" onclick="import()" plain="true">导入</a>
						<a class="nui-button" iconCls="icon-node" onclick="count()" plain="true">计算</a>
						<a class="nui-button" iconCls="icon-print" onclick="print()" plain="true">打印</a>
						<a class="nui-button" iconCls="icon-close" onclick="close()" plain="true">关闭</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	 <div  class="nui-panel" showToolbar="false" title="维修信息" showFooter="false" style="width:99%;height:147px;margin: 4px ;">
		<table>
			<tr style="display: block; margin:-3px 0 0 0">
				<td width="60px" style="text-align: right;">
					<label>车牌号：</label>
				</td>
				<td>
					<input class="nui-buttonedit"id="basetd1" allowInput="false" onclick="customer()"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>业务类型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>维修类型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>维修顾问：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd1"/> 
				</td>
			</tr>
			<tr style="display: block; margin:0">
				<td width="60px" style="text-align: right;">
					<label>进厂日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>进厂油量：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>进厂里程：</label>
				</td>
				<td>
					<input class="nui-spinner" id="basetd1" maxValue="100000000" changeOnMousewheel="false" showbutton="false" allowNull="true" value="&nbsp"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>报价日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block; margin:0">
				<td width="60px" style="text-align: right;">
					<label>维修日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>完工日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>总检日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>出厂日期：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block; margin:0 0 -5px 0">
				<td width="60px" style="text-align: right;">
					<label>备注：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd2"/>
				</td>
			</tr>
		</table>
	</div>
	<div  class="nui-panel" showToolbar="false" title="维修金额" showFooter="false" style="width:99%;height:248px;margin: 4px;">
		<table style="width: 100%">
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
			<tr>
				<td>
					<div style="width:100%;height:0;border: 0.6px solid #AAAAAA;margin:5px 0" ></div>
				</td>
			</tr>
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
					<label>材料优惠率：</label>
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
			<tr>
				<td>
					<div style="width:100%;height:0;border: 0.6px solid #AAAAAA;margin:5px 0" ></div>
				</td>
			</tr>
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
			<tr style="display: block;margin: -3px 0 0 0">
				<td style="width:105px;text-align: right">
					<label>维修费用：</label>
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
			<tr style="display: block;margin: 0 0 -5px 0">
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
		</table>
	</div>
	<div  class="nui-panel" showToolbar="false" title="描述信息" showFooter="false" style="width:99%;height:170px;margin:4px;">
		<table style="margin:0 0 -3px 0">
			<tr style="display: block; margin:0">
				<td>
					<div>客户描述：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
				<td >
					<div>故障现象：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
				<td >
					<div>解决措施：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
				<td >
					<div>出车报告：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div  class="nui-panel" showToolbar="false" title="客户/车辆信息" showFooter="false" style="width:99%;height:120px;;margin: 4px;">
		<table>
			<tr style="display: block; margin: -3px 0 0 0">
				<td width="74px" style="text-align: right;">
					<label>品牌：</label>
				</td>
				<td>
					<input class="nui-combobox" id="text1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>车型：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text1" class="nui-textbox" />
				</td>
				<td width="60px" style="text-align: right;">
					<label>底盘号：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text1" class="nui-textbox" />
				</td>
			</tr>
			<tr style="display: block; margin:  0">
				<td width="74px" style="text-align: right;">
					<label>发动机号：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text1" class="nui-textbox" />
				</td>
				<td width="60px" style="text-align: right;">
					<label>客户名称：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text2" class="nui-textbox" />
				</td>
			</tr>
			<tr style="display: block; margin:  0 0 -3px 0">
				<td width="74px" style="text-align: right;">
					<label>联系人姓名：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text1" class="nui-textbox" />
				</td>
				<td width="60px" style="text-align: right;">
					<label>身份：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input class="nui-combobox" id="text1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>手机号码：</label>
				</td>
				<td width="60px" style="text-align: right;">
					<input id="text1" class="nui-textbox" />
				</td>
			</tr>
		</table>
	</div>
	




	<script type="text/javascript">
    	nui.parse();
    	
    	function customer(){
    		nui.open({
    			url:"../../common/Customer.jsp",
    			title:"客户选择",width:900,height:550,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"add"};
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