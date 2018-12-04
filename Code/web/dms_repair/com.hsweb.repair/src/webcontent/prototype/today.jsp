<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
	<%@include file="/common/sysCommon.jsp"%>
			<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-10 11:22:57
  - Description:
-->

<head>
	<title>今日</title>
	<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/billSettle.js?v=1.5.1"></script>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<style>
		html {
			overflow-x: hidden;
			overflow-y: auto;
			color: #555;
		}

		span{
			font-size:13px;
		}
		span.fe {
			font-size:18px;
			color:#FF4040;
		}
		a {
		     cursor:pointer;
		}
		element.style {
			background-color: #cfddee;
			position: absolute;
			top: 90%;
			width: 100%;
			height: 10%;
			z-index: 900;
		}


		.pay_tcbk {
			border: 1px #dcdcdc solid;
		}

		td {
			align:left;
		}

		td,
		th {
			display: table-cell;
			vertical-align: inherit;
		}

		.line24 dl dd em {
			color: #b4b4b4;
			position: absolute;
			right: 84px;
			font-size: 15px;
			line-height: 34px;
		}

		em,
		strong {
			font-style: normal;
			font-weight: normal;
		}

		.payjsbd {
			height: 31px;
			border: 1px #dcdcdc solid;
			border-radius: 3px;
			text-align: center;
			color: #666;
		}

		body,
		div,
		dl,
		dt,
		dd,
		ul,
		ol,
		li,
		h1,
		h2,
		h3,
		h4,
		h5,
		h6,
		p {
			margin: 0;
			padding: 0;
			font-family: "微软雅黑", "宋体", "黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
			font-size: 14px;
			font-style: normal;
			font-weight: normal;
			font-variant: normal;
			list-style-type: none;
		}

		.pay_top dl dd {
			font-size: 24px;
			font-weight: bold;
			color: #ff3200;
			line-height: 58px;
		}

		.pay_top dl dt {
			font-size: 16px;
			margin: 21px 5px 0 0;
		}

		.fw {
			margin-top: 10px;
			margin-left: 15px;
		}

		.pay_top dl dt,
		.pay_top dl dd {
			float: left;
		}

		.pay_jshj_list {
			padding: 9px 15px;
			height: auto;
			overflow: hidden;
			border-bottom: 1px #dcdcdc solid;
		}






		a.depj {
			display: block;
			width: 14px;
			height: 15px;
			background: url(manage/settlement/images/delete.gif) 0 2px no-repeat;
			float: left;
			margin-right: 8px;
		}









	</style>
</head>

<body>
	<div style="position: relative;">
		<div class="fw">
			<div class="pay_list">
				<h2><span style="font-size: 14;font-weight: bold;    margin-bottom: 10px;">按等级&nbsp;</span><span style="font-size: 14;color:#FF4040">按黄金拨打时间</span></h2>
				<div class="pay_tcbk">
					<div id="benefitdeductionbox">
						<div class="pay_jshj_list">
							<div class="pay_js_right">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="80px">
												<span>客户名称：</span>
											</td>
											<td width="150px">
												<span>李先生</span>
											</td>
											<td width="200px">
												<span>上次联系时间：</span>
												<span>2018.09.11</span>
											</td>
											<td  rowspan="4" align="center" width="150px">
												<span class="fe">S级</span>
											</td>
											<td rowspan="4" align="center" width="150px">
												<span class="fe">黄金会员</span>
											</td>
											<td rowspan="4" align="center" width="150px">
												<a class="btn"><span class="fa fa-phone fa-2x    "></span></br><span>云呼叫</span></a>
											</td>
											<td rowspan="4" align="center" width="150px">
												<a class="btn"><span class="fa fa-envelope-o fa-2x  "></span></br><span>短信触达</span></a>
											</td>
											<td rowspan="4" align="right">
												<a class="btn"><span class="fa fa-navicon fa-2x  "></span></a>
											</td>
										</tr>
										<tr>
											<td width="">
												<span>厂牌：</span>
											</td>
											<td width="">
												<span>宝马325i</span>
											</td>
											<td width="">
												<span>联系状态：</span>
												<span>继续联系</span>
											</td>
										</tr>
										<tr>
											<td width="">
												<span>性别：</span>
											</td>
											<td width="">
												<span>男</span>
											</td>
											<td width="">
												<span>我的备注：</span>
												<span>重要</span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>


						<div class="pay_jshj_list">
							<div class="pay_js_right">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="80px">
												<span>客户名称：</span>
											</td>
											<td width="150px">
												<span>李先生</span>
											</td>
											<td width="200px">
												<span>上次联系时间：</span>
												<span>2018.09.11</span>
											</td>
											<td  rowspan="4" align="center" width="150px">
												<span class="fe">S级</span>
											</td>
											<td rowspan="4" align="center" width="150px">
												<span class="fe">黄金会员</span>
											</td>
											<td rowspan="4" align="center" width="150px">
												<a class="btn"><span class="fa fa-phone fa-2x    "></span></br><span>云呼叫</span></a>
											</td>
											<td rowspan="4" align="center" width="150px">
												<a class="btn"><span class="fa fa-envelope-o fa-2x  "></span></br><span>短信触达</span></a>
											</td>
											<td rowspan="4" align="right">
												<a class="btn"><span class="fa fa-navicon fa-2x  "></span></a>
											</td>
										</tr>
										<tr>
											<td width="">
												<span>厂牌：</span>
											</td>
											<td width="">
												<span>宝马325i</span>
											</td>
											<td width="">
												<span>联系状态：</span>
												<span>继续联系</span>
											</td>
										</tr>
										<tr>
											<td width="">
												<span>性别：</span>
											</td>
											<td width="">
												<span>男</span>
											</td>
											<td width="">
												<span>我的备注：</span>
												<span>重要</span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>


					

							

				</div>
			</div>

	<script type="text/javascript">

	</script>

</body>

</html>