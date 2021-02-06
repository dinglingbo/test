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
    <title>用户反馈管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <script src="<%=webPath + contextPath%>/common/js/feedbackList.js?v=1.0.15" type="text/javascript"></script>    
    
</head>
 <style type="text/css"> 
   a.optbtn {
        width: 40px; 
        /* height: 26px; */
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }
 </style>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<input class="nui-hidden" name="criteria/_entity" value="" />
		<table id="form" style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
				    <label style="font-family:Verdana;">快速查询：</label>
				    <input class="nui-combobox" id="statusId" emptyText="全部" name="statusId" data="[{statusId:3,text:'全部'},{statusId:0,text:'待处理'},{statusId:1,text:'处理中'},{statusId:2,text:'已解决'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="statusId" value="3"/>
					<input class="nui-textbox" id="recordMobile" name="recordMobile" width="160px" emptyText="请输入手机号" onenter="onSearch">
					<input class="nui-textbox" id="orgname" name="orgname" width="160px" emptyText="请输入公司名称" onenter="onSearch">
					
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="addOrg()" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="Oncancel" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
				</td>
			</tr>
		</table>
	</div> 
	 <div class="nui-fit">
          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="false"
               showPager="true"
               dataField="data"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = true
               multiSelect="false" 
               url=""
               totalField="page.count"
			   pageSize="500"
			   sizeList="[500,1000,2000]"
               >
              <div property="columns">
                <div type="indexcolumn">序号</div>
              	<!-- <div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div> -->
                <div field="recordMobile" name="recordMobile" width="60" align="center"  visible="true" headerAlign="center" header="手机号"></div>
                <div field="recorder" name="recorder" width="60" align="center"  visible="true" headerAlign="center" header="姓名"></div>
                <div field="orgname" name="orgname" width="" align="center"  headerAlign="center" header="公司"></div>
                <div field="questionType" name="questionType" width="" align="center"  headerAlign="center" header="问题摘要"></div>
                <div field="recordDate" name="recordDate" width="" align="center"  headerAlign="center" width="60" header="反馈时间" dateFormat="yyyy-MM-dd"></div>
                <div field="source" name="questionSource" width="" align="center"  headerAlign="center" header="来源"></div>
                <div field="status" name="status" width="" align="center"  headerAlign="center" header="状态"></div>
                <div field="feedOptBtn" name="feedOptBtn" width="" align="center"  headerAlign="center" header="操作"></div>
              </div>
          </div>
    </div>	
</body>
</html>