<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:22:10
  - Description:
-->
<head>
<title>新增关注品牌</title>
<script src="<%=webPath + contextPath%>/basic/js/partBrandOrgDetail.js?v=1.0.4"></script>
<style type="text/css">



.title {
	/*text-align: right;*/
	display: inline-block;
}

.title-width1 {
	width: 60px;
}

.required {
	color: red;
}

.row {
	margin-top: 5px;
}

.width1 {
	width: 240px;;
}
</style>
</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:0px;border-top:0;border-right:0;border-bottom: 1;">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                     <a class="nui-button" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                     <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                </td>
            </tr>
        </table>
    </div>
    <!-- 
         onrowdblclick="editPartBrand"
         rowdblclick="save()" 
    -->
    <div class="nui-fit">
        <div id="brandGrid" class="nui-datagrid" style="width:100%;height:100%;"
                showPager="false"
                ondrawcell="onDrawCell"
                dataField="brands"
                selectOnLoad="true"
                sortMode="client" 
                multiSelect="true"
                url="">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center">序号</div>
                <div header="配件品牌信息" headerAlign="center">
                    <div property="columns">
                        <div type="checkcolumn" width="30"></div>
                        <div field="code" width="70" headerAlign="center" allowSort="true">编码</div>
                        <div field="name" width="100" headerAlign="center" allowSort="true">名称</div>
                        <div field="firstCodeCh" width="30" headerAlign="center" allowSort="true">代码</div>
                        <div field="manufacture" width="100" headerAlign="center" allowSort="true">生产产家</div>
                        <div field="remark" headerAlign="center" allowSort="true">备注</div>
                        <div field="isDisabled" width="60" allowSort="true" headerAlign="center">是否禁用</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
