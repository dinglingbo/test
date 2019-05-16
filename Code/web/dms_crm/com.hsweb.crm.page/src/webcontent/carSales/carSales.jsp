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
                        <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>
                        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch()" id="type">所有</li>
                            <li iconCls="" onclick="quickSearch(12)" id="type12">草稿</li>
                        </ul>
                        <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox" />

                        <input id="" name="" width="80px" emptyText="车型名称" class="nui-textbox" />

                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn" visible="false"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="editBtn" visible="false"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn" visible="false"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="audit" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="auditno" visible="false"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="case" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;结案</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="csaeno" visible="false"><span class="fa fa-close fa-lg"></span>&nbsp;反结案</a>

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" visible="false" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="" name="" width="100px" headerAlign="center" header="工单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="状态"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="订车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="销售顾问"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车辆销价"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="应收定金"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="已收定金"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="应收余款"></div>
                </div>
            </div>
            <div id="mainGrid2" class="nui-datagrid" visible="false" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="" name="" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="预交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="工单号"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="单据状态"></div>
                </div>
            </div>
            <div id="mainGrid3" visible="false" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true"
                editNextOnEnterKey="true" allowCellWrap="true" url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="" name="" width="100px" headerAlign="center" header="销售顾问"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="客户名称"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="车型"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="销售日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="交车日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="结案日期"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="结案人"></div>
                    <div field="" name="" width="100px" headerAlign="center" header="工单号"></div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();

            var mainGrid = null;
            var mainGrid2 = null;
            var mainGrid3 = null;
            $(document).ready(function(v) {
                mainGrid = nui.get("mainGrid");
                mainGrid2 = nui.get("mainGrid2");
                mainGrid3 = nui.get("mainGrid3");
                if (nui.get("typeMsg").value == 1) {
                    mainGrid.setVisible(true);
                    nui.get("addBtn").setVisible(true);
                    nui.get("editBtn").setVisible(true);
                }
                if (nui.get("typeMsg").value == 2) {
                    mainGrid2.setVisible(true);
                    nui.get("audit").setVisible(true);
                    nui.get("auditno").setVisible(true);
                }
                if (nui.get("typeMsg").value == 3) {
                    mainGrid3.setVisible(true);
                    nui.get("case").setVisible(true);
                    nui.get("csaeno").setVisible(true);
                }
            });

            function add() {
                var tabsId = null;
                var text = null;
                if (nui.get("typeMsg").value == 1) {
                    tabsId = "12780";
                    text = "编辑销售管理";
                }
                if (nui.get("typeMsg").value == 2) {
                    tabsId = "12781";
                    text = "编辑销售单审核";
                }
                if (nui.get("typeMsg").value == 3) {
                    tabsId = "12782";
                    text = "编辑销售结案";
                }
                var item = {};
                item.id = tabsId;
                item.text = text;
                item.url = webPath + contextPath + "/page/carSales/editCarSales.jsp";
                item.iconCls = "fa fa-file-text";
                var params = {
                    typeMsg: nui.get("typeMsg").value
                };
                window.parent.activeTabAndInit(item, params);
            }
        </script>
    </body>

    </html>