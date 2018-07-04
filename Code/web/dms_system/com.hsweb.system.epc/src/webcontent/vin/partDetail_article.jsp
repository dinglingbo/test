<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    
<div title="品牌件" name="article" visible="fasle">    
   <div class="nui-fit">   
        <div id="dgarticle" class="nui-datagrid"
             style="width:100%;height:100%;"
             showColumns="true"
             showPager="fasle" >                
            <div property="columns">                                             
                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
                <div field="pid" headerAlign="center" width="50px" align="center">品牌编号</div>
                <div field="brandcn" headerAlign="center" width="50px" align="center">品牌名称</div>
                <div field="prices" headerAlign="center" width="50px" align="center">参考价格</div>
                <div field="counts" headerAlign="center" width="50px" align="center">件数</div>
                <div field="lable" headerAlign="center" width="50px" align="center">零件名称</div>
                <div field="ptype" headerAlign="center" width="50px" align="center">型号</div>
            </div>
        </div>
   </div>        
</div>