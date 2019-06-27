<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:24:02
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/basic/js/partQualityDetail.js?v=1.0.6"></script>
<style type="text/css">
body {
	padding: 10px;
}

.table-label {
	text-align: right;
}

.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 60px;
}

.required {
	color: red;
}

.row {
	margin-top: 5px;
}

.width1 {
	width: 240px;;
}
</style>
</head>
<body>

<div id="basicInfoForm" class="form">
      <!-- <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:80%;">
            <tr>
                <td style="width:80%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div> -->
    <input class="nui-hidden" name="cangBrandId"/>
    <input class="nui-hidden" name="isDisabled"/>
    <input class="nui-hidden" name="id"/>
    <div class="row">
        <span class="title title-width1 required">品质编码：</span>
        <input name="code" id="code" class="nui-textbox width1"/>
    </div>
    <div class="row">
        <span class="title title-width1 required">品质名称：</span>
        <input name="name" class="nui-textbox width1"/>
    </div>
</div>
 <div style="text-align:center;padding:10px;">
     <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a> 
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
 </div> 

</body>
</html>
