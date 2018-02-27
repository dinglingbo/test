<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-05 15:39:41
  - Description:
-->
<head>
<title>储值卡转充值</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	.text1{
    		width:234px
    	}
    	.text2{
    		width:290px
    	}
    	.area{
    		width:290px 
    	}
    	.f{
		    margin: 7px;
		    height: 82%;
		    padding: 0;
		    border: 1px solid #888888;
    	}
    	.legend{
		    margin-left: 7px;
		    
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%;overflow: hidden;">
	<fieldset  class="f">
		<legend class="legend">转充值客户信息</legend>
		<div class="nui-fit" style="overflow: hidden;">
			<table style="margin:0 4px;height: 100%; width: 100%;">
				<tr style="display: block;margin: 5px 0 0 0">
					<td style="width:60px">
						<label>充值卡号：</label>
					</td>
					<td>
						<input class="nui-textbox text1"/>
					</td>
					<td>
						<a class="nui-button"  onclick="" width="50px">读卡</a>
					</td>
				</tr>
				<tr style="display: block;margin: 0">
					<td style="width:60px">
						<label>客户名称：</label>
					</td>
					<td>
						<input class="nui-textbox text2"/>
					</td>
				</tr>
				<tr style="display: block;margin: 0">
					<td style="width:60px">
						<label>客户手机：</label>
					</td>
					<td>
						<input 	class="nui-spinner text2" 
								format="0" allowNull="true"
							 	value="&nbsp" showButton="false" 
						 		maxValue="90000000000" minValue="10000000000"/>
					</td>
				</tr>
				<tr style="display: block;margin: 0">
					<td style="width:60px">
						<label>转入金额：</label>
					</td>
					<td>
						<input 	class="nui-spinner text2" 
								format="0.00" allowNull="true"
							 	value="&nbsp" showButton="false" 
						 		maxValue="100000000000" minValue="-100000000000"/>
					</td>
				</tr>
				<tr style="display: block;margin: 0">
					<td style="width:60px">
						<label>说明：</label>
					</td>
					<td >
						<input class="nui-textarea area" height="70px" />
					</td>
				</tr>
			</table>
		</div>
	</fieldset>
	
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-4px;">
			<tr>
				<td style="text-align:right;">
					<a class="nui-button" onclick="onOk()" style="margin-right:10px;width:60px">确定(S)</a>      
					<a class="nui-button" onclick="onCancel" style="margin-right:5px;width:60px">取消(C)</a>       
				</td>
			</tr>
		</table>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function onCustomer(){
    		nui.open({
    			url:"../../common/Customer.jsp",
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
		//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
    	}
        //确定保存或更新
        function onOk() {
        	searchData();
        }

        //取消
        function onCancel() {
        	CloseWindow("cancel");
        }
    </script>
</body>
</html>