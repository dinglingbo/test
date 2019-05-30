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
    <script src="<%= request.getContextPath() %>/sales/customer/js/followVisit.js?v=1.0.0" type="text/javascript"></script>
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
a.optbtn {
        width: 52px;
       /* height: 36px; */ 
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px;
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
                     <input class="nui-combobox" id="qscoutstatus" emptyText="" name="qscoutstatus" data="[{qscoutstatus:0,text:'待今日跟进'},{qscoutstatus:1,text:'超期未跟进'},{qscoutstatus:2,text:'所有需跟进'},
                         {qscoutstatus:3,text:'所有重点跟进'},{qscoutstatus:3,text:'战败客户'}]" width="120"  onvaluechanged="doSearch" textField="text" valueField="qscoutstatus" value="0"/>
                   <!--  <label style="font-family:Verdana;">客户名称：</label> -->
                    <input class="nui-textbox" id="fullName-search" emptyText="客户名称" width="120"  onenter="doSearch"/>
                    <!-- <label style="font-family:Verdana;">手机号：</label> -->
                    <input class="nui-textbox" id="mobile-search" emptyText="手机号" width="120"  onenter="doSearch"/>
                     <a class="nui-button" iconCls="" plain="true" onclick="doSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> -->
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
	                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;客户资料</a> -->
	                <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                <a class="nui-button" onclick="guestInfo" plain="true"  style="width: 100px;"><span class="fa fa-user-plus fa-lg"></span>&nbsp;客户资料</a>
	                <a class="nui-button" iconCls="" plain="true" onclick="giftInfo()" id="addBtn"><span class="fa fa-shopping-bag fa-lg"></span>&nbsp;精品信息</a>
	                <a class="nui-button" onclick="buyCarCount" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
                </td>
            </tr>
        </table>
    </div>
          <input name="interialColorId"
             id="interialColorId"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
            />
             <input name="frameColorId"
             id="frameColorId"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
            />
            <input name="source"
	         id="source"
	         class="nui-combobox"
	         textField="name"
	         valueField="id"
	         allowInput="true"
	         width="100%"
	         visible="false"
	       />
	<div class="nui-splitter" style="width: 100%; height: 95%;"
		 showHandleButton="false">
         <!--  <input name="scoutStatus"
             id="scoutStatus"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
            /> -->
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
					 showFilterRow="false"
					 allowCellWrap="true"
					  >
					<div property="columns" >
						<div type="indexcolumn" width="50">序号</div>
                  <div header="操作" headerAlign="center">
                       <div property="columns" >
                        <div field="addOptBtn" name="addOptBtn" width="70" headerAlign="center" allowsort="false" header="">
                        <!-- <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/> -->
                        </div>
                       </div>
                  </div>
                  <div header="客户信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="id" name="id" width="80" headerAlign="center" allowsort="true" header="来访记录id" visible="false"></div>
	                  <div field="contactorId" name="contactorId" width="80" headerAlign="center" allowsort="true" header="联系人id"  visible="false"></div>
	                  <div field="fullName" name="fullName" width="80" headerAlign="center" allowsort="true" header="客户名称"></div>
  	                  <div field="sex" name="sex" width="80" headerAlign="center" allowsort="true" header="性别"></div>
  	                  <div field="comeDate" name="comeDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="来访时间"></div>
	                  <div field="leaveDate" name="leaveDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="离店时间"></div>
  	                  <div field="relationship" name="relationship" width="80" headerAlign="center" allowsort="true" header="关系阶段"></div>
	                  <div field="nextScoutDate" name="nextScoutDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="下次跟进时间"></div>
	                  <div field="scoutStatus" name="scoutStatus" width="60" headerAlign="center" allowsort="true" header="跟进状态"></div>
	                  <div field="source" name="source" width="60" headerAlign="center" allowsort="true" header="客户来源"></div>
	                 </div>
                  </div>
                  <div header="意向信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="carModelName" name="carModelName" width="80" headerAlign="center" allowsort="true" header="车型"></div>
	                  <div field="frameColorId" name="frameColorId" width="80" headerAlign="center" allowsort="true" header="车身颜色"></div>
  	                  <div field="interialColorId" name="interialColorId" width="80" headerAlign="center" allowsort="true" header="内饰颜色"></div>
	                 </div>
                  </div>
                  <div header="其他信息" headerAlign="center">
                  <div property="columns" >
                      <div field="saleAdvisor" name="saleAdvisor" width="80" headerAlign="center" allowsort="false" header="销售顾问"></div>
                      <div field="remark" name="remark" width="160" headerAlign="center" allowsort="true" header="备注"></div>
                  </div>
                  </div>
                  </div>
				</div>
              </div>  
		</div>
		<div size="650" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;" plain="false">
				 <div title="跟进内容">
				    <fieldset id="form" style="width:635px;height:100%">
				    <input name="id" class="nui-hidden" id="mainId"/>
				    <table>
				        <tr>
				            <td align="right" style="width:80px">关系阶段：</td>
				            <td>
				               <input name="relationship"
						         id="relationship"
						         class="nui-combobox"
						         textField="name"
						         valueField="id"
						         allowInput="true"
						         width="100%"
						       />       
				            </td>
				            <td align="right" style="width:60px">销售顾问：</td>
				            <td>
				            <input name="saleAdvisorId" id="saleAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false"  valueFromSelect="true" width="100%" />
                           </td>
                           <td align="right" style="width:60px">跟进日期：</td>
				            <td>
				                 <input width="100%" id="scoutDate" name="scoutDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" />
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
				           <input class="nui-TextArea" name="scoutRemark"
					       style="width: 100%; height: 100px;" id="scoutRemark"/>
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
				           <input class="nui-TextArea" name="scoutContent"
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
				              <input name="scoutModeId"
						         id="scoutModeId"
						         class="nui-combobox"
						         textField="name"
						         valueField="id"
						         allowInput="true"
						         width="100%"
						       />       
				            </td>
				           <td align="right" style="width:80px">跟进状态：</td>
				            <td>
				              <input name="status"
						         id="status"
						         class="nui-combobox"
						         textField="name"
						         valueField="id"
						         allowInput="true"
						         width="100%"
						       />      
				            </td>
				            <td align="right" style="width:90px">下次跟进时间：</td>
				            <td>
				                <input width="100%" id="nextOrderDate" name="nextOrderDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
				            </td>
				            
				        </tr>
				        <tr>
				            <td  align="right" style="width:80px">战败原因：</td>
				            <td colspan="5">
				                 <input name="failReasonId"
						         id="failReasonId"
						         class="nui-combobox"
						         textField="name"
						         valueField="id"
						         allowInput="true"
						         width="100%"
						       />     
				            </td>
				        </tr>
				        <tr>
				            <td align="right" style="width:60px">跟进结果：</td>
				            <td>
				                <input name="isUsabled"
						         id="isUsabled"
						         class="nui-combobox"
						         textField="name"
						         valueField="id"
						         allowInput="true"
						         width="100%"
						       />  
				            </td>
				           <td align="right" style="width:60px">跟进人：</td>
				            <td>
				               <input class="nui-textbox" id="recorder" name="recorder" width="100%"/>    
				            </td>
				           
				        </tr>
				    </table>
				</fieldset>
			    </div>
			    <div title="跟进记录" id="deductTab" name="deductTab" >
			    <div  id="datagrid" dataField="list" class="nui-datagrid" 
					style="width: 100%; height: 100%;"  sortMode="client"
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					 <div property="columns">
						<div type="indexcolumn" headerAlign="center" width="40">序号</div>
						<div field="recorder" name="recorder" headerAlign="center" allowSort="true">跟进人</div>
						<div field="scoutDate" name="scoutDate" id="" headerAlign="center" allowSort="true" dateFormat="  yyyy-MM-dd HH:mm" >跟进时间</div>
						<div field="scoutModeId" headerAlign="center" allowSort="true" >跟进方式</div>
						<div field="status" headerAlign="status" allowSort="true" >跟进状态</div>
						<div field="isUsabled" name="isUsabled" headerAlign="center" allowSort="true" >跟进结果</div>
						<!-- <div field="carNo" headerAlign="center" allowSort="true" >关系阶段</div> -->
						<div field="scoutContent" headerAlign="scoutContent" allowSort="true" >客户需求/跟进内容</div>
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