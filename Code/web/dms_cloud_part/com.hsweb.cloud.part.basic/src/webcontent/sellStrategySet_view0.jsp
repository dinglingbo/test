<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:05:48
  - Description:
-->
<head>
<title>销价策略定义</title>
<script src="<%=webPath + cloudPartDomain%>/basic/js/sellStrategySet.js?v=1.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-splitter"
     id="splitter"
     allowResize="false"
     handlerSize="6"
     style="width:100%;height:100%;">
    <div size="250" showCollapseButton="false">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">级别定义:</label>
                        <a class="nui-button" plain="true" iconCls="" onclick="onAddNode()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" iconCls="" onclick="onEditNode()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="straGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="list"
                 idField="id"
                 allowCellEdit="true"
                 allowCellSelect="true"
                 selectOnLoad="true"
                 sortMode="client"
                 url="">
                <div property="columns">
                    <div type="indexcolumn" width="20">序号</div>
                    <div field="recorder" width="60" headerAlign="center" allowSort="true">级别名称</div>
                </div>
            </div>
        </div>
    </div>
    <div showCollapseButton="false">
      <div class="nui-fit">
      
          <div id="mainTabs" class="nui-tabs" 
             activeIndex="0" 
             style="width:100%; height: 100%;" 
             plain="false" 
             onactivechanged="showTabInfo"
             ontabload="onMainTabLoad"
             >
            <div title="客户信息" name="guestInfo" url="" >
                  <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;">
                                  <a class="nui-button" plain="true" iconCls="" onclick="addPosition()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加客户</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="savePosition()"><span class="fa fa-close fa-lg"></span>&nbsp;删除客户</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="savePosition()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                  <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="locations"
                           idField="id"
                           allowCellEdit="true"
                           allowCellSelect="true"
                           ondrawcell="onDrawCell"
                           selectOnLoad="true"
                           sortMode="client"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div field="name" name="name" headerAlign="center" allowSort="true">客户全称</div>
                              <div field="name" name="name" headerAlign="center" allowSort="true">客户全称</div>
                              <div field="recorder" width="60" headerAlign="center" allowSort="true">操作人</div>
                              <div field="recordDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss">操作日期</div>
                          </div>
                      </div>
                  </div>
            </div>
            <div title="配件信息" name="partInfo" url="" >
                 <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;">
                                  <a class="nui-button" plain="true" iconCls="" onclick="addPosition()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="savePosition()"><span class="fa fa-close fa-lg"></span>&nbsp;删除配件</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="savePosition()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                                  <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="locations"
                           idField="id"
                           allowCellEdit="true"
                           allowCellSelect="true"
                           ondrawcell="onDrawCell"
                           selectOnLoad="true"
                           sortMode="client"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div field="name" name="name" headerAlign="center" allowSort="true">配件编码</div>
                              <div field="name" name="name" headerAlign="center" allowSort="true">配件全称</div>
                              <div field="name" name="name" headerAlign="center" allowSort="true">销售单价</div>
                              <div field="recorder" width="60" headerAlign="center" allowSort="true">操作人</div>
                              <div field="recordDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss">操作日期</div>
                          </div>
                      </div>
                  </div>
            </div>  

          </div>
      
     </div>
      


        
    </div>
</div>

</body>
</html>
