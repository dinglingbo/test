<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="替换件" name="replace" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgreplace" class="nui-datagrid"
             allowCellEdit="true" allowCellSelect="true"
             style="width:100%;height:100%;"
             showPager="fasle" >                
            <div property="columns">                                               
                <div field="pid" headerAlign="center" width="50px" align="center">零件号</div>
                <div field="lable" headerAlign="center" width="50px" align="center">零件名称</div>
                <div field="prices" headerAlign="center" width="50px" align="center">参考价格</div>
                <div field="ptype" headerAlign="center" width="50px" align="center">型号</div>
                <div field="brandcn" headerAlign="center" width="50px" align="center">品牌中文名称</div>
                <div field="counts" headerAlign="center" width="50px" align="center">件数</div>
            </div>
        </div>
   </div>        
</div>