<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!--
  - Author(s): steven
  - Date: 2018-05-30 08:57:57
  - Description:
-->
<head>
    <title>角色权限管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script>
		var defDomin = "<%=request.getContextPath()%>";
	</script>
    <script src="<%=webPath + contextPath%>/auth/js/roleMgr.js?v=1.0.4" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: Microsoft YaHei !important;
    }

    .mini-toolbar {
        border: 0px  solid #ccc !important;
        border-bottom: 1px solid #ccc !important;
        /* background: #fafafa; */
    }

    .mini-grid-headerCell, .mini-grid-topRightCell { 
        border-right: #c5c5c5 0px solid;
    }

    .mini-grid-headerCell {
     border-right: #A5ACB5 0px solid;
 }


 .mini-grid-cell, .mini-grid-headerCell, .mini-grid-filterCell, .mini-grid-summaryCell {
     border-right: #d2d2d2 0px solid;
 } 

 .mini-grid .mini-grid-rightCell {
    border-right-width: 0px; 
}

</style> 
</head>
<body> 
<!-- 1，汽修店，2汽配店，3变速箱维修店，4汽贸店，5汽贸汽修综合店 -->

    <div class="nui-splitter" style="width: 100%; height: 100%;">
        <div size="270" showcollapsebutton="true">
            <div class="nui-toolbar"  >
                    <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">所有</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch1(1)" id="type0">汽修</li>
                        <li iconCls="" onclick="quickSearch1(2)" id="type0">汽配</li>
                        <li iconCls="" onclick="quickSearch1(3)" id="type1">变速箱</li>
                        <li iconCls="" onclick="quickSearch1(4)" id="type2">汽贸</li>
                        <li iconCls="" onclick="quickSearch1(5)" id="type0">汽修汽贸</li>
                        <li iconCls="" onclick="quickSearch1(6)" id="type0">所有</li>
                   </ul>
                   <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >在用</a>
				    <ul id="popupMenu" class="nui-menu" style="display:none;">
				        <li iconCls="" onclick="quickSearch(1)">停用</li>
				        <li iconCls="" onclick="quickSearch(0)">在用</li>
				        <li iconCls="" onclick="quickSearch(2)">所有</li>
				        
				    </ul>
                <input class="nui-textbox" id="tenantId" name="tenantId" width="60" emptyText="租户ID" onenter="queryTenant">
                 <a class="nui-button" iconCls="" plain="true" onclick="queryTenant"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <!-- <a class="nui-button" plain="true" onclick="queryRole()"><i class="fa fa-refresh"></i>&nbsp;刷新</a> -->
            </div>
            <div class="nui-fit" >
            <div id="leftGrid" class="nui-datagrid" dataField="rs" style="width: 100%; height: 100%;" 
                idField="tenantId" allowResize="true"
                sizeList="[20,50,100]"  
                pageSize="20" 
                totalField="page.count" 
                showPager="true" 
                onselectionchanged="onLeftGridSelectionChanged"
                showPagerButtonIcon="true" >
                <div property="columns">
                    <div type="indexcolumn" name="index" width="30px" headeralign="center" ><strong>序号</strong></div>
                    <div field=tenantName width="140" headeralign="left" ><strong>租户名称</strong></div>
                    <div field="tenantType" width="100" headeralign="left" visible="true"><strong>租户类型</strong></div>
                    <div field="tenantId" width="50" headeralign="left" visible="true"><strong>租户ID</strong></div>
                    
                </div>
            </div> 
            </div>
        </div>
        <div showcollapsebutton="true">
            <div id="mainTabs" name="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;padding:0px;" bodyStyle="padding:0;border:0;" onactivechanged="ontopTabChanged">
                <div title="角色" name="role"  url=""></div>
                <div title="资源" name="resauth"  url=""></div>
                <div title="角色对应资源" name="roleResauth" url=""></div>
             </div>
        </div>
</div>
<div id="roleForm" class="nui-window" title="窗体" style="width:500px;height:200px;"  allowDrag="true" >
    <input id="roleId" name="roleId" class="nui-hidden" />
    <input id="roleCode" name="roleCode" class="nui-hidden" />
   <!--  <input id="tenantId" name="tenantId" class="nui-hidden" /> -->
    <table style="table-layout: fixed; border-collapse:separate;border-spacing:5px; ">
        <tr>
            <td style="width: 90px;text-align:right">角色名称：</td>
            <td><input class="nui-textbox"  id="roleName" name="roleName" style="width: 324px;"/></td>

        </tr>

        <tr>
            <td style="width: 90px;text-align:right">角色描述：</td>
            <td colspan="3"><input class="nui-textarea" id="roleDesc" name="roleDesc" style="width: 324px;height:60px;"  /></td>
            </tr>
        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="save()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
</body>
</html>