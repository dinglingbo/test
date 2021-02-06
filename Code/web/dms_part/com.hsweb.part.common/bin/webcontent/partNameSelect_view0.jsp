<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-01-27 21:49:50
  - Description:
-->
<head>
<title>配件名称查询</title>
<script src="<%=webPath + contextPath%>/commonPart/js/partNameSelect.js?v=1.0.15"></script>
<style type="text/css">
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <input class="nui-textbox" width="220" id="searchKey"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                <a class="nui-button" iconCls="" plain="true" onclick="addPartName()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增配件名称</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         allowResize="false"
         style="width:100%;height:100%;">
        <div size="240" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;text-align: center;">
                <span>系统分类</span>
            </div>
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;"
                    dataField="partTypes"
                    ondrawnode="onDrawNode"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id" parentField="parentId" resultAsTree="false">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-fit" >
                <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
                     frozenStartColumn="0"
                     frozenEndColumn="0"
                     borderStyle="border:0;"
                     dataField="partNames"
                     selectOnLoad="true"
                     url=""
                     ondrawcell="onPartGridDraw"
                     idField="id"
                     totalField="page.count"
                     pageSize="20"
                     sortMode="client"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
                    <div property="columns">
                        <div type="indexcolumn" width="40">序号</div>
                        <div header="配件名称" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="name" headerAlign="center" header="标准名称"></div>
                                <!-- <div allowSort="true" field="namestd" width="100" headerAlign="center" header="标准名称组"></div> -->
                                <div allowSort="true" field="direction" width="70" headerAlign="center" header="方向"></div>
                                <div allowSort="true" field="namecn" width="80" headerAlign="center" allowSort="true" header="别名"></div>
                            </div>
                        </div>
                        <!-- 
                        <div header="分类" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="cartypef" width="80" headerAlign="center" header="一级"></div>
                                <div allowSort="true" field="cartypes" width="80" headerAlign="center" header="二级"></div>
                                <div allowSort="true" field="cartypet" width="80" headerAlign="center" header="三级 "></div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="isdisabled" width="50" headerAlign="center" header="状态"></div>
                                <div allowSort="true" field="creator" width="60" headerAlign="center" header="建档人"></div>
                                <div allowSort="true" field="createdate" width="60" headerAlign="center" allowSort="true" header="建档日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                                <div allowSort="true" field="operator" width="70" headerAlign="center" header="修改人"></div>
                                <div allowSort="true" field="operatedate" width="80" headerAlign="center" allowSort="true" header="修改日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                            </div>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
