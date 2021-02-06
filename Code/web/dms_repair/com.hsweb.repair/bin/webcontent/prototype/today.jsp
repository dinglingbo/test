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
			<script src=""></script>
			<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
			<style>
				html {
					overflow-x: hidden;
					overflow-y: auto;
					color: #555;
				}

				span {
					font-size: 13px;
				}

				span.fe {
					font-size: 18px;
					color: #FF4040;
				}

				a {
					cursor: pointer;
					 color:black;
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
					align: left;
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
				p ,
				select{
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

				#detailsBox {
					margin-top: 20px;
					position: absolute;
					display: block;
					width: 330px;
					height: 500px;
					background-color: #FFF;
					top: 0px;
					right: 0px;
					padding-bottom: 20px;	
            		border: 2px solid;
            		border-radius: 25px;
            		border: 1px solid;
            		overflow-y:scroll;
				}

				a.depj {
					display: block;
					width: 14px;
					height: 15px;
					background: url(manage/settlement/images/delete.gif) 0 2px no-repeat;
					float: left;
					margin-right: 8px;
				}
				
				
				select{
				    width: 280px;
				    height: 43px;
				    font-size: 15px;
 				    border:none;
				}
				.guestT{
					margin-left: 20px;
					 font-size: 10px;
					 color: #C0C0C0;
				}
				HR{
					margin-left: 5px;
				}
				input{
					border:none;
					outline:medium;
				}
			.am{
				width: 28px;
				height: 21px;
				font-size: 10px;
				background: #578ccd;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
				display: inline-block
			}
			.m{
				width: 60px;
				height: 23px;
				font-size: 10px;
				background: #D2B48C;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
		.n{
				width: 60px;
				height: 23px;
				font-size: 10px;
				background: #F4A460;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
			</style>
		</head>

		<body>
			<div style="position: relative;">
				<div class="fw">
					<div class="pay_list">
						<h2>
							<span style="font-size: 14;font-weight: bold;    margin-bottom: 10px;">按等级&nbsp;</span>
							<span style="font-size: 14;color:#FF4040">按黄金拨打时间</span>
						</h2>
						<div class="pay_tcbk">
							<div id="benefitdeductionbox">
								<div class="pay_jshj_list">
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
												<td rowspan="4" align="center" width="150px">
													<span class="fe">S级</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<span class="fe">黄金会员</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-phone fa-2x "></span>
														</br>
														<span>云呼叫</span>
													</a>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-envelope-o fa-2x  "></span>
														</br>
														<span>短信触达</span>
													</a>
												</td>
												<td rowspan="4" align="right">
													<a class="btn" href="javascript:showDetails();">
														<span class="fa fa-reorder fa-2x "></span>
													</a>
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
								<div class="pay_jshj_list">
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
												<td rowspan="4" align="center" width="150px">
													<span class="fe">S级</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<span class="fe">黄金会员</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-phone fa-2x    "></span>
														</br>
														<span>云呼叫</span>
													</a>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-envelope-o fa-2x  "></span>
														</br>
														<span>短信触达</span>
													</a>
												</td>
												<td rowspan="4" align="right">
													<a class="btn" href="javascript:showDetails();">
														<span class="fa fa-navicon fa-2x  " ></span>
													</a>
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
								<div class="pay_jshj_list">
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
												<td rowspan="4" align="center" width="150px">
													<span class="fe">S级</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<span class="fe">黄金会员</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-phone fa-2x    "></span>
														</br>
														<span>云呼叫</span>
													</a>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-envelope-o fa-2x  "></span>
														</br>
														<span>短信触达</span>
													</a>
												</td>
												<td rowspan="4" align="right">
													<a class="btn" href="javascript:showDetails();">
														<span class="fa fa-navicon fa-2x  "></span>
													</a>
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
								<div class="pay_jshj_list">
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
												<td rowspan="4" align="center" width="150px">
													<span class="fe">S级</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<span class="fe">黄金会员</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-phone fa-2x    "></span>
														</br>
														<span>云呼叫</span>
													</a>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn" >
														<span class="fa fa-envelope-o fa-2x  "></span>
														</br>
														<span>短信触达</span>
													</a>
												</td>
												<td rowspan="4" align="right">
													<a class="btn" href="javascript:showDetails();">
														<span class="fa fa-navicon fa-2x  "></span>
													</a>
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

								<div class="pay_jshj_list">
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
												<td rowspan="4" align="center" width="150px">
													<span class="fe">S级</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<span class="fe">黄金会员</span>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn">
														<span class="fa fa-phone fa-2x    "></span>
														</br>
														<span>云呼叫</span>
													</a>
												</td>
												<td rowspan="4" align="center" width="150px">
													<a class="btn" >
														<span class="fa fa-envelope-o fa-2x  "></span>
														</br>
														<span>短信触达</span>
													</a>
												</td>
												<td rowspan="4" align="right">
													<a class="btn" href="javascript:showDetails();">
														<span class="fa fa-navicon fa-2x  "></span>
													</a>
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

					<div  id="detailsBox">
						<table>
							<tr>
								<td colspan="4">
									<a class="btn" style="margin-left: 15px;;" href="javascript:hideDetails();">
										<span class="fa fa-angle-right fa-2x "></span>
									</a>
								</td>
							</tr>
							<tr>
								<td width="30px">
									<a class="btn" style="margin-left: 15px;">
										<span class="fa fa-user-o fa-1x "></span>
									</a>
								</td>
								<td width="150px">
									客户资料 
				                    
								</td>
								<td align="right">
									<a class="btn" href="javascript:showGuestBox();" id="down">
										<span class="fa fa-angle-down fa-2x "></span>
									</a>
									<a class="btn" href="javascript:hideGuestBox();" id="up">
										<span class="fa fa-angle-up fa-2x "></span>
									</a>
								</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="4">
									<HR width="300px" SIZE=1>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div  id="guestBox">
										<table class="guestT">
											<tr>
												<td width="130px">
													最后来厂日期
												</td>
												<td width="130px">
													<input name="" id="" value="2018.08.09">
												</td>
											</tr>
											<tr>
												<td width="150px">
													车牌
												</td>
												<td>
													<input name="" id="" value="粤ANG215">
												</td>
											</tr>
											<tr>
												<td width="150px">
													车主
												</td>
												<td>
													<input name="" id="" value="张嘉泽">
												</td>
											</tr>
																						<tr>
												<td width="150px">
													性别
												</td>
												<td>
													<input name="" id="" value="先生">
												</td>
											</tr>
											<tr>
												<td width="150px">
													电话
												</td>
												<td>
													<input name="" id="" value="13260632181">
												</td>
											</tr>
											<tr>
												<td width="150px">
													联系人
												</td>
												<td>
													<input name="" id="" value="null">
												</td>
											</tr>
											<tr>
												<td width="150px">
													车架号
												</td>
												<td>
													<input name="" id="" value="D78JHV256JI411284">
												</td>
											</tr>
											<tr>
												<td width="150px">
													品牌车型
												</td>
												<td>
													<input name="" id="" value="宝马523i">
												</td>
											</tr>
											<tr>
												<td width="150px">
													离场里程
												</td>
												<td>
													<input name="" id="" value="52644KM">
												</td>
											</tr>
											<tr>
												<td width="150px">
													客户来源
												</td>
												<td>
													<input name="" id="" value="派卡">
												</td>
											</tr>
											<tr>
												<td width="150px">
													大客户
												</td>
												<td>
													<input name="" id="" value="null">
												</td>
											</tr>
																						<tr>
												<td width="150px">
													承保公司
												</td>
												<td>
													<input name="" id="" value="平安保险">
												</td>
											</tr>
											<tr>
												<td width="150px">
													会员类型
												</td>
												<td>
													<input name="" id="" value="钻石会员">
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<img src="<%=webPath + contextPath%>/repair/prototype/images/ditu.png" width="250px" height="100px"/>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							
							<tr>
								<td width="30px">
									<a class="btn" style="margin-left: 15px;;">
										<span class="fa fa-automobile fa-1x "></span>
									</a>
								</td>
								<td width="150px">
									维修档案				                    
								</td>
								<td align="right">
									<a class="btn" href="javascript:showCarBox();" id="cardown">
										<span class="fa fa-angle-down fa-2x "></span>
									</a>
									<a class="btn" href="javascript:hideCarBox();" id="carup">
										<span class="fa fa-angle-up fa-2x "></span>
									</a>
								</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="4">
									<HR width="300px" SIZE=1>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div  id="carBox">
										<table class="guestT">
											<tr>
												<td colspan="2">
													<img src="<%=webPath + contextPath%>/repair/prototype/images/ditu.jpg" width="250px" height="100px"/>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>

							<tr>
								<td width="30px">
									<a class="btn" style="margin-left: 15px;;">
										<span class="fa fa-assistive-listening-systems fa-1x "></span>
									</a>
								</td>
								<td width="150px">
									360全点触控				                    
								</td>
								<td align="right">
									<a class="btn" href="javascript:showPointBox();" id="pointdown">
										<span class="fa fa-angle-down fa-2x "></span>
									</a>
									<a class="btn" href="javascript:hidePointBox();" id="pointup">
										<span class="fa fa-angle-up fa-2x "></span>
									</a>
								</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="4">
									<HR width="300px" SIZE=1>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div  id="pointBox">
										<table>
											<tr>
												<td>
													<a id="one"  class="m" onclick="settleOK(1)">第一次</a>
												</td>
												<td>
													<a id="two" class="m"  onclick="settleOK(2)">第二次</a>
												</td>
												<td>
													<a id="three"  class="m" onclick="settleOK(3)">第三次</a>
												</td>
												<td>
													<a id="go" class="m"  onclick="settleOK(4)">即将</a>
												</td>
											</tr>
											<tr>
												<td colspan="4">
													<img src="<%=webPath + contextPath%>/repair/prototype/images/chudian.jpg" width="280px" height="200px"/>
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							
							<tr>
								<td width="30px">
									<a class="btn" style="margin-left: 15px;;">
										<span class="fa fa-eye fa-1x "></span>
									</a>
								</td>
								<td width="150px">
									机会预测<a id="" class="am" >AI</a>		                    
								</td>
								<td align="right">
									<a class="btn" href="javascript:showForecastBox();" id="forecastdown">
										<span class="fa fa-angle-down fa-2x "></span>
									</a>
									<a class="btn" href="javascript:hideForecastBox();" id="forecastup">
										<span class="fa fa-angle-up fa-2x "></span>
									</a>
								</td>
								<td></td>
							</tr>
							<tr>
								<td colspan="4">
									<HR width="300px" SIZE=1>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div  id="forecastBox">
										<table>
											<tr>
												<td colspan="4" >
													<span>预测客户：<span id="" style="font-size: 14;color:#FF4040" >张嘉泽</span>  可能需要的服务</span>
												</td>
											</tr>
											<tr>
												<td colspan="4">
													<span style="font-size: 14;color:#FF4040">里程推荐</span>
												</td>
											</tr>
											<tr>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/1.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/2.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/3.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/4.jpg" width="70px" height="80px"/></a>
												</td>
											</tr>
											<tr>
												<td colspan="4">
													<span style="font-size: 14;color:#FF4040">配件更换周期</span>
												</td>
											</tr>
											<tr>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/5.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/6.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/7.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/8.jpg" width="70px" height="80px"/></a>
												</td>
											</tr>
											<tr>
												<td colspan="4">
													<span style="font-size: 14;color:#FF4040">优惠券</span>
												</td>
											</tr>
											<tr>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/1.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/2.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/3.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													
												</td>
											</tr>
											
											<tr>
												<td colspan="4">
													<span style="font-size: 14;color:#FF4040">卡包到期</span>
												</td>
											</tr>
											<tr>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/1.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													<a><img src="<%=webPath + contextPath%>/repair/prototype/images/2.jpg" width="70px" height="80px"/></a>
												</td>
												<td>
													
												</td>
												<td>
													
												</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</div>




				</div>
			</div>
			<script type="text/javascript">
				var color = "one";//全点触控 变色
				$(document).ready(function(){
					hideDetails();
					hideGuestBox();
					hideCarBox();
					hidePointBox();
					hideForecastBox();
				});
				
				function settleOK(e){
					if(e==1){
						document.getElementById(color).setAttribute("class", "m");
						color = "one";
						document.getElementById("one").setAttribute("class", "n");
						
					}else if(e==2){
						document.getElementById(color).setAttribute("class", "m");
						color = "two";
						document.getElementById("two").setAttribute("class", "n");
						
					}else if(e==3){
						document.getElementById(color).setAttribute("class", "m");
						color = "three";
						document.getElementById("three").setAttribute("class", "n");
						
					}else if(e==4){
						document.getElementById(color).setAttribute("class", "m");
						color = "go";
						document.getElementById("go").setAttribute("class", "n");
						
					}
				}
				$("#txtemployee").click(function () {
		            if ($(".xzzjy").is(':hidden')) {
		                $(".xzzjy").show();
		            }
		            else {
		                $(".xzzjy").hide();
		            }
		        });
				function showDetails() {

					$("#detailsBox").show();
				}
				function hideDetails() {
					$("#detailsBox").hide();
				}
				function showGuestBox() {
					$("#guestBox").show();
					$("#down").css('display','none'); 
					$("#up").css('display','block');
				}
				function hideGuestBox() {
					$("#guestBox").hide();
					$("#up").css('display','none'); 
					$("#down").css('display','block');
				}
				
				function showCarBox() {
					$("#carBox").show();
					$("#cardown").css('display','none'); 
					$("#carup").css('display','block');
				}
				function hideCarBox() {
					$("#carBox").hide();
					$("#carup").css('display','none'); 
					$("#cardown").css('display','block');
				}
				
				function showPointBox() {
					$("#pointBox").show();
					$("#pointdown").css('display','none'); 
					$("#pointup").css('display','block');
				}
				function hidePointBox() {
					$("#pointBox").hide();
					$("#pointup").css('display','none'); 
					$("#pointdown").css('display','block');
				}
				
				function showForecastBox() {
					$("#forecastBox").show();
					$("#forecastdown").css('display','none'); 
					$("#forecastup").css('display','block');
				}
				function hideForecastBox() {
					$("#forecastBox").hide();
					$("#forecastup").css('display','none'); 
					$("#forecastdown").css('display','block');
				}
			</script>

		</body>

		</html>