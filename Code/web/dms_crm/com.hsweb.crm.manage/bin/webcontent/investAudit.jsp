<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>业绩审核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/investAudit.js?v=1.0.34"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table style="width:100%;">
        <tr>
            <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
                    <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                     <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                     <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                     <li class="separator"></li>
                     <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                     <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                     <li class="separator"></li>
                     <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                     <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                     <li class="separator"></li>
                     <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                     <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                 </ul>
                 录入日期:
                 <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                 <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />

              <input class="nui-combobox" id="carBrandId"   name="carBrandId" textField="empName"
              valueField="empId" visible="false" allowInput="true"valueFromSelect="false">
              <input class="nui-combobox" id="serviceTypeId"   name="serviceTypeId" textField="empName"
              valueField="empId" visible="false" allowInput="true"valueFromSelect="false">
              <span>车牌号:</span>
              <input id="carNo" class="nui-textbox" emptyText="输入查询条件" width="120"/>
              <span>工单号:</span>
              <input id="serviceCode" class="nui-textbox" emptyText="输入查询条件" width="120"/>
              <span>审核状态:</span>
              <input id="auditSign" class="nui-combobox" data="gAuditSign" emptyText="输入查询条件" width="120" showNullItem="true" nullItemText="请选择..."/>
              <a class="nui-button"  plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
              <a class="nui-button" iconCls="" plain="true" onclick="onAuditClick(1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核通过</a>
              <a class="nui-button" iconCls="" plain="true" onclick="onAuditClick(2)"><span class="fa fa-remove fa-lg"></span>&nbsp;审核不通过</a>
              <!-- <a class="nui-button" iconCls="" plain="true" onclick="onDeleteClick()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
              <a class="nui-button" iconCls="" plain="true" onclick="trackDetail()"><span class="fa fa-history fa-lg"></span>&nbsp;跟踪记录</a>
          </td>
      </tr>
  </table>
</div>

<div class="nui-fit">

    <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    multiSelect="false"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    ondrawcell="onDrawcell"
    onrowclick="onRowclick"
    allowCellWrap = true
    >
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" width="40">序号</div> 
        <div header="业绩信息" headerAlign="center">
            <div property="columns">
                <div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌号"></div>
                <div field="serviceCode" name="serviceCode" width="130" headerAlign="center" header="工单号"></div>
                <div field="visitMan" name="visitMan" width="80" headerAlign="center" header="营销员"></div>
                <div field="carType" name="carType" width="80" headerAlign="center" header="来厂类型"></div>
                <div field="recorder" name="recorder" width="80" headerAlign="center" header="录入人"></div>
                <div field="recordDate" name="recordDate" width="130" headerAlign="center" header="录入日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div field="auditSign" name="auditSign" width="80" headerAlign="center" header="审核状态"></div>
                <div field="auditDate" name="auditDate" width="130" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div field="auditOpinion" name="auditOpinion" width="100" headerAlign="center" header="审核备注"></div>
                <div field="remark" name="remark" width="100" headerAlign="center" header="业绩备注"></div>
                <div field="modifier" name="modifier" width="80" headerAlign="center" header="最后修改人"></div>
                <div field="modifyDate" name="modifyDate" width="130" headerAlign="center" header="最后修改日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            </div>
        </div>
        <div header="维修信息" headerAlign="center">
            <div property="columns">
                <div field="serviceTypeId" name="serviceTypeId" width="130" headerAlign="center" header="业务类型 "></div>
                <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" header="维修顾问 "></div>
                <div field="partTotalAmt" name="partTotalAmt" width="80" headerAlign="center" header="材料金额 "></div>
                <div field="itemTotalAmt" name="itemTotalAmt" width="80" headerAlign="center" header="项目金额 "></div>  
            </div>
        </div>
        <div header="车辆信息" headerAlign="center">
            <div property="columns">
                <div field="compComeTimes" name="compComeTimes" width="80" headerAlign="center" header="分店来厂次数"></div>
                <div field="chainComeTimes" name="chainComeTimes" width="80" headerAlign="center" header="连锁来厂次数"></div>
            
                <div field="carModel" name="carModel" width="280" headerAlign="center" header="品牌车型"></div>
                <div field="engineNo" name="engineNo" width="130" headerAlign="center" header="发动机号"></div>
                <div field="vin" name="vin" width="180" headerAlign="center" header="车架号(VIN)"></div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>