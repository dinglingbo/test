<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:29:48
  - Description:
-->
<head>
<title>维修营业明细</title>
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
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本周</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上周</u></a>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本月</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上月</u></a>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本年</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上年</u></a>
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
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="history()">查看维修历史</a>
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="print()">打印(P)</a>
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-toolbar" style="width: 100%;background: #DDD;">
		<label>把列标题拖放到此处使记录按此列进行分组</label>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
			 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
			 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
			 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
			 frozenStartColumn="0" frozenEndColumn="6">

			<div property="columns">
				<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
				<div header="辅助信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">分店名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">工单号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户卡号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">接车卡号</div>
					</div>
				</div>
				<div header="基本信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">品牌</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">车型</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">质检员</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">客户名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">业务类型</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修类型</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">投保公司</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">维修日期</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">离厂日期</div>
					</div>
				</div>
				<div header="工时信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">工时总额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">免费工时</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">收费工时</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠率</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">工时小计</div>
					</div>
				</div>	
				<div header="材料信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">材料总额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">免费材料</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">收费材料</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠率</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">材料小计</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">材料成本</div>
					</div>
				</div>
				<div header="维修费用" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">维修金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">材料管理费</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">辅料费</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">折让金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">其他费用</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">整单优惠率</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">总优惠金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">免费+优惠+折让</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">预提费用</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">预提说明</div>
					</div>
				</div>
				<div header="提成数据" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">机电金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">机电提成</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">钣金金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">钣金提成</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">喷漆金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">喷漆提成</div>
					</div>
				</div>
				<div header="出单信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">开大金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">开大税款</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">返利</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">出单优惠合计</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">出单小计</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">出单折让</div>
					</div>
				</div>
				<div header="营业数据" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">结算金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">储值卡付款</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">应收金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">营业收入</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">真实收入</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">发票金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">计划税款</div>
					</div>
				</div>
				<div header="毛利数据" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">毛利</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">毛利率</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="150px">毛利备注</div>
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
    			title:"高级查询",width:400,height:250,
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
    	function history(){
    		nui.open({
    			url:"../../common/History.jsp",
    			title:"维修历史",width:850,height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"history"};
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