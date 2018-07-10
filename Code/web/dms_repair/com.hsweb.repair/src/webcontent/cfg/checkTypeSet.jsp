<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>检查项目类型设置</title>
<script src="<%=webPath + repairDomain%>/repair/cfg/js/checkTypeSet.js?v=1.0.0"></script>
<link href="<%=webPath + sysDomain %>/common/nui/themes/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
}
.left{
    text-align: left;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 60px;
}
.fwidthb{
    width: 60px;
}
.htr{
    height: 20px;
}
.mainwidth{
    width: 700px;
}
.tmargin{
    margin-top: 10px;
    margin-bottom: 10px;
}

.vpanel{
    border:0px solid #d9dee9;
    margin:0px 0px 0px 0px;
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
    font-size:8px;
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

<div class="nui-fit" id= "basicInfoForm">
	<div class="vpanel mainwidth" style="height:auto;">
      <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
      <div class="vpanel_body vpanel_bodyww">
            <input id="id" name="id" width="100%" class="nui-hidden" >
            <input class="nui-hidden" name="dictid"/>
            <input class="nui-hidden" name="tenantId"/>
            <input class="nui-hidden" name="orgid"/>
            <table class="tmargin">
                <tr class="htr">
                    <td class=" right fwidthb required">编码:</td>
                    <td ><input name="customid" class="nui-textbox" width="100%" id="customid"/></td>
                </tr>
                <tr class="htr">
                        <td class=" right fwidthb required">名称:</td>
                        <td ><input name="name" class="nui-textbox" width="100%" id="name"/></td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidthb required">状态:</td>
                    <td >
                        <input name="isDisabled"
                        id="isDisabled"
                        class="nui-combobox"
                        textField="name"
                        valueField="id"
                        width="100%"
                        nullItemText="请选择..."/>
                    </td>
                </tr>
            </table>

        </div>
    </div>
</div>
<div style="text-align:center;padding:10px;">
        <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
        <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
