<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>盘点单</title>
<script src="<%=webPath + contextPath%>/purchase/js/stockCheck/stockCheck.js?v=1.1.7"></script>
<style type="text/css">
.title {
	width: 75px;
	text-align: right;
}

.title.required {
	color: red;
}

.title.wide {
	width: 100px;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                </ul>

                <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">草稿</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                </ul>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                
                <a class="nui-button" iconCls="" visible="false" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
           
            </td>
        </tr>
    </table>
</div>


<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="true"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="240" showCollapseButton="true">
          <div title="盘点列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="true"
                     pageSize="50"
                     sizeList=[20,50,100,200]
                     selectOnLoad="true"
                     showModified="false"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick=""
                     onselectionchanged="onLeftGridSelectionChanged"
                     onbeforedeselect=""
                     dataField="list"
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                      	<div field="auditSign" width="50" headerAlign="center" header="状态"></div>
                        <div field="createDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="盘点日期"></div>
                        <div field="orderMan" width="60" headerAlign="center" header="盘点员"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="盘点单号"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:60px;">
                      <legend><span>盘点信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <table style="width: 100%;">
                                  <tr>
                                    <td class="title required">
                                        <label>盘点仓库：</label>
                                    </td>
                                    <td>
                                        <input id="storeId"
                                               name="storeId"
                                               class="nui-combobox width1"
                                               textField="name"
                                               valueField="id"
                                               emptyText="请选择..."
                                               url=""
                                               valuefromselect="true"
                                               allowInput="true"
                                               selectOnFocus="true"
                                               showNullItem="false"
                                               width="100%"
                                               nullItemText="请选择..."
                                               />
                                      </td>
                                      <td class="title required">
                                          <label>盘点员：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" enabled="true" id="orderMan" name="orderMan" width="100%">
                                      </td>
                                      <td class="title required">
                                          <label>盘点日期：</label>
                                      </td>
                                      <td width="120">
                                          <input name="createDate"
                                                 id="createDate"
                                                 width="100%"
                                                 enabled="false"
                                                 showTime="true"
                                                 class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
                                      </td>
                                      <td class="title">
                                          <label>盘点单号：</label>
                                      </td>
                                      <td>
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false"/>
                                      </td>
                                  </tr>
                              </table>
                          </div>
                         
                      </div>
                  </fieldset>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="detailList"
                           idField="id"
                           showSummaryRow="true"
                           ondrawcell="onRightGridDraw"
                           allowCellSelect="true"
                           allowCellEdit="true"
                           oncellcommitedit="onCellCommitEdit"
                           oncelleditenter="onCellEditEnter"
                           onselectionchanged=""
                           oncellbeginedit="OnrpMainGridCellBeginEdit"
                           showModified="false"
                           editNextOnEnterKey="true"
                           allowCellWrap = true
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div header="配件信息" headerAlign="center">
                                  <div property="columns">
                                    <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="删除"></div>
                                      <div field="comPartCode" name="comPartCode" width="90" headerAlign="center" header="配件编码">
                                          <input property="editor" class="nui-textbox" />
                                      </div>
                                      <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                                      <div field="fullName" visible="false" headerAlign="center" header="配件全称"></div>
                                      <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                      <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                      <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
                                  </div>
                              </div>
                              <div header="数量金额信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="sysQty" name="sysQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="系统数量"></div>
                                      <div field="trueQty" name="trueQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="实盘数量">
                                        <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                      <div field="truePrice" name="truePrice" numberFormat="0.0000" width="60" headerAlign="center" header="成本单价">
                                        <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                      <div field="dc" name="dc" width="50" headerAlign="center" header="盈亏状态"></div>
                                      <div field="exhibitQty" name="exhibitQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="盈亏数量"></div>
                                      <div field="exhibitAmt" name="exhibitAmt" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="盈亏金额"></div>
                                      <div field="sysPrice" name="sysPrice" numberFormat="0.0000" width="60" headerAlign="center" header="系统成本"></div>
                                      <div field="remark" visible="false" width="80" headerAlign="center" allowSort="true" header="备注">
                                        <input property="editor" class="nui-textbox"/>
                                      </div>
                                  </div>
                              </div>
                              <div header="辅助信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="stockOutQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="缺货数量">
                                      </div>
                                      <div field="comOemCode" width="60" headerAlign="center" allowSort="true" header="OEM码"></div>   
                                      <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                                                        
                                  </div>
                              </div>
                          </div>
                      </div>
                </div>
              </div>



                

        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:290px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
          <tr>
                <td class="title">移仓日期:</td>
                <td>
                    <input id="sOrderDate"
                           name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eOrderDate"
                           name="eCreateDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">审核日期:</td>
                <td>
                    <input name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eAuditDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">移仓单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

<div id="advancedMorePartWin" class="nui-window"
     title="配件选择" style="width:430px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="1"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="OEM码"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="配件全称"></div>
              </div>
          </div>
    </div>
</div>

<div id="advancedAddWin" class="nui-window"
     title="快速录入配件" style="width:400px;height:200px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedAddForm" class="form">
        <table style="width:100%;">
          
            <tr>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="格式:编码*数量*单价" width="100%" style="height: 110px;" id="fastCodeList" name="fastCodeList"></textarea>
                </td>
            </tr>
            
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">盘点仓库：</td>
            <td colspan="1" align="left"><span id="eStoreName"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">盘点员：</td>
            <td colspan="1" align="left"><span id="eOrderMan"></span></td>
        </tr>
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件全称</td>
            <td colspan="1" align="center">品牌车型</td>
            <td colspan="1" align="center">单位</td>
            <td colspan="1" align="center">系统数量</td>
            <td colspan="1" align="center">实盘数量</td>
            <td colspan="1" align="center">盈亏状态</td>
            <td colspan="1" align="center">盈亏数量</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  

</body>
</html>
