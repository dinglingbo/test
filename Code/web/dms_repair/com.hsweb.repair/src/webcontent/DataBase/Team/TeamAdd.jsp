<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 15:07:01
  - Description:
-->
<head>
<title>新增班组</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<fieldset
		style="width: 95%; height: 110px; border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;"">
		<div id="dataform1" style="padding-top: 5px;">
			<!-- 隐藏区域 -->
			<!-- <input class="nui-hidden" name="rpbclass.rpbClassMembers" id="rpbclass.rpbClassMembers"/>
	    	<input class="nui-hidden" name="rpbclass." id="types.rpbClassMembers"/> -->

			<span style="width: 80px; height: 38px; display: inline-block;">维修工种：</span>
			<input class="nui-combobox" name="rpbclass.type" width="240px" /> <span
				style="width: 80px; height: 38px; display: inline-block;">班组名称：</span>
			<input class="nui-combobox" name="rpbclass.name" width="240px" /> <span
				style="width: 80px; height: 38px; display: inline-block;">班组长名称：</span>
			<input class="nui-textbox" name="rpbclass.captainName" width="240px" />

		</div>

	</fieldset>


	<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align: center;" colspan="4"><a
					class="nui-button" iconCls="icon-save" onclick="onOk()"
					id="save_btn">保存（s）</a> <span
					style="display: inline-block; width: 25px;"> </span> <a
					class="nui-button" iconCls="icon-cancel" onclick="onCancel"
					iconCls="icon-cancel">取消（c）</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");
        form.setChanged(false);
    	
    	
    	function onOk(){
                saveData();
        }
    	
    	
    	function setGridData(datagrid,dataid){
    	    var grid = nui.get(datagrid);
            var grid_data = grid.getChanges();//getChanges ( state, onlyField )：获取增加、删除、修改后的数据集合
    	    									//state: added|modified|removed。如传递null，则获取增删改数据。
												//onlyField：Boolean。传递true，modified的行数据将只返回修改的字段。
    	    nui.get(dataid).setValue(grid_data);
    	}
    	//存数据
    	function saveData(){
    	    form.validate();//验证表单：validate（）
    	    if(form.isValid()==false) return;//isValid（）:表单是否验证通过
    	    setGridData("dataform1","rpbclass.rpbClassMembers");    
    	    var data = form.getData(false, true);//getData（formatter, deep）:获取表单数据
    	    									//formatter：Boolean。默认false。设置true，获取的日期格式是"2010-11-12"字符串。
												//deep：Boolean。默认true，数据为{user:{name:"111"}}；设置false，数据为{"user.name": "111"}。
    	    var json = nui.encode(data);
    	    
    	    $.ajax({
    	    	url:"com.hsapi.repair.team.TeamAdd.biz.ext",
    	    	type:'POST',
    	    	data:json,
    	    	cache:false,//是否缓存结果
    	    	contentType:"text/json",
    	    	success:function(text){
    	    	    var returnJson = nui.decode(text);
    	    	    if(returnJson.exception == null){
    	    	        CloseWindow("savaSuccess");
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
    	function onCancel(){
    	     CloseWindow("cancel");
    	}
    	
    	function onReset(){
    	    form.reset();
    	    form.setChanged(false);
    	}
    	function CloseWindow(action){
    	    if(action == "close"){
    	    
    	    }else if(window.CloseOwnerWindow)return window.CloseOwnerWindow(action);
    	    else return window.close();
    	}
    	function onCancel(){
    	    CloseWindow("cancel");
    	}
    	
	    </script>
</body>
</html>