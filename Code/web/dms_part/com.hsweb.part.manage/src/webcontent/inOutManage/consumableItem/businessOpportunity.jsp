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
    <title>商机列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp"%>
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/consumableItem/businessOpportunity.js?v=1.1.2"></script>
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
    <input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"  visible="false" />
		 <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
         <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onenterSearch(this.value)"/>
        <span class="separator"></span>
        <label style="font-family:Verdana;">下次跟进日期</label>
        <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <span class="separator"></span> 
         <label style="font-family:Verdana;">商机所有者:</label>
		<input class="nui-combobox" id="chanceManId" name="chanceManId" value="" width="100" textField="empName" valueField="empId" onvaluechanged="onSearch()" allowInput="true" showNullItem="false" valueFromSelect="true"/>
        <input class="nui-textbox" id="chanceMan" name="chanceMan" visible="false" />
        <label style="font-family:Verdana;">阶段:</label>
        <input class="nui-combobox" name="status" id="status" textField="name" width="100" valueField="id"  data="statusList1" onvaluechanged="onSearch()" />
        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
    	<a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
    	<a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
              showPager="true"  dataField="list"   url="" sortMode="client"  totalField="page.count"
             pageSize="100" sizeList="[50,100,200,500]" showSummaryRow="true" allowResize="true" multiSelect="true" >
            <div property="columns">   
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
                <div field="carNo" name="carNo" width="100" summaryType="count"  headeralign="center"  >车牌号</div>
                <div field="guestName" name="guestName" width="100"  headeralign="center"  >客户名称</div>
                <div field="guestMobile" name="guestMobile" width="150"  headeralign="center" >手机号</div>
                <div field="chanceType" name="chanceType" width="100"  headeralign="center" >机会类型</div>
                <div field="prdtName" name="prdtName" width="100"  headeralign="center" >产品/项目</div>
                <div field="prdtAmt" name="prdtAmt" width="100"  headeralign="center" summaryType="sum">销售金额</div>
                <div name="chanceMan" field="chanceMan"  width="100"  headeralign="center" allowSort="true" >商机所有者</div>
                <div field="status" name="status" width="50"  headeralign="center" >阶段 </div>
                <div field="nextFollowDate" name="nextFollowDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >下次跟进时间</div>
 				<div field="planFinishDate" name="planFinishDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >预计成单时间</div>
 				<div field="recorder" name="recorder" width="80"  headeralign="center" >创建人</div>
           		<div field="recordDate" name="recordDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >创建人日期</div>
           		<div field="modifier" name="modifier" width="80"  headeralign="center" >修改人</div>
           		<div field="modifyDate" name="modifyDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >修改日期</div>
            </div>
        </div>

    </div>

</body>
</html>