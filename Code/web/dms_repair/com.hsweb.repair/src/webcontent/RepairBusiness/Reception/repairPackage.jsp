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
                 <div field="type" headerAlign="center" allowSort="false"
                     visible="true" width="60" header="项目类型" align="center">
                </div>
                <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId"
                     allowSort="false" visible="true" width="50" header="业务类型" align="center">
                     <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onPkgTypeIdValuechanged" emptyText=""  vtype="required" width="60%"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="40" datatype="float" align="center" name="itemItemTime">工时/数量
                </div>
                <div field="amt" headerAlign="center" name="pkgAmt"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>

                <div field="rate" headerAlign="center" name="pkgRate"
                     allowSort="false" visible="true" width="60" header="" align="center">
                           优惠率%<a href="javascript:setPkgRate()" title="批量设置优化率" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                     <input property="editor"  width="60%" vtype="float"  class="nui-textbox"  onvaluechanged="onPkgRateValuechanged" selectOnFocus="true"/>
                </div>
                 <div field="subtotal" headerAlign="center" name="pkgSubtotal"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center" >
                     <input  property="editor" vtype="float" class="nui-textbox" selectOnFocus="true" onvaluechanged="onPkgSubtotalValuechanged" width="60%"/>
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="" align="center" name="workers">
                                            施工员 <a href="javascript:setPkgWorkers()" title="批量设置施工员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                   
                     <input class="nui-textbox" property="editor" id="workersName" name="workersName"  onclick="openPkgWorkers" width="60%"/> 
                
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="100" header="施工员" align="center">
                </div> 
                <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="false" oncloseclick="onCloseClick" onvaluechanged="onworkerChanged"  visible="false">     
                    <!-- <div property="columns">
                        <div header="ID" field="id"></div>
                        <div header="名称" field="empName"></div>
                    </div> -->
                </div>               
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="" align="center" name="saleMan">
                                     销售员<a href="javascript:setPkgSaleMans()" title="批量设置销售员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
                     <input class="nui-textbox" property="editor" id="saleMansName" name="saleMansName"  onclick="openPkgSaleMans" width="60%"/>
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
        <a href="javascript:choosePackage()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择维修套餐</a>
    </span>
    <!--<span>&nbsp;</span>
    <span id="carHealthEl" >
        <a href="javascript:showBasicData('pkg')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择标准套餐</a>
    </span>-->
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
<div id="advancedPkgRateSetWin" class="nui-window"
     title="批量设置套餐优惠率" style="width:300px;height:120px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置套餐优惠率(标准套餐类型不能批量设置)</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    套餐优惠率：
                </td>
                <td >
                    <input property="editor" id="pkgRateEl"  width="80%" vtype="float"  class="nui-textbox" value="0" selectOnFocus="true" onvaluechanged="onPkgRateValuechangedBath"/>%
                </td>
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="surePkgRateSetWin()" id="pkgOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closePkgRateSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>   	

<!-- 往下删除 -->
 <div id="advancedPkgWorkersSetWin" class="nui-window"
     title="批量设置套餐施工员" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置套餐施工员</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    套餐施工员：
                </td>
                <td >
                 <div id="combobox3" property="editor" class="mini-combobox" style="width:200px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="flase"  onvaluechanged="onworkerChangedBat" > 
                 </div>  
                 </td>  
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="surePkgWorkersSetWin()" id="pkgOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closePkgWorkersSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>  
 <div id="advancedPkgSaleMansSetWin" class="nui-window"
     title="批量设置套餐销售员" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
        <table style="width: 100%;height: 100%;">
            <tr >
                <td colspan="2"  style="text-align: left;">
                    <label style="color: #9e9e9e;">批量设置套餐销售员</label>
                </td>
            </tr>
            <tr >
                <td style="text-align: right;">
                    套餐销售员：
                </td>
                <td >
                   <input  property="editor" enabled="true" dataField="memList" id="pkgSale"
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="saleManChangedBat" emptyText=""  vtype="required" oncloseclick="onCloseClick"/> 
                 </td>  
            </tr>
            <tr >
                <td colspan="2" style="text-align: center;">
                    <a class="nui-button"  plain="false" onclick="surePkgSaleMansSetWin()" id="pkgOk">确定</a>
                    <a class="nui-button"  plain="false" onclick="closePkgSaleMansSetWin()">取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>  


