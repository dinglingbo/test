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
	<title>工单结算</title>
	<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/billSettle.js?v=1.5.41"></script>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<style>
		html {
			overflow-x: hidden;
			overflow-y: auto;
			color: #555;
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
			word-break: break-all;
			word-wrap: break-word;
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
			padding: 16px 14px;
			height: auto;
			overflow: hidden;
			border-bottom: 1px #dcdcdc solid;
		}

		.pay_list {
			width: 1000px;
			height: auto;
			overflow: hidden;
			margin: 0 auto;
			margin-top: 30px;
		}

		.pay_js_left a.xz {
			border: 2px #01b49e solid;
			background: #fff url(manage/settlement/images/pay_xztb.png) right 13px no-repeat;
			color: #01b49e;
		}

		.pay_js_right {
			margin-left: 160px;
			height: auto;
			overflow: hidden;
		}

		.pay_js_left {
			width: 160px;
			float: left;
		}

		a.btn {
			background: #28bef0;
			text-decoration: none;
			display: inline-block;
			height: 38px;
			line-height: 38px;
			padding: 0 22px;
			border-radius: 5px;
			color: #fff;
			font-size: 15px;
		}

		.pay_js_left a {
			width: 102px;
			height: 32px;
			border: 2px #dcdcdc solid;
			padding-left: 14px;
			background: #f8f8f8;
			color: #b4b4b4;
			display: block;
			font-size: 15px;
			line-height: 32px;
			text-decoration: none;
			border-radius: 5px;
		}

		.pay_top {
			background: #f9fafb;
			border-bottom: 1px #dde0e6 solid;
			height: 58px;
		}



		.zffs td {
			font-size: 16px;
		}

		a.depj {
			display: block;
			width: 14px;
			height: 15px;
			background: url(manage/settlement/images/delete.gif) 0 2px no-repeat;
			float: left;
			margin-right: 8px;
		}

		select {
			appearance: none;
			-moz-appearance: none;
			-webkit-appearance: none;
			background: #fff url(manage/settlement/images/ssxljt.png) right center no-repeat;
			border: 1px #dcdcdc solid;
			border-radius: 3px;
			height: 30px;
			font-family: "微软雅黑";
			text-indent: 5px;
		}

		.pay_tcbk_list ul li a font {
			background: url(manage/settlement/images/yw_bg2.png) 0 -154px no-repeat;
			line-height: 33px;
			padding-left: 28px;
			width: 125px;
			margin: 0 auto;
			display: block;
		}

		.pay_tcbk_list ul li a {
			width: 180px;
			height: 33px;
			display: block;
			background: #75b7ea;
			border-radius: 3px;
			color: #fff;
			text-decoration: none;
		}

		.jiesuan2 {
			margin-right: 100px;
			height: 80px;
			background: #dce1e5;
			position: relative;
		}

		.zffs {
			padding: 15px 0;
		}
		
		
	  /*优惠券*/
	
     .quan-item {
            width: 30%;
            position: relative;
            margin-bottom: 20px;
            height: auto;
            overflow: hidden;
            border: 1px solid #f1f1f1;
            background: #fff;
            font-family: "Microsoft YaHei";
            float:left;
            margin-left: 20px;
            border:2px solid #fff;
        }
     
         .quan-item1 {
            width: 30%;
            position: relative;
            margin-bottom: 20px;
            height: auto;
            overflow: hidden;
            border: 1px solid #f1f1f1;
            background: #fff;
            font-family: "Microsoft YaHei";
            float:left;
            margin-left: 20px;
            border:2px solid #ff9000; 
           /*  box-shadow: darkgrey 0px 0px 30p */ 
        }

         .q-type {
            float: right;
            width: 70%;
            padding: 5px 0;
        }

        .q-price,
        .typ-txt {
            display: inline-block;
            display: block;
            color: #ff9000;
            font-size: 13px;
        }

        .quan-d-item .q-price {
            color: #ff9000;
            height: auto;
            overflow: hidden;
            padding: 5px 0;
        }

       .q-price em {
            margin: 5px 0 0;
            font-family: verdana;
            font-size: 24px;
            font-style: normal;

        }

        .q-price strong {
            margin: 0 10px 0 5px;
            font-size: 2rem;
            font-family: arial;
            _display: inline;
        }

         .q-price .txt {
            line-height: 22px;
            font-size: 1rem;
        }

        
        .q-range {
            color: #999;
        }

         .q-price {
            display: -webkit-flex;
            display: flex;
            -webkit-align-items: center;
            align-items: center;
            -webkit-justify-content: center;
            justify-content: center;
        }

         .q-price div.titles {
            flex: 1;
        }

        .quan-d-item .q-opbtns {
            background: #ff9000;

        }

         .q-opbtns {
            position: absolute;
            top: 0;
            bottom: 0;
            float: left;
            width: 25%;
            /* -webkit-writing-mode: vertical-lr; */
            line-height: 25px;
            background: #ff9000;
            color: #fff;
            font-size: 1.2rem;
            /* padding: 0 15px; */
           /*  height: 100%; */
            display: -webkit-flex;
            display: flex;
            -webkit-align-items: center;
            align-items: center;
            -webkit-justify-content: center;
            justify-content: center;
            text-align: center;


        }

         .q-opbtns::after {
            box-sizing: border-box;
            position: absolute;
            top: -3px;
            right: -3px;
            bottom: 0;
            content: "• • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • • •";
            line-height: 10px;
            width: 7px;
            color: #fff;
            font-size: 18px;
            overflow: hidden;
            z-index: 1;
        }
		
		 .useText{
		    background: #3087F7;
			text-decoration: none;
			display: inline-block;
      		width:40px;
      		height:25px;
			border-radius: 5px;
		   font-size: 12px;
		   text-align: center;
    	   color: #fff;
		   line-height:24px;
		    margin-left: 45px
	   } 	
	  	
	</style>
