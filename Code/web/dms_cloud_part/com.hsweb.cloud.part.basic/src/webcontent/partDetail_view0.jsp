<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>配件资料</title>
<script src="<%=webPath + contextPath%>/basic/js/partDetail.js?v=1.0.76"></script>
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
    width: 70px;
}
.htr{
    height: 20px;
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


.required {
    color: red;
}

  html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    
    .addyytime a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
    .addyytime a.hui{padding-left: 5px;padding-right: 5px;height:;line-height:24px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;
        text-align:center;color:#00b4f6;border-radius:4px;margin:0 5px 5px 0;}
    .addyytime a.hui{border:1px #e6e6e6 solid;color:#555555;background:#ccc;}
    .addyytime a.xz{ font-size: 13px; color: #555555 !important; background:#5ab1ef !important;}
    .addyytime a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px; color: #555555; text-decoration: none; }
    .addyytime a.hui:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px;background-color: #9fe6b8 ; color: #FFF; text-decoration: none; }
    .addyytime a .hui{text-decoration:none;transition:all .4s ease;}
    .addyytime a.backRed{border:1px #e6e6e6 solid;color:#555555;background:#f17171 ;}
</style>
</head>
<body>

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
<div class="nui-fit" id= "basicInfoForm"  style="width:100%;">
      <!-- <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div> -->
      <div class="vpanel_body vpanel_bodyww">
      	
  			    <input id="orgid" name="orgid" width="150px" class="nui-hidden" >
  			    <input class="nui-hidden" name="id"/>
  			    <input class="nui-hidden" name="isEdit"/>
  			    <input class="nui-hidden" name="name"/>
  			    <input class="nui-hidden" name="cangPartId"/>
            <input id="modifier" name="modifier" width="150px" class="nui-hidden" >
            <input id="modifyDate" name="modifyDate" width="150px" class="nui-hidden" >
            <table class="tmargin">
                <tr class="htr">
                    <td class=" right fwidtha required">配件品质:</td>
                    <td >
					<input name="qualityTypeId"
                       id="qualityTypeId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       valueFromSelect="true"
                       emptyText="请选择..."
                       url=""
                       width="150px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       onvaluechanged="onQualityTypeIdChanged"
                       nullItemText="请选择..."/>
		                </td>
                    <td class=" right fwidtha required">配件品牌:</td>
                    <td >
                       <input name="partBrandId"
                       id="partBrandId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       valueFromSelect="true"
                       width="150px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
                    </td>
                    </tr>
                    <tr>
                    <td class=" right fwidthb required">编码:</td>
                    <td ><input name="code" class="nui-textbox" width="150px" id="code"/></td>
                    <td class=" right fwidthb required">名称:</td>
                    <td >
                        <input name="partNameId" id="partNameId"
                        class="nui-buttonedit" emptyText=""
                        allowInput="false" width="150px"
                        onbuttonclick="onButtonEdit" selectOnFocus="true" />
                    </td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidthb required">单位:</td>
                    <td >
                        <input name="unit"
                        id="unit"
                        class="nui-combobox"
                        textField="name"
                        valueField="name"
                        emptyText="请选择..."
                        url=""
                        width="150px"
                        allowInput="true"
                        popupHeight="100%"
                        showNullItem="false"
                        nullItemText="请选择..."/>
                    </td><!-- 
                    <td class=" right fwidthb required">ABC分类:</td>
                    <td >
                        <input name="abcType"
                        id="abcType"
                        class="nui-combobox"
                        textField="name"
                        valueField="customid"
                        emptyText="请选择..."
                        url=""
                        valueFromSelect="true"
                        width="150px"
                        allowInput="true"
                        showNullItem="false"
                        nullItemText="请选择..."/>
                    </td> -->
                    <td class=" right fwidthb">OE码:</td>
                    <td ><input name="oemCode" class="nui-textbox" width="150px"/></td>
                    </tr>
                    <tr>
                    <td class=" right fwidthb">规格:</td>
                    <td ><input name="spec" class="nui-textbox" width="150px"/></td>
                    <td class=" right fwidthb">型号:</td>
                    <td ><input name="model" class="nui-textbox" width="150px"/></td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidthb">适用车型:</td>
                    <td >
                      <input name="applyCarbrandId"
                       id="applyCarbrandId"
                       class="nui-combobox"
                       textField="nameCn"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       width="150px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
                     </td>
                     <td colspan="6">
                      <input name="applyCarModel" id="applyCarModel" width="220px" class="nui-textbox"/>
                     </td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidthb">通用编码:</td>
                    <td colspan="3"><input name="commonCode" class="nui-textbox" width="375px"/></td>
                </tr>
                <tr class="htr">  
                    <td class=" right fwidthb">生产厂家:</td>
                    <td ><input name="produceFactory" class="nui-textbox" width="150px"/></td>
                    <td class=" right fwidthb">产地:</td>
                    <td ><input name="origin" class="nui-textbox" width="150px"/></td>
                </tr>
                <tr>
                    <td class=" right fwidthb">配件全称:</td>
                    <td colspan="3"><input name="fullName" class="nui-textbox" width="375px" enabled="false"/></td>
                </tr>
                <tr class="htr">
                    <td style="padding-left: 18px;"class=""  colspan="3">配件全称 = 名称+规格+车型+品牌</td>
                   
                </tr>
                <tr class="htr">
                    <td class=" right fwidthb">是否禁用:</td>
                    <td ><input name="isDisabled" class="nui-checkbox" width="150px" trueValue="1" falseValue="0"/><!-- </td><td class=" right fwidthb">统一售价:</td>
                    <td ><input name="isUniform" class="nui-checkbox" width="150px" trueValue="1" falseValue="0"/></td> -->
                    <td class=" right fwidthb">自定义分类:</td>
                    <td > <input name="customClassId" id="customClassId"
                        class="nui-buttonedit" emptyText=""
                        allowInput="false" width="150px"
                        onbuttonclick="onButtonEdit2" selectOnFocus="true" />
                    </td>
                </tr>
				<tr class="htr">
                    <td class=" right fwidthb">备注:</td>
                    <td colspan="3"><input name="remark" class="nui-textbox" width="375px" enabled="true"/></td>
                </tr>
            </table>
            
             <div class="addyytime" style="display:''" id="showHot" >
                     <table style="width:100%;height:30px;">
                        <tr>
		                    <td id="addAEl"></td>		                   
                       </tr>
                 </table>
              </div>
    </div>
</div>



</body>
</html>
