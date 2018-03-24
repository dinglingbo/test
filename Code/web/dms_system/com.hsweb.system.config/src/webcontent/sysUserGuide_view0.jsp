<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): steven
  - Date: 2018-03-23 15:00:13
  - Description:
-->
<head>
    <title>用户导航</title>
    <script src="<%= request.getContextPath() %>/config/js/userGuide.js?v=1.1.0"></script>
    <link href="<%= request.getContextPath() %>/common/nui/themes/bootstrap/skin.css?v=1.1.0" rel="stylesheet"
          type="text/css"/>
    <style>
        .container {
            padding: 30px;
        }

        .container .mini-panel {
            margin-right: 20px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
    <table border=0 cellpadding=0 cellspacing=0 style="width:70% ;height:70%" align="center" valign="middle">
        <tr>
            <td>
                <div class="mini-panel mini-panel-danger" title="初始化流程" width="250px" showCollapseButton="false" showCloseButton="false" >
                    <br />系统启用前各项参数的初始化
                    <br /><br />
                    <div align="center"><a class="mini-button mini-button-success" >初始化流程</a></div>
                </div>
            </td>
            <td>
                <div class="mini-panel mini-panel-primary" title="系统总体导航" width="250px" showCollapseButton="false" showCloseButton="false">
                    <br />包含系统配置、权限管理、基础资料、单据管理、期初设置等等
                    <br /><br />
                    <div align="center"><a class="mini-button mini-button-success" >系统总体导航</a></div>
                </div>
            </td>
            <td>
                <div class="mini-panel mini-panel-success" title="其它辅助导航" width="250px"showCollapseButton="false" showCloseButton="false">
                    <br />其它系统辅助功能设置
                    <br /><br />
                    <div align="center"><a class="mini-button mini-button-success" >其它辅助导航</a></div>
                </div>
            </td>
            <td>
                <div class="mini-panel mini-panel-info" title="入门帮助" width="250px" showCollapseButton="false" showCloseButton="false">
                    <br />包含系统常见问题、教学视频，客服热线等
                    <br /><br />
                    <div align="center"><a class="mini-button mini-button-success" >入门帮助</a></div>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
