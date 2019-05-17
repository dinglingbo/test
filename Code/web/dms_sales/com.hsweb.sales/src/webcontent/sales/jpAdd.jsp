<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 08:49:01
  - Description:
-->

    <head>
        <title>精品加装</title>
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
            width: 90px;
            text-align: right;
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
                        启始日期：<input id="sp_BirthDate" style="width: 100px" editable="false" class="nui-datepicker" />-<input id="sp_BirthDate" style="width: 100px" editable="false" class="nui-datepicker" />
                        <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>
                        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch()" id="type">所有</li>
                            <li iconCls="" onclick="quickSearch(12)" id="type12">已审</li>
                            <li iconCls="" onclick="quickSearch(12)" id="type12">未审</li>
                        </ul>


                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div class="mini-splitter" style="width:100%;height:100%;">
                <div size="20%" showCollapseButton="true">
                    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                        allowCellWrap="true" url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div field="" name="" width="100px" headerAlign="center" header="状态"></div>
                            <div field="" name="" width="100px" headerAlign="center" header="客户名称"></div>
                            <div field="" name="" width="100px" headerAlign="center" header="车架号(VIN)"></div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="true">
                    <fieldset id="fd9" style="width:99%;">
                        <legend><span>基本信息：</span></legend>
                        <table style="line-height: 23px; padding-top: 10px;width: 100%">
                            <tr>
                                <td class="td_title">
                                    销售类型：
                                </td>
                                <td>
                                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                                </td>
                                <td style="width: 150px;">
                                    销售单/库存车/客户编码：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                                </td>
                                <td class="td_title">
                                    车架号(VIN)：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                                </td>
                            </tr>
                            <tr>
                                <td class="td_title">
                                    车型：
                                </td>
                                <td colspan="3">
                                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                                </td>
                                <td class="td_title">
                                    销售单号：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                                </td>
                            </tr>
                            <tr>
                                <td class="td_title">
                                    应收金额：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                                </td>
                                <td class="td_title">
                                    实收金额：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                                </td>
                                <td class="td_title">
                                    客户名称：
                                </td>
                                <td>
                                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">备注：
                                </td>
                                <td colspan="5">
                                    <input id="db_Remark" style="width: 100%;height:100px" class="nui-textarea" multiline="true" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <div class="nui-fit">
                        <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;">
                            <div title="工时信息">
                                <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                    <table style="width:100%;">
                                        <tr>
                                            <td style="white-space:nowrap;">
                                                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                                                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                                                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-fit">
                                    <div class="mini-splitter" style="width:100%;height:100%;">
                                        <div size="70%" showCollapseButton="true">
                                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                                                allowCellWrap="true" url="">
                                                <div property="columns">
                                                    <div type="indexcolumn">序号</div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工时名称"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="金额小计"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="提成金额"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="收费类型"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工时"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工种"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="班组"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="承修人"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工时编码"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div showCollapseButton="true">
                                            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;float: right;" selectOnLoad="true" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true"
                                                editNextOnEnterKey="true" allowCellWrap="true" url="">
                                                <div property="columns">
                                                    <div type="indexcolumn">序号</div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工时名称"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="工种"></div>
                                                    <div field="" name="" width="100px" headerAlign="center" header="提成金额"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div title="精品出库">
                                2
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>