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
<title>更多(客户档案)</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#data{
    		width:140px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-fit">
		<table>
			<tr style="display: block;margin:5px 0 0 0">
				<td style="width:88px">
					<label>最后来厂  从：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
				<td style="width:40px">
					<label>至：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block;margin: 0">
				<td style="width:88px">
					<label>第一次来厂  从：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
				<td style="width:40px">
					<label>至：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block;margin:0">
				<td style="width:88px">
					<label>最后离厂  从：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
				<td style="width:40px">
					<label>至：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block;margin:0">
				<td style="width:88px">
					<label>建档日期  从：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
				<td style="width:40px">
					<label>至：</label>
				</td>
				<td>
					<input class="nui-datepicker" id="data"  format="yyyy-MM-dd" viewDate="new Date()"/>
				</td>
			</tr>
			<tr style="display: block;margin: 0">
				<td style="width:88px">
					<label>客户名称：</label>
				</td>
				<td>
					<input class="nui-buttonedit" width="328px"  allowInput="false" onclick="onCustomer()"/>
				</td>
			</tr>
			<tr style="display: block;margin:0">
				<td style="width:88px">
					<label>品牌：</label>
				</td>
				<td>
					<input class="nui-combobox" id="data"  allowInput="false"/>
				</td>
				<td style="width:40px">
					<label>车型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="data"  allowInput="false"/>
				</td>
			</tr>
			<tr style="display: block;margin: 0">
				<td style="width:88px">
					<label>手机号码：</label>
				</td>
				<td>
					<input class="nui-textbox" width="328px" allowInput="false"/>
				</td>
			</tr>
			<tr style="display: block;margin: 0">
				<td style="width:88px">
					<label>底盘号：</label>
				</td>
				<td>
					<input class="nui-textbox" width="328px" allowInput="false"/>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-3px;">
			<tr>
				<td style="text-align:center;">
					<a class="nui-button" onclick="onClean()" style="margin-right:10px;">清空</a>  
					<a class="nui-button" onclick="onOk()" style="margin-right:10px;">确定</a>      
					<a class="nui-button" onclick="onCancel" >取消</a>       
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