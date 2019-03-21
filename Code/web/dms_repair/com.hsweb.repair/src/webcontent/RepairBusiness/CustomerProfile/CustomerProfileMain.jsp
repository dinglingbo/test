<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 14:09:04
  - Description:
-->
<head>
	<title>客户档案</title>
	<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/CustomerProfile/CustomerProfileMain.js?v=1.5.8"></script>
	<style type="text/css">
		table {
			font-size: 12px;
		}

		.title {
			min-width: 80px;
			text-align: right;
		}
		a#car{
			text-decoration:underline
		}
	</style>
</head>

<body>
	<input class="nui-combobox" id="insureComp" visible="false" />
	<div class="nui-toolbar" style="border-bottom: 0;">
		<div class="nui-form" id="queryForm">
			<table class="table">
				<tr>
					<td>
						<label style="font-family: Verdana;">快速查询：</label>
						<a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">所有客户</a>
						<ul id="popupMenuStatus" class="nui-menu" style="display:none;">
							<li iconCls="" onclick="quickSearch(6)" id="type6">所有客户</li>
							<!-- <li iconCls="" onclick="quickSearch(0)" id="type0">本日所有开单客户</li> -->
							<li iconCls="" onclick="quickSearch(0)" id="type0">本日所有来厂客户</li>
							<li iconCls="" onclick="quickSearch(0)" id="type0">本日所有来厂客户</li>
							<li iconCls="" onclick="quickSearch(1)" id="type1">昨日所有来厂客户</li>
							<li iconCls="" onclick="quickSearch(2)" id="type2">本日新来厂客户</li>
							<li iconCls="" onclick="quickSearch(3)" id="type3">本月新来厂客户</li>
							<li iconCls="" onclick="quickSearch(4)" id="type4">本月所有来厂客户</li>
						</ul>
					</td>
						<td>
							
							<input class="nui-textbox" name="carNo" onenter="onSearch()" emptyText="车牌号" style="width:100px" />						
							<input class="nui-textbox" name="mobile" onenter="onSearch()" emptyText="手机号码" style="width:100px" />
							<input class="nui-textbox" name="carVin" onenter="onSearch()" emptyText="车架号(VIN)" style="width:160px"/>
							<input class="nui-textbox" name="guestFullName" emptyText="客户名称" onenter="onSearch()" style="width:100px" />
							
							<a class="nui-button" iconCls="" plain="true" onclick="onSearch()">
								<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
							<a class="nui-button" plain="true" onclick="advancedSearch()">
								<span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> 
						</td>
						<td>
							<a class="nui-button" iconCls="" onclick="add()" plain="true">
								<span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
							<a class="nui-button" iconCls="" id="updateBtn" onclick="edit()" plain="true">
								<span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
							<a class="nui-button" iconCls="icon-date" id="mergeBtn" onclick="amalgamate()" plain="true">资料合并</a>
							<a class="nui-button" iconCls="icon-date" onclick="split()" id="splitBtn" plain="true">资料拆分</a>
							<!-- 					<a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;客户导入</a>
					<a class="nui-button" plain="true" iconCls="" onclick="importTimesCard()" id="importTimesCardBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;客户计次卡导入</a>
					<a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"  ><span class="fa fa-level-down fa-lg"></span>&nbsp;客户储值卡导入</a>
                    <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                    	<li iconCls="" onclick="importCardByMobile()" id="importCardByMobile">电话号码导入</li>
                    	<li iconCls="" onclick="importCardByCarNo()" id="importCardByCarNo">车牌号导入</li>
                    </ul> -->
							<a class="nui-button" iconCls="" id="carChangeBtn" onclick="carChange()" plain="true">
								<span class="fa fa-edit fa-lg"></span>&nbsp;车辆变更</a>
						</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-fit">
		<div id="datagrid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" allowcellwrap="true"
		 onselectionchanged="selectionChanged"   totalCount="page.count" onrowdblclick="edit()"
		>
			<div property="columns">
				<div width="30" type="indexcolumn">序号</div>
				<div header="车辆信息" headerAlign="center">
					<div property="columns">
						<div field="carNo" headerAlign="center"   visible="true" width="80">车牌号</div>
						<div field="carModel" headerAlign="center"  width="180px">品牌车型</div>
						<div field="vin" headerAlign="center"   visible="true" width="160px">车架号（VIN）</div>
						<div field="annualInspectionDate"  headerAlign="center" dateFormat="yyyy-MM-dd"  visible="true"
						 width="80px">商业险到期</div>
						<div field="insureDueDate"  headerAlign="center" dateFormat="yyyy-MM-dd"  visible="true"
						 width="80px">交强险到期</div>
					</div>
				</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div name="guestFullName"  field="guestFullName" headerAlign="center"  visible="true" width="80px">客户名称</div>
