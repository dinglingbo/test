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
				<title>违章查询</title>
				<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/CustomerProfile/violation.js?v=1.0.4"></script>
				<style>
						.title {
							min-width: 130px;
							text-align: right;
						}
					input {
						border: none;
						outline: none;
					}

					.clearfix:after {
						content: "";
						height: 0;
						line-height: 0;
						display: block;
						clear: both;
					}

					.clearfix {
						zoom: 1;
					}


					.header {
						width: 100%;
						height: 60px;
						position: relative;
						line-height: 40px;
						border: 1px solid #fff;
						border-radius: 4px;
						text-align: center;
					}

					.header .intCity {
						width: 400px;
						height: 40px;
						line-height: 40px;
						font-size: 16px;
						text-indent: 10px;
						margin-top: 10px;
					}

					.header .seachBtn {
						width: 100px;
						height: 40px;
						line-height: 40px;
						font-size: 16px;
						color: #fff;
						text-align: center;
						background: #00BFFF;
						font-weight: 600;
						cursor: pointer;
						margin-top: 10px;
					}

					input {
						outline: none;
						border: none;
						height: 30px;
					}
				</style>
			</head>

			<body>
				<div class="nui-form" id="queryForm">
					<div class="nui-toolbar" style="border-bottom: 0;">

						<div class="header">
							<input id="carNo" name="carNo" class="intCity" type="text" placeholder="请输入车牌号" />
							<input class="seachBtn" type="button" value="查询违章" onclick="javascript:getViolation()" />
						</div>
					</div>
				</div>
				<div id="billForm" class="form">
					<table style="width: 100%;border-spacing: 0px 5px;">
						<tr>
							<td class="title">
								<label>驾照办理时登记的手机:</label>
							</td>
							<td class="">
								<input class="nui-textbox" name="driverLicenseMobile" id="driverLicenseMobile" enabled="false" width="100%" />
							</td>
							<td class="title required">
								<label>驾驶证档案编号:</label>
							</td>
							<td style="width:15%">
								<input class="nui-textbox" name="drivinglicenceno" id="drivinglicenceno" enabled="false" width="100%" />
							</td>
							<td class="title">
								<label>该车辆是否绑定了驾照：</label>
							</td>
							<td class="" colspan="1">
								<div id="isBoundDriverLicense" name="isBoundDriverLicense" 
			                        class="nui-radiobuttonlist" value="" repeatItems="2" 
			                        repeatDirection="" repeatLayout="table" 
			                        textField="text" valueField="id" ></div>
							</td>
							</tr>
							<tr>
							<td class="title">
								<label>驾驶证号：</label>
							</td>
							<td class="" colspan="1">
								<input class="nui-textbox" name="idCard" id="idCard" enabled="false" width="100%" />
							</td>
							<td class="title required">
								<label>驾照名称：</label>
							</td>
							<td>
								<input class="nui-textbox" name="name" id="name" enabled="false" width="100%" />
							</td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="datagrid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" pageSize="20" allowcellwrap="true"
					 onselectionchanged="selectionChanged" totalCount="page.count" onrowdblclick="edit()">
						<div property="columns">
							<div width="40px" type="indexcolumn">序号</div>
<!-- 								<div field=" CanProcessUsOrder" headerAlign="center" visible="true" width="160px"></div>
								<div field="Code" headerAlign="center" visible="true" width="60px">违章代码</div>
								<div name="guestFullName" field="guestFullName" headerAlign="center" visible="true" width="80px">客户名称</div>
								<div name="DD_NeedMakeDataEnum" field="DD_NeedMakeDataEnum" headerAlign="center" visible="true" width="80px">普通下单需要资料</div>
								<div name="FSBL" field="FSBL" headerAlign="center" visible="true" width="80px">快速办理</div>
								<div name="FSBLJE" field="FSBLJE" headerAlign="center" visible="true" width="80px">快速办理金额</div>
								<div name=" NeedMakeDataEnum" field="NeedMakeDataEnum" headerAlign="center" visible="true" width="80px"></div>
								
								<div name="NeedMakeUpData" field="NeedMakeUpData" headerAlign="center" visible="true" width="80px"></div>
								<div name="NeedMakeUpFirstMemo" field="NeedMakeUpFirstMemo" headerAlign="center" visible="true" width="80px"></div>
								<div name="NeedMakeUpPrice" field="NeedMakeUpPrice" headerAlign="center" visible="true" width="80px"></div>
								<div name="NeedMakeUpProxyFare" field="NeedMakeUpProxyFare" headerAlign="center" visible="true" width="80px"></div>
								<div name="UniqueCode" field="UniqueCode" headerAlign="center" visible="true" width="80px"></div>
								<div name="UsPriceFirst" field="UsPriceFirst" headerAlign="center" visible="true" width="80px"></div>
								<div name="latefine" field="latefine" headerAlign="center" visible="true" width="80px"></div>
								<div name="orderId" field="orderId" headerAlign="center" visible="true" width="80px"></div> 
								<div name="batchId" field="batchId" headerAlign="center" visible="true" width="80px">单据类型</div>
								<div name="WFLX" field="WFLX" headerAlign="center" visible="true" width="80px"></div>-->
								<div name="status" field="status" headerAlign="center" visible="true" width="80px">违章状态</div>
								<div field="CarNumber" headerAlign="center" visible="true" width="100px">车牌号</div>
								<div name="Reason" field="Reason" headerAlign="center" visible="true" width="220px">违章原因</div>
								<div field="CanProcess" headerAlign="center" width="80px">是否可代办</div>
								<div name="Degree" field="Degree"  headerAlign="center" visible="true" width="60px">扣分</div>
								<div name="count" field="count" headerAlign="center" visible="true" width="80px">罚款</div>
								<div name="Poundage" field="Poundage" headerAlign="center" visible="true" width="80px">手续费</div>
								<div name="Poundage1" field="Poundage1" headerAlign="center" visible="true" width="120px">非扣分单的首笔代办费</div>
								<div name="Poundage2" field="NeedMakeDataEnum" headerAlign="center" visible="true" width="120px">非扣分单的非首笔代办费</div>
								<div field="Archive" headerAlign="center" visible="true" width="160px">文书编号</div>
								<div name="Time" field="Time" headerAlign="center" visible="true" width="150px">违章时间</div>
								<div name="Location" field="Location" headerAlign="center" visible="true" width="170px">违章地址</div>
								<div name="LocationName" field="LocationName" headerAlign="center" visible="true" width="80px">城市名称</div>								
								<div name="department" field="department" headerAlign="center" visible="true" width="150px">处罚单位</div>
						</div>
					</div>
				</div>
			</body>

			</html>