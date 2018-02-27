<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 15:07:14
  - Description:
-->
<head>
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<fieldset
		style="width: 95%; height: 110px; border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;"">
		<div id="dataform1" style="padding-top: 5px;">
			<!-- 隐藏区域 -->
			<input class="nui-hidden" name="rpbclass.rpbClassMembers"
				id="rpbclass.rpbClassMembers" />
			<!-- <input class="nui-hidden" name="rpbclass." id="types.rpbClassMembers"/> -->

			<span style="width: 80px; height: 38px; display: inline-block;">维修工种：</span>
			<input class="nui-textbox" name="rpbclass.type" width="240px" /> <span
				style="width: 80px; height: 38px; display: inline-block;">班组名称：</span>
			<input class="nui-textbox" name="rpbclass.name" width="240px" /> <span
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
    	nnui.parse();
            var form = new nui.Form("#dataform1");
            var tab = nui.get("tab");
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
            function gridReload(datagrid){
                var grid = nui.get(datagrid);
                grid.reload();
            }

            function setGridData(datagrid,dataid){
                var grid = nui.get(datagrid);
                var grid_data = grid.getData();
                nui.get(dataid).setValue(grid_data);
            }
            
            
            function setData(data){
                data = nui.clone(data);
                nui.get("grid_0").load({types:data});
                var json = nui.encode({types:data});
                $.ajax({
                    url:"com.primeton.hw.lookup_type.lookup_get.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                   
                        obj = nui.decode(text);
                        form.setData(obj);
                        
                        //zzc
                        var span=nui.get('isSys2');
                        var lookupTypeCode = nui.get("lookupTypeCode");
						var lookupTypeName = nui.get("lookupTypeName");
						var lookupTypeRemark = nui.get("lookupTypeRemark");
						var isSys2 = nui.get("isSys2");
						var add_btn = nui.get("add_btn");
						var delete_btn = nui.get("delete_btn");
						var save_btn = nui.get("save_btn");
						if(span.checked==true){
						add_btn.disable();
						delete_btn.disable();
						save_btn.disable();
						lookupTypeCode.disable();
						lookupTypeName.disable();
						lookupTypeRemark.disable();
						isSys.disable();
						}else {
						add_btn.enable();
						delete_btn.enable();
						save_btn.enable();
						lookupTypeCode.enable();
						lookupTypeName.enable();
						lookupTypeRemark.enable();
						isSys2.enable();
				}
						
						form.setChanged(false);
                    }
                    });
                    


                    
                }
               
				

                function saveData(){
                    form.validate();
                    if(form.isValid()==false) return;
                    setGridData("grid_0","types.mpLookupCodess");
                    var data = form.getData(false,true);
                    var json = nui.encode(data);

                    $.ajax({
                        url:"com.primeton.hw.lookup_type.lookup_updata.biz.ext",
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

                        function onCancel(){
                            CloseWindow("cancel");
                        }

                        function CloseWindow(action){

                            if(action=="close"){}else if(window.CloseOwnerWindow)
                                return window.CloseOwnerWindow(action);
                                else
                                return window.close();
                            }
    </script>
</body>
</html>