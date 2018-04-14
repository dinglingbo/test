<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
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
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/telsales/js/telTrack.js?v=1.0" type="text/javascript"></script>
    <link href="<%=webPath + sysDomain%>/css/style1/style_form_edit.css?v=1.1" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td><!-- style="white-space:nowrap;"-->
                <label style="font-family:Verdana;">快速查询：</label>
                <label style="font-family:Verdana;">跟踪状态：</label>
                <input class="nui-textbox" name="source" id="source" enabled="true"/>
                <label style="font-family:Verdana;">车牌号：</label>
                <input class="nui-textbox" name="content" id="content" enabled="true"/>
                <label style="font-family:Verdana;">手机号：</label>
                <input class="nui-textbox" name="recorder" id="recorder" enabled="true"/>
                <label style="font-family:Verdana;">车辆状态：</label>
                <label style="font-family:Verdana;">下次跟踪时间：</label>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query" enabled="true">查询</a>
                
                <li class="separator"></li>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="add()" id="add" enabled="true">发送短信</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="edit()" id="edit" enabled="true">预约维修</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="edit()" id="edit" enabled="true">业绩登记</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="newClient()" id="edit" enabled="true">新增客户</a>
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
                        onrowdblclick=""
                        dataField="rs"
                        allowcellwrap="true"
                        virtualColumns="true"
                        idField="id"
                        url="<%=apiPath + crmApi%>/com.hsapi.crm.telsales.crmTelsales.getDatumMgrList.biz.ext"
                        showSummaryRow="true">
                        <div property="columns">
                            <div type="checkcolumn" width="20"></div>
                            <div type="indexcolumn" width="30" summaryType="count">序号</div>
                            <div headerAlign="center"><strong>车辆信息</strong>
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="orgid" width="70" headerAlign="center" renderer="setTypeName" allowSort=false>所在分店</div>
                                    <div field="carNo" width="50" headerAlign="center" allowSort=false>车牌号</div>
                                    <div field="carBrandId" width="40" headerAlign="center" allowSort=false>品牌</div>
                                    <div field="carModel" width="40" headerAlign="center" allowSort=false>车型</div>
                                    <div field="underpanNo" width="70" headerAlign="center" allowSort=false>VIN</div>
                                    <div field="firstRegDate" width="70" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort=false>初登日期</div>
                                    <div field="annualInspectionDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort=false>保险到期</div>
                                    <div field="recorder" width="40" headerAlign="center" allowSort=false>建档人</div>
                                    <div field="recordDate" width="70" headerAlign="center" allowSort=false>建档日期</div>
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
                                    <div field="visitStatus" width="60" headerAlign="center" summaryType="" allowSort=false>联系状态</div>
                                    <div field="priorScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort=false>上次联系时间</div>
                                    <div field="nextScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort=false>下次联系时间</div>
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
                     onactivechanged="changeTabs" >
                    <!--联系内容-->
                    <%@include file="/telsales/telTrack_tab1.jsp" %>
                    <!--客户资料-->
                    <%@include file="/telsales/telTrack_tab2.jsp" %>
                </div>
            </div>
        </div>
    </div><!--splitter-->
</div>
</body>
</html>