<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
    <title>车险登记</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceMain.js?v=1.0.61"></script>
    <style type="text/css">

    table {
        font-size: 12px;
    }

    .form_label {
        width: 84px;
    }
</style>

</head>
<body>
    <div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;">

        <table class="table" id="table1"> 
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
                    <a class="nui-menubutton" plain="true" iconCls="icon-date" id="searchByDateBtn" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="icon-date" onclick="quickSearch(0)">本日</li>
                        <li iconCls="icon-date" onclick="quickSearch(1)">昨日</li>
                        <li iconCls="icon-date" onclick="quickSearch(2)">本周</li>
                        <li iconCls="icon-date" onclick="quickSearch(3)">上周</li>
                        <li iconCls="icon-date" onclick="quickSearch(4)">本月</li>
                        <li iconCls="icon-date" onclick="quickSearch(5)">上月</li>
                        <li iconCls="icon-date" onclick="quickSearch(6)">本年</li>
                        <li iconCls="icon-date" onclick="quickSearch(7)">上年</li>
                    </ul>
                </td>
                               <td>
                    <label class="form_label">车牌号：</label>
                    <input class="nui-textbox" name="carNo" id="carNo-search"/>
                    <label class="form_label">客户名称：</label>
                    <input class="nui-textbox" name="guestName" id="guestName"/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" onclick="advancedSearch()" plain="true"><span class="fa fa-binoculars fa-lg"></span>&nbsp;更多</a>
                </td>
                <td>
                        <!-- <input class="nui-hidden" id="cNo" name="cNo" value='<b:write property="cNo"/>'/>
                        <input class="nui-textbox" id="guestName" name="guestName" emptyText="输入客户姓名" width="120" />
                        <input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="请输入单号" width="120" />
                        <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="120" />
                        <a class="nui-button" iconCls="" plain="true" onclick="onSearch"> 
                        <span class="fa fa-search fa-lg"></span>&nbsp;查询
                    </a>-->
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="">
                     <span class="fa fa-plus fa-lg"></span>&nbsp;新建车险登记
                 </a>

                 <a class="nui-button" iconCls="" plain="true" onclick="view()" id="">
                    <span class="fa fa-file-text-o fa-lg"></span>&nbsp;查看
                </a>
            </td>
        </tr>
    </table> 
</div> 
<div class="nui-fit">
    <div id="leftGrid" dataField="list" class="nui-datagrid" 
    style="width: 100%; height: 100%;"
    pageSize="50"
    totalField="page.count"
    sortMode="client"
    selectOnLoad="true"
    allowSortColumn="true">
    <div property="columns">
        <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
        <div header="">
            <div property="columns">
                <div field="status" headeralign="center" allowsort="true" visible="true" width="40px">状态</div>
            </div>
        </div> 
        <div header="客户信息">
            <div property="columns">
                <div field="carNo" headeralign="center" allowsort="true" visible="true" width="60px">车牌号</div>
                <div field="insuranceMan" headeralign="center" allowsort="true" visible="true" width="80px">被保险人</div>
                <div field="carBrandId" headeralign="center" allowsort="true" visible="true" width="60px">品牌</div>
                <div field="carModel" headeralign="center" allowsort="true" visible="true" width="180px">车型</div>
            </div>
        </div>
        <div header="交强险" headeralign="center">
            <div property="columns">
                <div field="insuranceSaliDate" headeralign="center" dateformat="yyyy-MM-dd" allowsort="true" visible="true" width="100px">购买日期</div>
                <div field="insuranceSaliDue" headeralign="center" dateformat="yyyy-MM-dd" allowsort="true" visible="true" width="100px">到期日期</div>
            </div>
        </div>
        <div header="商业险" headeralign="center">
            <div property="columns">
                <div field="insuranceBizDate" headeralign="center" dateformat="yyyy-MM-dd" allowsort="true" visible="true" width="100px">购买日期</div>
                <div field="insuranceBizDue" headeralign="center" dateformat="yyyy-MM-dd" allowsort="true" visible="true" width="100px">到期日期</div>
            </div>
        </div>
        <div header="">
            <div property="columns">
                <div field="serviceCode" headeralign="center" allowsort="true" visible="true" width="150px">工单号</div>
            </div>
        </div>
    </div>
</div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:420px;height:300px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">登记日期 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td>至:</td>
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
                <td class="form_label">交强险保单号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="insuranceSaliNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">交强险保单号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="insuranceBizNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">底盘号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="underpanNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">车牌号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" name="carNoList"></textarea>
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