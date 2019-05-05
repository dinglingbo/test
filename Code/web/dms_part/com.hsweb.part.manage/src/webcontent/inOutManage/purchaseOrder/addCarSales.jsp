<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 16:13:04
  - Description:
-->
<head>
<title>添加整车订单</title>
    
</head>
<body>
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
				
					<td class="title">
						<label>查询条件:</label>
					</td>
					<td colspan="3">
						<input name="" width="100%" class="nui-textbox" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>车辆编号:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="">
						<label>车型名称:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
				
					<td class="title">
						<label>汽车品牌:</label>
					</td>
					<td colspan="3">
						<input name="" width="100%" class="nui-textbox" />
					</td>
				</tr>				
				<tr>
					<td class="title">
						<label>车辆类型:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="">
						<label>颜色:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>内饰色:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="">
						<label>数量:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>单价:</label>
					</td>
					<td>
						<input name="" width="100%" class="nui-textbox" />
					</td>
					<td class="">
						<label>金额:</label>
					</td>
					<td>
						<input name="" class="nui-textbox" width="100%" />
					</td>
				</tr>
				<tr>
				
					<td class="title">
						<label>备注:</label>
					</td>
					<td colspan="3">
						<input name="" width="100%" class="nui-textbox" />
					</td>
				</tr>																
			</table>
		</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>