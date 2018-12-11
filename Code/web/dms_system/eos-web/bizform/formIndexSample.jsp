<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/bizform/bizformCommon.jsp" %>
</head>
<body>

	<div id="dataform1" class="nui-form" style="padding-top:5px;">
        <!-- hidden域 -->
        <input class="nui-hidden" name="ooperator.oContacts" id="ooperator.oContacts"/>
        <input class="nui-hidden" name="ooperator.__type" value="sdo:com.primeton.nuisample.data.OOperator">
        <input class="nui-hidden" name="ooperator.operatorId" id="ooperator.operatorId" />
        <table style="width:100%;height:95%;table-layout:fixed;" class="nui-form-table">
          <tr>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.biaform.IdentityCard") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.userId" required="true"/>
            </td>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.Name") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.userName" required="true"/>
            </td>
          </tr>
          <tr>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.Birthday") %>:</td>
            <td colspan="1">
              <input class="nui-datepicker" name="ooperator.birthday"/>
            </td>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.Gender") %>:</td>
            <td colspan="1">
              <input class="nui-combobox" dictTypeId="gender" name="ooperator.gender"/>
            </td>
          </tr>
          <tr>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.PostalCode") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.postcode"/>
            </td>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.Address") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.address"/>
            </td>
          </tr>
          <tr>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.PhoneNumber") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.phone"/>
            </td>
            <td class="form_label"><%=I18nUtil.getMessage(request, "bps.bizform.EMail") %>:</td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.email"/>
            </td>
          </tr>
        </table>
      </div>
    </fieldset>
    <!-- 从表的修改 -->
    <div style="margin:0px 2px 0px 2px;" >
      <div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
        <div title="<%=I18nUtil.getMessage(request, "bps.bizform.Contacts") %>">
          <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
              <tr>
                <td style="width:100%;"><%=I18nUtil.getMessage(request, "bps.bizform.Contacts") %></td>
                <td >
                  <a class="nui-button " iconCls="icon-add" onclick="gridAddRow('grid_0')"  plain="true" tooltip="<%=I18nUtil.getMessage(request, "bps.bizform.Add") %>">
                    &nbsp;
                  </a>
                </td>
                <td >
                  <a class="nui-button " iconCls="icon-remove" onclick="gridRemoveRow('grid_0')"  plain="true" tooltip="<%=I18nUtil.getMessage(request, "bps.bizform.Remove") %>">
                    &nbsp;
                  </a>
                </td>
              </tr>
            </table>
          </div>
          <div id="grid_0" class="nui-datagrid" style="width:100%;height:150px;" showPager="false" sortMode="client" allowCellEdit="true" allowCellSelect="true" multiSelect="true" editNextOnEnterKey="true" >
            <div property="columns">
              <div type="checkcolumn">
              </div>
              <div field="contactName" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.Name") %><input class="nui-textbox" name="contactName" property="editor"/>
              </div>
              <div field="relation" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.Relation") %><input class="nui-textbox" name="relation" property="editor"/>
              </div>
              <div field="phone" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.PhoneNumber") %><input class="nui-textbox" name="phone" property="editor"/>
              </div>
              <div field="postcode" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.PostalCode") %><input class="nui-textbox" name="postcode" property="editor"/>
              </div>
              <div field="address" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.Address") %><input class="nui-textbox" name="address" property="editor"/>
              </div>
              <div field="email" allowSort="true" align="left" headerAlign="center" width=""><%=I18nUtil.getMessage(request, "bps.bizform.EMail") %><input class="nui-textbox" name="email" property="editor"/>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      nui.parse();
      
      var form = new nui.Form("#dataform1");
      form.setChanged(false);

      function gridAddRow(datagrid){
        var grid = nui.get(datagrid);
        grid.addRow({});
      }

      function gridRemoveRow(datagrid) {
        var grid = nui.get(datagrid);
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
          grid.removeRows(rows, true);
        }
      }

      function setGridData(datagrid,dataid){
        var grid = nui.get(datagrid);
        var grid_data = grid.getChanges();
        nui.get(dataid).setValue(grid_data);
      }

		
		/**
		* 页面初始化的时候会被调用
		* e.sender : button
		* e {
			workItemID:1
		}
		*/
		function initData(e){
			tfcToast.take("workItemID:"+e.workItemID);
		}
		
		/**
		* 提交之前
		* e.submit = true，则提交表单，否则不提交表单
		* 
		*/
		function beforeSubmit(e){
// 			e.submit = false;//e.submit = false;
			 form.validate();
	    	 e.submit = form.isValid();
	    	 
// 	    	 e.instance.data.customSaveFormDataBiz = "com.zizhu.test.userManager";
// 	    	 debugger;
		}
		
		/**
		* 返回需要提交的业务数据
		* 
		*/
		function getSubmitData(e){
			setGridData("grid_0","ooperator.oContacts");
	        var data = form.getData();
	        var entity = {
	        		entity: data.ooperator
	        };
	        return entity;
		}
		
		/**
		* 表单提交之后调用
		* 有可能需要返回业务数据主键
		* e.data = {
			pkID: 1,
			workItemID: 1,
			processInstID: 1
		}
		*/
		function afterSubmit(e){
			if(e.returnData.exception){
				tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.SubmitFail") %>");
				return;
			}
			//自动弹到第一个tab页
			var tab = bps.components.core.getFormTab();
			if(tab){
				
			}
			tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.SubmitSuccess") %>");
			bps.components.core.closeNuiWindowAlways("ok");
		}
		
		/**
		* 返回给上一个页面的数据
		*/
		function getData(){
			
		}
		
	</script>
</body>
</html>