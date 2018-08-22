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
<title>业绩录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/common/crmcommon.js?v=1.0" type="text/javascript"></script> 
    <script src="<%=crmDomain%>/telsales/js/performEntry.js?v=1.0" type="text/javascript"></script> 
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td ><!--style="white-space:nowrap;"-->
                <label style="font-family:Verdana;">车牌号：</label>
                <input class="nui-textbox width1" name="carNo" id="carNo" enabled="true"/>
                <label style="font-family:Verdana;">工单号：</label>
                <input class="nui-textbox width1" name="carNo" id="carNo" enabled="true"/>
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
                <input name="tracker"
                    id="tracker"
                    visible="false"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <input name="achievType"
                    id="achievType"
                    visible="false"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query" enabled="true">查询</a>
                
                <li class="separator"></li>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="updateField('visitStatus', '060701')" id="add" enabled="true">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="updateField('visitStatus', '060702')" id="edit" enabled="true">修改</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editGuestInfo()" id="edit" enabled="true">删除</a>
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
             dataField="result"
             onrowdblclick=""
             dataField="data"
             sortMode="client"
             allowcellwrap="true"
             idField="id"
             multiSelect="false"
             url="<%=webPath + contextPath%>/com.hs.common.unify.intfc.biz.ext"
             showSummaryRow="true">
            <div property="columns">
                <div type="checkcolumn" width="25"></div>
                <div type="indexcolumn" width="30" summaryType="count">序号</div>
                <div headerAlign="center"><strong>业绩信息</strong>
                    <div property="columns">
                        <div field="id" visible=false>ID</div>
                        <div field="orgid" width="60" headerAlign="center" allowSort=false>分店名称</div>
                        <div field="carNo" width="70" headerAlign="center" allowSort=false>车牌号</div>
                        <div field="serviceId" width="50" headerAlign="center" allowSort=false>工单号</div>
                        <div field="deputyId" width="60" headerAlign="center" allowSort=false>营销员</div>
                        <div field="type" width="60" headerAlign="center" allowSort=false>来厂类型</div>
                        <div field="gradeRemark" width="60" headerAlign="center" allowSort=false>业绩备注</div>
                        <div field="recorder" width="60" headerAlign="center" allowSort=false>登记人</div>
                        <div field="recordDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>登记日期</div>
                        <div field="modifier" width="60" headerAlign="center" allowSort=false>最后修改人</div>
                        <div field="modifyDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>最后修改日期</div>
                    </div>
                </div>
                <div headerAlign="center"><strong>审核信息</strong>
                    <div property="columns">        
                        <div field="status" width="80" headerAlign="center">是否审核</div>
                        <div field="auditDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>审核日期</div>
                        <div field="auditReamrk" width="60" headerAlign="center" allowSort=false>审核备注</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
