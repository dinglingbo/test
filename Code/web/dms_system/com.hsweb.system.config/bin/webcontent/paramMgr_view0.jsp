<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>

<head>
<title>参数设置</title>
<script src="<%=webPath + contextPath%>/config/js/paramMgr.js?v=1.0.5"></script>
</head>
<body>
	<div class="nui-fit">
		<div id="mainTabs" class="nui-tabs" name="mainTabs"
			activeIndex="0" 
			style="width:100%; height:100%;" 
			plain="false" >
			<div title="工单参数" id="comParamsTab" name="comParamsTab" url="" >
			</div> 
			<div title="业务分类" id="businessTypeTab" name="businessTypeTab" url="">
			</div>
			<div title="客户级别" id="guestTypeTab" name="guestTypeTab" url="">
			</div>
			<div title="客户来源" name="guestSourceTab" url="" >
			</div> 
			<div title="客户标签" name="guestTab" url="" >
			</div>  
			<div title="回访设置" name="visitTab" url="" >
			</div>  
			<div title="检查类型设置" name="checkTypeTab" url="" >
			</div> 
			<div title="查车模板设置" name="carCheckModelTab" url="" >
			</div> 
			<!--<div title="库存设置" name="stockTab" url="" >
			</div>  -->
			<div title="绩效设置" name="basicDeductTab" url="" visible="false">
			</div>
			<div title="提醒设置" name="remindTab" url="" >
			</div> 
			<div title="通用提成" name="tongyongticheng" url="" >
			</div> 
			<div title="工作组" name="workTeam" url="" >
			</div> 
			<div title="技师等级" name="x_makeAnAppointmentLocation" url="" >
			</div> 
			<div title="结算单模板设置" name="settlementTemplate" url="" > 
 			</div> 
 			<div title="其他" name="other" url="" > 
 			</div> 
 			
		</div>	
	</div>
</body>
</html>
	