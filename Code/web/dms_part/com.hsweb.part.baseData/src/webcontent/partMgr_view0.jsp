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
<script src="<%= request.getContextPath() %>/baseData/js/partMgr/partMgr.js?v=1.0.0"></script>
<style type="text/css">
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <label style="font-family:Verdana;">编码：</label>
                <input class="nui-textbox" width="100" id="search-code"/>
                <label style="font-family:Verdana;">名称：</label>
                <input class="nui-textbox" width="100" id="search-name"/>
                <label style="font-family:Verdana;">车型：</label>
                <input class="nui-textbox" width="100" id="search-applyCarModel"/>
                <label style="font-family:Verdana;">拼音：</label>
                <input class="nui-textbox" width="100" id="search-namePy"/>
                <label style="font-family:Verdana;">品牌：</label>
                <input id="search-brandName"
                       class="nui-combobox width1"
                       textField="text"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="true"
                       nullItemText="请选择..."/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">包含已禁用：</label>
                <input class="nui-checkbox" />
            </td>
        </tr>
    </table>
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
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editPart()">修改</a>
                <a class="nui-button" iconCls="icon-no" plain="true" onclick="disablePart()">禁用</a>
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
                     ondrawcell="onPartGridDraw"
                     idField="id"
                     totalField="page.count"
                     pageSize="50"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div header="基础信息" headerAlign="center">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="isDisabled" width="50" headerAlign="center">状态</div>
                                <div field="qualityTypeId" width="60" headerAlign="center">品质</div>
                                <div field="partBrandId" width="70" headerAlign="center">品牌</div>
                                <div field="code" width="80" headerAlign="center" allowSort="true">编码</div>
                                <div field="name" width="80" headerAlign="center" allowSort="true">名称</div>
                                <div field="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                                <div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>

                                <div field="position_name" width="60" headerAlign="center" allowSort="true">型号</div>

                                <div field="applyCarModel" width="70" headerAlign="center" allowSort="true">车型</div>
                                <div field="carTypeIdF" width="80" headerAlign="center" allowSort="true">一级分类</div>
                                <div field="carTypeIdS" width="80" headerAlign="center" allowSort="true">二级分类</div>
                                <div field="carTypeIdT" width="80" headerAlign="center" allowSort="true">三级分类</div>
                            </div>
                        </div>
                        <div header="价格信息" headerAlign="center">
                            <div property="columns">
                                <div field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">零售价</div>
                                <div field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">批发价</div>
                                <div field="uniformSellPrice" width="70" headerAlign="center" align="right" allowSort="true">统一价格</div>
                            </div>
                        </div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="60" headerAlign="center" allowSort="true">助记码</div>

                                <div field="namePy" width="60" headerAlign="center" allowSort="true">拼音</div>

                                <div field="position_name" width="70" headerAlign="center" header="售价方式" allowSort="true"></div>

                                <div field="abcType" width="80" headerAlign="center" allowSort="true">ABC类型</div>
                                <div field="produceFactory" width="80" headerAlign="center" allowSort="true">生产厂家</div>
                                <div field="nameEn" width="120" headerAlign="center" allowSort="true">英文名称</div>
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
