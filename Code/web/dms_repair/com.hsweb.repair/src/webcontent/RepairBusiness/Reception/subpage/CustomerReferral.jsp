<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 16:48:49
  - Description:
-->
<head>
<title>客户转介绍</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-form1" id="form1" >
        <input class="nui-hidden" name="criteria/_entity" value=""/>
    </div>
	<!-- 上下 -->
	<div class="nui-splitter" handlerSize="2" showHandleButton="false" style="width: 100%; height: 100%;" borderStyle="border:1" vertical="true" allowResize="false">
		<div size="30%" showCollapseButton="false">
			<!-- 基本信息 -->
				<div class="nui-panel" title="现来厂客户信息" id="div_1" style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
					<div class="nui-fit" id="datagrid1" style="overflow: hidden">
						<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
							<tr style="display: block; margin-top:-4px">
								<td width="130px">
									<span style="margin-left: 10px;">现来厂客户名称：</span>
								</td>
								<td >
									<input class="nui-buttonedit" onclick="onCustomerNow()" width="175px" />
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td width="130px">
									<span style="margin-left: 10px;">现来厂客户车牌：</span>
								</td>
								<td>
									<input class="nui-textbox" id="data" allowInput="false" width="175px" /> 
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td width="130px">
									<span style="margin-left: 10px;">现来厂客户优惠金额：</span>
								</td>
								<td>
									<input class="nui-spinner" id="data"  width="175px" /> 
								</td>
							</tr>
						</table>
					</div>
				</div>
		</div>

		<div showCollapseButton="false">
			<!-- 描述信息 -->
				<div class="nui-panel" title="转介绍客户信息" id="div_1" style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
					<div class="nui-fit" id="datagrid2" style="overflow: hidden">
						<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
							<tr style="display: block; margin:0">
								<td width="130px">
									<span style="margin-left: 10px;">转介绍客户名称：</span>
								</td>
								<td >
									<input class="nui-buttonedit" onclick="onCustomer()" width="175px" />
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td width="130px">
									<span style="margin-left: 10px;">转介绍客户车牌：</span>
								</td>
								<td>
									<input class="nui-textbox" id="data" allowInput="false" width="175px" /> 
								</td>
							</tr>
							<tr style="display: block; margin:0">
								<td width="130px">
									<span style="margin-left: 10px;">转介绍客户优惠金额：</span>
								</td>
								<td>
									<input class="nui-spinner" id="data"  width="175px" /> 
								</td>
							</tr>
							<tr style="display: block; margin-left:10px">
								<td>
									<label>备注：</label>
								</td>
							</tr>
							<tr style="display: block; margin-left:10px">
								<td>
									<input class="nui-textarea" style="width:300px;height:75px" />
								</td>
							</tr>
						</table>
					</div>
					<div style="text-align:right;padding:10px;margin-top:0">               
							<a class="mini-button" onclick="onOk" style="margin-right:10px;">保存（S）</a>       
							<a class="mini-button" onclick="onCancel" >取消（C）</a>       
						</div>
				</div>
		</div>
	
	</div>



	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var grid2 = nui.get("datagrid2");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function onCustomerNow(){
    		nui.open({
    			url:"./subpage/Customer.jsp",
    			title:"客户选择",width:900,height:550,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"customerNow"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	
    	function onCustomer(){
    		nui.open({
    			url:"./subpage/Customer.jsp",
    			title:"客户选择",width:900,height:550,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"customer"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
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
    	//取消
        function onCancel() {
        	CloseWindow("cancel");
        }
    </script>
</body>
</html>