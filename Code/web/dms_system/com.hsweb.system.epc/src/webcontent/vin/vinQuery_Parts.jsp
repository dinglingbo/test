<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div id="gridParts" 
    class="nui-datagrid" 
    style="width:100%;height:100%;display:none;"
    showColumns="true"
    showPager="false"
    allowcellwrap="true"
    showSummaryRow="true">
    <div property="columns"> 
        <!-- <div type="indexcolumn" width="20" summaryType="count">序号</div> -->
        <div field="num" width="20" headerAlign="center" allowSort=false summaryType="count">位置</div>
        <div field="pid" width="60" headerAlign="center" allowSort=false>零件OE号</div>
        <div field="label" width="80" headerAlign="center" allowSort=false>名称</div>
        <div field="quantity" width="20" headerAlign="center" allowSort=false>件数</div>
        <div field="model" width="50" headerAlign="center" allowSort=false>型号</div>
        <div field="remark" width="80" headerAlign="center" allowSort=false>备注</div>
        <div field="prices" width="50" headerAlign="center" allowSort=false>参考价格</div>
        <div field="" width="20" headerAlign="center" allowSort=false>说明</div>
        <div field="detail" width="20" headerAlign="center" allowSort=false></div>
        <div field="opt" width="20" headerAlign="center" align="center" allowSort=false></div>
    </div>
</div>