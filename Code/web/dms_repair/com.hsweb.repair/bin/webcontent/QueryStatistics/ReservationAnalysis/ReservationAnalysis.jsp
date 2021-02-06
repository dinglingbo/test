<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:13:52
  - Description:
-->
<head>
<title>预约分析报表</title>
<script src="<%=request.getContextPath()%>/repair/js/ReservationAnalysis/ReservationAnalysis.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	
}

.required {
	color: red;
}
</style>
</head>
<body>
<input class="nui-combobox" visible="false" id="prebookItem"/>
<input class="nui-combobox" visible="false" id="prebookCategory"/>
<div class="nui-toolbar" style="border:0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">数据范围：</label>
                    <a class="nui-menubutton" plain="true" iconCls="icon-date" id="searchByDateBtn" menu="#popupMenu" ></a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="icon-date" onclick="quickSearch(4)">本月</li>
                        <li iconCls="icon-date" onclick="quickSearch(5)">上月</li>
                        <li iconCls="icon-date" onclick="quickSearch(6)">本年</li>
                        <li iconCls="icon-date" onclick="quickSearch(7)">上年</li>
                    </ul>
                </td>
                <td class="form_label">起始日期:</td>
                <td>
                    <input name="startDate"
                           id="startDate"
                           allowInput="false"
                           showClearButton="false"
                           class="nui-datepicker"/>
                </td>
                <td>终止日期:</td>
                <td>
                    <input name="endDate"
                           id="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           showClearButton="false"/>
                </td>
                <td>
                    <label style="font-family:Verdana;">快速分析：</label>
                    <a class="nui-menubutton" plain="true" iconCls="icon-date" id="analysisByDateBtn" menu="#popupMenu1" >按维修顾问</a>
                    <ul id="popupMenu1" class="nui-menu" style="display:none;">
                        <li iconCls="icon-date" onclick="quickSearch1(1)">按维修顾问</li>
                        <li iconCls="icon-date" onclick="quickSearch1(8)">按预约类型</li>
                        <li iconCls="icon-date" onclick="quickSearch1(9)">按预约项目</li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%">
                <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
                <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
            </td>
        </tr>
    </table>
</div>
<div style="width: 100%; height: 380px;">
    <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height:100%;"
         showpager="false"
         allowSortColumn="true">
        <div property="columns">
            <div header="维度" headerAlign="center">
                <div property="columns">
                    <div field="groupName" headerAlign="center" allowSort="true" visible="true" width="100">分析维度
                    </div>
                </div>
            </div>
            <div header="合计" headerAlign="center">
                <div property="columns">
                    <div field="tcount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">预约总量</div>
                    <div field="dq" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">到期客户量</div>
                    <div field="zyy" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">在预约</div>
                    <div field="bj" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">成功报价</div>
                    <div field="ls" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">流失</div>
                    <div field="zyyp" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">在预约占比</div>
                    <div field="bjp" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">成功报价占比</div>
                    <div field="lsp" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">流失占比</div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>