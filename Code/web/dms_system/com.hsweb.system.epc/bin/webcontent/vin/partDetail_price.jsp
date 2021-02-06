<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="渠道价格" name="price" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgprice" class="nui-datagrid"
             allowCellEdit="true" allowCellSelect="true"
             style="width:100%;height:100%;"
             showPager="fasle" >                
            <div property="columns">                                              
                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
                <div field="pid" headerAlign="center" width="100px" align="center">零件号</div>
                <div field="parttype" headerAlign="center" width="50px" align="center">零件类型</div>
                <div field="mill" headerAlign="center" width="50px" align="center">厂家</div>
                <div field="factory_type" headerAlign="center" width="50px" align="center" renderer="onFactoryTypeRender">产商类型</div>
                <div field="cost_price" headerAlign="center" width="60px" align="center">含税进货价</div>
                <div field="eot_price" headerAlign="center" width="60px" align="center">不含税进货价</div>
                <div field="prices" headerAlign="center" width="50px" align="center">售价</div>
                <div field="origin" headerAlign="center" width="50px" align="center">产地</div>
                <div field="remark" headerAlign="center" width="50px" align="center">备注</div>
                <div field="supplier" headerAlign="center" width="50px" align="center">服务商</div>
            </div>
        </div>
   </div>        
</div>