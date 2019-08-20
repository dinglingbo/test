<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>全部工单明细表</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/inventoryMgr/allotMain.js?v=1.0.0"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">

.title {
  width: 100px;
  text-align: right;
}

.form_label {
	width: 50px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}

</style>

</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
             <label>快速查询：</label>
             <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">所有</a>
                <ul id="popupMenuType" class="nui-menu" style="display:none;">
              <li iconCls="" onclick="quickSearch(13)" id="type10">所有</li>
              <span class="separator"></span>
                <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                <li iconCls="" onclick="quickSearch(7)" id="type7">已提交</li>
                <li iconCls="" onclick="quickSearch(8)" id="type8">已作废</li>
                <span class="separator"></span>
                <li iconCls="" onclick="quickSearch(9)" id="type8">待受理</li>
                <li iconCls="" onclick="quickSearch(10)" id="type8">部分受理</li>
                <li iconCls="" onclick="quickSearch(11)" id="type9">全部受理</li>
                <li iconCls="" onclick="quickSearch(12)" id="type9">已拒绝</li>
            </ul>
          <label>调入仓库：</label>
           <input name="storeId"
                 id="storeId"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 emptyText="请选择..."
                 url=""
                 allowInput="true"
                 showNullItem="false"
                 width="10%"
                 valueFromSelect="true"
                 onvaluechanged=""
                 nullItemText="请选择..."
                />
          <label>调出仓库：</label>
           <input name="storeId2"
                 id="storeId2"
                 class="nui-combobox"
                 textField="name"
                 valueField="id"
                 emptyText="请选择..."
                 url=""
                 allowInput="true"
                 showNullItem="false"
                 width="10%"
                 valueFromSelect="true"
                 onvaluechanged=""
                 nullItemText="请选择..."
                />                           
        <label style="font-family:Verdana;">单据日期 从：</label>
        <input class="nui-datepicker" id="sEnterDate" name="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="eEnterDate" name="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>                   
     	<a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
     	<span class="separator"></span>
     	<a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
        <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
     	<span class="separator"></span>
		 <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
         </td>
            </tr>
        </table>
    </div>


    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               frozenStartColumn="0"            
               pageSize="500"
               totalField="page.count"
               sizeList=[500,1000,2000]
               dataField="data"
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = "true"
               showSummaryRow = "true"
               showPager = "false"
               sortMode="client"
               onshowrowdetail="onShowRowDetail"
               url="">
			<div property="columns">
                  <div type="indexcolumn">序号</div>
                    <div field="serviceId" headerAlign="center" width="150" header="单号"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="调出仓库"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="调出门店"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="调入仓库"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="调入门店"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="申请人"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="总金额"></div>
                    <div field="status" width="150" headerAlign="center" header="状态"></div>
                    <div field="auditSign" width="150"  headerAlign="center" header="出入库状态"></div>
                    <div field="orderDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                    <div field="serviceId" headerAlign="center" width="150" header="备注"></div>
                </div>
          </div>
    </div>
</div>

</body>
</html>