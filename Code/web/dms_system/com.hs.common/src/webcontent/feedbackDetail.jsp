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
    <script src="<%=webPath + contextPath%>/common/js/feedbackList.js?v=1.0.4" type="text/javascript"></script>    
    
</head>
 <style type="text/css"> 
   a.optbtn {
        width: 60px; 
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
		<span>用户信息：</span>
		<table id="form" style="width:100%;">
			<tr>
				<td class="title required">
                    <label>手机号：</label>
                </td>
                <td class="" ><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
                <td class="title required">
                    <label>用户名：</label>
                </td>
                <td class="" ><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
                <td class="title required">
                    <label>公司：</label>
                </td>
                <td class="" ><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
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
               url="">
              <div property="columns">
              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
                <div field="recordMobile" name="recordMobile" width="30" align="center"  visible="true" headerAlign="center" header="手机号"></div>
                <div field="recorder" name="recorder" width="30" align="center"  visible="true" headerAlign="center" header="姓名"></div>
                <div field="orgname" name="orgname" width="" align="center"  headerAlign="center" header="公司"></div>
                <div field="questionType" name="questionType" width="" align="center"  headerAlign="center" header="问题摘要"></div>
                <div field="recordDate" name="recordDate" width="" align="center"  headerAlign="center" header="反馈时间" dateFormat="yyyy-MM-dd"></div>
                <div field="questionSource" name="questionSource" width="" align="center"  headerAlign="center" header="来源"></div>
                <div field="status" name="status" width="" align="center"  headerAlign="center" header="状态"></div>
              </div>
          </div>
    </div>	
</body>
</html>