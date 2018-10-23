<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-09-30 17:18:32
  - Description:
-->
<head>
<title>可退配件</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/returnPart.js?v=1.0.5"></script> 
</head>
<body>
  
 <div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
       <table class="table" id="table1">
        <tr>
           <td>
           <a class="nui-button" iconCls="" plain="true" onclick="onOk">
                  <span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
            </td>
         </tr>
       </table>
     </div>
     <!-- oncellcommitedit="onCellCommitEdit"
     ondrawsummarycell="onDrawSummaryCell" -->
<div class="nui-fit">
     <div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:100%;"
     showPager="false"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true"
     allowCellSelect="true"
     allowCellEdit="true"
     >
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
          <div header="配件信息" headerAlign="center">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码"></div> 
                <div field="qty" name="qty" summaryType="sum"  numberFormat="0" width="60" headerAlign="center" header="数量"> </div>
                <div field="pickQty" name="pickQty" summaryType="sum"  numberFormat="0" width="60" headerAlign="center" header="已领数量"> </div>
                <div field="unitPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价"></div>
                <div field="amt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额"></div>
                <div field="saleMan" headerAlign="center"  allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onpartsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div> 
                <div field="recordDate" width="60" headerAlign="center" header="购买日期" dateFormat="yyyy-MM-dd H:mm:ss"> </div>  
           </div>
         </div>
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