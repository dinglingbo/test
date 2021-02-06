<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 11:24:15
  - Description:
-->
<head>
<title>预约管理</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/BookingManagement/BookingManagementMain.js?v=1.0.22"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<input id="scoutMode" class="nui-combobox" visible="false"/>
<input id="isUsabled" class="nui-combobox" visible="false"/>
<input id="bookStatus" class="nui-combobox" visible="false"/>
<div class="nui-toolbar" style="border-bottom:0;">
    <div class="nui-form1" id="queryForm">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label>快速查询：</label>
                    <a class="nui-button" plain="true" onclick="quickSearch(0)" id="type0">本日预约车辆</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(2)" id="type2">本周预约车辆</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(4)" id="type4">本月预约车辆</a>
                    <span class="separator"></span>
                    <label>车牌号：</label>
                    <input class="nui-textbox" name="carNo"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" onclick="advancedSearch()" plain="true">更多</a>
                    <span class="separator"></span>
                    <label>仅显示本人预约</label>
                    <div class="nui-checkbox" name="showMeOnly" id="showMeOnly" trueValue="1" falseValue="0" value="1"></div>
    </td>
            </tr>
        </table>
    </div>
</div>

<div class="nui-toolbar" style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新</a>
                <a class="nui-button" plain="true" id="addBtn" iconCls="icon-add" onclick="add()">新增</a>
                <a class="nui-button" plain="true" enabled="false" id="saveBtn" iconCls="icon-save" onclick="save()">保存</a>
                <a class="nui-button" plain="true" enabled="false" id="cancelBtn" iconCls="icon-cancel" onclick="cancel()">取消</a>
                <a class="nui-button" plain="true" iconCls="" id="fllowUpBtn" onclick="fllowUp()">预约跟踪</a>
                <a class="nui-button" plain="true" iconCls="" onclick="quote()">转入报价</a>
                <a class="nui-button" plain="true" iconCls="" onclick="history()">维修历史</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;"
         borderStyle="border:0"
         allowResize="false">
        <div size="300" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid"
                     style="width: 100%; height: 100%;"
                     pageSize="20"
                     dataField="list"
                     showPageSize="false"
                     selectOnLoad="true"
                     sortMode="client"
                     showReloadButton="false" showPagerButtonIcon="true"
                     totalField="page.count"
                     allowSortColumn="true">
                    <div property="columns">
                        <div field="carNo" headerAlign="center" allowSort="true"
                             visible="true" width="">车牌号
                        </div>
                        <div field="bookStatus" headerAlign="center" allowSort="true"
                             visible="true" width="">预约状态
                        </div>
                        <div field="predictComeDate" headerAlign="center"
                             dateFormat="yyyy-MM-dd"
                             allowSort="true" visible="true">预约来厂日期
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-tabs" activeIndex="0" style="width:100%;height:100%">
                <div title="新增预约信息">
                    <div class="form" id="basicInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId" id="guestId"/>
                        <input class="nui-hidden" name="contactorId" id="contactorId"/>
                        <table>
                            <tr>
                                <td class="form_label">
                                    <label>车牌号：</label>
                                </td>
                                <td>
                                    <input class="nui-buttonedit" name="carId"
                                           onclick="selectCar"
                                           ebabled="false"
                                           id="carId"/>
                                </td>
                                <td class="form_label">
                                    <label>品牌：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="carBrandId" id="carBrandId"
                                           textField="nameCn"
                                           valueField="id"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>品牌车型：</label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-combobox"
                                           width="100%"
                                           textField="carModel"
                                           valueField="carModelId"
                                           id="carSeriesId"
                                           name="carSeriesId"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>联系人：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox"
                                           id="contactorName"
                                           name="contactorName"/>
                                </td>
                                <td class="form_label required">
                                    <label>联系电话：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="tel" id="tel"/>
                                </td>
                                <td class="form_label">
                                    <label>预约项目：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" id="prebookItem"
                                           name="prebookItem"
                                           textField="name"
                                           valueField="customid"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>预约来厂日期：</label>
                                </td>
                                <td>
                                    <input name="predictComeDate" class="nui-datepicker" viewDate="new Date()"
                                           nullValue="null" format="yyyy-MM-dd" showOkButton="true"
                                           showClearButton="false"/>
                                </td>
                                <td class="form_label">
                                    <label>登记日期：</label>
                                </td>
                                <td>
                                    <input name="recordDate"
                                           enabled="false"
                                           class="nui-datepicker"
                                           allowInput="false"
                                           format="yyyy-MM-dd" showOkButton="true" showClearButton="false"/>
                                </td>
                                <td class="form_label">
                                    <label>预约类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="prebookCategory"
                                           id="prebookCategory"
                                           textField="name"
                                           valueField="customid"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>预约单号：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="serviceCode" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>登记人：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="recorder" enabled="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>客户描述：</label>
                                </td>
                                <td colspan="5">
                                    <textarea class="nui-textarea"
                                              width="100%"
                                              name="faultDesc"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <label>预约跟踪明细</label>
                    </div>
                    <div class="nui-fit">
                        <div id="rightGrid"
                             class="nui-datagrid"
                             dataField="list"
                             style="width: 100%; height: 100%;"
                             showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                                <div header="基本信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="scoutMan" headerAlign="center"
                                             allowSort="true" visible="true" width="100">跟踪人
                                        </div>
                                        <div field="scoutDate" headerAlign="center"
                                             dateFormat="yyyy-MM-dd"
                                             allowSort="true" visible="true" width="100">跟踪日期
                                        </div>
                                        <div field="scoutMode"
                                             headerAlign="center" allowSort="true" visible="true"
                                             width="100">跟踪方式
                                        </div>
                                        <div field="isUsabled" headerAlign="center"
                                             allowSort="true" visible="true" width="100">跟踪结果
                                        </div>
                                        <div field="nextScoutDate" headerAlign="center"
                                             dateFormat="yyyy-MM-dd"
                                             allowSort="true" visible="true" width="100">下次跟踪日期
                                        </div>
                                    </div>
                                </div>
                                <div header="详细信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="scoutContent" headerAlign="center"
                                             allowSort="true" visible="true">跟踪内容
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:180px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">预计来厂 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td class="form_label">至:</td>
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
                <td class="form_label">品牌:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="carBrandId"
                           valueField="id" textField="nameCn"
                           id="carBrandId-ad"/>
                </td>
                <td class="form_label">车牌号:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="carNo"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">预约类型:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="prebookItem"
                           valueField="customid" textField="name"
                           id="prebookItem-ad"/>
                </td>
                <td class="form_label">车牌号:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="carNo"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchClear" style="width:60px;margin-right:20px;">清除</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>