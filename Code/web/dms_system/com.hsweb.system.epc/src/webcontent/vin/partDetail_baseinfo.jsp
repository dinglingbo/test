<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="技术信息" name="baseinfo" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgbaseinfo" class="nui-datagrid"
             allowCellEdit="true" allowCellSelect="true"
             style="width:100%;height:100%;"
             showColumns="fasle"
             showPager="fasle" >                
            <div property="columns">                                              
                <!--
                <div field="pid" headerAlign="center" width="50px" align="center">零件号</div>
                <div field="label" headerAlign="center" width="50px" align="center">零件名称</div>
                <div field="num" headerAlign="center" width="50px" align="center">数量</div>
                <div field="prices" headerAlign="center" width="50px" align="center">价格</div>
                <div field="model" headerAlign="center" width="50px" align="center">型号</div>
                <div field="remark" headerAlign="center" width="50px" align="center">备注</div>
                -->
                <div field="field1" width="20px" align="right"></div>
                <div field="field2" align="left"></div>
            </div>
        </div>
   </div>        
</div>