<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
        <div header="工时信息">
            <div property="columns">
                <div field="itemOptBtn" name="itemOptBtn" width="50" headerAlign="center" header="操作" align="center"></div>
                <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">工时名称</div>
                <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
                <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
                <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">小计</div>
                <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
                <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
                <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
            </div>
        </div>
    </div>
</div>
    


