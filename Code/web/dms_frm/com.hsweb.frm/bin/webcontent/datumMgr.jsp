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
<title>资料管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/common/crmcommon.js?v=1.0" type="text/javascript"></script> 
    <script src="<%=crmDomain%>/telsales/js/R.js?v=1.0" type="text/javascript"></script> 
        <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td ><!--style="white-space:nowrap;"-->
                <label style="font-family:Verdana;" title="点击清空条件"><span onclick="clearQueryForm()">快速查询：</span></label>
                <a class="nui-menubutton " iconCls="icon-tip" menu="#popupMenu1" value="-1" id="assignStatus">所有</a>
                <ul id="popupMenu1" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, -1)" id="typeAll">所有</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 0)" id="type0">未分配</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 1)" id="type1">已分配</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 2)" id="type2">今日待跟踪</li>
                    <!--
                    <li class="separator"></li>
                    <li iconCls="icon-tip" onclick="openMore()" id="type3">更多</li>
                    -->
                </ul>
                
                <input name="orgid"
                    id="query_orgid"
                    visible="false"
                    class="nui-combobox width2"
                    textField="orgname"
                    valueField="orgid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                
                <label style="font-family:Verdana;">车牌号：</label>
                <input class="nui-textbox width1" name="carNo" id="carNo" enabled="true"/>
                
                <label style="font-family:Verdana;">跟踪状态：</label>
                <input name="visitStatus"
                    id="visitStatus"
                    required="true"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <!--
                <label style="font-family:Verdana;">来厂状态：</label>
                <input name="isCome"
                    id="isCome"
                    required="true"
                    class="nui-combobox width1"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                -->
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query" enabled="true">查询</a>
                
                <li class="separator"></li>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="updateField('visitStatus', '060701')" id="add" enabled="true">设为继续跟踪</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="updateField('visitStatus', '060702')" id="edit" enabled="true">设为结束跟踪</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editGuestInfo()" id="edit" enabled="true">资料修改</a>
                
                <li class="separator"></li>
                <label style="font-family:Verdana;">分配给：</label>
                <input name="tracker"
                    id="tracker"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="assignTracker()" id="add" enabled="true">确定</a>
                <!-- <a class="nui-button" iconCls="icon-edit" plain="true" onclick="" id="" enabled="true">资料导入</a> -->
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <!-- splitter 1 -->
    <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
        <div size="15%" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div title="品牌" class="nui-panel"
                     showHeader="true"
                     showFooter="false"
                     style="width:100%;height:60%;border: 0;">
                    <ul id="tree1" class="nui-tree" 
                        style="width:100%;height:95%;padding:5px;" 
                        showTreeIcon="true" 
                        dataField="rs" 
                        textField="nameCn" 
                        idField="id" 
                        resultAsTree="false" 
                        parentField="" 
                        showTreeLines="true" 
                        onNodedblclick="onType1DbClick"
                        allowDrag="true">
                    </ul>
                </div>
                <div title="营销员" class="nui-panel"
                     showHeader="true"
                     showFooter="false"
                     style="width:100%;height:40%;border: 0;">
                    <ul id="tree2" class="nui-tree" 
                        style="width:100%;height:95%;padding:5px;" 
                        showTreeIcon="true" 
                        dataField="data" 
                        textField="empName" 
                        idField="empId" 
                        resultAsTree="false" 
                        parentField="" 
                        showTreeLines="true" 
                        onNodedblclick="onType2DbClick"
                        allowDrag="true">
                    </ul>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
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
                         dataField="data"
                         sortMode="client"
                         allowcellwrap="true"
                         idField="id"
                         multiSelect="true"
                         url="<%=apiPath + crmApi%>/com.hsapi.crm.telsales.crmTelsales.getDatumMgrList.biz.ext"
                         showSummaryRow="true">
                        <div property="columns">
                            <div type="checkcolumn" width="25"></div>
                            <div type="indexcolumn" width="30" summaryType="count">序号</div>
                            <div headerAlign="center"><strong>车辆信息</strong>
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="orgid" width="60" headerAlign="center" allowSort=false>所在分店</div>
                                    <div field="carNo" width="70" headerAlign="center" allowSort=false>车牌号</div>
                                    <div field="carBrandId" width="50" headerAlign="center" allowSort=false>品牌</div>
                                    <div field="carModel" name="carModel"  width="60" headerAlign="center" allowSort=false>品牌车型</div>
                                    <div field="underpanNo" width="60" headerAlign="center" allowSort=false>VIN</div>
                                    <div field="firstRegDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>初登日期</div>
                                    <div field="annualInspectionDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>保险到期</div>
                                    <div field="recorder" name="recorder" width="60" headerAlign="center" allowSort=false>建档人</div>
                                    <div field="recordDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>建档日期</div>
                                </div>
                            </div>
                            <div headerAlign="center"><strong>客户信息</strong>
                                <div property="columns">
                                    <div field="guestId" visible=false>客户ID</div>
                                    <div field="guestName" name="guestName" width="80" headerAlign="center" summaryType="" allowSort=false>客户名称</div>
                                    <div field="address" width="50" headerAlign="center" summaryType="" allowSort=false>地址</div>
                                    <!--
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>客户等级</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>来厂次数</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>离厂天数</div>
                                    -->
                                </div>
                            </div>
                            <div headerAlign="center"><strong>联系状态</strong>
                                <div property="columns">
                                    <div field="visitManId" width="60" headerAlign="center" summaryType="" allowSort=false>营销员</div>
                                    <div field="visitStatus" width="70" headerAlign="center" summaryType="" allowSort=false>跟踪状态</div>
                                    <div field="priorScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>上次联系时间</div>
                                    <div field="nextScoutDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>下次联系时间</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><!--splitter-->
</div>
</body>
</html>