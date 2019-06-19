<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

<head>
    <title>厂家返利编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=webPath + contextPath%>/sales/base/js/sFactoryRebateDet.js?v=1.2.6"></script>
    <style>
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .td_title {
            width: 6%;
            text-align: right;
        }

        .td_ctrl {
            width: 13%;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar">
        <a class="nui-button" iconCls="" plain="true" onclick="save()" id="deletBtn"><span
                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()" id="deletBtn"><span
                class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
    </div>
    <div class="nui-toolbar" style="border:0px;" id="form1">
        <input id="id" name="id"class="nui-textbox" enabled="false" visible="false" />
        <table cellpadding="0" cellspacing="0" style="padding:5px 20px;">
            <tr style="height: 35px;">
                <td class="td_title">单据编号：
                </td>
                <td class="td_ctrl">
                    <input id="serviceCode"name="serviceCode" style="width: 100%" class="nui-textbox" enabled="false" />
                </td>
                <td class="td_title">返利日期：
                </td>
                <td class="td_ctrl">
                    <input id="rebateDate" name="rebateDate" style="width: 100%" class="nui-datepicker" />
                </td>

                <td class="td_title">厂家名称：
                </td>
                <td class="td_ctrl">
                    <input id="guestFullName" name="guestFullName" class="nui-textbox" visible="false"
                        enabled="false" />
                    <input id="guestId" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." style="width: 100%"
                        onbuttonclick="selectSupplier('guestId',1)" selectOnFocus="true" onvaluechanged="onSearch()"/>
                </td>
                <td class="td_title" style="text-align: right">经办人：
                </td>
                <td class="td_ctrl">
                    <input class="nui-combobox" id="operator" name="operator" style="width: 100%;" valueField="empName"
                        textField="empName" />
                </td>
            </tr>
            <tr style="height: 35px;">
                <td style="text-align: right">返利政策：
                </td>
                <td>
                    <input id="rebateId" name="rebateId" class="nui-combobox" style="width: 100%;" dataField="list"
                        valueField="id" textField="name" />
                </td>

                <td style="text-align: right">备注：
                </td>
                <td colspan="5">
                    <input id="remark" name="remark" style="width: 100%; " class="nui-textbox" multiline="true" />
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">

        <div class="nui-splitter" vertical="false" style="width:100%;height:100%;">
            <div size="40%" showCollapseButton="true">
                <div class="nui-toolbar">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

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
                    <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd"
                        showTime="false" showOkButton="false" showClearButton="false" visible="false" />
                    <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd"
                        showTime="false" showOkButton="false" showClearButton="false" visible="false" />
                    <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox" visible="false" />
                    <!-- <input id="searchGuestId" class="nui-buttonedit" emptyText="请选择供应商..."
                        onbuttonclick="selectSupplier('searchGuestId',2)" selectOnFocus="true" /> -->
                    <input id="carModelName" name="carModelName" width="150px" emptyText="车型名称" class="nui-textbox" />
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span
                            class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                </div>
                <div class="nui-fit">
                    <div id="leftGrid" dataField="cssCheckEnter" class="nui-datagrid" style="width: 100%; height: 100%;"
                        multiSelect="true" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"
                        selectOnLoad="false" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                        totalField="page.count">
                        <div property="columns">
                            <div type="checkcolumn"></div>
                            <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                            <div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>
                            <!-- <div field="" headerAlign="center" allowSort="true" width="100px">整车编号</div> -->
                            <div field="carFrameNo" headerAlign="center" allowSort="true" width="100px">车架号(VIN)</div>
                            <div field="carModelName" headerAlign="center" allowSort="true" width="100px">车型名称</div>
                            <div field="guestFullName" name="guestFullName" width="100" headerAlign="center" header="供应商"></div>  
                            <div field="remark" headerAlign="center" allowSort="true" width="100px">备注</div>
                        </div>
                    </div>
                </div>

            </div>
            <div showCollapseButton="true">
                <input name="frameColorId" id="frameColorId" class="nui-combobox" textField="name" valueField="customid"
                    allowInput="true" visible="false" />
                <input name="interialColorId" id="interialColorId" class="nui-combobox" textField="name"
                    valueField="customid" allowInput="true" visible="false" />
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="list"
                    sortMode="client" allowCellSelect="true" allowCellEdit="true" showModified="false"
                    style="width: 100%; height: 100%;" pageSize="20" pageList='[10,20,50,100]' showPageInfo="false"
                    totalField="page.count" showSummaryRow="true" showPager="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                        <!-- <div field="" headerAlign="center" allowSort="true" width="100px">整车编号</div> -->
                        <div field="enterId" headerAlign="center" allowSort="true" visible="false"></div>
                        <div field="carModelId" headerAlign="center" allowSort="true" visible="false"></div>
                        <div field="vin" headerAlign="center" allowSort="true" width="100px">车架号(VIN)</div>
                        <div field="carModelName" headerAlign="center" allowSort="true" width="100px">车型名称</div>
                        <div field="frameColorId" headerAlign="center" allowSort="true" width="100px">车身颜色</div>
                        <div field="interialColorId" headerAlign="center" allowSort="true" width="100px">内饰颜色</div>
                        <!-- <div field="" headerAlign="center" allowSort="true" width="100px">进货日期</div> -->
                        <div field="orderPrice" headerAlign="center" allowSort="true" width="100px" >进价</div>
                        <div field="rebateAmt" headerAlign="center" allowSort="true" width="100px" summaryType="sum">返利金额
                            <input property="editor" class="nui-textbox" vtype="float" />
                        </div>
                        <div field="remark" headerAlign="center" allowSort="true" width="100px">备注
                            <input property="editor" class="nui-textarea" />
                        </div>
                        <!-- <div field="" headerAlign="center" allowSort="true" width="100px">操作</div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        nui.parse();

        // function edit(e) {
        //     var tit = null;
        //     if (e == 1) {
        //         tit = '新增';
        //     } else {
        //         tit = '修改';
        //     }
        //     nui.open({
        //         url: webPath + contextPath + '/page/car/xiaoshouhuifang_det.jsp',
        //         title: tit,
        //         width: 380,
        //         height: 250,
        //         onload: function () {
        //             var iframe = this.getIFrameEl();
        //             iframe.contentWindow.setData(row);
        //         },
        //         ondestroy: function (action) {
        //             visitHis.reload();
        //         }
        //     });
        // }
    </script>
</body>

</html>