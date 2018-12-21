<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
    <title>精准抓客</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
     <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label>内容分类：</label>
                    <input class="nui-combobox" name="" id="" enabled="true"/>
                    <label>操作类型：</label>
                    <input class="nui-combobox" name="" id="" enabled="true"/>
                    <label>标题：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="list()"><span class="fa fa-plus fa-lg"></span>&nbsp;测试预约</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
        pageSize="50"
        multiSelect="false"
        totalField="page.count"
        sizeList=[20,50,100,200]
        dataField="list"
        onrowdblclick=""
        allowCellSelect="true"
        allowCellWrap = true
        ondrawcell=""
        onshowrowdetail="onShowRowDetail"
        >
        <div property="columns">
            <div type="indexcolumn"headerAlign="center" header="序号"></div>
            <div type="expandcolumn" >#</div>
            <div field="a" name="" width="80" headerAlign="center" header="内容分类"></div>
            <div field="b" name="" width="80" headerAlign="center" header="操作类型"></div>
            <div field="c" name="" width="80" headerAlign="center" header="标题"></div>
            <div field="d" name="" width="80" headerAlign="center" header="活动类型"></div>
            <div field="" name="" width="80" headerAlign="center" header="次数"></div>
        </div>
    </div>
</div>


<div id="detailGrid_Form" style="display:none;">
    <div id="investGridDetai" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    multiSelect="false"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    allowCellWrap = true
    ondrawcell=""
    >
    <div property="columns">

        <div type="indexcolumn"headerAlign="center" header="序号"></div>
        <div field="a" name="" width="80" headerAlign="center" header="绑定手机"></div>
        <div field="b" name="" width="80" headerAlign="center" header="微信OPENID"></div>
        <div field="c" name="" width="80" headerAlign="center" header="微信昵称"></div>
        <div field="d" name="" width="80" headerAlign="center" header="车牌号"></div>
        <div field="" name="" width="80" headerAlign="center" header="内容分类"></div>
        <div field="" name="" width="80" headerAlign="center" header="操作类型"></div>
        <div field="" name="" width="80" headerAlign="center" header="标题"></div>
        <div field="" name="" width="80" headerAlign="center" header="次数"></div>
        <div field="" name="" width="80" headerAlign="center" header="时间" dateFormat="yyyy-MM-dd HH:mm"></div>
    </div>
</div>
</div>
<script type="text/javascript">
    nui.parse();
    var data1 = [{a:"文章",b:"浏览",c:"月饼的来历",d:"5"},{a:"文章",b:"浏览",c:"未知的世界",d:"6"}];
    var data2 = [{a:"12345678900",b:"oAzKz08FhxhBntgMrf9gR",c:"李三",d:"粤F98923"},{a:"12345123451",b:"dsfdshyjuk95342",c:"速度",d:"粤F3423"}];
    var grid1 = nui.get("investGrid");
    var grid2 = nui.get("investGridDetai");
    var detailGrid_Form = document.getElementById("detailGrid_Form");
    grid1.setData(data1);
    grid2.setData(data2);

    function onShowRowDetail(e) {
        var grid = e.sender;
        var row = e.record;
        var td = grid.getRowDetailCellEl(row);
        td.appendChild(detailGrid_Form);
        detailGrid_Form.style.display = "block";

        //grid2.load();
    }


    function list(){
       nui.open({
           url: webPath + contextPath  + "/repair/RepairBusiness/BookingManagement/BookingMgrMain.jsp",
           title: "预约管理",
           width: '100%', 
           height: '100%', 
           onload: function () {
           },
           ondestroy: function (action) {
           }
       });
   }
</script>
</body>
</html>