<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	
    	}
    </style>
    
    
</head>
<body style="margin:0;padding:0;">
		<input name="pageType" class="nui-hidden"/>
		<div  class="nui-panel" showToolbar="false" title="基本信息" showFooter="false" style="width:430px;height:200px;margin:9px 9px">
			<div id="dataform1" style="padding-top:5px;" >
				<table style="table-layout:fixed;" class="nui-form-table">
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;" >项目编码：</span>
						</td>
						<td>
							<input class="nui-textbox" name="code" width="120px"/>
						</td>
						<td class="form_label" width="50px"> 
							<span style="color:#FF0000;margin-left:10px;">工种：</span>
						</td>
						<td>
							<input class="nui-combobox" name="itemKind" width="122px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label"width="80px" > 
							<span style="color:#FF0000;margin-left:10px;">项目名称：</span>
						</td>
						<td>
							<input class="nui-textbox" name="name" width="300px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;">项目类型：</span>
						</td>
						<td>
							<input class="nui-combobox" name="type" width="300px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;">品牌：</span>
						</td>
						<td>
							<input class="nui-combobox" name="carBrandId" width="120px"/>
						</td>
						<td class="form_label" width="50px"> 
							<span style="color:#FF0000;margin-left:10px;">车型：</span>
						</td>
						<td>
							<input class="nui-combobox" name="carModel" width="122px"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		
		
		<!-- 工时价格信息 -->
			<!-- 
			<div class="nui-toolbar" style="width:100%;padding:0;margin:0;border-top:0;border-left:0;border-right:0;text-align:left;"borderStyle="border:2;">
				<span style="margin-left:10px">工时价格信息</span>
			</div>
			 -->
			
			<div  class="nui-panel" showToolbar="false" title="工时价格信息" showFooter="false" style="width:430px;height:200px;margin:9px 9px">
				<table style="table-layout:fixed;" class="nui-form-table">
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="margin-left:20px;">标准工时：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="itemTime" value="0" width="300px" inputStyle="text-align:right;"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="margin-left:20px;">工时单价：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="unitPrice" value="0" width="300px" inputStyle="text-align:right;"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="margin-left:20px;">工时金额：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="amt" value="0" width="300px" inputStyle="text-align:right;"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="margin-left:20px;">提成金额：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="unitPrice" width="300px" />
						</td>
					</tr>
				</table>
			</div>


				
			
			<div style="text-align:center;padding:10px;">               
	            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
	            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
	        </div>
		
	<script type="text/javascript">
    	nui.parse();
    	
    	var form = new nui.Form("#dataform1");
		form.setChanged(false);
		
    	function saveData(){
				var urlStr;
                var pageType = nui.getbyName("pageType").getValue();
                if(pageType=="add"){
                    urlStr = "com.hsapi.repair.item.addRepairItem.biz.ext";
                }
                if(pageType=="edit"){
                    urlStr = "com.hsapi.repair.item.editRepairItem.biz.ext";
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