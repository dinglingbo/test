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
    <script src="<%=webPath + contextPath%>/common/js/employeeQuery.js?v=2.1.32" type="text/javascript"></script>    
        <style type="text/css">

        #wechatTag1{
            color:#ccc;
    }
    #wechatTag{
        color:#62b900;
    }
    </style>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form1" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
					<label style="font-family:Verdana;">姓名：</label>
					<input class="nui-textbox" width="100px" id="name" name="meberName" onenter="search()"/>
					<label style="font-family:Verdana;">手机号码：</label>
					<input class="nui-textbox" width="100px" id="mobile" name="mobile" onenter="search()" />
					<label style="font-family:Verdana;">是否离职：</label>
					<input name="isDimission" width="60px" id="isDimission" class="nui-combobox width1" textField="value" valueField="id" 
                        emptyText="" url=""  allowInput="true" showNullItem="false" width="160" valueFromSelect="true" onvaluechanged="search()"/>
					<label style="font-family:Verdana;">是否服务技师：</label>
					<input name="isArtificer" width="60px" id="isArtificer" class="nui-combobox width1" textField="value" valueField="id" 
                        emptyText="" url=""  allowInput="true" showNullItem="false" width="160" valueFromSelect="true" onvaluechanged="search()"/>
					<label style="font-family:Verdana;">是否服务顾问：</label>
					<input name="isMtadvisor" width="60px" id="isMtadvisor" class="nui-combobox width1" textField="value" valueField="id" 
                        emptyText="" url=""  allowInput="true" showNullItem="false" width="160" valueFromSelect="true" onvaluechanged="search()"/>
					<label style="font-family:Verdana;">是否采购/仓库：</label>
					<input name="isPchsStock" width="60px" id="isPchsStock" class="nui-combobox width1" textField="value" valueField="id" 
                        emptyText="" url=""  allowInput="true" showNullItem="false" width="160" valueFromSelect="true" onvaluechanged="search()"/>
					
					
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
					<span class="separator"></span>
					<a class="nui-button" plain="true" id="btnisIM" name="btnisIM" iconCls="" onclick="stoporstartIM()" ><span class="fa fa-key"></span>&nbsp;开通聊天</a>
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
				<div id="empid" field="empid" headerAlign="center" allowSort="true"  width="60px" visible="false">id</div>
				<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="60px">姓名</div>
				<div id="tel" field="tel" headerAlign="center" allowSort="true" visible="true" width="100px">手机号码</div>
				<div id="sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="20px">性别</div>
				<div id="isArtificer" field="isArtificer" headerAlign="center" allowSort="true" visible="true" width="40px">服务技师</div>
				<div id="isMtadvisor" field="isMtadvisor" headerAlign="center" allowSort="true" visible="true" width="40px">服务顾问</div>
				<div id="isStockman" field="isStockman" headerAlign="center" allowSort="true" visible="true" width="40px">允许领料</div>
				<div id="isCanfreeCarnovin" field="isCanfreeCarnovin" headerAlign="center" allowSort="true" visible="true" width="40px">车牌号车架号是否允许自由输入</div>
				<div id="isCanSettle" field="isCanSettle" headerAlign="center" allowSort="true" visible="true" width="40px">工单是否允许直接结算</div>
				<div id="isPchsStock" field="isPchsStock" headerAlign="center" allowSort="true" visible="true" width="40px">采购/仓库</div>
				<div id="birthday" field="birthday" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="60px">生日</div>
				<div id="systemAccount" field="systemAccount" headerAlign="center" allowSort="true" visible="true" width="100px">登陆账号</div>
				<div id="isOpenAccount" field="isOpenAccount" headerAlign="center" allowSort="true" visible="true" width="50px">是否开通系统</div>
				<div id="imCode" field="imCode" headerAlign="center" allowSort="true" visible="true" width="50px">是否开通IM</div>
				<div id="isDimission" field="isDimission" headerAlign="center" allowSort="true" visible="true" width="40px">是否离职</div>
				<div id="compShortName" field="compShortName" headerAlign="center" allowSort="true" visible="true" width="60px">所属机构</div>
				<div id="recorder" field="recorder" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
				<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="100px" dateFormat="yyyy-MM-dd HH:mm">建档日期</div>							
		
				
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