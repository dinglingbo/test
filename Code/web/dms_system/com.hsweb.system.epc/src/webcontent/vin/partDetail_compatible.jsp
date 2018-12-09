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
                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
                <div field="brandname" headerAlign="center" align="left" width="20px">品牌</div>
                <div field="cars_model" headerAlign="center" align="left">品牌车型</div>
                <div field="year" headerAlign="center" width="20px" align="left">年份</div>
            </div>
        </div>
    </div>        
</div>