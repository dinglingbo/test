<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<head>
<title>注册审核</title>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script src="<%= request.getContextPath() %>/tenant/js/review_register.js?v=1.9.36"
	type="text/javascript"></script>
</head>
<body>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;"
		id="queryForm">
		<input class="nui-textbox" name="rOrp" id="rOrp" value="1" style="display: none;"></input>
		<table style="width: 100%;">
			<tr>
				<td>
					
					<input class="nui-combobox" id="provinceId" visible="false" textField="name" url="" valueField="code"/>
					<input class="nui-combobox" id="cityId" visible="false" textField="name" url="" valueField="code"/>
                	<label style="font-family: Verdana;" title="点击清空条件"><span>审核状态：</span></label> 
							<a class="nui-menubutton "  menu="#popupMenu1"  id="assignStatus" name="assignStatus" >全部</a>
               	  <ul id="popupMenu1" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="setMenu1(this, assignStatus, '')" id="type1">全部</li>
                    <li iconCls="" onclick="setMenu1(this, assignStatus,0)" id="typeAll">未审批</li>
                    <li iconCls="" onclick="setMenu1(this, assignStatus,1)" id="type0">审批通过</li>
                    </ul>	
                 
                    <label style="font-family: Verdana;" title="点击清空条件"><span>是否禁用：</span></label> 
							<a class="nui-menubutton "  menu="#popupMenu2"  id="assignStatus2" name="assignStatus2" >全部</a>
               	  <ul id="popupMenu2" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="setMenu2(this, assignStatus2, '')" id="type2">全部</li>
                    <li iconCls="" onclick="setMenu2(this, assignStatus2,1)" id="typeAll2">是</li>
                    <li iconCls="" onclick="setMenu2(this, assignStatus2,0)" id="type2">否</li>
                    </ul>
               
               		<li class="separator"></li>
                            <label style="font-family:Verdana;">创建日期 从：</label>
                            <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <label style="font-family:Verdana;">至</label>
                            <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
					
					<li class="separator"></li>
					<a class="nui-button"  plain="true" href="javascript:query();" id="query" enabled="true"  onclick="superSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
					<a class="nui-button"  plain="true" href="" id="query" enabled="true"  onclick="OrgShow"><span class="fa fa-search fa-lg"></span>&nbsp;查看</a>
<!-- 					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="audit"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a> -->
					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="auditRepair(2)"><span class="fa fa-check fa-lg"></span>&nbsp;认证为汽配商</a>
					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="auditRepair(1)"><span class="fa fa-check fa-lg"></span>&nbsp;认证为汽修商</a>
					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="auditRepair(3)"><span class="fa fa-check fa-lg"></span>&nbsp;认证为变速箱专修商</a>
					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="auditRepair(4)"><span class="fa fa-check fa-lg"></span>&nbsp;认证为汽贸商</a>
					<a class="nui-button"  plain="true"	 id="sh" enabled="true"  onclick="auditRepair(5)"><span class="fa fa-check fa-lg"></span>&nbsp;认证为汽贸汽修综合商</a>
					<a class="nui-button"  plain="true"	 id="jy" name="jy" enabled="true"  onclick="stopUse"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
					<a class="nui-button"  plain="true" visible="false"	 id="qy" name="qy" enabled="true"  onclick="stopUse"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用</a>
			 	</td>
			</tr>
		</table>
	</div>
	
	
		<div class="nui-fit">
		<!-- 供应商排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="20"
				sizeList="[20,50,100]" allowAlternating="true" multiSelect="true"
			    url="<%= request.getContextPath() %>/com.primeton.tenant.reView.allRegister.biz.ext" 
				onselectionchanged="changebutton"
				>
				<div property="columns" width="10">
						<div type="checkcolumn">选择</div>
						<div field="id" allowSort="true" headerAlign="center"  visible="false"
								width="120"  >用户id</div>
						<div field="tenantId" allowSort="true" headerAlign="center"
								width="50"  >租户ID</div>
						<div field="mobile" allowSort="true" headerAlign="center"
								width="120"  >手机号</div>
						<div field="name" allowSort="true" headerAlign="center"
								width="120"  >用户名称</div>
					    <div field="companyName" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
						<div field="provinceId" allowSort="true" headerAlign="center"
								width="120"  >省份</div>
						<div field="cityId" allowSort="true" headerAlign="center"
								width="120"  >城市</div>
						<div field="status" allowSort="true" headerAlign="center"
								width="120"  >审核状态</div>
						<div field="isDisabled" allowSort="true" headerAlign="center"
								width="120"  >是否禁用</div>
				 		<div field="type" allowSort="true" headerAlign="center"
								width="120"  >用户分类</div>
						<div field="recorder" allowSort="true" headerAlign="center"
								width="120"  >建档人</div>
						<div field="recordDate" allowSort="true" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"
								width="120"  >建档日期</div>
								
					</div>
			</div>
	
		</div>

 	
 	<div id="advancedOrgWin" class="nui-window"
     title="公司选择" style="width:600px;height:340px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <input class="nui-textbox" id="orgidOrName" name="orgidOrName" width="160px" emptyText="请输入店号或公司名">
                    <a class="nui-button" iconCls="" plain="true" onclick="searchOrg()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="addOrgAccount" id=""><span class="fa fa-check fa-lg"></span>&nbsp;开通电商账号</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="openAPP" id=""><span class="fa fa-check fa-lg"></span>&nbsp;注册仓先生APP</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="false"
               dataField="companyList"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               allowCellSelect="true" 
               multiSelect="false"
               url="">
              <div property="columns">
              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
                <div field="orgid" name="orgid" width="15" align="center"  visible="true" headerAlign="center" header="企业号"></div>
                <div field="name" name="name" width="80" align="center"  headerAlign="center" header="公司名称"></div>
                <div field="srmUserId" name="srmUserId" width="40" align="center"  headerAlign="center" header="电商账号"></div>
                <div field="agencyId" name="agencyId" width="40" align="center"  headerAlign="center" header="仓先生APP公司ID"></div>
              </div>
          </div>
    </div>
</div>
</body>
<script type="text/javascript">

		 function superSearch(){
		 nui.open({
             url: "superSearch.jsp",
             title: "收款", width: 600, height: 350,
             onload: function () {
              },
             ondestroy: function (action) {
             }
         });}

</script>
</html>