<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-27 09:25:58
  - Description:
-->
<head>
<title>零件详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>    
    
    <script src="<%=contextPath%>/epc/common/llqCommon.js?v=1.0.3" type="text/javascript"></script>
    <script src="<%=contextPath%>/epc/vin/js/partDetail.js?v=1.0.9" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit">
        <%--<h1 style="color:black" align="center">零件详情</h1> --%>
	   
        <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
		     onactivechanged="changeTabs" >
            <div title="基础信息"  id="basic" name="basic" >
			     <div class="nui-fit">   
			        <div id="dgbasic" class="nui-datagrid"
			             style="width:100%;height:100%;"
			             showColumns="fasle"
			             showPager="fasle" >                
			            <div property="columns">                                             
			                <div field="field1" width="20px" align="right"></div>
			                <div field="field2" align="left"></div>
			            </div>
			        </div>
			   </div>           
            </div>
            <div title="渠道价格"  id="price" name="price" >
            	   <div class="nui-fit">   
				        <div id="dgprice" class="nui-datagrid"
				             allowCellEdit="true" allowCellSelect="true"
				             style="width:100%;height:100%;"
				             showPager="fasle" >                
				            <div property="columns">                                              
				                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
				                <div field="pid" headerAlign="center" width="100px" align="center">零件号</div>
				                <div field="partType" headerAlign="center" width="50px" align="center">零件类型</div>
				                <div field="mill" headerAlign="center" width="50px" align="center">厂家</div>
				                <div field="factory_type" headerAlign="center" width="50px" align="center" renderer="onFactoryTypeRender">产商类型</div>
				                <div field="costPrice" headerAlign="center" width="60px" align="center">含税进货价</div>
				                <div field="eotPrice" headerAlign="center" width="60px" align="center">不含税进货价</div>
				                <div field="salePrice" headerAlign="center" width="50px" align="center">售价</div>
				                <div field="origin" headerAlign="center" width="50px" align="center">产地</div>
				                <div field="remark" headerAlign="center" width="50px" align="center">备注</div>
				                <div field="supplier" headerAlign="center" width="50px" align="center">服务商</div>
				            </div>
				        </div>
				   </div> 
            </div>
            <div title="替换件"  id="replace" name="replace" >
            	   <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">    
				        <div size="50%" showCollapseButton="false">
				        	<div class="nui-fit">
				        		<div class="nui-toolbar" style="border-bottom: 0;">
									<span>直接替换</span>
									<a style="display:none;"href="javascript:;">看不懂请点我<img style="display:none;" src="https://cdns.007vin.com/img/interpretation.png"></a>
						        </div>
						        <div id="dgreplace" class="nui-datagrid" onDrawcell="onDeReplaceDraw"
						             allowCellEdit="true" allowCellSelect="true"
						             style="width:100%;height:85%;"
						             onshowrowdetail="onShowRowDetail"
						             showPager="fasle" >                
						            <div property="columns"> 
						                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
						            	<div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>                                              
						                <div field="parentNum" headerAlign="center" width="50px" align="center">零件号</div>
						                <div field="lable" headerAlign="center" width="50px" align="center">零件名称</div>
						                <div field="prices" headerAlign="center" width="50px" align="center">参考价格</div>
						                <div field="ptype" headerAlign="center" width="50px" align="center">型号</div>
						                <div field="brandcn" headerAlign="center" width="50px" align="center">品牌中文名称</div>
						                <div field="counts" headerAlign="center" width="50px" align="center">件数</div>
						            </div>
						        </div>
					        </div>
				        </div>
				        
				        <div size="50%" showCollapseButton="false">
				        	<div class="nui-fit">
				        		<div class="nui-toolbar" style="border-bottom: 0;">
									<span>间接替换</span>
						        </div>
						        <div id="dgreplace2" class="nui-datagrid" onDrawcell="onDeReplaceDraw"
						             allowCellEdit="true" allowCellSelect="true"
						             style="width:100%;height:85%;"
						             onshowrowdetail="onShowRowDetail2"
						             showPager="fasle" >                             
						            <div property="columns">
						                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
						            	<div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>                                               
						                <div field="parentNum" headerAlign="center" width="50px" align="center">零件号</div>
						                <div field="lable" headerAlign="center" width="50px" align="center">零件名称</div>
						                <div field="prices" headerAlign="center" width="50px" align="center">参考价格</div>
						                <div field="ptype" headerAlign="center" width="50px" align="center">型号</div>
						                <div field="brandcn" headerAlign="center" width="50px" align="center">品牌中文名称</div>
						                <div field="counts" headerAlign="center" width="50px" align="center">件数</div>
						            </div>
						        </div>
					        </div>
				        </div>
				               
				   </div>
				   
				   <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
				
				   <div id="innerPartGrid"
				       dataField="innnerData"
				       allowCellWrap = true
				       class="nui-datagrid"
				       style="width: 100%; height: 100px;"
				       showPager="false"
				       allowSortColumn="true">
				      <div property="columns">
					        <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>                           
					        <div field="pid" headerAlign="center" width="50px" align="center">零件号</div>
					        <div field="lable" headerAlign="center" width="50px" align="center">零件名称</div>
					        <div field="prices" headerAlign="center" width="50px" align="center">参考价格</div>
					        <div field="ptype" headerAlign="center" width="50px" align="center">型号</div>
					        <div field="brandcn" headerAlign="center" width="50px" align="center">品牌中文名称</div>
				<!-- 	        <div field="counts" headerAlign="center" width="50px" align="center">件数</div> -->
				      </div>
				   </div>
				</div>
            </div>
            <div title="适用车型"  id="compatible" name="compatible" >
            	    <a class="nui-button continue" style="display:none;" onclick="showRightGrid(gridCfg)">加载更多...</a>
				    <div class="nui-fit">   
				        <div id="dgcompatible" class="nui-datagrid"
				             style="width:100%;height:100%;"
				             showColumns="true"
				             showPager="fasle" >                
				            <div property="columns">
				                <div type="indexcolumn" width="20" summaryType="count" align="center">序号</div>
				                <div field="brandName" headerAlign="center" align="left" width="20px">品牌</div>
				                <div field="carsModel" headerAlign="center" align="left">品牌车型</div>
				                <div field="year" headerAlign="center" width="20px" align="left">年份</div>
				            </div>
				        </div>
				    </div>  
            </div>
<%--             <!--基础信息-->
            <%@include file="/epc/vin/partDetail_basic.jsp" %>
            <!--渠道价格-->
            <%@include file="/epc/vin/partDetail_price.jsp" %>
            <!--替换件-->
            <%@include file="/epc/vin/PartDetail_replace_2.jsp" %>
            <!--品牌件-->
            <%@include file="/epc/vin/partDetail_article.jsp" %>
            <!--组件-->
            <%@include file="/epc/vin/partDetail_compt.jsp" %>
            <!--技术信息-->
            <%@include file="/epc/vin/partDetail_baseinfo.jsp" %>
            <!--适用车型-->
            <%@include file="/epc/vin/partDetail_compatible.jsp" %>
            <!--库存分布-->
            <%@include file="/epc/vin/partChainStock.jsp" %> --%>
        </div>
    </div>
</body>
</html>
<script>
    var pid = '<b:write property="pid"/>';
    var brand = '<b:write property="brand"/>';
</script>