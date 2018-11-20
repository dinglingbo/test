<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 10:09:47
  - Description:
-->
<head>
<title>客户分析</title>
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
                            	消费次数：<input class="nui-textbox" width="" id="" name="" selectOnFocus="true" enabled="true" emptyText=""/>
                            	最近消费：<input class="nui-textbox" width="" id="" emptyText=""  selectOnFocus="true" name=""/>         
                            	活动周期：<input class="nui-textbox" width="" id="" emptyText="" selectOnFocus="true" name=""/>
                            	消费金额：<input id="" visible="true" class="nui-textbox" name="" />

                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%;">
                            
                            	业务类型：<input id="" visible="true" class="nui-combobox" name="" />
                      &nbsp;&nbsp; 关键字：<input id="" visible="true" class="nui-textbox" name="" />
                    &nbsp;&nbsp; &nbsp;客单价：<input id="" visible="true" class="nui-textbox" name="" />
                            	服务顾问：<input id="" visible="true" class="nui-combobox" name="" />
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
              
                        </td>
                    </tr>
                </table>
            </div>
      <div class="nui-fit">   
		<div id="typeGridTabs" class="nui-tabs" name="gridTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="true" 
           onactivechanged="">
           <div title="全部" id="allTab" name="allTab" url="" >
           		<div id="allGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="活跃期" id="activeTab" name="activeTab" url="" >
           		<div id="activeGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="稳定期" id="stableTab" name="stableTab" url="" >
           		<div id="stableGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="睡眠期" id="sleepTab" name="sleepTab" url="" >
           		<div id="sleepGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
                    	<div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="流失期" id="loseTab" name="loseTab" url="" >
           		<div id="loseGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
           <div title="未分类" id="notClassTab" name="notClassTab" url="" >
           		<div id="notClassGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="" name="" width="80" headerAlign="center" header="姓名"></div>
		                <div field="" name="" width="55" headerAlign="center" header="客户类型"></div>
		                <div field="" name="" width="100" headerAlign="center" header="车牌号"></div>
	                  	<div field="" name="" width="70" headerAlign="center" header="电话"></div>
		                <div field="" name="" width="60" headerAlign="center" header="微信注册"></div>
	                    <div field="" name="" width="110" headerAlign="center" header="业务类型" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="最近消费"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="客单价"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="生命周期"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费次数"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="消费总额"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="服务顾问"></div>
	                    <div field="" name="" width="200" headerAlign="center" header="操作"></div>
	            </div>
	            </div>
           </div>
        </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>