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
<script src="<%=webPath + contextPath%>/basic/js/sellStrategySet.js?v=1.0.3"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div id="mtab" class="nui-tabs" 
     activeIndex="0" 
     style="width:100%; height: 100%;" 
     plain="false" 
     onactivechanged=""
     ontabload=""
     >
    <div title="级别销价" name="strategyTab" url="" >
         <div class="nui-splitter"
               id="splitter"
               allowResize="false"
               handlerSize="6"
               style="width:100%;height:100%;">
              <div size="260" showCollapseButton="false">
                  <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;">
                                  <label style="font-family:Verdana;">级别定义:</label>
                                  <a class="nui-button" plain="true" iconCls="" onclick="onAddNode()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="onSaveNode()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                  <a class="nui-button" plain="true" id="deleteNode" iconCls="" onclick="onDeleteNode()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
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
                           showModified="false"
                           selectOnLoad="false"
                           onrowclick="onStraGridClick"
                           oncellbeginedit ="OnrpMainGridCellBeginEdit"
                           sortMode="client"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn" width="20">序号</div>
                              <div field="name" width="60" headerAlign="center" header="级别名称" allowSort="true">
                                  <input property="editor" class="nui-textbox" />
                              </div>
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
                       onactivechanged="onMoreTabChanged"
                       ontabload="onMainTabLoad"
                       >
                      <div title="客户信息" name="guestInfo" id="guestInfo" url="" >
                            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="white-space:nowrap;">
                                            <input id="GuestNamePy" name="namePy" width="120px" emptyText="拼音" class="nui-textbox"/>
                                            <input id="GuestFullName" name="fullName" width="120px" emptyText="全称" class="nui-textbox"/>
                                            <a class="nui-button" plain="true" iconCls="" onclick="onGuestSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            <span class="separator"></span>
                                            <a class="nui-button" plain="true" iconCls="" onclick="selectSupplier('guestId')" id="guestId"><span class="fa fa-plus fa-lg"></span>&nbsp;添加客户</a>
                                            <a class="nui-button" plain="true" iconCls="" onclick="delStraGuest()"><span class="fa fa-close fa-lg"></span>&nbsp;删除客户</a>
                                            <a class="nui-button" plain="true" iconCls="" onclick="saveStraGuest()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="nui-fit">
                                <div id="rightGuestGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                     showPager="true"
                                     dataField="list"
                                     pageSize="20"
                                    
                                     sizeList=[20,50]
                                     idField="id"
                                     showReloadButton="false"
                                     allowCellEdit="true"
                                     allowCellSelect="true"
                                     ondrawcell=""
                                     showModified="false"
                                     multiSelect="true"
                                     selectOnLoad="true"
                                     sortMode="client"
                                     url="">
                                    <div property="columns">
                                        <div type="indexcolumn" width="20">序号</div>
                                        <div type="checkcolumn" width="25"></div>
                                        <div field="fullName" name="fullName" headerAlign="center" allowSort="true">客户全称</div>
                                        <div field="shortName" name="shortName" headerAlign="center" allowSort="true">客户简称</div>
                                        <div field="operator" width="60" headerAlign="center" allowSort="true">操作人</div>
                                        <div field="operateDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">操作日期</div>
                                    </div>
                                </div>
                            </div>
                      </div>
                      <div title="配件价格" name="partInfo" url="" >
                           <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="white-space:nowrap;">
                                            <input id="queryCode" name="queryCode" width="120px" emptyText="编码" class="nui-textbox"/>
                                            <input id="namePy" name="namePy" width="120px" emptyText="拼音" class="nui-textbox"/>
                                            <input id="fullName" name="fullName" width="120px" emptyText="名称" class="nui-textbox"/>
                                            <a class="nui-button" plain="true" visible="" id="onPartSearch"iconCls="" onclick="onPartSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            <a class="nui-button" plain="true" visible="false" id="onUnifySearch" iconCls="" onclick="onUnifySearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            <span class="separator"></span>
