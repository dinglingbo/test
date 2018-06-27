<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/commonRepair.jsp"%>
<html>
<!--
- Author(s): steven
- Date: 2018-01-26 11:24:15
- Description:
-->

<head>
    <title>预约管理</title>
    <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/BookingManagement/BookingManagementEdit.js?v=1.3"></script>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 84px;
            text-align: right;
        }

        .required {
            color: red;
        }
    </style>

</head>

<body>
    <input id="scoutMode" class="nui-combobox" visible="false" />
    <input id="isUsabled" class="nui-combobox" visible="false" />
    <input id="bookStatus" class="nui-combobox" visible="false" />

    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">

            <div class="nui-form" id="basicInfoForm">

                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr>

                        <td class="form_label">
                            <label>车牌号：</label>
                        </td>
                        <td>
                            <input class="nui-buttonedit" id="carNo" name="carNo" textname="carNo" emptyText="请输入或选择..." onbuttonclick="selectCustomer" selectOnFocus="true" required="true"/>
                            <input class="nui-textbox" id="carId" name="carId" visible="false" />
                        </td>
                        <td class="form_label">
                            <label>品牌：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="carBrandId" name="carBrandId" allowInput="true" valueField="id" textField="name" onvaluechanged="onCarBrandChange" required="true"
                            />
                        </td>
                        <td class="form_label">
                            <label>车系：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="carSeriesId" name="carSeriesId" allowInput="true" textField="name" valueField="id" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>客户名称：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="contactorName" name="contactorName" required="true"/>
                        </td>
                        <td class="form_label">
                            <label>联系电话：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="contactorTel" id="contactorTel" required="true"/>
                        </td>
                        <td class="form_label">
                            <label>业务类型：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="serviceTypeId" name="serviceTypeId" textField="name" valueField="id" required="true"/>

                        </td>
                    </tr>
                    <tr>
                        <td  class="form_label">
                            <label>预计来厂：</label>
                        </td>
                        <td>
                            <input id="predictComeDate"  name="predictComeDate" width="150px" class="nui-datepicker" format="yyyy-MM-dd H:mm" timeFormat="H:mm" showTime="true" 
                                allowInput="false" showTodayButton="false" ondrawdate="onDrawDate" viewDate="new Date()" nullValue="null" showOkButton="true"
                                showClearButton="false" required="true"/>
                        </td>

                        <td class="form_label">
                            <label>预约类型：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" name="prebookCategory" id="prebookCategory" textField="name" valueField="id" required="true"/>
                        </td>
                        <td class="form_label">
                            <label>服务顾问：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="mtAdvisorId" name="mtAdvisorId" value="" textField="empName" valueField="empId" onvaluechanged="onMTAdvisorIdChange" required="true"/>
                            <input class="nui-textbox" id="mtAdvisor" name="mtAdvisor" visible="false" />
                        </td>
                        <td>
                            <input class="nui-textbox" name="id" id="id" visible="false" />
                        </td>
                    </tr>

                    <tr>
                        <td class="form_label">
                            <label>客户描述：</label>
                        </td>
                        <td colspan="5">
                            <textarea class="nui-textarea" width="100%" height="180px" id="faultDesc" name="faultDesc"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center; padding: 1px;">
                <a class="nui-button" onclick="onOk" style="width: 60px;">保存(S)</a>
                <a class="nui-button" onclick="onClose" style="width: 60px;">关闭(C)</a>
            </div>

        </div>
    </div>


    </div>
</body>

</html>