<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 14:21:19
  - Description:
-->
<head>
<title>品牌</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarBrandDetail.js?v=1.0.1"></script>

</head>
<body style="margin: 0; padding: 0; overflow: hidden">
	<input name="pageType" class="nui-hidden" />
	<fieldset
		style="width: 92.5%; height: 100%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
		<div id="dataform1" style="padding-top: 5px;">
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; margin: 10px 0">
					<td class="form_label" width="100px"><span
						style="color: #FF0000; margin-left: 20px;">品牌英文名：</span></td>
					<td colspan="1"><input class="nui-textbox"
						name="brand.carBrandEn" width="230px" /></td>
				</tr>
				<tr style="display: block; margin: 10px 0">
					<td class="form_label" width="100px"><span
						style="color: #FF0000; margin-left: 20px;">品牌中文名：</span></td>
					<td colspan="1"><input class="nui-textbox"
						name="brand.carBrandZh" width="230px" /></td>
				</tr>
			</table>
		</div>
	</fieldset>
	<div style="text-align: right; padding: 10px;">
		<a class="mini-button" onclick="onOk" style="margin-right: 20px;">保存（S）</a>
		<a class="mini-button" onclick="onCancel">取消（C）</a>
	</div>


	<script type="text/javascript">
		nui.parse();
		
		var form = new nui.Form("#dataform1");
		form.setChanged(false);
		
    	function saveData(){
				var urlStr;
                var pageType = nui.getbyName("pageType").getValue();
                if(pageType=="add"){
                    urlStr = "com.hsapi.repair.brand.addBrand.biz.ext";
                }
                if(pageType=="edit"){
                    urlStr = "com.hsapi.repair.brand.editBrand.biz.ext";
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
                        CloseWindow("cancel");
                    }
                
    </script>
</body>
</html>