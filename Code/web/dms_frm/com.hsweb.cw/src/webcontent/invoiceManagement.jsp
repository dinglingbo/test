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
    <script src="<%= request.getContextPath() %>/cw/js/invoiceManagement/invoiceManagement.js?v=1" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/date.js" type="text/javascript"></script>
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
		                   单据日期:<input class="nui-datepicker" id="start"onblur="valueChane()"/>-<input class="nui-datepicker" id="end"onblur="valueChane()"/>
		            <input class="nui-combobox" data="data" textfield="text" valuefield="id" value="1" id="type"onvaluechanged="valueChane()"/>
		           <input id="message"name="message" class="nui-textbox" style="width:18%"  onblur="valueChane()">
		        </td>
		        <td style="white-space:nowrap;"><label style="font-family:Verdana;"></label>
		           		<a class="nui-button" iconCls="icon-search" onclick="newBill(1)">新建</a>
		           		<a class="nui-button" iconCls="icon-search" onclick="newBill(2)">编辑</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">导出到XLS</a>
	            </td>
		        </tr>
		    </table>
		</div>
        <div class="nui-fit">
        	<div id="grid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" url="">
                <div property="columns">
                	<div field="main" name="main" headeralign="center" align="center" width="40"visible="false"></div>
                    <div field="code" name="code" headeralign="center" align="center" width="40">开票单号</div>
                    <div field="serviceCode" name="serviceCode" headeralign="center" align="center"width="55">源单号</div>
                    <div field="guestFullName"  name="guestFullName" headeralign="center" align="center"width="30">客户姓名</div>
                    <div field="carNo"  name="carNo" headeralign="center" align="center"width="40">车牌号</div>
                    <div field="guestMobile"  name="guestMobile" headeralign="center" align="center"width="40">手机号</div>
                    <div field="invoiceType"  name="invoiceType" headeralign="center" align="center"width="40">发票类型</div>
                    <div field="rate"  name="rate" headeralign="center" align="center"width="20">税率</div>
                    <div field="invoiceAmt"  name="invoiceAmt" headeralign="center" align="center"width="40">开票金额</div>
                    <div field="rateAmt"  name="rateAmt" headeralign="center" align="center"width="40">税额</div>
                    <div field="invoiceNo"  name="invoiceNo" headeralign="center" align="center"width="40">发票号</div>
                    <div field="invoiceName"  name="invoiceName" headeralign="center" align="center"width="40">发票抬头</div>
                    <div field="recordDate"  name="recordDate" headeralign="center" align="center"width="35">开票日期</div>
                    <div field="recordDateMain"  name="recordDateMain" headeralign="center" align="center"width="35">源单日期</div>
                    <div field="recorder"  name="recorder" headeralign="center" align="center"width="30">开票人</div>
                    <div field="remark"  name="remark" headeralign="center" align="center"width="40">开票备注</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	 var data = [{ id: 1, text: '发票号查询' }, { id: 2, text: '开票单号查询' }, { id: 3, text: '源单号查询' },
    	  { id: 4, text: '客户姓名查询' }, { id: 5, text: '手机号码查询' }, { id: 2, text: '车牌号查询' }];
        nui.parse();
		
        function newBill(e) {
            var item={};
            item.id = "TicketOpeningMgr";
            item.text = "开票单";
            var url = null;
            if(e == 1){
            	url = "/cw/invoice.jsp";
            }else{
            	row = grid.getSelected();
            	if(row){
            		url = "/cw/invoice.jsp?state=1&serviceCode="+row.serviceCode+"&main="+row.main;
            	}
            }
            item.url = webPath + contextPath + url;
            item.iconCls = "fa fa-cog";
            window.parent.activeTab(item);
        }
        
    </script>
</body>

</html>