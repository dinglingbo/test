<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:51:32
  - Description:
-->
<head>
<title>panel Tmpl</title>
    
    <%@include file="/common/common.jsp"%>
   
        
</head>
<body>
<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="false"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="300" showCollapseButton="false">
            <!-- query panel -->
            <div title="入库单列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     selectOnLoad="true"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick="onLeftGridRowDblClick"
                     dataField="ptsEnterMainList"
                     sortMode="client"
                     idField="id"
                     url="">
                    <div property="columns">
                        <div allowSort="true" field="enterCode" headerAlign="center" header="入库单号"></div>
                        <div allowSort="true" field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div>
                        <div allowSort="true" field="billStatus" width="30" headerAlign="center" header="状态"></div>
                    </div>
                </div>
                <!--footer-->
                <div property="footer">
                    <input class='nui-textbox' value='' id="leftGridCount" readonly="true" style='vertical-align:middle;'/>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <!-- edit panel -->
            <div title="入库信息" class="nui-panel"
                 style="width:100%;height: 150px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="id"/>
                    <input class="nui-hidden" name="taxSign" id="taxSign"/>
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>入库单号：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" width="100%" name="enterCode" enabled="false" emptyText="新增入库单"/>
                            </td>
                            <td class="title required">
                                <label>入库日期：</label>
                            </td>
                            <td width="100">
                                <input name="enterDate"
                                       width="100%"
                                       showTime="false"
                                       allowInput="false"
                                       class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
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
                                <label>结算方式：</label>
                            </td>
                            <td>
                                <input name="settType"
                                       id="settType"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="customid"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>供应商：</label>
                            </td>
                            <td colspan="5">
                                <input id="guestId"
                                       name="guestId"
                                       class="nui-buttonedit"
                                       emptyText="请选择供应商..."
                                       onbuttonclick="selectSupplier('guestId','billTypeId','settType')"
                                       width="100%"
                                       allowInput="false"
                                       placeholder="请选择供应商"
                                       selectOnFocus="true" />
                            </td>
                            <td class="title required">
                                <label>票据类型：</label>
                            </td>
                            <td>
                                <input name="billTypeId"
                                       id="billTypeId"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="customid"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>采购员：</label>
                            </td>
                            <td colspan="1">
                                <input name="buyer"
                                        id="buyer"
                                        class="nui-combobox width1"
                                        textField="name"
                                        valueField="name"
                                        emptyText="请选择..."
                                        url=""
                                        allowInput="false"
                                        showNullItem="false"
                                        width="100%"
                                        nullItemText="请选择..."/>
                            </td>
                            <td class="title required">
                                <label>票据号：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" width="100%" name="billCode"/>
                            </td>
                            <td class="title">
                                <label>验货员：</label>
                            </td>
                            <td colspan="1">
                                <input name="storeKeeper"
                                       id="checker"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="name"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>备注：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" width="100%" name="remark"/>
                            </td>
                            <td class="title">
                                <label>税率：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="billTaxRate"
                                       id="billTaxRate"
                                       enabled="true" style="text-align: right;"/>
                            </td>
                            <td class="title">
                                <label>总金额：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="totalAmt" enabled="false" style="text-align: right;"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-toolbar" style="padding:2px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPart()" id="addPartBtn">添加</a>
                            <a class="nui-button" plain="true" iconCls="icon-edit" onclick="editPart()" id="editPartBtn">修改</a>
                            <a class="nui-button" plain="true" iconCls="icon-remove" onclick="deletePart()" id="deletePartBtn">删除</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     dataField="enterDetailList"
                     idField="detailId"
                     sortMode="client"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                                <div allowSort="true" field="partName" headerAlign="center" header="配件名称"></div>
                                <div allowSort="true" field="partBranId" width="60" headerAlign="center" header="品牌"></div>
                                <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                                <div allowSort="true" datatype="int" field="enterQty" width="40" headerAlign="center" header="数量"></div>
                            </div>
                        </div>
                        <div header="不含税信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="noTaxUnitPrice" width="40" headerAlign="center" header="单价"></div>
                                <div allowSort="true" datatype="float" field="noTaxAmt" width="40" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                        <div header="含税信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="taxRate" width="40" headerAlign="center" header="税率"></div>
                                <div allowSort="true" datatype="float" field="taxUnitPrice" width="40" headerAlign="center" header="单价"></div>
                                <div allowSort="true" datatype="float" field="taxAmt" width="40" headerAlign="center" header="金额"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="suggestPrice" width="60" headerAlign="center" header="建议销价"></div>
                                <div allowSort="true" field="remark" width="60" headerAlign="center" header="入库分配"></div>
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