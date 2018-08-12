<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-01 15:23:25
  - Description:
-->
<head>
<title>资料拆分</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div  class="nui-toolbar"  style="height:30px;width:100%">
		<div  class="nui-form1" id="form1" style="height:100%">
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; ">
					<td class="form_label" width="62px">
						<span style="margin-left: 2px;">客户名称：</span>
					</td>
					<td colspan="1">
						<input class="nui-buttonedit" onclick="onCustomer()" width="490px" />
					</td>
					<td class="form_label" width="70px">
						<span style="margin-left: 10px;">手机号码：</span>
					</td>
					<td colspan="1">
						<input class="nui-textbox"  width="150px" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div  class="nui-splitter" style="width:100%;height:78%;" allowResize="false">
	    <div size="70%" showCollapseButton="false">
	        <div  id="datagrid1" class="nui-datagrid" dataField="data" style="width:100%;height:110%" url=""
	        	  pageSize="20" showPageInfo="false" multiSelect="true"
				  showPageIndex="false" showPage="false" showPageSize="false"
				  showReloadButton="false" showPagerButtonIcon="false"
			   	  allowSortColumn="true" 
	        >	
	        	
			    <div property="columns">
			    	<div header="&nbsp" headerAlign="center">
			    		<div property="columns">
					    	<div type="indexcolumn" width="40px"></div>
					    </div>
			    	</div>
			    	<div header="&nbsp" headerAlign="center">
			    		<div property="columns">
					    	<div field="" width="50px" headerAlign="center" allowSort="true">
					        	车牌号
					        </div>
					        <div field="" width="40px" headerAlign="center" allowSort="true">
					        	品牌
					        </div>
					        <div field="" width="50px" headerAlign="center" allowSort="true">
					        	车型
					        </div>
					        <div field="" width="120px" headerAlign="center" allowSort="true">
					        	底盘号
					        </div>
					    </div>
			    	</div>
			    	<div header="&nbsp" headerAlign="center">
			    		<div property="columns">
					    	<div field="" width="80px" headerAlign="center" allowSort="true">
					        	来厂次数
					        </div>
					        <div field="" width="120px" headerAlign="center" allowSort="true">
					        	最后来厂时间
					        </div>
					    </div>
			    	</div>
			        
			    </div>
			</div>
		</div>
	    <div showCollapseButton="false" >
	        <div  class="nui-datagrid" dataField="data" url=""
	        	  pageSize="20" showPageInfo="false" multiSelect="true"
				  showPageIndex="false" showPage="false" showPageSize="false"
				  showReloadButton="false" showPagerButtonIcon="false"
			   	  allowSortColumn="true" style="width:100%;height:110%"
	        >
			    <div property="columns">
			    	<div header="&nbsp">
			    		<div property="columns">
					    	<div field="" width="30%" headerAlign="center" allowSort="true">
					        	姓名
					        </div>
					        <div field="" width="20%" headerAlign="center" allowSort="true">
					        	性别
					        </div>
					        <div field="" width="50%" headerAlign="center" allowSort="true">
					        	联系电话
					        </div>
					    </div>
			    	</div>
			        
			    </div>
			</div>

	    </div>
	</div>
	<div style="text-align: right; padding: 10px;">
		<a class="mini-button" onclick="onCancel">关闭（C）</a>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function onCustomer(){
    		nui.open({
    			url:"http://127.0.0.1:8080/default/repair/common/Customer.jsp",
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
        	saveData();
        }

        //取消
        function onCancel() {
        	CloseWindow("cancel");
        }
    </script>
</body>
</html>