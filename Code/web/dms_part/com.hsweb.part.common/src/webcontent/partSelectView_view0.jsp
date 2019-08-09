<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>配件管理</title>
<script src="<%=webPath + contextPath%>/commonPart/js/partSelect.js?v=1.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="unit"/>
    <input class="nui-combobox" visible="false" id="abcType"/>
    <input class="nui-combobox" visible="false" id="bxMsg"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	<input class="nui-textbox" id="state"visible="false"/>
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">编码：</label>
                    <input class="nui-textbox" width="100" id="search-code" name="code"/>
                    <label style="font-family:Verdana;">名称：</label>
                    <input class="nui-textbox" width="100" id="search-name" name="name"/>
                    <!-- <label style="font-family:Verdana;">品牌车型：</label>
                    <input class="nui-textbox" width="100" id="search-applyCarModel" name="applyCarModel"/>
                    <label style="font-family:Verdana;">拼音：</label>
                    <input class="nui-textbox" width="100" id="search-namePy" name="namePy"/>
                    <label style="font-family:Verdana;">规格：</label>
                    <input class="nui-textbox" width="100" id="search-spec" name="spec"/> -->
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"  onenter="onSearch()"/>
                    <label style="font-family:Verdana;">品牌：</label>
                     <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择品牌"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择品牌"/>
                    <input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="nameCn"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           style="display:none;"
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                      &nbsp;&nbsp;
                    <input type="checkbox" id="qtySign" class="mini-checkbox" trueValue="1" falseValue="0" >
	                <span >显示零库存</span>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!--<a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>-->
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
        
        	<div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
				<!--上：配件信息-->
				<div size="65%" showCollapseButton="false">
				     <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
		                <a class="nui-button" iconCls="" plain="true" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
		                <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
		                <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		            </div>
		            <div class="nui-fit" >
		                <div id="partGrid" class="nui-datagrid" style="float:left;width:100%;height:100%;"
		                     frozenStartColumn="0"
		                     frozenEndColumn="5"
		                     borderStyle="border:0;"
		                     dataField="parts"
		                     url=""
		                     idField="id"
		                     totalField="page.count"
		                     onrowdblclick="onOk()"
		                     selectOnLoad="true"
		                     pageSize="55"
		                     sortMode="client"
		                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
		                    <div property="columns">
		                        <div header="基础信息" headerAlign="center">
		                            <div property="columns">
		                                <div type="indexcolumn">序号</div>
		                                <div allowSort="true" field="fullName" width="100" headerAlign="center" allowSort="true">全称</div>
		                                <div allowSort="true" field="qualityTypeId" width="50" headerAlign="center">品质</div>
		                                <div allowSort="true" field="partBrandId" width="50" headerAlign="center">品牌</div>
		                                <div allowSort="true" field="code" width="100" headerAlign="center" allowSort="true">编码</div>
		       							<div allowSort="true" field="stockQty" width="55" headerAlign="center" allowSort="true">本店库存</div>
		       							<div allowSort="true" field="newestSellPrice" width="70" headerAlign="center" allowSort="true">最新销价</div>
		                                <div allowSort="true" field="applyCarModel" width="70" headerAlign="center" allowSort="true">品牌车型</div>
		                                <div allowSort="true" field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
		                            </div>
		                        </div>
		                        <div header="" headerAlign="center">
		                            <div property="columns">
		                                <div allowSort="true" field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
		
		                                <div allowSort="true" field="model" width="60" headerAlign="center" allowSort="true">型号</div>
		
		                               
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
		                                <div allowSort="true" field="name" width="80" headerAlign="center" allowSort="true">名称</div>
		                                <div allowSort="true" field="queryCode" width="60" headerAlign="center" allowSort="true">助记码</div>
		
		                                <div allowSort="true" field="namePy" width="60" headerAlign="center" allowSort="true">拼音</div>
		
		                                <div allowSort="true" field="isUniform" width="70" headerAlign="center" header="是否统一售价" allowSort="true"></div>
		
		                                <div allowSort="true" field="abcType" width="80" headerAlign="center" allowSort="true">ABC类型</div>
		                                <div allowSort="true" field="produceFactory" width="80" headerAlign="center" allowSort="true">生产厂家</div>
		                                <div allowSort="true" field="nameEn" width="120" headerAlign="center" allowSort="true">英文名称</div>
		                                <div allowSort="true" field="isDisabled" width="50" headerAlign="center">状态</div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            	
		            	<div id="splitDiv" style="float:left;width:1%;height:100%;display:none"></div>
		                <div id="tempGrid" class="nui-datagrid" style="float:left;width:29%;height:100%;display:none"
		                  showPager="false"
		                  pageSize="1000"
		                  selectOnLoad="true"
		                  showModified="false"
		                  onrowdblclick=""
		                  multiSelect="true"
		                  dataField="parts"
		                  url="">
		                  <div property="columns" >
		                    <div type="indexcolumn" width="20px" headerAlign="center">序号</div>
		                    <div header="已添加配件" headerAlign="left">
		                      <div property="columns">
		                        <div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" 
		                          width="20" headerAlign="center" header="">操作
		                        </div>
		                        <div field="partName" headerAlign="center" allowSort="true" width="80px">配件名称</div>
		                        <div field="unitPrice" headerAlign="center" allowSort="true" width="20px">金额</div>                
		                      </div>
		                    </div>
		                  </div>
		                </div>
		
		            </div>
		            
				</div>
				<!--下：库存分布-->
				<div showCollapseButton="false">
				    <div class="nui-fit">
      
				      	<div id="mainTabs" class="nui-tabs" 
				      		 activeIndex="0" 
				      		 style="width:100%; height: 100%;" 
				      		 plain="false" 
				      		 ontabload="onMainTabLoad"
				      		 >
						    <div title="库存分布" name="chainStock" url="">
						      	<div class="nui-fit">
								    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
								         showPager="true"
								         dataField="result"
								         idField="detailId"
								         ondrawcell="onDrawCell"
								         sortMode="client"
								         url=""
								         onrowdblclick=""
								         sizeList="[10,20,50]"
								         pageSize="10"
				      		             totalField="page.count"
								         showSummaryRow="false">
								        <div property="columns">
								            <div type="indexcolumn">序号</div>
								            <div allowSort="true" field="sellerName" width="80" headerAlign="center" header="供应商名称"></div>
								            <div allowSort="true" field="sellerCity" width="80" headerAlign="center" header="供应商所在地"></div>
								            <div allowSort="true" field="searchOe" width="60" headerAlign="center" header="配件编码"></div>
								            <div allowSort="true" field="prodName" width="60" headerAlign="center" header="配件名称"></div>
								            <div allowSort="true" field="prodUom" width="60" headerAlign="center" header="配件单位"></div>
								            <div allowSort="true" field="prodQuality" width="60" headerAlign="center" header="品质"></div>
								            <div allowSort="true" field="prodBrand" width="60" headerAlign="center" header="品牌"></div>
								            <!-- <div allowSort="true" field="carName" width="60" headerAlign="center" header="厂牌"></div> -->
								            <div allowSort="true" field="stockQty" width="60" headerAlign="center" header="库存数量"></div>
								            <div allowSort="true" field="price" width="60" headerAlign="center" header="单价"></div>
								            <div allowSort="true" field="vehBrand" width="100" headerAlign="center" header="车辆品牌"></div>
								            <div allowSort="true" field=" vehVehicle" width="60" headerAlign="center" header="车辆型号"></div>
								        </div>
								    </div>
								</div>
						    </div> 
						    <div title="本店库存" name="stockselect" url="" visible="false" >
						      
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
