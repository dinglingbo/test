<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>检查项目类型设置</title>
<script src="<%=webPath + contextPath%>/repair/cfg/js/checkTypeSet.js?v=1.0.2"></script>
<link href="<%=webPath + contextPath %>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
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
/* .mainwidth{
    width: 700px;
} */
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
  	        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
	<div class="vpanel mainwidth" style="height:auto;">
      <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
      <div class="vpanel_body vpanel_bodyww">
            <input id="id" name="id" width="100%" class="nui-hidden" >
            <input class="nui-hidden" name="dictid"/>
            <input class="nui-hidden" name="tenantId"/>
            <input class="nui-hidden" name="orgid"/>
            <input class="nui-hidden" name="customid"/>
            <table class="tmargin">
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
                        value = "0"
                        textField="name"
                        valueField="id"
                        width="100%"
                        nullItemText="请选择..."/>
                    </td>
                </tr>
            </table>

        </div>
<!--         <div style="text-align:center;padding-top:5px;"> -->
<!--             <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a> -->
<!--             <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a> -->
<!--         </div> -->
    </div>
</div>



</body>
</html>

