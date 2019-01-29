<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="替换件" name="replace" visible="fasle">    
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
		                <div field="parentnum" headerAlign="center" width="50px" align="center">零件号</div>
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
		                <div field="parentnum" headerAlign="center" width="50px" align="center">零件号</div>
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



