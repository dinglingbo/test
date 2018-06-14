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
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
      <script src="<%= request.getContextPath() %>/config/js/showSet.js?v=1.7.8"></script>
    
</head>
<body>
 <div  class="nui-form" id="showForm">
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="关怀提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示建档人为本人的提醒：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair_careAlarm_default_show"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="业务提醒默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair__service_default_show"/>
                </div>

     </div>
     <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="工作列表默认显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		     显示服务顾问为本人的工单：    <input  class="nui-checkbox" text="" value="0" trueValue="1" falseValue="0" name="repair__worklist_default_show"/>
                </div>

     </div>
          <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="默认仓库" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		
              		     默认仓库：           <input class="nui-combobox" id="defaultStore" name="defaultStore" value=""   width="70px"  textField="name" valueField="id"/>
              
                </div>

    	 </div>
    	 <div class="nui-col-6" style="margin-top: 2%;">
                
                <div class="nui-panel" title="结算单打印显示" width="80%" style="margin-left: 10%;" 
                    showCollapseButton="false" showCloseButton="false"  >
              		   结算单打印抬头显示：    <input  class="nui-textbox" name="repair__settorder_print_show"/>
                </div>

     	</div>
     	 <div style=" width: 100%;height: 10%;">
	 		<a class="nui-button" style="margin-top: 1.5%;  margin-right:10%;float: right;" onclick="showFormSet">保存</a>
	 
		 </div>
    </div>
    


	
</body>
</html>