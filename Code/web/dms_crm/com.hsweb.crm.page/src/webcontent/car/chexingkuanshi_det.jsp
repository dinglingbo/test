<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
--> 
<head>  
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
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
    .textboxWidth{
        width: 100%;
    }
    .tbText{
        text-align: right;
    }
</style> 
</head>
<body>
   
    <div class="nui-fit" id="form1">
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick=""><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                   </td>
               </tr>
           </table>
       </div>
       <table style="font-size: 9pt; padding-left: 10px">
            <tr>
                <td class="td_title">车型编号
                </td>
                <td>
                    <input id="AutotypeId_input" class="nui-textbox" type="text" style="width: 110px"
                         value="自动编号" disabled="disabled" />
                </td>
                <td class="td_title">拼音码
                </td>
                <td>
                    <input id="AutotypeCode_input" class="nui-textbox" type="text" style="width: 110px" />
                </td>
            </tr>
            <tr>
                <td align="right">车型名称
                </td>
                <td colspan="3">
                    <input id="AutotypeName_input" class="nui-textbox" type="text" style="width: 280px"
                         />
                </td>
            </tr>
            <tr>
                <td align="right">产地
                </td>
                <td>
                    <input id="ProduceHome_combobox" class="nui-combobox" style="width: 100px;">
                    </input>
                </td>
                <td align="right">进口车辆
                </td>
                <td colspan="3">
                    <input id="Import_combobox" class="nui-combobox" editable="false"
                        style="width: 110px;" > </input>
                </td>
            </tr>
            <tr>
                <td align="right">汽车品牌
                </td>
                <td colspan="3">
                    <input id="" class="nui-combobox" style="width: 99%;">
                    </input>
                </td>
            </tr>
            <tr>
                <td align="right">车辆类型
                </td>
                <td colspan="3">
                    <input id="CarSort_combobox" class="nui-combobox" style="width: 99%">
                    </input>
                </td>
            </tr>
            <tr>
                <td align="right">上市日期
                </td>
                <td>
                    <input id="PublicDate_datebox" class="nui-datepicker" editable="false" style="width: 110px"/>
                </td>
                <td align="right">车体结构
                </td>
                <td>
                    <input id="AutoStruct_combobox" class="nui-combobox" style="width: 110px" >
                    </input>
                </td>
            </tr>
            <tr>
                <td align="right">车辆级别
                </td>
                <td>
                    <input id="AutoLevel_combobox" class="nui-combobox" style="width: 110px" >
                    </input>
                </td>
                <td align="right">变速箱
                </td>
                <td>
                    <input id="Gearbox_input" class="nui-textbox" type="text" style="width: 110px" />
                </td>
            </tr>
            <tr>
                <td align="right">排量
                </td>
                <td>
                    <input id="Displacement_input" class="nui-textbox" type="text" style="width: 110px" />
                </td>
                <td align="right">标准座位
                </td>
                <td>
                    <input id="SeatingCount_input" class="nui-textbox" type="text" style="width: 110px" />
                </td>
            </tr>
            <tr>
                <td align="right">驱动方式
                </td>
                <td colspan="3">
                    <input id="DriverType_input" class="nui-textbox" type="text" style="width: 280px" />
                </td>
            </tr>
            <tr>
                <td align="right">指导进价
                </td>
                <td>
                    <input id="PurchasePrice_input" class="nui-textbox" type="text" style="width: 95px"/>元
                </td>

                <td align="right">指导销价
                </td>
                <td>
                    <input id="SailPrice_input" class="nui-textbox" type="text" style="width: 95px"/>元
                </td>
            </tr>
            <tr>
                <td align="right">销售底价
                </td>
                <td>
                    <input id="LimitPrice_input" class="nui-textbox" type="text" style="width: 95px" />元
                </td>
                <td align="right">购车订金
                </td>
                <td>
                    <input id="MustDeposit_input" class="nui-textbox" type="text" style="width: 95px" />元
                </td>
            </tr>
            <tr>
                <td align="right">备注说明
                </td>
                <td colspan="3">
                    <input id="Remark_input" class="nui-textarea" multiline="true" style="width: 286px; height: 65px;"/>
                </td>
            </tr>
        </table>
</div>
<script type="text/javascript">
    nui.parse();
   




function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}

</script>
</body>
</html>