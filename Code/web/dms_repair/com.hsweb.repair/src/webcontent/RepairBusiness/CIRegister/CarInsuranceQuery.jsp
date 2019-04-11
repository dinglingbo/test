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
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceQuery.js?v=1.0.38"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
                    <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >本日</a>
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
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"  onenter="onSearch()"/>
                    <label class="form_label">结算日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
	                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <a class="nui-button" iconCls="" onclick="advancedSearch()" plain="true"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                </td>
            </tr>
        </table> 
    </div> 
            <div  class="nui-fit">
                <div id="leftGrid" dataField="list" class="nui-datagrid" 
                 selectOnLoad="true"
                 showPager="true"
                 pageSize="500"
                 totalField="page.count"
                 sizeList=[500,1000,2000]
                 dataField="list" 
                 showModified="false"
                 showSummaryRow="true"
                 onrowdblclick=""
                 allowCellSelect="true"
                 editNextOnEnterKey="true"
                 allowCellWrap = true
                 style="height:100%;width:100%;"
                 sortMode="client"
                 onshowrowdetail="onShowRowDetail">
                <div property="columns">
                    <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
                    <div type="expandcolumn" width="20" visible="false"><span class="fa fa-plus fa-lg"></span></div>
                    <div header="客户车辆信息" headerAlign="center">
                      <div property="columns" >	
		                <div field="id" headeralign="center" allowsort="true" visible="false" >主键</div>
		                <div field="guestName" name="guestName" headeralign="center" allowsort="false" visible="true" >客户名称</div>
		                <div field="mobile" headeralign="center" allowsort="false" visible="true" >客户手机</div>
		                <div field="carNo" name="carNo" headeralign="center" allowsort="false" visible="true" >车牌号</div>
		                <div field="carModel" name="carModel"  headeralign="ture" allowsort="false" visible="true">品牌车型</div>
		                <div field="carVin" headeralign="center" allowsort="false" visible="true">车架号(VIN)</div>
                      </div>
                    </div>
	                <div header="保单信息" headerAlign="center">
	                   <div property="columns" >
	                     <div field="serviceCode" name="serviceCode" headeralign="center" allowsort="false" visible="true" >工单号</div>
	                     <div field="outDate" name=""  headerAlign="center" header="结算日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                     <div field="insureCompName" name="insureCompName"  headeralign="center" allowsort="false" visible="true" >保险公司</div>
	                     <div field="mtAdvisor" name="mtAdvisor"  headeralign="center" ture visible="true">服务顾问</div>
	                     <div field="saleMans" name="saleMans"  headeralign="center" allowsort="false" visible="true" >销售员</div>
	                     <div field="beginDate" name=""  headerAlign="center" header="有效开始日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                     <div field="endDate" name=""  headerAlign="center" header="有效结束日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                     <div field="settleTypeId" headeralign="center" allowsort="ture" visible="true" >保费收取方式</div>
	                     <div field="amt" name="amt"  headerAlign="center" header="保费总金额" ></div>
	                     <div field="rtnCompAmt" name="partAmt"  headerAlign="center" header="保司返点总金额" ></div>
	                     <div field="rtnGuestAmt" name="partAmt"  headerAlign="center" header="客户返点总金额" ></div>
	                     <div field="balaAmt" name="balaAmt"  headerAlign="center" header="结算金额" ></div>  
	                     <div field="grossProfit" name="grossProfit"  headerAlign="center" header="毛利" ></div>  
	                     <div field="grossProfitRate" name="grossProfitRate"  headerAlign="center" header="毛利率" ></div>
	                     <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" ></div>
                       </div>
                     </div>					
                    <div header="保费信息" headerAlign="center">
                       <div property="columns" >
		                <div field="insureTypeName" name="insureTypeName"  headerAlign="center" allowSort="false" visible="true" width="100" header="险种名称"></div>
		                <div field="insureNo" name=""  headerAlign="center" header="交强险/商业险单号" ></div>
		                <div field="damt" headerAlign="center" allowSort="false" header="保司保费" align="center" summaryType="sum"></div>
		                <div field="drtnCompRate" headerAlign="center" allowSort="false" header="保司返点" align="center"></div>
		                <div field="drtnCompAmt" headerAlign="center" allowSort="false" header="保司返点金额" align="center" summaryType="sum"></div>
		                <div field="drtnGuestRate" headerAlign="center" allowSort="false" header="客户返点" align="center" ></div>
		                <div field="drtnGuestAmt" headerAlign="center" allowSort="false" header="客户返点金额" align="center" summaryType="sum"></div>
		                
                     </div>
                   </div>
                </div>
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