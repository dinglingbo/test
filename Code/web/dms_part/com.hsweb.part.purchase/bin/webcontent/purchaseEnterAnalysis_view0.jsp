<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-07 16:32:24
  - Description:
-->
<head>
<title>采购入库分析</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/purchaseInbound/purchaseEnterAnalysis.js?v=1.0.2"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
		<div class="form" id="queryForm">
			<table style="width: 100%;">
				<tr>
					<td style="white-space: nowrap;"><label
						style="font-family: Verdana;">快速查询：</label> <a class="nui-button"
						iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
						<a class="nui-button" iconCls="" plain="true"
						onclick="quickSearch(5)" id="type5">上月</a> <span class="separator"></span>
						<a class="nui-button" iconCls="" plain="true"
						onclick="quickSearch(12)" id="type12">本季</a> <a class="nui-button"
						iconCls="" plain="true" onclick="quickSearch(13)" id="type13">上季</a>
						<span class="separator"></span> <a class="nui-button" iconCls=""
						plain="true" onclick="quickSearch(10)" id="type10">本年</a> <a
						class="nui-button" iconCls="" plain="true"
						onclick="quickSearch(11)" id="type11">上年</a> <span
						class="separator"></span> <a class="nui-button" iconCls=""
						plain="true" onclick="quickSearch2(0)" id="atyp0">按供应商</a> <a
						class="nui-button" iconCls="" plain="true"
						onclick="quickSearch2(1)" id="atyp1">按品牌</a> <a class="nui-button"
						iconCls="" plain="true" onclick="quickSearch2(2)" id="atyp2">按类型</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit" >
    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:60%;"
         showPager="false"
         dataField="analysisList"
         idField="code"
         sortMode="client"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="分店信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="orgName" width="150" headerAlign="center" header="分店名称"></div>
                </div>
            </div>
            <div header="维度" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="name" width="80" headerAlign="center" header="配件名称" align="center"></div>
                </div>
            </div>
            <div header="1-12月" headerAlign="center">
                <div property="columns">
                    <div field="Jan" width="80" headerAlign="center" header="1月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Feb" width="80" headerAlign="center" header="2月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Mar" width="80" headerAlign="center" header="3月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Apr" width="80" headerAlign="center" header="4月" align="right" allowSort="true" dataType="float"></div>
                    <div field="May" width="80" headerAlign="center" header="5月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Jun" width="80" headerAlign="center" header="6月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Jul" width="80" headerAlign="center" header="7月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Aug" width="80" headerAlign="center" header="8月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Sep" width="80" headerAlign="center" header="9月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Oct" width="80" headerAlign="center" header="10月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Nov" width="80" headerAlign="center" header="11月" align="right" allowSort="true" dataType="float"></div>
                    <div field="Dec" width="80" headerAlign="center" header="12月" align="right" allowSort="true" dataType="float"></div>
                </div>
            </div>
        </div>
    </div>
</div>




</body>
</html>
