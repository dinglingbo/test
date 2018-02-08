<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 16:02:39
  - Description:
-->
<head>
<title>维修历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#text1{
    		width:135px
    	}
    	#text2{
    		width:135px
    	}
    	#text3{
    		width:135px
    	}
    	#text4{
    		width:135px
    	}
    	#combobox1{
    		width:130px
    	}
    	#combobox2{
    		width:130px
    	}
    	#combobox3{
    		width:130px
    	}
    </style>
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div  class="nui-splitter" style="width:100%;height:95%;" vertical="true" allowResize="false">
	    <div size="21%" showCollapseButton="false">
	    	<div  class="nui-panel" showToolbar="false" title="客户基本信息" showFooter="false" style="width:100%;height:100%">
				<div class="nui-fit" style="margin:0;height:100%;width:100%;overflow:hidden">
					<table>
						<tr style="display: block; margin:-1px 0 0 0">
							<td width="60px">
								<label>客户名称：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text1"/>
							</td>
							<td width="60px">
								<label>联系人：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text2"/>
							</td>
							<td width="60px">
								<label>联系电话：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text3"/>
							</td>
							<td width="60px">
								<label>身份：</label>
							</td>
							<td>
								<input class="nui-combobox"  allowInput="false" id="text4"/>
							</td>
						</tr>
						<tr style="display: block; margin:-1px 0 0 0">
							<td width="60px">
								<label>车牌号：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text1"/>
							</td>
							<td width="60px">
								<label>品牌：</label>
							</td>
							<td>
								<input class="nui-combobox" allowInput="false" id="text2"/>
							</td>
							<td width="60px">
								<label>车型：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text3"/>
							</td>
							<td width="60px">
								<label>底盘号：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text4"/>
							</td>
						</tr>
						<tr style="display: block; margin:-1px 0 0 0">
							<td width="60px">
								<label>发动机号：</label>
							</td>
							<td>
								<input class="nui-textbox" id="text1"/>
							</td>
							<td width="60px">
								<label>来厂次数：</label>
							</td>
							<td>
								<input class="nui-combobox" allowInput="false" id="text2"/>
							</td>
							<td width="60px">
								<label>客户备注：</label>
							</td>
							<td>
								<input class="nui-textbox" width="339px"/>
							</td>
						</tr>
					</table>
				</div>
	    	</div>
	        
		</div>
	    <div showCollapseButton="false">
	    	<div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
			    <div size="23%" showCollapseButton="false">
			        <div class="nui-fit">
	    				<div  class="nui-datagrid" dataField="data" url="" style="width:100%;height:100%;"
	    					  pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="false" showPage="false"  
					          showReloadButton="false" showPagerButtonIcon="false"  totalCount="total" showPageSize="false"
					          onselectionchanged="selectionChanged" allowSortColumn="true"
	    				>
						    <div property="columns">
						        <div field=""  headerAlign="center" allowSort="true" width="50px">分店名称</div>
						        <div field=""  headerAlign="center" allowSort="true" width="100px">维修工单号</div>
						    </div>
						</div>
	    			</div>
	        	</div>
			    <div showCollapseButton="false">
			    	<div class="nui-fit" style="margin:0;height:100%;width:100%;overflow:hidden">
				        <div  class="nui-panel" showToolbar="false" title="客户基本信息" showFooter="false" style="width:100%;height:100px">
							<table style="margin:0;height:100%;width:100%;">
								<tr style="display: block; margin:0">
									<td width="60px">
										<label>业务类型：</label>
									</td>
									<td>
										<input class="nui-combobox" allowInput="false" id="combobox1"/>
									</td>
									<td width="60px">
										<label>维修类型：</label>
									</td>
									<td>
										<input class="nui-combobox" allowInput="false" id="combobox2"/>
									</td>
									<td width="60px">
										<label>维修顾问：</label>
									</td>
									<td>
										<input class="nui-combobox" allowInput="false" id="combobox3"/>
									</td>
								</tr>
								<tr style="display: block; margin-top:2px">
									<td width="60px">
										<label>里程数：</label>
									</td>
									<td>
										<input class="nui-spinner" allowInput="false" changeOnMousewheel="false" showbutton="false" id="combobox1"/>
									</td>
									<td width="60px">
										<label>进程日期：</label>
									</td>
									<td>
										<input class="nui-datepicker" viewDate="new Date()" format="yy-MM-dd HH:mm:ss" allowInput="false" id="combobox2" showTime="true"/>
									</td>
									<td width="60px">
										<label>离厂日期：</label>
									</td>
									<td>
										<input class="nui-datepicker" viewDate="new Date()" format="yy-MM-dd HH:mm:ss" allowInput="false" id="combobox3" showTime="true"/>
									</td>
								</tr>
							</table>
						</div>
						<div  class="nui-tabs" style="width:100%;height:77%;margin-top:5px" activeIndex="0" plain="false" >
							<div title="估算项目/材料" url="./subpage/EstimateItem.jsp"></div>
							<div title="维修项目/材料" url="./subpage/RepairItem.jsp"></div>
							<div title="出单项目/材料 " url="./subpage/OutItem.jsp"></div>
							<div title="辅料清单 " url="./subpage/PartList.jsp"></div>
							<div title="出车报告 " url="./subpage/OutCar.jsp"></div>
							<div title="描述信息 " url="./subpage/Description.jsp"></div>
						</div>
					</div>
			    </div>
			</div>
		 </div>
	</div>
	<div class="nui-toolbar">
		<div style="text-align:right;padding:0 10px 0 0;margin-top:0">
			<a class="nui-button" onclick="onCancel" plain="true" style="font-size: 14px">取消（C）</a>       
		</div>               
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>