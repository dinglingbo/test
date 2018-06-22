<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="packageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div type="expandcolumn" >#</div>
                <div field="packageName" headerAlign="center" allowSort="true"
                     visible="true" width="">套餐名称
                </div>
                <div field="status" headerAlign="center"
                     allowSort="true" visible="true" width="60">状态
                </div>
                <div field="pkgamt" headerAlign="center"
                     allowSort="true" visible="true" width="80">套餐金额
                </div>
                <div field="discountAmt" headerAlign="center"
                     allowSort="true" visible="true" width="80">优惠金额
                </div>
                <div field="subtotal" headerAlign="center"
                     allowSort="true" visible="true" width="80">小计金额
                </div>
                <div field="amt4s" headerAlign="center"
                     allowSort="true" visible="true" width="80">4S店金额
                </div>
                <div field="remark" headerAlign="center"
                     allowSort="true" visible="true" width="">备注
                </div>
            </div>
        </div>
    </div>
</div>
<div id="packageDetailGrid_Form" style="display:none;">
    <div id="packageDetailGrid" class="nui-datagrid"
         style="width: 100%; "
         dataField="list"
         showPager="false"
         selectOnLoad="true"
         allowSortColumn="true">
        <div property="columns">
            <div field="typeName" headerAlign="center" allowSort="true"
                 visible="true" width="60">类型
            </div>
            <div field="name" headerAlign="center"
                 allowSort="true" visible="true" width="">名称
            </div>
            <div field="qty" headerAlign="center"
                 allowSort="true" visible="true" width="80">工时/数量
            </div>
            <div field="remark" headerAlign="center"
                 allowSort="true" visible="true" width="80">备注
            </div>
        </div>
    </div>
</div>
    


