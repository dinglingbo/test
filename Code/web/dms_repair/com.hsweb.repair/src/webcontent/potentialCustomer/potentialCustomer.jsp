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
<title>潜在客户</title>
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

.mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important;
}

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
                <td style="width:100%;">
                    
                   <a class="nui-button" onclick="addCus()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                   <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-check fa-lg"></span>&nbsp;成功</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-remove fa-lg"></span>&nbsp;失败</a>
                   <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 80px;"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;置为洽谈</a>
                   <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 80px;"><span class="fa fa-share fa-lg"></span>&nbsp;转为客户</a>
                   <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                   <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;其他功能</a>

                <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="unfinish()" id="addBtn">返单</li>
                    <li iconCls="" onclick="updateBillExpense()" id="billExpense">费用登记</li>
                   <!--  <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount">新增报销单</li> -->
                    <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount1">报销单</li>
                    <li iconCls="" onclick="openOrderDetail()" id="openOrderDetail">打开工单详情页</li>
                    <li iconCls="" onclick="toChangBillTypeId(2)" id="">转为洗美开单</li>
                    <li iconCls="" onclick="toChangBillTypeId(4)" id="">转为理赔开单</li>
                    <li iconCls="" onclick="upload()" id="ExpenseAccount1">上传维修前后照片</li>
                    <!-- <li iconCls="" onclick="addcardTime()" id="type13">车牌替换/修改</li>
                    <li iconCls="" onclick="addcard()" id="type11">等级转介绍客户</li> -->
                </ul>
                 <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;退出</a>
                </td>
            </tr>
        </table>
    </div>
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="nui-form-table" border=0>
            <tr>
                
               <td class="form_label" style="width:100px">
                   <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">来访日期</a>
                   <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">来访日期</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">回访日期</li>
                   </ul>
               </td>
                <td>   
                    <input class="nui-datepicker" id="OstartDate"  width="100" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false" />
				-
                   <input class="nui-datepicker" id="OendDate"  width="100" allowInput="false"  format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
             	</td>
             	 <td class="form_label">
             	     <label>来访方式：</label>
             	</td>
             	 <td>
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false"  valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                 </td>
                 
                 <td class="form_label">
                      <label>客户来源：</label>
                 </td>
                 <td>
                 <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                         url=""  allowInput="true" showNullItem="false"  valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                </td>
                 <!--  <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                 --> 
                 <td class="form_label"> 
                     <label>状态：</label>
                 </td>
                 <td>
                  <input class="nui-combobox" id="billTypeId" emptyText="全部" name="billTypeId" data="[{billTypeId:5,text:'全部'},{billTypeId:0,text:'洽谈中'},{billTypeId:2,text:'成功'},{billTypeId:4,text:'失败'}]"
                           onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/>
                 </td>
                 <td class="form_label">
                  <label>客户名称：</label>
                 </td>
                 <td>
                  <input class="nui-textbox"  id="partCodeOrName" name="partCodeOrNmae" selectOnFocus="true" enabled="true" emptyText=""/>
                 </td>
                 <td class="form_label">
                 <label>客户区域：</label>
                 </td>
                 <td>
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                       emptyText="" url=""  allowInput="true" showNullItem="false"  valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                </td>
                <td class="form_label">
                <label >意向颜色：</label>
                </td>
                <td>
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                
                  <!--  <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> -->  
                </td>
                
            </tr>
            <tr>
               <td class="form_label">
                  <label>意向车型：</label>
               </td>
               <td>
                  <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url="" width="200" allowInput="true" showNullItem="false"  valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                </td>
               <td class="form_label">
                    <label style="font-family:Verdana;">购车用途：</label>
               </td>
               <td class="form_label">
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
             </td> 
             
               <td class="form_label">
                 <a class="nui-menubutton " menu="#popupMenuDate2" id="menunamedate2">联系人</a>
                   <ul id="popupMenuDate2" class="nui-menu" style="display:none;">
                   <li iconCls="" onclick="quickSearch(0)" id="type0">手机号</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">联系电话</li>
                   <li iconCls="" onclick="quickSearch(0)" id="type0">证件号码</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">汽车品牌</li>
                   <li iconCls="" onclick="quickSearch(1)" id="type1">车辆类型</li>
                   </ul>
               </td>
               <td>
                  <input class="nui-textbox"  id="partCodeOrName" name="partCodeOrNmae" selectOnFocus="true" enabled="true" emptyText=""/>
              </td>
              <td class="form_label">   
                  <label >组织机构：</label>
              </td>
              <td>
                 <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false"  valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
             </td>
             <td class="form_label">
                  <label>业务员：</label>
             </td>
             <td>
                 <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="" url=""  allowInput="true" showNullItem="false" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
              </td>
              <td class="form_label">
                <label >试驾：</label> 
              </td>
              <td>
                 <input class="nui-combobox" id="billTypeId2" emptyText="全部" name="billTypeId" data="[{billTypeId:5,text:'全部'},{billTypeId:0,text:'是'},{billTypeId:2,text:'否'}]"
                            onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/>
              </td>
              <td class="form_label" >
                 <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
              </td>
            </tr>
        </table>
    </div>




	<div class="nui-splitter" style="width: 100%; height: 88%;"
		 showHandleButton="false">
		<div size="150" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar"
					 style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<span>客户等级</span>
				
				</div> 
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;height: 86%;"
						dataField="data"
						resultAsTree="false"
						showTreeIcon="true"
						textField="name" idField="id" parentField="dictid">
					</ul>
				</div>
			</div>
		</div>
		
		
		<div showCollapseButton="false" style="width:100%;">
			<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 20px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%">
						来访记录
						</td>
					</tr>
				</table>
		        <!--  <span></span> -->
			</div>
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
						<div type="indexcolumn">序号</div>
						<div type="checkcolumn" name="checkcolumn" visible="false"></div>
						<div field="" headerAlign="center" allowSort="true" width="60px">单据编号</div>
				         <div field="" name="" id="" headerAlign="center" allowSort="true" dateFormat="  yyyy-MM-dd HH:mm"  width="60px">来访时间</div>
						<div field="" headerAlign="center" allowSort="true" width="50px">业务员</div>
						<div field="" headerAlign="center" allowSort="true" width="60px">来访方式</div>
						<div field="" headerAlign="center" allowSort="true" visible="true" width="50px">访问状态</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" dateFormat="  yyyy-MM-dd HH:mm"  width="60px">售前回访日期</div>
						<div field="" headerAlign="center" allowSort="true" width="50px">客户来源</div>
						<div field="" headerAlign="center" allowSort="true" width="50px">意向级别</div>
						<div field="" headerAlign="center" width="60px">客户名称</div>
						<div field="" headerAlign="center" width="60px">联系人</div>
						<div field="" name="" headerAlign="center" allowSort="true" width="60px">联系人电话</div>
						<div field="" name="" headerAlign="center" allowSort="true" width="60px">手机号码</div>
						<div field="" name="" headerAlign="center" allowSort="true" width="60px">车型编号</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">车型名称</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">汽车品牌</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">车辆类型</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">意向颜色</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">购车用途</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">付款方式</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">预算金额</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">购车预期</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">考虑因素</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">是否试驾</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">备注</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">组织机构</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" width="60px">制单人</div>
						<div field="" name="" id="" headerAlign="center" allowSort="true" dateFormat="  yyyy-MM-dd HH:mm"  width="60px">制单日期</div>
					</div>
				</div>
              </div>
              <div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 30px;">
              客户跟进记录
              </div>
              <div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 30px;">
				<table style="width: 100%">
					<tr>
				  <td style="width:100%;">
                   <a class="nui-button" onclick="addFollowUpRecord()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                     <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                   <a class="nui-button" onclick="potentialCustomer" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                </td>
					</tr>
				</table>
			</div>		
			    <div id="tempGrid2" class="nui-datagrid" style="width:100%;height:30%"
					showPager="false"
					pageSize="1000"
					selectOnLoad="true"
					showModified="false"
					multiSelect="true"
					dataField="parts"
					url="">
					<div property="columns" >
					<div field="" headerAlign="center" allowSort="true" width="80px">跟踪日期</div>
					<div field="" headerAlign="center" allowSort="true" width="80px">跟踪方式</div>
					<div field="" headerAlign="center" allowSort="true" width="80px">跟踪员</div>
					<div field="" headerAlign="center" allowSort="true" width="80px">跟内容</div>
					<div field="" headerAlign="center" allowSort="true" width="20px">下次跟踪日期</div>
				</div>
			</div>
		    
		</div>
   </div>
</div>
</body>
</html>