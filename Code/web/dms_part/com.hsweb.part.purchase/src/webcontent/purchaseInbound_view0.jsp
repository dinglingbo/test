<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:33:46
  - Description:
-->
<head>
<title>采购入库</title>
<script src="purchase/js/purchaseInbound/purchaseInbound.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
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
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)">上周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)">上月</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)">未审</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)">已审</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)">已过帐</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)">全部</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">供应商：</label>
                <input id="btnEdit1" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('btnEdit1')" selectOnFocus="true" />
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()">修改</a>
                <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
                <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEdit()">取消</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()">审核</a>
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
        <div size="250" showCollapseButton="false">
            <div title="入库单列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     url="">
                    <div property="columns">
                        <div field="dept_name" headerAlign="center" header="入库单号"></div>
                        <div field="dept_name" width="80" headerAlign="center" header="入库日期"></div>
                        <div field="dept_name" width="60" headerAlign="center" header="状态"></div>
                    </div>
                </div>
                <!--footer-->
                <div property="footer">
                    <input type='nui-textbox' value='Footer' readonly="true" style='vertical-align:middle;'/>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div title="入库信息" class="nui-panel"
                 style="width:100%;height: 150px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="id"/>
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>入库单号：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" width="100%"/>
                            </td>
                            <td class="title required">
                                <label>入库日期：</label>
                            </td>
                            <td width="100">
                                <input name="inDate"
                                       width="100%"
                                       class="nui-datepicker"/>
                            </td>
                            <td class="title required">
                                <label>仓库：</label>
                            </td>
                            <td>
                                <input id="purchase"
                                       class="nui-combobox width1"
                                       textField="text"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="true"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title required">
                                <label>票据类型：</label>
                            </td>
                            <td>
                                <input name="type"
                                       class="nui-combobox width1"
                                       textField="text"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="true"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>供应商：</label>
                            </td>
                            <td colspan="5">
                                <input id="btnEdit3"
                                       class="nui-buttonedit"
                                       emptyText="请选择供应商..."
                                       onbuttonclick="selectSupplier('btnEdit3')"
                                       width="100%"
                                       selectOnFocus="true" />
                            </td>
                            <td class="title">
                                <label>结算方式：</label>
                            </td>
                            <td>
                                <input name="way"
                                       class="nui-combobox width1"
                                       textField="text"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="true"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>采购员：</label>
                            </td>
                            <td colspan="1">
                                <input name="person"
                                       class="nui-combobox width1"
                                       textField="text"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="true"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title">
                                <label>票据号：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" width="100%" name="piaojuhao"/>
                            </td>
                            <td class="title">
                                <label>验货员：</label>
                            </td>
                            <td colspan="1">
                                <input name="yanhuo"
                                       class="nui-combobox width1"
                                       textField="text"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="true"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>备注：</label>
                            </td>
                            <td colspan="5">
                                <input class="nui-textbox" width="100%" name="backup"/>
                            </td>
                            <td class="title">
                                <label>总金额：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="total"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-toolbar" style="padding:2px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPart()">添加</a>
                            <a class="nui-button" plain="true" iconCls="icon-edit" onclick="savePosition()">修改</a>
                            <a class="nui-button" plain="true" iconCls="icon-remove" onclick="disablePosition()">删除</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="100" headerAlign="center" header="配件编码"></div>
                                <div field="dept_name" headerAlign="center" header="配件名称"></div>
                                <div field="dept_name" width="60" headerAlign="center" header="品牌"></div>
                                <div field="dept_name" width="60" headerAlign="center" header="车型"></div>
                                <div field="dept_name" width="40" headerAlign="center" header="单位"></div>
                                <div field="dept_name" width="40" headerAlign="center" header="数量"></div>
                            </div>
                        </div>
                        <div header="不含税信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="40" headerAlign="center" header="单价"></div>
                                <div field="dept_name" width="40" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                        <div header="含税信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="40" headerAlign="center" header="税率"></div>
                                <div field="dept_name" width="40" headerAlign="center" header="单价"></div>
                                <div field="dept_name" width="40" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="60" headerAlign="center" header="建议销价"></div>
                                <div field="dept_name" width="60" headerAlign="center" header="入库分配"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:250px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd H:mm:ss"
                           timeFormat="H:mm:ss"
                           showTime="true"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">入库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;"></textarea>
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
