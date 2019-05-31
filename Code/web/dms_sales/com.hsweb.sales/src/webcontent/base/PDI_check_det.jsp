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

        .textboxWidth {
            width: 100%;
        }

        .td_title {
            text-align: right;
        }
    </style>
</head>

<body>

    <div class="nui-fit" id="form1">
        <input id="id" name="id" class="nui-textbox" visible="false" />
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span
                                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span
                                class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <table style="font-size: 9pt; padding-left: 10px;padding-top: 10px;line-height:30px;">
            <tr>
                <td class="td_title">项目编号：
                </td>
                <td>
                    <input id="code" name="code" class="nui-textbox" type="text" style="width: 150px" enabled="false" />
                </td>
                <td class="td_title">拼音码：
                </td>
                <td>
                    <input id="pyCode" name="pyCode" class="nui-textbox" type="text" style="width: 150px"
                        enabled="false" />
                </td>
            </tr>
            <tr>
                <td class="td_title">排序序号：
                </td>
                <td>
                    <input id="orderNo" name="orderNo" class="nui-textbox" type="text" style="width: 150px"
                        vtype="int" required="true"/>
                </td>
                <td class="td_title">项目类型：
                </td>
                <td>
                    <input id="pdiTypeId" name="pdiTypeId" class="nui-combobox" style="width: 150px" valueField="id"
                        textField="name" allowInput="false" />
                </td>
            </tr>
            <tr>
                <td class="td_title">项目名称：
                </td>
                <td colspan="3">
                    <input id="name" name="name" class="nui-textbox" type="text" style="width: 100%"  required="true"/>

                </td>
            </tr>
            <tr>
                <td class="td_title">备注：
                </td>
                <td colspan="3">
                    <input id="remark" name="remark" class="nui-textarea" style="width: 100%;height:50px;" />

                </td>
            </tr>
            <tr>
                <td class="code">勾选/描述：
                </td>
                <td>
                    <input id="isEnableCheck" name="isEnableCheck" class="nui-combobox" style="width: 150px" required="true"
                        data="checkList" valueField="id" textField="name" />
                </td>
                <td class="td_title">禁用：
                </td>
                <td>
                    <div id="isDisabled" name="isDisabled" class="nui-checkbox" text="" trueValue="1" falseValue="0">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var checkList = [{
            id: 0,
            name: "勾选"
        }, {
            id: 1,
            name: "描述"
        }];
        nui.parse();
        var saveUrl = apiPath + saleApi + "/sales.base.addCsbPDI.biz.ext";
        var form = new nui.Form("form1")
        initDicts({
            pdiTypeId: '10361' //pdi检测类型
        }, function () {});

        function SetData(row) {
            form.setData(row);
        }
 

        function save(){
            var fdata = form.getData(true);
            form.validate();
            if (form.isValid() == false) return;
            nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : '保存中...'
            });

            nui.ajax({
                url : saveUrl,
                type : "post",
                data : JSON.stringify({
                    data:fdata,
                    token: token
                }),
                success : function(data) {
                    nui.unmask(document.body);
                    if (data.errCode == "S") {
                        parent.showMsg("保存成功!","S");
                        //doSearch();
                    } else {
                        parent.showMsg(data.errMsg || "保存失败!","E");
                    }
                    CloseWindow("ok");
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    // nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
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