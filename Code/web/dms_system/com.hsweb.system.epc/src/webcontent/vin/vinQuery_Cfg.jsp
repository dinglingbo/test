<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div id="gridCfg" 
    class="nui-datagrid" 
    style="width:100%;height:100%;"
    showColumns="true"
    showPager="false"
    allowcellwrap="true"
    showSummaryRow="true">
    <div property="columns">  
        <!-- <div type="indexcolumn" width="20" summaryType="count">序号</div> -->
        <div field="field1" width="80" headerAlign="center" allowSort=false summaryType="count">分类</div>
        <div field="field2" width="150" headerAlign="center" allowSort=false>详情</div>
    </div>
</div>