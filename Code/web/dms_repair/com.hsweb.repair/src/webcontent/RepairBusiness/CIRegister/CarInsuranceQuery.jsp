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
    <title>保险开单查询</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceQuery.js?v=1.0.26"></script>
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
                    <a class="nui-menubutton" plain="true" iconCls="" id="searchByDateBtn" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)">本日</li>
                        <li iconCls="" onclick="quickSearch(1)">昨日</li>
                        <li iconCls="" onclick="quickSearch(2)">本周</li>
                        <li iconCls="" onclick="quickSearch(3)">上周</li>
                        <li iconCls="" onclick="quickSearch(4)">本月</li>
                        <li iconCls="" onclick="quickSearch(5)">上月</li>
                        <li iconCls="" onclick="quickSearch(6)">本年</li>
                        <li iconCls="" onclick="quickSearch(7)">上年</li>
                    </ul>
                </td>
                <td>
                    <label class="form_label">车牌号：</label>
                    <input class="nui-textbox" name="carNo" id="carNo-search"/>
                    <label class="form_label">客户名称：</label>
                    <input class="nui-textbox" name="guestName" id="guestName"/>
                    <label class="form_label">开单日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" onclick="advancedSearch()" plain="true"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
             
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
                onrowdblclick=""
               	allowCellSelect="true"
               	editNextOnEnterKey="true"
              	onshowrowdetail="onShowRowDetail"
               	allowCellEdit="true"
               	allowCellWrap = true
                allowSortColumn="true">
                <div property="columns">
                    <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
                    <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                    <div field="id" headeralign="center" allowsort="true" visible="false" width="80px">主键</div>
                    <div field="carNo" headeralign="center" allowsort="true" visible="true" width="90px">车牌</div>
                    <div field="carBrandId" headeralign="center" allowsort="true" visible="true" width="80px">品牌</div>
                    <div field="carModel" headeralign="center" allowsort="true" visible="true" width="280px">车型</div>
                    <div field="carVin" headeralign="center" allowsort="true" visible="true" width="130px">VIN码</div>
                    <div field="guestName" headeralign="center" allowsort="true" visible="true" width="80px">客户名称</div>
<!--                     <div field="mobile" headeralign="center" allowsort="true" visible="true" width="100px">客户手机</div> -->
                    <div field="insureCompName" headeralign="center" allowsort="true" visible="true" width="250px">保险公司</div>
					<div field="saleMans" headeralign="center" allowsort="true" visible="true" width="100px">销售员</div>
                    <div field="serviceCode" headeralign="center" allowsort="true" visible="true" width="120px">工单号</div>
                    <div field="outDate" name="" width="130" headerAlign="center" header="结算日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="beginDate" name="" width="130" headerAlign="center" header="有效开始日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="endDate" name="" width="130" headerAlign="center" header="有效结束日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="settleTypeId" headeralign="center" allowsort="true" visible="true" width="100px">保费收取方式</div>
                    <div field="amt" name="amt" width="80" headerAlign="center" header="保司保费总金额"></div>
                    <div field="rtnCompAmt" name="partAmt" width="80" headerAlign="center" header="保司返点总金额"></div>
                    <div field="rtnGuestAmt" name="partAmt" width="80" headerAlign="center" header="客户返点总金额"></div>
                </div>
            </div>
            <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
             <div id="innerPartGrid"
             dataField="list"
             class="nui-datagrid"
             style="width: 100%; height: 100px;"
             showPager="false"
             allowSortColumn="true">
             <div property="columns">
                 <div headerAlign="center" type="indexcolumn" width="20">序号</div>
                 <div field="insureTypeName" headerAlign="center" allowSort="false" visible="true" width="100" header="险种"></div> 
                 <div field="amt" headerAlign="center" allowSort="false"  width="80px" header="保司保费" align="center"></div>   
                 <div field="rtnCompAmt" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="保司返点" > </div>
                 <div field="rtnGuestAmt" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="客户返点"> </div>
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