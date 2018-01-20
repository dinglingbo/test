<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%--
- Author(s): 李俊
- Date: 2010-03-19 15:02:03
- Description:
--%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>
      <b:message key="wfbiz_internal_role_query_jsp.internal_role_main"/>
    </title>
  </head>
  <body>
    <e:datasource name="criteria" type="entity" path="com.primeton.das.criteria.criteriaType" />
    <e:datasource name="page" type="entity" path="com.eos.foundation.PageCond" />
    <e:datasource name="wfbizinternalroles" type="entity" path="com.primeton.bps.workspace.frame.internalrole.internalrole.WfbizInternalRole" />
    <queryform id= "c48ccce5-90df-4b13-8a46-34c4cda2ef1d">
      <h:form  name="query_form" action="com.primeton.bps.workspace.frame.internalrole.WfbizInternalRoleMaintain.flow" checkType="blur" target="_self" method="post" onsubmit="return checkForm(this);">
        <input type="hidden" name="_eosFlowAction" value="pageQuery"/>

        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="wfbiz_internal_role_query_jsp.query_condition"/></td>
          </tr>
          
          <tr>
            <td>
          
          <table align="center" border="0" width="100%" class="form_table">
            <tr>
              <td class="form_label" valign="middle">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_id"/>
              </td>
              <td colspan="1">
                <h:text property="criteria/_expr[1]/roleid"/>
                <h:hidden property="criteria/_expr[1]/_op" value="like"/>
                <h:hidden property="criteria/_expr[1]/_likeRule" value="all"/>
              </td>
              
              <td class="form_label" valign="middle">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_name"/>
              </td>
              <td colspan="1">
                <h:text property="criteria/_expr[2]/rolename"/>
                <h:hidden property="criteria/_expr[2]/_op" value="like"/>
                <h:hidden property="criteria/_expr[2]/_likeRule" value="all"/>
              </td>
            </tr>

            <tr class="form_bottom">
              <td colspan="4" class="form_bottom">
                <input type="hidden" name="criteria/_entity" value="com.primeton.bps.workspace.frame.internalrole.internalrole.WfbizInternalRole">
                <b:message key="wfbiz_internal_role_query_jsp.every_page_display"/>
                <h:text size="2" property="page/length" value="10" validateAttr="minValue=1;maxValue=100;type=integer;isNull=true" />
                <input type="hidden" name="page/begin" value="0">
                <input type="hidden" name="page/isCount" value="true">
                <input type="submit" value='<b:message key="permission_common.btn_query"/>' class="button">
              </td>
            </tr>
          </table>
          
            </td>
          </tr>
        </table>

      </h:form>
    </queryform>
    <br/>
    <viewlist id= "58676a21-eb36-4223-b901-7fb8ae79b5d2">
      <h:form name="page_form" action="com.primeton.bps.workspace.frame.internalrole.WfbizInternalRoleMaintain.flow" method="post">
        <input type="hidden" name="_eosFlowAction" value="pageQuery" >
        <h:hiddendata property="criteria" />
        <h:hidden property="page/begin"/>
        <h:hidden property="page/length"/>
        <h:hidden property="page/count"/>
        <h:hidden property="page/isCount"/>
       
        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="wfbiz_internal_role_query_jsp.internal_role_result_list"/></td>
          </tr>
          
          <tr>
            <td>
       
          <table align="center" border="0" width="100%" class="EOS_table">
            <tr>
              <th width="5%" align="center">
                <b:message key="permission_common.select"/>
              </th>
                            <th width="25%">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_id"/>
              </th>
              <th width="25%">
                <b:message key="wfbiz_internal_role_input_jsp.internal_role_name"/>
              </th>
              <th width="40%">
                <b:message key="wfbiz_internal_role_input_jsp.desc"/>
              </th>
            </tr>
            <w:checkGroup id="group1">
              <l:iterate property="wfbizinternalroles" id="id1">
                <tr class="<l:output evenOutput='EOS_table_row' />">
                  <td align="center">
                    <w:rowCheckbox>
                      <h:param name='select_objs/roleid' iterateId='id1' property='roleid' indexed='true' />
                    </w:rowCheckbox>
                  </td>
                                    <td>
                    <b:write iterateId="id1" property="roleid"/>
                  </td>
                  <td>
                    <b:write iterateId="id1" property="rolename"/>
                  </td>
                  <td>
                    <b:write iterateId="id1" property="roledesc"/>
                  </td>
                </tr>
              </l:iterate>
            </w:checkGroup>
         		</table>
         		
         				<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="30">   
            
            <tr>
              <td align="left" nowrap="nowrap" >
                <input type="button" value='<b:message key="permission_common.btn_add"/>' onclick="addRecord();" class="button">
                <l:greaterThan property="page/size" targetValue="0" compareType="number">
                  <input type="button" value='<b:message key="permission_common.btn_edit"/>' onclick="updateRecord();" class="button">
                </l:greaterThan>
                <l:greaterThan property="page/size" targetValue="0" compareType="number">
                  <input type="button" value='<b:message key="permission_common.btn_del"/>' onclick="deleteRecord();" class="button">
                </l:greaterThan>
                </td>
                
                
                <td align="right" nowrap="nowrap">
                  <l:equal property="page/isCount" targetValue="true">
                    <b:message key="permission_common.page_info1"/>
                    <b:write property="page/count"/>
                    <b:message key="permission_common.page_info2"/>
                    <b:write property="page/currentPage"/>
                    <b:message key="permission_common.page_info3"/>
                    <b:write property="page/totalPage"/>
                    <b:message key="permission_common.page_info4"/>
                  </l:equal>
                  <l:equal property="page/isCount" targetValue="false">
                    <b:message key="permission_common.page_info5"/>
                    <b:write property="page/currentPage"/>
                    <b:message key="permission_common.page_info6"/>
                  </l:equal>
                  <input type="button" onclick="firstPage('page', 'pageQuery', null, null, 'page_form');" value='<b:message key="permission_common.btn_first"/>'  <l:equal property="page/isFirst" targetValue="true">disabled</l:equal> >
                  <input type="button" onclick="prevPage('page', 'pageQuery', null, null, 'page_form');" value='<b:message key="permission_common.btn_prev"/>' <l:equal property="page/isFirst" targetValue="true">disabled</l:equal> >
                  <input type="button" onclick="nextPage('page', 'pageQuery', null, null, 'page_form');" value='<b:message key="permission_common.btn_next"/>' <l:equal property="page/isLast" targetValue="true">disabled</l:equal> >
                  <l:equal property="page/isCount" targetValue="true">
                    <input type="button" onclick="lastPage('page', 'pageQuery', null, null, 'page_form');" value='<b:message key="permission_common.btn_last"/>' <l:equal property="page/isLast" targetValue="true">disabled</l:equal> >
                  </l:equal>
                
              </td>
            </tr>

          </table>
            </td>
          </tr>
        </table>
      </h:form>
    </viewlist>
    <script>
      function updateRecord()
      {
        var g = $id("group1");
        var frm = $name("page_form");
        if (g.getSelectLength() != 1) {
          alert('<b:message key="wfbiz_internal_role_query_jsp.select_tip1"/>');
          return;
        }
        frm.elements["_eosFlowAction"].value = "update";
        frm.submit();
      }
      function addRecord()
      {
        var frm = $name("page_form");
        frm.elements["_eosFlowAction"].value = "insert";
        frm.submit();
      }
      function deleteRecord()
      {
        var g = $id("group1");
        var frm = $name("page_form");
        if (g.getSelectLength() < 1) {
          alert('<b:message key="wfbiz_internal_role_query_jsp.select_tip2"/>');
          return;
        }
        frm.elements["_eosFlowAction"].value = "delete";
        frm.submit();
      }
    </script>
  </body>
</html>
