<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 17:02:48
  - Description:
-->
<head>
<title>品牌车型</title>
<script src="<%=request.getContextPath()%>/repair/js/DataBase/Brand/BrandMain.js?v=1.0.9"></script>
<style type="text/css">
table {
	table-layout: fixed;
	font-size: 12px;
}
</style>

</head>
<body>
<div id="queryForm" class="nui-form">
    <div class="nui-toolbar" style="border-bottom: 0;">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family: Verdana;">快速查询：</label>
                    <a class="nui-button" plain="true" onclick="onSearch(0)" id="type0">已启用</a>
                    <a class="nui-button" plain="true" onclick="onSearch(1)" id="type1">已禁用</a>
                    <a class="nui-button" plain="true" onclick="onSearch(2)" id="type2">全部</a>
                    <a class="nui-button" plain="true" onclick="doSync(0)">同步品牌</a>
                    <a class="nui-button" plain="true" onclick="doSync(1)">同步车系</a>
                    <a class="nui-button" plain="true" onclick="doSync(2)">同步车型</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <!-- 左右 -->
    <div class="nui-splitter" handlerSize="2" showHandleButton="false"
         style="width: 100%; height: 100%;" borderStyle="border:0">
        <div style="width: 100%; height: 100%;border: 0;" size="40%">
            <!-- 左边的上下 -->
            <div class="nui-splitter" handlerSize="2" showHandleButton="false"
                 style="width: 100%; height: 100%;" borderStyle="border:0"
                 vertical="true">
                <div style="width: 100%; height: 100%;border: 0;" size="50%">
                    <!-- 车辆品牌信息 -->
                    <div class="nui-toolbar" id="tb1"
                         style="border-bottom: 0; padding: 0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" id="addBrand" iconCls="" onclick="addBrand()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增品牌</a>
                                    <a class="nui-button" id="updateBrand" iconCls="" onclick="editBrand()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改品牌</a>
                                    <a class="nui-button" id="disableBrand" iconCls="" onclick="disableBrand()" plain="true"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用品牌</a>
                                    <a class="nui-button" plain="true" iconCls="" onclick="enableBrand()" id="enableBrand" visible="false"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用品牌</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="leftBrandGrid" dataField="brands" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             showPager="false"
                             ondrawcell="onDrawCell"
                             onrowdblclick="editBrand"
                             onrowclick="onLeftBrandGridRowClick"
                             selectOnLoad="true">
                            <div property="columns">
                                <div type="indexcolumn" width="30">序号</div>
                                <div header="车辆品牌信息" headerAlign="center">
                                    <div property="columns">
                                        <div field="carBrandZh" headerAlign="center" allowSort="true" visible="true" header="名称" width="50%"></div>
                                        <div  field="imageUrl" width="70px" headerAlign="center">图标</div>
                                        <div field="isDisabled" headerAlign="center" allowSort="true" visible="true" header="是否禁用"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <!-- 车系信息 -->
                    <div class="nui-toolbar" style="border-bottom: 0; padding: 0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" id="add" iconCls="" onclick="addSeries()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增车系</a>
                                    <a class="nui-button" id="update" iconCls="" onclick="editSeries()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改车系</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div id="leftSeriesGrid" dataField="serieses" class="nui-datagrid"
                             style="width: 100%; height:100%;"
                             showPager="false"
                             onDrawCell="onDrawCell"
                             onrowclick="onLeftSeriesGridRowClick"
                             allowSortColumn="true">
                            <div property="columns">
                                <div type="indexcolumn" width="30">序号</div>
                                <div header="车系信息" headerAlign="center">
                                    <div property="columns">
                                        <div id="name" field="name" headerAlign="center"
                                             allowSort="true" visible="true" width="50%">名称
                                        </div>
                                        <div id="isDisabled" field="isDisabled" headerAlign="center"
                                             allowSort="true" visible="true">是否禁用
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <!-- 车型车系信息 -->
            <div class="nui-toolbar" style="border-bottom: 0; padding: 0;">
                <table>
                    <tr>
                        <td >
                            <a class="nui-button" iconCls="" onclick="addModel()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增车型</a>
                            <a class="nui-button" iconCls="" onclick="editModel()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;修改车型</a>
                            <a class="nui-button" iconCls="" onclick="disableModel()" plain="true" id="disableModel"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用车型</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="enableModel()" id="enableModel" visible="false"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用车型</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="rightModelGrid"
                     dataField="models"
                     showPager="false"
                     class="nui-datagrid"
                     style="width: 100%; height:100%;"
                     ondrawcell="onDrawCell"
                     allowSortColumn="true">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="车型车系信息" headerAlign="center">
                            <div property="columns">
                                <div field="carFactoryName" name="carFactoryName" headerAlign="center"
                                     allowSort="true" visible="true" width="15%">厂商
                                </div>
                                <div field="carSeriesName" name="carSeriesName" headerAlign="center" allowSort="true"
                                     width="15%">车系
                                </div>
                                <div field="carModel" headerAlign="center" allowSort="true"
                                     width="50%">品牌车型
                                </div>
                                <div field="isDisabled" headerAlign="center" allowSort="true"
                                     visible="true" width="20%">是否禁用
                                </div>
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