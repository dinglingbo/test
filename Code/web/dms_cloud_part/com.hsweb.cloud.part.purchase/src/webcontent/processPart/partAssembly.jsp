<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <style type="text/css">
.title {
  width: 30px;
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
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
</style> 
<head>
<title>配件组装</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/purchase/js/processPart/partAssembly.js?v=1.0.2"></script>
</head>
<body>
	
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

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

                <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">所有</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                  <li iconCls="" onclick="quickSearch(13)" id="type10">所有</li>
                  <span class="separator"></span>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审核</li>
                  
                </ul>
                <a class="nui-button" plain="true" onclick="advancedSearch()">
								<span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> 
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save('0')" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" visible="true"  id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
               
                <span id="status"></span>
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
        <div size="220" showCollapseButton="true">
          <div title="配件组装列表" class="nui-panel"
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
                     dataField="processMain"
                     totalField="page.count"
                     url="">
                    <div property="columns">
                      	<div type="indexcolumn">序号</div>
                      	<div field="id" visible="false" headerAlign="center" header="配比清单主表ID"></div>
                        <div field="auditSign" width="65" visible="true" headerAlign="center" header="状态"></div>
                        <div field="createDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                        <div field="creator" width="60" headerAlign="center" header="操作员"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="配件组装单号"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核员"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <div showCollapseButton="false">
            
		
			    <div class="nui-splitter"
			         id="splitter" vertical="true"
			         allowResize="true"
			         handlerSize="6"
			         style="width:100%;height:100%;">
			         
			        <div size="" showCollapseButton="true">
			        	<div class="nui-fit">
			        	<fieldset id="fd1" style="width:99.5%;height:100px;">
		                      <legend><span>配件组装信息</span></legend>
		                      <div class="fieldset-body">
		                          <div id="basicInfoForm" class="form" contenteditable="false">
		                              <input class="nui-hidden" name="id"/>
		                              <input class="nui-hidden" name="operateDate"/>
		                              <input class="nui-hidden" name="versionNo"/>
		                              <input class="nui-hidden" name="status" id="status"/>
		                              <input class="nui-hidden" name="isDisabled" id="isDisabled"/>
		                              <input class="nui-hidden" name="orgid" id="orgid"/>
		                              <input class="nui-hidden" name="auditSign"/>
		                              <input name="partBrandId"id="partBrandId"  visible="false"class="nui-combobox" />
		                              <table style="width: 100%;">
		                                  <tr>
		                                      
		                                      <td class="title required">
		                                          <label>仓库：</label>
		                                      </td>
		                                      <td colspan="1" style="width:120px">
		                                           <input name="storeId"
		                                                 id="storeId"
		                                                 class="nui-combobox"
		                                                 textField="name"
		                                                 valueField="id"
		                                                 emptyText="请选择..."
		                                                 url=""
		                                                 allowInput="true"
		                                                 showNullItem="false"
		                                                 width="100%"
		                                                 valueFromSelect="true"
		                                                 onvaluechanged=""
		                                                 nullItemText="请选择..."
		                                                />
		                                      </td>
		                                      <td class="title required" style="">
		                                          <label>创建日期：</label>
		                                      </td>
		                                      <td width="150" style="width:120px">
		                                        <input name="createDate"
		                                               id="createDate"
		                                               width="100%"
		                                               showTime="true"
		                                               class="nui-datepicker"  format="yyyy-MM-dd HH:mm"
		                                               enabled="false"
		                                            />
		                                      </td> 
		                                      
		                                       <td class="title">
		                                          <label>操作员：</label>
		                                      </td>
		                                      <td colspan="1" style="width:120px">
		                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="orderMan" name="orderMan" enabled="true"/>
		                                      </td>  
		                                                              
		                                  </tr>
		                                  <tr>  
		                                      <td class="title">
		                                          <label>备注：</label>
		                                      </td>
		                                      <td colspan="3">
		                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark" enabled="true"/>
		                                      </td>
		                                    
		                                      <td class="title">
		                                          <label>组装单号：</label>
		                                      </td>
		                                      <td style="width:180px">
		                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder=""/>
		                                      </td>
		
		                                  </tr>
		                              </table>
		                          </div>
		                         
		                      </div>
		                  </fieldset>
		                  
		                   <div class="nui-toolbar" style="padding:2px;border-left:0;">
		                      <table style="width:100%;">
		                          <tr>
		                              <td style="white-space:nowrap;" style="width:120px;">
		                                  <a class="nui-button" plain="true" iconCls="" onclick="addPart()" id="addPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择成品</a>
		<!--                                   <a class="nui-button" plain="true" iconCls="" onclick="deletePart()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
		                              </td>
		                          </tr>
		                      </table>
		                  </div>
		                  
		                   <div class="nui-fit">
		                   		
	                   		   <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                           showPager="false"
		                           dataField="data"
		                           idField="id"
		                           frozenStartColumn=""
		                           frozenEndColumn=""
		                           showSummaryRow="true"
		                           ondrawcell="onRightGridDraw"
		                           allowCellSelect="true"
		                           allowCellEdit="true"
		                       
		                           oncellcommitedit="onCellCommitEdit"
			                       oncelleditenter="onCellEditEnter"
			                       ondrawsummarycell=""
			                       showModified="false"
			                       oncellbeginedit="OnrpMainGridCellBeginEdit"
		   						   sortMode="client"
		                           editNextOnEnterKey="true"
		                           allowCellWrap = "true"
		                           url="">
		                          <div property="columns">
		                              <div type="indexcolumn">序号</div>
		                              <div header="配件信息" headerAlign="center">
		                                  <div property="columns">
		                                  	  
		                                   	  <div field="parentId" visible="false" headerAlign="center" header="配比清单主表ID"></div>
		                                      <div field="partCode" name="partCode" width="100" summaryType="count" headerAlign="center" header="配件编码">
		                                          <input  class="nui-textbox" />
		                                      </div>
		                                      <div field="partName" visible="false" headerAlign="center" header="配件名称"></div>
		                                      <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
		                                      <div field="partBrandId" visible="false"width="60" headerAlign="center" header="品牌"></div>
		                                  </div>
		                              </div>
		                              
		                              <div header="数量信息" headerAlign="center">
		                                  <div property="columns">
		                                      <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量">
		                                        <input property="editor" vtype="float" class="nui-textbox"/>
		                                      </div>
		                                       
		                                      <div field="remark" width="120" headerAlign="center" allowSort="true" header="备注">
		                                        <input property="editor" class="nui-textbox"/>
		                                      </div>
		                                  </div>
		                              </div>
		                              <div header="辅助信息" headerAlign="center">
		                                  <div property="columns">
		                                      <div field="applyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
		                                      <div field="unit" name="unit" width="60" headerAlign="center" header="单位"></div>
		                                      <div field="oemCode" width="50" headerAlign="center" allowSort="true" header="OE码"></div>   
		                                      <div field="spec" width="50" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div> 
		                                                                             
		                                  </div>
		                              </div>
		                          </div>
		                        </div> 
		                   		
		                   </div>
		                  
		                  </div>
		                  
			        </div>
			        
			         <div size="" showCollapseButton="true">
			         	
						<div id="detailGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                           showPager="false"
		                           dataField=""
		                           idField="id"
		                           frozenStartColumn=""
		                           frozenEndColumn=""
		                           showSummaryRow="true"
		                           ondrawcell="onRightGridDraw"
		   						   sortMode="client"
		                           editNextOnEnterKey="true"
		                           allowCellWrap = "true"
		                           url="">
		                	<div property="columns">
		                		<div type="indexcolumn">序号</div>
		                		<div field="partCode" visible="" headerAlign="center" header="配件编码"></div>
		                		<div field="partName" visible="false" headerAlign="center" header="配件名称"></div>
                                <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                                <div field="applyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
                                <div field="unit" name="comUnit" width="60" headerAlign="center" header="单位"></div>
                                <div field="qty" name="qty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="单成品需要数量" visible="false"></div>
		                		<div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="需要数量"></div>
		                		<div field="storeStockQty" name="stockQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="库存"></div>
		                		<div field="stockOutQty" name="stockOutQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="缺货数量"></div>
		                		<div field="costPrice" name="costPrice" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="库存单价"></div>
		                	</div>
		                 </div>

			        </div>
			        
			    </div>
			
		</div>

        </div>
    </div>
    <div id="advancedSearchWin" class="nui-window" title="高级查询" style="width: 400px; height:250px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
				
					<td class="title" style="width:70px;">
						<label >创建日期从:</label>
					</td>
					<td>
						<input name="sCreateDate" width="100%" class="nui-datepicker" />
					</td>
					<td align="center">
						<label>至:</label>
					</td>
					<td>
						<input name="eCreateDate" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
				
					<td class="title">
						<label>审核日期从:</label>
					</td>
					<td>
						<input name="sAuditDate" width="100%" class="nui-datepicker" />
					</td>
					<td align="center">
						<label>至:</label>
					</td>
					<td>
						<input name="eAuditDate" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>成品编码:</label>
					</td>
					<td colspan="3">
						<input name="cPartCode" width="100%" class="nui-textbox" />
					</td>
				</tr>
				<tr>
					<td class="title" >
						<label>半成品编码:</label>
					</td>
					<td colspan="3">
						<input name="bPartCode" width="100%" class="nui-textbox" />
					</td>
				</tr>
				<tr>
				
					<td class="title">
						<label>单号:</label>
					</td>
					<td colspan="3">
						<input name="serviceId" width="100%" class="nui-textbox" />
					</td>
				</tr>
				
				
		  </table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width: 60px; margin-right: 20px;">确定</a>
				
				<a class="nui-button" onclick="cancelData" style="width: 60px;margin-right: 20px;">清除</a>
				
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width: 60px;">取消</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>