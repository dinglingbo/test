<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 22:56:04
  - Description:
-->
<head>
<title>配件管理</title>
<script src="<%= request.getContextPath() %>/baseData/js/partMgr/partMgr.js?v=1.0.10"></script>
<style type="text/css">
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <label style="font-family:Verdana;">编码：</label>
                    <input class="nui-textbox" width="100" id="search-code" name="code"/>
                    <label style="font-family:Verdana;">名称：</label>
                    <input class="nui-textbox" width="100" id="search-name" name="name"/>
                    <label style="font-family:Verdana;">车型：</label>
                    <input class="nui-textbox" width="100" id="search-applyCarModel" name="applyCarModel"/>
                    <label style="font-family:Verdana;">拼音：</label>
                    <input class="nui-textbox" width="100" id="search-namePy" name="namePy"/>
                    <label style="font-family:Verdana;">品牌：</label>
                    <input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="carBrandZh"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">包含已禁用：</label>
                    <input class="nui-checkbox" trueValue="1" falseValue="0" name="showDisabled"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         allowResize="false"
         style="width:100%;height:100%;">
        <div size="210" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;text-align: center;">
                <span>配件分类</span>
            </div>
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;"
                    dataField="partTypes"
                    ondrawnode="onDrawNode"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id" parentField="parentid" resultAsTree="false">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addPart()">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editPart()" id="editBtn">修改</a>
                <a class="nui-button" iconCls="icon-no" plain="true" onclick="disablePart()" id="disableBtn">禁用</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="enablePart()" id="enableBtn" visible="false">启用</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-reload" plain="true" onclick="reloadData()">刷新</a>
            </div>
            <div class="nui-fit" >
                <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     frozenStartColumn="0"
                     frozenEndColumn="7"
                     borderStyle="border:0;"
                     dataField="parts"
                     url=""
                     onrowdblclick="onPartGridRowDblClick"
                     onrowclick="onPartGridRowClick"
                     ondrawcell="onPartGridDraw"
                     idField="id"
                     totalField="page.count"
                     selectOnLoad="true"
                     pageSize="50"
                     sortMode="client"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div header="基础信息" headerAlign="center">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div allowSort="true" field="isDisabled" width="50" headerAlign="center">状态</div>
                                <div allowSort="true" field="qualityTypeId" width="60" headerAlign="center">品质</div>
                                <div allowSort="true" field="partBrandId" width="70" headerAlign="center">品牌</div>
                                <div allowSort="true" field="code" name="code" width="80" headerAlign="center" allowSort="true">编码</div>
                                <div allowSort="true" field="name" name="name" width="80" headerAlign="center" allowSort="true">名称</div>
                                <div allowSort="true" field="fullName" name="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                                <div allowSort="true" field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="spec" width="60" headerAlign="center" allowSort="true">规格</div>

                                <div allowSort="true" field="model" width="60" headerAlign="center" allowSort="true">型号</div>

                                <div allowSort="true" field="applyCarModel" width="70" headerAlign="center" allowSort="true">车型</div>
                                <div allowSort="true" field="carTypeIdF" width="80" headerAlign="center" allowSort="true">一级分类</div>
                                <div allowSort="true" field="carTypeIdS" width="80" headerAlign="center" allowSort="true">二级分类</div>
                                <div allowSort="true" field="carTypeIdT" width="80" headerAlign="center" allowSort="true">三级分类</div>
                            </div>
                        </div>
                        <div header="价格信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">零售价</div>
                                <div allowSort="true" datatype="float" field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">批发价</div>
                                <div allowSort="true" datatype="float" field="uniformSellPrice" width="70" headerAlign="center" align="right" allowSort="true">统一价格</div>
                            </div>
                        </div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="queryCode" width="60" headerAlign="center" allowSort="true">助记码</div>

                                <div allowSort="true" field="namePy" width="60" headerAlign="center" allowSort="true">拼音</div>

                                <div allowSort="true" field="isUniform" width="70" headerAlign="center" header="是否统一售价" allowSort="true"></div>

                                <div allowSort="true" field="abcType" width="80" headerAlign="center" allowSort="true">ABC类型</div>
                                <div allowSort="true" field="produceFactory" width="80" headerAlign="center" allowSort="true">生产厂家</div>
                                <div allowSort="true" field="nameEn" width="120" headerAlign="center" allowSort="true">英文名称</div>
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
