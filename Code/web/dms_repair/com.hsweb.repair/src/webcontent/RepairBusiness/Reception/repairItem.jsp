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
     editNextOnEnterKey = "false"
     >
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="项目信息">
            <div property="columns">
                <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="50" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onValueChangedItemTypeId" emptyText=""  vtype="required" width="60%"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="30" datatype="float" align="center" name="itemItemTime">工时/数量
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true" width="60%"/>
                </div>
                <div field="planFinishDate" headerAlign="center" allowSort="false" visible="false" width="40" datatype="float" align="center" name="planFinishDate">
                                                      工时预计完工时间
                </div>
                <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                    <input property="editor" vtype="float" class="nui-textbox"  onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true" width="60%"/>
                </div>
                <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="50" datatype="float" align="center" >
                    优惠率%<a href="javascript:setItemPartRate()" title="批量设置优化率" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true" width="60%"/>
                </div>
                <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true" width="60%"/>
                </div>
                <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">项目总金额
                </div>
               <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="" align="center" name="workers">
                                            施工员 <a href="javascript:setItemWorkers()" title="批量设置施工员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                    <input class="nui-textbox" property="editor" id="workersName" name="workersName"  onclick="openItemWorkers" width="60%"/> 
                </div>
                <div id="combobox2" property="editor" class="mini-combobox" style="width:230px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="false" oncloseclick="onCloseClick" onvaluechanged="onworkerChanged" visible="false">     
                    <!-- <div property="columns">
                        <div header="ID" field="id"></div>
                        <div header="名称" field="empName"></div>
                    </div> -->
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="施工员" align="center">
                </div>                
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="" align="center" name="saleMan">
                      销售员<a href="javascript:setItemSaleMan()" title="批量设置销售员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                     <input class="nui-textbox" property="editor" id="saleMansName" name="saleMansName"  onclick="openItemSaleMans" width="60%"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center" >
                </div> 
                <div field="remark" headerAlign="center" name="remark"
                     allowSort="false" visible="true" width="80" header="备注" align="center"  >
                      <input class="nui-textbox" property="editor" id="remark" name="remark"  onvaluechanged="remarkChang" width="80%"/> 
                </div> 
                <div field="itemOptBtn" name="itemOptBtn" width="80" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择维修项目</a>
        <a href="javascript:chooseBlank()" class="chooseClass" id="chooseBlank" ><span class="fa fa-plus"></span>&nbsp;选择钣喷项目</a>
    </span>
    <!-- <span id="carHealthEl" >
        <a href="javascript:updateItem()" class="chooseClass" >修改</a>
    </span>
    <span id="carHealthEl" >
        <a href="javascript:saveItem()" class="chooseClass" >保存</a>
    </span> -->
    <!--<span>&nbsp;</span>
    <span id="carHealthEl" >
        <a href="javascript:showBasicData('item')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择标准项目</a>
    </span>-->
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
                    项目优惠率：
                </td>
                <td >
                    <input property="editor" id="itemRateEl"  width="80%" vtype="float"  class="nui-textbox" value="0" selectOnFocus="true" onvaluechanged="onItemRateValuechangedBath"/>%
                </td>
            </tr> 
            <tr >
                <td style="text-align: right;">
                    配件优惠率：
                </td>
                <td >
                    <input property="editor" id="partRateEl"  width="80%" vtype="float"  class="nui-textbox" value="0" selectOnFocus="true" onvaluechanged="onPartRateValuechangedBath()"/>%
                </td>
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="sureItemPartRateSetWin()" id="itemOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closeItemPartRateSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>   

<!-- 不要 -->
<div id="advancedItemWorkersSetWin" class="nui-window"
     title="批量设置项目施工员" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置项目施工员</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                   项目施工员：
                </td>
                <td >
                 <div id="combobox4" property="editor" class="mini-combobox" style="width:200px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="false"  onvaluechanged="onworkerChangedBat" > 
                 </div>  
                 </td>  
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="sureItemWorkersSetWin()" id="pkgOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closeItemWorkersSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div> 

<div id="advancedItemPartSaleManSetWin" class="nui-window"
     title="批量设置销售员" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置销售员</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    项目销售员：
                </td>
                <td >
                   <input class="nui-textbox" property="editor" id="itemSaleMan" name="itemSaleMan"  onclick="setSaleManBat('item')" />  
                 </td>
            </tr> 
            <tr >
                <td style="text-align: right;">
                    配件销售员：
                </td>
                <td >
                 <input class="nui-textbox" property="editor" id="partSaleMan" name="partSaleMan"  onclick="setSaleManBat('part')" />  
                    
                 </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="sureItemPartSaleManSetWin()" id="itemOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closeItemPartSaleManSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>  
