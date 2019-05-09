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
    <title>员工兼职选择</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <script src="<%=webPath + contextPath%>/common/js/employeeHaveCompany.js?v=1.0.6" type="text/javascript"></script>    
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
				    <label style="font-family:Verdana;">快速查询：</label>
					<input class="nui-textbox" id="code" name="code" width="160px" emptyText="请输入店号" onenter="onSearch">
					<input class="nui-textbox" id="name" name="name" width="160px" emptyText="请输入公司名称" onenter="onSearch">
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="addOrg()" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="Oncancel" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
				</td>
			</tr>
		</table>
	</div> 
	 <div class="nui-fit">
          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="false"
               showPager="true"
               pageSize="10"
               totalField="page.count"
               dataField="companyList"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               multiSelect="true"
               url="">
              <div property="columns">
              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
                <div field="code" name="orgid" width="30" align="center"  visible="true" headerAlign="center" header="店号"></div>
                <div field="name" name="orgname" width="" align="center"  headerAlign="center" header="公司名称"></div>
                <div field="address" name="address" width="" align="center"  headerAlign="center" header="公司地址"></div>
              </div>
          </div>
    </div>	
</body>
</html>