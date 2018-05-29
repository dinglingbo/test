<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<title>供应商</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:900px;" 
    url="com.hsapi.demo.Controller.testque.biz.ext"
    allowResize="true"
    sizeList="[20,30,50,100]" pageSize="20" dataField="pp"
    showHeader="true" title="配件表格"
 onmouseup="return datagrid1_onmouseup()"
 allowCellEdit="true" allowCellSelect="true" multiSelect="true" 
        editNextOnEnterKey="true"  editNextRowCell="true">
    <div property="columns">
        <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div>
           
        <div field="menuname" width="120" headerAlign="center" allowSort="true">序号</div>  
          
        <div field="menuid" width="120" headerAlign="center" allowSort="true">公司名称</div>  
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">类型编号 </div> 
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">类型名称 </div> 
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">入库数量</div> 
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">入库金额 </div> 
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">退货数量</div> 
        
        <div field="menulabel" width="120" headerAlign="center" allowSort="true">退货金额 </div> 
        
         <div field="menulabel" width="120" headerAlign="center" allowSort="true">实际入库数量</div> 
         
          <div field="menulabel" width="120" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
