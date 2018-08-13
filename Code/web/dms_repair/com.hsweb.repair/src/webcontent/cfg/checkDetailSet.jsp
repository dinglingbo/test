<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>检查项目设置</title>
<script src="<%=webPath + partDomain%>/repair/cfg/js/checkDetailSet.js?v=1.0.3"></script>
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
    margin-left: 70px;
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


        <div>
            <div id="editForm" class="form">
                    <input id="orgid" name="orgid" width="100%" class="nui-hidden" >
                    <input class="nui-hidden" name="id"/>
                    <input class="nui-hidden" name="mainId"/>
                    <input id="modifier" name="modifier" width="100%" class="nui-hidden" >
                    <input id="modifyDate" name="modifyDate" width="100%" class="nui-hidden" >
                    <input name="itemName" class="nui-textbox" visible="false" id="itemName"/>
                    <input name="partName" class="nui-textbox" visible="false" id="partName"/>
                    <table class="tmargin">
                        <tr class="htr">
                            <td class=" right fwidtha required">检查类型:</td>
                            <td >
                               <input name="checkType"
                               id="checkType"
                               class="nui-combobox"
                               textField="name"
                               valueField="customid"
                               valueFromSelect="true"
                               emptyText="请选择..."
                               url=""
                               width="100%"
                               allowInput="true"
                               showNullItem="false"
                               onvaluechanged=""
                               nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr class="htr">
                                <td class=" right fwidthb required">项目名称:</td>
                                <td ><input name="checkName" class="nui-textbox" width="100%" id="checkName"/></td>
                            </tr>
                        <tr class="htr">
                            <td class=" right fwidthb">工时:</td>
                            <td >
                                <input name="itemNameId" id="itemNameId"
                                class="nui-buttonedit" emptyText=""
                                allowInput="false" width="100%"
                                onbuttonclick="onItemButtonEdit" selectOnFocus="true" />
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class=" right fwidthb">配件:</td>
                            <td >
                                <input name="partNameId" id="partNameId"
                                class="nui-buttonedit" emptyText=""
                                allowInput="false" width="100%"
                                onbuttonclick="onPartButtonEdit" selectOnFocus="true" />
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class=" right fwidthb">排序值:</td>
                            <td >
                                <input class="nui-spinner"
                                name="orderIndex"
                                id="orderIndex"
                                format="0"
                                value="0" maxValue="1000000000"
                                changeOnMousewheel="true" showButton="false"
                                width="50px" />
                                (>0的整数,越小越靠前显示)
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class=" right fwidthb">是否禁用:</td>
                            <td ><input name="isDisabled" class="nui-checkbox" width="100%" trueValue="1" falseValue="0"/>
                        </tr>
                    </table>
    
              </div>
        </div>
    
        <div class="nui-fit">
            <div id="contentGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    showPager="false"
                    dataField="list"
                    sortMode="client"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    url="">
                <div property="columns">
                    <div allowSort="true" field="opt" width="20" headerAlign="center" align="center" header="操作"></div>
                    <div allowSort="true" field="content" headerAlign="center" header="常用语">
                            <input property="editor" class="nui-textbox"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="nui-toolbar" style="height:40px;text-align:center;">
            <a class="nui-button" iconCls="" plain="true" onclick="onOk">保存</a>
            <a class="nui-button" iconCls="" plain="true" onclick="onCancel">取消</a>
        </div>
 
</body>
</html>
