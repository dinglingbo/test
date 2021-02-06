<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-03-01 10:35:44
  - Description:新增功能，弹出面板使用
-->
<head>
</head>
<body>
<div style="padding-top:5px">
	<div id="form1">
		<input id="appfuncbtn.resId" name="appfuncbtn.resId" class="nui-hidden" />
        <table style="width:100%;table-layout:fixed;" class="nui-form-table" >
            <tr>
                <th class="nui-form-label"><label for="appfuncbtn.name$text">按钮名称：</label></th>
                <td>    
                    <input id="appfuncbtn.name" name="appfuncbtn.name" class="nui-textbox nui-form-input" required="true"  vtype="rangeLength:1,50"/>
                </td>
                <th class="nui-form-label"><label for="appfuncbtn.code$text">按钮编码：</label></th>
                <td>    
                    <input id="appfuncbtn.code" name="appfuncbtn.code" class="nui-textbox nui-form-input" required="true"  vtype="rangeLength:1,100" onvalidation="codevalidation"/>
                </td>
            </tr>
            <tr class="odd">
                <th class="nui-form-label"><label for="appfuncbtn.btnArea$text">按钮区域：</label></th>
                <td>
                    <input id="appfuncbtn.btnArea" name="appfuncbtn.btnArea" class="nui-textbox nui-form-input" required="true"  vtype="rangeLength:1,50"/>
                </td>
            	<th class="nui-form-label"><label for="appfuncbtn.type$text">权限控制方式：</label></th>
                <td>
                	<input id="appfuncbtn.type" class="nui-combobox nui-form-input" name="appfuncbtn.type" value="0" 
                    valueField="dictID" textField="dictName" data="COF_YESORNO" />
                </td>
                </td>
            </tr>
            <tr class="odd">
                <th class="nui-form-label"><label for="appfuncbtn.btnUrl$text">接口地址：</label></th>
                <td colspan="3">
                	<input id="appfuncbtn.btnUrl" class="nui-textbox nui-form-input" onbuttonclick="onButtonEdit" name="appfuncbtn.btnUrl" 
                		onvalidation="" textName="test2" style="width:420px;"/>  
                </td>
            </tr>
            <tr class="odd">
                <th class="nui-form-label"><label for="appfunction.tagContent$text">DOM脚本：</label></th>
                <td colspan="3">     
                    <input id="appfuncbtn.tagContent" name="appfuncbtn.tagContent" class="nui-textarea nui-form-input" style="width:420px;height:100px;" />
                </td>
            </tr>
            <tr class="odd">
             	<th class="nui-form-label"><label for="appfuncbtn.displayorder$text">序号：</label></th>
                <td>    
                    <input id="appfuncbtn.displayorder" name="appfuncbtn.displayorder" class="nui-textbox nui-form-input" required="true"  vtype="int"/>
                </td>
                <th class="nui-form-label"><label for="appfuncbtn.btndesc$text">描述：</label></th>
                <td>    
                    <input id="appfuncbtn.btndesc" name="appfuncbtn.btndesc" class="nui-textbox nui-form-input" required="true"  vtype="rangeLength:1,200" onvalidation="codevalidation"/>
                </td>
            </tr>
        </table>
         <div style="padding-top:5px;padding-bottom:5px;">
	     </div>
        <div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
	        <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
	        <span style="display:inline-block;width:25px;"></span>
	        <a class="nui-button" style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
	    </div>          
    </div>
</div>
    <script type="text/javascript">
       	var COF_YESORNO =[{dictID:"0",dictName:"隐藏"},{dictID:"1",dictName:"删除"}];
    	var COF_APPTYPE =[{dictID:"0",dictName:"本地"},{dictID:"1",dictName:"远程"}];
    	var COF_FUNCTYPE =[{dictID:"flow",dictName:"页面流"},{dictID:"app",dictName:"APP"},{dictID:"form",dictName:"表单"},
    					{dictID:"order",dictName:"其他"},{dictID:"page",dictName:"页面"},{dictID:"startprocess",dictName:"启动流程"}];
        nui.parse();
        var form = new nui.Form("form1");  
        function onButtonEdit(){
	   		var btnEdit = this;
	    	nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/function/entrance_select.jsp",
                title: "选择功能调用入口", 
                width: 350, 
                height: 460,
                allowResize:false,
                ondestroy: function (action) {
                    //grid.reload();
                   if (action == "ok") {
                        var iframe = this.getIFrameEl();
                        var data = iframe.contentWindow.getData();
                        data = nui.clone(data);    //必须
                        if (data) {
                        	var url = data.resUrl;
                        	if(url.indexOf("/")!=0){
                        		url = "/"+url;
                        	}
                            btnEdit.setValue(url);
                            btnEdit.setText(url);
                            if(!data.resType=="startprocess"){
                             	var respara = nui.get("paraInfo");
                             	respara.setValue(data.resPara);
                            }
                            var restype = nui.get("resType");
                            restype.setValue(data.resType);
                        }
                    } 
                }
            });
	    }
        
        function SaveData() {
            var o = form.getData(true,true);            
			
            form.validate();
            if (form.isValid() == false) return;
            o.token = token;
			//"org.gocom.components.coframe.framework.FunctionManager.saveFunction.biz.ext",
            var json = nui.encode(o);
            $.ajax({
                url: apiPath + sysApi + "/com.hsapi.system.tenant.permissions.updateFuncbtn.biz.ext",
                type: 'POST',
                data: json,
                cache: false,
                contentType:'text/json',
                success: function (text) {
                    CloseWindow("ok");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }
        
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        
        function SetData(data) {
            //跨页面传递的数据对象，克隆后才可以安全使用
            data = nui.clone(data);
            document.getElementById("appfuncbtn.resId").value = data.resId;
        }
        
        function codevalidation(e){
            var re = new RegExp("^[A-Za-z0-9_]{0,63}$");
      		if (!re.test(e.value)){
            	e.errorText = "只能包含字母、数字、下划线";
            	e.isValid = false;
            	return;
      		}
        	if(e.isValid){
        		var data = {funccode:e.value};
        		var json = nui.encode({template:data,token:token});
	        	$.ajax({
                    url: apiPath + sysApi + "/com.hsapi.system.tenant.permissions.validateFunction.biz.ext",//"org.gocom.components.coframe.framework.FunctionManager.validateFunction.biz.ext",
                    type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
                    cache: false,
                    async:false,
                    success: function (text) {
                       var o = nui.decode(text);
                        if(o.data == "1"){
                        	e.errorText = "功能编码不唯一，请请重新填写";
	        				e.isValid = false;
                        }
                    }
	           });
        	}
        }
        function urlvalidation(e){
        	if(e.value == "") return;
        	if(e.isValid){
        		 if (e.value.substring(0,1) != "/") {
                    e.errorText = "必须以/开头";
                    e.isValid = false;
                }
        	}
        }        
    </script>
</body>
</html>