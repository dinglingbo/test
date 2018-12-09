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
	<title>特别关怀</title>
	<script src="<%=request.getContextPath()%>/manage/js/specialAttention.js?v=1.0.7">
	</script>
</head>

<body style="margin:0;width: 98%; height:100%;overflow-x:hidden">
<!-- 	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
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
	 										<a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn">
						<span class="fa fa-envelope-open fa-lg"></span>&nbsp;标记已读</a> 
				</td>
			</tr>
		</table>
	</div> -->
	<div id="tabs" class="nui-tabs" width="100%" height="100%" onactivechanged="change()">
				<div title="商业险到期提醒">
						<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
								<table style="width:100%;">
									<tr>
										<td style="width:100%;">
 												<a class="nui-button" iconCls="" plain="true" onclick="Care()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;关怀</a> 
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true" pageSize="20" showPageInfo="true"
								 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
								 <div property="columns">
										<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
										<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
										<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
										<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
										<div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
										<div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
										<div field="annualInspectionCompName" headerAlign="center" allowSort="true" width="100px">保险公司</div>
										<div field="annualStatus" headerAlign="center" allowSort="true" width="60px">状态</div>
										<div field="annualInspectionDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
											商业险到期日期</div>
									</div>
								</div>
							</div>
				</div>
	    		<div title="交强险到期提醒">
						<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
							<table style="width:100%;">
								<tr>
									<td style="width:100%;">
 												<a class="nui-button" iconCls="" plain="true" onclick="Care()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;关怀</a> 
									</td>
								</tr>
							</table>
						</div>
						<div class="nui-fit">
							<div id="compulsoryInsurance" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true" pageSize="20" showPageInfo="true"
							 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
							 <div property="columns">
									<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
									<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
									<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
									<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
									<div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
									<div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
									<div field="insureCompName" headerAlign="center" allowSort="true" width="100px">保险公司</div>
									<div field="insureStatus" headerAlign="center" allowSort="true" width="60px">状态</div>
									<div field="insureDueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
										交强险到期日期</div>
								</div>
							</div>
						</div>
					</div>
					<div title="驾照年审提醒">
							<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
									<table style="width:100%;">
										<tr>
											<td style="width:100%;">
 												<a class="nui-button" iconCls="" plain="true" onclick="Care()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;关怀</a> 
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="drivingLicense" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true" pageSize="20" showPageInfo="true"
									 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
									 <div property="columns">
											<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
											<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
											<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
											<div field="orgid" headerAlign="center" allowSort="true" visible="false">orgid</div>
											<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
											<div field="guestName" headerAlign="center" allowSort="true" width="100px">客户姓名</div>
											<div field="mobile" headerAlign="center" allowSort="true" width="60px">电话</div>
											<div field="licenseStatus" headerAlign="center" allowSort="true" width="60px">状态</div>
											<div field="licenseOverDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
												驾照年审日期</div>
										</div>
									</div>
								</div>
					</div>
					<div title="车辆年检提醒">
							<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
								<table style="width:100%;">
									<tr>
										<td style="width:100%;">
 												<a class="nui-button" iconCls="" plain="true" onclick="Care()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;关怀</a> 
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="car" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" multiSelect="true" showPageInfo="true"
								 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
								 <div property="columns">
										<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
										<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
										<div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
										<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
										<div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
										<div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌/车型</div>
										<div field="veriStatus" headerAlign="center" allowSort="true" width="60px">状态</div>
										<div field="annualVerificationDueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
											车辆年检到期日期</div>
									</div>
								</div>
							</div>
						</div>
						
						<div title="客户生日提醒">
								<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
									<table style="width:100%;">
										<tr>
											<td style="width:100%;">
 												<a class="nui-button" iconCls="" plain="true" onclick="Care()" id="saveBtn">
												<span class="fa fa-envelope-open fa-lg"></span>&nbsp;关怀</a> 
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="guestBirthday" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true" pageSize="20" showPageInfo="true"
									 onDrawCell="onDrawCell" onselectionchanged="selectionChanged" allowSortColumn="false">
									 <div property="columns">
											<div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
											<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
											<div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
											<div field="carId" headerAlign="center" allowSort="true" visible="false">orgid</div>
											<div field="guestName" headerAlign="center" allowSort="true" width="100px">客户姓名</div>
											<div field="mobile" headerAlign="center" allowSort="true" width="60px">电话</div>
											<div field="birthdayType" headerAlign="center" allowSort="true" width="100px">生日类型</div>
											<div field="birStatus" headerAlign="center" allowSort="true" width="60px">状态</div>
											<div field="birthday" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">
												生日</div>
										</div>
									</div>
								</div>
							</div>
							
	</div>



</body>

</html>