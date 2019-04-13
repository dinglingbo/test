<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
    <title>车险开单</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceMain.js?v=1.0.77"></script>
    <style type="text/css">

    table {
        font-size: 12px;
    }

    .form_label {
        width: 84px;
    }
</style>

</head>
<body>
    <div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;">

        <table class="table" id="table1">
            <tr>
                <td>
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

                    <a class="nui-menubutton"  iconCls="" id="searchByDateBtn" menu="#popupMenu" >所有</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearchType(0)">所有</li>
                        <li iconCls="" onclick="quickSearchType(1)">草稿</li>
                        <li iconCls="" onclick="quickSearchType(2)">预结算</li>
                        <li iconCls="" onclick="quickSearchType(3)">已结算</li>
                    </ul>

                    <input class="nui-textbox" id="guestFullName" name="guestFullName" emptyText="输入客户姓名" width="100"  onenter="doSearch()"/>
                    <input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="请输入单号" width="100" onenter="doSearch()"/>
                    <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="100" onenter="doSearch()"/>
                    <label class="form_label">开单日期&nbsp;从：</label>
                    <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "startDate" value="" />
                    <label class="form_label">至：</label>
                    <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "endDate" value=""/>

                    <a class="nui-button" iconCls="" onclick="doSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="newInsuranceDetail" id="">
                     <span class="fa fa-plus fa-lg"></span>&nbsp;新增
                 </a>

                 <a class="nui-button" iconCls="" plain="true" onclick="view()" id="">
                    <span class="fa fa-edit fa-lg"></span>&nbsp;修改
                </a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="leftGrid" dataField="list" class="nui-datagrid"
    style="width: 100%; height: 100%;"
    pageSize="50"
    totalField="page.count"
    sortMode="client"
    selectOnLoad="true"
    allowSortColumn="true">
    <div property="columns">
        <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
        <div field="serviceCode" headeralign="center" allowsort="true" visible="true" width="80px">工单号</div>
        <div field="carNo" headeralign="center" allowsort="true" visible="true" width="60px">车牌号</div>
        <div field="guestName" headeralign="center" allowsort="true" visible="true" width="80px">姓名</div>
        <div field="status" headeralign="center" allowsort="true" visible="true" width="40px">状态</div>
        <div field="insureCompName" headeralign="center" allowsort="true" visible="true" width="100px">保险公司</div>
        <div field="carModel" headeralign="center" allowsort="true" visible="true" width="180px">品牌车型</div>
        <div field="recordDate" headeralign="center" allowsort="true" visible="true" dateFormat="yyyy-MM-dd HH:mm" width="100px">开单日期</div>
    </div>
</div>
</div>

        </body>
        </html>