<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonRepair.jsp"%>
<%@include file="/common/common.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:51:28
  - Description:
-->
<head>
    <title>客户服务-点评管理</title>
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/billCommmentQty.js?v=1.0.15"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">
    .title {
      width: 60px;
      text-align: right;
  }

  .form_label {
    width: 72px;
    text-align: right;
}

.required {
    color: red;
}
</style>
</head>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style=" width:51%;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                   <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                   <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                   <li class="separator"></li>
                   <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                   <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
               </ul>
               			点评日期 从:<input class="nui-datepicker" id="sRecordDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
			至:<input class="nui-datepicker" id="eRecordDate" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

             	<input class="nui-textbox" width="100px" id="carNo" name="carNo" selectOnFocus="true" enabled="true" emptyText="车牌号"/>
                <input class="nui-textbox" width="100px" id="mobile" emptyText="手机"  selectOnFocus="true" name="mobile"/>
               	<input id="point"
	                name="point"
	                class="nui-combobox"
	                width="100px"
	                textField="name"
	                valueField="type"
	                valueFromSelect="true"
	                emptyText="分类"
	                url=""
	                dataField="pointList"
	            	data="pointList"
	                allowInput="true"
	                showNullItem="true"
	                nullItemText="请选择..."/>
	                
                  <input id="serviceTypeId"
                    name="serviceTypeId"
                    class="nui-combobox"
                    width="100px"
                    textField="id"
                    valueField="name"
                    valueFromSelect="true"
                    emptyText="业务类型"
                    url="" 
                    style="display:none;"
                    allowInput="true"
                    showNullItem="false"
                    nullItemText="业务类型"/>
                   <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

</td>
    </tr>
</table>
</div>

<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="list"
    idField="partId"
    sortMode="client"
    pageSize="100"
    showSummaryRow="true"
    totalField="page.count" 
    sizeList=[50,100,500,1000] 
     onrowdblclick="" 
     allowCellWrap = true>
    <div property="columns">
        <div type="indexcolumn" width="40" headerAlign="center">序号</div>
        <div header="基本信息" headerAlign="center">
            <div property="columns">
            	<div allowSort="true" field="serviceCode" width="130" headerAlign="center" header="业务单号"></div>
            	<div allowSort="true" field="carNo" width="100" headerAlign="center" header="车牌号"></div>
   				<div allowSort="true" field="carModel"  name="carModel"width="250" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" field="chainComeTimes" width="80" headerAlign="center" header="来厂次数"></div>
                <div allowSort="true" field="recorder"  name="recorder"width="60" headerAlign="center"  header="点评人"></div>
                <div allowSort="true" field="recordDate" width="130" headerAlign="center"dateFormat="yyyy-MM-dd HH:mm"  header="点评时间"></div>
                <div allowSort="true" field="modifyDate" width="130" headerAlign="center"dateFormat="yyyy-MM-dd HH:mm" header="更新时间"></div>
                <div allowSort="true" field="serviceTypeId"  name="serviceTypeId"width="60" headerAlign="center" header="维修类型"></div>
            </div>
        </div> 
        
         <div header="点评信息" headerAlign="center">
            <div property="columns">
                <div  allowSort="true" field="polite" width="60" headerAlign="center" header="服务态度"  align="left"></div>
                <div allowSort="true"  field="repairQuality"  width="90" headerAlign="center" header="维修/保养品质"  align="left"></div>
                <div allowSort="true"  field="interpretation"  width="60" headerAlign="center" header="价格合理"  align="left"></div>
                <div allowSort="true"  field="outFactorySpeed"  width="60" headerAlign="center" header="交车速度"  align="left"></div>
                <div allowSort="true"  field="environmental"  width="80" headerAlign="center" header="环境舒适" align="left"></div>
                <div allowSort="true"  field="sumPoint"  width="60" headerAlign="center" header="总分"  align="left"></div>
                <div allowSort="true"  field="avgPoint"  width="60" headerAlign="center" header="平均分"  align="left"></div>
                <div allowSort="true"  field="isNextCome" name="isNextCome" width="100" headerAlign="center" header="是否推荐给朋友"  align="left"></div>
                <div allowSort="true"  field="suggestion"  width="60" headerAlign="center" header="客户建议"  align="left"></div>
                <div allowSort="true"  field="mtAdvisor" name="mtAdvisor" width="60" headerAlign="center" header="服务顾问"  align="left"></div>
            </div>
        </div>
   
        
    </div>
</div>
</div>


</html>
