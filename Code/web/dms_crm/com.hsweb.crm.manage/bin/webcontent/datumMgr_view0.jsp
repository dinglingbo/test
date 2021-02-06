<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>
<html>
<!--
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
    <title>资料管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/datumMgr.js?v=1.0.27"></script>
         <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">


</style>
</head>
<body>

    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label style="font-family:Verdana;" title="点击清空条件"><span onclick="clearQueryForm()">快速查询：</span></label>
                    <a class="nui-menubutton " iconCls="" menu="#popupMenu1" value="-1" id="assignStatus">所有</a>
                    <ul id="popupMenu1" class="nui-menu" style="display:none;">
                        <li  onclick="setMenu1(this, assignStatus, -1)" id="typeAll">所有</li>
                        <li  onclick="setMenu1(this, assignStatus, 0)" id="type0">未分配</li>
                        <li  onclick="setMenu1(this, assignStatus, 1)" id="type1">已分配</li>
                        <li  onclick="setMenu1(this, assignStatus, 2)" id="type2">今日待跟踪</li>
                    </ul>
                    <input name="color"
                    id="color"
                    class="nui-combobox width2"
                    textField="name"
                    visible="false"
                    valueField="customid"
                    emptyText="请选择..."
                    url=""
                    allowInput="false"
                    showNullItem="false"
                    nullItemText="请选择..."/>

                    <input name="orgid"
                    id="query_orgid"
                    visible="false"
                    class="nui-combobox width2"
                    textField="orgname"
                    valueField="orgid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>

                    <label style="font-family:Verdana;">跟踪状态：</label>
                    <input name="visitStatus"
                    id="visitStatus"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="true"
                    nullItemText="请选择..."
                    style="width:130px;"/>

                    <label style="font-family:Verdana;">车牌号：</label>
                    <input class="nui-textbox width1" name="carNo" id="carNo" enabled="true" style="width:100px;"/>

                    <a class="nui-button"  plain="true" onclick="query(0)" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button"  plain="true" onclick="moreQuery()" id="" enabled="true"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                    <li class="separator"></li>
                    <a class="nui-button"  plain="true" onclick="updateField('visitStatus', '060701')" id="add" enabled="true"><span class="fa fa-edit fa-lg"></span>&nbsp;设为继续跟踪</a>
                    <a class="nui-button"  plain="true" onclick="updateField('visitStatus', '060702')" id="edit" enabled="true"><span class="fa fa-edit fa-lg"></span>&nbsp;设为结束跟踪</a>

                    <li class="separator"></li>
                    <label style="font-family:Verdana;">分配给：</label>
                    <input name="tracker"
                    id="tracker"
                    class="nui-combobox width1"
                    popupwidth="150px;"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."
                    style="width:100px;"/>
                    <a class="nui-button"  plain="true" onclick="assignTracker()" id="add" enabled="true"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <li class="separator"></li>
                    <a class="nui-button"  plain="true" onclick="editClient()" id="" enabled="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改客户资料</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">

        <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
            <div size="15%" showCollapseButton="false" style="border:0;">
                <div class="nui-fit">
                    <div title="品牌" class="nui-panel"
                    showHeader="true"
                    showFooter="false"
                    style="width:100%;height:60%;border: 0;">
                    <ul id="tree1" class="nui-tree"
                    style="width:100%;height:100%;"
                    showTreeIcon="false"
                    dataField="rs"
                    textField="nameCn"
                    idField="id"
                    resultAsTree="false"
                    parentField=""
                    showTreeLines="true"
                    onnodeclick="onType1DbClick"
                    allowDrag="true">
                </ul>
            </div>
            <div title="营销员" class="nui-panel"
            showHeader="true"
            showFooter="false"
            style="width:100%;height:40%;border: 0;">
            <ul id="tree2" class="nui-tree"
            style="width:100%;height:100%;"
            showTreeIcon="false"
            dataField="data"
            textField="empName"
            idField="empId"
            resultAsTree="false"
            parentField=""
            showTreeLines="true"
            onnodeclick="onType2DbClick"
            allowDrag="true">
        </ul>
    </div>
</div>
</div>
<div showCollapseButton="false" style="border:0;">
    <div class="nui-fit">
        <div title="" class="nui-panel"
        showHeader="false"
        showFooter="false"
        style="width:100%;height:100%;border: 0;">
        <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
        showPager="true"
        totalField="page.count"
        pageSize="50" sizeList=[20,50,100]
        selectOnLoad="true"
        ondrawcell=""
        onrowdblclick=""
        dataField="data"
        sortMode="client"
        idField="id"
        multiSelect="true"
        allowCellWrap = true>
        <div property="columns">
            <div type="checkcolumn" width="25"></div>
            <div type="indexcolumn" width="40" summaryType="count">序号</div>
            <div headerAlign="center">车辆信息
                <div property="columns">
                    <div field="id" visible=false>ID</div>
                    <div field="orgid" width="120" headerAlign="center" allowSort=false visible="false">所在分店</div>
                    <div field="carNo" width="90" headerAlign="center" allowSort=false>车牌号</div>
                    
                    <div field="carModel" name="carModel"   width="250" headerAlign="center" allowSort=false>品牌车型</div>
                    <div field="vin" width="160" headerAlign="center" allowSort=false>车架号(VIN)</div>
                    <div field="engineNo" width="160" headerAlign="center" allowSort=false>发动机号</div>
                    <div field="color" width="80" headerAlign="center" allowSort=false>颜色</div>
                    <div field="firstRegDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>初登日期</div>
                    <div field="annualInspectionDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>保险到期</div>
                    <div field="recorder"  name="recorder" width="80" headerAlign="center" allowSort=false>建档人</div>
                    <div field="recordDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>建档日期</div>
                </div>
            </div>
            <div headerAlign="center">客户信息
                <div property="columns">
                    <div field="guestId" visible=false>客户ID</div>
                    <div field="guestName"  name="guestName"  width="80" headerAlign="center" summaryType="" allowSort=false>客户名称</div>
                    <div field="mobile" width="100" headerAlign="center" summaryType="" allowSort=false>手机号</div>
                    <div field="sex" width="50" headerAlign="center" summaryType="" allowSort=false>性别</div>
                    <div field="contacts" width="80" headerAlign="center" summaryType="" allowSort=false>联系人</div>
                    <div field="tel" width="100" headerAlign="center" summaryType="" allowSort=false>电话</div>
                    <div field="address" width="150" headerAlign="center" summaryType="" allowSort=false>地址</div>
                </div>
            </div>
            <div headerAlign="center">联系状态
                <div property="columns">
                    <div field="visitManId" id="visitManId" name="visitManId" width="60" headerAlign="center" summaryType="" allowSort=false>营销员</div>
                    <div field="visitStatus" width="100" headerAlign="center" summaryType="" allowSort=false>跟踪状态</div>
                    <div field="priorScoutDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>上次联系时间</div>
                    <div field="nextScoutDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>下次联系时间</div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>