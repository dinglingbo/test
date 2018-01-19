<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String validateID = ResourcesMessageUtil.getI18nResourceMessage("wsp_validate.id");
String allStatus = ResourcesMessageUtil.getI18nResourceMessage("processinst_query_jsp.status_all");
String selectBrowse = ResourcesMessageUtil.getI18nResourceMessage("catalog_common.select_browse");
 %>
<html>
<head>
<title><b:message key="processinst_query_jsp.process_instance_query"/></title>
<script language="javascript">
	function initiFrame(){
		var height = frameElement.parentNode.offsetHeight;
		if (isFF) { height -= 70; }
		frameElement.height = height;
		
		document.forms['processInstForm'].submit();
	}
	
	function clearQueryForm(){
		$name("queryCondition/_expr[1]/processDefID").value='';
		$name("queryCondition/_expr[2]/processInstID").value='';
		$name("queryCondition/_expr[3]/processInstName").value='';
		$name("queryCondition/_expr[4]/currentState").value='';
		$names("queryCondition/_expr[5]/isTimeOut")[0].checked = 'true';
		$name("queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID").value='';
		$name("showCatalogName").value='';
		$name("isIncludeSubCatalog").value='';
		$name("isIncludeSubCatalog").nextSibling.checked='';
		dataCatchPool = [];
	}
	function doSubmit(formObj){
		var processInstName = document.forms['processInstForm'].elements['queryCondition/_expr[3]/processInstName'].value;
		document.forms['processInstForm'].elements['queryCondition/_expr[3]/processInstName'].value = trim(processInstName);
		return true;
	}
</script>
</head>
<body onLoad="initiFrame()" topmargin="3" bottommargin="0" rightmargin="5" leftmargin="5" style="background:#EAF0F1;overflow: auto;">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td valign="top">
		<h:form name="processInstForm" action="com.primeton.workflow.manager.instance.getProcessInstList.flow?_eosFlowAction=queryProcessInstWithPage" method="post" target="processInstQueryResult" onsubmit="doSubmit(this)">
        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="processinst_query_jsp.query_cond"/></td>
          </tr>
          <tr>
            <td>            
   			  <h:hidden name="queryCondition/_orderby/_property" value="processInstID"/>
   			  <h:hidden name="queryCondition/_orderby/_sort" value="desc"/>        
              <h:hidden name="pageCond/begin" value="0"/>
              <h:hidden name="pageCond/length" value="10"/>
              <h:hidden name="pageCond/isCount" value="true"/>
     		  <h:hidden name="queryCondition/_entity" value="com.eos.workflow.data.WFProcessInst"/>
	     	  <h:hidden name="queryCondition/_expr[1]/processDefID" property="queryCondition/_expr[1]/processDefID"/>
              <table width="100%" class="form_table">
                <tr>
                  <td width="15%" class="form_label"><b:message key="processinst_query_jsp.process_instance_id"/><b:message key="wsp_punctuation.colon"/></td>
                  <td width="35%">
                  	<h:text name="queryCondition/_expr[2]/processInstID" property="queryCondition/_expr[2]/processInstID" styleClass="textbox" size="32" maxlength="18" validateAttr="type=integer;message=<%=validateID %>;allowNull=true"
								onblur="checkInput(this);" />
                  </td>
                  <td width="15%" class="form_label"><b:message key="processinst_query_jsp.process_instance_name"/><b:message key="wsp_punctuation.colon"/></td>
                  <td width="35%" >                                
                  	 <h:text name="queryCondition/_expr[3]/processInstName" property="queryCondition/_expr[3]/processInstName" styleClass="textbox" size="32" maxlength="200"/>                 
                  	 <h:hidden name="queryCondition/_expr[3]/_op" value="like"/>
                  	 <h:hidden name="queryCondition/_expr[3]/_likeRule" value="all"/>
                  </td>
                </tr>
                <tr>
                  <td class="form_label"><b:message key="processinst_query_jsp.status"/><b:message key="wsp_punctuation.colon"/></td>
                  <td>
                  	 <d:select  name="queryCondition/_expr[4]/currentState" property="queryCondition/_expr[4]/currentState"  styleClass="select" dictTypeId="WFDICT_ProcessState" nullLabel="<%=allStatus %>"/>                               
                  </td>
                  <td class="form_label"><b:message key="processinst_query_jsp.overtime"/><b:message key="wsp_punctuation.colon"/></td>
                  <td>
                  	 <d:radio name="queryCondition/_expr[5]/isTimeOut" property="queryCondition/_expr[5]/isTimeOut" dictTypeId="WFDICT_ProcessTimeoutType" value="" />
                  	 <!--<h:switchCheckbox name="queryCondition/_expr[5]/isTimeOut" checkedValue="Y" uncheckedValue="N"/>-->
                  </td>
                </tr>
                <tr>
                  <td class="form_label"><b:message key="catalog_common.biz_catalog"/><b:message key="wsp_punctuation.colon"/></td>
                  <td>
                  	 <input type="text" name="showCatalogName" value="" readonly="true" size="32">&nbsp;
                  	 <wf:selectBizCatalog name="select" value="<%=selectBrowse %>" maxNum="1" hiddenType="ID" hidden="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" form="processInstForm" output="showCatalogName" styleClass="button"/>
                  	 <l:present property="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID">
					 	<h:hidden name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID" property="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>	
					 </l:present>
					 <l:notPresent property="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID">
					 	<h:hidden name="queryCondition/_and[1]/_or[1]/_expr[1]/catalogUUID"/>	
					 </l:notPresent>
                  </td>
                  <td class="form_label"><b:message key="catalog_common.include_sub_catalog"/><b:message key="wsp_punctuation.colon"/></td>
                  <td>
                     <h:switchCheckbox name="isIncludeSubCatalog" checkedValue="true" uncheckedValue="false"/>
                  </td>
                </tr>
				<tr>
                  <td colspan="5" class="form_bottom">
                    <input type="submit" id="queryBtn" name="query" value="<b:message key="manager_common.query"/>" class="button">
                    <input type="button" id="resetBtn" name="reset" value="<b:message key="manager_common.clear"/>" class="button" onclick="clearQueryForm();">
                  </td>
         		</tr>
              </table>
            </td>
          </tr>
        </table>
        </h:form>
      </td>
    </tr>
    <tr height="330px">
      <td valign="top" align="center" style="padding-top:10px">
      <iframe width="100%" height="100%" marginHeight="0" scrolling="auto" frameBorder="0" marginWidth="0" name="processInstQueryResult" src=""></iframe>      
      </td>
    </tr>
  </table>
</body>
</html>