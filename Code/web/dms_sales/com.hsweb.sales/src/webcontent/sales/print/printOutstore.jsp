<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->

    <head>
        <title>出库放行条</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
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
    </style>

    <body>
        <input id="frameColorId1" name="frameColorId1" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
        <input id="interialColorId1" name="interialColorId1" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
        <input class="nui-combobox" id="saleAdvisorId1" name="saleAdvisorId1" style="width: 100%;" textField="empName" valueField="empId" visible="false">
        <div class="print_btn">
            <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
            <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
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
                                <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp">车道东莞测试12店</span></div>
                                <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">您身边的车管家</span></div>
                                <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">一次选择 终生服务</span></div>
                            </td>
                            <td rowspan="2" style="">
                                <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename">出库放行条</span></b></div>
                                <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">Release Pass</span> </div>
                                <div style="font-size: 14px;padding-left: 10px; ">打印日期：<span id="date"></span></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div style="border-top:1px">
                <div style="width:33%;display: inline-block;">NO：<span></span></div>
                <div style="width:33%;display: inline-block;"><span></span></div>
                <div style="width:32%;display: inline-block;">打印人：<span id="currUserName"></span></div>
            </div>

            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk" style="line-height:32px;margin-top:5px;">
                <tbody>
                    <tr>
                        <td height="50" valign="top" style="padding:8px;width:10%;" id="">
                            车牌
                        </td>
                        <td height="50" valign="top" style="padding:  8px;width:20%;" id="">
                            <span id="carNo"></span>
                        </td>
                        <td height="50" valign="top" style="padding:  8px;width:10%;" id="">
                            厂牌
                        </td>
                        <td height="50" valign="top" style="padding:  8px;width:20%;" id="">

                        </td>
                        <td height="50" valign="top" style="padding:  8px;width:10%;" id="">
                            车型
                        </td>
                        <td height="50" valign="top" style="padding:  8px;width:20%;" id="carModelName">

                        </td>
                    </tr>
                    <tr>
                        <td height="50" valign="top" style="padding:8px" id="">
                            客户
                        </td>
                        <td height="50" valign="top" style="padding:  8px;" id="">
                            <span id="guestFullName"></span>
                        </td>
                        <td height="50" valign="top" style="padding:  8px;">
                            车身颜色
                        </td>
                        <td height="50" valign="top" style="padding:  8px;" id="frameColorId">

                        </td>
                        <td height="50" valign="top" style="padding:  8px;">
                            内饰颜色
                        </td>
                        <td height="50" valign="top" style="padding:  8px;" id="interialColorId">

                        </td>
                    </tr>
                    <tr>
                        <td height="50" valign="top" style="padding:8px" id="">
                            车架号
                        </td>
                        <td height="50" valign="top" style="padding:  8px;" id="" colspan="3">
                            <span id="vin"></span>
                        </td>
                        <td height="50" valign="top" style="padding:  8px;" id="">
                            销售员
                        </td>
                        <td height="50" valign="top" style="padding:  8px;">
                            <span id="saleAdvisorId"></span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="border-top:1px">
                <div style="width:33%;display: inline-block;">销售顾问：<span></span></div>
                <div style="width:33%;display: inline-block;">收银：<span></span></div>
                <div style="width:32%;display: inline-block;">销售经理：<span></span></div>
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
                initMember("saleAdvisorId1", function() {

                });
                document.getElementById("currUserName").innerHTML = currUserName;
                var date = new Date();
                document.getElementById("date").innerHTML = format(date, "yyyy-MM-dd HH:mm:ss");
                var url = baseUrl + 'sales.search.searchSalesMain.biz.ext?params/id=' + serviceId;
                var enterId = 0;
                $.post(url, function(res) {
                    if (res.data.length > 0) {
                        var temp = res.data[0];
                        var guestFullName = temp.guestFullName || "";
                        var carModelName = temp.carModelName || "";
                        var frameColorId = temp.frameColorId || "";
                        var interialColorId = temp.interialColorId || "";
                        var saleAdvisorId = temp.saleAdvisorId || "";
                        document.getElementById("guestFullName").innerHTML = guestFullName;
                        nui.get("frameColorId1").setValue(frameColorId);
                        nui.get("interialColorId1").setValue(interialColorId);
                        document.getElementById("frameColorId").innerHTML = nui.get("frameColorId1").text;
                        document.getElementById("interialColorId").innerHTML = nui.get("interialColorId1").text;
                        nui.get("saleAdvisorId1").setValue(saleAdvisorId);
                        document.getElementById("saleAdvisorId").innerHTML = nui.get("saleAdvisorId1").text;
                        document.getElementById("carModelName").innerHTML = carModelName;
                        enterId = temp.enterId || 0;
                    }
                });

                var url = baseUrl + "/sales.inventory.queryCheckEnter.biz.ext?params/id=" + enterId;
                if (enterId) {
                    $.post(url, function(res) {
                        if (res.data.length > 0) {
                            var temp = res.cssCheckEnter[0];
                            var vin = temp.vin || "";
                            var carNo = temp.carNo || "";
                            document.getElementById("vin").innerHTML = vin;
                            document.getElementById("carNo").innerHTML = carNo;
                        }
                    });
                }
            }

            function CloseWindow(action) {
                if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
                else window.close();
            }
        </script>
    </body>

    </html>