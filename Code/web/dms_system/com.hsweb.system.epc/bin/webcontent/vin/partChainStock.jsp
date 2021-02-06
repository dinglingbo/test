<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="库存分布" name="stock" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgstock" class="nui-datagrid"
             allowCellEdit="true" allowCellSelect="true"
             style="width:100%;height:100%;"
             showPager="fasle" >                
            <div property="columns">                                              
                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
                <div field="shortName" headerAlign="center" align="left" width="50px" align="center">公司名称</div>
                <div field="partCode" headerAlign="center" align="left" width="50px" align="center">配件编码</div>
                <div field="partCode" headerAlign="center" align="left" width="50px" align="center">OEM码</div>
                <div field="fullName" headerAlign="center" align="left" width="80px" align="center">配件全称</div>
                <div field="stockQty" headerAlign="center" align="left" width="20px" align="center">库存数量</div>
                <div field="address" headerAlign="center" align="left" width="60px" align="center">公司地址</div>
            </div>
        </div>
   </div>        
</div>