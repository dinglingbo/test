<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-30 15:16:57
  - Description:
-->

<head>
	<title>预收账款管理</title>
	<script src="<%=webPath + contextPath%>/settlement/js/deduct.js?v=1.0.26"></script>
	    <link href="<%=webPath + contextPath%>/settlement/js/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/settlement/js/HeaderFilter.js" type="text/javascript"></script>
	<style type="text/css">
		

		

		.tmargin1 {
			margin-left: 20px;
		}

		.twidth {
			width: 200px;
		} 
		
		.tmargin {
			margin-top: 10px;
			margin-left: 50px;
			margin-bottom: 5px;
			border-spacing: 10 20;
		}

		.vpanel {
			border: 1px solid #d9dee9;
			margin: 10px 0px 0px 20px;
			height: 248px;
			float: left;
		}

		.vpanel_heading {
			border-bottom: 1px solid #d9dee9;
			width: 100%;
			height: 28px;
			line-height: 28px;
		}

		.vpanel_heading span {
			margin: 0 0 0 20px;
			font-size: 16px;
			font-weight: normal;
		}

		.vpanel_bodyww {
			padding: 10 10 10 10px !important
		}

	</style>
</head>

<body>
	<div class="nui-fit">
		<div id="mainTabs" class="nui-tabs" name="mainTabs"
				 activeIndex="0" 
				 style="width:100%; height: 100%;" plain="false"
				 onactivechanged="">
				<div title="待抵扣"  >
						<div class="nui-fit">
						<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
							<table style="width: 100%;">
								<tr>
									<td style="white-space: nowrap;">
										<a class="nui-button" iconCls="" plain="true" onclick="doDeduct()"><span
											class="fa fa-check fa-lg"></span>&nbsp;确定冲减</a>
				 						<a class="nui-button" iconCls="" plain="true" onclick="onCancel()" id="exportBtn">
											<span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
											
										<span class="separator"></span>
										<label style="font-family:Verdana;">结算日期:</label>
										<input id="rpSettleDate"
							                           name="rpSettleDate"
							                           width="100px"
							                           allowinput="false"
							                           class="nui-datepicker"/>
									</td>
								</tr>
							</table>
						</div>
						
							<div id="rRightGrid" class="nui-datagrid" style="width: 100%; height: 200px;" showPager="true" dataField="detailList" idField="detailId"
							 ondrawcell="onDrawCell" sortMode="client" allowCellSelect="true" allowCellEdit="true" url="" multiSelect="true" showModified="false"
							 pageSize="500" sizeList="[500,1000,2000]"   
							 oncellcommitedit="onCellCommitEdit" showSummaryRow="true">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div type="checkcolumn" field="check" width="20"></div> 
									<div allowSort="true" field="guestName" name="guestName" width="100" headerAlign="center" header="结算单位"></div>
									<div allowSort="true" summaryType="count" field="billServiceId" name="billServiceId" width="180" summaryType="count" headerAlign="center" header="业务单号"></div>
									<div allowSort="true" field="rpAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="应收金额"></div>
									<div allowSort="true" field="charOffAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="已结金额"></div>
									<div allowSort="true" field="nowAmt" visible="true" width="60" headerAlign="center" align="right" numberFormat="0.00" summaryType="sum" dataType="float" header="当前结算">
										<input property="editor" vtype="float" class="nui-textbox" />
									</div>
									<div allowSort="true" field="billTypeId" name="billTypeId" width="100" headerAlign="center" header="收支项目"></div>
									<div allowSort="true" field="remark" name="remark" width="120" headerAlign="center" header="业务备注"></div>
									<div allowSort="true" field="createDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
									
							
								</div>
							</div>
						<div id="settleSearchForm" class="form">
							
					        <div id="settleAccountGrid" class="nui-datagrid" style="width:100%;height:100px;"
				                 showPager="false"
				                 dataField="detailList"
				                 idField="detailId"
				                 ondrawcell="onDrawCell"
				                 sortMode="client"
				                 url=""
				                 allowCellSelect="true"
				                 allowCellEdit="true"
				                 multiSelect="true"
				                 oncellcommitedit="onCellCommitEdit"
				                 oncellbeginedit="OnModelCellBeginEdit"
				                 showSummaryRow="false">
				                <div property="columns">
				                    <div name="action" width="30" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
				                    <div field="settAccountId" type="comboboxcolumn" width="60" headerAlign="center" header="结算账户">
				                        <input  property="editor" enabled="true" name="settleAccount" dataField="settleAccount" class="nui-combobox" valueField="id" textField="name" 
				                                  url="" valueFromSelect="true" allowInput="true"
				                                  onvaluechanged="onAccountValueChanged" emptyText=""  vtype="required"
				                                  /> 
				                    </div>
				                    <div field="balaTypeCode" type="comboboxcolumn" width="60" headerAlign="center" header="结算方式">
				                        <input  property="editor" enabled="true" name="list" dataField="list" class="nui-combobox" valueField="customId" textField="customName" 
				                                  url=""
				                                  onvaluechanged="" emptyText=""  vtype="required"
				                                  /> 
				                    </div>
				                    <div field="charOffAmt" width="60" headerAlign="center" summaryType="sum" header="金额">
				                            <input property="editor" vtype="float" class="nui-textbox"/>
				                    </div>
				                </div>
				            </div>
				            
				            <div class="vpanel_body">
				                <table class="tmargin"> 
				                	<tr>
				                        <td id="settleGuestName" style="text-align:left;" colSpan="4">结算单位：</td>
				                        <td id="settleBillCount" style="text-align:left;" colSpan="4">结算单据数：0</td>
				                    </tr>
				                    <!-- <tr>
				                        <td id="settleBillCount" style="text-align:left;" colSpan="8">结算单据数：0</td>
				                    </tr> -->
				                    <tr id="rcTr">
				                        <td style="text-align:center" width="60px">应结金额:</td>
				                        <td id="rRPAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>
				
										<td style="text-align:center" width="60px">已结金额:</td>
				                        <td id="rCharOffAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>
				                        
										<td style="text-align:center" width="60px">未结金额:</td>
				                        <td id="rNoCharOffAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>
				                        
				                        <td style="text-align:center" width="80px">本次结算金额:</td>
				                        <td id="rTrueAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>
				
				                        <td style="text-align:center;display:none;" width="60px">优惠金额:</td>
				                        <td id="rVoidAmt" style="text-align:center;color:blue;text-decoration:underline;display:none;" width="60px"></td>
				
				                        
				                    </tr>
				                    <tr>
					                    <td style="text-align:center" width="60px">备注:</td>
					                    <td colspan="7" id="rpRemark" style="text-align:left;" width="50px">
					                        <input id="rpTextRemark" width="100%" height="50px" emptyText="" class="nui-textArea"/>
					                    </td>
					                </tr>
				                </table>
				
				            </div>
				            
					    </div>
					    </div>
				</div>
				<div title="抵扣记录"  >
					<div class="nui-fit">
							<div id="deductGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="true" dataField="detailList" idField="detailId"
							 ondrawcell="" sortMode="client" allowCellSelect="true"  showModified="false"
							 pageSize="50" sizeList="[50,100,200]" showSummaryRow="true">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div allowSort="true" summaryType="count" field="billNos" name="billNos" width="180" summaryType="count" headerAlign="center" header="业务单号"></div>
									<div allowSort="true" field="deductAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="抵扣金额"></div>
									<div allowSort="true" field="advanceAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="上次结余"></div>
									<div allowSort="true" field="balaAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="本次结余"></div>
									<div field="recorder" width="60" headerAlign="center" header="操作人" allowSort="true" dataType="string"></div>
									<div allowSort="true" field="recordDate" headerAlign="center" header="操作日期" dateFormat="yyyy-MM-dd HH:mm"></div>
									
							
								</div>
							</div>
					</div>
				</div> 
				<div title="退款记录"  >
					<div class="nui-fit">
							<div id="refundGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="list" idField="detailId"
							 ondrawcell="" sortMode="client" allowCellSelect="true"  url="" 
							 showSummaryRow="true">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div allowSort="true" field="amt" width="60" headerAlign="center" align="right" numberFormat="0.00" dataType="float" summaryType="sum" header="退款金额"></div>
									<div field="recorder" width="60" headerAlign="center" header="操作人" allowSort="true" dataType="string"></div>
									<div allowSort="true" field="recordDate" headerAlign="center" header="操作日期" dateFormat="yyyy-MM-dd HH:mm"></div>
									
							
								</div>
							</div>
					</div>
				</div> 
		</div>
		
		
		
		
	</div>


</body>

</html>	