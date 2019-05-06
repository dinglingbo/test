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
            width: 55px;
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
        <div id="main" data-options="region:'north'" style="height: 200px;" border="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选车</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;反结算</a>
                <a class="nui-button" iconCls="" plain="true" onclick="registration()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;车辆上牌</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-dollar fa-lg"></span>&nbsp;车辆图片</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="onPrint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
            </div>
            <table cellpadding="0" cellspacing="0" style="line-height: 27px; padding-top: 4px; padding-left: 0px;">
                <tr>
                    <td class="td_title">单据编号
                    </td>
                    <td>
                        <input id="txtDocumentId" required="true" value="自动编号" style="width: 110px;" class="nui-textbox" disabled="true" />
                    </td>
                    <td class="td_title">单据日期
                    </td>
                    <td>
                        <input id="txtDocumentDate" editable="false" name="txtDocumentDate" class="nui-datepicker" style="width: 110px" />
                    </td>
                    <td class="td_title">经办人
                    </td>
                    <td>
                        <input class="nui-combobox" id="cmbDealMan" style="width: 140px;" validtype="equals" editable="false">
                    </td>
                    <td class="td_title">预交日期
                    </td>
                    <td>
                        <input id="txtReserveGiveDate" editable="false" name="txtReserveGiveDate" class="nui-datepicker" style="width: 110px" />
                    </td>
                    <td class="td_title">客户名称
                    </td>
                    <td>
                        <input class="nui-combobox" id="txtCustName" style="width: 120px;" validtype="equals" editable="false">
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style1">客户性质
                    </td>
                    <td class="auto-style1">
                        <input id="txtKHXZ" disabled="disabled" style="width: 110px;" class="nui-textbox" />
                    </td>
                    <td align="right" class="auto-style1">业务员
                    </td>
                    <td class="auto-style1">
                        <input class="nui-combobox" id="cmbBusinessMan" style="width: 120px;" validtype="equals" editable="false">
                    </td>
                    <td align="right" class="auto-style1">联系人
                    </td>
                    <td class="auto-style1">
                        <input id="txtLinkMan" style="width: 140px;" class="nui-textbox" />
                    </td>
                    <td align="right" class="auto-style1">手机号码
                    </td>
                    <td class="auto-style1">
                        <input id="txtMovePhone" disabled="disabled" style="width: 110px;" class="nui-textbox" />
                    </td>
                    <td align="right" class="auto-style1">联系电话
                    </td>
                    <td class="auto-style1">
                        <input id="txtPhone" disabled="disabled" style="width: 120px;" class="nui-textbox" />
                    </td>
                </tr>
                <tr>
                    <td align="right">区域
                    </td>
                    <td>
                        <input id="txtArea" disabled="disabled" style="width: 110px;" class="nui-textbox" />
                    </td>
                    <td align="right">购车方式
                    </td>
                    <td>
                        <input class="nui-combobox" id="cmbAutoBuyway" style="width: 120px;" validtype="equals" editable="false">
                    </td>
                    <td align="right">合同号
                    </td>
                    <td>
                        <input id="txtContractNum" class="nui-textbox" style="width: 140px;" />
                    </td>
                    <td align="right">是否开票
                    </td>
                    <td>
                        <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                    </td>
                    <td align="right">票据类型
                    </td>
                    <td>
                        <input class="nui-combobox" id="cmbBillSort" style="width: 120px;" validtype="equals" editable="false">
                    </td>
                </tr>
                <tr>
                    <td align="right">发票号码
                    </td>
                    <td colspan="3">
                        <input id="txtBillNum" style="width: 285px;" class="nui-textbox" />
                    </td>
                    <td align="right">开票客户
                    </td>
                    <td colspan="5">
                        <input id="txtBillCust" class="nui-textbox" style="width: 480px;" />
                    </td>

                </tr>
                <tr>
                    <td align="right">结算备注
                    </td>
                    <td colspan="9">
                        <input id="txtSettleRem" class="nui-textbox" style="width: 820px;height:40px" multiline="true" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;">
                <div title="车辆信息">
                    <table style="line-height: 23px; padding-top: 10px;">
                        <tr>
                            <td class="td_title">车型名称
                            </td>
                            <td colspan="3">
                                <input id="cxks_combox" class="nui-combobox" style="width: 335px" />
                            </td>
                            <td class="td_title">车身颜色
                            </td>
                            <td>
                                <input id="txtAutoColor" style="width: 130px" class="nui-textbox" />
                            </td>
                            <td class="td_title">车内饰色
                            </td>
                            <td>
                                <input id="txtAutoSetcolor" style="width: 130px" class="nui-textbox" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">车辆配置
                            </td>
                            <td colspan="7">
                                <input id="txt_CLPZ" class="nui-textbox" style="width: 730px; height: 40px" multiline="true" />
                                <div style="display: none">
                                    <input id="sp_lx" class="nui-textbox" />
                                    <input id="sp_pp" class="nui-textbox" />
                                    <input id="sp_gearbox" class="nui-textbox" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">VIN码
                            </td>
                            <td>
                                <input id="txtVIN" style="width: 130px" disabled class="nui-textbox" />
                                <div style="display: none">
                                    <input id="txtAutoId" class="nui-textbox" />
                                </div>
                            </td>
                            <td align="right">发动机号
                            </td>
                            <td>
                                <input id="txtEngineNum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">合格证号
                            </td>
                            <td>
                                <input id="txtCertificationNum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">商检单号
                            </td>
                            <td>
                                <input id="txtInspectionNum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">关单号
                            </td>
                            <td>
                                <input id="txtCustomsNum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">钥匙号
                            </td>
                            <td>
                                <input id="txtKeyNum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">生产日期
                            </td>
                            <td>
                                <input id="txtProductionDate" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">出厂日期
                            </td>
                            <td>
                                <input id="txtReleaseDate" style="width: 130px" disabled class="nui-datepicker" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">提单号
                            </td>
                            <td>
                                <input id="txtPickBillnum" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">整车仓库
                            </td>
                            <td>
                                <input id="txtAutoStore" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                            <td align="right">货位
                            </td>
                            <td colspan="3">
                                <input id="txtAutoStoreposition" style="width: 130px" disabled class="nui-textbox" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">车辆售价
                            </td>
                            <td>
                                <input id="txtSailPrice" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="checkCarPrice(this)" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">代办费用
                            </td>
                            <td>
                                <input id="dbMoney" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">让利费用
                            </td>
                            <td>
                                <input id="rlMoney" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">装潢费用
                            </td>
                            <td>
                                <input id="zhMoney" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                        </tr>
                        <tr>
                            <td align="right">需收订金
                            </td>
                            <td>
                                <input id="txtMustDeposit" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">实收订金
                            </td>
                            <td>
                                <input id="txtActulMoney" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">保单费用
                            </td>
                            <td>
                                <input id="bxMoney" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                        </tr>
                        <tr>
                            <td align="right">付款方式
                            </td>
                            <td>
                                <input id="txtPayWay" style="width: 130px" disabled="disabled" class="nui-textbox" />
                            </td>
                            <td align="right">应收金额
                            </td>
                            <td>
                                <input id="txtShouldPay" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">实收金额
                            </td>
                            <td>
                                <input id="txtActualPay" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                            <td align="right">未收尾款
                            </td>
                            <td>
                                <input id="txtDue" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                            </td>
                        </tr>
                        <tr>
                            <td align="right" rowspan="2">备注
                            </td>
                            <td colspan="5" rowspan="2">
                                <input id="txtRemark" class="nui-textbox" style="width: 540px; height: 50px" multiline="true" />
                            </td>
                            <td align="right">交车日期
                            </td>
                            <td>
                                <input id="txtJCTime" style="width: 130px" disabled="disabled" class="nui-datepicker" />
                            </td>

                        </tr>
                        <tr>
                            <td align="right">交车人
                            </td>
                            <td>
                                <input id="txtJCMan" style="width: 130px" disabled="disabled" class="nui-textbox" />
                            </td>

                        </tr>
                        <tr>
                            <td align="right">交车备注
                            </td>
                            <td colspan="7">
                                <input id="txtJCRem" style="width: 735px;height:40px" multiline="true" disabled="disabled" class="nui-textbox" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div title="代办项目">
                    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                        <div title="center" region="center">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="70px" headerAlign="center" header="项目编号"></div>
                                    <div field="" name="" width="150px" headerAlign="center" header="项目名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="代办金额（元）"></div>
                                    <div field="" name="" width="80px" headerAlign="center" header="支出金额（元）"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="备注"></div>
                                </div>
                            </div>
                        </div>
                        <div title="当前选中的代办事项" region="east" showSplitIcon="true" width="450%">
                            <table style="width: 100%; line-height: 23px">
                                <tr>
                                    <td class="td_title">查询条件
                                    </td>
                                    <td colspan="3">
                                        <input id="cmbDbxm" class="nui-combobox" style="width: 360px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">项目编号
                                    </td>
                                    <td>
                                        <input id="db_AgentitemId" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                    <td align="right">项目名称
                                    </td>
                                    <td>
                                        <input id="db_AgentitemName" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">代办金额
                                    </td>
                                    <td>
                                        <input id="db_AgentMoney" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 100px;" value="0" />元
                                    </td>
                                    <td align="right">支出金额
                                    </td>
                                    <td>
                                        <input id="db_ZCMoney" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 100px;" value="0" />元
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">备注
                                    </td>
                                    <td colspan="3">
                                        <input id="db_Remark" style="width: 360px;height:50px" class="nui-textbox" multiline="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right" style="padding-right: 30px">
                                        <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="让利项目">
                    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                        <div title="center" region="center">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="70px" headerAlign="center" header="项目编号"></div>
                                    <div field="" name="" width="150px" headerAlign="center" header="项目名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="让利金额（元）"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="备注"></div>
                                </div>
                            </div>
                        </div>
                        <div title="当前选中的代办事项" region="east" showSplitIcon="true" width="450%">
                            <table style="width: 100%; line-height: 23px">
                                <tr>
                                    <td class="td_title">查询条件
                                    </td>
                                    <td colspan="3">
                                        <input id="cmbDbxm" class="nui-combobox" style="width: 360px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">项目编号
                                    </td>
                                    <td>
                                        <input id="db_AgentitemId" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                    <td align="right">项目名称
                                    </td>
                                    <td>
                                        <input id="db_AgentitemName" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">让利金额
                                    </td>
                                    <td colspan="3">
                                        <input id="zh_CarBrand" style="width: 360px" disabled class="nui-textbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">备注
                                    </td>
                                    <td colspan="3">
                                        <input id="db_Remark" style="width: 360px;" class="nui-textbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right" style="padding-right: 30px">
                                        <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="装潢明细">
                    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                        <div title="center" region="center">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="110px" headerAlign="center" header="货品代码"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="货品名称"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="汽车品牌"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="通用车型"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="产地"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="计量单位"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="数量"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="单价(元)"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="金额(元)"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="成本(元)"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="备注"></div>
                                </div>
                            </div>
                        </div>
                        <div title="当前选中的工时项目" region="east" showSplitIcon="true" width="450%">
                            <table style="width: 100%; line-height: 23px">
                                <tr>
                                    <td class="td_title">查询条件
                                    </td>
                                    <td colspan="3">
                                        <input id="cmbDbxm" class="nui-combobox" style="width: 360px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">配件代码
                                    </td>
                                    <td>
                                        <input id="zh_ProductCode" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                    <td align="right">配件名称
                                    </td>
                                    <td>
                                        <input id="zh_ProductName" style="width: 130px" disabled class="nui-textbox" />
                                        <span id="zh_ProductID" style="display: none"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">适用品牌
                                    </td>
                                    <td colspan="3">
                                        <input id="zh_CarBrand" style="width: 360px" disabled class="nui-textbox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">通用车型
                                    </td>
                                    <td>
                                        <input id="zh_CarSort" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                    <td align="right">产地
                                    </td>
                                    <td>
                                        <input id="zh_ProductHome" style="width: 130px" disabled class="nui-textbox" />
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">数量
                                    </td>
                                    <td>
                                        <input id="zh_Amount" numbertype="Amount" min="0" style="width: 80px;" class="nui-textbox usernumber" onchange="checkInt(this)" /> 【
                                        <span id="zh_ProductUnit"></span>】
                                    </td>
                                    <td align="right">单价
                                    </td>
                                    <td>
                                        <input id="txtZHUnitPrice" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="countPrice(this)" style="width: 100px;" value="0" />元
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">金额
                                    </td>
                                    <td>
                                        <input id="txtZHPrice" numbertype="Money" min="0" disabled class="nui-textbox usernumber" style="width: 100px;" value="0" />元
                                    </td>
                                    <td align="right">成本
                                    </td>
                                    <td>
                                        <input id="txtZHCost" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 100px;" value="0" />元
                                        <div style="display: none">
                                            <input id="txtperCost" class="nui-textbox" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">备注
                                    </td>
                                    <td colspan="3">
                                        <input id="zh_remDetal" style="width: 360px;" multiline="true" class="nui-textbox" onblur="remblur()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right" style="padding-right: 30px">
                                        <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="保险信息">
                    <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                        <div title="center" region="center">
                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="" name="" width="70px" headerAlign="center" header="保险险种"></div>
                                    <div field="" name="" width="150px" headerAlign="center" header="保险费"></div>
                                    <div field="" name="" width="100px" headerAlign="center" header="备注"></div>
                                    <div field="" name="" width="110px" headerAlign="center" header="是否打印"></div>
                                </div>
                            </div>
                        </div>
                        <div region="east" showSplitIcon="true" width="450%" title="保险信息">
                            <table style="width: 100%; line-height: 23px">
                                <tr>
                                    <td class="td_title">保险险种
                                    </td>
                                    <td colspan="3">
                                        <input id="cmbDbxm" class="nui-combobox" style="width: 360px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">保险种类
                                    </td>
                                    <td>
                                        <input id="txtbxzl" class="nui-textbox" style="width: 160px" />
                                    </td>
                                    <td align="right">保险费
                                    </td>
                                    <td>
                                        <input id="txtbxbxf" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 135px;" value="0" />元
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">备注
                                    </td>
                                    <td colspan="3">
                                        <input id="txtbxbz" class="nui-textbox" multiline="true" style="width: 360px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">是否打印
                                    </td>
                                    <td>
                                        <input id="isPrint" class="nui-checkbox" editable="false" style="width: 30px" />
                                    </td>
                                    <td colspan="2" style="text-align: right; padding-right: 5px">
                                        <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="按揭信息">
                    <div style="padding-top: 10px;">
                        <table>
                            <tr>
                                <td class="td_title">按揭贷方
                                </td>
                                <td>
                                    <input id="txtCreditName" class="nui-combobox" style="width: 120px" />
                                </td>
                                <td class="td_title">借款形式
                                </td>
                                <td>
                                    <input id="txtCreditWay" class="nui-textbox" style="width: 120px" />
                                </td>
                                <td class="td_title">借款期数
                                </td>
                                <td>
                                    <input id="txtCreditTime" class="nui-textbox" style="width: 120px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">贷款金额
                                </td>
                                <td>
                                    <input id="txtCreditMoney" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 85px;" value="0" />元
                                </td>
                                <td align="right">首付金额
                                </td>
                                <td>
                                    <input id="txtFirstMoney" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 85px;" value="0" />元
                                </td>
                                <td align="right">贷款毛利
                                </td>
                                <td>
                                    <input id="txtCreditGross" numbertype="Money" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 85px;" value="0" />元
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div title="购车定金">
                    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    </div>
                    <div class="nui-fit">
                        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                            onshowrowdetail="onShowRowDetail" allowCellWrap="true" url="">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="" name="" width="150px" headerAlign="center" header="单据编号"></div>
                                <div field="" name="" width="150px" headerAlign="center" header="付款日期"></div>
                                <div field="" name="" width="150px" headerAlign="center" header="收取订金(元)"></div>
                                <div field="" name="" width="150px" headerAlign="center" header="经办人"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();

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
        </script>
    </body>

    </html>