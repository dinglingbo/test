<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 16:36:01
  - Description:
-->
<head>
<title>车间效率分析</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/WorkshopManagement/WorkshopEfficiency/WorkshopEfficiencyMain.js?v=1.0.2"></script>
<style type="text/css">
.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
</head>
<body>
<input class="nui-combobox" id="orgId" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoFrom">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <label>年份：</label>
                    <input class="nui-spinner" maxValue="2200" minValue="1900" showButton="false"
                           name="year" id="year"
                           changeOnMousewheel="false" allowNull="true" style="width: 50px;"/>
                    <label>月份：</label>
                    <input class="nui-spinner" maxValue="12" minValue="1" showButton="false"
                           name="month" id="month"
                           changeOnMousewheel="false" allowNull="true" style="width: 50px;"/>
                </td>
                <td>
                    <div class="nui-radiobuttonlist" valueField="id" repeatItems="2" textField="text"
                         repeatLayout="table" name="countField1" id="countField1" value="b.item_time"
                         data="[{ id:'b.item_time', text: '项目' },{ id: 'b.amt', text: '项目金额' }]">
                    </div>
                </td>
                <td>
                    <label>统计日期:</label>
                </td>
                <td>
                    <div class="nui-radiobuttonlist" valueField="id" repeatItems="2" textField="text"
                         repeatLayout="table" name="countField2" id="countField2" value="c.sure_mt_date"
                         data="[{ id:'c.sure_mt_date', text: '维修日期' },{ id: 'c.out_date', text: '结算日期' }]">
                    </div>
                </td>
                <td>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">统计</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印(P)</a>
                <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
         sortMode="client"
         allowSortColumn="true" virtualScroll="true" virtualColumns="true"
         frozenStartColumn="0" frozenEndColumn="3">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="100px">分店名称</div>
                    <div field="className" headerAlign="center" allowSort="true" visible="true" width="70px">班组名称</div>
                    <div field="worker" headerAlign="center" allowSort="true" visible="true" width="70px">成员名称</div>
                </div>
            </div>
            <div header="项目信息" headerAlign="center">
                <div property="columns">
                    <div field="t1" headerAlign="center" allowSort="true" visible="true" width="60px">1号</div>
                    <div field="t2" headerAlign="center" allowSort="true" visible="true" width="60px">2号</div>
                    <div field="t3" headerAlign="center" allowSort="true" visible="true" width="60px">3号</div>
                    <div field="t4" headerAlign="center" allowSort="true" visible="true" width="60px">4号</div>
                    <div field="t5" headerAlign="center" allowSort="true" visible="true" width="60px">5号</div>
                    <div field="t6" headerAlign="center" allowSort="true" visible="true" width="60px">6号</div>
                    <div field="t7" headerAlign="center" allowSort="true" visible="true" width="60px">7号</div>
                    <div field="t8" headerAlign="center" allowSort="true" visible="true" width="60px">8号</div>
                    <div field="t9" headerAlign="center" allowSort="true" visible="true" width="60px">9号</div>
                    <div field="t10" headerAlign="center" allowSort="true" visible="true" width="60px">10号</div>
                    <div field="t11" headerAlign="center" allowSort="true" visible="true" width="60px">11号</div>
                    <div field="t12" headerAlign="center" allowSort="true" visible="true" width="60px">12号</div>
                    <div field="t13" headerAlign="center" allowSort="true" visible="true" width="60px">13号</div>
                    <div field="t14" headerAlign="center" allowSort="true" visible="true" width="60px">14号</div>
                    <div field="t15" headerAlign="center" allowSort="true" visible="true" width="60px">15号</div>
                    <div field="t16" headerAlign="center" allowSort="true" visible="true" width="60px">16号</div>
                    <div field="t17" headerAlign="center" allowSort="true" visible="true" width="60px">17号</div>
                    <div field="t18" headerAlign="center" allowSort="true" visible="true" width="60px">18号</div>
                    <div field="t19" headerAlign="center" allowSort="true" visible="true" width="60px">19号</div>
                    <div field="t20" headerAlign="center" allowSort="true" visible="true" width="60px">20号</div>
                    <div field="t21" headerAlign="center" allowSort="true" visible="true" width="60px">21号</div>
                    <div field="t22" headerAlign="center" allowSort="true" visible="true" width="60px">22号</div>
                    <div field="t23" headerAlign="center" allowSort="true" visible="true" width="60px">23号</div>
                    <div field="t24" headerAlign="center" allowSort="true" visible="true" width="60px">24号</div>
                    <div field="t25" headerAlign="center" allowSort="true" visible="true" width="60px">25号</div>
                    <div field="t26" headerAlign="center" allowSort="true" visible="true" width="60px">26号</div>
                    <div field="t27" headerAlign="center" allowSort="true" visible="true" width="60px">27号</div>
                    <div field="t28" headerAlign="center" allowSort="true" visible="true" width="60px">28号</div>
                    <div field="t29" headerAlign="center" allowSort="true" visible="true" width="60px">29号</div>
                    <div field="t30" headerAlign="center" allowSort="true" visible="true" width="60px">30号</div>
                    <div field="t31" headerAlign="center" allowSort="true" visible="true" width="60px">31号</div>
                    <div field="tall" headerAlign="center" allowSort="true" visible="true" width="60px">合计</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>