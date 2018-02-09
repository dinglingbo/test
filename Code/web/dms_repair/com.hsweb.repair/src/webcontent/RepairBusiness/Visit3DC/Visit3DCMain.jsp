<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:49:45
  - Description:
-->
<head>
<title>3DC回访</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<style type="text/css">
		td.mini-radiobuttonlist-td {
			padding-left:20px;
			width: 60px;
		}
	</style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
        <div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
        	<table class="table" id="table1" style="height:100% ">
        		<tr style="display: block; margin:-5px 0">
					<td>
						<span style="color:#0000FF;">离厂3天内，对客户进行电话回访关怀。</span>
					</td>
				</tr>
        		<tr>
        	   		<td>
        	    		<label style="font-family:Verdana;">快速查询：</label>
        	    	
        	         	<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>我接待的车辆</u></a>
                	 	<a class="nui-button" plain="true" onclick="onSearch(1)" style="color:#0000FF"><u>所有维修车辆</u></a>
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
					<a class="nui-button" plain="true" iconCls="icon-undo" onclick="undo()">3DC回访（H）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="sendSMS()">发送短信（F）</a> 
					<a class="nui-button" plain="true" iconCls="icon-node" onclick="history()">维修历史（W）</a> 
					<a class="nui-button" plain="true" iconCls="icon-node" onclick="visit()">回访历史（L）</a> 
					<a class="nui-button" plain="true" iconCls="icon-user" onclick="complaint()">投诉登记（T）</a>
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
							<div type="indexcolumn"  headerAlign="center" allowSort="true"  width="30px">序号</div>
							<div header="双击填写回访内容" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">车牌号</div>
									<div id="name" field="name" headerAlign="center"
										allowSort="true" visible="true" width="50px">维修顾问</div>
									<div id="captainName" field="captainName" headerAlign="center"
										allowSort="true" visible="true" width="70px">工单号</div>
									<div id="captainName" field="captainName" headerAlign="center"
										allowSort="true" visible="true" width="50px">离厂天数</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 47%;" plain="false"
					onactivechanged="">
					<div title="基本信息" url="./subpage/BasicMessage.jsp"></div>
					<div title="套餐信息 " url="./subpage/PackageMessage.jsp"></div>
					<div title="维修项目信息 " url="./subpage/RepairItem.jsp"></div>
					<div title="维修材料信息 " url="./subpage/RepairMaterial.jsp"></div>
					<div title="估算项目信息" url="./subpage/EstimateItem.jsp"></div>
					<div title="估算材料信息" url="./subpage/EstimateMaterial.jsp"></div>
					<div title="出单信息" url="./subpage/OutItem.jsp"></div>
					<div title="出车报告 " url="./subpage/OutCar.jsp"></div>
					<div title="描述信息 " url="./subpage/Description.jsp"></div>
				</div>
				<div class="nui-panel" showToolbar="false" title="请填写回访内容"
					showFooter="true" style="width: 100%; height: 100%">
					<div class="nui-fit">
						<table>
							<tr>
								<td>
									<div style="padding: 0 10px">
										<div class="nui-panel" showToolbar="false" title="质量满意度评分"
											showFooter="false" style="width: 220px; height: 70px">
											<div class="nui-radiobuttonlist" valueField="id"
												repeatItems="2" repeatLayout="table"
												repeatDirection="vertical" textField="text"
												data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
											</div>
										</div>
									</div>
								</td>
								<td>
									<div style="padding: 0 10px">
										<div class="nui-panel" showToolbar="false" title="服务满意度评分"
											showFooter="false" style="width: 220px; height: 70px">
											<div class="nui-radiobuttonlist" valueField="id"
												repeatItems="2" repeatLayout="table"
												repeatDirection="vertical" textField="text"
												data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
											</div>
										</div>
									</div>
								</td>
								<td>
									<div style="padding: 0 10px">
										<div class="nui-panel" showToolbar="false" title="时间满意度评分"
											showFooter="false" style="width: 220px; height: 70px">
											<div class="nui-radiobuttonlist" valueField="id"
												repeatItems="2" repeatLayout="table"
												repeatDirection="vertical" textField="text"
												data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
											</div>
										</div>
									</div>
								</td>
								<td>
									<div style="padding: 0 10px">
										<div class="nui-panel" showToolbar="false" title="价格满意度评分" id="radiobuttonlist"
											showFooter="false" style="width: 220px; height: 70px">
											<div class="nui-radiobuttonlist" valueField="id"
												repeatItems="2" repeatLayout="table"
												repeatDirection="vertical" textField="text"
												data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
														{ id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 }]">
													<table>
														<tr>
															<td>
															</td>
														</tr>
													</table>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<table style="width: 100%">
							<tr style="display: block; margin:0">
								<td style="width: 60px">
									<label>回访方式：</label>
								</td>
								<td>
									<input class="nui-combobox" style="width: 150px;" allowInput="false" />
								</td>
								<td style="width: 85px">
									<label>下次保养日期：</label>
								</td>
								<td>
									<input id="data" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
									showOkButton="true" showClearButton="false" viewDate="new Date()"style="width: 150px;" />
								</td>
								<td style="width: 60px">
									<label>保养周期：</label>
								</td>
								<td>
									<input id="spinner" class="nui-spinner" style="width: 150px;" maxValue="100000000"/>
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td style="width: 60px">
									<label>回访内容：</label>
								</td>
								<td>
									<input class="nui-textarea" style="width:900px; height: 140px; "/>
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td style="width: 60px">
									<label>回访员：</label>
								</td>
								<td>
									<input class="nui-textbox" style="width: 150px; " /> 
								</td>
								<td style="width: 85px;text-align: right;">
									<label>回访时间：</label>
								</td>
								<td>
									<input id="data" class="nui-datepicker" nullValue="null" format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
									showOkButton="true" showClearButton="false" viewDate="new Date()"style="width: 150px; " />	
								</td>
								<td>
									<a class="nui-button" iconCls="" onclick="choiceScript()" style="margin: 0 10px 0 0;width:70px">选择话术</a> 
									<a class="nui-button" iconCls="" onclick="collectScript()" style="margin: 0 10px 0 0;width:70px">收藏话术</a>
									<a class="nui-button" iconCls="" onclick="search()" style="width:70px">保存</a>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	function sendSMS(){
    		nui.open({
    			url:"../../common/SendSMS.jsp",
    			title:"发送短信",width:460,height:330,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"split"};
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
    	function visit(){
    		nui.open({
    			url:"../../common/CustomerFollowUp.jsp",
    			title:"客户跟进记录",width:950,height:620,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"visit"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function complaint(){
    		nui.open({
    			url:"../../common/ComplaintRegistration.jsp",
    			title:"投诉登记",width:650,height:450,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"complaint"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function choiceScript(){
    		nui.open({
    			url:"../../common/ModeScript.jsp",
    			title:"话术模板",width:880,height:630,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"choiceScript"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function collectScript(){
    		nui.open({
    			url:"../../common/ScriptIpnut.jsp",
    			title:"话术录入",width:450,height:300,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"collectScript"};
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