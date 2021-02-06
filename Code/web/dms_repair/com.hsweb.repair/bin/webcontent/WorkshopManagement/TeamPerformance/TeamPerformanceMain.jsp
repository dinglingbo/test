<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 15:07:35
  - Description:
-->
<head>
<title>班组业绩</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/WorkshopManagement/TeamPerformance/TeamPerformanceMain.js?v=1.0.1"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<div class="nui-toolbar"  style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoFrom">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton" plain="true" iconCls="icon-date" id="searchByDateBtn" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="icon-date" onclick="quickSearch(4)">本月</li>
                        <li iconCls="icon-date" onclick="quickSearch(5)">上月</li>
                        <li iconCls="icon-date" onclick="quickSearch(6)">本年</li>
                        <li iconCls="icon-date" onclick="quickSearch(7)">上年</li>
                    </ul>
                    <label class="form_label">结算日期：</label>
                    <input class="nui-datepicker" id="startDate" name="startDate" format="yyyy-MM-dd"
                           allowInput="false"
                           showClearButton="false"/>
                    <label class="form_label">至：</label>
                    <input class="nui-datepicker" id="endDate" name="endDate" format="yyyy-MM-dd"
                           allowInput="false"
                           showClearButton="false"/>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table>
        <tr>
            <td>
                <a class="nui-menuButton" plain="true" iconCls="icon-print" menu="#printMenu">打印(P)</a>
                <a class="nui-menuButton" plain="true" iconCls="icon-node" menu="#exportMenu">导出(E)</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%;height: 100%;" allowResize="false" borderStyle="border:0">
        <div size="200" showCollapseButton="false">
            <ul id="tree1"
                class="nui-tree"
                resultAsTree="false"
                style="width:100%;height:100%;"
                idField="id"
                dataField="list"
                parentField="parentid" textField="name">
            </ul>
        </div>
        <div showCollapseButton="false" style="border: 0;">
            <div class="nui-splitter" style="width:100%;height:100%;" allowResize="false" vertical="true" borderStyle="border:0">
                <div size="50%" showCollapseButton="false" style="border: 0;">
                    <div class="nui-datagrid"
                         dataField="list"
                         id="grid1"
                         style="height: 100%;width: 100%" showPager="false">
                        <div property="columns">
                            <div type="indexcolumn" headerAlign="center" width="30px" allowSort="true">序号</div>
                            <div header="基本信息" headerAlign="center">
                                <div property="columns">
                                    <div field="name" width="160px" headerAlign="center" allowSort="true">班组</div>
                                    <div field="serviceIdCount" width="100px" headerAlign="center" allowSort="true">维修单数</div>
                                    <div field="tmen" width="80px" headerAlign="center" allowSort="true">人数</div>
                                </div>
                            </div>
                            <div header="项目金额" headerAlign="center">
                                <div property="columns">
                                    <div field="itemAmt" width="100px" headerAlign="center" allowSort="true">项目金额</div>
                                    <div field="perItemAmt" width="100px" headerAlign="center" allowSort="true">人均工时</div>
                                    <div field="itemDeduct" width="100px" headerAlign="center" allowSort="true">项目提成</div>
                                    <div field="perItemDeduct" width="100px" headerAlign="center" allowSort="true">人均提成</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false" style="border: 0;">
                    <div class="nui-datagrid" style="height: 100%;width: 100%"
                         dataField="list"
                         id="grid2"
                         showPager="false">
                        <div property="columns">
                            <div type="indexcolumn" headerAlign="center" width="30px" allowSort="true">序号</div>
                            <div header="班组项目信息" headerAlign="center">
                                <div property="columns">
                                    <div field="serviceCode" width="140px" headerAlign="center" allowSort="true">工单号</div>
                                    <div field="carNo" width="70px" headerAlign="center" allowSort="true">车牌号</div>
                                    <div field="outDate" width="90px" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">结算日期</div>
                                    <div field="itemName" width="90px" headerAlign="center" allowSort="true">项目名称</div>
                                    <div field="itemKind" width="60px" headerAlign="center" allowSort="true">工种</div>
                                    <div field="className" width="60px" headerAlign="center" allowSort="true">班组</div>
                                    <div field="worker" width="60px" headerAlign="center" allowSort="true">承修人</div>
                                    <div field="amt" width="70px" headerAlign="center" allowSort="true">项目金额</div>
                                    <div field="itemPrefRate" width="60px" headerAlign="center" allowSort="true">优惠率</div>
                                    <div field="itemSubtotal" width="70px" headerAlign="center" allowSort="true">项目小计</div>
                                    <div field="deductAmt" width="90px" headerAlign="center" allowSort="true">班组提成金额</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<ul id="printMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li>打印班组业绩</li>
    <li>打印班组业绩明细</li>
</ul>
<ul id="exportMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li>导出班组业绩</li>
    <li>导出班组业绩明细</li>
</ul>
</body>
</html>