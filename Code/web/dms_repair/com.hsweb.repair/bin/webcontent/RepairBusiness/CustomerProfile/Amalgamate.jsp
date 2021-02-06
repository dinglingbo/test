<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-01 12:12:05
  - Description:
-->
<head>
<title>客户选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div  class="nui-toolbar"  style="height:30px">
		<span style="margin-left:20px;color:#0000FF; line-height:30px;font-size:18px">
			将B牌客户资料合并到A牌客户中
		</span>
	</div>
	<div  class="nui-splitter" style="width:100%;height:75%;" allowResize="false">
	    <div size="50%" showCollapseButton="false">
	        <div  class="nui-panel" showToolbar="false" title="A车牌信息" showFooter="false" style="width:100%;height:100%;" >
				<table style="table-layout: fixed;" class="nui-form-table">
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">车牌号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandEn" width="180px" />
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">客户名称：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" />
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">品牌：</span>
						</td>
						<td colspan="1">
							<input class="nui-combobox" name="brand.carBrandZh" width="180px" valueFromSelect="true"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">品牌车型：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">发动机号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">底盘号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">来厂次数：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	    <div showCollapseButton="false" style="width:100px;height:100px">
	        <div  class="nui-panel" showToolbar="false" title="B车牌信息" showFooter="false" style="width:100%;height:100%;" >
				<table style="table-layout: fixed;" class="nui-form-table">
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">车牌号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandEn" width="180px" />
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">客户名称：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" />
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">品牌：</span>
						</td>
						<td colspan="1">
							<input class="nui-combobox" name="brand.carBrandZh" width="180px" valueFromSelect="true"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">品牌车型：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">发动机号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">底盘号：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
					<tr style="display: block; margin: 3px 0">
						<td class="form_label" width="70px">
							<span style="margin-left: 10px;">来厂次数：</span>
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="brand.carBrandZh" width="180px" allowInput="false"/>
						</td>
					</tr>
				</table>
			</div>
	    </div>
	</div>
	<div style="text-align: right; padding: 10px;">
		<a class="nui-button" onclick="onOk" style="margin-right: 20px;">合并（S）</a>
		<a class="nui-button" onclick="onCancel">取消（C）</a>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
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