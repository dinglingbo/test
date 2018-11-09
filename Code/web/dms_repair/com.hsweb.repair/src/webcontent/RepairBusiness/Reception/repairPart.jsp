<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
<div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true"
     ondrawsummarycell="onDrawSummaryCellPart"
     >
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="配件信息">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">
                    <!-- <input property="editor" class="nui-textbox" emptyText="配件编码、名称、拼音" /> -->
                </div>
                 <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center">
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量" name="partQty">
                    <input property="editor" vtype="float" class="nui-textbox"  onvaluechanged ="onValueChangedPartQty" selectOnFocus="true"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价" name="partUnitPrice">
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged ="onValueChangedpartUnitPrice"  selectOnFocus="true"/>
                </div>
                <div  field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center"  header="优惠率" name="partRate">
                    <input property="editor" vtype="float" class="nui-textbox" id="MML" onvaluechanged ="onValueChangedpartRate" selectOnFocus="true"/>
                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额" name="partSubtotal">
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged ="onValueChangedpartSubtotal" selectOnFocus="true"/>
                </div>
                <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">金额</div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件编码">
                </div>           
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onpartsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
                <div field="partOptBtn" name="partOptBtn" width="100" headerAlign="center" header="操作" align="center" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:choosePart()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择配件</a>
    </span>
    <span>&nbsp;</span>
    <span id="carHealthEl" >
        <a href="javascript:showBasicData('part')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择标准配件</a>
    </span>
</div>
<div id="advancedMorePartWin" class="nui-window"
     title="" style="width:450px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="1"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="OEM码"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="配件全称"></div>
              </div>
          </div>
    </div>
</div> 


