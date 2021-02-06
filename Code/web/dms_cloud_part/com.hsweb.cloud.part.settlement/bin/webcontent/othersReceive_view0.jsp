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
<title>其他收入单</title>
<script src="<%=webPath + contextPath%>/settlement/js/othersReceive.js?v=2.0.15"></script>
<style type="text/css">
.title {
  width: 60px;
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




<div class="nui-fit"> 

            <div class="nui-toolbar" style="padding:0px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            

                            <label style="font-family:Verdana;">创建日期 从：</label>
                            <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <label style="font-family:Verdana;">至</label>
                            <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                            <label style="font-family:Verdana;">审核状态：</label>
                            <input class="nui-combobox" id="auditSign" name="auditSign" value="0" nullitemtext="请选择..." emptyText="审核状态" data="auditSignList" width="70px" />

                            <span class="separator"></span> 
                            <input id="searchGuestId" class="nui-buttonedit"
                                   emptyText="请选择往来单位..."
                                   onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                            <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
							<a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                            <span class="separator"></span>
                            
                            <a class="nui-button" plain="true" iconCls="" onclick="addGuest()" id="addGuestBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="deleteGuest()" id="deleteGuestBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                            
                            <span class="separator"></span>
							<label style="font-family:Verdana;">结算日期:</label>
							<input id="rpSettleDate"
				                           name="rpSettleDate"
				                           width="100px"
				                           allowinput="false"
				                           class="nui-datepicker"/>
				                           
                        </td>
                    </tr>
                </table>
            </div> 

            <div class="nui-fit">
                <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="true"
                     dataField="detailList"
                     ondrawcell="onDrawCell"
                     idField="id"
                     showSummaryRow="true"
                     allowCellSelect="true"
                     allowCellEdit="true"
                     oncellcommitedit="onCellCommitEdit"
                     showModified="false"
                     multiSelect="true"
                     oncellbeginedit="OnrpMainGridCellBeginEdit"
                     pageSize="1000"
                     sizeList="[500,1000,2000]"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn" width="25">序号</div>
                        <div type="checkcolumn" field="check" width="25"></div>
                        <div field="guestId" width="50" headerAlign="center" visible="false"></div>
                        <div field="billDc" width="50" headerAlign="center" visible="false"></div>
                        <div field="guestName" summaryType="count" width="50" headerAlign="center" header="往来单位名称"></div>
                        <div field="balaAccountId" type="comboboxcolumn" width="100" headerAlign="center" header="结算账户">
                            <input  property="editor" enabled="true" id="balaAccountList" name="list" data="accountList" class="nui-combobox" 
                            valueFromSelect="true" allowInput="true"
                            valueField="id" textField="name" onvaluechanged="onAccountValueChanged" url="" emptyText=""  vtype="required"/> 
                        </div>
                        <div field="balaTypeCode" type="comboboxcolumn" width="50" headerAlign="center" header="结算方式">
                            <input  property="editor" enabled="true" name="list" dataField="list" class="nui-combobox" valueField="customId" textField="customName" 
                                      url=""
                                      onvaluechanged="" emptyText=""  vtype="required"
                                      /> 
                        </div>
                        <div field="billTypeId" type="comboboxcolumn" width="100" headerAlign="center" header="收入项目">
                            <input  property="editor" enabled="true" id="billTypeList" name="list" data="list" dataField="list" class="nui-combobox" valueField="id" onvaluechanged="onbillTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
                        </div>
                        <div field="billTypeCode" headerAlign="center" visible="false" header="收入项目编码"></div>
                        <div field="charOffAmt" width="60" summaryType="sum" headerAlign="center" header="收入金额">
                           <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="remark" width="80" headerAlign="center" header="备注">
                            <input property="editor" class="nui-textbox"/>
                        </div>
                        <div field="auditSign" width="30" headerAlign="center" header="是否审核"></div>
                        <div field="auditor" width="30" headerAlign="center" header="审核人"></div>
                        <div allowSort="true" field="auditDate" width="60" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                        <div field="rpAccountId" width="60" headerAlign="center" header="单号"></div>
                        <div allowSort="true" field="createDate" width="60" headerAlign="center" visible="false" dateFormat="yyyy-MM-dd HH:mm"></div>
                            
                    </div>  
                  
                    </div>
            </div>
     
    
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">创建日期:</td>
                <td>
                    <input id="sCreateDate" name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eCreateDate" name="eCreateDate"
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
                <td class="title">
                    往来单位:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">收款单号:</td>
                <td colspan="3">
                	<!--<textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="billServiceIdList" name="billServiceIdList"></textarea>-->
                    <input id="rpAccountId" name="rpAccountId" width="100%" emptyText="付款单号" class="nui-textbox"/>
                </td>
            </tr>
            <tr>
                <td class="title">审核状态:</td>
                <td colspan="3">
                    <input class="nui-combobox"  name="elAuditSign" 
                     nullitemtext="请选择..." emptyText="结算状态" data="auditSignList" width="100%" />
                </td>
            </tr>
            <tr>
                <td class="title">结算账户:</td>
                <td colspan="3">
                    <input class="nui-combobox" id="elBalaAccountId" name="elBalaAccountId" value="0"
                           textField="name" valueField="id" allowInput="true"
                     nullitemtext="请选择..." emptyText="结算账户" width="100%" />
                </td>
            </tr>
            <tr>
                <td class="title">收支项目:</td>
                <td colspan="3">
                    <input class="nui-combobox" id="elBillTypeId" name="elBillTypeId" value="0"
                           textField="name" valueField="id" allowInput="true"
                     nullitemtext="请选择..." emptyText="收支项目" width="100%" />
                </td>
            </tr>
            <tr>
                <td class="title">审核人:</td>
                <td colspan="3">
                    <input id="elAuditor" name="elAuditor" width="100%" emptyText="审核人" class="nui-textbox"/>
                </td>
            </tr>
            <tr>
                <td class="title">备注:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="elRemark" name="elRemark"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>
