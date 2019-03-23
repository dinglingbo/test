<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>员工管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <script src="<%=webPath + contextPath%>/common/js/employeeQuery.js?v=2.1.10" type="text/javascript"></script>    
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form1" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
					<label style="font-family:Verdana;">姓名：</label>
					<input class="nui-textbox" id="name" name="meberName" onenter="search()"/>
					<label style="font-family:Verdana;">电话：</label>
					<input class="nui-textbox" id="mobile" name="mobile" onenter="search()" />
					<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="选择公司" url=""  allowInput="true" showNullItem="false" width="160" valueFromSelect="true" onvaluechanged="search()"/>
					<a class="nui-button"  iconCls="" onclick="search()" plain="true"><span class="fa fa-search"></span>&nbsp;查询</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="" onclick="edit('new')"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" plain="true" iconCls="" onclick="edit('edit')"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
					 <span class="separator"></span>
					<a class="nui-button" plain="true" iconCls="" id="btnisDimission" name="btnisDimission" onclick="dimssion()"><span class="fa fa-user-times"></span>&nbsp;离职</a>
					<a class="nui-button" plain="true" id="btnisOpenAccount" name="btnisOpenAccount" iconCls="" onclick="stoporstart()" ><span class="fa fa-key"></span>&nbsp;开通账号</a>
					<a class="nui-button" plain="true" id="resetPasswordBtn" name="resetPasswordBtn" iconCls="" onclick="resetPassword()" ><span class="fa fa-key"></span>&nbsp;重置密码</a>
					<span class="separator"></span>
					<a class="nui-button" plain="true" id="selectComBtn" name="selectComBtn" iconCls="" onclick="selectCom()" ><span class="fa fa-check fa-lg"></span>&nbsp;新增兼职公司</a>
					<a class="nui-button" plain="true" id="lookComBtn" name="lookComBtn" iconCls="" onclick="lookCom()" ><span class="fa fa-search fa-lg"></span>&nbsp;查看兼职公司</a>
					<a class="nui-button" plain="true" iconCls="" onclick="importGuest()"  visible="false" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div id="datagrid1" 
			dataField="rs" 
			class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url=""
			showModified="false" onrowdblclick="edit('edit')"
			pageSize="50" showPageInfo="true" multiSelect="false"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count" onselectionchanged="changebutton" 
			allowSortColumn="true">

			<div property="columns">
				
						<div type="checkcolumn">选择</div>
						<div id="empid" field="empid" headerAlign="center" allowSort="true"  width="40px" visible="false">id</div>
						<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="40px">姓名</div>
						<div id="compShortName" field="compShortName" headerAlign="center" allowSort="true" visible="true" width="60px">所属机构</div>
						<div id="sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="20px">性别</div>
						<div id="idcardno" field="idcardno" headerAlign="center" allowSort="true" visible="true" width="80px">身份证</div>
						<div id="birthday" field="birthday" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="60px">生日</div>
						<div id="tel" field="tel" headerAlign="center" allowSort="true" visible="true" width="60px">电话</div>
						<div id="isDimission" field="isDimission" headerAlign="center" allowSort="true" visible="true" width="40px">是否离职</div>
						<div id="isOpenAccount" field="isOpenAccount" headerAlign="center" allowSort="true" visible="true" width="50px">是否开通系统</div>
						<div id="systemAccount" field="systemAccount" headerAlign="center" allowSort="true" visible="true" width="50px">登陆账号</div>
						<div id="recorder" field="recorder" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
						<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="60px" dateFormat="yyyy-MM-dd HH:mm">建档日期</div>
		
				
			</div>
		</div>
	</div>
	
	<div id="advancedOrgWin" class="nui-window"
     title="公司选择" style="width:530px;height:340px;"
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
                    <a class="nui-button" iconCls="" plain="true" onclick="addOrg" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="false"
               dataField="orgList"
               onrowdblclick="addOrg"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               allowCellSelect="true" 
               multiSelect="false"
               url="">
              <div property="columns">
              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
                <div field="orgcode" name="orgid" width="15" align="center"  visible="true" headerAlign="center" header="企业号"></div>
                <div field="orgname" name="orgname" width="" align="center"  headerAlign="center" header="公司名称"></div>
              </div>
          </div>
    </div>
</div>
	
	
</body>
</html>