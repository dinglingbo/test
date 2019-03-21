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
    <title>更新日期</title>
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
    </style>
</head>

<body>

    <div class="nui-fit" id="form1">
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <table class="tmargin" >
            <tr class="htr">
                <td style="width: 70px;text-align: right;">客户名称：</td>
                <td style="width: 135px;">
                    <input id="guestName" name="guestName" class="nui-textbox " enabled="false">
                </td>
            </tr>
            <tr class="htr">
                <td style="width: 70px;text-align: right;">车牌号：</td>
                <td style="width: 135px;">
                    <input id="carNo" name="carNo" class="nui-textbox " enabled="false">
                </td>
            </tr>
            <tr class="htr">
                <td style="width: 70px;text-align: right;">日期：</td>
                <td style="width: 135px;">
                    <input id="updateDate" name="updateDate" class="nui-datepicker "  dateFormat="yyyy-MM-dd" timeFormat="HH:mm" required="true">
                </td>
            </tr>

        </table>
    </div>

    <script type="text/javascript">
        nui.parse();
        var updateUrl = apiPath + repairApi +'/com.hsapi.repair.repairService.threeDC.updateDate.biz.ext';

        var mainData = {};
        var form = new nui.Form("#form1");

        nui.get("guestName").focus();
        document.onkeyup = function (event) {
            var e = event || window.event;
            var keyCode = e.keyCode || e.which; //38向上 40向下
            if ((keyCode == 27)) { //ESC
                onCancel();
            }
        };

        function setData(rowData) {
            mainData = rowData;
            form.setData(rowData);
            if(rowData.serviceType == 5){
                nui.get("updateDate").setShowTime(true);
            }
        }

        function save() {
            var data = form.getData(true);
            if (!data.updateDate) {
                showMsg("请填写日期", "W");
                return;
            }
            var params = {
                mainData:mainData,
                updateDate: data.updateDate
            };
            
            nui.ajax({
                url: updateUrl,
                type: "post",
                data: params,
                success: function (text) { 
                    if (text.errCode == "S") {
                        showMsg("保存成功！", "S");
                        
                    }else{
                        showMsg("保存失败！", "E");
                    }
                    CloseWindow("ok");
                }
            });
        }

        function onCancel() {
            CloseWindow("cancel");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                window.close();
        }
    </script>
</body>

</html>