<!--                                             <a class="nui-button" plain="true" iconCls="" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a> -->
<!--                                             <a class="nui-button" plain="true" iconCls="" onclick="delStraPart()"><span class="fa fa-close fa-lg"></span>&nbsp;删除配件</a> -->
                                            <a class="nui-button" id="saveStraPart" plain="true" iconCls="" onclick="saveStraPart()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                            <a class="nui-button" visible="false" id="saveUnifyPart" plain="true" iconCls="" onclick="saveUnifyPart()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                            <a class="nui-button" plain="true" iconCls="" onclick="importPart()" id="importPartBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="nui-fit">
                                <div id="rightPartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                     showPager="true"
                                     dataField="list"
                                     idField="id"
                                     pageSize="20"
                                     sizeList=[20,50]
                                     totalField="page.count"
                                     allowCellEdit="true"
                                     allowCellSelect="true"
                                     ondrawcell=""
                                      allowInput="true"
                                     showReloadButton="false"
                                     showModified="false"
                                     oncellcommitedit="onCellCommitEdit"
                                     multiSelect="true"
                                     selectOnLoad="true"
                                     sortMode="client"
                                     url="">
                                    <div property="columns">
                                        <div type="indexcolumn" width="20">序号</div>
                                        <div type="checkcolumn" width="25"></div>
                                        <div field="strategyId" visible="false" name="strategyId" width="120"headerAlign="center" allowSort="true" header="策略ID">
                                        	 <input property="editor" vtype="float"  allowInput="false" class="nui-textbox"/>
                                        </div>
                                        <div field="partCode" name="partCode" width="120"headerAlign="center" allowSort="true">配件编码</div>
                                        <div field="fullName" name="fullName" width="450"headerAlign="center" allowSort="true">配件全称</div>
                                        <div field="costPrice" name="sellPrice" width="60"headerAlign="center" allowSort="true" header="成本单价"></div>
                                        <div field="sellPrice" name="sellPrice" width="60"headerAlign="center" allowSort="true" header="销售单价">
                                            <input property="editor" vtype="float"  allowInput="true" class="nui-textbox"/>
                                        </div>
                                        <div field="operator" width="60" headerAlign="center" allowSort="true" header="操作人">
<!--                                         	<input property="editor"   allowInput="false" class="nui-textbox"/> -->
                                        </div>
                                        <div field="operateDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" header="操作日期">
<!--                                         	<input property="editor"  allowInput="false" class="nui-textbox"/> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                      </div>  

                    </div>
                
               </div>
                


                  
              </div>
          </div>
    </div>
    <div title="统一售价" name="unifyTab" url="" visible="false" >
         
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
              <table style="width:100%;">
                  <tr>
                      <td style="white-space:nowrap;">
                          <input id="queryCodeSearch" name="queryCodeSearch" width="120px" emptyText="编码" class="nui-textbox"/>
                          <input id="namePySearch" name="namePySearch" width="120px" emptyText="拼音" class="nui-textbox"/>
                          <input id="fullNameSearch" name="fullNameSearch" width="120px" emptyText="名称" class="nui-textbox"/>
                          <a class="nui-button" plain="true" iconCls="" onclick="onUnifySearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                          <span class="separator"></span>
<!--                           <a class="nui-button" plain="true" iconCls="" onclick="addUnifyPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a> -->
<!--                           <a class="nui-button" plain="true" iconCls="" onclick="delUnifyPart()"><span class="fa fa-close fa-lg"></span>&nbsp;删除配件</a> -->
                          <a class="nui-button" plain="true" iconCls="" onclick="saveUnifyPart()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                          <a class="nui-button" plain="true" iconCls="" onclick="importUnifyPart()" id="importPartBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                      </td>
                  </tr>
              </table>
          </div>
          <div class="nui-fit">
              <div id="rightUnifyGrid" class="nui-datagrid" style="width:100%;height:100%;"
                   showPager="true"
                   dataField="list"
                   idField="id"
                   pageSize="20"
                   sizeList=[20,50]
                   allowCellEdit="true"
                   allowCellSelect="true"
                   ondrawcell=""
                   showReloadButton="false"
                   showModified="false"
                   oncellcommitedit="onCellCommitEdit"
                   multiSelect="true"
                   selectOnLoad="true"
                   sortMode="client"
                   url="">
                  <div property="columns">
                      <div type="indexcolumn" width="20">序号</div>
                      <div type="checkcolumn" width="25"></div>
                      <div field="partCode" name="partCode"  width="120"headerAlign="center" allowSort="true">配件编码</div>
                      <div field="fullName" name="fullName"  width="450"headerAlign="center" allowSort="true">配件全称</div>
                      <div field="sellPrice" name="sellPrice" width="100" headerAlign="center" allowSort="true" header="销售单价">
                          <input property="editor" vtype="float" class="nui-textbox"/>
                      </div>
                      <div field="operator" width="60" headerAlign="center" allowSort="true">操作人</div>
                      <div field="operateDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">操作日期</div>
                  </div>
              </div>
          </div>


    </div>  

</div>



</body>
</html>
