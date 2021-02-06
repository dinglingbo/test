<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-07 17:26:42
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/repairMgr/repairMaterial.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>

<div id="basicInfoForm" >
    <input name="id" class="nui-hidden" />
    <table>
        <tr>
            <td>
                <label class="title required">零件编码：</label>
            </td>
            <td colspan="5">
                <input name="partCode" class="nui-textbox" width="100%"/>
            </td>
        </tr>
        <tr>
            <td>
                <label class="title required">零件名称：</label>
            </td>
            <td colspan="5">
                <input name="partName" class="nui-textbox" width="100%"/>
            </td>
        </tr>
        <tr>
            <td>
                <label>收费类型：</label>
            </td>
            <td>
                <input name="Country"
                       showNullItem="true"
                       class="nui-combobox"
                       url=""
                       textField="text"
                       valueField="id" />
            </td>
            <td>
                <label>项目进程：</label>
            </td>
            <td>
                <input name="Country"
                       showNullItem="true"
                       class="nui-combobox"
                       url=""
                       enabled="false"
                       textField="text"
                       valueField="id" />
            </td>
        </tr>
        <tr>
            <td>
                <label>数量：</label>
            </td>
            <td>
                <input id="textbox4"
                       name="username" class="nui-textbox"  />
            </td>
            <td>
                <label>单价：</label>
            </td>
            <td>
                <input id="textbox5"
                       name="username" class="nui-textbox"  />
            </td>
            <td>
                <label>金额：</label>
            </td>
            <td>
                <input id="textbox6"
                       name="username" class="nui-textbox"  />
            </td>
        </tr>
        <tr>
            <td>
                <label>备注：</label>
            </td>
            <td colspan="5">
                <input id="textbox1"  name="username"
                       class="nui-textbox"  width="100%"/>
            </td>
        </tr>
    </table>
    <div style="text-align: center;">
        <a class="nui-button" onclick="prevItem">上一条</a>
        <a class="nui-button" onclick="nextItem">下一条</a>
        <a class="nui-button" onclick="onOk">保存</a>
        <a class="nui-button" onclick="onCancel">关闭</a>
    </div>

</div>


</body>
</html>
