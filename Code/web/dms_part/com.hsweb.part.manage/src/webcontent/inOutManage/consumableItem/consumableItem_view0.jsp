<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>耗材出库</title>
<script src="<%=request.getContextPath()%>/manage/js/inOutManage/consumableItem/consuambleItem.js?v=1.0.15"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
   
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                     <td class="form_label">日期 从:</td>
                <td>
                     <input class="nui-datepicker" id="sCreateDate" allowInput="false" width="100%" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
                </td>
                <td class="">至:</td>
                <td>
                    <input class="nui-datepicker" id="eCreateDate" allowInput="false" width="100%" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                </td>
                <td>
                	<td class="form_label">领料人: </td>
                     <td>
                     <input class="nui-textbox" name="orderMan"id="orderMan" allowInput="true" width="" showTime="false" showOkButton="false" showClearButton="false" />
                    </td>
                </td>

                <td><a class="nui-button"  plain="true" onclick="onSearch()"> <span class="fa fa-search fa-lg"></span> 查询</a>
                	<a class="nui-button"  plain="true" onclick="getPart()"> <span class="fa fa-search fa-lg"></span> 领料</a>
                	<a class="nui-button"  plain="true" onclick="orderToEnter()"> <span class="fa fa-search fa-lg"></span> 归库</a>
                
                </td>
            
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div  id="grid" dataField="detailList" class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="50"
         totalField="page.count" allowSortColumn="true"
         frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" width="30">序号</div>
  
                    <div field="partName" headerAlign="center" allowSort="true" visible="true" width="">配件名称</div>
                    <div field="orderQty" headerAlign="center" allowSort="true" visible="true" width="">出库数量</div>

                    <div field="orderPrice" headerAlign="center" allowSort="true" visible="true" width="">单价</div>
                    <div field="orderAmt" headerAlign="center" allowSort="true" visible="true" width="">金额</div>
                    <div field="mainRemark" id="periodValidity" headerAlign="center" allowSort="true" visible="true" width="">备注</div>
                	 <div field="auditDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">出库日期</div>  
                    <div field="orderMan" headerAlign="center" allowSort="true" visible="true" width=""  align="right">领料人</div>
                    
            </div>
        </div>
    </div>
</div>

 

</body>
</html>