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
<title>内部转账单</title>
<script src="<%=webPath + contextPath%>/manage/settlement/js/internalTransfer.js?v=2.1.4"></script>
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
                            <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="addInternalTransfer()" id="addInternalTransferBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="deleteGuest()" id="deleteGuestBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
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
                     oncellbeginedit="OnrpMainGridCellBeginEdit"
                     showModified="false"
                     multiSelect="true"
                     pageSize="1000"
                     sizeList="[500,1000,2000]"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn" width="25">序号</div>
                        <div type="checkcolumn" field="check" width="25"></div>
                        <div field="toSettAccountId" type="comboboxcolumn" width="100" headerAlign="center" header="收款账户">
                            <input  property="editor" enabled="true" id="balaAccountList" name="list" data="accountList" class="nui-combobox" valueField="id" textField="name" onvaluechanged="onRAccountChange" url="" emptyText=""  vtype="required"/> 
                        </div>
                        <div field="toAccountCode" headerAlign="center" visible="false" header=""></div>
                        <div field="toSettAccountName" headerAlign="center" visible="false" header=""></div>
                        <div field="rpAmt" width="60" summaryType="sum" headerAlign="center" header="收款金额">
                           <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="settAccountId" type="comboboxcolumn" width="100" headerAlign="center" header="付款账户">
                            <input  property="editor" enabled="true" id="balaAccountList" name="list" data="accountList" class="nui-combobox" valueField="id" textField="name" onvaluechanged="onPAccountChange" url="" emptyText=""  vtype="required"/> 
                        </div>
                        <div field="balaTypeCode" type="comboboxcolumn" width="50" headerAlign="center" header="付款方式">
                            <input  property="editor" enabled="true" name="list" dataField="list" class="nui-combobox" valueField="customId" textField="customName" 
                                      url=""
                                      onvaluechanged="" emptyText=""  vtype="required"
                                      /> 
                        </div>
                        <div field="settAccountCode" headerAlign="center" visible="false" header=""></div>
                        <div field="settAccountName" headerAlign="center" visible="false" header=""></div>
                        <div field="itemTypeId" type="comboboxcolumn" width="100" headerAlign="center" header="费用科目">
                            <input  property="editor" enabled="true" id="billTypeList" name="list" data="list" dataField="list" class="nui-combobox" valueField="id" onvaluechanged="onbillTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
                        </div>
                        <div field="itemTypeCode" headerAlign="center" visible="false" header="费用科目编码"></div>
                        
                        <div field="remark" width="80" headerAlign="center" header="备注">
                            <input property="editor" class="nui-textbox"/>
                        </div>
                        <div field="auditSign" width="30" headerAlign="center" header="是否审核"></div>
                        <div field="auditor" width="30" headerAlign="center" header="审核人"></div>
                        <div allowSort="true" field="auditDate" width="60" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd hh:MM"></div>
                        <div field="serviceId" width="60" headerAlign="center" header="单号"></div>
                        <div allowSort="true" field="createDate" width="60" headerAlign="center" visible="false" dateFormat="yyyy-MM-dd hh:MM"></div>
                            
                    </div>  
                  
                    </div>
            </div>
     
    
</div>

</body>
</html>
