<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 11:24:15
  - Description:
-->
<head>
<title>预约管理</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<style type="text/css">
		#td{
			width:170px
		}
		#label1{
			width:85px
		}
		#label2{
			width:60px
		}
	</style>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
        <div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
        	<table class="table" id="table1" style="height:100% ">
        		<tr style="display: block; margin:-5px 0">
					<td width="80px">
						<span style="color:#0000FF;">车牌号：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width:120px; " /></label>
					</td>
					<td >
						<span style="color:#FF0000;margin-left: 10px;">预计来厂日期：</span>
					</td>							<td>
						<label field="" style="color:#0000FF;width: 50px; " /></label>
					</td>
					<td width="50px">
						<span style="color:#0000FF;margin-left: 10px;">进程：</span>
					</td>
					<td>
						<label field="" style="color:#FF0000;width: 70px; " /></label>	
					</td>
				</tr>
        		<tr>
        	   		<td>
        	    		<label style="font-family:Verdana;">快速查询：</label>
        	    	
        	         	<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本日预约车辆</u></a>
                	 	<a class="nui-button" plain="true" onclick="onSearch(1)" style="color:#0000FF"><u>本周预约车辆</u></a>
                	 	<a class="nui-button" plain="true" onclick="onSearch(2)" style="color:#0000FF"><u>本月预约车辆</u></a>
                	 	<a class="nui-button" plain="true" onclick="onSearch(3)" style="color:#0000FF"><u>已完工的车</u></a>
                	 	<a class="nui-button" plain="true" onclick="onSearch(4)" style="color:#0000FF"><u>在结算的车</u></a>
                	 	
                	</td>
                	<td>
                		<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
                	</td>
                	<td>
                		<label>车牌号：</label>
                	</td>
                	<td>
                		<input class="nui-textbox" style="widht:150px"/>
                		
                		<a class="nui-button" iconCls="icon-search" plain="true" onclick="">查询(Q)</a>
                		<a class="nui-button" plain="true" style="color: #0000FF" onclick="onMore()"><u>更多</u></a>
                		
                		<label>仅显示本人预约</label>
                		<div  class="nui-checkbox"></div>
					</td>
        		</tr>
			</table>
		</div>
	</div>
	
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新（R）</a> 
					<a class="nui-button" plain="true" iconCls="icon-add" onclick="add()">新增（A）</a>
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存（S）</a> 
					<a class="nui-button" plain="true" iconCls="icon-cancel" onclick="cancel()">取消（C）</a> 
					<a class="nui-button" plain="true" iconCls="" onclick="reservation()">预约跟踪（G）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="quote()">转入报价（T）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="history()">维修历史（W）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false">
			<div size="25%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url=""
						pageSize="20" showPageInfo="true" multiSelect="true"
						showPageIndex="false" showPage="true" showPageSize="false"
						showReloadButton="false" showPagerButtonIcon="false"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="30%">车牌号</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="30%">预约状态</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="30%">预约来厂日期</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div class="nui-panel" title="基本信息"  style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
					<div class="nui-fit">
						<table >
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label>车牌号：</label>
								</td>
								<td>
									<input class="nui-buttonedit" id="td" onclick="onCustomer()" />
								</td>
								<td id="label2">
									<label>品牌：</label>
								</td>
								<td>
									<input class="nui-combobox" id="td" />
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label>车型：</label>
								</td>
								<td>
									<input class="nui-textbox" style="width: 646px; " />
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label style="color: #FF0000">联系人：</label>
								</td>
								<td>
									<input class="nui-textbox" id="td" />
								</td>
								<td id="label2">
									<label style="color: #FF0000">联系电话：</label>
								</td>
								<td>
									<input class="nui-textbox" id="td" />
								</td>
								<td id="label2">
									<label>预约项目：</label>
								</td>
								<td>
									<input class="nui-combobox" id="td" />
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label style="color: #FF0000">预约来厂日期：</label>
								</td>
								<td>
									<input id="td"  class="nui-datepicker" viewDate="new Date()"
										   nullValue="null" format="yyyy-MM-dd"  showOkButton="true" showClearButton="false" />
								</td>
								<td id="label2">
									<label>登记日期：</label>
								</td>
								<td>
									<input id="td" class="nui-datepicker" viewDate="new Date()" nullValue="null" allowInput="false "
										   format="yyyy-MM-dd"  showOkButton="true" showClearButton="false" />
								</td>
								<td id="label2">
									<label>预约类型：</label>
								</td>
								<td>
									<input class="nui-combobox" id="td" />
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label>预约单号：</label>
								</td>
								<td>
									<input id="td"  class="nui-datepicker" viewDate="new Date()"
										   nullValue="null" format="yyyy-MM-dd"  showOkButton="true" showClearButton="false" />
								</td>
								<td id="label2">
									<label>登记人：</label>
								</td>
								<td>
									 <input class="nui-textbox" id="td" />
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td id="label1">
									<label>客户描述：</label>
								</td>
							</tr>
							<tr style="display: block;margin: 0">
								<td >
									<input class="nui-textarea" style="width: 990px;height: 100px"/>
								</td>
							</tr>
							<tr style="display: block;margin: 0">	
								<td>
									<label>预约跟踪明细</label>
								</td>
							</tr>
						</table>
						<div class="nui-fit">
							<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
								style="width: 100%; height: 100%;"
								url=""
								pageSize="20" showPageInfo="true" multiSelect="true"
								showPageIndex="false" showPage="true" showPageSize="false"
								showReloadButton="false" showPagerButtonIcon="false"
								totalCount="total" onselectionchanged="selectionChanged"
								allowSortColumn="true" virtualScroll="true"
								virtualColumns="true">
								<div property="columns">
									<div type="indexcolumn"  headerAlign="center" allowSort="true"  width="5%">序号</div>
									<div header="基本信息" headerAlign="center">
										<div property="columns">
											<div id="type" field="type" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪人</div>
											<div id="name" field="name" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪日期</div>
											<div id="captainName" field="captainName"
												headerAlign="center" allowSort="true" visible="true"
												width="13%">跟踪方式</div>
											<div id="isDisabled" field="isDisabled" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪结果</div>
											<div id="isDisabled" field="isDisabled" headerAlign="center"
												allowSort="true" visible="true" width="13%">下次跟踪日期</div>
										</div>
									</div>
									<div header="详细信息" headerAlign="center">
										<div property="columns">
											<div id="type" field="type" headerAlign="center"
												allowSort="true" visible="true" width="33%">跟踪内容</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
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
    	function onMore(){
    		nui.open({
    			url:"./subpage/More.jsp",
    			title:"高级查询",width:380,height:180,
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
    	function reservation(){
    		nui.open({
    			url:"../../common/ReservationTracking.jsp",
    			title:"预约跟踪",width:560,height:500,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"reservation"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	
    	function quote(){
    		nui.open({
    			url:"../../common/subpage/customerSubpage/AddEditCustomer.jsp",
    			title:"客户资料",width:450,height:650,
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