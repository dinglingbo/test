<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>电销业绩统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/query/stat/js/marketPerform.js?v=1.0" type="text/javascript"></script> 
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">数据范围：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">上月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">本年</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">上年</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">更多</a>
                <!-- 
                <span class="separator"></span>
                 -->
                <label style="font-family:Verdana;">快速分析：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">按分店</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">按营销员</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">按业务类型</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">按品牌</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">按来厂类别</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-print" plain="true" onclick="addInbound()">打印</a>
                <a class="nui-button" iconCls="icon-downgrade" plain="true" onclick="editInbound()" id="editEnterMainBtn" enabled="false">导出</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <div title="" class="nui-panel"
         showFooter="true"
         style="width:100%;height:50%;border: 0;">
        <div id="chart" style="width:100%;height:100%;">
        </div>
    </div>
    <div title="" class="nui-panel"
         showHeader="false"
         showFooter="false"
         style="width:100%;height:50%;border: 0;">
        <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
             showPager="false"
             selectOnLoad="true"
             ondrawcell=""
             onrowdblclick=""
             dataField="ptsEnterMainList"
             sortMode="client"
             idField="id"
             url=""
             showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn" width="20">序号</div>
                <div headerAlign="center"><strong>分析维度</strong>
                    <div property="columns">
                        <!--分店名称、营销员、业务类型、品牌、来厂类别-->
                        <div field="name" width="30" headerAlign="center" summaryType="count" allowSort=false>分店名称</div>
                    </div>
                </div>
                <div headerAlign="center"><strong>分析类别</strong>
                    <div property="columns">
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>车次</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>工时</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>配件</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>维修金额</div>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <div property="footer">
            <input class='nui-textbox' value='' id="leftGridCount" readonly="true" style='vertical-align:middle;'/>
        </div>
    </div>
</div>
</body>
</html>