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
<title>车辆资料统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/query/stat/js/carData.js?v=1.0" type="text/javascript"></script> 
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">按分店</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">按营销员</a>
                <!-- 
                <span class="separator"></span>
                 -->
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">按品牌</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">按客户等级</a>
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
                        <!--分店名称、营销员、品牌、客户等级-->
                        <div field="name" width="30" headerAlign="center" summaryType="count" allowSort=false>分店名称</div>
                    </div>
                </div>
                <div headerAlign="center"><strong>总车辆数</strong>
                    <div property="columns">
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>总数</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>已来厂</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>未来厂</div>
                    </div>
                </div>
                <div headerAlign="center"><strong>未来厂车辆数</strong>
                    <div property="columns">
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>有效数</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>无效数</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>未联系</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>已联系</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>继续联系</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>终止联系</div>
                    </div>
                </div>
                <div headerAlign="center"><strong>客户忠诚度</strong>
                    <div property="columns">
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>0分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>1分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>2分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>3分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>4分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>5分</div>
                        <div field="name" width="30" headerAlign="center" summaryType="sum" allowSort=false>未定义</div>
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

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:250px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           allowInput="false"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">入库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" id="enterIdList"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

</body>
</html>