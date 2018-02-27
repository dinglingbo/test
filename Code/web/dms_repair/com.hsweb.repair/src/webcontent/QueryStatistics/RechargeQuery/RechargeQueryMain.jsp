<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>储蓄卡充值查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">快速查询：</label>
	        	    </td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本日</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>昨日</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本周</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上周</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本月</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上月</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本年</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上年</u></a>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onMore()" style="color:#0000FF"><u>更多</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true"  iconCls="icon-undo" onclick="onRefund()">退款</a>
					<a class="nui-button" plain="true"  iconCls="icon-goto" onclick="onRecharge()">转充值</a>
					<a class="nui-button" plain="true"  iconCls="icon-remove" onclick="onRemove">删除</a>
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="print()">打印</a>
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
			 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
			 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
			 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
			 frozenStartColumn="0" frozenEndColumn="6">

			<div property="columns">
				<div type="indexcolumn"headerAlign="center" width="30px">序号</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">会员卡号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户电话</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">充值日期</div>
					</div>
				</div>
				<div header="充值信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">充值金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">赠送金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">赠送积分</div>
					</div>
				</div>
				<div header="余额信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">储蓄余额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">赠送余额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">赠送积分</div>
					</div>
				</div>	
				<div header="备注" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">记录人</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">记录日期</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="120px">备注</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	function onMore(){
    		nui.open({
    			url:"./subpage/More.jsp",
    			title:"高级查询",width:370,height:210,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"more"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function onRefund(){
    		nui.open({
    			url:"./subpage/Refund.jsp",
    			title:"会员退款",width:420,height:280,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"onRefund"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function onRecharge(){
    		nui.open({
    			url:"./subpage/Recharge.jsp",
    			title:"储值卡转充值",width:390,height:300,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"onRecharge"};
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