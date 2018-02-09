<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 09:53:49
  - Description:
-->
<head>
<title>维修单审核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#cs{
    		width: 120px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table style="width:100%;">
		<tr style=" display:block;margin:5px 5px 0 5px">
			<td>
				<label>项目金额：</label>
			</td>
			<td>
				<input id="cs" class="nui-textbox" />
			</td>
			<td>
				<label>配件金额：</label>
			</td>
			<td>
				<input id="cs" class="nui-textbox" />
			</td>
			<td>
				<label>套餐金额：</label>
			</td>
			<td>
				<input id="cs" class="nui-textbox" />
			</td>
			<td>
				<label>合计金额：</label>
			</td>
			<td>
				<input id="cs" class="nui-textbox" />
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>出车报告：</label>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td>
				<input class="nui-textarea" style="width: 908px;height: 150px;margin:0"/>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>配件成本：</label>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px;height: 100%">
			<td style="width: 60px">
				<div  class="nui-datagrid" dataField="data" url="" style="width: 100%;height: 280px" showPager="false">
				    <div property="columns">
						<div header="零件信息" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="118px">零件名称</div>
								<div field="" headerAlign="center" allowSort="true" width="50px">单位</div>
								<div field="" headerAlign="center" allowSort="true" width="50px">数量</div>
							</div>
						</div>
						<div header="不含税成本" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="60px">单价</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">金额</div>
							</div>
						</div>
						<div header="含税成本" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="60px">单价</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">金额</div>
							</div>
						</div>
						<div header="实际成本" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="60px">单价</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">金额</div>
							</div>
						</div>
						<div header="销售信息" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="60px">单价</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">金额</div>
							</div>
						</div>
						<div header="领料信息" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="60px">领料人</div>
								<div field="" headerAlign="center" allowSort="true" width="90px">领料日期</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">审核人</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-1px;">
			<tr>
				<td style="text-align: left">
					<a class="nui-button" onclick="onChoice()" style="margin-left:5px;width:110px">选择出车报告(R)</a>    
				</td>
				<td style="text-align: right">
					<a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">确定(Y)</a> 
					<a class="nui-button" onclick="onOk" style="margin-right:5px;width:60px">关闭(C)</a>     
				</td>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	function onChoice(){
    		nui.open({
    			url:"../../common/subpage/OutCarDetail.jsp",
    			title:"出车报告",width:1200,height:690,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"choice"};
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