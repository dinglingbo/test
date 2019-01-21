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
    <title>查车单明细表</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/checkMainDetail.js?v=1.0.2"></script>
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
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch"/>
                    <!-- <input class="nui-textbox" id="checkMan" emptyText="查车技师名称" width="120" onenter="onSearch"/> -->
                    <input name="mtAdvisorId"
                       id="mtAdvisorId"
                       class="nui-combobox width1"
                       textField="empName"
                       valueField="empId"
                       emptyText="查车技师"
                       url=""
                       allowInput="true"
                       showNullItem="false"
                       valueFromSelect="true"
                       nullItemText="请选择..." onenter="onSearch" onvaluechanged="onSearch"/>
                    <label class="form_label">查车日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <a class="nui-button" iconCls="" onclick="advancedSearch()" plain="true"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                <input  class="nui-combobox" style="display:none; width:100%;" name="checkTypeA" id="checkTypeA"
	                     textfield="name" valuefield="customid" dataFile="data"  allowInput="true" visible="false"/>
                </td>
            </tr>
        </table> 
    </div> 
           <div  class="nui-fit">
                <div id="leftGrid" dataField="list" class="nui-datagrid" 
                 selectOnLoad="true"
                 showPager="true"
                 pageSize="50"
                 totalField="page.count"
                 sizeList=[20,50,100,200]
                 dataField="list" 
                 showModified="false"
                 onrowdblclick=""
                 allowCellSelect="true"
                 editNextOnEnterKey="true"
                 allowCellWrap = true
                 style="height:100%;width:100%;"
                 onshowrowdetail="onShowRowDetail">
                <div property="columns">
                    <div type="indexcolumn" headeralign="center" allowsort="true" visible="true" width="30">序号</div>
                    <div type="expandcolumn" width="20" visible="true"><span class="fa fa-plus fa-lg"></span></div>
                    <div header="客户车辆信息" headerAlign="center">
                       <div property="columns" >	
		                <div field="id" headeralign="center" allowsort="true" visible="false" >主键</div>
		                <div field="contactName" headeralign="center" allowsort="true" visible="true" >客户名称</div>
		                <div field="contactMobile" headeralign="center" allowsort="true" visible="true" >客户手机</div>
		                <div field="carNo" headeralign="center" allowsort="true" visible="true" >车牌号</div>
		                <div field="carModel" headeralign="center" allowsort="true" visible="true">品牌车型</div>
		                <div field="carVin" headeralign="center" allowsort="true" visible="true" width="120">车架号(VIN)</div>
                      </div>
                    </div>
                    <div header="工单信息" headerAlign="center">
                      <div property="columns" >	
                          <div field="serviceCode" name="serviceCode" width="140" headerAlign="center" header="工单号"></div> 
                          <div field="checkMan" name="recordDate" width="100" headerAlign="center" header="查车技师" ></div>
                          <div field="checkPoint" headerAlign="center" allowSort="false" visible="true"  align="center" header="本次检查得分"> </div>
                          <div field="lastPoint" headerAlign="center" allowSort="false" visible="true"  align="center" header="上次次检查得分"> </div>
                          <div field="lastCheckDate" name="lastCheckDate" width="100" headerAlign="center" header="上次检查时间" dateFormat="yyyy-MM-dd HH:mm"></div>
                          <div field="checkDate" name="checkDate" width="100" headerAlign="center" header="本次检查时间" dateFormat="yyyy-MM-dd HH:mm"></div>
                          <div field="enterKilometers" headerAlign="center" allowSort="false" visible="true"   align="center" header="本次检查里程"> </div>
                          <div field="lastKilometers" headerAlign="center" allowSort="false" visible="true"   align="center" header="上次检查里程"> </div>
                      </div>
                   </div>
                </div>
            </div>
       </div>
       <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
             <div id="innerPartGrid"
             dataField="list"
             class="nui-datagrid"
             style="width: 100%; height: 200px;"
             showPager="false"
             allowSortColumn="true">
             <div property="columns">
                 <div headerAlign="center" type="indexcolumn" width="20">序号</div>
                 <div field="checkType" headerAlign="center" allowSort="false" visible="true" width="100" header="检查类型"></div> 
                 <div field="checkName" headerAlign="center" allowSort="false"  width="80px" header="检查项目" align="center"></div>   
                 <div field="status" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="是否正常" > </div>
                 <div field="checkRemark" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="检查说明"> </div>
                 <div field="settleType" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="处理意见"> </div>
                 <div field="careDueDate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="下次处理时间" dateFormat="yyyy-MM-dd HH:mm"> </div>
                 <div field="careDueMileage" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="下次处理里程"> </div>
             </div>
         </div>
       </div>
</body>
</html>