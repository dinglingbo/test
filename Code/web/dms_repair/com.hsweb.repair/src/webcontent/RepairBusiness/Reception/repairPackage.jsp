<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
<div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     showModified="false"
     allowSortColumn="false"
     ondrawsummarycell="onDrawSummaryCellPack"
     >
    <div property="columns">
    	<div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div field="prdtName" headerAlign="center" allowSort="false"
                     visible="true" width="100" header="套餐名称">
                </div>
                <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId"
                     allowSort="false" visible="true" width="50" header="业务类型" align="center">
                     <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onPkgTypeIdValuechanged" emptyText=""  vtype="required" /> 
                </div>
                <div field="subtotal" headerAlign="center" name="pkgSubtotal"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center" numberFormat="0.0000">
                     <input property="editor" vtype="float" class="nui-textbox" selectOnFocus="true" onvaluechanged="onPkgSubtotalValuechanged"/>
                </div>
                <div field="rate" headerAlign="center" name="pkgRate"
                     allowSort="false" visible="true" width="60" header="优惠率" align="center">
                     <input property="editor" vtype="float" class="nui-textbox" numberFormat="0.0000" onvaluechanged="onPkgRateValuechanged" selectOnFocus="true"/>
                </div>
                <div field="amt" headerAlign="center" name="pkgAmt"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="施工员" align="center" name="workers">
                    <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="true" oncloseclick="onCloseClick" onvaluechanged="onworkerChanged" >     
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
                             url="" onvaluechanged="onsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
                <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:choosePackage()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择套餐</a>
    </span>
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
    	


