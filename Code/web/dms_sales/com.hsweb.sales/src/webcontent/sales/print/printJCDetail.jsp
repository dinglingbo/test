<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%-- <%@include file="/common/sysCommon.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->

<head>
    <title>交车确认单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js"
        type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js" type="text/javascript">
    </script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"
        type="text/javascript"></script>
    <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet"
        type="text/css" />

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
</style>

<body>
    <!-- oncontextmenu = "return false" -->
    <div class="boxbg" style="display:none"></div>
    <div class="popbox" style="height:420px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2>
        <div style="padding-top:15px; margin:0 15px;">
            <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" width="90" height="46">单据编号：</td>
                        <td><input type="text" id="txtno" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">门店名称：</td>
                        <td><input type="text" id="txtstorename" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">地址：</td>
                        <td><input type="text" id="txtaddress" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">电话：</td>
                        <td><input type="text" id="txtphoneno" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">进厂时间：</td>
                        <td><input id="updateEnterDate" type="datetime-local" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">打印时间：</td>
                        <td><input id="meeting" type="datetime-local" value="" /></td>
                    </tr>
                </tbody>
            </table>

        </div>
        <div class="boxbtn">
            <ul><a href="javascript:box_setup_close()" class="qc">取消</a><a href="javascript:save()" id="btn_save">保存</a>
            </ul>
        </div>
    </div>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a href="javascript:box_setup_open()">修改</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
        <a plain="true" iconCls="" plain="false" onclick="sendInfo()" id="sendInfo">发送短信</a>
        <a style="" plain="true" iconCls="" plain="false" onclick="sendWechatInfo()" id="openId">发送微信</a>
    </div>

    <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <td rowspan="2" style="width: 133px;text-align: center">
                            <img alt="" src="http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7" id="showImg" height="60px">
                        </td>
                        <td style="width:55%">
                            <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span
                                    id="comp">车道东莞测试12店</span></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">您身边的车管家</span></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">一次选择 终生服务</span></div>
                        </td>
                        <td rowspan="2" style="">
                            <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename">贷款购车计算表</span></b></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">Order to Delivery</span> </div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">打印日期：2019-5-24 11:17:38</span></div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk"
            style="line-height:32px;margin-top:5px;">
            <tbody>
                <tr>
                    <td height="50" valign="top" style="padding:8px" id="guestDesc">
                        销售合同号
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="faultPhen">
                        <span id="guestFullName"></span>
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="solveMethod">
                        车顾客名称/单位
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        155000
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        车辆型号
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                            特斯拉 MODEL S 2019款 showdon S 特别版
                        <span id="carModelName"></span>
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        电话
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        <span id="saleAmt"></span>
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        车身颜色
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        <span id=""></span>
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        内饰颜色
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        <span id=""></span>
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        车架号
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        <span id=""></span>
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        提车时间
                    </td>
                    <td height="50" valign="top" style="padding:  8px;" id="">
                        <span id=""></span>
                    </td>
                </tr>
            </tbody>
            <tbody>
                
                <tr>
                    <td  valign="top" style="padding:  8px;" id="" colspan="4">
                            <p>尊敬的用户：</p>
                            <p>&nbsp;&nbsp;&nbsp;&nbsp;您好！首先感谢您对本公司的厚爱与支持，在您使用这部车辆之前，让我们来为您的爱车做点交与说明。</p>
                            <p>&nbsp;&nbsp;&nbsp;&nbsp;车主于签收车辆以前，下面各项证件资料点交及功能操作均需经过销售颐问详细点交及说明，请 车主确认井签收。</p>
                            <p>&nbsp;&nbsp;&nbsp;&nbsp;若有委托交车代理人，于交车手续所做的任何行为，视同委托人的行为，车辆离开公司概由委托 人负责。</p>
                    </td>
                </tr>
                <tr>
                    <td height="50" colspan="4"  style="padding:  8px;" > 
                        <p style="width:49%;display:inline-block;">交车前准备：<input type="checkbox" name="" value="" />&nbsp;PDI检查</p>
                        <p style="width:50%;display:inline-block;">费用说明及单据点交：<input type="checkbox" name="" value="" />&nbsp;发票</p>
                    </td>
                </tr>
                <tr>
                    <td  colspan="4"  style="padding:  8px;" > 
                        <p>交车前准备：</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;车内整洁&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;外观整洁&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;钥匙&nbsp;&nbsp;&nbsp;&nbsp;把&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;工具医药包&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;备胎&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="checkbox" name="" value="" />&nbsp;三角牌
                        
                        </p>
                    </td>
                </tr>
                <tr>
                    <td  colspan="4" style="padding:  8px;" > 
                        <p>车辆操作说明：</p>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;座椅、方向盘、后视镜调节</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;电动车窗调节</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;儿童安全锁</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;空调系统</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;音响系统</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;灯光仪表盘</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;特有配置( CD、安全气囊、ABS、电动天窗、延时灯光）</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;发动机盖、行李箱、油箱盖的开启方法</span>
                        
                    </td>
                </tr>
                <tr>
                    <td  colspan="4" style="padding:  8px;" > 
                        <p>温馨服务：</p>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;座椅、方向盘、后视镜调节</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;拍照留念</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span><input type="checkbox" name="" value="" />&nbsp;其它（<span style="width:100px;display: inline-block"></span>)</span>
                        
                    </td>
                </tr>
                <tr>
                    <td  colspan="4" style="text-align: center"> 
                        <span style="font-size:18px;">保险相关说明</span>
                    </td>
                </tr>
                <tr>
                    <td  colspan="4" style="padding:  8px;" > 
                        <p style="text-align: center">保险声明</p>
                        <span>本人同意在销售服店购买相关车险，销售颐问或保险公司己详细介绍各种险种的保费及说明，本人
                                对自己所购险种无任何异议，一切按照《保险法》及保险销售合同约定与保险投保单条款执行。</span>
                            <div>
                                <span><input type="checkbox" name="" value="" />&nbsp;交强</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;三责（保&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;万）</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;车损</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;车船税</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;盗抢</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;自然</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;划痕</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;不免计税</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span><input type="checkbox" name="" value="" />&nbsp;上车人</span>
                            </div>
                                <div style="float:right;width:300px;">投保人/委托人签字：</div>
                    </td>
                </tr>
                <tr >
                    <td  valign="top" style="padding:  8px;" id="" colspan="4">
                        <div>
                            <div style="width:100%;">备注：<br></div>
                            <div style="float:left;width:400px;">以上所有内容本人经确认无误后签字：<span></span></div>
                            <div style="float:right;width:200px;">
                                年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
                            </div>
                            <div style="clear:both"></div>
                        </div>
                    </td>
                </tr>
                <tr >
                        <td height="50"  valign="top" style="padding:  8px;" id="" colspan="4">
                            <div>
                                <div style="float:left;width:200px;">销售顾问签字：<span></span></div>
                                <div style="float:right;width:200px;">
                                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
                                </div>
                                <div style="clear:both"></div>
                            </div>
                        </td>
                    </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        $("#print").click(function () {
            $(".print_btn").hide();
            $(".print_hide").hide();

            window.print();
        });
        getTableData();

        function getTableData() {
            var url = 'http://127.0.0.1:8080/default/sales.search.searchSaleCalc.biz.ext?billType=2&serviceId=24';
            $.post(url, function (res) {
                if (res.data.length > 0) {
                    var temp = res.data[0];
                    //document.getElementById("guestFullName").innerHTML = temp.guestFullName;
                    //document.getElementById("carModelName").innerHTML = temp.carModelName;
                    document.getElementById("saleAmt").innerHTML = temp.saleAmt; //车价（元）
                    document.getElementById("insuranceBudgetAmt").innerHTML = temp.insuranceBudgetAmt; //保险预算费
                    document.getElementById("boardLotAmt").innerHTML = temp.boardLotAmt; //上牌费
                    document.getElementById("purchaseBudgetAmt").innerHTML = temp.purchaseBudgetAmt; //购置税预算	
                    document.getElementById("decrAmt").innerHTML = temp.decrAmt; //精品加装	
                    document.getElementById("gpsAmt").innerHTML = temp.gpsAmt; //GPS费
                    document.getElementById("otherAmt").innerHTML = temp.otherAmt; //其它费用
                    document.getElementById("getCarTotal").innerHTML = temp.getCarTotal; //提车合计
                    document.getElementById("buyBudgetTotal").innerHTML = temp.buyBudgetTotal; //购车预算合计
                }
            });


        }
    </script>
</body>

</html>