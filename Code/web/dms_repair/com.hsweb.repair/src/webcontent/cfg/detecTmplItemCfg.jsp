<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:49:18
  - Description:
-->
<head>
<title>查车单模板项目配置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@ include file="/common/sysCommon.jsp"%>
    <!--
    <script src="<%=webPath + contextPath%>/repair/cfg/js/parameterSet.js?v=1.0"></script>
    -->
    <style>
        span.mini-tools-add
        {
            width:16px;height:16px;
            background:url(<%=webPath + contextPath %>/common/nui/themes/icons/add.gif) no-repeat;
        }
        span.mini-tools-edit
        {
            width:16px;height:16px;
            background:url(<%=webPath + contextPath %>/common/nui/themes/icons/edit.gif) no-repeat;
        }    
        span.mini-tools-remove
        {
            width:16px;height:16px;
            background:url(<%=webPath + contextPath %>/common/nui/themes/icons/remove.gif) no-repeat;
        }        
    </style> 
</head>
<body>
 <div class="nui-tabs" style="margin-left: 5%; width: 90%; height: 100%;">
     <div title="查车单">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="toolbar">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <!--
                        <label style="font-family:Verdana;">快速查询：</label>
                        -->
                        <a class="nui-button" iconCls="icon-add" plain="true" onclick="query()" id="query" enabled="true">新增</a>
                        <a class="nui-button" iconCls="icon-remove" plain="true" onclick="add()" id="add" enabled="true">删除</a>
                    </td>
                </tr>
            </table>
        </div>
        
        <div class="nui-fit" style="padding:5px;">
            <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;parding:5px;"
                url="<%=apiPath + contextPath %>/org.gocom.components.coframe.org.organization.queryOrg.biz.ext" dataField="treeNodes" sizeList="[10,20,50,100]">
                <div property="columns">
                    <div type="indexcolumn"></div>                
                    <div field="orgcode" width="120" headerAlign="center" >编码</div>    
                    <div field="startdate" width="120" headerAlign="center" >检测单类别</div>    
                    <div field="orgtype" width="120" headerAlign="center" renderer="renderOrgtype">检测项目类型</div>    
                    <div field="orgname" width="120" headerAlign="center" >检测项目</div>    
                    <div field="orglevel" width="120" headerAlign="center" >检测项名称</div>    
                    <div field="enddate" width="120" headerAlign="center" >失效日期</div>    
                </div>
            </div>
        </div>
     </div>
     
     <div title="接车预检单">
     </div>


</body>
</html>