<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>反结算记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp"%>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
    }


</style>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
        <label style="font-family:Verdana;">操作	日期 从：</label>
        <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        
        <input id="carNo" width="100px" emptyText="车牌号" onvalueChanged="onSearch()" class="nui-textbox" allowinput="true" />
        <input id="creator" width="100px" emptyText="操作人" onvalueChanged="onSearch()" class="nui-textbox" allowinput="true" />
        
        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="" showPager="true"  dataField="detailList"   url="" sortMode="client" 
             pageSize="500" sizeList="[100,500,1000]" showSummaryRow="true" multiSelect="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="40">序号</div>
                <div field="carNo" name="carNo" width="120"  headeralign="center" allowsort="true" summaryType="count">工单号</div>
                <div field="carNo" name="carNo" width="100"  headeralign="center" allowsort="true">车牌号</div>
                <div field="remark" name="remark" width="200"  headeralign="center" allowsort="true">备注</div>
                <div field="creator" name="creator" width="80"  headeralign="center" allowsort="true">操作人</div>
                <div field="createDate" name="createDate" width="120" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowsort="true">操作日期</div>
            </div>
        </div>

    </div>
</body>

<script type="text/javascript">
	var mainGrid = null;
	var searchBeginDate = null;
	var searchEndDate = null;
	
	$(document).ready(function(v)
	{
	
	    mainGrid = nui.get("mainGrid");
		mainGrid.setUrl(apiPath + frmApi + "/com.hsapi.frm.frmService.finance.queryReverseDetail.biz.ext");
	    searchBeginDate = nui.get("beginDate");
	    searchEndDate = nui.get("endDate");
	    
	
	    searchBeginDate.setValue(getNowStartDate());
	    searchEndDate.setValue(getNowEndDate());
	    
	    onSearch();
	
	});
    
	function onSearch() {
		var params = {};
	    params.carNo = nui.get('carNo').getValue();
	    params.creator = nui.get('creator').getValue();
	    
	    params.sCreateDate = searchBeginDate.getFormValue();
	    params.eCreateDate =(addDate(searchEndDate.getValue(), 1));
	
	    mainGrid.load({
	        params: params,
	        token : token
	    });
	}
</script>

</html>