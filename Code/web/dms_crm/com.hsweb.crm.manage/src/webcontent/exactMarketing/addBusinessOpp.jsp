<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 16:07:35
  - Description:
-->
<head>
<title>添加商机</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
    
        <style type="text/css">

   	#remark.mini-textbox{
   		width: 335px;
   	}
   	#remark.mini-textbox-border{
   		width:303px;
   	}
   	table{
   		margin-left:15px;
   	}
   	td{
   		padding-top:3px;
   	}

    </style>
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
			<tr>
				<td style="padding-left: 18px;">客户手机号：<input  class="nui-textbox" id="partCode" name="partCode" type="text"></td>
				<td style="padding-left: 24px;">商业类型：<input  class="nui-combobox" id="fullName" name="fullName" type="text"></td>
			</tr>
			<tr>
				<td style="padding-left: 41px;">车牌号：<input  class="nui-textbox" id="partBrandId" name="partBrandId" type="text"></td>
				<td style="padding-left: 24px;">销售阶段：<input  class="nui-combobox" id="applyCarModel" name="applyCarModel" type="text"></td>
			</tr>
			<tr>
				<td id="" style="padding-left: 30px;">客户姓名：<input  class="nui-textbox" id="stockQty" name="stockQty" type="text"></td>
				<td style="padding-left: 24px;">预计金额：<input class="nui-textbox" id="" name="" type="text">元</td>
			</tr>
			<tr>
				<td colspan="2" id=""  >销售产品/项目：<input  class="nui-textbox" id="stockQty" name="stockQty" type="text" width="78%"></td>
	
			</tr>
<!-- 			<tr><td  colspan="2" id="out1">请输入数量及领料人:</td></tr> -->
			<tr id="out">
				<td style="">预计成单时间：
					<input  name=""  id="" class="nui-datepicker" />
				</td>
				<td>下次跟进日期：<input  class="nui-datepicker" id="" name="" ></td>
			</tr>
			<tr id="out">
				<td style="" colspan="2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注：
				<input   class="nui-textarea" id="remark" name="remark" type="text" ></td>
			</tr>

			
		</table>
	</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>