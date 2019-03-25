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
    <title>修改 回访信息</title>
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

        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
    </style>
</head>

<body>

    <div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span
                            class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" onclick="onCancel(2)" plain="true" style="width: 60px;"><span
                                class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="form" id="carInfoFrom" style="height:100%;width:100%;padding-right:20px;">
        <input class="nui-hidden" name="id" />

        <table class="nui-form-table" style="width:100%;line-height: 30px;">

            <tr>
                <td class="form_label">
                    <label>客户姓名：</label>
                </td>
                <td>
                    <input name="contactorName" class="nui-textbox" width="100%" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>车牌号：</label>
                </td>
                <td>
                    <input name="carNo" allowInput="true" class="nui-textbox" width="100%" enabled="false"/>
                </td>
            </tr>
            <tr>

            <tr>
                <td class="form_label">
                    <label>回访类型：</label>
                </td>
                <td>
                    <input name="serviceType" class="nui-combobox" data="serviceTypeList" textField="text" valueField="id" width="100%" enabled="false"/>
                </td>
                <td class="form_label">
                    <label>回访方式：</label>
                </td>
                <td>
                    <input id="visitMode" name="visitMode" class="nui-combobox "textField="name" valueField="customid"  width="100%" enabled="false"/>
                </td>
            </tr>
            <tr>

            </tr>
            <tr>
                <td class="form_label">
                    <label>回访内容：</label>
                </td>
                <td colspan="3">
                    <textarea class="nui-textarea" id="visitContent" name="visitContent" width="100%" style="height:140px;"></textarea>
                </td>
            </tr>

        </table>
    </div>
    <script type="text/javascript">
        var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }];
        nui.parse();
        var baseUrl = apiPath + repairApi + "/";
        var saveUrl = apiPath + crmApi + "/com.hsapi.crm.svr.visit.updateVisitRecord.biz.ext";

        var mainData = {};
        var carInfoFrom = new nui.Form("#carInfoFrom");


        initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型        
    });


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
            carInfoFrom.setData(rowData);
        }


        function save() {
                nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : '保存中...'
            });
            var data = carInfoFrom.getData(true);
            nui.ajax({
                url: saveUrl,
                type: 'post',
                data: {
                    params: data
                },
                success: function (res) {
                    nui.unmask(document.body);
                    if (res.errCode == 'S') {
                        showMsg('数据保存成功', 'S');
                    } else {
                        showMsg('数据保存失败', 'E');
                    }
                    CloseWindow();
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