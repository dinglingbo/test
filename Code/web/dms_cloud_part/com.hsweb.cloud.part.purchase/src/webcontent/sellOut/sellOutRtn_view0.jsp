<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%-- <%@include file="/common/common.jsp"%> --%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>销售退货</title>
<script src="<%= request.getContextPath() %>/purchase/js/sellOut/sellOutRtn.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
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

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">上周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)" id="type6">未审</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)" id="type7">已审</a>
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)" id="type8">已过帐</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)" id="type9">全部</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">客户：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="add()" id="addBtn">新增</a>
                <!-- <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" id="editEnterMainBtn">修改</a> -->
                <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()" id="saveBtn">保存</a>
                <!-- <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" id="cancelEditEnterMainBtn">取消</a> -->
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="audit()" id="auditBtn">审核</a>
                <a class="nui-button" iconCls="icon-print" plain="true" onclick="print()" id="printBtn">打印</a>
            </td>
        </tr>
    </table>
</div>


<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="true"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="300" showCollapseButton="true">
	        <div title="采购入库列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="true"
                 	   pageSize="50"
                 	   sizeList=[20,50,100,200]
                     selectOnLoad="true"
                     showModified="false"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick=""
                     onselectionchanged="onLeftGridSelectionChanged"
                     onbeforedeselect="onLeftGridBeforeDeselect"
                     dataField="pjEnterMainList"
                     url="">
                    <div property="columns">
                    	<div type="indexcolumn">序号</div>
                        <div field="serviceId" headerAlign="center" width="150" header="退货单号"></div>
                        <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
                        <div field="auditSign" width="35" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" width="80" headerAlign="center" header="客户"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                    </div>
                </div>
                <!--footer-->
                <!-- <div property="footer">
                    <input type='nui-textbox' value='Footer' readonly="true" style='vertical-align:middle;'/>
                </div> -->
            </div>
        </div>
        <div showCollapseButton="false">
            <!-- <div title="订单信息" class="nui-panel"
                 style="width:100%;height: 130px;">
            
             -->
                <fieldset id="fd1" style="width:98%;height: 80px;">
                    <legend><span>销售退货信息</span></legend>
                    <div class="fieldset-body">
                    
                        <div id="basicInfoForm" class="form" contenteditable="false">
                            <input class="nui-hidden" name="id"/>
                            <input class="nui-hidden" name="operateDate"/>
                            <input class="nui-hidden" name="versionNo"/>
                            <input class="nui-hidden" id="enterTypeId" name="enterTypeId"/>
                            <table style="width: 100%;">
                                <tr>
                                    <td class="title required">
                                        <label>客户：</label>
                                    </td>
                                    <td colspan="3">
                                        <input id="guestId"
                                               name="guestId"
                                               class="nui-buttonedit"
                                               emptyText="请选择客户..."
                                               onbuttonclick="selectSupplier('guestId')"
                                               onvaluechanged="onGuestValueChanged"
                                               width="100%"
                                               placeholder="请选择客户"
                                               selectOnFocus="true" />
                                    </td>
                                    <td class="title required">
                                        <label>仓库：</label>
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
                                    <td class="title">
                                        <label>退货员：</label>
                                    </td>
                                    <td colspan="1">
                                        <input class="nui-textbox" id="enterMan" name="enterMan" width="100%">
                                    </td>
                                    <td class="title">
                                        <label>退货单号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新退货单号"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="title required">
                                        <label>退货日期：</label>
                                    </td>
                                    <td width="120" colspan="3">
                                        <input name="enterDate"
                                               id="enterDate"
                                               width="100%"
                                               showTime="true"
                                               class="nui-datepicker" enabled="true" format="yyyy-MM-dd H:mm:ss"/>
                                    </td>
                                    <td class="title">
                                        <label>备注：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                                    </td>
                                    <td class="title">
                                        <label>总金额：</label>
                                    </td>
                                    <td colspan="1">
                                        <input class="nui-textbox" width="100%" id="enterAmt" name="enterAmt" enabled="false" style="text-align: right;"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                       
                    </div>
                </fieldset>

                
            <!-- </div> -->
            <div class="nui-toolbar" style="padding:2px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPart()" id="addPartBtn">添加</a>
                            <a class="nui-button" plain="true" iconCls="icon-remove" onclick="deletePart()" id="deletePartBtn">删除</a>
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
                     frozenEndColumn="6"
                     ondrawcell="onRightGridDraw"
                     allowCellSelect="true"
                     allowCellEdit="true"
                     oncellcommitedit="onCellCommitEdit"
                     ondrawsummarycell="onDrawSummaryCell"
                     showModified="false"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                            	<div field="partId" summaryType="count" width="50" headerAlign="center" header="配件ID"></div>
                                <div field="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                                <div field="comPartName" headerAlign="center" header="配件名称"></div>
                                <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                <div field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
                                <div field="comUnit" width="40" headerAlign="center" header="单位"></div>
                            </div>
                        </div>
                        <div header="退货信息" headerAlign="center">
                            <div property="columns">
                                <div field="enterQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
                                	<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="rtnPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
                                	<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="rtnAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
                                	<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="remark" width="80" headerAlign="center" allowSort="true">
					        	备注<input property="editor" class="nui-textbox"/>
					        	</div>
                            </div>
                        </div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="true">
					        	仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
			                            url="com.hsapi.cloud.part.baseDataCrud.crud.getStorehouse.biz.ext"
			                            onvaluechanged="" emptyText=""  vtype="required"
			                            /> 
					        	</div>	
				    			<div field="comOemCode" width="60" headerAlign="center" allowSort="true" header="OEM码"></div>	
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
        	<div title="" class="nui-panel" showHeader="false"
                 style="width:100%;height: 30px;">
                <div id="bottomForm" class="form">
                    <input class="nui-hidden" name="id"/>
                    <table style="width: 100%;">
                    	<tr>
                            <td class="title">
                                <label>创建人：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" width="100%" name="creator" enabled="false"/> <!-- placeholder="新增订单号" -->
                            </td>
                            
                            <td class="title">
                                <label>创建日期：</label>
                            </td>
                            <td >
                                <input name="createDate"
                                       width="100%"
                                       showTime="true" enabled="false"
                                       class="nui-datepicker" enabled="true" format="yyyy-MM-dd H:mm:ss"/>
                            </td>
                            
                            <td class="title">
                                <label>审核人：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" width="100%" name="auditor" enabled="false"/> <!-- placeholder="新增订单号" -->
                            </td>
                            
                            <td class="title">
                                <label>审核日期：</label>
                            </td>
                            <td >
                                <input name="auditDate"
                                       width="100%"
                                       showTime="true" enabled="false"
                                       class="nui-datepicker" enabled="true" format="yyyy-MM-dd H:mm:ss"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="sEnterDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eEnterDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">创建日期:</td>
                <td>
                    <input name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eCreateDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">审核日期:</td>
                <td>
                    <input name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eAuditDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">客户</span>:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">采购单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">配件ID:</td>
                <td colspan="3">
                    <input id="partId"
                           name="partId"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

</body>
</html>
