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
    <title>流失回访</title>
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
        .tbText{
            text-align: right;
            width:100px; 
        }
        .tmargin{
            /* width:calc(100% - 20px) */
            /* margin-top:20px; */
            line-height:30px;
            border-spacing: 0;  
            border-collapse: collapse; 
        }
    </style>
</head>

<body>
    <div class="nui-fit" id="form1">
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:100%;">
                <tbody>
                    <tr>
                        <td style="width:100%;"> <a class="nui-button" iconcls="" plain="true" onclick="save"><span
                                    class="fa fa-save fa-lg"></span>&nbsp;保存</a> <a class="nui-button" iconcls=""
                                plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <input visible="false" id="visitDate" name="visitDate" class="nui-datepicker textboxWidth" showtime="true"
            format="yyyy-MM-dd HH:mm" />
        <input visible="false" id="visitMode" name="visitMode" class="nui-combobox textboxWidth" datafield="data"
            valuefield="customid" textfield="name" value="011401" enabled="false" />
        <input visible="false" id="nowMtComp" name="nowMtComp" class=" nui-textbox textboxWidth" />
        <input visible="false" id="visitMan" name="visitMan" class="nui-combobox textboxWidth" allowinput="true"
            textfield="empName" valuefield="empName" emptytext="请选择..." nullitemtext="请选择..."
            onvaluechanged="visitManChanged" />
        <input visible="false" id="planComeDate" name="planComeDate" class="nui-datepicker textboxWidth" minvalue="0" />
        <table class="tmargin" >
            <tbody>
                <tr class="htr">
                    <td class="tbText">回访内容：</td>
                    <td colspan="3"> <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth"
                            style="width: 100%;height:150px;" /> </td>
                </tr>
                <tr class="htr"> 
                    <td class="tbText">不来厂主要原因：</td>
                    <td> <input id="mainReason" name="mainReason" class="nui-combobox textboxWidth" datafield="data"
                            valuefield="customid" textfield="name" /> </td>
                    <td class="tbText">不来厂明细原因：</td>
                    <td style="width:286px;"> <input id="subReason" name="subReason" class=" nui-combobox textboxWidth"
                            datafield="data" valuefield="customid" textfield="name" popupwidth="350px" 
                            style="width:100%;" /> </td>
                </tr>
                <tr class="htr">
                    <td class="tbText">是否继续跟进：</td>
                    <td > <input id="isContinueVisit" name="isContinueVisit"
                            class="nui-combobox textboxWidth" valuefield="id" textfield="text"
                            data="[{id:0,text:'是'},{id:1,text:'否'}]" /> </td>
                    <td class="tbText">下次跟进日期：</td>
                    <td > <input id="nextVisitDate" name="nextVisitDate"
                            class=" nui-datepicker textboxWidth" /> </td>

                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = apiPath + sysApi + "/";
        var visitModeCtrlUrl = apiPath + sysApi +
            "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
        var mainReasonUrl = baseUrl +
            "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000008&fromDb=true";
        var detailReasonUrl = baseUrl +
            "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000009&fromDb=true";
        var saveUrl = apiPath + crmApi + "/com.hsapi.crm.svr.visit.savevisitDetail.biz.ext";
        visitMode_ctrl = nui.get("visitMode");
        visitMode_ctrl.setUrl(visitModeCtrlUrl);
        var visitManEl = nui.get("visitMan");
        var visitIdEl = nui.get("visitId");
        var mainReason_ctrl = nui.get("mainReason");
        mainReason_ctrl.setUrl(mainReasonUrl);
        var subReason_ctrl = nui.get("subReason");
        subReason_ctrl.setUrl(detailReasonUrl);
        var tabForm = new nui.Form("#form1");
        var form = {};
        var mainData = null;
        nui.get("visitDate").setValue(new Date());


        initMember("visitMan", function () {
            visitManEl.setValue(currUserId);
            visitManEl.setText(currUserName);
        });

        function visitManChanged(e) {
            var sel = e.selected;
            visitIdEl.setValue(sel.empId);

        }

        function setData(rowData) {
            mainData = rowData;
        }

        function save() {
            var data = tabForm.getData();
            var record = {
                visitMode: data.visitMode,
                visitId: data.visitId,
                visitMan: data.visitMan,
                visitDate: data.visitDate,
                visitContent: data.visitContent,
                careDueDate: data.careDueDate,
                careDayCycle: data.careDayCycle,
                carId: mainData.carId,
                carNo: mainData.carNo,
                guestId: mainData.contactorId,
                serviceId: mainData.serviceId,
                serviceType: '4',
                mainId: mainData.id,
                isContinueVisit: data.isContinueVisit,
                mainReason: data.mainReason,
                subReason: data.subReason,
                planComeDate: data.planComeDate,
                nextVisitDate: data.nextVisitDate,
                nowMtComp: data.nowMtComp,
                guestSource: 0
            };
            nui.ajax({
                url: saveUrl,
                type: "post",
                data: {
                    params: record
                },
                success: function (text) {
                    if (text.errCode == "S") {
                        // var detailData = text.detailData;
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