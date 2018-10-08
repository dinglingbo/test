<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
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
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
 <div class="nui-fit">
     <div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true"
     allowCellSelect="true"
     allowCellEdit="true"
     oncellcommitedit="onCellCommitEdit"
     ondrawsummarycell="onDrawSummaryCell"
     >
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
          <div header="配件信息" headerAlign="center">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码"></div> 
                <div field="qty" name="qty" summaryType="sum"  numberFormat="0" width="60" headerAlign="center" header="数量">
                   <input property="editor" vtype="int" class="nui-textbox"/>
                </div>
                <div field="unitPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价">
                   <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
                   <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="saleMan" headerAlign="center"  allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onpartsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
                <div field="partOptBtn" name="partOptBtn" width="100" headerAlign="center" header="操作" align="center" align="center"></div>
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