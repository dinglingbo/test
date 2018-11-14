<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->
<head>
    <title>施工项目明细（应收）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
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
</style>
<body>
    <div id="form1" class="mini-toolbar" style="padding:10px;">
        结算日期:
        <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
        <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
        <input class="nui-textbox"  id="serviceCode" name="serviceCode" emptytext="工单号">
        <input class="nui-textbox" id="carNo" name="carNo"emptytext="车牌号">
        <input class="nui-textbox" id="itemName" name="itemName"emptytext="工时名称">
        <input class="nui-textbox" id="mtAdvisor"name="mtAdvisor" emptytext="服务顾问">
        <input class="nui-textbox" id=""name=""emptytext="配件分类">

        <a class="nui-button" iconcls=""  name="" onclick="Search()">查询</a>
        <a class="nui-button" iconcls=""  name="" onclick="">导出</a>
    </div>

    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true" url="" 
        allowcellwrap="true" style="width:100%;height:100%;"
        totalField="page.count">
            <div property="columns">
                <div field="serviceCode"  name="serviceCode" headeralign="center" width="100" align="center">工单号</div>
                <div field="serviceTypeId"  name="serviceTypeId" headeralign="center" width="100" align="center">业务类型</div>
                <div field="itemName"  name="itemName" headeralign="center" width="100" align="center">工时名称</div>
                <div field="carNo"  name="carNo" headeralign="center" width="100" align="center">车牌号</div>
                <div field="carModel"  name="carModel" headeralign="center" width="200" align="center" width="130">品牌</div>
                <div field="guestName"  name="guestName" headeralign="center" width="100" align="center">客户名称</div>
                <div field="carVin"  name="carVin" headeralign="center" width="100" align="center">VIN码</div>
                <div field="itemTime"  name="itemTime" headeralign="center" width="100" align="center">工时</div>
                <div field="unitPrice"  name="unitPrice" headeralign="center" width="100" align="center">单价</div>
                <div field="amt"  name="amt" headeralign="center" width="100" align="center">金额</div>
                <div field="rate"  name="rate" headeralign="center" width="100" align="center">优惠率</div>
                <div field="subtotal"  name="subtotal" headeralign="center" width="100" align="center">小计</div>
                <div field=""  name="" headeralign="center" width="100" align="center">来店途径</div>
                <div field="workers"  name="workers" headeralign="center" width="100" align="center">施工员</div>
                <div field="status"  name="status" headeralign="center" width="100" align="center">状态</div>
                <div field="isBack"  name="isBack" headeralign="center" width="100" align="center">是否返工</div>
                <div field="mtAdvisor"  name="mtAdvisor" headeralign="center" width="100" align="center">服务顾问</div>
                <div field="finishDate"  name="finishDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd">完工日期</div>
                <div field="outDate"  name="outDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd">结算日期</div>
            </div>
        </div>
    </div>

<script type="text/javascript">

    nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var grid = nui.get("grid");
    var gridUrl = 'com.hsapi.repair.repairService.report.queryItemTotalDetailReport.biz.ext';
    var form=new nui.Form("#form1");
    grid.setUrl(gridUrl);
    grid.load();

    function Search() {
        var data= form.getData();


        grid.load({params:data});
    }

</script>
</body>
</html>