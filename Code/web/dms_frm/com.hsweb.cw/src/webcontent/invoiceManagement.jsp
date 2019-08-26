<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>	

<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 19:45:52
  - Description:
-->

<head>
    <title>开票管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/cw/js/invoiceManagement/invoiceManagement.js?v=1.0.7" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/date.js" type="text/javascript"></script>
    		    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
    <div class="nui-fit">
    	<div id="toolbar1" class="nui-toolbar" style="padding:2px;">
		    <table style="width:100%;">
		        <tr>
		        <td style="width:100%;">
		                   源单日期:<input class="nui-datepicker" id="start"onblur="valueChane()"/>-<input class="nui-datepicker" id="end"/>
		            <input class="nui-combobox" data="data" textfield="text" valuefield="id" value="1" id="type"/>
		           <input id="message"name="message" class="nui-textbox" style="width:18%" onenter="refresh()">
		           <input name="invoiceType"
	                        id="invoiceType"
	                        class="nui-combobox width1"
	                        textField="name"
	                        valueField="id"
	                        emptyText="请选择..."
	                        url=""
	                        allowInput="true"
	                        nullItemText="请选择..."
	                        valuechanged="change"
	                        width="150px"
	                        visible="false"
	                        />
		             <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		             <a class="nui-button" plain="true" iconCls="" onclick="newBill(1)" ><span class="fa fa-plus fa-lg"></span>&nbsp;增加</a>
		             <a class="nui-button" plain="true" iconCls="" onclick="newBill(2)" ><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
	            </td>
		        </tr>
		    </table>
		</div>
        <div class="nui-fit">
        	<div id="grid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" url="">
                <div property="columns">
                <div width="30" type="indexcolumn">序号</div>
                	<div field="main" name="main" headeralign="center" align="center" width="40"visible="false"></div>
                    <div field="code" name="code" headeralign="center" align="center" width="100">开票单号</div>
                    <div field="serviceCode" name="serviceCode" headeralign="center" align="center"width="100">源单号</div>
                    <div field="guestFullName"  name="guestFullName" headeralign="center" align="center"width="60">客户姓名</div>
                    <div field="carNo"  name="carNo" headeralign="center" align="center"width="80">车牌号</div>
                    <div field="guestMobile"  name="guestMobile" headeralign="center" align="center"width="80">手机号</div>
                    <div field="invoiceType"  name="invoiceType" headeralign="center" align="center"width="40">发票类型</div>
                    <div field="rate"  name="rate" headeralign="center" align="center"width="40">税率</div>
                    <div field="invoiceAmt"  name="invoiceAmt" headeralign="center" align="center"width="60">开票金额</div>
                    <div field="rateAmt"  name="rateAmt" headeralign="center" align="center"width="60">税额</div>
                    <div field="invoiceNo"  name="invoiceNo" headeralign="center" align="center"width="60">发票号</div>
                    <div field="invoiceName"  name="invoiceName" headeralign="center" align="center"width="40">发票抬头</div>
                    <div field="recordDate"  name="recordDate" headeralign="center" align="center"width="60">开票日期</div>
                    <div field="recordDateMain"  name="recordDateMain" headeralign="center" align="center"width="60">源单日期</div>
                    <div field="recorder"  name="recorder" headeralign="center" align="center"width="60">开票人</div>
                    <div field="remark"  name="remark" headeralign="center" align="center"width="60">开票备注</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	 var data = [{ id: 1, text: '发票号查询' }, { id: 2, text: '开票单号查询' }, { id: 3, text: '源单号查询' },
    	  { id: 4, text: '客户姓名查询' }, { id: 5, text: '手机号码查询' }, { id: 2, text: '车牌号查询' }];
        nui.parse();
		
        
    </script>
</body>

</html>