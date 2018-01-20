<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/new-activity-api.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/i18n/message.js" i18n="true"/>
	<title></title>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;overflow: auto;" onload="sizeDialog()">
<form name="startActForm">
   <table id="tLayout"width="100%" border="0" cellpadding="0" cellspacing="0" class="workarea">
   	<tr>
		<td colspan="3" class="workarea_title" valign="middle">
			<font color="#000033" class="title_font"><b:message key="edit_process_info_jsp.routerActDetails"/></font><!-- 路由活动详细信息 -->
		</td>
	</tr> 
	<tr>
	 <td width="100" valign="top" style="padding-top:8px;padding-left:5px;">
	  	 <div>
	  	 	<label><b:message key="edit_finishact_info_jsp.setOption"/></label><!-- 设置选项 -->
	  	 </div>
	  	 <div>
			 <select name="proItem" multiple="multiple" size="16" style="width:100px;">
				<option value="basedInfo"><b:message key=""/></option><!-- 基本信息 -->
			 </select>
		 </div>
	  </td>
	  <td width="10px" style="repeat-y 50%;"></td>
		<td valign="top" style="padding-top:10px;"> 
	  		<div id="basedInfo">
	  				<fieldset>
	  						<legend><b:message key="edit_finishact_info_jsp.basicInfo"/></legend><!-- 基本属性 -->
	  						<div>
	  								<label for="activityId"><b:message key="edit_finishact_info_jsp.activityID"/></label><!-- 活动ID -->
	  								<div style="display:inline;padding-left:14px">
	  									<input type="text" id="activityId" name="activityId" size="60" readonly>
	  								</div>
	  						</div>
	  						<div>
	  								<label for="activityName"><b:message key="edit_finishact_info_jsp.activityName"/></label><!-- 活动名称 -->
	  								<input type="text" id="activityName" name="activityName" size="60">
	  						</div>
	  						<div>
	  								<label for="splitType"><b:message key="edit_process_info_jsp.branch_mode"/></label><!-- 分支模式 -->
	  								<select id="splitType" name="splitType">
	  										<option value="AND"><b:message key="edit_autoact_info_jsp.all_branch"/></option><!-- 全部分支 -->
	  										<option value="XOR"><b:message key="edit_autoact_info_jsp.single_branch"/></option><!-- 单一分支 -->
	  										<option value="OR"><b:message key="edit_autoact_info_jsp.multi_branch"/></option><!-- 多路分支 -->
	  								</select>
	  								<div style="display:inline;padding-left:90px">
	  										<label for="joinType"><b:message key=""/></label><!-- 聚合模式 -->
	  										<select id="joinType" name="joinType">
	  												<option value="AND"><b:message key=""/></option><!-- 全部聚合 -->
			  										<option value="XOR"><b:message key=""/></option><!-- 单一聚合 -->
			  										<option value="OR"><b:message key=""/></option><!-- 多路聚合 -->
	  										</select>
	  								</div>
	  						</div>
	  						<%--<div>
	  								<label for="priority">优先级</label>
	  								<div style="display:inline;padding-left:12px">
	  									<select id="priority" name="priority">
						 		 			<option value="30">极低</option>
						 		 			<option value="40">低</option>
						 		 			<option value="50">次中</option>
						 		 			<option value="60">中</option>
						 		 			<option value="70">次高</option>
						 		 			<option value="80">高</option>
						 		 		</select>
						 		 	</div>
	  						</div>--%>
	  						<div>
	  								<label for="description"><b:message key=""/></label><!-- 描述 -->
	  								<div style="display:inline;padding-left:25px">
	  									<textarea id="description" name="description" style="width:360px" cols="60" rows="6" onMouseMove="textCounter(this,200);" onkeydown="textCounter(this,200);" onkeyup="textCounter(this,200);"></textarea>
	  								</div>
	  						</div>
	  				</fieldset>
	  		</div>
	  		<div style="position:relative;display:block;padding-top:20px;padding-bottom:5px">
		            <button class="button" id="activityOK"><b:message key=""/></button><!-- 确定 -->
		            <button class="button" id="activityCancel"><b:message key=""/></button><!-- 取消 -->
			</div>
	  </td>
	</tr>
</table> 
</form>
 
	 <jsp:include flush="true" page="/workflow/wfmanager/definition/processdef_detail/edit_common.jsp"></jsp:include>
		<script>
 				routeActivity.renderRouteActivity(actJson.activity);
				//alert(actJson.toJSONString()) ;
		</script>
</body>
</html>