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
    <title>滞销产品统计分析</title>
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
        快速查询：
        <a class="nui-menubutton" plain="true" iconCls="" id="menunamedate" menu="#popupMenu" >7天之内</a>
        <ul id="popupMenu" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch(0)">7天之内</li>
            <li iconCls="" onclick="quickSearch(1)">30天之内</li>
            <li iconCls="" onclick="quickSearch(2)">90天之内</li>
            <li iconCls="" onclick="quickSearch(3)">180天之内</li> 
            <li iconCls="" onclick="quickSearch(4)">360天之内</li>
        </ul>

        入库日期: 
        <input class="nui-datepicker"  id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
        <input class="nui-datepicker"  id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
        <input class="nui-textbox"  id="partCode" name="partCode" emptytext="配件编码">
        <input class="nui-textbox" id="partName" name="partName"emptytext="配件名称">
        <!-- <input class="nui-textbox" id=""emptytext="配件品牌"> -->
        <input class="nui-textbox" id="storeId"name="storeId"emptytext="仓库">
        <input class="nui-textbox" id="branchStockAge"name="branchStockAge" emptytext="滞销天数">
        <input class="nui-textbox" emptytext="配件分类">

        <a class="nui-button" iconcls=""  name="" onclick="Search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <a class="nui-button" iconcls=""  name="" onclick=""><span class="fa fa-mail-forward fa-lg"></span>&nbsp;导出</a>
    </div>

    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;"
        totalField="page.count" pageSize="50" sizeList=[20,50,100]>
        <div property="columns">
            <div field="partCode"  name="" headeralign="center" align="center" width="100">配件编码 </div>
            <div field="partName"  name="" headeralign="center" align="center" width="100">配件名称 </div>
            <div field="oemCode"  name="" headeralign="center" align="center" width="100">OEM码 </div>
            <div field="partBrandId"  name="" headeralign="center" align="center" width="100">品牌 </div>
            <div field="applyCarModel"  name="" headeralign="center" align="center" width="150">品牌车型 </div>
            <div field="enterUnitId"  name="" headeralign="center" align="center" width="100">单位 </div>
            <div field="carTypeIdF"  name="" headeralign="center" align="center" width="100">配件分类一级 </div>
            <div field="carTypeIdS"  name="" headeralign="center" align="center" width="100">配件分类二级 </div>
            <div field="carTypeIdT"  name="" headeralign="center" align="center" width="100">配件分类三级 </div>
            <div field="spec"  name="" headeralign="center" align="center" width="100">规格 </div>
            <div field="storeId"  name="" headeralign="center" align="center" width="100">仓库 </div>
            <div field="outableQty"  name="" headeralign="center" align="center" width="100">数量 </div>
            <div field="enterPrice"  name="" headeralign="center" align="center" width="100">单价 </div>
            <div field="enterAmt"  name="" headeralign="center" align="center" width="100">金额  </div>
            <div field="branchStockAge"  name="" headeralign="center" align="center" width="100">滞销天数  </div>
            <div field="enterDate"  name="" headeralign="center" align="center" width="100" dateFormat="yyyy-MM-dd">入库日期</div>

        </div>
    </div>
</div>

<script type="text/javascript">

    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var grid = nui.get("grid");
    var gridUrl = baseUrl +'com.hsapi.repair.repairService.report.queryproductUnsold.biz.ext';
    var form=new nui.Form("#form1");
    var startDateEl = nui.get("startDate");
    var endDateEl = nui.get("endDate");
    grid.setUrl(gridUrl);
    grid.load();

quickSearch(0);
    function Search() {
        var data= form.getData();
        var eDate = nui.get("endDate").getFormValue();
        if(eDate){
                data.endDate = eDate +" 23:59:59";
        }
		grid.load({params:data});
    }
    
    
    function quickSearch(type){
	var params = form.getData();
    var queryname = "最近七天";
    switch (type)
    {
        case 0:
            params.startDate = getDate(7);
            params.endDate = getDate(-1);
            queryname = "最近七天";
            break;
        case 1:
            params.startDate = getDate(30);
            params.endDate = getDate(-1);
            queryname = "最近30天";
            break;
        case 2:
            params.startDate = getDate(90);
            params.endDate = getDate(-1);
            queryname = "最近90天";
            break;
        case 3:
            params.startDate = getDate(180);
            params.endDate = getDate(-1);
            queryname = "最近180天";
            break; 
        case 4:
            params.startDate = getDate(360);
            params.endDate = getDate(-1);
            queryname = "最近360天";
            break; 
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
            if(params.endDate){
                params.endDate = params.endDate +" 23:59:59";
        }
        grid.load({params:params});
} 

function getDate(wantDay){
	var date=new Date();
	var returnDate=new Date(date-1000*60*60*24*wantDay);
	var year=returnDate.getFullYear();
	var month=returnDate.getMonth()+1;
	var day=returnDate.getDate();
	var returnSting=year+"-"+(month<10 ? "0"+month :month)+"-"+(day<10 ?"0"+day:day);
	return returnSting;
}
</script>
</body>
</html>