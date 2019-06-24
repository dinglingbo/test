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
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%= request.getContextPath() %>/sales/sales/js/editCarSales.js?v=1.1085" type="text/javascript"></script>

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
            width:70px;
            text-align:right;
        }
         .auto-style2 {
            height: 31px;
            width:90px;
            text-align:right;
        }       
        
        .td_title {
            width: 100px;
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
        
        .tbText {
            text-align: right;
            width: 15%;
        }
        
        .tbInput {
            width: 30%;
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
         .statusview{background:#78c800; color:#fff; padding:3px 20px; border-radius:20px;}
        .nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}
    </style>

    <body>
        <input class="nui-hidden" id="type">
        <input class="nui-hidden" name="typeMsg" id="typeMsg" />
        <input class="nui-hidden" name="agentGrossProfit" id="agentGrossProfit" />
        <div class="nui-toolbar" style="padding:2px;position: relative;">
            <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
                <tr>
                    <td class="btn">
                        <div class="nui-autocomplete" emptyText="未匹配到数据...(输入的内容长度要求大于或是等于2)" style="width:380px;height: 50px !important;" popupWidth="600" textField="text" valueField="id" searchField="key" multiSelect="false" id="search_key" dataField="data" placeholder="请输入...">
                            <div property="columns">
                                <div header="客户名称" field="fullName" width="30" headerAlign="center"></div>
                                <div header="客户手机" field="mobile" width="60" headerAlign="center"></div>
                            </div>
                        </div>
                        <input id="search_name" name="search_name" class="nui-textbox aa" emptyText="客户名称/手机号" visible="false" enabled="false" showClose="false" allowInput="true" />
                        <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                        <label style="font-family:Verdana;">工单号:</label>
                        <label id="servieIdEl" style="font-family:Verdana;"></label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <label style="font-family:Verdana;"><span id="repairStatus" name="statusvi" class="nvstatusview" >草稿</span></label>
                    </td>
                    <td style="text-align:right;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save(0)" id="saveBtn" visible="false"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="save(1)" id="submitBtn" visible="false"><span class="fa fa-save fa-lg"></span>&nbsp;提交</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="isSubmitCar()" id="submitCarBtn" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;交车</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="auditingSales()" id="audit" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="selectCar()" id="selectBtn" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;选车</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="caseMsg()" id="case" visible="false"><span class="fa fa-dollar fa-lg"></span>&nbsp;结案</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="delet()" id="invalidBtn" visible="false"><span class="fa fa-close fa-lg"></span>&nbsp;作废</a>
                        <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint">
                            <span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                        <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="salesOnPrint(1)" id="cash">打印现款购车计算表</li>
                            <li iconCls="" onclick="salesOnPrint(2)" id="loan">打印贷款购车计算表</li>
                            <li iconCls="" onclick="salesOnPrint(3)" id="confirm">打印交车确认单</li>
                            <li iconCls="" onclick="salesOnPrint(4)" id="contract">打印车辆销售合同</li>
                            <li iconCls="" onclick="salesOnPrint(5)" id="contract">打印出库放行条</li>
                        </ul>
                        <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore">
                            <span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

                        <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="backSingle()" id="unfinishBtn">返单</li>
                            <li iconCls="" onclick="registration()" id="addBtn">车辆上牌</li>
                        </ul>
                    </td>
                </tr>
            </table>

        </div>
        <form id="billForm">
            <input class="nui-hidden" name="id" />
            <input class="nui-hidden" name="isSettle" />
            <input class="nui-hidden" name="enterId" value="0" />
            <input class="nui-hidden" name="status" />
            <input class="nui-hidden" name="serviceCode" />
            <input class="nui-hidden" name="billTypeId" />
            <input class="nui-hidden" name="carModelId" />
            <input class="nui-hidden" name="isSubmitCar" />
            <input class="nui-hidden" name="guestId" />
            <input class="nui-hidden" id="handcartAmt" name="handcartAmt" />
            <input class="nui-hidden" id="carCost" name="carCost" />
            <input id="frameColorId" name="frameColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
            <input id="interialColorId" name="interialColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
            <table cellpadding="0" cellspacing="0" style="line-height: 30px; padding-top: 4px; padding-left: 0px;width:100%">
                <tr>
                    <td class="auto-style1">单据日期：</td>
                    <td>
                        <input id="orderDate" name="orderDate" class="nui-datepicker" style="width: 100%" enabled="false" format="yyyy-MM-dd HH:mm:ss" timeFormat="H:mm:ss" showTime="true" />
                    </td>
                    <td class="auto-style1">预交日期：</td>
                    <td>
                        <input id="submitPlanDate" name="submitPlanDate" class="nui-datepicker" style="width: 100%" format="yyyy-MM-dd HH:mm:ss" timeFormat="H:mm:ss" showTime="true" ondrawdate="onDrawDate" />
                    </td>
                    <td class="auto-style1">客户名称：</td>
                    <td>
                        <input class="nui-textbox" id="guestFullName" name="guestFullName" style="width: 100%;" enabled="false">
                    </td>
                    <td  class="auto-style1">销售顾问：
                    </td>
                    <td>
                        <input class="nui-combobox" id="saleAdvisorId" name="saleAdvisorId" style="width: 100%;" textField="empName" valueField="empId">
                    </td>
                    <td  class="auto-style1">联系人：
                    </td>
                    <td >
                        <input id="contactor" name="contactor" style="width: 100%;" class="nui-textbox" enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td  class="auto-style1">手机号码：
                    </td>
                    <td >
                        <input id="contactorTel" name="contactorTel" style="width: 100%;" class="nui-textbox" enabled="false" />
                    </td>
                    <td class="auto-style1">购车方式：</td>
                    <td>
                        <input class="nui-combobox" id="saleType" name="saleType" style="width: 100%;" textField="name" valueField="customid" onvaluechanged="changeBuyType">
                    </td>
                    <td class="auto-style1">合同号：
                    </td>
                    <td>
                        <input id="contractNo" name="contractNo" class="nui-textbox" style="width: 100%;" />
                    </td>
                    <td class="auto-style1">是否开票：
                    </td>
                    <td>
                        <input id="billSign" name="billSign" class="nui-combobox" style="width: 100%" data="isNot">
                    </td>
                    <td class="auto-style1">票据类型：</td>
                    <td>
                        <input name="billTypeId" id="billTypeId" class="nui-combobox width1" textField="name" valueField="customid" emptyText="请选择..." url="" allowInput="true" showNullItem="false" width="100%" valueFromSelect="true" onvaluechanged="" nullItemText="请选择..." />
                    </td>
                </tr>
                <tr>
                    <tr>
                        <td class="auto-style1">
                            <label>意向车型：</label>
                        </td>
                        <td colspan="3">
                            <input id="carModelName" name="carModelName" class="nui-buttonedit" style="width: 100%;" onbuttonclick="onButtonEdit" />
                        </td>
                        <td class="auto-style1">发票号码：</td>
                        <td>
                            <input id="billNo" name="billNo" style="width: 100%;" class="nui-textbox" />
                        </td>
                        <td class="auto-style1">开票客户：</td>
                        <td colspan="5">
                            <input id="billTitle" name="billTitle" class="nui-textbox" style="width: 100%;" />
                        </td>

                    </tr>
                    <tr>
                        <td class="auto-style1">结算备注：
                        </td>
                        <td colspan="9">
                            <input id="remark" name="remark" class="nui-textarea" style="width: 100%;height:40px" multiline="true" />
                        </td>
                    </tr>
            </table>
        </form>
        <div class="nui-fit" style="padding-top:10px">
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" onactivechanged="activechangedmain()" id="mainTabs" name="mainTabs">
                <div title="精品加装" id="gift" name="gift">
                    <div class="mini-splitter" style="width:100%;height:100%;">
                        <div size="30%" showCollapseButton="true">
                            <div class="nui-fit">
                                <div id="jpGrid" class="nui-datagrid" style="width:100%;height:100%;" multiSelect="true" selectOnLoad="false" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true"
                                    editNextOnEnterKey="true" allowCellWrap="true" url="">
                                    <div property="columns">
                                        <div type="checkcolumn" width="50px">选择</div>
                                        <div field="name" name="name" width="300px" headerAlign="center" header="精品名称"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div showCollapseButton="true">
                            <div id="jpDetailGrid" class="nui-datagrid" style="width:100%;height:100%;" oncellcommitedit="onCellCommitEdit" showSummaryRow="true" selectOnLoad="false" allowcelledit="true" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200]
                                dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap="true" url="">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div field="giftName" name="giftName" width="100px" headerAlign="center" header="精品名称"></div>
                                    <div field="receType" name="receType" width="100px" headerAlign="center" header="收费类型">
                                        <input class="nui-combobox" property="editor" vtype="float" data="costList" idField="id" textField="name" value="1">
                                    </div>
                                    <div field="qty" name="qty" width="80px" headerAlign="center" header="数量">
                                        <input class="nui-textbox" property="editor" vtype="float">
                                    </div>
                                    <div field="price" name="price" width="80px" headerAlign="center" header="单价">
                                        <input class="nui-textbox" property="editor" vtype="float">
                                    </div>
                                    <div field="amt" name="amt" width="80px" headerAlign="center" header="金额" summaryType="sum">
                                    </div>
                                    <div field="costAmt" name="costAmt" width="100px" headerAlign="center" header="成本金额">
                                        <input class="nui-textbox" property="editor" vtype="float">
                                    </div>
                                    <div field="remark" name="remark" width="140px" headerAlign="center" header="备注内容">
                                        <input class="nui-textarea" property="editor">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="购车计算" id="editForm" name="editForm">
                    <iframe id="caCalculation" src="" style="width: 100%;height: 100%"></iframe>
                </div>
                <div title="保险信息">
                    <form id="insuranceForm">
                        <table cellpadding="0" cellspacing="0" style="line-height: 27px; padding-top: 4px; padding-left: 0px;width: 100%">
                            <tr>
                                <td class="auto-style2">保险公司：</td>
                                <td class=""><input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..." width="100%" /></td>
                                <td class="auto-style2">销售人员：</td>
                                <td><input class="nui-combobox" id="saleManIds" name="saleManIds" emptyText="选择销售人员" dataField="data" valueField="empId" textField="empName" showNullItem="true" nullItemText="请选择..." multiSelect="true" width="100%" /></td>

                                <td class="auto-style2">
                                    <label>有效日期：</label>
                                </td>
                                <td>
                                    <input id="beginDate" name="beginDate" class="nui-datepicker" value="" format="yyyy-MM-dd " /> 至 <input id="endDate" name="endDate" class="nui-datepicker" value="" format="yyyy-MM-dd " />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style2">保费收取方式：</td>
                                <td class=""><input class="nui-combobox" name="settleTypeId" id="settleTypeId" valueField="id" textField="name" data="settleTypeIdList" dataField="settleTypeIdList" width="100%" /></td>
                                <td class="auto-style2">其他成本：</td>
                                <td><input class="nui-textbox" name="costAmt" id="costAmt" width="100%" vtype="float" onvaluechanged="changeCostAmt" /></td>
                                <td class="auto-style2">其他成本说明：</td>
                                <td class=""><input class="nui-textbox" name="costRemark" id="costRemark" enabled="true" width="100%" /></td>
                            </tr>
                        </table>
                    </form>
                    <div class="nui-fit">
                        <div id="detailGrid" datafield="list" class="nui-datagrid" style="width: 100%; height:100%;" showpager="false" sortmode="client" allowcelledit="true" allowcellselect="true" showSummaryRow="true" showModified="false">
                            <div property="columns">
                                <div type="indexcolumn" width="50" headeralign="center" align="center">序号</div>
                                <div field="insureTypeName" headeralign="center" align="center" visible="true" width="100">名称</div>
                                <div field="insureTypeId" headeralign="center" align="center" visible="false" width="100" header="险种ID"> </div>
                                <div field="insureNo" headeralign="center" align="center" visible="true" width="100" header="交强险/商业险单号"></div>
                                <div field="amt" name="amt" headeralign="center" align="center" visible="true" width="100" header="保司保费(售价/元)" summaryType="sum"></div>
                                <div field="rtnCompRate" name="rtnCompRate" headeralign="center" align="center" visible="true" width="100" header="保司返点(%)" summaryType="sum"></div>
                                <div field="rtnCompAmt" name="rtnCompAmt" headeralign="center" align="center" visible="true" width="100" header="保司返点金额(元)" summaryType="sum"></div>
                                <div field="rtnGuestRate" name="rtnGuestRate" headeralign="center" align="center" visible="true" width="100" header="客户返点(%)" summaryType="sum"></div>
                                <div field="rtnGuestAmt" name="rtnGuestAmt" headeralign="center" align="center" visible="true" width="100" header="客户返点金额(元)" summaryType="sum"></div>
                                <div field="remark" name="remark" headeralign="center" align="center" visible="true" width="150" header="备注"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="费用信息">
                    <div class="nui-toolbar" id="toolbar">
                        <div align="right">
                            <a class="nui-button" iconCls="" plain="true" onclick="costMsg()" id="costBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        </div>
                    </div>
                    <div class="nui-fit">
                        <div class="mini-splitter" style="width:100%;height:100%;">
                            <div size="30%" showCollapseButton="true">
                                <div id="costGrid" class="nui-datagrid" style="width:100%;height:100%;" multiSelect="true" selectOnLoad="false" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true"
                                    editNextOnEnterKey="true" allowCellWrap="true" url="">
                                    <div property="columns">
                                        <div type="checkcolumn" width="10px">选择</div>
                                        <div field="name" name="name" width="100px" headerAlign="center" header="费用项目名称"></div>
                                    </div>
                                </div>
                            </div>
                            <div showCollapseButton="true">
                                <div id="costDetailGrid" class="nui-datagrid" style="width:100%;height:50%;" oncellbeginedit="OnModelCellBeginEdit" oncellcommitedit="costCommitEdit" allowcelledit="true" selectOnLoad="false" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200]
                                    dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap="true" url="">
                                    <div property="columns">
                                        <div type="indexcolumn">序号</div>
                                        <div field="auditSign" name="auditSign" width="100px" headerAlign="center" header="状态" renderer="onIsNotRenderer" data="is_not"></div>
                                        <div field="costName" name="costName" width="100px" headerAlign="center" header="费用名称"></div>
                                        <div field="costAmt" name="costAmt" width="100px" headerAlign="center" header="报销金额">
                                            <input class="nui-textarea" property="editor" vtype="float">
                                        </div>
                                        <div field="remark" name="remark" width="100px" headerAlign="center" header="备注">
                                            <input class="nui-textarea" property="editor">
                                        </div>
                                        <div field="modifier" name="modifier" width="100px" headerAlign="center" header="登记人"></div>
                                        <div field="modifyDate" name="modifyDate" width="100px" headerAlign="center" header="登记时间"></div>
                                        <div field="action" name="action" width="100px" headerAlign="center" header="操作" visible="false"></div>
                                    </div>
                                </div>
                                <div id="costDetailGrid2" class="nui-datagrid" style="width:100%;height:50%;" oncellbeginedit="OnModelCellBeginEdit" oncellcommitedit="costCommitEdit" allowcelledit="true" selectOnLoad="false" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200]
                                    dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap="true" url="">
                                    <div property="columns">
                                        <div type="indexcolumn">序号</div>
                                        <div field="auditSign" name="auditSign" width="100px" headerAlign="center" header="状态" renderer="onIsNotRenderer" data="is_not"></div>
                                        <div field="costName" name="costName" width="100px" headerAlign="center" header="费用名称"></div>
                                        <div field="costAmt" name="costAmt" width="100px" headerAlign="center" header="成本金额（报销金额）">
                                            <input class="nui-textarea" property="editor" vtype="float">
                                        </div>
                                        <div field="remark" name="remark" width="100px" headerAlign="center" header="备注内容">
                                            <input class="nui-textarea" property="editor">
                                        </div>
                                        <div field="modifier" name="modifier" width="100px" headerAlign="center" header="登记人"></div>
                                        <div field="modifyDate" name="modifyDate" width="100px" headerAlign="center" header="登记时间"></div>
                                        <div field="action" name="action" width="100px" headerAlign="center" header="操作" visible="false"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="交车信息">
                    <form>
                        <table id="form1">
                            <tr>
                                <td class="tbText">交车人：</td>
                                <td class="tbInput">
                                    <input class="nui-combobox " id="submitCarMen" name="submitCarMen" style="width: 100%;" textField="empName" valueField="empId" />
                                </td>
                                <td class="tbText">交车日期：</td>
                                <td class="tbInput">
                                    <input class="nui-datepicker" id="submitTrueDate" name="submitTrueDate" style="width:100%" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="true" ondrawdate="onDrawSubmitTrueDate" />
                                </td>
                            </tr>
                            <tr>
                                <td class="tbText">钥匙数量：</td>
                                <td class="tbInput">
                                    <input class="nui-textbox" id="submitCarKeyQty" name="submitCarKeyQty" vtype="int" style="width:100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="tbText">交车备注：</td>
                                <td class="tbInput" colspan="3">
                                    <input class="nui-textarea" id="submitCarRemark" name="submitCarRemark" style="width:100%;height:100px;" />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var isNot = [{
                id: 0,
                text: "是"
            }, {
                id: 1,
                text: "否"
            }];

            nui.parse();
        </script>
    </body>

    </html>