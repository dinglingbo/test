<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="组件" name="compt" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgcompt" class="nui-datagrid"
             allowCellEdit="true" 
             allowCellSelect="true"
             style="width:100%;height:100%;"
             showPager="fasle" >                
            <div property="columns">                                         
                <div field="pid" headerAlign="center" width="50px" align="center">零件号</div>
                <div field="label" headerAlign="center" width="50px" align="center">名称</div>
                <div field="num" headerAlign="center" width="50px" align="center">件数</div>
                <div field="model" headerAlign="center" width="50px" align="center">型号</div>
                <div field="remark" headerAlign="center" width="50px" align="center">备注</div>
            </div>
        </div>
   </div>        
</div>