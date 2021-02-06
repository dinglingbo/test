<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>期初应收应付</title>
<script src="<%=webPath + contextPath%>/frm/js/settle/initQCRPBill.js?v=1.1.0"></script>
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
                            <a class="nui-button" plain="true" iconCls="" onclick="addGuest()" id="addGuestBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;添加供应商</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="deleteGuest()" id="deleteGuestBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
                        </td>
                    </tr>
                </table>
            </div> 

            <div class="nui-fit">
                <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     dataField="detailList"
                     ondrawcell="onrpMainGridDrawCell"
                     idField="id"
                     showSummaryRow="true"
                     allowCellSelect="true"
                     allowCellEdit="true"
                     oncellcommitedit="onCellCommitEdit"
                     oncellbeginedit="OnMainGridCellBeginEdit"
                     showModified="false"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div field="guestId" width="50" headerAlign="center" visible="false"></div>
                        <div field="billDc" width="50" headerAlign="center" visible="false"></div>
                        <div field="guestFullName" summaryType="count" width="100" headerAlign="center" header="往来单位全称"></div>
                         <div field="carNo" name="carNo" width="70" headerAlign="center" header="车牌号"></div>
                        <div field="guestShortName" width="100" headerAlign="center" header="往来单位简称"></div>
                        <div field="code" headerAlign="center" header="往来单位编码"></div>
                        <div field="ramt" width="60" summaryType="sum" headerAlign="center" header="应收">
                          <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="pamt" width="60" summaryType="sum" headerAlign="center" header="应付">
                          <input property="editor" vtype="float" class="nui-textbox"/>
                        </div>
                        <div field="remark" width="40" headerAlign="center" header="备注">
                        	<input property="editor"  class="nui-textbox"/>
                        </div>
                            
                    </div>  
                  
                    </div>
            </div>
     
    
</div>

</body>
</html>
