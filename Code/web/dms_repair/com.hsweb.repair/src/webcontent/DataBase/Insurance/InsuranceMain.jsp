<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:45:50
  - Description:
-->
<head>
<title>保险公司</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceMain.js" type="text/javascript" ></script>
    
</head>
<body>
	
	
        <div  class="nui-toolbar"  style="height:30px">
        	<div  class="nui-form1" id="form1" style="height:100%">
        		<table class="table" id="table1" style="height:100% ">
	        	   <tr>
	        	   		<td>
	        	    		 <label style="font-family:Verdana;font-size: 12px;">快速查询：</label>
	        	    	
	        	         	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(0)">已启用</a>
	                	 	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(1)">已禁用</a>
	                	 	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(2)">全部</a>
	        	        </td>
	        	   </tr>
	        	</table>
        	</div>
        </div>
    
	
	<div class="nui-toolbar"  style="border-bottom:0;padding:0px;height:30px">
		<table style="width:100%">
			<tr >
				<td style="width:100%" >
					<a class="nui-button" iconCls="icon-add" onclick="add()" plain="true">新增（A）</a>
					<a class="nui-button" iconCls="icon-edit" onclick="edit()" plain="true">修改（E）</a>
					<a class="nui-button" iconCls="icon-no" onclick="disableComeguest()" id="disabled" plain="true">禁用（L）</a>
					<a class="nui-button" iconCls="icon-ok" onclick="enableComeguest()"  id="enabled"  plain="true" visible="false">启用</a>
				</td>
        	</tr>
    	</table>
    </div>
    
    <div class="nui-fit" >
		<div id="datagrid1" dataField="comguests" class="nui-datagrid" style="width:100%;height:100%;" 
             url="" 
             pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="false" showPage="true"  showPageSize="false"
             showReloadButton="false" showPagerButtonIcon="false"  totalCount="total"
             ondrawcell="onDrawCell"
             allowSortColumn="true">
			<div property="columns">
				<div type="indexcolumn" >序号</div>
				<div header="保险公司信息" headerAlign="center">
					<div property="columns">
						<div id="code"  field="code" headerAlign="center" allowSort="true" width="15%">保险公司代码</div>
                    	<div id="fullName" field="fullName" headerAlign="center" allowSort="true" visible="true"width="35%">保险公司名称</div>
						<div id="contactor" field="contactor" headerAlign="center" allowSort="true" width="10%">联系人</div>
						<div id="contactorTel" field="contactorTel" headerAlign="center" allowSort="true" width="20%">联系人电话</div>
						<div id="orderIndex" field="orderIndex" headerAlign="center" allowSort="true" width="8%" dataType="int">排序号</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" width="12%" renderer="onIsDisabled">是否禁用</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>