<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 20:57:14
  - Description:
-->
<head>
<title>收款明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>    
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>
<body>
<div class="nui-fit">
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">收款日期</div>
                <div field="" name="" headeralign="center" align="center">单号</div>
                <div field="" id="" name="" headeralign="center" align="center">应收</div>
                <div field="" id="" name="" headeralign="center" align="center">实收</div>
                <div field="" id="" name="" headeralign="center" align="center">优惠</div>
                <div field="" id="" name="" headeralign="center" align="center">欠款</div>
                <div field="" id="" name="" headeralign="center" align="center">结算方式</div>
                <div field="" id="" name="" headeralign="center" align="center">票据单号</div>
                <div field="" id="" name="" headeralign="center" align="center">收款人</div>                
            </div>
        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>