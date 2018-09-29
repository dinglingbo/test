<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowSortColumn="true"
     ondrawsummarycell="onDrawSummaryCellItem"
     >
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="项目信息">
            <div property="columns">
                <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onValueChangedItemTypeId" emptyText=""  vtype="required"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true"/>
                </div>
                <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                    <input property="editor" vtype="float" class="nui-textbox"  onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true"/>
                </div>
                <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >
                    优惠率<a href="javascript:setItemPartRate()" title="批量设置优化率" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true"/>
                </div>
                <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true"/>
                </div>
                <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">工时总金额
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="80" header="施工员" name="workers" align="center">
                    <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="true" oncloseclick="onCloseClick" onvaluechanged="onitemworkerChanged" >     
                    <!-- <div property="columns">
                        <div header="ID" field="id"></div>
                        <div header="名称" field="empName"></div>
                    </div> -->
                </div>
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="施工员" align="center">
                </div>                
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onitemsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div> 
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择工时</a>
    </span>
    <span>&nbsp;</span>
    <span id="carHealthEl" >
        <a href="javascript:showBasicData('item')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择标准工时</a>
    </span>
</div>

<div id="advancedMorePartWin" class="nui-window"
     title="" style="height:70px;width:100px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <table style="text-align:left;width: 100%; height: 100%;padding-left:6px;">
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="choosePart()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择配件</a>
            </td>
        </tr>
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="showBasicDataPart()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择标准配件</a>
            </td>
        </tr>
    </table>
</div>    


<div id="advancedItemPartRateSetWin" class="nui-window"
     title="批量设置优惠率" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置优惠率</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    工时优惠率：
                </td>
                <td >
                    <input property="editor" id="itemRateEl"  width="80%" vtype="float"  class="nui-textbox" value="0" selectOnFocus="true"/>%
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    配件优惠率：
                </td>
                <td >
                    <input property="editor" id="partRateEl"  width="80%" vtype="float"  class="nui-textbox" value="0" selectOnFocus="true"/>%
                </td>
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="closeItemPartRateSetWin()">取消</a>
                    <a class="nui-button"  plain="false" onclick="sureItemPartRateSetWin()">确定</a>
                </td>
            </tr>
        </table>
    </div>
</div>   
