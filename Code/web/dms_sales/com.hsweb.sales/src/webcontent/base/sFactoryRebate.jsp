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
        <title>厂家返利</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
        <script src="<%=webPath + contextPath%>/sales/base/js/sFactoryRebate.js?v=1.2.1"></script>
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
        <div class="nui-toolbar" id="form1">
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
                        单据日期:
                        <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                        至
                        <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                        <li class="separator"></li>
                        <input id="guestId" name="guestId" class="nui-buttonedit"
                        emptyText="请选择供应商..." 
                        onbuttonclick="selectSupplier('guestId')" selectOnFocus="true" />

                        <input id="rebateId" name="rebateId" class="nui-combobox" showNullItem="true" nullItemText="请选择..."
                        dataField="list" valueField="id" textField="name" emptyText="返利政策" />

                        <a class="nui-button" iconCls="" plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="edit(1)" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="edit(2)" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="submit()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;提交</a>
                        <!-- <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a> -->

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                totalField="page.count">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                    <!-- <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div> -->
                    <div field="serviceCode" headerAlign="center" allowSort="true" width="100px">单据编号</div>
                    <div field="guestFullName" headerAlign="center" allowSort="true" width="100px">返利厂家</div>
                    <div field="name" headerAlign="center" allowSort="true" width="100px">返利政策</div>
                    <div field="rebateTotalAmt" headerAlign="center" allowSort="true" width="100px">金额（元） </div>
                    <div field="recordDate" headerAlign="center" allowSort="true" width="100px" dateFormat="yyyy-MM-dd HH:mm">单据日期</div>
                    <div field="operator" headerAlign="center" allowSort="true" width="100px">经办人</div>
                    <!-- <div field="" headerAlign="center" allowSort="true" width="100px">厂家编号</div> -->
                    <!-- <div field="" headerAlign="center" allowSort="true" width="100px">数量</div> -->
                    <div field="recorder" headerAlign="center" allowSort="true" width="100px">制单人</div>
                    <div field="status" headerAlign="center" allowSort="true" width="100px">状态</div>
                    <!-- <div field="" headerAlign="center" allowSort="true" width="100px">制单时间</div> -->
                    <div field="remark" headerAlign="center" allowSort="true" width="200px">备注</div>
                </div>
            </div>
        </div>
        </div>

        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>