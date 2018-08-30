<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div field="packageOptBtn" name="packageOptBtn" width="30" headerAlign="center" header="操作" align="center"></div>
                <div type="expandcolumn" >#</div>
                <div field="packageName" headerAlign="center" allowSort="false"
                     visible="true" width="">套餐名称
                </div>
                <div field="pkgamt" headerAlign="center"
                     allowSort="false" visible="true" width="80">业务类型
                </div>
                <div field="pkgamt" headerAlign="center"
                     allowSort="false" visible="true" width="80">套餐金额
                </div>
                <div field="amt4s" headerAlign="center"
                     allowSort="false" visible="true" width="80">优惠率
                </div>
                <div field="discountAmt" headerAlign="center"
                     allowSort="false" visible="true" width="80">优惠金额
                </div>
                <div field="subtotal" headerAlign="center"
                     allowSort="false" visible="true" width="80">小计金额
                </div>
                <div field="remark" headerAlign="center"
                     allowSort="false" visible="true" width="">销售员
                </div>
            </div>
        </div>
    </div>
</div>
<div id="packageDetailGridForm" style="display:none;">
    <div id="packageDetailGrid" class="nui-datagrid"
         style="width: 100%; "
         dataField="list"
         showPager="false"
         selectOnLoad="true"
         allowSortColumn="true">
        <div property="columns">
            <div field="typeName" headerAlign="center" allowSort="false"
                 visible="true" width="60">类型
            </div>
            <div field="name" headerAlign="center"
                 allowSort="false" visible="true" width="">名称
            </div>
            <div field="qty" headerAlign="center"
                 allowSort="false" visible="true" width="80">工时/数量
            </div>
            <div field="remark" headerAlign="center"
                 allowSort="false" visible="true" width="80">备注
            </div>
        </div>
    </div>
</div>
    


