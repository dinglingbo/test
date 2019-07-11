
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head> 
<title>查车单模版管理</title>

<script src="<%=webPath + contextPath%>/repair/cfg/js/checkModelMgr.js?v=1.0.10"></script>
<link href="<%=webPath + contextPath %>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
.title {
	width: 90px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>

    <div class="nui-splitter"
        id="splitter"
        allowResize="true"
        handlerSize="6"
        style="width:100%;height:100%;">
       <div size="40%" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
            
                            <input id="name" width="150px" emptyText="模版名称" class="nui-textbox"/>
                            <input id="isDisabled" width="60px" emptyText="状态" class="nui-combobox" textField="name"
                                    valueField="id" value="2"/>
            
                            <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" plain="true" onclick="addCheckModel()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="saveCheckModel()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <input name="checkType"
                               id="checkType"
                               class="nui-combobox"
                               textField="name"
                               valueField="customid" visible="false"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                        dataField="list"
                        sortMode="client"
                        selectOnLoad="true"
                        allowCellSelect="true"
                        allowCellEdit="true"                      
                        showPager="false"
                        allowCellWrap = true
                        showSummaryRow="false">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div field="id" name="id" visible="false">id</div>
                        <div allowSort="true" field="name" width="120" headerAlign="center" header="模板名称">
                                <input property="editor" class="nui-textbox" />
                        </div>
                        <div allowSort="true" field="isDisabled" headerAlign="center" header="状态">
                                <input  property="editor" enabled="true" name="dataList" dataField="dataList" 
                                class="nui-combobox" valueField="id" textField="name" data="dataList" /> 
                        </div>
                        <div allowSort="true" field="isShare" name="isShare" headerAlign="center" header="是否共享" visible="false">
                                <input  property="editor" enabled="true" name="dataList" dataField="dataList" 
                                class="nui-combobox" valueField="id" textField="name" data="stList" /> 
                        </div>
                        <div field="modifier" width="60" headerAlign="center" header="修改人"></div>
                        <div field="modifyDate" width="130" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="修改日期"></div>
                    </div>
                </div>
            </div>
       </div>
       <div showCollapseButton="false">
           <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
               <table style="width:100%;">
                   <tr>
                       <td style="white-space:nowrap;">
                           <label style="font-family:Verdana;">检查项目设置:</label>
                           <a class="nui-button" plain="true" iconCls="" onclick="addCheckDetail()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增检查项目</a>
                           <a class="nui-button" plain="true" iconCls="" onclick="editCheckDetail()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改检查项目</a>
                           <span class="separator"></span>
                           <a class="nui-button" plain="true" iconCls="" onclick="addCheckType()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增检查类型</a>
                       </td>
                   </tr>
               </table>
           </div>
           <div class="nui-fit">
               <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    showPager="false"
                    dataField="list"
                    idField="id"
                    selectOnLoad="true"
                    sortMode="client"
                    allowCellWrap = true
                    url="">
                   <div property="columns">
                       <div type="indexcolumn">序号</div>
                       <div type="expandcolumn" width="20" >#</div>
                       <div field="id" name="id" visible="false">id</div>
                       <div field="checkName" name="checkName" width="120" headerAlign="center" allowSort="true">项目名称</div>
                       <div field="checkType" width="120" headerAlign="center" allowSort="true">检查类型</div>
                       <div field="orderIndex" width="50" headerAlign="center" allowSort="true">排序值</div>
                       <div field="itemName" width="100" headerAlign="center" allowSort="true">工时</div>
                       <div field="partName" width="140" headerAlign="center" allowSort="true">项目</div>
                       <!-- <div field="isDisabled" width="80" headerAlign="center" allowSort="true">所需工时</div>
                       <div field="isDisabled" width="80" headerAlign="center" allowSort="true">所需配件</div> -->
                       <div allowSort="true" width="50" field="isDisabled" headerAlign="center" header="状态"></div>
                       <div field="modifier" width="60" allowSort="true" headerAlign="center">修改人</div>
                       <div field="modifyDate" width="120" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">修改时间</div>
                   </div>
               </div>
           </div>
       </div>
   </div>


   <div id="checkDetailContentForm" style="display:none;">
        <div id="contentGrid" class="nui-datagrid" style="width:100%;height:150px;"
             showPager="false"
             dataField="list"
             sortMode="client"
             url=""
             showSummaryRow="true">
            <div property="columns">
                <div allowSort="true" field="content" summaryType="count"  headerAlign="center" header="常用语"></div>
            </div>
        </div>
    </div>




</body>
</html>
