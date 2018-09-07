<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowCellSelect="false"
     allowCellEdit="false"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="工时信息">
            <div property="columns">
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="100">工时名称</div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="itemTime" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时</div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时单价</div>
                <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">工时金额</div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" numberFormat="p">优惠率</div>
                <div field="discountAmt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">优惠金额</div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">工时金额</div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="80" header="施工员">
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
                     allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onitemsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div> 
                <div field="worker" headerAlign="center" allowSort="false" visible="true" width="60" align="center">销售员</div>
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择工时</a>
    </span>
</div>
    


