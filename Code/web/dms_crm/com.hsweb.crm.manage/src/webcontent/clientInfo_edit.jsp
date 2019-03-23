<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>客户资料</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=webPath + contextPath%>/manage/js/clientInfo_edit.js?v=1.1.3" type="text/javascript"></script>
    <link href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.0" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" method="post" style="width:100%;height:100%;">
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
						<a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:95%;" plain="false"
             onactivechanged="">
        
             
            <!--客户信息-->
            <%@include file="../manage/clientInfo_tab1.jsp" %>
            <!--车辆信息-->
            <%@include file="../manage/clientInfo_tab2.jsp" %>
        </div>

<!--         <div style="text-align:center;padding:10px;"> -->
<!--             <a id="save" class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a> -->
<!--             <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a> -->
<!--         </div> -->
    </form>
</body>
</html>