<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): steven
  - Date: 2018-06-20
  - Description:
-->

<head>
<title>预约列表</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/BookingManagement/BookingManagementList.js?v=1.0.62"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<div class="nui-fit">
<input id="scoutMode" class="nui-combobox" visible="false"/>
<input id="isUsabled" class="nui-combobox" visible="false"/>
<input id="bookStatus" class="nui-combobox" visible="false"/>
<div class="nui-toolbar" style="border-bottom:0;">
    <div class="nui-form" id="queryForm" style="width: 100%;" >
        <table style="width: 100%;" id="table1">
            <tr>
                <td>
                    <label>快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenu"id="timeStatus" name="timeStatus">所有</a>               		
               		<ul id="popupMenu_date" class="nui-menu" style="display:none;">
                        <li  onclick="quickSearch(this, timeStatus,'all')" >所有</li>
                        <li  onclick="quickSearch(this, timeStatus, 'today')" >本日</li>
                        <li  onclick="quickSearch(this, timeStatus, 'yesterday')" >昨日</li>
                   		<li  onclick="quickSearch(this, timeStatus, 'week')" >本周</li>
                        <li  onclick="quickSearch(this, timeStatus, 'lastweek')" >上周</li>
                        <li  onclick="quickSearch(this, timeStatus, 'month')" >本月</li>
                        <li  onclick="quickSearch(this, timeStatus, 'lastmounth')" >上月</li>
                	</ul>		
					
					<a class="nui-menubutton " menu="#popupMenu1"id="status" name="status">所有</a>            
                   		<ul id="popupMenu_status" class="nui-menu" style="display:none;">
                        <li  onclick="quickSearch(this, statusStatus,'')" >所有</li>
                        <li  onclick="quickSearch(this, statusStatus, '0')" >待确认</li>
                        <li  onclick="quickSearch(this, statusStatus, '1')" >已确认</li>
                   		<li  onclick="quickSearch(this, statusStatus, '2')" >已开单</li>
                        <li  onclick="quickSearch(this, statusStatus, '3')" >已取消</li>
                        <li  onclick="quickSearch(this, statusStatus, '4')" >已评价</li>
                    </ul>	

                    <span class="separator"></span>
                    <label>车牌号：</label>
                    <input class="nui-textbox" name="carNo"/>
                    <label>手机号：</label>
                    <input class="nui-textbox" name="contactorTel"/>
                    <label style=" margin-left: 1%">服务顾问：</label>
                   	<input class="nui-combobox" id="mtAdvisor" name="mtAdvisor"  value=""   width="70px"  textField="name" valueField="id"/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    			</td>
            </tr>
        </table>
    </div>
</div>

<div class="nui-toolbar" style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td>            
                <a class="nui-button" plain="true" id="addBtn" onclick="addRow()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" plain="true" id="saveBtn" onclick="editRow()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" plain="true" iconCls="" onclick="confirmRow()"><span class="fa fa-check fa-lg"></span>&nbsp;确认</a>
                <a class="nui-button" plain="true" iconCls="" onclick="newBill()"><span class="fa fa-clone fa-lg"></span>&nbsp;开单</a>
                <a class="nui-button" plain="true"  id="cancelBtn"  onclick="cancelBill()"><span class="fa fa-times-circle"></span>&nbsp;取消</a>
           		<a class="nui-button" plain="true" iconCls="" id="fllowUpBtn" onclick="callBill()"><span class="fa fa-comment-o fa-lg"></span>&nbsp;跟进</a>
                <a class="nui-button" plain="true" iconCls="" onclick="showhistory()"><span class="fa fa-shopping-bag fa-lg"></span>&nbsp;服务履历</a>            	
           </td>            
        </tr>
    </table>
</div>

<div class="nui-fit">
<div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
    <div size="70%" showCollapseButton="true">
        <div class="nui-fit">
            <div id="upGrid" class="nui-datagrid"
                style="width: 100%; height: 100%;"
                pageSize="20"
                dataField="data" 
                showPageSize="false"
                selectOnLoad="true" 
                sortMode="client"  ondrawcell="gridOnDraw"
                showReloadButton="false" showPagerButtonIcon="true"
                totalField="page.count"
                allowSortColumn="true">
                <div property="columns">
                    <div field="id" headerAlign="center" allowSort="true" visible="false" width="">id </div>
                    <div field="status" headerAlign="center" allowSort="true" visible="false" width="">status </div>
                    <div field="mtAdvisor" headerAlign="center" allowSort="true" align="center" visible="true" width="">服务顾问 </div>
                    <div field="mtAdvisorId" headerAlign="center" allowSort="true"  visible="false" width="">服务Id </div>
                    <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="">车牌号 </div> 
                    <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="">品牌 </div>
                    <div field="carSeriesId" headerAlign="center" allowSort="true" visible="true" width="">车系 </div>
                    <div field="contactorName" headerAlign="center" allowSort="true" visible="true" width="">联系人 </div>
                    <div field="contactorTel" headerAlign="center" allowSort="true" visible="true" width="">联系电话 </div>
                    <div field="serviceTypeId" headerAlign="center" allowSort="true" visible="true" width="">业务类型 </div>
                    <div field="predictComeDate" headerAlign="center" allowSort="true" dateformat="yyyy-MM-dd" visible="true" width="">预计来厂 </div>
                    <div field="prebookCategory" headerAlign="center" allowSort="true" visible="true" width="">预约类型 </div>
                    <div field="faultDesc" headerAlign="center" allowSort="true" visible="true" width="">客户描述 </div>
                </div>
            </div>
        </div>
    </div>    
    <div size="30%" showCollapseButton="true">
        <div class="nui-fit">
            <div id="downGrid"
            class="nui-datagrid"
            dataField="data"
            style="width: 100%; height: 100%;"
            showPager="false"
            allowSortColumn="true">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                <div header="基本信息" headerAlign="center">
                    <div property="columns">
                        <div field="scoutMan" headerAlign="center" allowSort="true" visible="true" width="100">跟进人 </div>
                        <div field="scoutDate" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" visible="true" width="100">跟进日期 </div>
                        <div field="scoutMode" headerAlign="center" allowSort="true" visible="true" width="100">跟进方式 </div>
                        <div field="isUsabled" headerAlign="center" allowSort="true" visible="true" width="100">跟进结果 </div>
                        <div field="nextScoutDate" headerAlign="center"  dateFormat="yyyy-MM-dd" allowSort="true" visible="true" width="100">下次跟进日期 </div>
                    </div>
                </div>
                <div header="详细信息" headerAlign="center">
                    <div property="columns">
                        <div field="scoutContent" headerAlign="center" allowSort="true" visible="true">跟进内容 </div>
                    </div>
                </div>
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