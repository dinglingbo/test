<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-29 15:58:11
  - Description:
-->
<head>
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<input name="pageType" class="nui-hidden" />
	<fieldset
		style="width: 350px; height: 100px; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
		<div id="dataform1" style="padding-top: 5px;">
			<!-- 隐藏区域 
	    	<input class="nui-hidden" name="comguest" id="comguest"/>
	    	<input class="nui-hidden" name="comguest.code" id="comguest.code"/>
		    -->
			<table style="width: 100%; height: 100%; table-layout: fixed;"
				class="nui-form-table">
				<tr>
					<td class="form_label"><span>保险公司代码：</span></td>
					<td colspan="1"><input class="nui-combobox"
						name="rpbclass.type" /></td>
				</tr>
				<td class="form_label"><span>保险公司名称：</span></td>
				<td colspan="1"><input class="nui-combobox"
					name="rpbclass.name" /></td>
				</tr>
				</tr>
				<td class="form_label">保险公司缩写：</td>
				<td colspan="1"><input class="nui-textbox" name="rpbclass.name" />
				</td>
				</tr>

			</table>
		</div>
	</fieldset>
	<div class="nui-toolbar" style="padding: 3px;" borderStyle="border:0;">
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
		
    	function saveData(){
				var urlStr;
                var pageType = nui.getbyName("pageType").getValue();
                if(pageType=="add"){
                    urlStr = "com.hsapi.repair.Insurance.InsuranceAdd.biz.ext";
                }
                if(pageType=="edit"){
                    urlStr = "com.hsapi.repair.Insurance.InsuranceEdit.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
				var data = form.getData(false,true);
                var json = nui.encode(data);

                $.ajax({
                    url:urlStr,
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
                                    
                                }
                                });
                            }
                        }
                        });
                    }

                    //页面间传输json数据
                    function setData(data){
                        var infos = nui.clone(data);
						nui.getbyName("pageType").setValue(infos.pageType);

                        if (infos.pageType == "edit") {
                            var json = infos.record;
							var form = new nui.Form("#dataform1");
                            form.setData(json);
                            form.setChanged(false);
                        }
                    }

                    //关闭窗口
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

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("close");
                    }
                
    </script>
</body>
</html>