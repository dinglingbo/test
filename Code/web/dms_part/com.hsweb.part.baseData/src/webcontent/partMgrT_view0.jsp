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
<script src="<%=webPath + contextPath%>/baseDataPart/js/partMgr/partMgr.js?v=1.1.2"></script>
  <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="unit"/>
    <input class="nui-combobox" visible="false" id="abcType"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
	                <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch()" />
<!--                     <label style="font-family:Verdana;">编码：</label>
                    <input class="nui-textbox" width="100" id="search-code" name="code"/>
                    <label style="font-family:Verdana;">名称：</label>
                    <input class="nui-textbox" width="100" id="search-name" name="name"/>
                    <label style="font-family:Verdana;">品牌车型：</label>
                    <input class="nui-textbox" width="100" id="search-applyCarModel" name="applyCarModel"/>
                    <label style="font-family:Verdana;">拼音：</label>
                    <input class="nui-textbox" width="100" id="search-namePy" name="namePy"/> -->
                    <label style="font-family:Verdana;">品牌：</label>
                    <input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="nameCn"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
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
        <div size="240" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;text-align: center;">
                <span>配件分类</span>
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
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
                <a class="nui-button" iconCls="" plain="true" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="editPart()" id="editBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" iconCls="" plain="true" onclick="disablePart()" id="disableBtn"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
                <a class="nui-button" iconCls="" plain="true" onclick="enablePart()" id="enableBtn" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;启用</a>
                <!-- <a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a> -->
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="reloadData()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
            </div>
            <div class="nui-fit" >
              <div id="mainTabs" class="nui-tabs" name="mainTabs"
                   activeIndex="0" 
                   style="width:100%; height:100%;" 
                   plain="false" 
                   onactivechanged="">
                
                <div title="本地配件资料" name="local" id="local" >
                    <div class="nui-fit">
                        <div id="partLoalGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             frozenStartColumn="0"
                             frozenEndColumn="7"
                             borderStyle="border:0;"
                             dataField="parts"
                             url=""
                             onrowdblclick="onPartGridRowDblClick"
                             onrowclick="onPartGridRowClick"
                             idField="id"
                             totalField="page.count"
                             selectOnLoad="true"
                             allowCellWrap="true"
                             pageSize="50"
                             sortMode="client"
                             showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                            <div property="columns">
                                <div header="基础信息" headerAlign="center">
                                    <div property="columns">
                                         <div type="indexcolumn">序号</div>
                                        <div  field="name" name="name" width="100px" headerAlign="center" >名称</div>
                                        <div  field="code" name="code" width="90px" headerAlign="center" >编码</div>
               
                                        <div  field="qualityTypeId" width="60px" headerAlign="center">品质</div>
                                        <div  field="partBrandId" width="70px" headerAlign="center">品牌</div>
                                        <div  field="unit" width="30px" headerAlign="center" >单位</div>
                                    </div>
                                </div>
                                <div header="" headerAlign="center">
                                    <div property="columns">
                                        <div  field="spec" name="spec" width="60" headerAlign="center" >规格</div>

                                        <div  field="model" width="100" headerAlign="center" >型号</div>

                                        <div  field="applyCarModel" width="120" headerAlign="center" >品牌车型</div>
                                        <div  field="carTypeIdF" width="80" headerAlign="center" >一级分类</div>
                                        <div  field="carTypeIdS" width="80" headerAlign="center" >二级分类</div>
                                        <div  field="carTypeIdT" width="95" headerAlign="center" >三级分类</div>
                                    </div>
                                </div>
                                <div header="价格信息" headerAlign="center">
                                    <div property="columns">
                                        <div  datatype="float" field="retailPrice" width="60" headerAlign="center" align="right" >零售价</div>
                                        <div  datatype="float" field="wholeSalePrice" width="60" headerAlign="center" align="right" >批发价</div>
                                        <div  datatype="float" field="uniformSellPrice" width="70" headerAlign="center" align="right" >统一价格</div>
                                    </div>
                                </div>
                                <div header="辅助信息" headerAlign="center">
                                    <div property="columns">
                                    	<div   field="fullName" name="fullName" width="180px" headerAlign="center" >全称</div>
                                        <div  field="isDisabled" width="50px" headerAlign="center">状态</div>
                                        <div  field="remark" width="60" headerAlign="center" >备注</div>
                                        <div  field="queryCode" width="100" headerAlign="center" >助记码</div>

                                        <div  field="namePy" width="255" headerAlign="center" >拼音</div>

                                        <div  field="isUniform" width="80" headerAlign="center" header="是否统一售价" ></div>

                                        <div  field="abcType" width="80" headerAlign="center" >ABC类型</div>
                                        <div  field="produceFactory" width="80" headerAlign="center" >生产厂家</div>
                                        <div  field="nameEn" width="120" headerAlign="center" >英文名称</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
                
                <div title="云配件资料" id="main" name="main" >
                    <div class="nui-fit">
                        <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             frozenStartColumn="0"
                             frozenEndColumn="7"
                             borderStyle="border:0;"
                             dataField="parts"
                             url=""
                             onrowdblclick="editPart()"
                             idField="id"
                             totalField="page.count"
                             selectOnLoad="true"
                             allowCellWrap="true"
                             pageSize="50"
                             sortMode="client"
                             showFilterRow="false" allowCellSelect="true" allowCellEdit="false"
                             onrowclick="onNoShow"
                             >
                            <div property="columns">
                                <div header="基础信息" headerAlign="center">  
                                    <div property="columns">  
                                        <div type="indexcolumn">序号</div>
                                        <div  field="name" name="name" width="100px" headerAlign="center" >名称</div>           
                                        <div  field="code" name="code" width="90px" headerAlign="center" >编码</div>
                                        <div  field="qualityTypeId" width="60px" headerAlign="center">品质</div>
                                        <div  field="partBrandId" width="70px" headerAlign="center">品牌</div>
                                        <div  field="unit" width="35px" headerAlign="center" >单位</div>
                                    </div>
                                </div>
                                <div header="" headerAlign="center">
                                    <div property="columns">
                                        <div  field="spec" width="100px" headerAlign="center" >规格</div>

                                        <div  field="model" name="model" width="60" headerAlign="center" >型号</div>

                                        <div  field="applyCarModel" name="applyCarModel" width="200" headerAlign="center" >品牌车型</div>
                                        <div  field="carTypeIdF" nem="carTypeIdF" width="80" headerAlign="center" >一级分类</div>
                                        <div  field="carTypeIdS" nem="carTypeIdS" width="80" headerAlign="center" >二级分类</div>
                                        <div  field="carTypeIdT" nem="carTypeIdT" width="95" headerAlign="center" >三级分类</div>
                                    </div>
                                </div>
                                <!-- <div header="价格信息" headerAlign="center">
                                    <div property="columns">
                                        <div  datatype="float" field="retailPrice" width="60" headerAlign="center" align="right" >零售价</div>
                                        <div  datatype="float" field="wholeSalePrice" width="60" headerAlign="center" align="right" >批发价</div>
                                        <div  datatype="float" field="uniformSellPrice" width="70" headerAlign="center" align="right" >统一价格</div>
                                    </div>
                                </div> -->
                                <div header="辅助信息" headerAlign="center">
                                    <div property="columns">
                                    	<div   field="fullName" name="fullName" width="250px" headerAlign="center" >全称</div>
                                        <div  field="isDisabled" width="50px" headerAlign="center">状态</div>
                                    	<div  field="remark" width="60" headerAlign="center" >备注</div>
                                    
                                        <div  field="queryCode" width="130" headerAlign="center" >助记码</div>

                                        <div  field="namePy" width="170" headerAlign="center" >拼音</div>

                                        <div  field="isUniform" width="85" headerAlign="center" header="是否统一售价" ></div>

                                        <div  field="abcType" width="80" headerAlign="center" >ABC类型</div>
                                        <div  field="produceFactory" name="produceFactory" width="80" headerAlign="center" >生产厂家</div>
                                        <div  field="nameEn" width="120" headerAlign="center" >英文名称</div>
                                    </div>
                                </div>
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
