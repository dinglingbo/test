<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	 <%@include file="/common/sysCommon.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>电话跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/telTrack.js?v=1.0.0"></script>
    <link href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td><!-- style="white-space:nowrap;"-->
                <label style="font-family:Verdana;" title="点击清空条件"><span onclick="clearQueryForm()">快速查询：</span></label>
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
                <label style="font-family:Verdana;">跟踪状态：</label>
                <input name="visitStatus"
                    id="query_visitStatus"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    url=""
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <label style="font-family:Verdana;">车牌号：</label>
                <input class="nui-textbox" name="carNo" id="query_carno" enabled="true"/>
                
                <label style="font-family:Verdana;">手机号：</label>
                <input class="nui-textbox" name="mobile" id="query_mobile" enabled="true"/>

                <label style="font-family:Verdana;">下次跟踪时间：</label>
                <input id="query_nextScoutDate" 
                    name="nextScoutDate" 
                    class="nui-datepicker width2" 
                    dateFormat="yyyy-MM-dd" 
                    emptyText="请选择日期" alwaysView="true"/>
                <a class="nui-button"  plain="true" onclick="query()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

                <a class="nui-button"  plain="true" onclick="add()" id="add" enabled="true">发送短信</a>
                <a class="nui-button"  plain="true" onclick="edit()" id="edit" enabled="true">预约维修</a>
                <a class="nui-button"  plain="true" onclick="edit()" id="edit" enabled="true">业绩登记</a>
                <a class="nui-button"  plain="true" onclick="newClient()" id="edit" enabled="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增客户</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <!-- splitter 1 -->
    <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
        <div size="61%" showCollapseButton="false" style="border:0;">
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
                        onSelect="setScoutForm"
                        dataField="data"
                        
                        virtualColumns="true"
                        idField="id"
                        showSummaryRow="true">
                        <div property="columns">
                            <div type="checkcolumn" width="20"></div>
                            <div type="indexcolumn" width="30" summaryType="count">序号</div>
                            <div headerAlign="center"><strong>车辆信息</strong>
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="orgid" width="70" headerAlign="center" allowSort=false>所在分店</div>
                                    <div field="carNo" width="50" headerAlign="center" allowSort=false>车牌号</div>
                                    <div field="carBrandId" width="40" headerAlign="center">品牌</div>
                                    <div field="carModel" width="40" headerAlign="center">车型</div>
                                    <div field="vin" width="70" headerAlign="center" allowSort=false>VIN</div>
                                    <div field="firstRegDate" width="70" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>初登日期</div>
                                    <div field="annualInspectionDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>保险到期</div>
                                    <div field="recorder" width="40" headerAlign="center" allowSort=false>建档人</div>
                                    <div field="recordDate" width="70" headerAlign="center" dateFormat="yyyy-MM-dd hh:MM" allowSort=false>建档日期</div>
                                </div>
                            </div>
                            <div headerAlign="center"><strong>客户信息</strong>
                                <div property="columns">
                                    <div field="guestId" visible=false>客户ID</div>
                                    <div field="guestName" width="80" headerAlign="center" summaryType="" allowSort=false>客户名称</div>
                                    <div field="address" width="100" headerAlign="center" summaryType="" allowSort=false>地址</div>
                                    <!--
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>客户等级</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>来厂次数</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>离厂天数</div>
                                    -->
                                </div>
                            </div>
                            <div headerAlign="center"><strong>联系状态</strong>
                                <div property="columns">
                                    <div field="visitManId" width="40" headerAlign="center" summaryType="" allowSort=false>营销员</div>
                                    <div field="visitStatus" width="60" headerAlign="center">跟踪状态</div>
                                    <div field="priorScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd hh:MM" allowSort=false>上次联系时间</div>
                                    <div field="nextScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd hh:MM" allowSort=false>下次联系时间</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
                     onactivechanged="" >
                    <!--联系内容--><%=webPath + contextPath%>/telsell/js/telTrack.js
                    <%@include file="../manage/telTrack_tab1.jsp" %>
                    <!--客户资料-->
                    <%@include file="../manage/telTrack_tab2.jsp" %>
                </div>
            </div>
        </div>
    </div><!--splitter-->
</div>
</body>
</html>