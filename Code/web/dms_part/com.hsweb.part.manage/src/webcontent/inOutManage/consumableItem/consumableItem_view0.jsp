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
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/consumableItem/consuambleItem.js?v=2.0.18"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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

    <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
        <!-- 上 -->
        <div size="50%" showCollapseButton="false">
         <div class="nui-fit">
            <div  class="nui-toolbar" style="padding:2px;border-bottom:1;">
                <table id="top"style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                           <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton" menu="#popupMenuDate2" id="menunamedate2">所有</a>
                            <ul id="popupMenuDate2" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickMorePartSearch(0)" id="type0">所有</li>
			                    <li iconCls="" onclick="quickMorePartSearch(1)" id="type1">本日</li>
			                    <li iconCls="" onclick="quickMorePartSearch(2)" id="type2">本周</li>
			                </ul>
			                <label style="font-family:Verdana;" style="display:none;">入库日期 从：</label>
			                <input style="" class="nui-datepicker" id="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
			                <label style="font-family:Verdana;" style="display:none;">至</label>
			                <input style=""class="nui-datepicker" id="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <input class="nui-textbox" width="100px" id="morePartCode" name="morePartCode" selectOnFocus="true" enabled="true" emptyText="编码"/>
                            <input class="nui-textbox" width="100px" id="morePartName" emptyText="名称"  selectOnFocus="true" name="morePartName"/>
                            <input id="storeId"
	                           name="storeId"
	                           class="nui-combobox"
	                           textField="name"
	                           valueField="id"
	                           emptyText="仓库"
	                           url="" width="80"
	                           valueFromSelect="true"
	                           allowInput="false"
	                           showNullItem="false"
	                           nullItemText="请选择..."/>
                            <input class="nui-textbox" width="80px" id="storeShelf" emptyText="仓位"  selectOnFocus="true" name="storeShelf"/>
                            <input id="partBrandId"
                            name="partBrandId"
                            class="nui-combobox"
                            width="80px"
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
                            <!--                         <input class="nui-checkbox" id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/> -->
                            <!--                         <span class="separator"></span> -->
                            <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <!--                         <a class="nui-button" iconCls="" plain="true" onclick="onOut" id="out"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a> -->
                            <!--                         <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
                            
                            <input id="billTypeId" visible="false" class="nui-combobox" textField="name" valueField="customid" />
                            <input id="tempId" visible="false" class="nui-textbox" name="tempId" />
                        </td>
                    </tr>
                </table>
            </div>
            
            <ul id="gridMenu" class="mini-contextmenu" >              
		        <li name="enterBtn" iconCls="icon-add" onclick="onEnterRecord">入库记录</li>
			    <li name="outBtn" iconCls="icon-edit" onclick="onOutRecord">出库记录</li>        
		    </ul>
		    
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
                allowCellEdit="true"  
                multiSelect="false" 
                allowCellWrap = true
                showSummaryRow="true"
                contextMenu="#gridMenu"
                >
                <div property="columns">
                   <div type="checkcolumn" width="40" class="mini-radiobutton" header="选择"></div> 
                   <div type="indexcolumn" width="40">序号</div>
                   <div allowSort="true" field="partCode" name="partCode" width="120" headerAlign="center" header="配件编码"></div>
                   <div allowSort="true" field="oemCode" name="oemCode" width="190" headerAlign="center" header="OEM码"></div>
                   <div allowSort="true" field="partName" name="partName" width="100" headerAlign="center" header="配件名称"></div>
                   <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量" summaryType="sum" ></div>
                   <div allowSort="true" visible="false"  datatype="int" width="60" field="preOutQty" headerAlign="center" header="待出库数量" summaryType="sum" ></div>
                   <div allowSort="true" visible="false"  datatype="float" width="60" field="outQty" headerAlign="center" header="出库数量" summaryType="sum" >
                       <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                   </div>
                   <div allowSort="true" field="enterPrice" width="60px" headerAlign="center" allowSort="true" header="库存单价"></div>
                   <div allowSort="true" field="billTypeId" align="left" width="60px" headerAlign="center" allowSort="true" header="票据类型"></div>
                   <div allowSort="true" field="storeId" name="storeId"  id="storeId" width="100" headerAlign="center" allowSort="true" header="仓库"></div>
                   <div allowSort="true" field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                   <div allowSort="true" field="partBrandId" name="partBrandId" width="70" headerAlign="center" header="品牌"></div>
                   <div allowSort="true" field="applyCarModel" name="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
                   <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
                   <div allowSort="true" field="enterCode" width="140" headerAlign="center" header="入库单号"></div>
                   <div allowSort="true" field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="150px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
                   <div allowSort="true" field="guestName" name="guestName" width="280px" headerAlign="center" allowSort="true" header="供应商"></div>  

                   <div allowSort="true" field="fullName" name="fullName" width="300" headerAlign="center" header="配件全称"></div> 
                <div allowSort="true" field="pickMan" visible="false"  name="pickMan" width="50" headerAlign="center" header="创建人">
                   <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
               </div>
               <div allowSort="true" field="remark" visible="false"  name="remark" width="50" headerAlign="center" header="备注">
                   <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
               </div>
               <div allowSort="true" field="sourceId" name="sourceId" width="50" headerAlign="center" header="" visible="flase">明细Id</div>
               <div allowSort="true" field="partNameId" name="partNameId" width="50" headerAlign="center" header="" visible="flase">配件名称ID</div>
               <div allowSort="true" field="pickType" name="pickType" width="50" headerAlign="center" header="" visible="flase">配件名称ID</div>
           </div>
       </div>
   </div>
