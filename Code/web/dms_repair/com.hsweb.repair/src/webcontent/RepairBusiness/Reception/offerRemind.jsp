<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-12 10:27:06
  - Description:
-->
<head>
<title>报价提醒</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        	<script src="<%=request.getContextPath()%>/coframe/imjs/message.js"></script>
	<script src="<%=request.getContextPath()%>/coframe/imjs/messagebody.js"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/offerRemind.js?v=1.0.7"></script>
    
</head>
<body>
 	<a class="nui-button" iconCls="" plain="true" onclick="addRemind()" id="auditBtn"><span class="fa fa-bell fa-lg"></span>&nbsp;报价提醒</a> 
 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false" multiSelect="true"
               dataField=""
               frozenStartColumn="0" allowCellEdit="true"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
					               url="">

					              <div property="columns">
					              	<div type="indexcolumn">序号</div>
					                  <div type="checkboxcolumn" field="noMtType" name="noMtType" trueValue="1" falseValue="0"  width="50px" headerAlign="center" align="center" >
						                	<strong>是否需要报价&nbsp;<a title="批量设置为需要" plain="true" onclick="setNormal()"><span class="fa fa-edit fa-lg"></span></a></strong>
						              </div>
					                  <div field="prdtName" name="prdtName" width="80" headerAlign="center" header="配件名称"></div>
					                  <div field="prdtCode" name="prdtCode" width="100" headerAlign="center" header="配件编码"></div>
					                  <div field="qty" name="qty" width="60" headerAlign="center" header="数量"></div>
					                  <div field="unit" name="unit" width="50" headerAlign="center" header="单位"></div>
					              </div>
					          </div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>