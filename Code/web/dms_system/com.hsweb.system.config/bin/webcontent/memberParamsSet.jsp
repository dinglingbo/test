<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:49:36
  - Description:
-->
<head>
<title>员工参数设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/config/js/memberParamsSet.js?v=1.0.0"></script>
    
</head>
<body>
 <div  class="nui-form" id="showForm">
     <input visible="false" id="empid" class="nui-textbox" name="empid"/>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
                           显示建档人为本人的提醒：    
                           <input id="displayRemindTag"  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="displayRemindTag"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="业务提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
                           显示服务顾问为本人的工单：    
                           <input id="displayBusinessTag"  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="displayBusinessTag"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="工作列表默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
                           显示服务顾问为本人的工单：    
                           <input id="displayBillTag" class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="displayBillTag"/>
                </div>

     </div>
 	 <div style=" width: 100%;height: 10%;">
 		<a class="nui-button" style="margin-top: 1.5%;  margin-right:10%;float: right;" onclick="save()">保存</a>
 
	 </div>
    </div>
    


	
</body>
</html>