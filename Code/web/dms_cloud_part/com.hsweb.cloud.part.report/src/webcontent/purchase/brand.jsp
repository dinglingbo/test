<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
  
     <div id="datagrid1" class="nui-datagrid" style="width:100%;height:900px;" 
    url="com.hsapi.demo.Controller.testque.biz.ext"
    allowResize="true"
    sizeList="[20,30,50,100]" pageSize="20" dataField="pp"
    showHeader="true" title="品牌表格"
 onmouseup="return datagrid1_onmouseup()"
 allowCellEdit="true" allowCellSelect="true" multiSelect="true" 
        editNextOnEnterKey="true"  editNextRowCell="true">
        
    <div property="columns">
    
        <div type="indexcolumn" ></div>
        
           <div type="checkcolumn"></div>
           
        <div field="menuname" width="100" headerAlign="center" allowSort="true">序号</div>  
          
        <div field="menuid" width="100" headerAlign="center" allowSort="true">公司名称</div>  
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">配件内码</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">商品编码</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">商品名称</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">品牌</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">规格</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">适用车型</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">OEM码</div>
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">实物码</div>
                
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">入库数量</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">入库金额 </div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">退货数量</div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">退货金额 </div> 
        
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">实际入库数量</div> 
         
        <div field="menulabel" width="100" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>