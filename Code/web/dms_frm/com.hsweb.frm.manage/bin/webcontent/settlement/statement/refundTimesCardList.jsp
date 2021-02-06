<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>计次卡退款</title>
<script
	src="<%=request.getContextPath()%>/manage/settlement/js/refundTimesCardList.js?v=1.2.7"></script>
    <style type="text/css">
        body { 
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            Foverflow: hidden;
        }
        .btnType{
            font-family:Verdana;
            font-size: 14px;
            text-align: center;
            height: 40px;
            width: 120px;
            line-height:40px;
        }
        .title {
            width: 80px;
            text-align: right;
        }
        .required {
            color: red;
        }
       
        a.optbtn {
            width: 44px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }


.tishi{
	margin-top: 5px;
}
.btn .mini-buttonedit{
	height:36px;
}
.btn .aa{
	height:36px;
	width: 300px;
}
.btn .mini-buttonedit .mini-corner-all{
	height:33px;
	background: #368bf447;
}
.btn .aa .mini-corner-all{
	height:33px;
}
.mini-corner-all .nui-textbox{
	height:30px;
}
.btn .mini-corner-all .mini-buttonedit-input{
	font-size: 16px;
	margin-top: 8px;
	
}
.btn .mini-corner-all .mini-textbox-input{
	font-size: 14px;
	margin-top: 8px;
	
}

 
    	.tips {
    	width:100%;
    color: #8a6d3b;
    background-color: #fcf8e3;
    border-color: #faebcc;
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
    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;height:48px;position: relative;">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td class="btn">
                	<div class="nui-autocomplete" emptyText="客户查询(输入的内容长度要求大于或是等于3)"
                    style="width:400px;height: 50px !important;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo"   searchField="key" multiSelect="false" 
                    dataField="list" placeholder="请输入..."  >     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="车架号(VIN)" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox aa"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-history fa-lg"></span>&nbsp;清空</a>
<!--                 <a class="nui-button" onclick="refund()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款</a>
				<a class="nui-button" onclick="refundRecord()" plain="true"> <span class="fa fa-user-circle fa-lg"></span>&nbsp;退款记录</a> -->
            </td> 
          </tr>
        </table>
      </div>

<div id="dataform1" >
				<table width="100%" height="85%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td colspan="4">
								<div class="tips">
								<span class="fa fa-exclamation-triangle fa-lg" style="margin-left: 10px;"></span>计次卡退款只能退未使用过的计次卡并且只能退全款！<br>
								<span class="fa fa-exclamation-triangle fa-lg" style="margin-left: 10px;"></span>退款请对清明细，退款成功无法撤回，谨慎操作！<br>
								</div>
							</td>
						</tr>
						
						<tr >
							<td align="right" width="100px" colspan="1" >
								<font color="red">*</font>计次卡<font color="red">*</font>：		
							</td>
							<td align="left" width="100px" colspan="3">
								<input class="mini-combobox" id="cardName" name="cardName" textField="text" valueField="value" width="300"  />
							</td>

						</tr>

						<tr>
							<td colspan="4">
								<div class="pay_list">
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
							</td>
						</tr>
						<tr>
							<td colspan="4">
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
							</td>
						</tr>

                    <tr>
                        <td colspan="2" a align="left" >

							
						 <a id="wxbtnsettle1" style="    width: 100px;
							height: 40px;
							font-size: 18px;
							background: #2ac476;
							color: #FFF;
							text-align: center;
							display: block;
							border-radius: 5px;
							margin-top: 5px;
							line-height: 2;
							float:left;
							margin-left:100px;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="pay()" >退款</a>
                           
                        </td>
                    </tr>
                    					</tbody>
              </table>
		</div>

</body>
</html>