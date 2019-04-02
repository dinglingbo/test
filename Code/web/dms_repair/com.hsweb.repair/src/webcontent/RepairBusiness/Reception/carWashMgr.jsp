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
<title>洗车开单</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/carWashBillMgr.js?v=1.3.3"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">

.title {
  width: 80px;
  text-align: right;
}

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

 #wechatTag1{
            color:#ccc;
        }
 #wechatTag{
            color:#62b900;
        }
</style>

</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                     <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">所有在厂</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)" id="type0">所有在厂</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type0">开单</li>
                        <li iconCls="" onclick="quickSearch(2)" id="type1">施工</li>
                        <li iconCls="" onclick="quickSearch(3)" id="type2">完工</li>
                        <li iconCls="" onclick="quickSearch(4)" id="type0">待结算</li>
                    </ul>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onenterSearch(this.value)"/>
                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true" onenter="onenterMtAdvisor(this.value)"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <a class="nui-button" plain="true" onclick="advancedSearch()" ><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a> -->
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="unfinish()" id="addBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返工</a>--> 
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a> -->
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
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
                  <div field="status" name="status" width="70px" headerAlign="center" header="进程"></div>
                  <div field="serviceCode" name="serviceCode" width="150px" headerAlign="center" header="工单号"></div>
                  <div field="carNo" name="carNo" width="80px" headerAlign="center" header="车牌号"></div>
                  <div field="enterDate" name="enterDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="进厂时间"></div>
                  <div field="serviceTypeName" name="serviceTypeName" width="140px" headerAlign="center" header="业务类型"></div>
                  <div field="carModel" name="carModel" width="100px" headerAlign="center"  header="品牌车型"></div>
                  <div field="carVin" name="carVin" width="130px" headerAlign="center" header="车架号(VIN)"></div>
                  <div field="mtAdvisor" name="mtAdvisor" width="90px" headerAlign="center" header="服务顾问"></div>
                  <div field="balaAuditSign" name="balaAuditSign" width="90px" headerAlign="center" header="结算状态"></div>
                  <div field="contactName" name="contactName" width="80px" headerAlign="center" header="联系人姓名"></div>
                  <div field="contactMobile" name="contactMobile" width="100px" headerAlign="center" header="联系人手机"></div>

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
      </div>
   </div> 
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            
            <input name="carBrandId"
                id="carBrandId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
           <input name="serviceTypeId"
                id="serviceTypeId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
            <tr>
                <td class="title">开单日期:</td>
                <td>
                    <input id="sRecordDate"
                           name="sRecordDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eRecordDate"
                           name="eRecordDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <!-- <tr >
                <td class="title">预计完工日期:</td>
                <td>
                    <input id="sPlanFinishDate"
                           name="sPlanFinishDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="ePlanFinishDate"
                           name="ePlanFinishDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr> -->
            <tr>
                <td class="title">业务类型:</td>
                <td colspan="3">
                    <div id="serviceTypeIds" name="serviceTypeIds" class="nui-checkboxlist" repeatItems="5" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" ></div>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
        </div>
    </div>
</div>

</body>
</html>