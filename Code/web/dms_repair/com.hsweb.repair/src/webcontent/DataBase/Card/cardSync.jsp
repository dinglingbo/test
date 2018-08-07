<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
  <head>
    <title>
      会员卡录入录入
    </title>
    <script src="<%=request.getContextPath()%>/repair/js/Card/cardSysn.js?v=1.0.0"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body >
    <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
      <legend>
        会员卡
      </legend>
      <div id="dataform1" style="padding-top:5px;" >
        <!-- hidden域 -->
        <input class="nui-hidden" id="id"/>
        <table style="width:100%;height:95%;table-layout:fixed;" class="nui-form-table" >
        
                     <tr>
            <td class="form_label" style="width:17%">
              会员卡名称:
            </td>
            <td colspan="1" style="width:33%">
              <input class="nui-textbox" name="name"/>
              <input class="nui-hidden"name="id" readonly="readonly" />
            </td>


            <td class="form_label" style="width:14%">
              适用范围:
            </td>
            <td colspan="2"  style="width:36%">
              <input class="nui-combobox" data ="[{value:'0',text:'本店',},{value:'1',text:'连锁'}]" textField="text" valueField="value" name="useRange" value="0" />
            </td>
            </tr>
            
          <tr>
            <td class="form_label">
           充值金额:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="rechargeAmt" vtype="float" />
            </td>
            <td class="form_label">
              赠送金额:
            </td>
            <td colspan="2">
              <input class="nui-textbox"  name="giveAmt" vtype="float"/>
            </td>
          </tr>
          <tr>
           <tr>
                       <td class="form_label">
             套餐优惠率(%):
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="packageRate" vtype="range:0,100"/>
            </td>
            <td class="form_label">
             配件优惠率(%):
            </td>
            <td colspan="2">
              <input class="nui-textbox" name="partRate" vtype="range:0,100"/>
              
            </td>

          </tr>
          <tr>

            <td class="form_label">
              工时优惠率(%):
            </td>
            <td colspan="">
              <input class="nui-textbox" name="itemRate" vtype="range:0,100"/>
            </td>
                        <td class="form_label">
              有效期(月):
            </td>
            <td colspan="2">
              <input class="nui-textbox" name="periodValidity" vtype="float"/>
            </td>
          
            <td class="form_label">
          </tr>
          <tr>
            <td class="form_label">
              销售提成方式:
            </td>
            <td colspan="1">
            <input class="nui-combobox" data ="[{value:'0',text:'按原价比例',},{value:'1',text:'按折后价比例'},{value:'2',text:'按产值比例',},{value:'3',text:'固定金额'}]" 
            textField="text" valueField="value" name="salesDeductType"  value="0" onvalidation="updateError()" id="x"/>

            </td>
            <td class="form_label">
             销售提成值:
            </td>
            <td colspan="1" >
              <input class="nui-textbox" name="salesDeductValue" requiredErrorText="元" vtype="float"/>
              
            </td>
			 <td colspan="1" ><div style="display:none;" id="y" >&nbsp元</div><div style="display:block;" id="b" >&nbsp%</div></td> 
          </tr>
		<tr>
            </td>
                        <td class="form_label">
              是否允许修改金额:
            </td>
            <td colspan="1" >
		    
		    <div class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" name="canModify"
    textField="text" valueField="value"  data ="[{value:'0',text:'否',},{value:'1',text:'是'}]" value="0" >
</div>
		    
            </td>
			            <td class="form_label">
              状态:
            </td>
            <td colspan="2">
		    
		    <div class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" name="status"
    textField="text" valueField="value"  data ="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
</div>
		    
		</tr>

  

           <tr>
            <td class="form_label">
             使用条款:
            </td>
            <td colspan="2">
            <input class="nui-TextArea" name="useRemark"     style="width:330px;height:50px;"/>

            </td>
            </tr>
            <tr>
            <td class="form_label">
           卡说明:
            </td>
            <td colspan="1">
            <input class="nui-TextArea" name="remark"  style="width:330px;height:50px;"/>
            </td>
          </tr>
          <tr>
          	<td style="text-align:center;" colspan="4">
          		<a class="nui-button" iconCls="icon-save" onclick="onOk()">
                保存
                </a>
              <span style="display:inline-block;width:25px;">
          	</td>
          </tr>
        </table>
      </div>
    </fieldset>
  </body>
</html>
