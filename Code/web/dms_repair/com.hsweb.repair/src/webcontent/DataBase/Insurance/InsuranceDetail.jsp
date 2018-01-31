<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-29 15:58:11
  - Description:
-->
<head>
<title>编辑保险公司</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceDetail.js?v=1.0.1" ></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<input name="pageType" class="nui-hidden"/>
	<fieldset style="width:93%;height:200px;border:solid 1px #aaa;position:relative;margin:5px 5px;">
	    <div id="dataform1" style="padding-top:5px;" >
	    	 <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" width="130px">
	                     <span style="color:#FF0000;margin-left:30px;">保险公司代码：</span> 	  
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.code" width="250px"/>
	                    </td>
	                </tr>
	                    <td class="form_label" width="130px">
	                       <span style="color:#FF0000;margin-left:30px;">保险公司名称：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.fullName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">保险公司缩写：</span> 
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.shortName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">保险公司拼音：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.pyName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">联系人：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.contactor" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">联系人电话：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.contactorTel" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">排序号：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="comguest.orderIndex" width="250px"/>
	                    </td>
	                </tr>
	            </table>
	    </div>
    </fieldset>
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
                    urlStr = "com.hsapi.repair.insurance.InsuranceAdd.biz.ext";
                }
                if(pageType=="edit"){
                    urlStr = "com.hsapi.repair.insurance.InsuranceEdit.biz.ext";
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