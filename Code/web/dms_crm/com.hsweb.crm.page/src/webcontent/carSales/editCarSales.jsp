<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 15:39:18
  - Description:
-->

    <head>
        <title>编辑整车销售</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
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
        
        .auto-style1 {
            height: 31px;
        }
        
        .td_title {
            width: 90px;
            text-align: right;
        }
        
        .style1 {
            width: 95px;
            text-align: right;
        }
        
        .style2 {
            width: 80px;
        }
        
        .style3 {
            width: 132px;
        }
        
        .style4 {
            width: 81px;
            text-align: right;
        }
        
        .style5 {
            width: 81px;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap!important;
        }
    </style>

    <body>
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;提交</a>
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;作废</a>
            <a class="nui-button" iconCls="" plain="true" onclick="auditAndcase(1)" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
            <a class="nui-button" iconCls="" plain="true" onclick="auditAndcase(2)" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>
            <a class="nui-button" iconCls="" plain="true" onclick="caseMsg()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;结案</a>
            <a class="nui-button" iconCls="" plain="true" onclick="auditAndcase(4)" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;反结案</a>
            <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选车</a>
            <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
            <a class="nui-button" iconCls="" plain="true" onclick="registration()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;车辆上牌</a>
            <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="onPrint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
            <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore">
                <span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

            <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                <li iconCls="" onclick="unfinish()" id="addBtn">返单</li>
                <li iconCls="" onclick="upload()" id="ExpenseAccount1">车辆图片</li>
            </ul>
        </div>
        <table cellpadding="0" cellspacing="0" style="line-height: 27px; padding-top: 4px; padding-left: 0px;">
            <tr>
                <td class="td_title">单据编号：
                </td>
                <td>
                    <input id="txtDocumentId" required="true" value="自动编号" style="width: 110px;" class="nui-textbox"="true" />
                </td>
                <td class="td_title">单据日期：
                </td>
                <td>
                    <input id="txtDocumentDate" editable="false" name="txtDocumentDate" class="nui-datepicker" style="width: 110px" />
                </td>
                <td class="td_title">预交日期：
                </td>
                <td>
                    <input id="txtReserveGiveDate" editable="false" name="txtReserveGiveDate" class="nui-datepicker" style="width: 110px" />
                </td>
                <td class="td_title">客户名称：
                </td>
                <td>
                    <input class="nui-combobox" id="txtCustName" style="width: 120px;" validtype="equals" editable="false">
                </td>
            </tr>
            <tr>
                <td align="right" class="auto-style1">销售顾问：
                </td>
                <td class="auto-style1">
                    <input class="nui-combobox" id="cmbBusinessMan" style="width: 120px;" validtype="equals" editable="false">
                </td>
                <td align="right" class="auto-style1">联系人：
                </td>
                <td class="auto-style1">
                    <input id="txtLinkMan" style="width: 140px;" class="nui-textbox" />
                </td>
                <td align="right" class="auto-style1">手机号码：
                </td>
                <td class="auto-style1" colspan="3">
                    <input id="txtMovePhone"="" style="width: 110px;" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td align="right">购车方式：
                </td>
                <td>
                    <input class="nui-combobox" id="cmbAutoBuyway" style="width: 120px;" validtype="equals" editable="false">
                </td>
                <td align="right">合同号：
                </td>
                <td>
                    <input id="txtContractNum" class="nui-textbox" style="width: 140px;" />
                </td>
                <td align="right">是否开票：
                </td>
                <td>
                    <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                </td>
                <td align="right">票据类型：
                </td>
                <td>
                    <input class="nui-combobox" id="cmbBillSort" style="width: 120px;" validtype="equals" editable="false">
                </td>
            </tr>
            <tr>
                <td align="right">发票号码：
                </td>
                <td colspan="3">
                    <input id="txtBillNum" style="width: 285px;" class="nui-textbox" />
                </td>
                <td align="right">开票客户：
                </td>
                <td colspan="5">
                    <input id="txtBillCust" class="nui-textbox" style="width: 100%;" />
                </td>

            </tr>
            <tr>
                <td align="right">结算备注：
                </td>
                <td colspan="9">
                    <input id="txtSettleRem" class="nui-textarea" style="width: 820px;height:40px" multiline="true" />
                </td>
            </tr>
        </table>
        <div class="nui-fit">
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;">
                <div title="精品加装">
                    <div class="mini-splitter" style="width:100%;height:100%;">
                        <div size="30%" showCollapseButton="true">
                            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                精品名称：<input class="nui-textbox"><a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            </div>
                            <div class="nui-fit" id="hhhh">
                                <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                    allowCellWrap="true" url="">
                                    <div property="columns">
                                        <div type="checkcolumn">选择</div>
                                        <div field="" name="" width="100px" headerAlign="center" header="精品名称"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div showCollapseButton="true">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="100px" headerAlign="center" header="精品名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="收费类型"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="数量"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="单价"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="金额"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="成本金额"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="备注内容"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="购车计算">
                    <iframe id="caCalculation" src="" style="width: 100%;height: 100%"></iframe>
                </div>
                <div title="保险信息">
                    <iframe id="carInsurance" src="" style="width: 100%;height: 100%"></iframe>
                </div>
                <div title="费用信息">
                    <div class="mini-splitter" style="width:100%;height:100%;">
                        <div size="30%" showCollapseButton="true">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="checkcolumn">选择</div>
                                    <div field="" name="" width="100px" headerAlign="center" header="费用项目名称"></div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="true">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:50%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="100px" headerAlign="center" header="状态"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="费用名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="报销金额"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="备注"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="登记人"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="登记时间"></div>
                                </div>
                            </div>
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:50%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="100px" headerAlign="center" header="状态"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="费用名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="成本金额（报销金额）"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="备注内容"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="登记人"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="登记时间"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="交车信息">

                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            var webBaseUrl = webPath + contextPath + "/";
            document.getElementById("caCalculation").src = webBaseUrl + "page/carSales/caCalculation.jsp";
            document.getElementById("carInsurance").src = webBaseUrl + "com.hsweb.RepairBusiness.CarInsuranceDetail.flow";

            function registration() {
                nui.open({
                    url: webPath + contextPath + "/page/carSales/vehicleRegistration.jsp?token=" + token,
                    title: "车辆上牌",
                    width: "880px",
                    height: "290px",
                    onload: function() {
                        var iframe = this.getIFrameEl();
                    },
                    ondestroy: function(action) {

                    }
                });
            }

            function caseMsg() {
                nui.open({
                    url: webPath + contextPath + "/page/carSales/salesReview.jsp?token=" + token,
                    title: "销售结案审核",
                    width: "880px",
                    height: "700px",
                    onload: function() {
                        var iframe = this.getIFrameEl();
                    },
                    ondestroy: function(action) {

                    }
                });
            }
        </script>
    </body>

    </html>