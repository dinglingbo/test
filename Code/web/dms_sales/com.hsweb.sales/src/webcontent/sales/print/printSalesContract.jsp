<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/sysCommon.jsp"%>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->

        <head>
            <title>车辆销售合同</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js" type="text/javascript"></script>
            <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js" type="text/javascript"></script>
            <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" />

        </head>
        <style>
            table,
            td {
                font-family: Tahoma, Geneva, sans-serif;
                font-size: 13px;
                color: #000;
            }
            
            table.ybk {
                width: 100%;
                max-width: 100%;
                border-spacing: 0;
                border-collapse: collapse;
                background-color: transparent;
            }
            
            table.ybk1 {
                width: 100%;
                max-width: 100%;
                border: 1px solid #151515;
                background-color: transparent;
            }
            
            table.ybk2 {
                border-top: #FF0000 solid 1px;
            }
            
            table.ybk td {
                border: 1px solid #000;
            }
            
            .print_btn {
                text-align: center;
                width: 100%;
                padding: 30px 0 20px 0;
                border: 0px solid red;
            }
            
            .print_btn a {
                width: 160px;
                height: 42px;
                display: inline-block;
                background: #578ccd;
                line-height: 42px;
                border-radius: 5px;
                color: #fff;
                font-size: 18px;
                text-decoration: none;
                margin: 0 10px;
            }
            
            .print_btn a:active,
            .print_btn a:hover {
                background: #df0024;
            }
            
            .sminput {
                width: 640px;
                height: 40px;
                border: 1px #b4b4b4 solid;
                float: left;
                font-size: 13px;
                font-family: "微软雅黑";
            }
            
            .smbottom {
                width: 50px;
                height: 44px;
                background: #c8c8c8;
                border: 0;
                border-radius: 5px;
                margin-left: 5px;
            }
            
            .xgsm {
                width: 720px;
                margin: 0 auto;
                display: none;
            }
            
            .jsxx {
                color: #000;
                padding-bottom: 15px;
            }
            
            .jsxx h3 {
                color: #000;
                font-size: 15px;
                font-weight: 700;
                height: 26px;
                border-bottom: 1px #000 solid;
            }
            
            .jsxx ul {
                padding-top: 6px;
            }
            
            .jsxx ul li {
                color: #000;
            }
            
            .renyuan {
                height: 40px;
                line-height: 40px;
                width: 97%;
                margin: 0 auto;
            }
            
            .renyuan li {
                width: 33%;
                float: left;
            }
            
            .myddc dd,
            .myddc dt {
                float: left;
                margin-right: 30px;
            }
            
            .myddc dd font {
                display: block;
                float: left;
                width: 12px;
                height: 12px;
                border: 1px #000 solid;
                margin: 4px 5px 0 0;
            }
            
            .divHeight {
                height: 30px;
            }
        </style>

        <body>
            <!-- oncontextmenu = "return false" -->
            <div class="print_btn">
                <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
                <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
            </div>
            <input id="frameColorId1" name="frameColorId1" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
            <input id="interialColorId1" name="interialColorId1" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
            <div style="margin: 0 10px;" class="printny">
                <div class="company-info">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr>
                                <td rowspan="2" style="width: 133px;text-align: center">
                                    <img alt="" src="http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7" id="showImg" height="60px">
                                </td>
                                <td style="width:55%">
                                    <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp"></span></div>
                                    <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">您身边的车管家</span></div>
                                    <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">一次选择 终生服务</span></div>
                                </td>
                                <td rowspan="2" style="">
                                    <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span
                                        id="spstorename">车辆销售合同</span></b></div>
                                    <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">Sales Contract</span>
                                    </div>
                                    <div style="font-size: 14px;padding-left: 10px; ">打印日期：<span id="date"></span></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div class="divHeight">
                <div style="border-top:1px solid black;border-bottom:1px solid black;">
                    <div style="width:33%;display: inline-block;">合同编号：<span id="contractNo"></span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">买方姓名：<span style="text-decoration: underline;" id="guestFullName"></span></div>
                    <div style="width:49%;display: inline-block;">卖方：<span id="comp"></span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">电&emsp;&emsp;话：<span style="text-decoration: underline;" id="contactorTel"></span></div>
                    <div style="width:49%;display: inline-block;">电话：<span id="currEmpTel"></span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">身份证号：<span style="text-decoration: underline;" id="idCard"></span></div>
                    <div style="width:49%;display: inline-block;">服务热线：<span></span></div>
                </div>
                <div style="margin-top:10px;">一、车辆信息 </div>

                <table border="0" cellpadding="0" cellspacing="0" class="ybk" style="line-height:32px;margin-top:5px;margin-left:28px;width:calc(100% - 28px);">
                    <tbody>
                        <tr>
                            <td height="50" valign="top" style="padding:8px;width:33%;" id="">
                                车型
                            </td>
                            <td height="70" valign="top" style="padding:  8px;width:10%;" id="">
                                外饰
                            </td>
                            <td height="70" valign="top" style="padding:  8px;width:10%;" id="">
                                内饰
                            </td>
                            <td height="50" valign="top" style="padding:  8px;width:20%;" id="">
                                车架号（VIN）
                            </td>
                            <td height="50" valign="top" style="padding:  8px;width:26%;" id="">
                                备注
                            </td>
                        </tr>
                        <tr>
                            <td height="50" valign="top" style="padding:8px;" id="">
                                <span id="carModelName"></span>
                            </td>
                            <td height="50" valign="top" style="padding:  8px;" id="">
                                <span id="frameColorId"></span>
                            </td>
                            <td height="50" valign="top" style="padding:  8px;" id="">
                                <span id="interialColorId"></span>
                            </td>
                            <td height="50" valign="top" style="padding:  8px;" id="">
                                <span id=""></span>
                            </td>
                            <td height="50" valign="top" style="padding:  8px;" id="">
                                <span id=""></span>
                            </td>
                        </tr>

                    </tbody>
                </table>
                <div style="margin-top:10px;">二、购买方式：
                    <span id="select1">☐</span>&nbsp;全款&nbsp;&nbsp;&nbsp;&nbsp;
                    <span id="select2">☐</span>&nbsp;银行按揭&nbsp;&nbsp;&nbsp;&nbsp;
                    <span id="select3">☐</span>&nbsp;金融公司&nbsp;&nbsp;&nbsp;&nbsp;
                    <span id="select4">☐</span>&nbsp;厂家金额&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
                <div style="margin-top:10px;">
                    <p>三、车辆价格￥：
                        <span id="saleAmt"></span>元（大写）<span id="saleAmtB"></span></p>
                    <p>&emsp;&emsp;预付款￥：<span id="advanceChargeAmt"></span>元（大写）<span id="advanceChargeAmtB"></span></p>
                    <p id="saleType">&emsp;&emsp;银行按揭：审核贷款通过后，买方按购车计算表提车首付款金额（￥
                        <span style="text-decoration: underline" id="downPaymentAmt"></span>元）支付给卖方，待银行将贷款金额（￥
                        <span style="text-decoration: underline" id="loanAmt"></span>元）打入卖方账户并且到账后，买方办理提车。</p>

                </div>
                <div style="margin-top:10px;">四、交车时间、地点：
                    <p>&emsp;&emsp;交车时间：<span style="text-decoration: underline" id="submitPlanDate"> </span>（全款到账提车）</p>
                    <p>&emsp;&emsp;交车地点：<span style="text-decoration: underline" id="address"></span></p>
                </div>
                <div style="margin-top:10px;">五、本合同价款包含：
                    <p>&emsp;&emsp;<span>钥匙扣、手机支架、大屏导航仪</span></p>
                </div>
                <div style="margin-top:10px;">六、备注：
                    <div style="margin-left:28px;width:calc(100% - 28px);height:80px;border:1px solid black;"></div>

                </div>
                <div style="margin-top:10px;">
                    <div style="margin-left:28px;width:calc(100% - 28px);height: 40;">
                        <div style="width:50%;display: inline-block;"></div>
                        <p style="display: inline-block">销售顾问：</p>
                        <p style="border-bottom:1px solid black;width:200px;display: inline-block"></p>
                    </div>
                    <div style="margin-left:28px;width:calc(100% - 28px);">
                        <div style="width:50%;display: inline-block;">
                            <p style="display: inline-block">买方：</p>
                            <p style="border-bottom:1px solid black;width:200px;display: inline-block">&emsp;</p>
                        </div>
                        <div style="width:49%;display: inline-block;">
                            <p style="display: inline-block">电话/微信：</p>
                            <p style="border-bottom:1px solid black;width:200px;display: inline-block"></p>
                        </div>
                    </div>
                    <div style="margin-left:28px;width:calc(100% - 28px);">
                        <div style="width:50%;display: inline-block;"></div>
                        <div style="width:49%;display: inline-block;">
                            <p style="display: none">&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;</p>
                            <p style="border-bottom:1px solid black;width:200px;display: none">&emsp;</p>
                        </div>
                    </div>

                </div>
                <div class="divHeight" style="border-top:1px solid black;margin-top:5px;">
                    <div style="width:50%;display: inline-block;">公司：<span id="currRepairSettorderPrintShow"></span></div>
                    <div style="width:49%;display: inline-block;">电话/传真：<span id="currCompTel"></span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">地址：<span id="currCompAddress"></span></div>
                    <div style="width:49%;display: inline-block;">网址：<span></span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">开户银行：<span id="currBankName"></span></div>
                    <div style="width:49%;display: inline-block;">银行账户：<span id="currBankAccountNumber"> </span></div>
                </div>
                <div class="divHeight">
                    <div style="width:50%;display: inline-block;">24小时救援电话：<span></span></div>
                    <div style="width:49%;display: inline-block;">投诉电话：<span></span></div>
                </div>
                <div class="divHeight" style="text-align: center;">
                    <span style="font-size:12px;">特别声明：本合同与客户签字确认的购车费用计算表起同等法律效力。</span>
                </div>





            </div>
            <script type="text/javascript">
                var webBaseUrl = webPath + contextPath + "/";
                var baseUrl = apiPath + saleApi + "/";
                $("#print").click(function() {
                    $(".print_btn").hide();
                    $(".print_hide").hide();

                    window.print();
                });

                function SetData(serviceId) {
                    $.ajaxSetup({
                        async: false
                    });
                    initDicts({
                        frameColorId1: "DDT20130726000003", //车辆颜色
                        interialColorId1: "10391"
                    });
                    var date = new Date();
                    document.getElementById("date").innerHTML = format(date, "yyyy-MM-dd HH:mm:ss");
                    document.getElementById("currRepairSettorderPrintShow").innerHTML = currRepairSettorderPrintShow;
                    document.getElementById("currCompTel").innerHTML = currCompTel;
                    document.getElementById("currCompAddress").innerHTML = currCompAddress;
                    document.getElementById("address").innerHTML = currCompAddress;
                    document.getElementById("currBankName").innerHTML = currBankName;
                    document.getElementById("currBankAccountNumber").innerHTML = currBankAccountNumber;
                    document.getElementById("comp").innerHTML = currRepairSettorderPrintShow;
                    document.getElementById("currEmpTel").innerHTML = currEmpTel;
                    var url = baseUrl + 'sales.search.searchSalesMain.biz.ext?params/id=' + serviceId;
                    $.post(url, function(res) {
                        if (res.data.length > 0) {
                            var temp = res.data[0];
                            var contractNo = temp.contractNo || "";
                            var guestFullName = temp.guestFullName || "";
                            var contactorTel = temp.contactorTel || "";
                            var submitPlanDate = temp.submitPlanDate || "";
                            var idCard = temp.idCard || "";
                            var carModelName = temp.carModelName || "";
                            var frameColorId = temp.frameColorId || "";
                            var interialColorId = temp.interialColorId || "";
                            document.getElementById("contractNo").innerHTML = contractNo;
                            document.getElementById("guestFullName").innerHTML = guestFullName;
                            if (submitPlanDate) {
                                document.getElementById("submitPlanDate").innerHTML = format(submitPlanDate, 'yyyy-MM-dd HH:mm:ss');
                            }
                            document.getElementById("contactorTel").innerHTML = contactorTel;
                            document.getElementById("idCard").innerHTML = idCard;
                            nui.get("frameColorId1").setValue(frameColorId);
                            nui.get("interialColorId1").setValue(interialColorId);
                            document.getElementById("frameColorId").innerHTML = nui.get("frameColorId1").text;
                            document.getElementById("interialColorId").innerHTML = nui.get("interialColorId1").text;
                            document.getElementById("carModelName").innerHTML = carModelName;
                        }
                    });
                    var url = baseUrl + 'sales.search.searchSaleCalc.biz.ext?params/billType=2&params/serviceId=' + serviceId;
                    $.post(url, function(res) {
                        if (res.data.length > 0) {
                            var temp = res.data[0];
                            document.getElementById("saleAmt").innerHTML = temp.saleAmt || 0; //车价（元）
                            document.getElementById("saleAmtB").innerHTML = transform(temp.saleAmt + "");
                            document.getElementById("advanceChargeAmt").innerHTML = temp.advanceChargeAmt || 0; //预付款
                            document.getElementById("advanceChargeAmtB").innerHTML = transform(temp.advanceChargeAmt + "");
                            var saleType = temp.saleType;
                            if (saleType && saleType == "1558580770894") {
                                document.getElementById("saleType").style.display = "none";
                            } else {
                                document.getElementById("downPaymentAmt").innerHTML = temp.downPaymentAmt || 0;
                                document.getElementById("loanAmt").innerHTML = temp.loanAmt || 0;
                            }
                            if (saleType == "1558580770894") {
                                document.getElementById("select1").innerHTML = "☑";
                            } else if (saleType == "1558078347480") {
                                document.getElementById("select2").innerHTML = "☑";
                            } else if (saleType == "1558580770897") {
                                document.getElementById("select3").innerHTML = "☑";
                            } else if (saleType == "1558580770896") {
                                document.getElementById("select4").innerHTML = "☑";
                            }
                        }
                    });
                }

                function CloseWindow(action) {
                    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
                    else window.close();
                }
            </script>
        </body>

        </html>