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
<script src="<%= request.getContextPath() %>/baseData/js/partBrandMgr/partBrandMgr.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" plain="true" onclick="onSearch(0)">已启用</a>
                <a class="nui-button" plain="true" onclick="onSearch(1)">已禁用</a>
                <a class="nui-button" plain="true" onclick="onSearch(2)">全部</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="false"
         handlerSize="0"
         style="width:100%;height:100%;">
        <div size=40%" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPartQuality()">新增品质</a>
                            <a class="nui-button" plain="true" iconCls="icon-edit" onclick="editPartQuality()">修改品质</a>
                            <a class="nui-button" plain="true" iconCls="icon-no" onclick="disablePartQuality()">禁用品质</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件品质信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="60" headerAlign="center" allowSort="true">编码</div>
                                <div field="position_name" headerAlign="center" allowSort="true">名称</div>
                                <div field="salary" width="60" allowSort="true" headerAlign="center">是否禁用</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPartBrand()">新增品牌</a>
                            <a class="nui-button" plain="true" iconCls="icon-edit" onclick="editPartBrand()">修改品牌</a>
                            <a class="nui-button" plain="true" iconCls="icon-no" onclick="disablePartBrand()">禁用品牌</a>
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
                        <div header="配件品牌信息" headerAlign="center">
                            <div property="columns">
                                <div field="dept_name" width="60" headerAlign="center" allowSort="true">编码</div>
                                <div field="position_name" width="100" headerAlign="center" allowSort="true">名称</div>
                                <div field="position_name" width="100" headerAlign="center" allowSort="true">生产产家</div>
                                <div field="position_name" headerAlign="center" allowSort="true">备注</div>
                                <div field="salary" width="60" allowSort="true" headerAlign="center">是否禁用</div>
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