</div>
</div>


<!-- 下 -->
<div showCollapseButton="false">
    <div class="nui-fit">
        <div class="nui-toolbar" style="border-bottom: 0;">
            <div class="nui-form1" id="queryInfoForm">
                <table class="table">
                    <tr>
                        <td>
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>
                            <ul id="popupMenuDate" class="nui-menu" style="display:none;">
			                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
			                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
			                    <li class="separator"></li>
			                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
			                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
			                    <li class="separator"></li>
			                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
			                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
			                </ul>
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
                           		<input class="nui-combobox" 
					                  id="pickMan1" 
					                  name="pickMan1" 
					                  textField="empName"
					                  valueField="empId"
					          
					                  url=""
					                  allowInput="true"
					                  valueFromSelect="false"
					                  width="100px">
					                <input class="nui-textbox" width="80px" id="partCode" name="partCode" selectOnFocus="true" enabled="true" onenter="onSearch" emptyText="配件编码"/>
    								<input class="nui-textbox" width="80px" id="partName" emptyText="配件名称"  selectOnFocus="true" onenter="onSearch" name="partName"/>
<!--                                <input class="nui-textbox" name="pickMan1"id="pickMan1" allowInput="true" width="" showTime="false" showOkButton="false" showClearButton="false" /> -->
                           </td>
                       </td>

                       <td><a class="nui-button"  plain="true" onclick="onSearch()"> <span class="fa fa-search fa-lg"></span> 查询</a>
                           <a class="nui-button"  plain="true" onclick="onOut()"> <span class="fa fa-cubes fa-lg"></span> 领料</a>
                           <a class="nui-button"  plain="true" onclick="onBlack()"> <span class="fa fa-check fa-lg"></span> 归库</a>
						   <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>                             
                       </td>
                       
                   </tr>
               </table>
           </div>
       </div>
       <div class="nui-fit">
        <div  id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
        pageSize="500" sizeList=[500,1000,2000] sortMode="client"
        totalField="page.count" allowSortColumn="true"   allowCellSelect="true" 
        allowCellEdit="true"  multiSelect="false" allowCellWrap = true showSummaryRow="true"
        frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div allowSort="true" type="indexcolumn" headerAlign="center" width="30">序号</div> 
            
            <div allowSort="true" field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码"></div>
            <div field="partName" name="partName" headerAlign="center" allowSort="true" visible="true" width="">配件名称</div>
            <div field="outQty" headerAlign="center" allowSort="true" visible="true" width="" summaryType="sum" >出库数量</div>

            <div field="sellUnitPrice" headerAlign="center" allowSort="true" visible="true" width="">单价</div>
            <div field="sellAmt" headerAlign="center" allowSort="true" visible="true" width="" summaryType="sum" >金额</div>
            <div field="remark" id="remark" name="remark" headerAlign="center" allowSort="true" visible="true" width="">备注</div>
            <div field="pickDate" headerAlign="center" allowSort="true" visible="true" width="" format="yyyy-MM-dd" dateFormat="yyyy-MM-dd HH:mm">出库日期</div>  
            <div field="pickMan" name="pickMan" headerAlign="center" allowSort="true" visible="true" width=""  align="right">领料人</div>
            <div field="recorder" name="recorder" headerAlign="center" allowSort="true" visible="true" width=""  align="right">创建人</div>
            <div field="returnReasonId" id="returnReasonId" headerAlign="center" allowSort="true" visible="false" width="">归库原因ID
               <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
           </div>
           <div field="returnRemark" id="returnRemark" headerAlign="center" allowSort="true" visible="false" width="">归库原因
               <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
           </div>
           <div field="returnMan" id="returnMan" name="returnMan" headerAlign="center" allowSort="true" visible="false" width=""  align="right">归库人
               <input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
           </div> 
           
       </div>
   </div>
</div>
</div>
</div>

</div>
<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
        
        	<td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件名称</td>
            <td colspan="1" align="center">出库数量</td>
            <td colspan="1" align="center">单价</td>
             <td colspan="1" align="center">金额</td>
             
            <td colspan="1" align="center">备注</td>
            <td colspan="1" align="center">出库日期</td>
            <td colspan="1" align="center">领料人</td>          
                        
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div> 

</body>
</html>