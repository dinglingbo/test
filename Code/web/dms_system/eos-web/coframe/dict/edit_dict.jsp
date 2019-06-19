<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): 陈鹏
  - Date: 2013-12-14 14:48:59
  - Description:
-->
<body>
<div class="nui-fit" style="padding-top:5px;">
	<form id="dict_form" method="post">	
		<input class="nui-hidden" name="status"/>
		<input class="nui-hidden" name="id"/>
		<input class="nui-hidden" name="seqno"/>
		<input class="nui-hidden" name="action"/>
		<table class="nui-form-table" style="width:100%;height:100%;table-layout:fixed;">
		<tr>
			<th class="nui-form-label"><label for="parentid$text">上级字典项代码：</label></th>
			<td><input id="parentid" name="parentid" class="nui-textbox nui-form-input" readonly="true"/></td>
		</tr>
		<tr class="odd">
			<th class="nui-form-label"><label for="dicttypeid$text">类型代码：</label></th>
			<td>
				<input id="dicttypeid" name="dictid" vtype="maxLength:128" required="true" class="nui-combobox nui-form-input"
					textField="name" valueField="id" emptyText="请选择" allowInput="false"/>
			</td>
		</tr>
		<tr>
			<th class="nui-form-label"><label for="dictid$text">字典项代码：</label></th>
			<td><input id="dictid" name="customid" vtype="maxLength:128" required="true" class="nui-textbox nui-form-input"/></td>
		</tr>
		<tr class="odd">
			<th class="nui-form-label"><label for="dictname$text">字典项名称：</label></th>
			<td><input id="dictname" name="name" vtype="maxLength:255" required="true" class="nui-textbox nui-form-input"/></td>
		</tr>
		<tr>
			<th class="nui-form-label"><label for="sortno$text">是否有效：</label></th>
			<td>
                <input id="isDisabled" name="isDisabled" vtype="maxLength:128" required="true" class="nui-combobox nui-form-input"
					textField="text" valueField="value" data="const_enabled" emptyText="请选择" allowInput="false"/>
            </td>
		</tr>
		<tr>
			<th class="nui-form-label"><label for="">属性值1：</label></th>
			<td><input id="property1" name="property1" class="nui-textbox nui-form-input"/></td>
		</tr>
		<tr>
			<th class="nui-form-label"><label for="">属性值2：</label></th>
			<td><input id="property2" name="property2" class="nui-textbox nui-form-input"/></td>
		</tr>
		<tr>
			<th class="nui-form-label"><label for="">属性值3：</label></th>
			<td><input id="property3" name="property3" class="nui-textbox nui-form-input"/></td>
		</tr>
		</table>
	</form>
</div>
<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" borderStyle="border:0;">
    <a class="nui-button" iconCls="icon-save" onclick="saveForm();">保存</a>
    <span style="display:inline-block;width:25px;"></span>
    <a class="nui-button" iconCls="icon-close" onclick="closeWindow('cancel');">关闭</a>
</div>
</body>
</html>

<script type="text/javascript">
	nui.parse();
	
	var form = new nui.Form("dict_form");

	function loadForm(data) {
		data = nui.clone(data);
		/*if(data.parentdicttypeid != null){
			$.ajax({
				url: "org.gocom.components.coframe.dict.DictManager.queryDictType.biz.ext",
				type: 'post',
				data: nui.encode({dicttypeid:data.parentdicttypeid}),
				cache: false,
				contentType:'text/json',
				success: function (json) {
					nui.get("dicttypeid").load(json.data);
				}
			});
            
		}
		else{
			nui.get("dicttypeid").load([{dicttypeid:data.eosDictType.dicttypeid, dicttypename:data.eosDictType.dicttypename}]);
			nui.get("dicttypeid").setReadOnly(true);
		}*/
        nui.get("dicttypeid").setData([data.eosDictType]);
        form.setData(data);
        //alert(data.eosDictType.id);
        //alert(data.id);
		form.setChanged(false);
		
		if(data.action == 'edit'){
			nui.get('dictid').setReadOnly(true);
		}
	}
	
	function saveForm() {
		form.validate();
		if (form.isValid() == false) return;

		nui.ajax({
			//url: "org.gocom.components.coframe.dict.DictManager.saveDict.biz.ext",
            url: apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDict.biz.ext",
			type: 'post',
			data: nui.encode({data:form.getData()}),
			cache: false,
			contentType:'text/json',
			success: function (json) {
				if(json.errCode == 'S'){
					closeWindow('ok');
				}
				else if(json.status == 'exist') nui.alert("记录已存在！");
				else nui.alert("保存失败！");
				
			},
			error: function (jqXHR, textStatus, errorThrown) {
				nui.alert("保存失败！");
				closeWindow('ok');
			}
		});
	}
    
	function closeWindow(action) {            
		if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		else window.close();
	}

</script>