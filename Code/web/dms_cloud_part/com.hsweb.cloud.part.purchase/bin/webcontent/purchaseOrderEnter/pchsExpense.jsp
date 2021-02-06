<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-29 12:25:47
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src ="<%=request.getContextPath()%>/purchase/js/purchaseOrderEnter/pchsExpense.js?v=1.0.3"></script>
    
</head>
<body>
<div class="nui-fit">
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addNewRow()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;添加</a>
<!--                     <a class="nui-button" plain="true" iconCls="" onclick="deleteRow()" id="deleteGuestBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                    <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    
                    <input name="settleTypeId" id="settleTypeId" class="nui-combobox" textField="name" valueField="customid" visible="false"/>
                </td>
            </tr>
        </table>
    </div>
    
     <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
             showPager="true"
             dataField="list"
             ondrawcell="onDrawCell"
             idField="id"
             showSummaryRow="true"
             allowCellSelect="true"
             allowCellEdit="true"
             oncellcommitedit="onCellCommitEdit"
             showModified="false"
             multiSelect="true"
             pageSize="1000"
             sizeList="[500,1000,2000]"
             oncellbeginedit="OnrpMainGridCellBeginEdit"
             url="">
            <div property="columns">
                <div type="indexcolumn" width="10">序号</div>
                <div type="checkcolumn" field="check" width="25" visible="false"></div>
                <div field="guestId" width="50" headerAlign="center" visible="false"></div>
                <div field="billDc" width="50" headerAlign="center" visible="false"></div>
                <div field="optBtn" name="optBtn" width="30" headerAlign="center" header="操作" align="center" ></div>
                <div field="fullName" summaryType="count" width="60" headerAlign="center" header="往来单位名称"></div>
                <div field="settleTypeId" type="comboboxcolumn" width="40" headerAlign="center" header="结算方式">
                    <input  property="editor" enabled="true" id="settleTypeId" name="list" data="settleTypeIdList" dataField="settleTypeIdList" class="nui-combobox" valueField="customid" textField="name" url="" emptyText=""  vtype="required"/> 
                </div>
                <div field="expenseTypeCode" type="comboboxcolumn" width="50" headerAlign="center" header="费用类型">
                    <input  property="editor" enabled="true" id="billTypeList" name="list" data="list" dataField="list" class="nui-combobox" onvaluechanged="onbillTypeChange" valueField="id" textField="name" url="" emptyText=""  vtype="required"/> 
                </div>
                <div field="expenseAmt" width="60" summaryType="sum" headerAlign="center" header="应付金额">
                  <input property="editor" vtype="range:0,15000"  class="nui-textbox"/>
                </div>
                <div field="logisticsNo" width="50" headerAlign="center" header="物流单号">
                    <input property="editor" class="nui-textbox"/>
                </div>
                <div field="remark" width="80" headerAlign="center" header="备注">
                    <input property="editor" class="nui-textbox"/>
                </div>
                <div allowSort="true" field="createDate" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                <div allowSort="true" field="creator" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建人"></div>     
            </div>  
          
        </div>
    </div>
    
</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>