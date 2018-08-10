<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body>
    <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
      <legend>
        会员卡
      </legend>
      <div id="dataform1" style="padding-top:5px;" class="form">
        <!-- hidden域 -->
        <input class="nui-hidden" id="card.id"/>
        <table style="width:100%;height:95%;table-layout:fixed;" class="nui-form-table" >
             
              <tr>
            <td class="form_label" >
              会员卡名称:
            </td>
            <td colspan="1" >
              <input class="nui-textbox" name="card.name"/>
            </td>
            </tr>
             
             
            <tr>
            <td class="form_label" >
              会员卡名称:
            </td>
            <td colspan="1" >
              <input class="nui-textbox" name="card.name"/>
            </td>

            <td class="form_label" >
              适用范围:
            </td>
            <td colspan="1"  >
              <input class="nui-combobox" data ="[{value:'1',text:'本店',},{value:'2',text:'连锁'}]" textField="text" valueField="value" name="card.useRange" />
            </td>
            
         <td class="form_label" >
              会员卡名称:
            </td>
            <td colspan="1" >
              <input class="nui-textbox" name="card.name"/>
            </td>
            </tr>
            
          <tr>
            <td class="form_label">
           充值金额:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="card.rechargeAmt"/>
            </td>
            <td class="form_label">
              赠送金额:
            </td>
            <td colspan="1">
              <input class="nui-textbox"  name="card.giveAmt"/>
            </td>
            <td class="form_label">
              赠送金额:
            </td>
            <td colspan="1">
              <input class="nui-textbox"  name="card.giveAmt"/>
            </td>   
          </tr>
         
  

           <tr>
            <td class="form_label">
             使用说明:
            </td>
            <td colspan="2">
            <input class="nui-TextArea" name="card.useRemark"     style="width:330px;height:50px;"/>

            </td>
            </tr>
            <tr>
            <td class="form_label">
           卡说明:
            </td>
            <td colspan="1">
            <input class="nui-TextArea" name="card.remark"  style="width:330px;height:50px;"/>
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
    <!-- 从表的修改 -->

    <script type="text/javascript">
      nui.parse();
      var form = new nui.Form("#dataform1");
      form.setChanged(false);

      function onOk(){
        saveData();
      }

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

      function saveData(){
        form.validate();
        if(form.isValid()==false) return;
        var data = form.getData(false,true);
        var json = nui.encode(data);//变成json格式
        $.ajax({
          url:"com.hsapi.repair.baseData.crud.syncCard.biz.ext",
          type:'POST',
          data:json,
          cache:false,
          contentType:'text/json',
          success:function(text){
            var returnJson = nui.decode(text);
            if(returnJson.exception == null){
              CloseWindow("saveSuccess");
            }else{
              nui.alert("保存失败", "系统提示", function(action){
                if(action == "ok" || action == "close"){
                  //CloseWindow("saveFailed");
                }
                });
              }
            }
            });
          }

          function onReset(){
            form.reset();
            form.setChanged(false);
          }



          function CloseWindow(action){
            if(action=="close"){

              }else if(window.CloseOwnerWindow)
              return window.CloseOwnerWindow(action);
              else
              return window.close();
            }
            
          function setData(data){
            //跨页面传递的数据对象，克隆后才可以安全使用
 				var data  = nui.clone(data);
    
   					 
              form.setData(data);
              form.setChanged(false);
            
          }
          
           function CloseWindow(action) {
            if (action == "close" && form.isChanged()) {
              if (confirm("数据被修改了，是否先保存？")) {
                saveData();
              }
            }
            if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
            else window.close();
          }
          </script>
        </body>
      </html>
