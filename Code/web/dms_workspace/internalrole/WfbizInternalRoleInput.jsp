<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String msg1 = ResourcesMessageUtil.getI18nResourceMessage("wfbiz_internal_role_input_jsp.msg1");
String msg2 = ResourcesMessageUtil.getI18nResourceMessage("wfbiz_internal_role_input_jsp.msg2");
String msg3 = ResourcesMessageUtil.getI18nResourceMessage("wfbiz_internal_role_input_jsp.msg3");
%>

<%--
- Author(s): 李俊
- Date: 2010-03-19 15:02:04
- Description:
--%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <b:message key="wfbiz_internal_role_input_jsp.internal_role_input"/>
    </title>
  </head>
  <body>
    <e:datasource name="wfbizinternalrole" type="entity" path="com.primeton.bps.workspace.frame.internalrole.internalrole.WfbizInternalRole" />
    <h:form name="data_form" action="com.primeton.bps.workspace.frame.internalrole.WfbizInternalRoleMaintain.flow" method="post" >

      
      
      <l:equal property="_eosLastAccessAction" targetValue="update">
        <input type="hidden" name="_eosFlowAction" value="updateSubmit" >
      </l:equal>
      <l:equal property="_eosLastAccessAction" targetValue="insert">
        <input type="hidden" name="_eosFlowAction" value="insertSubmit" >
      </l:equal>
      <h:hiddendata property="criteria" />
      <h:hidden property="page/begin"/>
      <h:hidden property="page/length"/>
      <h:hidden property="page/isCount"/>
      <dataform id= "ef132833-6a7a-4593-8e2d-d6e9a4ef6d46">

        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="wfbiz_internal_role_input_jsp.internal_role_input"/></td>
          </tr>
          
          <tr>
            <td>

          <table align="center" border="0" width="100%" class="form_table">
            <tr>
              <td class="form_label">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_id"/>
              </td>
              
      <l:equal property="_eosLastAccessAction" targetValue="update">
              <td colspan="1" width="35%" >
                <h:hidden property="wfbizinternalrole/roleid" />
                <b:write property="wfbizinternalrole/roleid"  />
              </td>
      </l:equal>   
      
      
            <l:equal property="_eosLastAccessAction" targetValue="insert">
              <td colspan="1">
                <h:text property="wfbizinternalrole/roleid" validateAttr="maxLength=32;message=<%=msg1%>;minLength=1;allowNull=false"/>
              </td>
      </l:equal>                     
              

              <td class="form_label">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_name"/>
              </td>
              <td colspan="1">
                <h:text property="wfbizinternalrole/rolename" validateAttr="maxLength=32;message=<%=msg2%>;minLength=1;allowNull=false"/>
              </td>
            </tr>
            
             <tr>
              <td class="form_label">
                <b:message key="wfbiz_internal_role_input_jsp.desc"/>
              </td>
              <td colspan="3">
                <h:textarea property="wfbizinternalrole/roledesc"  rows="5" cols="50" validateAttr="maxLength=128;message=<%=msg3%>;allowNull=true"/>
              </td>
            </tr>
            
            <tr class="form_bottom">
              <td colspan="4">
              
            <l:equal property="_eosLastAccessAction" targetValue="insert">
                <input type="button" value='<b:message key="permission_common.btn_save"/>' class="button" onclick="saveRole();" >
              </l:equal>    
                
            <l:equal property="_eosLastAccessAction" targetValue="update">
                <input type="submit" value='<b:message key="permission_common.btn_edit"/>' class="button"  >
              </l:equal>  
                
                
                <input type="button" value='<b:message key="permission_common.btn_back"/>' onclick="javascript:history.go(-1);" class="button">
              </td>
            </tr>
          </table>
            </td>
          </tr>
        </table>
      </dataform>
    </h:form>
  </body>
 <script>
 
 function saveRole(){
 
 			var frm = $name("data_form");
 
	            var myAjax = new Ajax("com.primeton.bps.workspace.frame.internalrole.wfbizinternalrolebiz.querRoleCount.biz");
	
	             myAjax.submitForm(frm); 
	             
	
	            var id_flag =myAjax.getValue("root/data/id_flag");
	            
	            var name_flag =myAjax.getValue("root/data/name_flag");
	            
	            
	            if(checkForm(frm)){
	            
	            		if(id_flag == "0" & name_flag == "0"){
		            
		            		frm.submit();
		            
		           		 }else if(id_flag != "0"){
		             
		               		alert('<b:message key="wfbiz_internal_role_input_jsp.role_id_exist"/>');
		               		return false;
		                 }else if(name_flag != "0"){
		             
		               		alert('<b:message key="wfbiz_internal_role_input_jsp.role_name_exist"/>');
		               		return false;
		                 }
	            
	            	            	
	            }else{	            		               
		                
		                return false;
		            
		            }
	        }
	        
	        
	            
 </script> 
  

  
</html>













