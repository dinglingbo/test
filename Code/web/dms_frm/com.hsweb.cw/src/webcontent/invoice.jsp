<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>	
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 18:46:38
  - Description:
-->

<head>
	<title>开票单</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/cw/js/invoiceManagement/invoice.js?v=1.3" type="text/javascript"></script>
</head>
<style type="text/css">
        a.optbtn {
            width: 44px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }
	body {
		margin: 0;
		padding: 0;
		border: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}

	#left {
		display: inline-block;
		float: left;
	}

	#right {
		display: inline-block;
		float: right;
	}
</style>

<body>
	<div class="nui-fit">
		<div style="width: 100%; height: 30%;" id="form">
			<input class="nui-hidden"id="state" value='<b:write property="state"/>'  name="state"/>  
			<input class="nui-hidden"id="serviceCode" value='<b:write property="serviceCode"/>'  name="serviceCode"/> 
			<input class="nui-hidden"id="main" value='<b:write property="main"/>'  name="main"/> 
			<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="saveData()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
                        </td>
                    </tr>
                </table>
            </div>
			<form id="form">
				<table> 
            <tr>   
                <td class="title required">发票类型:</td> 
                <td class="">
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
	                        />
                </td>
                <td class="title required">
                    <label>税率:</label>
                </td>
                <td class="">
                    <input class="nui-textbox" width="150px" name="rate" id="rate" onvaluechanged="checkValue(e)">%
                </td>
                </tr>
                <tr>
                <td class="title required">
                    <label>发票号：</label>
                </td>
                <td>
                   <input class="nui-textbox" width="150px" name="invoiceNo">
                </td>
                <td class="title">发票抬头:</td> 
                <td class=""><input class="nui-textbox" width="150px" name="invoiceName"></td>
            </tr>
            <tr>   
                <td class="title required" >开票备注:</td> 
                <td class=""colspan="5"><input class="nui-textarea" width="360px" name="remark"></td>
            </tr>
        </table>
			</form>

		</div>
		<div class="nui-toolbar" style="padding:2px;border-left:2px;">
          <table style="width:100%;">
              <tr>
                  <td style="white-space:nowrap;" style="width:120px;">
                      <a class="nui-button" plain="true" iconCls="" onclick="addRepair()" id="addPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择</a>
                      <a class="nui-button" plain="true" iconCls="" onclick="remove()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                  </td>
              </tr>
          </table>
      </div>
		<div class="nui-fit">
			<div id="grid" class="nui-datagrid " datafield="ticketDetail"  showsummaryrow="true" ondrawsummarycell="onDrawSummaryCell"editNextOnEnterKey="true" onCellEditEnter="onCellEditEnter"oncellbeginedit="oncellbeginedit" allowCellEdit="true"allowHeaderWrap="true"allowCellSelect="true" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;" allowcellselect="true">
				<div property="columns">
					<div field="servcieId" name="servcieId" headeralign="center" align="center"visible="false">
					</div>
					<div field="serviceCode" name="serviceCode" headeralign="center" align="center">单号
						<input class="nui-textbox" property="editor">
					</div>
					<div field="guestName" name="guestName" headeralign="center">客户名称</div>
					<div field="guestId" name="guestId" headeralign="center" visible="false"></div>
					<div field="carNo" name="carNo" headeralign="center" align="center">车牌号</div>
					<div field="invoiceType" name="invoiceType" headeralign="center" align="center">发票类型	</div>
					<div field="rate" name="rate" headeralign="center" align="center"summarytype="sum">税率</div>
					<div field="invoiceAmt" name="invoiceAmt" headeralign="center" align="center"summarytype="sum">发票金额
						<input class="nui-textbox" property="editor">
					</div>
					<div field="rateAmt" name="rateAmt" headeralign="center" align="center"summarytype="sum">税额</div>
					<div field="action" name="action" headeralign="center" align="center">操作</div>
				</div>
			</div>
		</div>
	<div id="advancedMorePartWin" class="nui-window"
      style="width:700px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelect()" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onClose()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="moreGrid" class="nui-datagrid" style="width:100%;height:95%;"
               dataField="data"               
               allowCellSelect="true"
               editNextOnEnterKey="true"
               totalField="page.count" sizeList=[20,50,100,200] pageSize="20"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="serviceId" name="serviceId" headeralign="center" align="center"visible="false">源单号</div>
                <div field="serviceCode" name="serviceCode" headeralign="center" align="center">源单号</div>
				<div field="guestFullName" name="guestFullName" headeralign="center">客户名称</div>
				<div field="carNo" name="carNo" headeralign="center" align="center">车牌号</div>
				<div field="contactMobile" name="contactMobile" headeralign="center" align="center">手机号</div>
				<div field="recordDate" name="recordDate" headeralign="center" dateFormat="yyyy-MM-dd"  align="center">源单日期</div>
				<div field="carId" name="carId" headeralign="center" align="center" visible="false"></div>
				<div field="guestId" name="guestId" headeralign="center" align="center" visible="false"></div>
              </div>
          </div>
    </div>
</div>
	</div>
	<script type="text/javascript">
		nui.parse();
	</script>
</body>

</html>