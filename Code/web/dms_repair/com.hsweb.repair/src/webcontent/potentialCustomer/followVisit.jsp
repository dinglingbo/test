<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 17:00:58
  - Description:
-->
<head>
<title>来访跟进</title>
<script src="<%= request.getContextPath() %>/repair/js/potentialCustomer/potentialCustomer.js?v=1.0.4" type="text/javascript"></script>
<style type="text/css">
/* table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
} */
.dtable{
	table-layout: fixed;
	font-size: 12px;
	height: 100%;
	width: 100%;
}

.form_label {
	width:80px;
	text-align: right;
}

.d_label {
	width: 80px;
	text-align: center;
}

/* .mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important;
} */

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-fit"> 
     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                 <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                     <input class="nui-combobox" id="billTypeId" emptyText="是" name="billTypeId" data="[{billTypeId:0,text:'待今日跟进'},{billTypeId:1,text:'超期未跟进'},{billTypeId:2,text:'所有需跟进'},
                         {billTypeId:1,text:'所有重点跟进'},{billTypeId:1,text:'战败客户'}]" width="120"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
                    <label style="font-family:Verdana;">客户名称：</label>
                    <input class="nui-textbox" id="carNo-search" emptyText="" width="120"  onenter="onenterSearch(this.value)"/>
                    <label style="font-family:Verdana;">手机号：</label>
                    <input class="nui-textbox" id="carNo-search" emptyText="" width="120"  onenter="onenterSearch(this.value)"/>
                     <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
	                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;客户资料</a>
                </td>
            </tr>
        </table>
    </div>
	<div class="nui-splitter" style="width: 100%; height: 95%;"
		 showHandleButton="false">
		<div showCollapseButton="false" style="width:100%;">
			<div class="nui-fit">
				<div id="rightGrid"
					 dataField="list"
					 class="nui-datagrid"
					 style="float:left;width:100%; height: 98%;"
					 url=""
					 borderStyle="border:1"
					 pageSize="50"
					 totalField="page.count"
					 sortMode="client"
					 showPageSize="true"  
					 allowSortColumn="true"
					 selectOnLoad="false"
					 allowCellSelect="true"
					 onDrawCell="onDrawCell"
					 showFilterRow="false" >
					<div property="columns" >
						<div type="indexcolumn" width="50">序号</div>
                  <div header="选择" headerAlign="center">
                       <div property="columns" >
                        <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" allowsort="false" header="操作">
                        <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
                        </div>
                       </div>
                  </div>
                  <div header="客户信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="客户名称"></div>
  	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="性别"></div>
  	                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="来访时间"></div>
	                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="离店时间"></div>
  	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="关系阶段"></div>
	                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="下次跟进时间"></div>
	                  <div field="serviceTypeName" name="serviceTypeName" width="60" headerAlign="center" allowsort="true" header="跟进状态"></div>
	                  <div field="serviceTypeName" name="serviceTypeName" width="60" headerAlign="center" allowsort="true" header="客户来源"></div>
	                 </div>
                  </div>
                  <div header="意向信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="车型"></div>
	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="车身颜色"></div>
  	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="内饰颜色"></div>
	                 </div>
                  </div>
                  <div header="其他信息" headerAlign="center">
                  <div property="columns" >
                      <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="false" header="销售顾问"></div>
                      <div field="serviceTypeName" name="serviceTypeName" width="60" headerAlign="center" allowsort="true" header="备注"></div>
                  </div>
                  </div>
                  </div>
				</div>
              </div>  
		</div>
		<div size="600" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;" plain="false">
				 <div title="跟进内容">
				    <fieldset id="fd1" style="width:585px;height:100%">
				    <table>
				        <tr>
				            <td align="right" style="width:80px">关系阶段：</td>
				            <td>
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				            <td align="right" style="width:60px">跟进日期：</td>
				            <td><input class="nui-datepicker" id="birthday" name="birthday" width="100%"/></td>
				            <td align="right" style="width:60px">销售顾问：</td>
				            <td>
				            <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                           </td>
				        </tr>
				        <tr>
				           <td>经理批注：</td> 
				           <!-- <td colspan="1">
				           <label class="form_label" align="right"></label>
					       </td> -->
										
				        </tr>
				        <tr>
				           <!-- <td class="form_label" align="right"></td> --> 
				           <td colspan="6">
				           <input class="nui-TextArea" name="useRemark"
					       style="width: 100%; height: 100px;" />
					       </td>
										
				        </tr>
				         <tr>
				           <td colspan="2" >跟踪内容/客户需求：</td> 
				           <!-- <td colspan="1">
				           <label class="form_label" align="right"></label>
					       </td> -->
										
				        </tr>
				        <tr>
				           <!-- <td class="form_label" align="right"></td>  -->
				           <td colspan="6">
				           <input class="nui-TextArea" name="useRemark"
					       style="width: 100%; height: 200px;" />
					       </td>
										
				        </tr>
				       <!--  <tr>
				           <td class="form_label" align="right" style="width:100px">跟踪内容/客户需求:</td>
				          <td colspan="5"><input class="nui-TextArea" name="useRemark"
					       style="width: 100%; height: 200px;" />
					       </td>
				        </tr> -->
				          <tr>
				            <td  align="right" style="width:80px">跟进方式：</td>
				            <td>
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				           <td align="right" style="width:80px">跟进状态：</td>
				            <td>
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				            <td align="right" style="width:90px">下次跟进时间：</td>
				            <td><input class="nui-datepicker" id="birthday" name="birthday" width="100%"/></td>
				        </tr>
				        <tr>
				            <td  align="right" style="width:80px">跟进方式：</td>
				            <td colspan="5">
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				        </tr>
				        <tr>
				            <td align="right" style="width:60px">跟进结果：</td>
				            <td>
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				           <td align="right" style="width:60px">跟进人：</td>
				            <td>
				               <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
						            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
						          
				            </td>
				           
				        </tr>
				    </table>
				</fieldset>
			    </div>
			    <div title="跟进记录" id="deductTab" name="deductTab" >
			    <div  id="datagrid2" dataField="data" class="nui-datagrid" 
					style="width: 100%; height: 100%;"  sortMode="client"
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					 <div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="carNo" headerAlign="center" allowSort="true">跟进人</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" dateFormat="  yyyy-MM-dd HH:mm" >跟进时间</div>
						<div field="carNo" headerAlign="center" allowSort="true" >跟进方式</div>
						<div field="carNo" headerAlign="center" allowSort="true" >跟进状态</div>
						<div field="carNo" headerAlign="center" allowSort="true" >跟进结果</div>
						<div field="carNo" headerAlign="center" allowSort="true" >关系阶段</div>
						<div field="carNo" headerAlign="center" allowSort="true" >客户需求/跟进内容</div>
					 </div>
				 </div>
			    </div>
			 </div>
			</div>
		</div>
   </div>
</div>
</body>
</html>