<!-- 						<div name="mobile" field="mobile"  headerAlign="center"  visible="true" width="100px">客户电话</div> -->
						<div name="addr" field="addr"  headerAlign="center"  visible="true" width="200px">地址</div>
						<div name="lastComeDate" field="lastComeDate"  dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="100px">最后来厂日期</div>
						<div name="lastLeaveDate" field="lastLeaveDate"  dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="100px">最后离厂日期</div>
						<div name="mtAdvisorName" field="mtAdvisorName" headerAlign="center"   visible="true" width="70px">服务顾问</div>
						<div name="recorder" field="recorder" headerAlign="center"   visible="true" width="70px">建档人</div>
						<div name="recordDate" field="recordDate" dateFormat="yyyy-MM-dd"  headerAlign="center"  visible="true"
						 width="100">建档日期
						</div>
						<div field="chainComeTimes" headerAlign="center"   visible="true" width="70px">来厂次数</div>
						<div name="leaveDay" field="leaveDay" headerAlign="center"   visible="true" width="70px">离厂天数</div>
					</div>
				</div>
				<div header="其他信息" headerAlign="center">
					<div property="columns">
						<div name="engineNo" field="engineNo" headerAlign="center"   visible="true" width="120px">发动机号</div>
						<div name="produceDate" field="produceDate"  dateFormat="yyyy-MM-dd" headerAlign="center" 
						 visible="true" width="80px">生产年份</div>
						<!-- <div name="color" field="color" headerAlign="center"   visible="true" width="50px">颜色</div> -->
					</div>
				</div>

			</div>
		</div>
	</div>


	<div id="advancedSearchWin" class="nui-window" title="高级查询" style="width: 430px; height: 460px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
				
					<td class="title">
						<label>最后来厂 从:</label>
					</td>
					<td>
						<input name="lastEnterStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="lastEnterEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>第一次来厂 从:</label>
					</td>
					<td>
						<input name="firstEnterStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="firstEnterEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>最后离厂 从:</label>
					</td>
					<td>
						<input name="lastOutStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="lastOutEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>建档日期 从:</label>
					</td>
					<td>
						<input name="recordStart" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="recordEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>交强险到期:</label>
					</td>
					<td colspan="">
						<input name="insureDueDateStar" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="insureDueDateEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>商业险到期:</label>
					</td>
					<td colspan="">
						<input name="annualVerificationDueDateStar" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="annualVerificationDueDateEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>年审到期:</label>
					</td>
					<td colspan="">
						<input name="annualVerificationDueDateStar" width="100%" class="nui-datepicker" />
					</td>
					<td class="">
						<label>至:</label>
					</td>
					<td>
						<input name="annualVerificationDueDateEnd" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>消费金额在:</label>
					</td>
					<td>
						<input class="nui-textbox" name="chainConsumeAmtStar" id="startAmt" style="width: 100%;" vtype="int" value=""/>
					</td>
					<td class="">
						<label>到:</label>
					</td>
					<td>
						 <input class="nui-textbox" name="chainConsumeAmtEnd" id="endAmt" style="width: 100%;" vtype="int" value=""/>
					</td>
				</tr>
				
				<tr>
					<td class="title">
						<label>消费次数在:</label>
					</td>
					<td>
						<input class="nui-textbox" name="chainComeTimesStar" id="startAmt" style="width: 100%;" vtype="int" value=""/>
					</td>
					<td class="">
						<label>到:</label>
					</td>
					<td>
						 <input class="nui-textbox" name="chainComeTimesEnd" id="endAmt" style="width: 100%;" vtype="int" value=""/>
					</td>
				</tr>
				 <tr>
					<!-- <td class="title">
						<label>客户类型:</label>
					</td>
					 <td colspan="1">
						 <input class="nui-combobox" name="type" id="type" style="width: 100%;"  required="false" multiSelect="false"
                        data="gType" textField="text" valueField="id" allowInput="true" valueFromSelect="true" />
					</td> 
					-->
					<td class="title">
						<label>客户等级:</label>
					</td>
					<td colspan="3">
						 <input class="nui-combobox" name="guestTypeId" id="guestTypeId" style="width: 100%;"  required="false" multiSelect="true"
                        textField="name" valueField="id" allowInput="false" />
					</td>
				</tr> 
				
				<tr>
					<td class="title">
						<label>客户名称:</label>
					</td>
					<td colspan="3">
						<input name="guestId" id="guestId1" class="nui-buttonedit" emptyText="请选择客户..." onbuttonclick="selectCustomer('guestId1')"
						 width="100%" allowInput="false" selectOnFocus="true" />
					</td>
				</tr>
				<!-- <tr>
					<td class="title">
						<label>品牌:</label>
					</td>
					<td colspan="1">
						<input class="nui-combobox" name="carBrandId" width="100%" id="carBrandId" valueField="id" onvaluechanged="onCarBrandChange"
						 textField="nameCn" />
					</td>
					<td class="" width="50">
						<label>品牌车型:</label>
					</td>
					<td colspan="1">
						<input class="nui-combobox" name="carModelId" width="100%" id="carModelId" valueField="carModelId" textField="carModel"
						/>
					</td>
				</tr> -->
				<tr>
					<td class="title">
						<label>品牌:</label>
					</td>
					<td colspan="3">
						<input class="nui-combobox" name="carBrandId" width="100%" id="carBrandId" valueField="id" onvaluechanged="onCarBrandChange"
						 textField="nameCn" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>品牌车型:</label>
					</td>
					<td colspan="3">
						<input class="nui-combobox" name="carModelId" width="100%" id="carModelId" valueField="carModelId" textField="carModel"
						/>
					</td>
				</tr>
				
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width: 60px;margin-right: 20px;">取消</a>
				<a class="nui-button" onclick="cancelData" style="width: 60px;">清除</a>
			</div>
		</div>
	</div>

</body>

</html>