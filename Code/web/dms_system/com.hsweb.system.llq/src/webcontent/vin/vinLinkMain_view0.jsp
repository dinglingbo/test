<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
    <title>车架号/车型/零件号</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon2.jsp" %>
    <script src="<%=sysDomain%>/llq/vin/js/vinLinkMain.js?v=1.2" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
    }

    .right{
        text-align: right;
    }  
    .fwidtha{
        width: 120px;
    }
    .fwidthb{
        width: 120px;
    }
    .htr{
        height: 30px;
    }
    .mainwidth{
        width: 1100px;
    }
    .tmargin{
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .vpanel{
        border:1px solid #d9dee9;
        margin:10px 0px 0px 20px;
        height:248px;
        float:left;
    }
    .vpanel_heading{
        border-bottom:1px solid #d9dee9;
        width:100%;
        height:28px;
        line-height:28px;
    }
    .vpanel_heading span{
        margin:0 0 0 20px;
        font-size:16px;
        font-weight:normal;
    }
    .vpanel_bodyww{
        padding : 10 10 10 10px !important

    }

    .required {
        color: red;
    }

</style>
</head>
<body>
    <div class="nui-toolbar" style="padding:10px;border-top:0;border-left:0;border-right:0;text-align:center;">
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(0)" id="query0">车架号查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(1)" id="query1">车型查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="query_vin(2)" id="query2">零件号查询</a>
    </div>
    <div class="nui-fit">
            <iframe id="mainFrame0" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame1" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            <iframe id="mainFrame2" class="theIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
    </div>
</body>
</html>