<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>闪电开单模板</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/quickBill.js?v=1.0.1"></script>
<style type="text/css">

.title {
  width: 80px;
  text-align: right;
}shu

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}

</style>

</head>
<body>

<div class="nui-fit">
    <input id="carBrandList" class="nui-combobox" visible="false" />
    <input id="carSeriesList" class="nui-combobox" visible="false" />
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">全部</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(2)" id="type2">洗美</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type1">综合</li>
                        <li iconCls="" onclick="quickSearch(3)" id="type3">理赔</li>
                        <li iconCls="" onclick="quickSearch(4)" id="type3">全部</li>
                    </ul>
                    <span class="separator"></span>
                     <label class="form_label">模板名称：</label>
                     <input class="nui-textbox" id="modelName" name="modelName" onenter="onenterModelName(this.value)"/>
                     <label class="form_label">业务类型：</label>
	                     <input name="serviceTypeId"
	                    id="serviceTypeId"
	                    class="nui-combobox width1"
	                    textField="name"
	                    valueField="id"
	                    emptyText="请选择..."
	                    url=""
	                    allowInput="true"
	                    showNullItem="false"
	                    valueFromSelect="true"
	                    nullItemText="请选择..." onenter="onenterServiceTypeId(this.value)"/>
                     <label class="form_label">创建日期&nbsp;从：</label>
                     <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
                     <label class="form_label">至：</label>
                     <input format="yyyy-MM-dd" style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                  
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               allowCellWrap = "true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                  <div field="id" name="id" width="120px" headerAlign="center" header="模板id" visible="false"></div>
                  <div field="modelName" name="modelName" width="120px" headerAlign="center" header="模板名称"></div>
                  <div field="billTypeId" name="billTypeId" width="80" headerAlign="center"  header="开单类型"></div>
                  <div field="serviceTypeId" name="serviceTypeId" width="80px" headerAlign="center" header="业务类型"></div>
                  <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="40">品牌 </div>
                  <div field="carSeriesId" headerAlign="center" allowSort="true" visible="true" width="120">车系 </div>
                  <div field="recordDate" name="recordDate" width="80px" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                  <div field="remark" name="remark" width="200px" headerAlign="center" header="备注"></div>
              </div>
          </div>
    </div>
</div>
<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

  <div  id="innerpackGrid" class="nui-datagrid"
	    style="width:100%;height:100px;"
	    dataField="data"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false" >
      <div property="columns">
    	   <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100" header="套餐名称"></div>
           <div field="type" headerAlign="center" allowSort="false" visible="true" width="60" header="项目类型" align="center"></div>    
           <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId" allowSort="false" visible="true" width="50" header="业务类型" align="center"> </div>
           <div field="subtotal" headerAlign="center" name="pkgSubtotal" allowSort="false" visible="true" width="60" header="套餐金额" align="center" ></div>
           <div field="rate" headerAlign="center" name="pkgRate" allowSort="false" visible="true" width="60" header="优惠率" align="center"></div>
           <div field="amt" headerAlign="center" name="pkgAmt"  allowSort="false" visible="true" width="60" header="原价" align="center"></div>
           <div field="workers" headerAlign="center"  allowSort="false" visible="true" width="60" header="施工员" align="center" name="workers"></div>
           <div field="workerIds" headerAlign="center" allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
           <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
           <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
     </div>
   </div>
   <div id="innerItemGrid"
       borderStyle="border-bottom:0;"
       class="nui-datagrid"
       dataField="data"
       style="width: 100%;height:100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
           <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
	       <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型 </div>
	       <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量 </div>
	       <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价 </div>
	       <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >优惠率</div>            
	       <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额</div>          
	       <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">总金额 </div>           
           <div field="workers" headerAlign="center" allowSort="false" visible="true" width="80" header="施工员" name="workers"  align="center"></div>
	       <div field="workerIds" headerAlign="center"  allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
	       <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
	       <div field="saleManId" headerAlign="center"   allowSort="false" visible="false" width="80" header="销售员" align="center"></div> 
	       <div field="remark" headerAlign="center"   allowSort="false" visible="true" width="80" header="备注" align="center"></div>
      </div>
   </div>
</div>
</body>
</html>