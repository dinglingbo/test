<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-24 09:26:40
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style>
        .tbText{
            text-align: right;
            width:15%;
        }
        .tbInput{
            width: 30%;
        }
        .trHeight{
            height:40px;
        }
        .trPadding{
            padding-top:8px;
        }
    </style>
</head>
<body>
<table >
    <tr class="trHeight">
        <td class="tbText">交车人：</td>
        <td class="tbInput">
            <input class="nui-combobox " id="" name=""  style="width:100%"/>
        </td>
        <td class="tbText">交车日期：</td>
        <td class="tbInput">
            <input class="nui-datepicker " id="" name=""  style="width:100%"/>
        </td>
    </tr>
    <tr class="trHeight">
        <td class="tbText">钥匙数量：</td>
        <td class="tbInput">
            <input class="nui-textbox " id="" name="" vtype="int"  style="width:100%"/>
        </td>
    </tr>
    <tr >
        <td class="tbText trPadding">交车备注：</td>
        <td class="tbInput trPadding" colspan="3">
            <input class="nui-textarea " id="" name=""   style="width:100%;height:100px;"/>
        </td>
    </tr>
</table>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>