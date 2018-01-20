<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<%@ include file="/workflow/wfmanager/instance/common.jsp"%>
<script language="javascript">
function validate(){

	if(!document.forms['versionForm'].processDefID){
		alert('<b:message key="processversion_list_jsp.havenot_version_modify"/>');//当前无版本可更换
		return false;
	}
		
		
	if(document.forms['versionForm'].processDefID.length == undefined){
		if(document.forms['versionForm'].processDefID.checked){
			var processDefID=document.forms['versionForm'].processDefID.value;
			var longProcess=document.forms['versionForm'].longProcess.value;
  			if(longProcess=='N'){
  				alert('<b:message key="processversion_list_jsp.model_cannot_shortprocess"/>');//切换流程版本的目标模板不能是短流程
  				return false;
  			}
  			return processDefID;
		}
	}else{
		for(i = 0;i<document.forms['versionForm'].processDefID.length;i++){
		  	if(document.forms['versionForm'].processDefID[i].checked){
	  			var processDefID=document.forms['versionForm'].processDefID[i].value;
	  			var longProcess=document.forms['versionForm'].longProcess[i].value;
	  			if(longProcess=='N'){
	  				alert('<b:message key="processversion_list_jsp.model_cannot_shortprocess"/>');//切换流程版本的目标模板不能是短流程
	  				return false;
	  			}
	  			return processDefID;
			}
	  	}
	}
	alert('<b:message key="processversion_list_jsp.select_version"/>');//请先选中一条流程版本记录
	return false;
}

function doSubmit(){
	var targetProcessDefID = validate();
	
	if(targetProcessDefID){
		
		if(dialogArguments){
			window.returnValue = 'changeVersionSuccess';
			var actionName = '<b:write property="actionName"/>';
			var sourceProcessDefID = '<b:write property="processDefID"/>';
			if(actionName == 'changeVersionBatch'){
				var hs = new HideSubmit('com.primeton.workflow.manager.instance.ProcessInstanceManager.changeVersionBatch.biz');				
				hs.addParam('targetProcessDefID',targetProcessDefID);
				if(dialogArguments.length){
					for(i=0,k=1;i<dialogArguments.length;i++){
						if(dialogArguments[i].checked){
							hs.addParam('processInstIDS['+k+']',dialogArguments[i].value);
							k++;
						}
					}
				}else{
					hs.addParam('processInstIDS[1]',dialogArguments.value);
				}

				hs.submit();
			}else if(actionName == 'changeAllVersion'){
			    var hs = new HideSubmit('com.primeton.workflow.manager.instance.ProcessInstanceManager.changeAllProcessInstVersion.biz');
				hs.addParam('targetProcessDefID',targetProcessDefID);
				hs.addParam('sourceProcessDefID',sourceProcessDefID);
				hs.submit();
				
				var result;
				try{
					result = hs.getProperty("ret");
				}catch(e){}
				if(result){
					var s = '<b:message key="processversion_list_jsp.state_cannot_modify"/>';
					s = s.replace('{0}',result);
					alert(s);//流程实例['+result+']状态为完成或终止，不能更换版本
				}
			}
			
			if(ajaxIsSuccess==false){
					//alert('操作失败');
				return;
			}
			alert('<b:message key="processversion_list_jsp.operation_success"/>');//操作成功
			window.close();
		}
	}
	
}
</script>
</head>
<body  style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:scroll; overflow-y:auto; overflow-x: auto;" topmargin="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="EOS_panel_body" height="100%">
  <tr valign="top">
    <td width="100%">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="EOS_panel_body">
		<%--        <tr>
          <td class="EOS_panel_head" valign="top" nowrap="nowrap">流程定义所有版本列表</td>
        </tr>--%>
        <tr valign="top">
          <td width="100%"  valign="top">   
          	<form name="versionForm" action="" method="post">          	  
              <table id="table1" width="100%" border="0" cellpadding="0" cellspacing="0" class="EOS_table">
                <tr class="EOS_table_head">
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.operation"/></th><%-- 操作 --%>
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.proc_def_id"/></th><%-- 流程定义ID --%>
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.cn_name"/></th><%-- 中文名称 --%>
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.state"/></th><%-- 状态 --%>
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.version"/></th><%-- 版本号 --%>
                  <th width="12%" nowrap="nowrap"><b:message key="processversion_list_jsp.creator"/></th><%-- 创建者 --%>
                </tr>
                <l:present property="processDefList">
                <% int flag =0; String cls = "";%>
               	  <l:iterate id="list" property="processDefList">
               	  <%if(flag%2==0){cls="";}else{cls="EOS_table_row";}%>
                  <tr class="<%=cls %>" onmouseover='this.className="EOS_table_selectRow"' onmouseout='this.className="<%=cls %>"'>
                    <td nowrap="nowrap">
                      <l:notEqual iterateId="list" property="processDefID" targetValue="@processDefID">
	                      <h:radio iterateId="list" name="processDefID" property="processDefID"/>
	                      <h:hidden iterateId="list" name="longProcess" property="longProcess"/>    
                      </l:notEqual>                 
                    </td>
                    <td nowrap="nowrap">
                      <b:write iterateId="list" property="processDefID"/>
                    </td>
                    <td nowrap="nowrap">
                      <b:write iterateId="list" property="processChName"/>
                    </td>
                    <td nowrap="nowrap">
                      <d:write iterateId="list" property="currentState"  dictTypeId="WFDICT_ProcessDefState"/>
                    </td>
                    <td nowrap="nowrap">
                      <b:write iterateId="list" property="versionSign"/>
                      <h:hidden  iterateId="list" property="versionSign"/>
                    </td>
                    <td nowrap="nowrap">
                      <b:write iterateId="list" property="processDefOwner"/>
                    </td>
                  </tr>
                  	<%flag++;  %>
                </l:iterate>
                </l:present>
              </table>
            </form>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="30">
              <tr>
                <td align="left" >
                  <input name="btChangeVerson" type="button" class="button" value="<b:message key="processversion_list_jsp.modify"/>" onClick="doSubmit()"><%-- 更换 --%>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</html>
