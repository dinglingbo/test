<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:33:05
  - Description:
-->
<head>
<title>维修顾问业绩</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">当前分析维度：</label>
	        	    </td>
	        	    <td>
	        	    	<label style="color:#FF0000">快速查询：</label>
	        	    </td>
	        	</tr>
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
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onMore()" style="color:#0000FF"><u>更多</u></a>
					</td>
					<td>
	        	    	<label style="font-family:Verdana;">快速分析：</label>
	        	    </td>
	        	    <td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按维修顾问</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按分店</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按品牌</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按客户来源</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按业务类型</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按维修类型</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按来厂次数</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="print()">打印(P)</a>
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit" style="width: 100%; height: 70%;">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height:100%;"url=""
			 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
			 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
			 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
			 frozenStartColumn="0" frozenEndColumn="1">

			<div property="columns">
				<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
				<div header="维度" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">按XX分析（根据快速分析结果）</div>
					</div>
				</div>
				<div header="车次信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">新客户</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">结算车次</div>
					</div>
				</div>
				<div header="工时信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">工时总额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">免费工时</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">收费工时</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠率</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">优惠金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">项目小计</div>
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
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">结算金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">发票金额</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">单产</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="margin:10px 0" >
		<table style="width:100%;margin-top:0;">
			<tr >
				<td style="text-align:right;">
					<a class="nui-button" onclick="onChoice()" style="margin-right:10px;width:70px">选择样式</a>  
					<span style="width:0;height:100%;border: 0.6px dashed #AAAAAA;margin:5px" ></span>
					<a class="nui-button" onclick="onCancel" style="margin-right:7px;width:60px;color:#0000FF" plain="true"><u>柱形图（列表）</u></a>       
				</td>
			</tr>
			<tr style="display: block; margin:0">
				<td>
					<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1320px;height: 60px;margin-top:5px"></a>  
				</td>				
			</tr>
		</table>
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
    	
    	function onChoice(){
    		nui.open({
    			url:"./subpage/onChoice.jsp",
    			title:"定制",width:200,height:300,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"onChoice"};
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