<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 18:51:42
  - Description:
-->
<head>
<title>商机设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
</head>
<body>
<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
	<!-- 上 -->
	<div size="50%" showCollapseButton="false">

		<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td >
						商机设置
                    </td>
                    <td align="right">
						<a class="nui-button" iconCls="" plain="true" onclick="editMatinRemind()" id=""><span class="fa fa-edit fa-lg"></span>&nbsp;提醒方式</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="" id=""><span class="fa fa-edit fa-lg"></span>&nbsp;提醒原因</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
        <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false" pageSize="20"
            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
            <div property="columns">
            		<div type="indexcolumn" width="30">序号</div>
                	<div field="" name="" width="80" headerAlign="center" header="名称"></div>
	                <div field="" name="" width="55" headerAlign="center" header="系统预设备单价"></div>
	                <div field="" name="" width="100" headerAlign="center" header="客单价"></div>
                  	<div field="" name="" width="70" headerAlign="center" header="提前通知时间"></div>
	                <div field="" name="" width="60" headerAlign="center" header="更新时间"></div>
                    <div field="" name="" width="100" headerAlign="center" header="状态"></div>
                    <div field="" name="" width="100" headerAlign="center" header="操作"></div>
            </div>
	   </div>
	   </div>
	</div>
	<div showCollapseButton="false">
		<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="">
						项目设置
                    </td>
                    <td align="right">
						<a class="nui-button" iconCls="" plain="true" onclick="editMatinRemind()" id=""><span class="fa fa-edit fa-lg"></span>&nbsp;批量设置</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="" id=""><span class="fa fa-plus fa-lg"></span>&nbsp;工时项目</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="" id=""><span class="fa fa-plus fa-lg"></span>&nbsp;配件项目</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
        <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false" pageSize="20"
            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
            <div property="columns">
            		<div type="indexcolumn" width="30">序号</div>
                	<div field="" name="" width="80" headerAlign="center" header="编号"></div>
	                <div field="" name="" width="55" headerAlign="center" header="项目名称"></div>
	                <div field="" name="" width="100" headerAlign="center" header="售价"></div>
                  	<div field="" name="" width="70" headerAlign="center" header="VIP价"></div>
	                <div field="" name="" width="60" headerAlign="center" header="温馨提示"></div>
                    <div field="" name="" width="100" headerAlign="center" header="保养提醒"></div>
                    <div field="" name="" width="100" headerAlign="center" header="提醒服务顾问"></div>
                    <div field="" name="" width="100" headerAlign="center" header="状态"></div>
                	<div field="" name="" width="100" headerAlign="center" header="操作"></div>
            </div>
	   </div>
	   </div>
	</div>
</div>

	<script type="text/javascript">
    	nui.parse();
    	
    	function editMatinRemind(){
    		nui.open({
			url : webPath+ crmDomain+ "/manage/exactMarketing/editMatinRemind.jsp?token"+ token,
			title : "更新保养设置",
			width : 400,
			height : 350,
			allowDrag : false,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();


// 				iframe.contentWindow.SetData(params);
			},
			ondestroy : function(action) {
				if (action == 'ok') {

				}
			}
		});
    	}
    	
    	function editMatinRemind(){
    		nui.open({
			url : webPath+ crmDomain+ "/manage/exactMarketing/itemRemindSet.jsp?token"+ token,
			title : "项目提醒设置",
			width : 500,
			height : 480,
			allowDrag : false,
			allowResize : false,
			onload : function() {
				var iframe = this.getIFrameEl();


// 				iframe.contentWindow.SetData(params);
			},
			ondestroy : function(action) {
				if (action == 'ok') {

				}
			}
		});
    	}
    </script>
</body>
</html>