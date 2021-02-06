<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:36:22
  - Description:
-->
<head>
<title>车辆基盘数量查询</title>
<script src="<%=request.getContextPath()%>/repair/js/CarNumQuery/CarNumQueryMain.js?v=1.0.0"></script>
<style type="text/css">
.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="orgId" visible="false"/>
<div class="nui-toolbar" style="border: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <input class="nui-spinner" maxValue="2100" minValue="2000" showButton="false" style="width:60px;"
                           changeOnMousewheel="false" value="" allowNull="false" name="currentYear"/>
                    <label>年</label>
                    <input class="nui-spinner" maxValue="12" minValue="1" showButton="false"
                           name="currentMonth"
                           changeOnMousewheel="false" style="width:40px;"
                           value="" allowNull="false"/>
                    <label>月</label>
                    <input class="nui-spinner" maxValue="31" minValue="1" showButton="false"
                           name="currentDay"
                           changeOnMousewheel="false" style="width:40px;"
                           value="" allowNull="false"/>
                    <label>日</label>
                    <a class="nui-button" plain="true" iconCls="icon-search" onclick="search()">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
                    <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-tabs" style="width:100%;height:100%;" activeIndex="0">
        <div title="车辆汇总">
            <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                 pageSize="50"
                 sortMode="client"
                 totalField="page.count" allowSortColumn="true"
                 frozenStartColumn="0" frozenEndColumn="6">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
                    <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名称</div>
                    <div field="beginPeriodQty" headerAlign="center" allowSort="true" visible="true" width=""
                         datatype="int" align="right">期初车辆
                    </div>
                    <div field="endPeriodQty" headerAlign="center" allowSort="true" visible="true" width=""
                         datatype="int" align="right">期末车辆
                    </div>
                    <div field="flowInQty" headerAlign="center" allowSort="true" visible="true" width="" datatype="int"
                         align="right">流入车辆
                    </div>
                    <div field="flowOutQty" headerAlign="center" allowSort="true" visible="true" width="" datatype="int"
                         align="right">流出车辆
                    </div>
                    <div field="flowBackQty" headerAlign="center" allowSort="true" visible="true" width=""
                         datatype="int" align="right">回流车辆
                    </div>
                    <div field="newQty" headerAlign="center" allowSort="true" visible="true" width="" datatype="int"
                         align="right">新车客户
                    </div>
                    <div field="beginPeriodLostQty" headerAlign="center" allowSort="true" visible="true" width=""
                         datatype="int" align="right">期初流失
                    </div>
                    <div field="endPeriodLostQty" headerAlign="center" allowSort="true" visible="true" width=""
                         datatype="int" align="right">期末流失
                    </div>
                    <div field="listQty" headerAlign="center" allowSort="true" visible="true" width="" datatype="int"
                         align="right">净流失
                    </div>
                    <div field="lostRate" headerAlign="center" allowSort="true" visible="true" width="" datatype="int"
                         align="right" numberFormat="p">流失率
                    </div>
                </div>
            </div>
        </div>
        <div title="车辆走势图">
        </div>
    </div>
</div>
</body>
</html>