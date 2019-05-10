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
        <title>销售回访</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
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
                    width: 90px;
                    text-align: right;
                }
            </style>
    </head>

    <body>
        <div class="nui-toolbar">
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
                        <input id="" name="" width="80px" emptyText="客户名称" class="nui-textbox" />

                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;回访登记</a>

                    </td>
                </tr>
            </table>
        </div>

        <div class="nui-fit">

            <div id="layout1" class="nui-layout" style="width:100%;height:100%;">
                <div title="center" region="center">
                    <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                        totalField="page.count">
                        <div property="columns">
                            <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">购车日期</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">销售顾问</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">下次回访日期</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">回访状态</div>
                            <div field="" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        </div>
                    </div>
                </div>
                <div title="回访记录" region="east" showCloseButton="false" showSplitIcon="true" width="700">
                    <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;">
                        <div title="跟踪记录">
                            <div class="nui-fit">
                                <div>
                                    跟踪日期:<input id="txtDocumentDate" editable="false" name="txtDocumentDate" class="nui-datepicker" style="width: 110px" /> - <input id="txtDocumentDate" editable="false" name="txtDocumentDate" class="nui-datepicker" style="width: 110px"
                                    />&nbsp;&nbsp; 销售顾问：
                                    <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                                </div>
                                <div class="nui-fit">
                                    <span>客户需求/跟踪内容：</span>
                                    <div class="nui-fit">
                                        <div style="width: 100%;height: 80%">
                                            <input class="nui-textArea" style="width: 100%;height: 100%">
                                        </div>

                                        <table cellpadding="0" cellspacing="0" style="line-height: 27px; padding-top: 4px; padding-left: 0px;">
                                            <tr>
                                                <td class="td_title">
                                                    跟踪方式：
                                                </td>
                                                <td>
                                                    <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                                                </td>
                                                <td class="td_title">
                                                    跟踪状态：
                                                </td>
                                                <td>
                                                    <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                                                </td>
                                                <td class="td_title">
                                                    下次预约时间：
                                                </td>
                                                <td>
                                                    <input id="cmbBillFlg" class="nui-datepicker" editable="false" style="width: 110px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="td_title">
                                                    跟踪结果：
                                                </td>
                                                <td>
                                                    <input id="cmbBillFlg" class="nui-combobox" editable="false" style="width: 110px">
                                                </td>
                                                <td class="td_title">
                                                    跟踪人：
                                                </td>
                                                <td>
                                                    <input id="txtContractNum" class="nui-textbox" style="width: 110px;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();

            function edit(e) {
                var tit = null;
                if (e == 1) {
                    tit = '新增';
                } else {
                    tit = '修改';
                }
                nui.open({
                    url: webPath + contextPath + '/page/car/xiaoshouhuifang_det.jsp',
                    title: tit,
                    width: 380,
                    height: 250,
                    onload: function() {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData(row);
                    },
                    ondestroy: function(action) {
                        visitHis.reload();
                    }
                });
            }
        </script>
    </body>

    </html>