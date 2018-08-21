<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:15:46
  - Description:
-->
<head>
<title>配件品牌</title>
<script src="<%=webPath + contextPath%>/baseDataPart/js/partBrandMgr/partBrandMgr.js?v=1.0.13"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>


<div>
<div class="nui-splitter"
        id="splitter"
        vertical="true"
        allowResize="true"
        handlerSize="6"
        style="width:100%;height:100%;">
    <div size="40%" showCollapseButton="false" style="border-right:0">
        <div class="nui-fit">
            <div class="nui-splitter"
                    id="splitter"
                    allowResize="false"
                    handlerSize="6"
                    style="width:100%;height:100%;">
                <div size="40%" showCollapseButton="false" style="border-right:0">
                    <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-bottom: 0;">
                        <table style="width:100%;">
                            <tr>
                                <td style="white-space:nowrap;">
                                    <label style="font-family:Verdana;">云配件品质:</label>
                                    <a class="nui-button" plain="true" iconCls="" onclick="addPartQuality()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增品质</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="editPartQuality()" id="editLeft"><span class="fa fa-edit fa-lg"></span>&nbsp;修改品质</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="disablePartQuality()" id="disabledLeft" visible="false"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用品质</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="enablePartQuality()" id="enabledLeft" visible="false"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用品质</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                dataField="brands"
                                showPager="false"
                                ondrawcell="onDrawCell"
                                onrowdblclick="editPartQuality"
                                onrowclick="onLeftGridRowClick"
                                selectOnLoad="true"
                                sortMode="client"
                                url="">
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center">序号</div>
                                <div header="配件品质信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="code" width="60" headerAlign="center" allowSort="true">编码</div>
                                        <div field="name" headerAlign="center" allowSort="true">名称</div>
                                        <div field="isDisabled" width="60" allowSort="true" headerAlign="center">是否禁用</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false"  style="border-left:0">
                    <div class="nui-toolbar" style="padding:2px;border-top:0;border-right:0;border-bottom: 0;">
                        <table style="width:100%;">
                            <tr>
                                <td style="white-space:nowrap;">
                                    <label style="font-family:Verdana;">云配件品牌:</label>
                                    <a class="nui-button" plain="true" iconCls="" onclick="addPartBrand()" id="addRight"><span class="fa fa-plus fa-lg"></span>&nbsp;新增品牌</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="editPartBrand()" id="editRight"><span class="fa fa-edit fa-lg"></span>&nbsp;修改品牌</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="disablePartBrand()" id="disabledRight" visible="false"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用品牌</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="enablePartBrand()" id="enabledRight" visible="false"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用品牌</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                showPager="false"
                                ondrawcell="onDrawCell"
                                dataField="brands"
                                onrowdblclick="editPartBrand"
                                selectOnLoad="true"
                                sortMode="client"
                                url="">
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center">序号</div>
                                <div header="配件品牌信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="code" width="60" headerAlign="center" allowSort="true">编码</div>
                                        <div field="name" width="100" headerAlign="center" allowSort="true">名称</div>
                                        <div field="firstCodeCh" width="100" headerAlign="center" allowSort="true">代码</div>
                                        <div field="manufacture" width="100" headerAlign="center" allowSort="true">生产产家</div>
                                        <div field="remark" headerAlign="center" allowSort="true">备注</div>
                                        <div field="isDisabled" width="60" allowSort="true" headerAlign="center">是否禁用</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div showCollapseButton="false"  style="border-left:0">
        <div class="nui-toolbar" style="padding:2px;border-top:0;border-right:0;border-bottom: 0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">本地关注品牌:</label>
                        <a class="nui-button" plain="true" iconCls="" onclick="addLocalBrand()" id="addBottom"><span class="fa fa-plus fa-lg"></span>&nbsp;新增关注品牌</a>
                        <a class="nui-button" plain="true" iconCls="" onclick="delLocalBrand()" id="editBottom"><span class="fa fa-remove fa-lg"></span>&nbsp;取消关注品牌</a>
                        <a class="nui-button" plain="true" iconCls="" onclick="saveLocalBrand()" id="editBottom"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="bottomGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    showPager="false"
                    ondrawcell="onDrawCell"
                    dataField="brands"
                    onrowdblclick="editPartBrand"
                    selectOnLoad="true"
                    multiSelect="true"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    sortMode="client"
                    showModified="false"
                    url="">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center">序号</div>
                    <div header="配件品牌信息" headerAlign="center">
                        <div property="columns">
                                <div type="checkcolumn" width="30"></div>
                            <div field="code" width="60" headerAlign="center" allowSort="true">编码</div>
                            <div field="name" width="100" headerAlign="center" allowSort="true">名称</div>
                            <div field="firstCodeCh" width="30" headerAlign="center" allowSort="true">代码</div>
                            <div field="orderIndex" width="30" headerAlign="center" allowSort="true">排序值
                                <input property="editor" class="nui-textbox" />
                            </div>
                            <div field="manufacture" width="100" headerAlign="center" allowSort="true">生产产家</div>
                            <div field="remark" headerAlign="center" allowSort="true">备注</div>
                            <div field="isDisabled" width="60" allowSort="true" headerAlign="center">是否禁用</div>
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
