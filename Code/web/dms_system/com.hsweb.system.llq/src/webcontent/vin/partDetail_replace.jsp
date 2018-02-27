<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="替换件" name="replace">    
   <div class="nui-fit">   
        <div id="bz" class="nui-datagrid" dataField="dgreplace" 
             allowCellEdit="true" allowCellSelect="true"
             url="com.hs.ys.control.basicData.compGrowthModel.queryCompGrowthModel.biz.ext"
             style="width:100%;height:100%;"
             showPager="fasle" >                
            <div property="columns">  
                <div field="investLevel"    visible="false"><strong>标准店</strong></div>
                <div field="investLevelId" visible="false" ><strong>标准店ID</strong></div>                                              
                <div field="fiveForceKpiType" name="fiveForceKpiType" headerAlign="center" width="50px" align="center"></div>
            </div>
        </div>
   </div>        
</div>