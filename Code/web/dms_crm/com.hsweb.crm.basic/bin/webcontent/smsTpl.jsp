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
    <title>短信模板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/basic/js/smsTpl.js?v=1.1" type="text/javascript"></script> 
</head>
<body>

  <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <label style="font-family:Verdana;">来源：</label>
                <input class="nui-textbox" name="source" id="source" enabled="true" onenter="query()"/>
                <label style="font-family:Verdana;">短信内容：</label>
                <input class="nui-textbox" name="content" id="content" enabled="true" onenter="query()"/>
                <label style="font-family:Verdana;">创建人：</label>
                <input class="nui-combobox" name="recorder" id="recorder" enabled="true" style="width:90px;"
                textField="empName" valueField="empName" allowInput="true" onenter="query()" />
                <a class="nui-button" iconCls="" plain="true" onclick="query()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="add" enabled="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增模板</a>
                <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="edit" enabled="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改模板</a>
                <span id="span1" style="display: none;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onClose()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </span>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <!-- splitter 1 -->
    <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
        <div size="20%" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div title="短信类型" class="nui-panel"
                showHeader="true"
                showFooter="false"
                style="width:100%;height:100%;border: 0;">
                <ul id="tree1" class="nui-tree" 
                url="<%=apiPath + sysApi%>/com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130902000005&page/length=200&token=<%=token%>" 
                style="width:100%;height:100%;" 
                showTreeIcon="false" 
                dataField="data" 
                textField="name" 
                idField="customid" 
                resultAsTree="false" 
                parentField="dictid" 
                showTreeLines="true" 
                onNodeclick="onNodeDbClick"
                allowDrag="true">
            </ul>
        </div>
    </div>
</div>
<div showCollapseButton="false" style="border:0;">
    <div class="nui-fit">
        <div title="" class="nui-panel" showHeader="false"showFooter="false"style="width:100%;height:100%;border: 0;">
            <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
            showPager="true"
            totalField="page.count"
            pageSize="50" sizeList=[20,50,100] 
            selectOnLoad="true"
            ondrawcell=""
            onrowdblclick=""
            dataField="rs"
            sortMode="client"
            allowcellwrap="true"
            idField="id"
            url="<%=apiPath + crmApi%>/com.hsapi.crm.basic.crmBasic.getSmsList.biz.ext"
            showSummaryRow="true">
            <div property="columns">
                <div type="checkcolumn"field="check"name="check" width="10" visible="false"></div>
                <div type="indexcolumn" width="15" summaryType="count" headerAlign="center" >序号</div>
                <div headerAlign="center">基本信息
                    <div property="columns">
                        <div field="id" visible=false>ID</div>
                        <div field="typeId" width="50" headerAlign="center" renderer="setTypeName" allowSort=false>类别</div>
                        <div field="charCount" width="20" headerAlign="center" summaryType="" allowSort=false>字数</div>
                    </div>
                </div>
                <div headerAlign="center">详细信息
                  <div property="columns">
                    <div field="content" width="150" headerAlign="center" summaryType="" allowSort=false>短信内容</div>
                    <div field="source" width="30" headerAlign="center" summaryType="" allowSort=false>短信来源</div>
                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>创建人</div>
                    <div field="recordDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>创建日期</div>
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