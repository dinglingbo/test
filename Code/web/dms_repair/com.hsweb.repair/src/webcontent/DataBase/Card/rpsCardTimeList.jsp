<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
	<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-08 09:53:27
  - Description:
-->
<head>
<title>计次卡查询</title>

<script src="<%=request.getContextPath()%>/repair/js/Card/rpsCardTimesList.js?v=1.2.4"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
	
</head>

<body>
	<div class="nui-splitter" vertical="true"
		style="width: 100%; height: 100%;" allowResize="true">
		<!-- 上 -->
		<div size="70%" showCollapseButton="false">
			<div class="nui-fit">
				<div id="queryform" class="nui-form">	
				<div class="nui-toolbar" style="border-bottom: 0;">
				<div id="queryForm">
				<input class="nui-textbox" id="serviceTypeId"  width="120" visible="false"/>
					<table>
						<tr>
							<td>
							<input name="serviceTypeId" id="serviceTypeId" visible="false" class="nui-combobox" textField="name" valueField="id"/>
								   <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
				       			   <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="search()" />
									办卡日期: <input id="startDate" class="mini-datepicker" required="true" />-至-
									         <input id="endDate" class="mini-datepicker" required="true" /> 
									 <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        			emptyText="兼职公司" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
									<a class="nui-button" onclick="search()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查询</a>
									<a class="nui-button" onclick="searchOne()" plain="true"> <span class="fa fa-search fa-lg"></span>&nbsp; 查看详情</a>	
				   					<a class="nui-button" onclick="dealtWithCard()" plain="true"> <span class="fa fa-address-card-o fa-lg"></span>&nbsp;次卡办理</a>
				<!-- 						<a class="nui-button" onclick="refund()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款</a> -->
                    				<a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 				
								</td>			
							</tr>
						</table>
					</div>
				</div>
				</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="cardData" class="nui-datagrid"
					       onDrawCell="onDrawCell"  		
					        showPager="true"  
					        sortMode="client"  
		                    totalField="page.count"
		                    allowCellSelect="true"
		                    allowCellEdit="true"
		                    showModified="false"
		                    allowCellWrap = "true"
					        allowSortColumn="true" 
					        pageSize="500"
					        sizeList=[500,1000,2000] 
					        style="width: 100%;height:100% "
					        onselectionchanged="selectionChanged"
					        showSummaryRow = "true"
                            sortMode="client"
					       >
					  <div property="columns">
						 <div type="indexcolumn" width="50px">序号</div>
						<div type="checkcolumn" ></div>  
						
						<div field="fullName" name="fullName" headerAlign="center" allowSort="true"
							>客户名称</div>
						<div field="carNo" name="carNo" headerAlign="center" allowSort="true">
							车牌号</div>
						<div field="mobile" name="mobile" headerAlign="center" allowSort="true"  >
							电话</div>		 
						<div field="cardName" name="cardName" headerAlign="center" allowSort="true">
						  计次卡名称</div>
						<div field="periodValidity" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">
							有效期</div>
						<div field="prdtType" headerAlign="center" allowSort="true">
							项目类型
						</div>
						<div field="prdtName" name="prdtName" headerAlign="center" allowSort="true">
							项目名称
						</div>
						<div field="totalTimes" headerAlign="center" allowSort="true" dataType="int">
							总次数
						</div>
						<div field="useTimes" headerAlign="center" allowSort="true" dataType="int">
							已使用次数
						</div>
						<div field="balaTimes" headerAlign="center" allowSort="true" dataType="int">
							剩余次数
						</div>
						<div field="sellAmt" headerAlign="center" allowSort="true" summaryType="sum" dataType="int">
							总金额
						</div>
						<div field="remainAmt" headerAlign="center" allowSort="true" summaryType="sum" dataType="int">
							剩余金额
						</div>
						<div field="settleDate" width="120"dateFormat="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true" >
							办卡日期
						</div>	
						<div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
				</div>
			</div>
			</div>
		</div>
       </div>       
		<!-- 下 -->
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid2" dataField="data" class="nui-datagrid" 
					style="width: 100%; height: 100%;" 
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					<div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="carNo" headerAlign="center" allowSort="false" width="70px">车牌号</div>
						<div field="carModel" headerAlign="center" allowSort="false" width="220px" visible="false">品牌车型</div>
						<div field="carVin" headerAlign="center" allowSort="false" width="120px">车架号(VIN)</div>
						<div field="serviceTypeId" name = "serviceTypeId" headerAlign="center" allowSort="true" width="60px">业务类型</div>
						<div field="mtAdvisor" headerAlign="center" allowSort="false" width="60px">服务顾问</div>
						<div field="serviceCode" headerAlign="center" allowSort="false" width="120px">工单号</div>
						<div field="qty" headerAlign="center" allowSort="false" width="120px">工时/数量</div>
						<div field="subtotal" headerAlign="center" allowSort="false" width="120px">金额</div>
						<div field="outDate" name="outDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="出厂日期" allowsort="true"></div>
		                <div field="collectMoneyDate" name="collectMoneyDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="收款日期" allowsort="true"></div>
					</div>
				</div>
			</div>
		</div>
</div>

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
               
        	<td colspan="1" align="center">客户名称</td>
            <td colspan="1" align="center">车牌号</td>
            <td colspan="1" align="center">电话</td>
            <td colspan="1" align="center">计次卡名称</td>
             <td colspan="1" align="center">有效期</td>            
            <td colspan="1" align="center">项目类型</td>
            <td colspan="1" align="center">项目名称</td>
            <td colspan="1" align="center">总次数</td>                                 
            <td colspan="1" align="center">已使用次数</td>
            <td colspan="1" align="center">剩余次数</td>
            <td colspan="1" align="center">总金额</td>  
            <td colspan="1" align="center">剩余金额</td>  
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>
</body>
</html>
