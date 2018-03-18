<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 14:09:04
  - Description:
-->
<head>
<title>客户档案</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/CustomerProfileMain.js?v=1.0.3"></script>
<style type="text/css">
table {
	table-layout: fixed;
	font-size: 12px;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form" id="queryForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" plain="true" onclick="onSearch(0)" id="type0">本日来厂</a>
                    <a class="nui-button" plain="true" onclick="onSearch(1)" id="type1">昨日来厂</a>
                    <a class="nui-button" plain="true" onclick="onSearch(2)" id="type2">本日新客户</a>
                    <a class="nui-button" plain="true" onclick="onSearch(3)" id="type3">本月新客户</a>
                    <a class="nui-button" plain="true" onclick="onSearch(4)" id="type4">本月所有来厂客户</a>
                    <a class="nui-button" plain="true" onclick="onSearch(5)" id="type5">本月流失回厂</a>
                    <a class="nui-button" plain="true" onclick="onSearch(6)" id="type6">上月流失回厂</a>
                </td>
            </tr>
            <tr>
                <td>
                    <label>车牌号</label>
                    <input class="nui-textbox" name=""/>
                    <label>手机号码：</label>
                    <input class="nui-textbox" name=""/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" plain="true" onclick="onMore()">更多</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="nui-toolbar" style="border-bottom:0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" iconCls="icon-add" onclick="add()" plain="true">新增</a>
                <a class="nui-button" iconCls="icon-edit" onclick="edit()" plain="true">修改</a>
                <a class="nui-button" iconCls="icon-date" onclick="amalgamate()" plain="true">资料合并</a>
                <a class="nui-button" iconCls="icon-date" onclick="split()" plain="true">资料拆分</a>
                <a class="nui-button" iconCls="icon-node" onclick="history()" plain="true">维修历史</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" dataField="" class="nui-datagrid" style="width:100%;height:100%;"
         pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="true" showPage="true" showPageSize="true"
         showReloadButton="true" showPagerButtonIcon="true" totalCount="total"
         onselectionchanged="selectionChanged" allowSortColumn="true"
         virtualScroll="true" virtualColumns="true"
         frozenStartColumn="0" frozenEndColumn="7">
        <div property="columns">
            <div width="30" type="indexcolumn">序号</div>
            <div header="车辆信息" headerAlign="center">
                <div property="columns">
                    <div field="type" headerAlign="center" allowSort="true" visible="true" width="80">车牌号
                    </div>
                    <div field="name" headerAlign="center" allowSort="true" visible="true" width="80">品牌
                    </div>
                    <div field="captainName" headerAlign="center" allowSort="true" visible="true"
                         width="80px">车型
                    </div>
                    <div field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="120px">VIN
                    </div>
                    <div field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="80px">保险到期
                    </div>
                    <div field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="80px">年审日期
                    </div>
                    <div field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="80px">投保公司
                    </div>
                </div>
            </div>
            <div header="客户信息" headerAlign="center">
                <div property="columns">
                    <div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="60px">档案号
                    </div>
                    <div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="100px">
                        客户名称
                    </div>
                    <div id="captainName" field="captainName" headerAlign="center" allowSort="true" visible="true"
                         width="100px">地址
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="100px">最后来厂日期
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="100px">最后离厂日期
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="50px">营销员
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="50px">建档人
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="70px">建档日期
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="70px">来厂次数
                    </div>
                    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true"
                         width="70px">离厂天数
                    </div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="120px">
                        发动机号
                    </div>
                    <div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份
                    </div>
                    <div id="captainName" field="captainName" headerAlign="center" allowSort="true" visible="true"
                         width="50px">颜色
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>