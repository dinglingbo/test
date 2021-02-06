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
    <title>电话回访</title>
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
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <input class="nui-hidden" name="visitId" id="visitId" />
        <input class="nui-hidden" name="id" id="id" />
        <table class="tmargin" style="table-layout: fixed;width:100%">
            <tr class="htr">
                <td style="width: 70px;">提醒方式：</td>
                <td style="width: 135px;">
                    <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="data"
                        valueField="customid" textField="name" value="011401" enabled="false">
                </td>
                <td style="width: "></td>
            </tr>
            <tr class="htr">
                <td>提醒内容：</td>
                <td colspan="6">
                    <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:150px;">
                </td>
            </tr>

        </table>
    </div>

    <script type="text/javascript">
        nui.parse();
        var visitModeCtrlUrl = apiPath + sysApi +
            "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
        var remindUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
        var tabForm = new nui.Form("#form1");
        var visitMode = nui.get("visitMode");
        visitMode.setUrl(visitModeCtrlUrl);
        var mainData = {};

        nui.get("visitContent").focus();
        document.onkeyup = function (event) {
            var e = event || window.event;
            var keyCode = e.keyCode || e.which; //38向上 40向下
            if ((keyCode == 27)) { //ESC
                onCancel();
            }
        };

        function setData(rowData) {
            mainData = rowData;
        }

        function save() {
            var data = tabForm.getData();
            if (!data.visitContent) {
                showMsg("请填写内容", "W");
                return;
            }
           	nui.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '保存中...'
		    });
            var params = {
                serviceType:mainData.serviceType,
                mainId:mainData.mainId,
                guestId: mainData.guestId,
                carId: mainData.carId,
                carNo:mainData.carNo||'',
                visitMode: data.visitMode,
                visitContent: data.visitContent,
                visitId: currUserId,
                visitMan: currUserName,
                guestSource:mainData.guestSource
            };
            
            nui.ajax({
                url: remindUrl,
                type: "post",
                data: {
                    params: params
                },
                success: function (text) {
                nui.unmask(document.body); 
                    if (text.errCode == "S") {
                        var detailData = text.list;
                        showMsg("保存成功！", "S");
                        CloseWindow("ok");
                    }
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