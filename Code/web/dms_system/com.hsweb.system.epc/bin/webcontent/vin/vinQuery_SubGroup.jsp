<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div id="subGroups">
    <span id="sButton">
        <a class="nui-button sButton" style="display:;" onclick="showSubGroups($('#imgSubGroup'))">图</a>
        <a class="nui-button sButton" style="display:;" onclick="showSubGroups($('#gridSubGroup'))">表</a>
    </span>
    <div id="gridSubGroup" 
        class="nui-datagrid" 
        style="width:100%;height:100%;display:none;"
        showColumns="true"
        showPager="false"
        allowcellwrap="true"
        showSummaryRow="true">
        <div property="columns"> 
            <div field="auth" visible="false"></div>
            <div field="has_subs" visible="false"></div>
            <!-- <div type="indexcolumn" width="20" summaryType="count">序号</div> -->
            <div field="num" width="30" headerAlign="center" allowSort=false summaryType="count">主组</div>
            <div field="mainGroup" width="30" headerAlign="center" allowSort=false>分组</div>
            <div field="subGroup" width="60" headerAlign="center" allowSort=false>图号</div>
            <div field="name" width="150" headerAlign="center" allowSort=false>名称</div>
            <div field="description" width="150" headerAlign="center" allowSort=false>备注</div>
            <div field="model" width="100" headerAlign="center" allowSort=false>型号</div>                      
        </div>
    </div>
    <div id="imgSubGroup"        
        style="width:100%;height:100%;display:;" class="content">
    </div>
</div>