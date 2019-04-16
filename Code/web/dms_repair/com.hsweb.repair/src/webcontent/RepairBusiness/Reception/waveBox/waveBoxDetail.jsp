<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@include file="/common/commonRepair.jsp"%>
        <html>
        <!-- 
  - Author(s): Administrator
  - Date: 2019-02-18 10:13:53
  - Description:
-->

        <head>
            <title>Title</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/waveBox/js/waveBoxDetail.js?v=1.328"></script>
        </head>
        <style type="text/css">
            body {
                margin: 0;
                padding: 0;
                border: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }
            
            .btnType {
                font-family: Verdana;
                font-size: 14px;
                text-align: center;
                height: 40px;
                width: 120px;
                line-height: 40px;
            }
            
            .title {
                width: 80px;
                text-align: right;
            }
            
            .textStyle {
                text-align: center;
                font-size: 14px;
                font-weight: bold;
                /* color:#32b400; */
            }
            
            .required {
                color: red;
            }
            
            #guestInfo a:link {
                font-size: 12px;
                color: #578ccd;
                text-decoration: none;
            }
            
            #guestInfo a:visited {
                font-size: 12px;
                color: #578ccd;
                text-decoration: none;
            }
            
            #guestInfo a:hover {
                font-size: 12px;
                color: #578ccd;
                text-decoration: underline;
            }
            
            #guestTab a:link {
                font-size: 12px;
                color: #578ccd;
                text-decoration: none;
            }
            
            #wechatTag {
                color: #62b900;
            }
            
            #wechatTag1 {
                color: #ccc;
            }
            /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/
            
            a.healthview {
                background: #78c800;
                font-size: 13px;
                color: #fff;
                text-decoration: none;
                padding: 0px 8px;
                border-radius: 20px;
            }
            
            a.healthview:hover {
                background: #f00000;
                color: #fff;
                text-decoration: none;
            }
            
            a.chooseClass {
                background: #578ccd;
                font-size: 13px;
                color: #fff;
                text-decoration: none;
                padding: 0px 8px;
                border-radius: 20px;
            }
            
            a.chooseClass:hover {
                background: #f00000;
                color: #fff;
                text-decoration: none;
            }
            
            a.optbtn {
                width: 52px;
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
            
            .statusview {
                background: #78c800;
                color: #fff;
                padding: 3px 20px;
                border-radius: 20px;
            }
            
            .nvstatusview {
                color: #5a78a0;
                padding: 3px 20px;
                border-radius: 20px;
                border: 1px solid;
            }
            
            .bottomfont {
                font-size: 20px;
            }
            
            .showhealthcss {
                color: #5a78a0;
                padding: 3px 20px;
                border: 1px solid;
            }
            /* 	#search{
		 display: none; 
		font-size:18px;
		text-align:center;
		left:240px;
		top:0px;
		text-align:center;
		z-index:999;
		color: #671e1ebf;
		width: 120px;
	    height: 40px;
	    background: #cac52afc;
	    position: absolute;
	    -moz-border-radius: 12px;
	    -webkit-border-radius: 12px;
	    border-radius: 12px;
	} */
            
            #comment_bubble {
                width: 140px;
                height: 100px;
                background: #78c800c2;
                position: relative;
                -moz-border-radius: 12px;
                -webkit-border-radius: 12px;
                border-radius: 12px;
            }
            /*  #search:before {
    content: "";
    width: 0;
    height: 0;
    right: 100%;
    top: 12px;
    position: absolute;
    border-top: 8px solid transparent;
    border-right: 18px solid #cac52afc;
    border-bottom: 8px solid transparent;
}   */
            
            .tishi {
                margin-top: 5px;
            }
            
            .btn .mini-buttonedit {
                height: 36px;
            }
            
            .btn .aa {
                height: 36px;
                width: 300px;
            }
            
            .btn .mini-buttonedit .mini-corner-all {
                height: 33px;
                background: #368bf447;
            }
            
            .btn .aa .mini-corner-all {
                height: 33px;
            }
            
            .mini-corner-all .nui-textbox {
                height: 30px;
            }
            
            .btn .mini-corner-all .mini-buttonedit-input {
                font-size: 16px;
                margin-top: 8px;
            }
            
            .btn .mini-corner-all .mini-textbox-input {
                font-size: 14px;
                margin-top: 8px;
            }
            
            html,
            body {
                margin: 0px;
                padding: 0px;
                border: 0px;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }
            
            .addyytime a.ztedit {
                height: 18px;
                display: inline-block;
                background: url(../images/sjde.png) 40px -1px no-repeat;
                padding-right: 22px;
                color: #888;
                text-decoration: none;
            }
            
            .addyytime a.hui {
                padding-left: 5px;
                padding-right: 5px;
                height: ;
                line-height: 24px;
                border: 1px #a6e0f5 solid;
                display: block;
                float: left;
                text-decoration: none;
                text-align: center;
                color: #00b4f6;
                border-radius: 4px;
                margin: 0 10px 10px 0;
            }
            
            .addyytime a.hui {
                border: 1px #e6e6e6 solid;
                color: #555555;
                background: #fff;
            }
            
            .addyytime a.xz {
                font-size: 13px;
                color: #555555 !important;
                background: #5ab1ef !important;
            }
            
            .addyytime a:link,
            a:visited {
                font-family: 微软雅黑, Arial, Helvetica, sans-serif;
                font-size: 16px;
                color: #555555;
                text-decoration: none;
            }
            
            .addyytime a.hui:hover {
                font-family: 微软雅黑, Arial, Helvetica, sans-serif;
                font-size: 16px;
                background-color: #9fe6b8;
                color: #FFF;
                text-decoration: none;
            }
            
            .addyytime a .hui {
                text-decoration: none;
                transition: all .4s ease;
            }
            
            .addyytime a.backRed {
                border: 1px #e6e6e6 solid;
                color: #555555;
                background: #f17171;
            }
            
            .titleTextDiv {
                border-bottom: 1px solid #ccc;
                margin-top: 10px;
            }
            
            .titleText {
                font-weight: 400;
                font-size: 18px;
                color: #666;
                border-bottom: 2px solid #23c0fa;
                display: inline-block;
                line-height: 35px;
            }
        </style>

        <body>
            <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox width1" textField="name" valueField="id" emptyText="请选择..." url="" allowInput="true" showNullItem="false" valueFromSelect="true" nullItemText="请选择..." width="100%" visible="false" />
            <div class="nui-toolbar" style="padding:2px;height:65px;position: relative;">
                <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
                    <tr>
                        <td class="btn">
                            <div class="mini-autocomplete" emptyText="未匹配到数据...(输入的内容长度要求大于或是等于3)" style="width:300px;height: 50px !important;" popupWidth="600" textField="text" valueField="id" id="search_key" url="" value="carNo" searchField="key" howNullItem="true" allowInput="true"
                                autoFill="true" dataField="list" placeholder="请输入...">
                                <div property="columns">
                                    <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                                    <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                                    <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                                    <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                                </div>
                            </div>
                            <input id="search_name" name="search_name" class="nui-textbox aa" emptyText="客户名称/手机号" onbuttonclick="onSearchClick()" visible="false" enabled="false" font-size="16px" showClose="false" allowInput="true" />
                            <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                            <label style="font-family:Verdana;">工单号:</label>
                            <label id="servieIdEl" style="font-family:Verdana;"></label>
                        </td>

                        <td style="text-align:right;">
                            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn">
                                <span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn">
                                <span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                           
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" plain="true" onclick="sureMT()" id="addBtn"><span class="fa fa-car fa-lg"></span>&nbsp;施工</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="warehousing()" id="warehousing" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;成品入库</a>
                            <span class="separator"></span>

                            <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint">
                                <span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                            <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="onPrint(2)" id="type11">打印派工单</li>
                                <li iconCls="" onclick="onPrint(5)" id="type11">打印领料单</li>
                                <li iconCls="" onclick="bxOnPrint(1)" id="type11">打印报价单</li>
                                <li iconCls="" onclick="bxOnPrint(3)" id="type11">打印施工单</li>
                                <li iconCls="" onclick="bxOnPrint(4)" id="type11">打印厂内翻新单</li>
                                <li iconCls="" onclick="bxOnPrint(2)" id="type11">打印结算单</li>
                            </ul>


                            <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT">
                                <span class="fa fa-gift fa-lg"></span>&nbsp;充值办卡</a>

                            <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="addcardTime()" id="type10">计次卡销售</li>
                                <li iconCls="" onclick="addcard()" id="type11">储值卡充值</li>
                            </ul>
                            <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore">
                                <span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

                            <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="unfinish()" id="addBtn">返单</li>
                                <li iconCls="" onclick="updateBillExpense()" id="billExpense">费用登记</li>
                                <!-- <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount">新增报销单</li> -->
                                <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount1">报销单</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                    	<td></td>
                    	<td style="text-align:right;">
                    			<a class="nui-button" iconCls="" plain="true" onclick="upload()" id="addBtn">
                                <span class="fa fa-upload fa-lg"></span>&nbsp;上传维修前后照片</a>      
                                <a class="nui-button" plain="true" id="attach" onclick="attach()">
                                <span class="fa fa-edit fa-lg"></span>&nbsp;附件登记</a>
                            <a class="nui-button" plain="true" id="fault" onclick="fault()">
                                <span class="fa fa-user fa-lg"></span>&nbsp;故障现象</a>
                    	</td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="billForm" class="form">
                    <input name="msg" id="msg" class="nui-hidden" />
                    <input name="id" class="nui-hidden" />
                    <input name="guestId" class="nui-hidden" id="guestId" />
                    <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden" />
                    <input class="nui-hidden" name="contactorId" />
                    <input class="nui-hidden" name="carId" />
                    <input class="nui-hidden" name="balaAuditSign" />
                    <input class="nui-hidden" name="carVin" />
                    <input class="nui-hidden" name="drawOutReport" />
                    <input class="nui-hidden" name="contactorName" />
                    <input class="nui-hidden" name="carModel" />
                    <input class="nui-hidden" name="identity" />
                    <input class="nui-hidden" name="billTypeId" id="billTypeId" />
                    <input class="nui-hidden" name="status" />
                    <input class="nui-hidden" name="isSettle" id="isSettle" />
                    <input class="nui-hidden" name="carModelIdLy" />
                    <input class="nui-hidden" name="carNo" id="carNo" />
                    <input class="nui-hidden" name="faultPhen" id="faultPhen" />
                    <table style="width: 100%;border-spacing: 0px 5px;">
                        <tr>
                            <td align="right" style="width:100px">变速箱型号：</td>
                            <td class="">
                                <input class="nui-textbox" name="engineModel" id="engineModel" width="100%" />
                            </td>
                            <td align="right" style="width:100px">
                                <label>波箱厂牌：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-combobox" name="carBrandId" id="carBrandId" valueField="id" textField="name" width="100%" />
                            </td>
                            <td align="right" style="width:100px">变速箱号：</td>
                            <td class="">
                                <input class="nui-textbox" name="engineNo" id="engineNo" width="100%" />
                            </td>
                            <td align="right" style="width:100px">
                                <label>驱动形式：</label>
                            </td>
                            <td class="" colspan="1">
                                <input name="driveType" id="driveType" class="nui-combobox width1" property="editor" data="QD" emptytext="请选择驱动形式" allowInput="true" showNullItem="false" valueFromSelect="true" nullItemText="请选择..." width="100%" />
                            </td>
                            <td class="title" style="width:100px">
                                <label>车架号(VIN)：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="carVin" id="carVin" width="100%" />
                            </td>
                        </tr>

                        <tr>
                            <td class="title required" style="width:100px">
                                <label>车牌号：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="carNo" id="carNo" width="100%" />
                            </td>
                            <td class="title required" style="width:100px">
                                <label>业务类型：</label>
                            </td>
                            <td class="">
                                <input name="boxServiceTypeId" id="boxServiceTypeId" class="nui-combobox width1" property="editor" data="boxServiceTypeId" emptytext="请选择业务类型" allowInput="true" showNullItem="false" valueFromSelect="true" onvaluechanged="changeBoxService" nullItemText="请选择..."
                                    width="100%" />
                            </td>
                            <td class="title required">
                                <label>服务顾问：</label>
                            </td>
                            <td>
                                <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" emptyText="请选择..." url="" allowInput="true" showNullItem="false" valueFromSelect="true" textField="empName" valueField="empId" nullItemText="请选择..." width="100%" />

                            </td>
                            <td class="title required">客户名称：</td>
                            <td class="">

                                <input class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%" />

                            </td>

                            <td class="title required">客户手机：</td>
                            <td class="">
                                <input class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false" width="100%" />

                            </td>
                        </tr>
                        <tr>
                            <td class="title required">联系人名称：</td>

                            <td class="">
                                <input id="contactorName" name="contactorName" class="nui-buttonedit" emptyText="" onbuttonclick="chooseContactor()" placeholder="请选择联系人" selectOnFocus="true" allowInput="false" width="100%" />
                            </td>
                            <td class="title required">联系人手机：</td>
                            <td class="">
                                <input class="nui-textbox" name="mobile" id="mobile" enabled="false" width="100%" />
                                <input class="nui-Spinner" decimalPlaces="0" minValue="0" maxValue="100000000" width="45%" id="enterKilometers" name="enterKilometers" allowNull="false" showButton="false" visible="false" />
                            </td>
                            <td class="title">进厂时间：</td>
                            <td class="">
                                <input id="enterDate" name="enterDate" allowInput="false" format="yyyy-MM-dd HH:mm" class="nui-datepicker" width="100%" />
                            </td>
                            <td class="title" style="width:100px">
                                <label>故障描述：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="faultPhen" id="faultPhen" enabled="false" width="100%" />
                            </td>
                            <td class="title">备注：</td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="remark" width="100%" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="text-align:center;">
                    <table border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <a href="javascript:bindWechat()" id="showA" style="display:none">
                                    <span id="wechatTag" class="fa fa-wechat fa-lg"></span>
                                </a>&nbsp;
                                <a href="javascript:bindWechat()" id="showA1" style="display:none">
                                    <span id="wechatTag1" class="fa fa-wechat fa-lg"></span>
                                </a>&nbsp;
                                <label style="font-family:Verdana;">客户名称:</label>
                                <label id="guestInfo" style="font-family:Verdana;">
                                    <a id="guestNameEl" href="javascript:checkGuest()"></a>
                                </label>&nbsp;
                                <label style="font-family:Verdana;">手机:</label>
                                <label id="guestTelEl" style="font-family:Verdana;"></label>&nbsp;
                            </td>
                            <td>
                                <div id="guestInfo">
                                    <label id="cardPackageEl" style="font-family:Verdana;color:blue;">
                                        <a id="showCardTimesEl" href="javascript:showCardTimes()">次卡套餐(0)</a>
                                    </label>
                                    <label id="clubCardEl" style="font-family:Verdana;color:blue;">
                                        <a id="showCardEl" href="javascript:showCard()">储值卡(0)</a>
                                    </label>
                                    <label id="creditEl" style="font-family:Verdana;color:#578ccd;">挂账:0</label>
                                    <span>&nbsp;&nbsp;&nbsp;</span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div class="titleTextDiv">
                        <span class="titleText">服务项目</span>
                    </div>
                    <div class="addyytime" style="display:''" id="showHot">
                        <table style="width:100%;height:50px;">
                            <tr>
                                <td id="addAEl">

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="" style="width:100%;height:auto;">
                        <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
                    </div>
                </div>
            </div>
            <div style="height: 10%;"></div>

            <div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
                <div id="statustable" style="float: left;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
                    <table style='height: 100%'>
                        <tbody>
                            <tr>
                                <tr>
                                    <td style='height: 100%;font-size:18px'>
                                        <label style="font-family:Verdana;">服务进度:</label>
                                        <label style="font-family:Verdana;">
                                            <span id="addStatus" name="statusvi" class="nvstatusview">开单</span>
                                        </label>
                                        <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                                        <label style="font-family:Verdana;">
                                            <span id="repairStatus" name="statusvi" class="nvstatusview">施工</span>
                                        </label>
                                        <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                                        <label style="font-family:Verdana;">
                                            <span id="finishStatus" name="statusvi" class="nvstatusview">完工</span>
                                        </label>
                                        <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                                        <label style="font-family:Verdana;">
                                            <span id="settleStatus" name="statusvi" class="nvstatusview">结算</span>
                                        </label>
                                    </td>
                                </tr>
                        </tbody>
                    </table>
                </div>
                <div id="sellForm" class="form" style="float:right;height: 100%;padding-right: 20px;">
                    <table style='height: 100%'>
                        <tbody>
                            <tr>
                                <td style='height: 100%'>
                                    <label>总金额：</label>
                                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" id="totalAmt" name="totalAmt" />
                                    <label>优惠金额：</label>
                                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" id="totalPrefAmt" name="totalPrefAmt" />
                                    <label>小计金额：</label>
                                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" id="totalSubtotal" name="totalSubtotal" />

                                    <div style='display: none'>
                                        <input class="nui-hidden" enabled="false" id="packageSubtotal" name="packageSubtotal" />
                                        <input class="nui-hidden" enabled="false" id="packagePrefAmt" name="packagePrefAmt" />
                                        <input class="nui-hidden" enabled="false" id="itemSubtotal" name="itemSubtotal" />
                                        <input class="nui-hidden" enabled="false" id="itemPrefAmt" name="itemPrefAmt" />
                                        <input class="nui-hidden" enabled="false" id="partSubtotal" name="partSubtotal" />
                                        <input class="nui-hidden" enabled="false" id="partPrefAmt" name="partPrefAmt" />
                                        <input class="nui-hidden" enabled="false" id="ycAmt" name="ycAmt" />
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="advancedCardTimesWin" class="nui-window" title="" style="width:550px;height:200px;" showModal="false" showHeader="false" allowResize="false" allowDrag="false">
                <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" iconCls="" plain="true" onclick="showCardTimes()" id="auditBtn">
                                    <span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="cardTimesGrid" class="nui-datagrid" style="width:100%;height:95%;" selectOnLoad="true" showPager="false" dataField="data" idField="id" allowCellSelect="true" editNextOnEnterKey="true" url="">
                        <div property="columns">
                            <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
                            <div field="prdtType" name="prdtType" width="60" headerAlign="center" header="产品类别"></div>
                            <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总次数"></div>
		                    <div field="useTimes" name="useTimes" width="60" headerAlign="center" header="已使用次数"></div>
                            <div field="doTimes" name="doTimes" width="70" headerAlign="center" header="使用中次数"></div>
                            <div field="canUseTimes" name="canUseTimes" width="70" headerAlign="center" header="可使用次数"></div>
                            <div field="cardTimesOpt" name="cardTimesOpt" width="60" headerAlign="center" header="操作"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="advancedMemCardWin" class="nui-window" title="" style="width:500px;height:200px;" showModal="false" showHeader="false" allowResize="false" allowDrag="false">
                <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" iconCls="" plain="true" onclick="showCard()" id="auditBtn">
                                    <span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="memCardGrid" class="nui-datagrid" style="width:100%;height:95%;" selectOnLoad="true" showPager="false" dataField="data" onrowdblclick="addSelectPart" allowCellSelect="true" editNextOnEnterKey="true" url="">
                        <div property="columns">
                            <div field="cardName" name="cardName" width="100" headerAlign="center" header="卡名称"></div>
                            <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="余额"></div>
                            <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="储值日期" dateFormat="yyyy-MM-dd"></div>
                            <div field="periodValidity" name="periodValidity" width="100" headerAlign="center" header="到期日期" dateFormat="yyyy-MM-dd"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="carCheckInfo" class="nui-window" title="" style="width:400px;height:200px;" showModal="false" showHeader="false" allowResize="false" allowDrag="false">
                <div class="nui-fit" id="show1">
                    <table style="width: 100%;background-color: #eef1f4">
                        <tr style="height: 40px;">
                            <td class="">
                                <label id="lastCheckInfo1" style="color: #9e9e9e;"></label>
                            </td>

                            <td class="">
                                <label id="lastCheckInfo2"></label>
                            </td>

                            <td class="">
                                <label id="lastCheckInfo3"></label>
                            </td>

                            <td class="">
                                <a class="nui-button  mini-button-info" iconCls="" plain="false" onclick="viewLastCheck()" id="lastCheckInfo4" style="display: none">查看</a>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 100%;margin-top:20px; ">
                        <tr>
                            <td class="">
                                <label id="checkStatus1" class="showhealthcss">未派工</label>
                            </td>

                            <td class="">
                                <label id="checkStatus2" class="showhealthcss">已派工</label>
                            </td>

                            <td class="">
                                <label id="checkStatus3" class="showhealthcss">施工中</label>
                            </td>

                            <td class="">
                                <label id="checkStatus4" class="showhealthcss">已完工</label>
                            </td>
                        </tr>
                    </table>
                    <div align="center" style="margin-top:20px; " id="checkStatusButton1">
                        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="MemSelectCancel(2)" id="">
                            <span style="line-height: 30px;">车况派工</span>
                        </a>
                        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="showHealth()" id="">
                            <span style="line-height: 30px;">取消</span>
                        </a>
                    </div>

                    <div align="center" style="margin-top:20px;display: none; " id="checkStatusButton2">
                        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="newCheckMain()" id="">
                            <span style="line-height: 30px;">车况查看</span>
                        </a>
                        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="showHealth()" id="">
                            <span style="line-height: 30px;">取消</span>
                        </a>
                    </div>
                </div>


                <div class="nui-fit" id="show2" style="display: none;">

                    <table style="width: 100%;margin-top:20px; ">
                        <tr>
                            <td class="" style="float: right;">
                                <label>选择检查人</label>
                            </td>

                            <td class="">
                                <input name="checkManId" id="checkManId" style="width:150px;" class="nui-combobox " textField="empName" valueField="empId" emptyText="请选择..." url="" allowInput="true" required="true" showNullItem="false" valueFromSelect="true" nullItemText="请选择..." />
                            </td>
                        </tr>
                    </table>
                    <div align="center" style="margin-top:20px; ">
                        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectOk" id="">
                            确定
                        </a>

                        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectCancel(1)" id="">
                            取消
                        </a>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                var boxServiceTypeId = [{
                    id: 1,
                    text: "厂外维修"
                }, {
                    id: 2,
                    text: "厂内翻新"
                }, {
                    id: 3,
                    text: "厂外返修"
                }];
                var QD = [{
                    id: 1,
                    text: "FWD"
                }, {
                    id: 2,
                    text: "RWD"
                }, {
                    id: 3,
                    text: "4WD"
                }];
                nui.parse();
            </script>
        </body>

        </html>