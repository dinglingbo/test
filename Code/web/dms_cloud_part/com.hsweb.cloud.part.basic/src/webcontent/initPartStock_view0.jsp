<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>期初库存</title>
<script src="<%=webPath + contextPath%>/basic/js/initPartStock.js?v=2.0.8"></script>
<style type="text/css">
.title {
  width: 80px;
  text-align: right;
}

.title.required {
  color: red;
}

.title.wide {
  width: 100px;
}

.mini-panel-border {
  border: 0;
}

.mini-panel-body {
  padding: 0;
}
</style>
</head>
<body>




<div class="nui-fit">
		<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
		    <table style="width:100%;">
		        <tr>
		            <td style="width:100%;">
		                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
		                <a class="nui-button" iconCls="" plain="true" onclick="open()" id="openBtn"><span class="fa fa-copy fa-lg"></span>&nbsp;打开</a>
		                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
		                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
					</td>
		        </tr>
		    </table>
		</div>
                <fieldset id="fd1" style="width:99.5%;height: 60px;">
                    <legend><span>期初库存信息</span></legend>
                    <div class="fieldset-body">
                    
                        <div id="basicInfoForm" class="form" contenteditable="false">
                            <input class="nui-hidden" name="id"/>
                            <input class="nui-hidden" name="operateDate"/>
                            <input class="nui-hidden" name="auditSign"/>
                            <input class="nui-hidden" name="versionNo"/>
                            <input class="nui-hidden" name="guestId"/>
                            <input class="nui-hidden" id="enterTypeId" name="enterTypeId"/>
                            <table style="width: 100%;">
                                <tr>
                                    <td class="title required">
                                        <label>默认仓库：</label>
                                    </td>
                                    <td>
                                        <input id="storeId"
                                               name="storeId"
                                               class="nui-combobox width1"
                                               textField="name"
                                               valueField="id"
                                               emptyText="请选择..."
                                               url=""
                                               allowInput="false"
                                               showNullItem="false"
                                               width="100%"
                                               nullItemText="请选择..."/>
                                    </td>
                                    <td class="title ">
                                        <label>业务员：</label>
                                    </td>
                                    <td colspan="1">
                                        <input class="nui-textbox" id="orderMan" name="orderMan" width="100%">
                                    </td>
                                    <td class="title">
                                        <label>入库单号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" />
                                    </td><td class="title">
                                        <label>备注：</label>
                                    </td>
                                    <td colspan="5">
                                        <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                       
                    </div>
                </fieldset>

            <div class="nui-toolbar" style="padding:0px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="" onclick="addPart()" id="addPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;添加</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="deletePart()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                            <a class="nui-button" plain="true" iconCls="" onclick="importPart()" id="importPartBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                        </td>
                    </tr>
                </table>
            </div> 

            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     dataField="pjEnterDetailList"
                     idField="id"
                     showSummaryRow="true"
                     frozenStartColumn="0"
                     frozenEndColumn="0"
                     ondrawcell="onRightGridDraw"
                     allowCellSelect="true"
                     allowCellEdit="true"
                     oncellcommitedit="onCellCommitEdit"
                     ondrawsummarycell=""
                     showModified="false"
                      multiSelect="true"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                        	<div type="checkcolumn" width="20" ></div>
                            
                              <div field="partId" summaryType="count" width="50" headerAlign="center" header="配件ID"></div>
                                <div field="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                                <div field="comPartName" headerAlign="center" header="配件名称"></div>
                                <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                <div field="comUnit" width="40" headerAlign="center" header="单位"></div>
                            </div>
                        </div>
                        <div header="数量金额信息" headerAlign="center">
                            <div property="columns">
                                <div field="enterQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
                                  <input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="enterPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
                                  <input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="sellPrice" numberFormat="0.0000" width="50" headerAlign="center" header="销售价">
                                  <input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="enterAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
                                  <input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="remark" width="80" headerAlign="center" allowSort="true">
                    备注<input property="editor" class="nui-textbox"/>
                    </div>
                            </div>
                        </div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div field="storeShelf" width="80" headerAlign="center" allowSort="true">
                                    仓位<input property="editor" class="nui-textbox"/>
                                </div>
                                <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="true">
                    仓库<input  property="editor" enabled="true" name="storehouse" data="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
                                  url=""
                                  onvaluechanged="" emptyText=""  vtype="required"
                                  /> 
                    </div>  
                  <div field="comOemCode" width="60" headerAlign="center" allowSort="true" header="OE码"></div> 
                  <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                               
                            </div>
                        </div>
                        <div header="不含税信息" headerAlign="center">
                            <div property="columns">
                                <div field="noTaxPrice" width="50" headerAlign="center" header="单价"></div>
                                <div field="noTaxAmt" summaryType="sum" numberFormat="0.0000" width="50" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                        <div header="含税信息" headerAlign="center">
                            <div property="columns">
                                <div field="taxRate" width="50" headerAlign="center" header="税率"></div>
                                <div field="taxPrice" width="50" headerAlign="center" header="单价"></div>
                                <div field="taxAmt" summaryType="sum" numberFormat="0.0000" width="50" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
     
    
</div>

</body>
</html>
