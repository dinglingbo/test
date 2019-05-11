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
        <title>销售退货</title>
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
                        <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>
                        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch(12)" id="type12">所有</li>
                        </ul>
                        <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox" />

                        <input id="" name="" width="80px" emptyText="车型名称" class="nui-textbox" />

                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                totalField="page.count">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">工单号</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">状态</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">车型名称</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">销售顾问</div>
                    <div field="" headerAlign="center" allowSort="true" width="100px">车辆销价</div>
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
                    url: webPath + contextPath + '/page/car/x_xiaoshoutuihuo_det.jsp',
                    title: tit,
                    width: 580,
                    height: 350,
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