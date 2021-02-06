<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<style>	
.separator{
   margin-left:0px;
   margin-right:0px;
}

</style>
<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true" id="partPanel">
<!-- 上 -->
	<div size="50%" showCollapseButton="false" >
		<div id="gridParts" 
		    class="nui-datagrid" 
		    style="width:100%;height:100%;display:none;"
		    showColumns="true"
		    showPager="false"
		    allowcellwrap="true"
		    allowCellSelect="true"
		    allowCellEdit="true"
		    showModified="false"
		    showSummaryRow="true">
		    <div property="columns"> 
		        <!-- <div type="indexcolumn" width="20" summaryType="count">序号</div> -->
		        <div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" 
		             width="25" headerAlign="center" header=""><span class="fa fa-check"></span>
		        </div>
		        <div field="pnum" width="20" headerAlign="center" allowSort=false summaryType="count">位置</div>
		        <div field="pid" width="60" headerAlign="center" allowSort=false>零件OE号</div>
		        <div field="label" width="80" headerAlign="center" allowSort=false>名称</div>
		        <div field="quantity" width="20" headerAlign="center" allowSort=false>件数</div>
		        <div field="model" width="50" headerAlign="center" allowSort=false>型号</div>
		        <div field="remark" width="80" headerAlign="center" allowSort=false>备注</div>
		        <div field="prices" width="50" headerAlign="center" allowSort=false>参考价格</div>
		        <div field="" width="20" headerAlign="center" allowSort=false>说明</div>
		        <div field="detail" width="20" headerAlign="center" allowSort=false></div>
		        <!-- <div field="opt" width="20" headerAlign="center" align="center" allowSort=false></div> -->
		    </div>
		</div>
		
	</div>
	
	<div size="50%" showCollapseButton="true">
		<div  class="nui-splitter"  vertical="false" style="width:100%;height:100%;" allowResize="true">
			<div size="55%" showCollapseButton="false">
			
				<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
				 	<div class="nui-fit">
		            <div class="form" id="queryForm">
		            	<h1 style="color:#222">购物车(临时存放信息)</h1>
		                <table style="width:100%;height:40px"">
		                    <tr>
		                        <td style="white-space:nowrap;">
		                            <a class="nui-button car" iconCls="" plain="true" onclick="deleteCartShop()" ><span class="part-span">删除</span></a>
		                            <span class="separator"></span>
		                            <a class="nui-button car" iconCls="" visible="true" id="pchsCartBtn" plain="true" onclick="addToPchsCart()"><span class="part-span">添加采购车</span></a>
		                            <a class="nui-button car" iconCls="" visible="true" id="sellCartBtn" plain="true" onclick="addToSellCart()"><span class="part-span">添加销售车</span></a>
		                            <span class="separator"></span>
		                            <a class="nui-button car" iconCls="" visible="true" id="pchsOrderBtn" plain="true" onclick="generatePchsOrder()"><span class="part-span">生成采购订单</span></a>
		                            <a class="nui-button car" iconCls="" visible="true" id="sellOrderBtn" plain="true" onclick="generateSellOrder()"><span class="part-span">生成销售订单</span></a>
		            
		                            <a class="nui-button car" visible="true" plain="true"onclick="copyEmbed()" id="copyBtn" data-clipboard-action="copy"><span class="part-span">一键复制</span></a>							
		                     
		                        </td>
		                    </tr>
		                </table>
		            </div>
		            </div>
		        </div>
		
		        <div class="nui-fit">
		                <div id="cartPartGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                             borderStyle="border:0;"
		                             showPager="false"
		                             dataField="list"
		                             url=""
		                             showSummaryRow="true"
		                             idField="id"
		                             totalField="page.count"
		                             pageSize="100"
		                             oncellcommitedit="onCellCommitEdit"
		                             showPager="true"
		                             showLoading="false"
		                             multiSelect="true"
		                             showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
		                        <div property="columns">
		                                <div type="indexcolumn">序号</div>
		                                <div type="checkcolumn" width="25"></div>
		                                <div field="partId" width="50" visible="false" headerAlign="center">配件ID</div>
		                                <div field="pid" width="100" headerAlign="center" allowSort="true" summaryType="count">零件OE号</div>
		                                <div field="label" width="120" headerAlign="center" allowSort="true">名称</div>
		                                <div field="PCS" width="30" visible="false" headerAlign="center" allowSort="true">单位PCS</div>
		                                <div field="orderQty" width="50" headerAlign="center" allowSort="true">
		                                    数量<input property="editor" vtype="float" class="nui-textbox"/>
		                                </div>
		                                <div field="orderPrice" width="50" headerAlign="center" allowSort="true">
		                                    单价<input property="editor" vtype="float" class="nui-textbox"/>
		                                </div>
		                                <div field="remark" width="80" headerAlign="center" allowSort="true">备注<input property="editor" class="nui-textbox"/></div>
		                        </div>
		                </div>
		        </div>
		        
			</div>
			
			<div size="45%" showCollapseButton="false">
				<div class="nui-fit">
				<h1 style="color:#222">库存分布</h1>
				<div id="stockGrid" class="nui-datagrid" style="width:100%;height:90%;"
			         showPager="false"
			         dataField="detailList"
			         idField="detailId"
			         ondrawcell="onDrawCell"
			         sortMode="client"
			         url=""
			         onrowdblclick=""
			         pageSize="10000"
			         sizeList="[1000,5000,10000]"
			         showSummaryRow="false">
			        <div property="columns">
			            <div type="indexcolumn" width="30">序号</div>
			            <div allowSort="true" field="shortName" width="100" headerAlign="center" header="供应商名称"></div>
			            <div allowSort="true" field="storeId" width="70" headerAlign="center" header="仓库"></div>
			            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
			            <div allowSort="true" field="sellPrice" width="60" headerAlign="center" header="售价"></div>
			            <div allowSort="true" field="manager" width="60" headerAlign="center" header="联系人"></div>
			            <div allowSort="true" field="mobile" width="60" headerAlign="center" header="联系人手机"></div>
			            <div allowSort="true" field="contactor" width="60" headerAlign="center" header="业务员"></div>
			            <div allowSort="true" field="contactorTel" width="60" headerAlign="center" header="业务员手机"></div>
			            <div allowSort="true" field="address" width="180" headerAlign="center" header="公司地址"></div>
			        </div>
			    </div>
				</div>	
				
			</div>
		</div>
	</div>
</div>