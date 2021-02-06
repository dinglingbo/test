<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 20:41:40
  - Description:
-->
<head>
<title>添加跟进记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
</head>
<body>

	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
						<a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		
		<table>
			<tr id="out">
				<td style="" colspan="2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;跟进内容：
				<input style="width:340px;"  class="nui-textarea" id="remark" name="remark" type="text" ></td>
			</tr>
			<tr>
				<td style="padding-left: 29px;">跟进类型：<input  class="nui-textbox" id="partCode" name="partCode" type="text"></td>
				<td style="padding-left: 24px;">销售金额：<input  class="nui-combobox" id="fullName" name="fullName" type="text"></td>
			</tr>
			<tr>
				<td style="padding-left: 28px;">销售阶段：<input  class="nui-textbox" id="partBrandId" name="partBrandId" type="text"></td>
				<td style="padding-left: 24px;"></td>
			</tr>
			
			<tr id="out">
				<td style="">预计成单时间：
					<input  name=""  id="" class="nui-datepicker" />
				</td>
				<td>下次跟进日期：<input  class="nui-datepicker" id="" name="" ></td>
			</tr>
			

			
		</table>
	</div>
	</div>
	


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>