<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>耗材出库</title>
<script src="<%=request.getContextPath()%>/manage/js/inOutManage/consumableItem/consuambleItem.js?v=1.0.9"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.form_label {
	width: 72px;
	text-align: right;
}

</style>
</head>
<body>

<div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
<!-- 上 -->
	<div size="50%" showCollapseButton="false">
		 <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:1;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <input class="nui-textbox" width="100px" id="morePartCode" name="morePartCode" selectOnFocus="true" enabled="true" emptyText="编码"/>
                        <input class="nui-textbox" width="100px" id="morePartName" emptyText="名称"  selectOnFocus="true" name="morePartName"/>
                        <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox"
                           width="100px"
                           textField="name"
                           valueField="id"
                           valueFromSelect="true"
                           emptyText="品牌"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="品牌"/>
                        <input class="nui-textbox" width="100px" id="moreServiceId" emptyText="入库单号" selectOnFocus="true" name="moreServiceId"/>
                        <span class="separator"></span>
                        <input id="sortType" class="nui-combobox" width="100px" textField="text" valueField="id" emptyText="排序类型"
                                value="1"  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/> 
                        <input class="nui-checkbox" id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/>
                        <span class="separator"></span>
                        <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--                         <a class="nui-button" iconCls="" plain="true" onclick="onOut" id="out"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a> -->
<!--                         <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a> -->
                    
                        <input id="billTypeId" visible="false" class="nui-combobox" textField="name" valueField="customid" />
                        <input id="tempId" visible="false" class="nui-textbox" name="tempId" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">             
                    <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                            borderStyle="border:1;"
                            selectOnLoad="true"
                            showPager="true"
                            pageSize="20"
                            sizeList=[20,50,100,200]
                            dataField="partlist"
                            url=""
                            showModified="false"
                            sortMode="client"
                            ondrawcell=""
                            onrowdblclick=""
                            idField="id"
                            totalField="page.count"
                            allowCellSelect="true" 
                             allowCellEdit="true"  multiSelect="false" 
                            >
                        <div property="columns">
                        	<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                            <div type="indexcolumn">序号</div>
                            <div field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码"></div>
                            <div field="oemCode" name="oemCode" width="80" headerAlign="center" header="OEM码"></div>
                            <div field="partName" partName="name" width="80" headerAlign="center" header="配件名称"></div>
                            <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量"></div>
                            <div allowSort="true" visible="false"  datatype="int" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
                            <div allowSort="true" visible="false"  datatype="float" width="60" field="outQty" headerAlign="center" header="出库数量">
                            	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                                    </div>
                                    <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
                                    <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
                                    <div field="storeId" name="storeId"  id="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
                                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                                    <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
                                    <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
                                    <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
                                    <div field="guestName" width="120px" headerAlign="center" allowSort="true" header="供应商"></div>  

                                    <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称">
<!--                                     	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" /> -->
                            </div> 
                            <div field="pickMan" visible="false"  name="pickMan" width="50" headerAlign="center" header="领料人">
                            	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                            </div>
                            <div field="remark" visible="false"  name="remark" width="50" headerAlign="center" header="备注">
                            	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                            </div>
                            <div field="sourceId" name="sourceId" width="50" headerAlign="center" header="" visible="flase">明细Id</div>
                            <div field="partNameId" name="partNameId" width="50" headerAlign="center" header="" visible="flase">配件名称ID</div>
                            <div field="pickType" name="pickType" width="50" headerAlign="center" header="" visible="flase">配件名称ID</div>
                        </div>
                    </div>
        </div>
    </div>
</div>


<!-- 下 -->
 <div showCollapseButton="false">
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                     <td class="form_label">日期 从:</td>
                <td>
                     <input class="nui-datepicker" id="sCreateDate" allowInput="false" width="100%" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
                </td>
                <td class="">至:</td>
                <td>
                    <input class="nui-datepicker" id="eCreateDate" allowInput="false" width="100%" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                </td>
                <td>
                	<td class="form_label">领料人: </td>
                     <td>
                     <input class="nui-textbox" name="pickMan1"id="pickMan1" allowInput="true" width="" showTime="false" showOkButton="false" showClearButton="false" />
                    </td>
                </td>

                <td><a class="nui-button"  plain="true" onclick="onSearch()"> <span class="fa fa-search fa-lg"></span> 查询</a>
                	<a class="nui-button"  plain="true" onclick="onOut()"> <span class="fa fa-cubes fa-lg"></span> 领料</a>
                	<a class="nui-button"  plain="true" onclick="onBlack()"> <span class="fa fa-check fa-lg"></span> 归库</a>
                
                </td>
            
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div  id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="50"
         totalField="page.count" allowSortColumn="true"   allowCellSelect="true" 
         allowCellEdit="true"  multiSelect="false" 
         frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" width="30">序号</div>
  					
  					<div field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码"></div>
                    <div field="partName" headerAlign="center" allowSort="true" visible="true" width="">配件名称</div>
                    <div field="outQty" headerAlign="center" allowSort="true" visible="true" width="">出库数量</div>

                    <div field="sellUnitPrice" headerAlign="center" allowSort="true" visible="true" width="">单价</div>
                    <div field="sellAmt" headerAlign="center" allowSort="true" visible="true" width="">金额</div>
                    <div field="remark" id="remark" headerAlign="center" allowSort="true" visible="true" width="">备注</div>
                	 <div field="pickDate" headerAlign="center" allowSort="true" visible="true" width="" format="yyyy-MM-dd" dateFormat="yyyy-MM-dd">出库日期</div>  
                    <div field="pickMan" headerAlign="center" allowSort="true" visible="true" width=""  align="right">领料人</div>
                    <div field="returnReasonId" id="returnReasonId" headerAlign="center" allowSort="true" visible="false" width="">归库原因ID
                    	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                    </div>
                    <div field="returnRemark" id="returnRemark" headerAlign="center" allowSort="true" visible="false" width="">归库原因
                    	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                    </div>
                    <div field="returnMan" id="returnMan" headerAlign="center" allowSort="true" visible="false" width=""  align="right">归库人
                    	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                    </div> 
                    
            </div>
        </div>
    </div>
</div>


</div>


</body>
</html>