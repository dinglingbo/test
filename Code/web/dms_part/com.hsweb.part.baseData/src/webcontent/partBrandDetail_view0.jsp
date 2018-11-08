<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:22:10
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/baseDataPart/js/partBrandMgr/partBrandDetail.js?v=1.0.4"></script>
<style type="text/css">



.title {
	/*text-align: right;*/
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
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
    <input class="nui-hidden" name="id"/>
    <input class="nui-hidden" name="parentId"/>
    <div class="row">
        <span class="title title-width1 required">品牌编码：</span>
        <input name="code" class="nui-textbox width1"/>
    </div>
    <div class="row">
        <span class="title title-width1 required">品牌名称：</span>
        <input name="name" class="nui-textbox width1"/>
    </div>
    <div class="row">
        <span class="title title-width1">生产厂家：</span>
        <input name="manufacture" class="nui-textbox width1"/>
    </div>
    <div class="row">
        <span class="title title-width1">备注：</span>
        <input name="remark" class="nui-textbox width1"/>
    </div>
</div>


</body>
</html>
