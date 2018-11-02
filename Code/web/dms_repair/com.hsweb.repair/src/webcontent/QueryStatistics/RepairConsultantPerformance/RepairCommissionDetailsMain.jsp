<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>综合开单查询</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairConsultantPerformance/RepairCommissionDetailsMain.js?v=1.0.0"></script>
<%@include file="/common/commonRepair.jsp"%>
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
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"/>
 
  结算日期:
                    <input id="sOutDate" name="sOutDate" class="nui-datepicker"/>
至:
                    <input id="eOutDate" name="eOutDate" class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           showClearButton="false"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
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
               dataField="data"
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  
                  <div header="业务信息" headerAlign="center">
	                  <div property="columns" >
		                  <div field="carNo" name="carNO" width="80" headerAlign="center" header="车牌"></div>
		                  <div field="carBrandId" name="carBrandId" width="80" headerAlign="center" header="品牌"></div>
		                  <div field="carModel" name="carModel" width="80" headerAlign="center" header="车型"></div>
		                  <div field="carVin" name="carVin" width="80" headerAlign="center" header="VIN码"></div>
		                  <div field="guestFullName" name="guestFullName" width="60" headerAlign="center" header="客户姓名"></div>
		                  <div field="guestMobile" name="guestMobile" width="90" headerAlign="center" header="客户手机"></div>
		                  <div field="mtAdvisor" name="mtAdvisor" width="60" headerAlign="center" header="服务顾问"></div>
		                  <div field="serviceTypeId" name="serviceTypeId" width="60" headerAlign="center" header="业务类型"></div> 
		                  <div field="serviceCode" name="serviceCode" width="110" headerAlign="center" header="工单号"></div>
		                  <div field="sureMtDate" name="sureMtDate" width="60" headerAlign="center" header="维修日期"></div>
		                  <div field="outDate" name="outDate" width="60" headerAlign="center" header="结算日期"></div>
	                  </div>
                  </div>
                  <div header="提成信息" headerAlign="center">
	                  <div property="columns" >	                  
		                  <div field="worker" name="worker" width="60" headerAlign="center" header="姓名"></div>
		                  <div field="salesDeductValue" name="salesDeductValue" width="60" headerAlign="center" header="销售提成"></div>
		                  <div field="techDeductValue" name="techDeductValue" width="60" headerAlign="center" header="施工提成"></div>
		                  <div field="advisorDeductValue" name="advisorDeductValue" width="60" headerAlign="center" header="服务提成"></div>
		                  <div field="totalDeductAmt" name="totalDeductAmt" width="60" headerAlign="center" header="总提成"></div>
	                  </div>
                  </div>
              </div>
          </div>
    </div>
</div>
</body>
</html>