<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     allowCellSelect="true"
     allowCellEdit="true"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
        <div header="配件信息">
            <div property="columns">
                <div field="partOptBtn" name="partOptBtn" width="30" headerAlign="center" header="操作" align="center"></div>
                <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100" header="配件名称">
                    <input property="editor" class="nui-textbox" emptyText="配件编码、名称、拼音" />
                </div>
                <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80" header="收费类型">
                    <input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="customid" textField="name" data="receTypeIdList"
                     url="" onvaluechanged="" emptyText=""  vtype="required"/>
                </div>
                <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right" header="数量">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" header="单价">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" header="金额"></div>
                <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p" header="优惠率">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right" header="优惠金额">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="" header="配件编码"></div>
            </div>
        </div>
    </div>
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
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
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


