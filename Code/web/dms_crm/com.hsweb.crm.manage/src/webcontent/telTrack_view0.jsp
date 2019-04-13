<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
     <%@include file="/common/commonRepair.jsp"%>
<html>
<!--
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>电话跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/telTrack.js?v=1.0.20"></script>
        <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
</head>
<body>
    <div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
        <div size="70%" showCollapseButton="true">
<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td><!-- style="white-space:nowrap;"-->
                <!-- <label style="font-family:Verdana;" title="点击清空条件"><span onclick="clearQueryForm()">快速查询：</span></label> -->
                <input name="orgid"
                    id="query_orgid"
                    visible="false"
                    class="nui-combobox width2"
                    textField="orgname"
                    valueField="orgid"
                    emptyText="请选择..."
                    url=""
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <input name="artType"
                    id="artType"
                    visible="false"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <input name="visitStatus"
                    id="query_visitStatus"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="选择跟踪状态"
                    url=""
                    value="060706" 
                    onvaluechanged="query()"
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="true"
                    nullItemText="请选择..."
                    style="width:130px;"/>

	                 <input class="nui-combobox"
	                  id="carBrandId"
	                  name="carBrandId"
	                  textField="empName"
	                  valueField="empId"
	          		  visible="false"
	                  url=""
	                  allowInput="true"
	                  valueFromSelect="false"
	                  width="100px">
                <input class="nui-textbox" name="carNo" id="query_carno" enabled="true"style="width:100px;" emptyText="车牌号"/>
                <input class="nui-combobox"
	                  id="visitManId"
	                  name="visitManId"
	                  textField="empName"
	                  valueField="empId"
	          		  visible="true"
	                  url=""
	                  allowInput="true"
                      valueFromSelect="false"
                      emptyText="营销员"
                      popupwidth="150px;"
	                  width="100px">
               <!--  <label style="font-family:Verdana;">手机号：</label>
                <input class="nui-textbox" name="mobile" id="query_mobile" enabled="true"/> -->

                <input id="query_nextScoutDate"
                    name="nextScoutDate"
                    class="nui-datepicker width2"
                    dateFormat="yyyy-MM-dd"
                    emptyText="下次跟踪时间" alwaysView="true"
                    style="width:120px;"/>
                <a class="nui-button"  plain="true" onclick="query()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <li class="separator"></li>
                <a class="nui-button"  plain="true" onclick="telInfo()" id="" enabled="true"><span class="fa fa-phone fa-lg"></span>&nbsp;电话跟踪</a>
                <a class="nui-button"  plain="true" onclick="sendInfo()" id="add" enabled="true"><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                <a class="nui-button"  plain="true" onclick="addRow()" id="" enabled="true"><span class="fa fa-wrench fa-lg"></span>&nbsp;预约登记</a>
                <li class="separator"></li>
                <a class="nui-button"  plain="true" onclick="newClient()" id="edit" enabled="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增客户资料</a>
                <a class="nui-button"  plain="true" onclick="editClient()" id="" enabled="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改客户资料</a>
            </td>
        </tr>
    </table>
</div>



            <div class="nui-fit">
                <div title="" class="nui-panel"
                     showHeader="false"
                     showFooter="false"
                     style="width:100%;height:100%;border: 0;">
                    <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
                        showPager="true"
                        totalField="page.count"
                        pageSize="50" sizeList=[20,50,100]
                        selectOnLoad="true"
                        ondrawcell=""
                        onrowdblclick="telInfo"
                        dataField="data"
                        allowCellWrap = true
                        virtualColumns="true"
                        idField="id"
                        sortMode="client"
                        allowSortColumn="true"
                        showSummaryRow="true">
                        <div property="columns">
                            <div type="checkcolumn" width="20"></div>
                            <div type="indexcolumn" width="40" summaryType="count">序号</div>
                            <div headerAlign="center">车辆信息
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="carNo" width="80" headerAlign="center" allowSort="true" dataType="string">车牌号</div>
                                   
                                    <div field="carModel" name="carModel" width="250" headerAlign="center"allowSort="true" dataType="string">品牌车型</div>
                                    <div field="vin" width="150" headerAlign="center" allowSort="true" dataType="string">车架号(VIN)</div>
                                    <div field="firstRegDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" dataType="date">上牌日期</div>
                                    <div field="annualInspectionDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" dataType="date">商业险到期</div>
                                    <div field="insureDueDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" dataType="date">交强险到期</div>
                                    <div field="annualVerificationDueDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" dataType="date">车辆年检到期</div>


                                </div>
                            </div> 
                            <div headerAlign="center">客户信息
                                <div property="columns">
                                    <div field="guestId" visible=false>客户ID</div>
                                    <div field="drivingLicenceDueDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" dataType="date">驾照年审到期</div>
                                    <div field="guestName" name="guestName" width="80" headerAlign="center" summaryType="" allowSort="true" dataType="string">客户名称</div>
                                    <div field="contacts" name="contacts" width="80" headerAlign="center" summaryType="" allowSort="true" dataType="string">联系人</div>
                                    <div field="mobile" width="100" headerAlign="center" summaryType="" allowSort="true" dataType="string">手机号</div>
                                    <div field="address" width="150" headerAlign="center" summaryType="" allowSort="true" dataType="string">地址</div>
                                    <!--
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort="true" dataType="string">客户等级</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort="true" dataType="string">来厂次数</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort="true" dataType="string">离厂天数</div>
                                    -->
                                </div>
                            </div>
                            <div headerAlign="center">联系状态
                                <div property="columns">
                                    <div field="visitManId" width="60" headerAlign="center" summaryType="" allowSort="true" dataType="string">营销员</div>
                                    <div field="visitStatus" width="100" headerAlign="center"allowSort="true" dataType="string">跟踪状态</div>
                                    <div field="priorScoutDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date">上次联系时间</div>
                                    <div field="nextScoutDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date">下次联系时间</div>
                                </div>
                            </div>
                            <div headerAlign="center">其他
                                <div property="columns">
                                	<div field="orgid" width="100" headerAlign="center" allowSort="true" dataType="string">所在分店</div>
                                    <div field="recorder" name="recorder" width="80" headerAlign="center" allowSort="true" dataType="string">建档人</div>
                                    <div field="recordDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date">建档日期</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div >
                <%@include file="/manage/maintainRemind/visitHistoryList.jsp" %>
    </div>
</div>
</body>
</html>