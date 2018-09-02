<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowCellSelect="true"
     allowCellEdit="true"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="工时信息">
            <div property="columns">
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="100">工时名称</div>
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="60">业务类型</div>
                <div field="itemTime" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right">工时</div>
                <div field="amt" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right">工时单价</div>
                <div field="amt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">工时金额</div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right" numberFormat="p">优惠率</div>
                <div field="discountAmt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">优惠金额</div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">小计金额</div>
                <div field="worker" headerAlign="center" allowSort="false" visible="true" width="80">施工员</div>
                <div field="worker" headerAlign="center" allowSort="false" visible="true" width="60">销售员</div>
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
    


