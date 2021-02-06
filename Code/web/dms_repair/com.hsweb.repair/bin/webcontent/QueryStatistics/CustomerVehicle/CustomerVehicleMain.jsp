<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:15:59
  - Description:
-->
<head>
<title>客户车辆明细</title>
<script src="<%=request.getContextPath()%>/repair/js/CustomerVehicle/CustomerVehicleMain.js?v=1.0.0"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="orgId" visible="false"/>
<input class="nui-combobox" id="carBrand" visible="false"/>
<input class="nui-combobox" id="insureComp" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">日期：</label>
                </td>
                <td>
                    <input class="nui-datepicker" format="yyyy-MM-dd" id="queryDate"
                           allowInput="false" showClearButton="false" allowNull="false"
                           name="queryDate"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-tabs" style="width:100%;height:100%;" activeIndex="0" id="mainTab">
        <div title="期初车辆">
            <div class="nui-fit">
                <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div title="期末车辆">
            <div class="nui-fit">
                <div id="grid2" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="流入车辆">
            <div id="grid3" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                 showPager="false" sortMode="client"
                 allowSortColumn="true"
                 frozenStartColumn="0" frozenEndColumn="11">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                    <div header="客户信息" headerAlign="center">
                        <div property="columns">
                            <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                            <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                            <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                            <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                            <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                            <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                            <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                            <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                            <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                            <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                            <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                        </div>
                    </div>
                    <div header="车辆信息" headerAlign="center">
                        <div property="columns">
                            <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                            <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                            <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                            <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                            <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                            <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                        </div>
                    </div>
                    <div header="其他信息" headerAlign="center">
                        <div property="columns">
                            <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                            <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                            <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="流出车辆">
            <div class="nui-fit">
                <div id="grid4" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="回流车辆">
            <div class="nui-fit">
                <div id="grid5" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="新车客户">
            <div class="nui-fit">
                <div id="grid6" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="期初流失车辆">
            <div class="nui-fit">
                <div id="grid7" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="期末流失车辆">
            <div class="nui-fit">
                <div id="grid8" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                     showPager="false" sortMode="client"
                     allowSortColumn="true"
                     frozenStartColumn="0" frozenEndColumn="11">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                        <div header="客户信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">公司名字</div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="100">维修单号</div>
                                <div field="guestFullName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="60">维修顾问</div>
                                <div field="" headerAlign="center" allowSort="true" visible="true" width="60">回访员</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="65">车牌号</div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60">品牌</div>
                                <div field="lastComeDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后来厂日期</div>
                                <div field="lastLeaveDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">最后离厂日期</div>
                                <div field="chainComeTimes" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">来厂次数</div>
                                <div field="leaveDay" headerAlign="center" allowSort="true" visible="true" width="55" datatype="int" align="right">离厂天数</div>
                            </div>
                        </div>
                        <div header="车辆信息" headerAlign="center">
                            <div property="columns">
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="underpanNo" headerAlign="center" allowSort="true" visible="true" width="">底盘号</div>
                                <div field="insureDueDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">保险到期</div>
                                <div field="annualInspectionDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">年审日期</div>
                                <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy-MM-dd">建档日期</div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="engineNo" headerAlign="center" allowSort="true" visible="true" width="80">发动机号</div>
                                <div field="produceDate" headerAlign="center" allowSort="true" visible="true" width="80" dateFormat="yyyy">生产年份</div>
                                <div field="color" headerAlign="center" allowSort="true" visible="true" width="50">颜色</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div title="名词解释">
            <div class="nui-panel" showToolbar="false" title="" showHeader="false" showFooter="true"
                 style="width:100%;height:95%">
                <table>
                    <tr>
                        <td style="width:200px">
                            <label>期初车辆</label>
                        </td>
                        <td style="width:600px">
                            <label>查询时间点前150天至前30天在店维修的车辆。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>期末车辆</label>
                        </td>
                        <td style="width:600px">
                            <label>查询时间点往前120天在店维修的车辆。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>首次到店车辆</label>
                        </td>
                        <td style="width:600px">
                            <label>首次到连锁任意分店维修的车辆。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>流出客户</label>
                        </td>
                        <td style="width:600px">
                            <label>本店的车辆转出到其他店维修。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>流入客户</label>
                        </td>
                        <td style="width:600px">
                            <label>其他店的车辆转入本店维修。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>流失客户</label>
                        </td>
                        <td style="width:600px">
                            <label>最近出厂时间超过120天的车辆，且不在厂维修。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>期初流失</label>
                        </td>
                        <td style="width:600px">
                            <label>开店时间至当前时间前30天所有超过120天未来厂客户。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>期末流失</label>
                        </td>
                        <td style="width:600px">
                            <label>开店时间到当前时间所有超过120天未来厂客户。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>净流失</label>
                        </td>
                        <td style="width:600px">
                            <label>期末流失-期初流失。</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">
                            <label>回流客户</label>
                        </td>
                        <td style="width:600px">
                            <label>已流失车辆再回厂维修。</label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

    </div>
</div>
</body>
</html>