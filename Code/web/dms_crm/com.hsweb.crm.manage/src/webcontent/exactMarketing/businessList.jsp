<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 11:44:38
  - Description:
-->
<head>
<title>商机列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
    
      <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
</style>  
</head>
<body>

		<div  class="nui-toolbar" style="padding:2px;border-bottom:1;">
                <table id="top"style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                        	预计成单时间：<input class="nui-datepicker"  id="" name="" selectOnFocus="true" enabled="true" emptyText=""/>
                        	姓名/手机：<input class="nui-textbox" id="" emptyText=""  selectOnFocus="true" name=""/>         
                        	产品/项目：<input class="nui-textbox"  id="" emptyText="" selectOnFocus="true" name=""/>
                        	销售阶段：<input id="" visible="true" class="nui-combobox" name="" />
                            	
                        </td>
                      
                    </tr>
                     <tr>
                        <td style="width:100%;">

                        	下次跟进时间：<input id="" visible="true" class="nui-datepicker" name="" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;车牌号：<input id="" visible="true" class="nui-textbox" name="" />
                        	商机所有者：<input id="" visible="true" class="nui-combobox" name="" />
                        	   状态：<input id="" visible="true" class="nui-textbox" name="" />                                    
                        	<span class="separator"></span>
                            <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id=""><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="addBusinessOpp" id=""><span class="fa fa-plus fa-lg"></span>&nbsp;添加商机</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="" id=""><span class="fa fa-edit fa-lg"></span>&nbsp;商机设置</a>
                        </td>
                    </tr>
                </table>
            </div>
      <div class="nui-fit">      
		<div id="businessTabs" class="nui-tabs" name="gridTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="true" 
           onactivechanged="">
           <div title="商机列表" id="allTab" name="allTab" url="" >
           		<div id="allGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="车牌号"></div>
		                <div field="" name="" width="100" headerAlign="center" header="手机号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="产品/项目"></div>
		                <div field="" name="" width="60" headerAlign="center" header="销售金额"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="商机所有者"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="跟进次数"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="上次跟进内容"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="阶段"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="创建人"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="下次跟进时间"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="预计成单时间"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="状态"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="商机报表" id="activeTab" name="activeTab" url="" >
           		<div id="activeGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="车牌号"></div>
		                <div field="" name="" width="100" headerAlign="center" header="手机号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="产品/项目"></div>
		                <div field="" name="" width="60" headerAlign="center" header="销售金额"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="商机所有者"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="跟进次数"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="上次跟进内容"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="阶段"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="创建人"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="下次跟进时间"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="预计成单时间"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="状态"></div>
	                    <div field="" name="" width="100" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>

        </div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	function addBusinessOpp(){
    		nui.open({
			url : webPath+ crmDomain+ "/manage/exactMarketing/addBusinessOpp.jsp?token"+ token,
			title : "添加商机",
			width : 500,
			height : 300,
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