</head>

<body>
	<div style="position: relative;">
		<div class="fw">
			<div class="fw_top" style="text-align: center; background: #dcdcdc; font-size: 25px; line-height: 64px;">
				收款结账
			</div>
			<div class="pay_top">
				<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td width="200" height="58">
								车辆：
								
								<span style="padding-top: 2px;"  id="carNo" name="carNo">></span>
							</td>
							<td align="center">
								客户：
								
									<span style="padding-top: 2px;" id="guest" name="guest"></span>
								
								&nbsp;&nbsp;
								<span name="mobile" id="mobile"></span>
							</td>
							<td align="center" style="padding-left: 10px;">
								挂账：
								<span style="color: #ff7800;" id="creditEl">0.00元</span>
							</td>
							<td width="320" valign="top" style="position: relative;">
								<dl>
									<dt>待收金额：</dt>
									<dd totalmoney="0" totalpaid="0" id="totalAmt" name="totalAmt"></dd>
								</dl>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="pay_list">
				<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">收费详情</span></h2>
				<div class="pay_tcbk">
					<div id="benefitdeductionbox">

						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">套餐金额</a>
							</div>
							<div class="pay_js_right">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="15%">
												<span>套餐金额：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="packageSubtotal" name="packageSubtotal" enabled="false" m="1" cardid="" amount="" style="width: 100px; float: left;">
											</td>
											<td width="10%">
												<span>套餐优惠：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="packagePrefAmt" name="packagePrefAmt" enabled="false" width="100px" enabled="false"   showbutton="false"
												 allowNull="false" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">项目金额</a>
							</div>
							<div class="pay_js_right">
								<table id="tbcouponlist" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="15%">
												<span>项目金额：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="itemSubtotal" name="itemSubtotal" enabled="false" m="1" cardid="" amount="" style="width: 100px; float: left;">
											</td>
											<td width="10%">
												<span>项目优惠：</span>

											</td >
											<td height="40" class="line24">
												<input class="nui-textbox" id="itemPrefAmt" name="itemPrefAmt" enabled="false" width="100px"  showbutton="false"
												 allowNull="false"  />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">配件金额</a>
							</div>
							<div class="pay_js_right">
								<table id="tbcommissionlist" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="15%">
												<span>配件金额：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="partSubtotal" name="partSubtotal" enabled="false" m="1" cardid="" amount="" style="width: 100px; float: left;">
											</td>
											<td width="10%">
												<span>配件优惠：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="partPrefAmt" name="partPrefAmt" enabled="false" width="100px"  showbutton="false"
												 allowNull="false"  />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>

					</div>
				</div>
			</div>
			
			<div class="pay_list">
				<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">优惠/抵扣</span></h2>
				<div class="pay_tcbk">
					<div id="benefitdeductionbox">

						<div class="pay_jshj_list" id ="carddk">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">储值卡抵扣</a>
							</div>
							<div class="pay_js_right">
								<table width="100%"  border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="15%">
												<span>储值卡余额：</span>

											</td>
											<td height="40" class="line24">
												<input class="nui-textbox" id="rechargeBalaAmt" name="rechargeBalaAmt" enabled="false" m="1" cardid="" amount="" style="width: 100px; float: left;">
											</td>
											<td width="10%">
												<span>抵扣金额：</span>

											</td>
											<td height="40" class="line24">
												<input class="mini-spinner" id="deductible" name="deductible" width="100px" minValue="0" maxValue="1000000" showbutton="false" changeOnMousewheel="false" showbutton="false"
												 allowNull="false" onvaluechanged="onChanged" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">优惠券抵扣</a>
							</div>
							<div class="pay_js_right">
								<table id="tbcouponlist" width="100%"  border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td height="60">
											  <div  id="inputUserCode" style="display: none;margin-bottom: 10px" >
                                                                             卡券编码： <input class="nui-textbox" name="inputCode"  style="width: 30%;" id="inputCode"  onenter="inputUserQuan"/> 
											  </div> 
                                             <div  id="show">
                                             
                                             </div>
                                             

											</td>
										</tr>
									</tbody>
								</table>
					             <div  id="showCode" style="display: none;" >
                                         所选优惠券编码：<span id="strCode" style="display:inline-block;width:80%;word-wrap:break-word;white-space:normal;"></span><!-- <input class="nui-TextArea" name="useRemark"
						                      style="width: 80%; height: 40px;" id="strCode"/> -->
                                 </div>
							</div>
						</div>
						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">积分抵扣</a>
							</div>
							<div class="pay_js_right">
								<table id="tbcommissionlist" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td height="40">没有可用积分</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="pay_jshj_list">
							<div class="pay_js_left">
								<a href="javascript:;" class="xz">优惠金额</a>
							</div>
							<div class="pay_js_right">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td width="10%">
												<span>其他优惠：</span>

											</td>
											<td height="40" class="line24">
												<input class="mini-spinner" id="PrefAmt" name="PrefAmt" changeOnMousewheel="false" showbutton="false" m="1" allowNull="false" minValue="-0.999999" maxValue="1000000" cardid="" amount="" style="width: 100px; float: left;" onvaluechanged="onChanged">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>

					<div class="pay_list">
						<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">其它费用收入</span></h2>
						<div class="pay_tcbk zffs" style="padding: 0 0 18px 0;">
							<div id="dataform">
								<div class="skbox2" id="div0" name="div0">
									<table name="account0" id="account0" width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="50%" height="&quot;44&quot;">
											
												</td>
												<td>
												</td>
											
											</tr>
										</tbody>
									</table>
									<table name="paytype0" id="paytype0" width="96%" border="0" cellpadding="0" cellspacing="0">
										<tbody>

										</tbody>
									</table>
								</div>
							</div>
					
						</div>
					</div>

					
					<div class="pay_list">
						<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">其它费用支出</span></h2>
						<div class="pay_tcbk zffs" style="padding: 0 0 18px 0;">
							<div id="dataform">
								<div class="skbox2" id="div0" name="div0">
									<table name="account0" id="account0" width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="50%" height="&quot;44&quot;">
									
												</td>
												<td>
												</td>
									
											</tr>
										</tbody>
									</table>
									<table name="paytype1" id="paytype1" width="96%" border="0" cellpadding="0" cellspacing="0">
										<tbody>

										</tbody>
									</table>
								</div>
							</div>

						</div>
					</div>
					<div class="pay_list">
						<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">收款方式</span></h2>
						<div class="pay_tcbk zffs" style="padding: 0 0 18px 0;">
							<div id="dataform">
								<div class="skbox2" id="div0" name="div0">
									<table name="account0" id="account0" width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="50%" height="&quot;44&quot;">
													<select name="optaccount0" id="optaccount0" onchange="checkField(this.id)" style="width: 94%; height: 33px; font-weight: bold; font-size: 15px; color: #578ccd;border:0;">


													</select>
												</td>
												<td>
												</td>
												<!-- <td>
											<a class="depj" data-balloon="删除收款方式" href="javascript:void(0);" onclick="dF()" style="margin-left: 15px;"></a>
										</td> -->
											</tr>
										</tbody>
									</table>
									<table name="ppaytype0" id="ppaytype0" width="96%" border="0" cellpadding="0" cellspacing="0">
										<tbody>

										</tbody>
									</table>
								</div>
							</div>
							<div class="" id="csdiv" style="background: #f8f8f8;">
								<div class="guazhangbz">
									<table id="tbaddaccount" width="96%" height="30px" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td>
													<div class="pay_tcbk_list" style="padding: 0; margin-bottom: 2px;">
														<ul>
															<li>
																<a href="javascript:void(0);" onclick="addF()">
																	<font>添加收款方式</font>
																</a>
															</li>
														</ul>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					
					<div class="pay_list">
						<div class="pay_tcbk zffs" id="csdiv" style="background: #f8f8f8;">
							<div class="guazhangbz">
								<table width="100%" border="0" cellspacing="0" cellpadding="10">
									<tr>
										<!-- <td width="100">收款时间</td>
										<td width="220">
											<input class="mini-datepicker">
										</td> -->
										<td width="120" align="right">业务备注:</td>
										<td >
											<input class="nui-textbox" id="txtreceiptcomment" name="txtreceiptcomment" width="150px">
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					
					

				</div>
			</div>
			
		</div>
		<div style="height: 15%;">

		</div>
	</div>
	<div style="background-color: #cfddee;position:fixed; top:90%;width:100%;height: 10%; z-index:900;">
		<div style="float:left;height:100%;width:100%;">
			<table id="statustable" style="width:100%;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
				<tr>
					<td >
						<label style="font-family:Verdana;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td >
						<label style="font-family:Verdana;">应收金额：</label>
						<span id="totalAmt1" name="totalAmt1" style="font-size:21px; font-weight:bold; color:#ff3200;"></span> 元
					</td>
					<td >
					</td>
					<td >
						<label style="font-family:Verdana;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td >
						<label style="font-family:Verdana;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td >
						<input type="checkbox" id="settlesendwx" >微信通知客户
					</td>
					<td >
						<input type="checkbox" id="settlesenddx">短信通知客户
					</td>
					<td >
						<label style="font-family:Verdana;">预存金额：</label>
						<span id="ycAmt" style="font-size:21px; font-weight:bold; color:#ff3200;"></span> 元
					</td>
					<td >
						<label style="font-family:Verdana;">优惠券抵扣：</label>
						<span id="quanAmt" style="font-size:21px; font-weight:bold; color:#ff3200;"></span> 元
					</td>
					<td >
						<label style="font-family:Verdana;">实收金额：</label>
						<span id="amount" style="font-size:21px; font-weight:bold; color:#ff3200;"></span> 元
					</td>
					<td >
						<a id="ysettle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #2ac476;
							color: #fff;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="noPay()" >转预结算</a>
					</td>
					<td >
						<a id="settle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #578ccd;
							color: #fff;
							text-align: center;
							display: block;
							border-radius: 5px;
							text-decoration: none;
							line-height: 2;" 
							href="javascript:void(0)" onclick="pay()" >结算收款</a>
					</td>
				</tr>
			</table>
		</div>
			
		<!-- <div style="float: left;height: 100%;">
			<table id="statustable" style="width:100%;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;align-content: ">
				<tr>
					<td margin-left:10px width="20%">
						<dd style="margin-right:60px;">待收金额：
							<span id="totalAmt1" name="totalAmt1" style="font-size:21px; font-weight:bold; color:#ff3200; line-height:76px;"></span> 元
						</dd>
					</td>
					<td>
						<dt style="margin-right:60px;">
							<label for="settlesendwx">
								<input type="checkbox" id="settlesendwx" checked="checked">微信通知车主
							</label>
							<label for="settlesenddx">
								<input type="checkbox" id="settlesenddx">短信通知车主
							</label>
						</dt>
					</td>
					<td>
						<dd style="margin-right:160px;">剩余应收：
							<span id="amount" style="font-size:21px; font-weight:bold; color:#ff3200; line-height:76px;"></span> 元
						</dd>
					</td>
					<td>
						<dd>
							<a id="wxbtnsettle" style="    width: 120px;
											height: 40px;
											font-size: 18px;
											background: #2ac476;
											color: #fff;
											text-align: center;
											display: block;
											border-radius: 5px;
											text-decoration: none;
											line-height: 40px;
											margin-bottom: 20%;" href="javascript:void(0)" onclick="settleOK()">微信结算</a>
						</dd>
					</td>
					<td >
						<dd >
							<a id="btnsettle" style="    width: 120px;
											height: 40px;
											font-size: 18px;
											background: #578ccd;
											color: #fff;
											text-align: center;
											display: block;
											border-radius: 5px;
											text-decoration: none;
											line-height: 40px;
											margin-bottom: 20%;" href="javascript:void(0)" onclick="settleOK()">结算</a>
						</dd>
					</td>

				</tr>
			</table>
		</div> -->
	</div>
	<script type="text/javascript">

	</script>

</body>

</html>