<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-10 11:22:57
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
	车辆<input class="nui-textbox" enabled="false" id="carNo" name="carNa" />
	客户<input class="nui-textbox" enabled="false" id="guest" name="guest" />
	挂账<input class="nui-textbox" enabled="false" id="" name="" />
	<font  size=4 style=" color: red;">代收金额</font><input class="nui-textbox" enabled="false" id="" name="" />
<div>
 <div id="rtTr" class="vpanel panelwidth" style="height:auto;">
            <div  class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>使用优惠</span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr id="rcTr">
                        <td >额外优惠(-)</td>
                        <td></td>
                        <td ><input class="nui-textbox" enabled="false" id="rRPAmt" name=""></td>

                    </tr>
                </table>

            </div>
        </div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>