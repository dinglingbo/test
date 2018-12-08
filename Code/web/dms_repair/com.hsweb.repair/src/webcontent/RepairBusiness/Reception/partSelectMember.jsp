<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator 
  - Date: 2018-01-25 14:17:08
  - Description:  
--> 

<head> 
  <title>选择领料人</title>  
  <style type="text/css">

  .tbtext{
      float: right;
  }
  .tbCtrl{
    width: 350px;
}
</style>

</head>

<body>
    
	 <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;确定</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
    <div style="height: 10px;"></div>
    <table id="table1"  style=" left:0;right:0;margin: 0 auto;"> 

        <tr>
            <td class="tbtext">归库人：</td>
            <td class="tbCtrl" >
                <input class="nui-textbox" name="ftype" id="ftype" value='<b:write property="ftype"/>'  visible="false"/>
                <input class="nui-hidden" name="mtAdvisor" id="mtAdvisor"/>
                <input name="mtAdvisorId"
                id="mtAdvisorId"
                style="width:100%"
                class="nui-combobox width1"
                textField="empName"
                valueField="empId" 
                emptyText="请选择..."
                required="true"
                url=""
                allowInput="true"
                showNullItem="false" 
                valueFromSelect="true"
                nullItemText="请选择..."/>

            </td>
        </tr> 
        <tr>
            <td style="height: 10px;"></td>
        </tr> 
        <tr>
            <td class="tbtext">备注:</td>
            <td class="tbCtrl">
                <input class="nui-textarea tabwidth" name="remark" id="remark" style="width:100%;height: 100px;"/>
            </td>

        </tr> 
    </table>
<!--     <div align="center" style="margin-top:45px;"> -->
<!--         <a class="nui-button" iconCls="" plain="false" onclick="onOk"> -->
<!--             <span class="fa fa-check fa-lg"></span>&nbsp;确定 -->
<!--         </a> -->
<!--         <a class="nui-button" iconCls="" plain="false" onclick="onCancel" style="margin-left: 20px;"> -->
<!--             <span class="fa fa-remove fa-lg"></span>&nbsp;取消 -->
<!--         </a> -->
<!--     </div>  -->
    <script type="text/javascript">
        nui.parse();
        var form = null;
        var mtAdvisorIdEl = null;
        $(document).ready(function(v) {
			form = new nui.Form("#table1");
			mtAdvisorIdEl = nui.get("mtAdvisorId");
		
			initMember("mtAdvisorId",function(){
	            memList = mtAdvisorIdEl.getData();
				mtAdvisorIdEl.setValue(currEmpId);
    			mtAdvisorIdEl.setText(currUserName);
	        });
	
			mtAdvisorIdEl.on("valueChanged",function(e){
	            var text = mtAdvisorIdEl.getText();
	            nui.get("mtAdvisor").setValue(text);
	        });
	        document.onkeyup = function(event) {
		        var e = event || window.event;
		        var keyCode = e.keyCode || e.which;// 38向上 40向下
		        
		
		        if ((keyCode == 27)) { // ESC
					onCancel();
		        }
		
		    }
		});

        

        function SetData(ftype){
            nui.get("ftype").setValue(ftype);
       	    mtAdvisorIdEl.setValue(currEmpId);
    		mtAdvisorIdEl.setText(currUserName);
    		nui.get("mtAdvisor").setValue(currUserName);
    		nui.get('remark').focus();
        }

        function onOk(){ 
            form.validate();
            if (form.isValid() == false) {
                showMsg("请先选择领料人！","W");
                return;
            }
            nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '数据处理中...'
	        });
        
            closeWindow("ok");
        }

        function GetFormData(){
            var data = form.getData();
            return data;
        }

        function onCancel() {
            closeWindow("no");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>

</body>

</html>