<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    
<div title="适用车型" name="compatible" visible="fasle">    
    <a class="nui-button continue" style="display:none;" onclick="showRightGrid(gridCfg)">加载更多...</a>
    <div class="nui-fit">   
        <div id="dgcompatible" class="nui-datagrid"
             style="width:100%;height:100%;"
             showColumns="true"
             showPager="fasle" >                
            <div property="columns">                                             
                <div field="cars_model" headerAlign="right" width="20px" align="right">车型</div>
                <div field="year" headerAlign="left" align="left">年份</div>
            </div>
        </div>
    </div>        
</div>