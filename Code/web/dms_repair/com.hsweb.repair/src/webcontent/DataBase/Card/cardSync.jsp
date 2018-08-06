<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
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
    <!-- 从表的修改 -->

    <script type="text/javascript">
      nui.parse();
      var form = new nui.Form("#dataform1");
      form.setChanged(false);

	  	var requiredField = {
			name : "会员卡名称",
			rechargeAmt : "充值金额",
			giveAmt : "赠送金额",
			packageRate : "套餐优惠率",
			partRate : "配件优惠率",
			itemRate : "工时优惠率",
			periodValidity : "有效期",
			salesDeductValue : "提成值"
		};
      function onOk(){
      	var data = form.getData();
		for ( var key in requiredField) {
			if (!data[key] || $.trim(data[key]).length == 0) {
				showMsg(requiredField[key] + "不能为空!","W");
	
				return;
			}
		}
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
        //var json = nui.encode(data);//变成json格式
        var param = {
        	card:data
        }
        var json = nui.encode(param);
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
            var json = nui.clone(data);


            //如果是点击编辑类型页面
            if (json.id!=null) {
              form.setData(json);
              form.setChanged(false);
            }
          }
          

		  function updateError(e) {
            
		  
            if (nui.get('x').getValue()=="3") {
                document.getElementById('y').style.display='block';
                document.getElementById('b').style.display='none';
            }else{
            	document.getElementById('b').style.display='block';
            	document.getElementById('y').style.display='none';
            }
        }
 
        
          </script>
        </body>
      </html>
