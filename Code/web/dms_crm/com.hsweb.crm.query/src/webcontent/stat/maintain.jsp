<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
<head>
	<title>首页提醒</title>
	<script src="<%=request.getContextPath()%>/query/stat/js/maintain.js?v=1.1.2">
	</script>
</head>

<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
						<table style="width:100%;">
							<tr>
								<td style="width:100%;">
								        <label style="font-family:Verdana;">快速查询：</label>
					                    <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">未读</a>
					                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
					                        <li iconCls="" onclick="quickSearch(0)" id="type0">所有</li>
					                        <li iconCls="" onclick="quickSearch(1)" id="type0">未读</li>
					                        <li iconCls="" onclick="quickSearch(2)" id="type0">已读</li>
					                    </ul>
<!-- 										<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
										<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
								</td>
							</tr>
						</table>
					</div>
	<div id="tabs" class="nui-tabs" width="100%" height="100%">
			<div title="保养到期提醒">
					
					<div class="nui-fit">
						<div id="maintain" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
						 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
							<div property="columns">
								<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
								<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
								<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
								<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
								<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
								<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
								<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
								<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
									发生日期</div>
							</div>
						</div>
					</div>
				</div>
				<div title="商业险到期提醒">
						<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
								<table style="width:100%;">
									<tr>
										<td style="width:100%;">
<!-- 											<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
								 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
								 <div property="columns">
										<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
										<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
										<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
										<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
										<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
										<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
										<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
										<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
											发生日期</div>
									</div>
								</div>
							</div>
				</div>
	    		<div title="交强险到期提醒">
						<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
							<table style="width:100%;">
								<tr>
									<td style="width:100%;">
<!-- 										<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
											<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
									</td>
								</tr>
							</table>
						</div>
						<div class="nui-fit">
							<div id="compulsoryInsurance" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
							 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
							 <div property="columns">
									<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
									<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
									<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
									<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
									<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
									<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
									<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
									<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
										发生日期</div>
								</div>
							</div>
						</div>
					</div>
					<div title="驾照年审提醒">
							<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
									<table style="width:100%;">
										<tr>
											<td style="width:100%;">
<!-- 												<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
													<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="drivingLicense" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
									 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
									 <div property="columns">
											<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
											<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
											<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
											<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
											<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
											<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
											<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
											<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
												发生日期</div>
										</div>
									</div>
								</div>
					</div>
					<div title="车辆年检提醒">
							<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
								<table style="width:100%;">
									<tr>
										<td style="width:100%;">
	<!-- 										<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="car" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
								 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
								 <div property="columns">
										<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
										<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
										<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
										<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
										<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
										<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
										<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
										<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
											发生日期</div>
									</div>
								</div>
							</div>
						</div>
						<div title="预约到店提醒">
								<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
										<table style="width:100%;">
											<tr>
												<td style="width:100%;">
<!-- 													<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
														<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
												</td>
											</tr>
										</table>
									</div>
									<div class="nui-fit">
										<div id="appointment" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
										 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
										 <div property="columns">
												<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
												<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
												<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
												<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
												<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
												<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
												<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
												<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
													发生日期</div>
											</div>
										</div>
									</div>
						</div>
						<div title="客户生日提醒">
								<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
									<table style="width:100%;">
										<tr>
											<td style="width:100%;">
<!-- 												<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
													<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="guestBirthday" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
									 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
									 <div property="columns">
											<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
											<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
											<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
											<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
											<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
											<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
											<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
											<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
												发生日期</div>
										</div>
									</div>
								</div>
							</div>
							<div title="员工生日提醒">
									<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
											<table style="width:100%;">
												<tr>
													<td style="width:100%;">
<!-- 														<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
															<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> -->
													</td>
												</tr>
											</table>
										</div>
										<div class="nui-fit">
											<div id="employeeBirthday" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
											 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
											 <div property="columns">
													<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
													<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
													<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
													<div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false">mtAdvisorId</div>
													<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
													<div field="msgContent" headerAlign="center" allowSort="true" width="100px">消息内容</div>
													<div field="readSign" headerAlign="center" allowSort="true" width="60px">状态</div>
													<div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
														发生日期</div>
												</div>
											</div>
										</div>
							</div>
	</div>



</body>

</html>