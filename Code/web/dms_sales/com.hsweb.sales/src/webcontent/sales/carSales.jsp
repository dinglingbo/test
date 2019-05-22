<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
        - Author(s): Administrator
        - Date: 2019-05-05 14:52:47
        - Description:
        -->

    <head>
        <title>整车销售</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%=request.getContextPath()%>/sales/sales/js/carSales.js?v=1.0.4"></script>
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
        
        .td_title {
            width: 65px;
            text-align: right;
        }
    </style>

    <body>
        <input class="nui-hidden" id="typeMsg" name="typeMsg" value='<b:write property="typeMsg"/>' />
        <div class="nui-toolbar" style="padding:2px;height:48px;position: relative;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">快速查询：</label>
                        <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>

                        <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                            <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                            <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                            <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                            <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                        </ul>
                        <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>
                        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch(12)" id="type">所有</li>
                            <li iconCls="" onclick="quickSearch(13)" id="type12">草稿</li>
                            <li iconCls="" onclick="quickSearch(14)" id="type12">待审</li>
                            <li iconCls="" onclick="quickSearch(15)" id="type12">已审</li>
                            <li iconCls="" onclick="quickSearch(16)" id="type12">作废</li>
                        </ul>
                        <input class="nui-combobox" id="searchType" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
                        <input class="nui-textbox" id="textValue" emptyText="输入查询条件" width="120" onenter="onenterSearch(this.value)" />
                        <!-- <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox" />

                        <input id="" name="" width="80px" emptyText="车型名称" class="nui-textbox" /> -->

                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(1)" id="addBtn" visible="false"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="editBtn" visible="false"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="deletBtn" visible="false"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="audit" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="auditno" visible="false"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="case" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;结案</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="addAndEdit(2)" id="csaeno" visible="false"><span class="fa fa-close fa-lg"></span>&nbsp;反结案</a>

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" visible="false" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="serviceCode" name="serviceCode" width="100px" headerAlign="center" header="工单号"></div>
                    <div field="status" name="status" width="50px" headerAlign="center" header="状态"></div>
                    <div field="guestFullName" name="guestFullName" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="orderDate" name="orderDate" width="100px" headerAlign="center" header="订车日期"></div>
                    <div field="carModelName" name="carModelName" width="100px" headerAlign="center" header="车型名称"></div>
                    <div field="submiPlanDate" name="submiPlanDate" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="saleAdvisor" name="saleAdvisor" width="100px" headerAlign="center" header="销售顾问"></div>
                    <div field="saleAmt" name="saleAmt" width="100px" headerAlign="center" header="车辆销价"></div>
                    <div field="advanceChargeAmt" name="advanceChargeAmt" width="100px" headerAlign="center" header="应收定金"></div>
                    <div field="receivedDeposit" name="receivedDeposit" width="100px" headerAlign="center" header="已收定金"></div>
                    <div field="calculateField" name="calculateField" width="100px" headerAlign="center" header="应收余款"></div>
                </div>
            </div>
            <div id="mainGrid2" class="nui-datagrid" visible="false" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="guestFullName" name="guestFullName" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="carModelName" name="carModelName" width="100px" headerAlign="center" header="车型"></div>
                    <div field="submiPlanDate" name="submiPlanDate" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="serviceCode" name="serviceCode" width="100px" headerAlign="center" header="工单号"></div>
                    <div field="status" name="status" width="100px" headerAlign="center" header="单据状态"></div>
                </div>
            </div>
            <div id="mainGrid3" visible="false" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="saleAdvisor" name="saleAdvisor" width="100px" headerAlign="center" header="销售顾问"></div>
                    <div field="guestFullName" name="guestFullName" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="carModelName" name="carModelName" width="100px" headerAlign="center" header="车型"></div>
                    <div field="submitTrueDate" name="submitTrueDate" width="100px" headerAlign="center" header="销售日期"></div>
                    <div field="submiPlanDate" name="submiPlanDate" width="100px" headerAlign="center" header="交车日期"></div>
                    <div field="financialEndDate" name="financialEndDate" width="100px" headerAlign="center" header="结案日期"></div>
                    <div field="financialEndMan" name="financialEndMan" width="100px" headerAlign="center" header="结案人"></div>
                    <div field="serviceCode" name="serviceCode" width="100px" headerAlign="center" header="工单号"></div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>