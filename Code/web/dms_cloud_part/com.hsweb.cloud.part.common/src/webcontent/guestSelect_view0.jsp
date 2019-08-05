<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:15:25
  - Description:
-->
<head>
<title>往来单位选择界面</title>
<script src="<%=webPath + contextPath%>/common/js/guestSelect.js?v=1.1.1"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="settType"/>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
<div class="nui-toolbar" style="padding:2px;border:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <input emptyText="名称" class="nui-textbox" width="100" id="name"/>
                <input emptyText="编码" class="nui-textbox" width="100" id="code"/>
                <input emptyText="电话" class="nui-textbox" width="100" id="phone"/>
                <input id="type"
                       visible = "false"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择类型"
                       url=""
                       allowInput="true"
                       showNullItem="true"
                       nullItemText="请选择..."/>
                <span class="separator"></span>
                <label style="font-family:Verdana;">显示禁用：</label>
                <input class="nui-checkbox" width="100" id="showDisabled" trueValue="1" falseValue="0"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                <span class="separator"></span>
<!--                 <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="false"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="200" showCollapseButton="false">
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;height: 100%;"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false" style="border-right:0;border-left:0;">
            <div class="nui-fit">
                <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
                     url=""  idField="id" multiSelect="true" allowCellWrap = true
                     pageSize="20"
                     dataField="guest"
                     totalField="page.count"
                     selectOnLoad="true"
                     sortMode="client"
                     onrowdblclick="onOk"
                     frozenStartColumn="0"
                     frozenEndColumn="0">
                    <div property="columns">
                        <div width="40" type="indexcolumn">序号</div>
                        <!--<div type="checkcolumn" ></div>-->
                        <div header="往来基本信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="shortName" width="80" headerAlign="center" header="简称"></div>
                                <div allowSort="true" field="fullName" width="200" headerAlign="center" header="全称"></div>
                                <div allowSort="true" field="isInternal" width="110" headerAlign="center" header="是否内部供应商"></div>
                                <div allowSort="true" field="advantageCarbrandId" width="200" headerAlign="center" header="优势品牌/产品"></div>
                                <div allowSort="true" field="billTypeId" width="80" headerAlign="center" header="票据类型"></div>
                                <div allowSort="true" field="settTypeId" width="100" headerAlign="center" header="结算方式"></div>
                                <div allowSort="true" field="manager" width="100" headerAlign="center" header="联系人"></div>
                                <div allowSort="true" field="mobile" width="100" headerAlign="center" header="联系人手机"></div>
                                <div allowSort="true" field="contactor" width="80" headerAlign="center" header="业务员"></div>
                                <div allowSort="true" field="contactorTel" width="100" headerAlign="center" header="业务员电话"></div>
                                <div allowSort="true" field="code" width="100" headerAlign="center" header="编码"></div>
                                <div allowSort="true" field="isDisabled" width="100" headerAlign="center" header="状态"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:456px;height:290px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="table-label">全称:</td>
                <td><input name="fullName" class="nui-textbox" /></td>
                <td class="table-label">简称:</td>
                <td><input name="shortName" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">编码:</td>
                <td><input name="code" class="nui-textbox" /></td>
                <td class="table-label">单位等级:</td>
                <td><input name="tgrade" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">联系人:</td>
                <td><input name="manager" class="nui-textbox" /></td>
                <td class="table-label">联系人电话:</td>
                <td><input name="mobile" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">会员等级:</td>
                <td><input name="memLevel" class="nui-textbox" /></td>
                <td class="table-label">会员卡号:</td>
                <td><input name="memCarNo" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">省份:</td>
                <td>
                    <input name="provinceId"
                           id="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                </td>
                <td class="table-label">城市:</td>
                <td>
                    <input name="cityId"
                           id="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
                <td class="table-label">客户:</td>
                <td>
                    <input class="nui-checkbox" name="icClient" trueValue="1" falseValue="0"/>
                </td>
                <td class="table-label">是否禁用:</td>
                <td>
                    <input class="nui-checkbox" name="showDisabled" trueValue="1" falseValue="0"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="mini-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="mini-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

</body>
</html>
