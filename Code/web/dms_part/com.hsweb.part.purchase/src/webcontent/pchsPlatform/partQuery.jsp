<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-10 10:18:54
  - Description:
-->
<head>
<title>配件查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script
	src="<%=webPath + contextPath%>/purchasePart/js/pchsPlatform/partQuery.js?v=1.0.31"></script>
<style type="text/css">
		.table-label {
			text-align: right;
		}
		a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
		a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}
</style>
</head>
<body>
	 <input class="nui-combobox" visible="false" id="unit" name="unit"/>
     <input class="nui-combobox" visible="false" id="abcType"/>
     <input name="billTypeIdE"id="billTypeIdE"  visible="false"class="nui-combobox" />
	 <input name="settleTypeIdE" id="settleTypeIdE"  visible="false" class="nui-combobox"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	<input class="nui-textbox" id="state"visible="false"/>
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">配件编码：</label>
                    <input class="nui-textbox" width="100" id="partCode" name="partCode"/>
                    <label style="font-family:Verdana;">配件名称：</label>
                    <input class="nui-textbox" width="100" id="partName" name="partName"/>
                    <label style="font-family:Verdana;">选择品牌：</label>
                     <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox width1"
                           textField="brandName"
                           valueField="brandCode"
                           emptyText="请选择品牌"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择品牌"/>
<!--                     <label style="font-family:Verdana;">选择厂牌：</label> -->
<!--                     <input id="Carplate" -->
<!--                            name="Carplate" -->
<!--                            class="nui-combobox width1" -->
<!--                            textField="name" -->
<!--                            valueField="id" -->
<!--                            emptyText="请选择..." -->
<!--                            url="" -->
<!--                            allowInput="true" -->
<!--                            showNullItem="false" -->
<!--                            nullItemText="请选择..."/> -->
                    <span class="separator"></span>
                    
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--                     <a  class="nui-button" id="signBtn" onclick="platformSignIn" text="配件采购平台注册"  style="float:right; "></a> -->
                    <input class="nui-hidden" width="180" id="protoken" name="protoken"/>
                    <span id="useMoney" align="right">平台额度:<span id="money"></span></span>
<!-- 					<a class="nui-button" iconCls="" plain="true" onclick="getToken()"><span class=""></span>&nbsp;获取token</a> -->
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
                    dataField="data"
                    ondrawnode="onDrawNode" 
                    onnodedblclick="onNodeDblClick" ajaxData="setRoleId" 
                    showTreeIcon="true" textField="name" idField="id" parentField="parentid" resultAsTree="false">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false">
            <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
	        <!-- 上 -->
	        <div size="50%" showCollapseButton="false">
         	<div class="nui-fit" >
         		 <div id="partGrid" class="nui-datagrid" style="float:left;width:100%;height:100%;"
	                     borderStyle="border:0;"
	                     dataField="data"
	                     url=""
	                     idField="id"
	                     totalField="page.count"
	                     onselectionchanged="onGridSelectionChanged()"
	                     selectOnLoad="true"
	                     pageSize="500"
	                     sizeList="[200,500,1000]"
	                     pageIndexField="currpage"
	                     pageSizeField="count"
	                     sortMode="client"
	                     onshowrowdetail="onShowRowDetail"
     					 allowCellWrap = true
	                     showFilterRow="false" allowCellSelect="false" allowCellEdit="false">
		          	 	<div property="columns">
		          	 		<div type="indexcolumn">序号</div>
		          	 		<div allowSort="true" field="goodsCode" width="50" headerAlign="center" allowSort="true">商品内码</div>
		          	 		<div allowSort="true" field="partsCode" width="100" headerAlign="center" allowSort="true">配件编码</div>
		          	 		<div allowSort="true" field="goodsName" width="300" headerAlign="center" allowSort="true">全称</div>
		          	 		<div allowSort="true" field="brandName" width="100" headerAlign="center" allowSort="true">品牌</div>
		          	 		<div allowSort="true" field="countQty" visible="false" width="100" headerAlign="center" allowSort="true">库存量</div>
		          	 	</div>
		          </div>
         	</div>
        </div>
        
        <div  showCollapseButton="false">
        	<div class="nui-toolbar" style="padding:2px;border-bottom:1;">
        		<table id="top"style="width:100%;">
        			<tr>
        				<td>
        					<label style="font-family:Verdana;">配件详情：</label>
        				</td>
        			</tr>
        		</table>
        	</div>
        	<div class="nui-fit">
        		<div id="partDetailGrid" class="nui-datagrid" style="float:left;width:100%;height:100%;"
				       borderStyle="border:0;"
	                     dataField="data"
	                     url=""
	                     idField="id"
	                     totalField="page.count"
	                     selectOnLoad="true"
	                     pageSize="50"
	                     pageIndexField="currpage"
	                     pageSizeField="count"			       
	                     allowCellSelect="true"
	                     allowCellWrap = "false"
				       allowSortColumn="true">
				      <div property="columns">
				      	   <div headerAlign="center" type="indexcolumn" width="30">序号</div>
				           <div field="goodsCode" name="goodsCode" width="80" visible="true" headerAlign="center" header="商品内码"></div>
					       <div field="partsCode" headerAlign="partsCode" visible="true" width="80"header="编码"></div>
					       <div field="partsName" headerAlign="partsName" visible="true" width="80"header="配件名称"></div>
					       <div field="oemCode" headerAlign="oemCode" visible="true" width="80"header="原厂编码"></div>
					       <div field="unit" headerAlign="oemCode" visible="true" width="30"header="单位"></div>
					       <div field="full_name" id="full_name" visible="false" width="260" headerAlign="center" header="全称"></div>
					       <div field="brandCode" name="brandCode" visible="false" headerAlign="center" header="品牌编码"></div>
					       <div field="brandName" name="brandName" visible="true"  width="60" headerAlign="center" header="品牌"></div>
					       <div field="carName"  width="60" visible="false" headerAlign="center" header="厂牌"></div>
				           <div field="storeCode"  width="60" visible="false" headerAlign="center" header="配件商编码"></div>
						   <div field="storeName" width="150" headerAlign="center" allowSort="true" header="配件商"></div>
					       <div field="qty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center"header="库存" ></div>
						   <div field="price" width="60" headerAlign="center" allowSort="true" header="销售价"></div>
					   	   <div field="wareHouseName" id="wareHouseName" width="140" headerAlign="center" header="仓库"></div>
						   <div field="action" width="180" headerAlign="center" allowSort="true" header="操作"></div>
				      </div>
				 </div>
        	</div>
        </div>
        </div>
   </div>
</div>
</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>