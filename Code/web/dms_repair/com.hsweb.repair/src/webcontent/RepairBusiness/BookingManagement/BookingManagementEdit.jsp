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


        a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
        .addyytime a{width:150px;height:36px;line-height:36px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;text-align:center;color:#00b4f6;border-radius:4px;margin:0 15px 15px 0;}
        .addyytime a.hui{border:1px #e6e6e6 solid;color:#c8c8c8;background:#e6e6e6;}
        .addyytime a.xz{ border:1px #ff7800 solid; color:#fff; background:#ff7800;}
        a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #555555; text-decoration: none; }
        a:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #df0024; text-decoration: none; }
        a {text-decoration:none;transition:all .4s ease;}


    </style>

</head>

<body>
    <input id="scoutMode" class="nui-combobox" visible="false" />
    <input id="isUsabled" class="nui-combobox" visible="false" />
    <input id="bookStatus" class="nui-combobox" visible="false" />

    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk" style="width: 60px;">保存</a>
                            <a class="nui-button" onclick="onClose" style="width: 60px;">关闭</a>
                        </td>
                    </tr>
                </table>
            </div>
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
                        <td  class="form_label">
                            <label>预计来厂：</label>
                        </td>
                        <td>
                            <!-- <input id="predictComeDate"  name="predictComeDate" width="150px" class="nui-datepicker" format="yyyy-MM-dd H:mm" timeFormat="H:mm" showTime="true" 
                                allowInput="false" showTodayButton="false" ondrawdate="onDrawDate" viewDate="new Date()" nullValue="null" showOkButton="true"
                                showClearButton="false" required="true"/> -->
                            <input class="nui-combobox" id="timeStart" name="timeStart" textField="name"  ondrawdate="onDrawDate"
                                valueField="id" allowInput="false"  onValuechanged="setTimeChange" >
                        </td>
                    </tr>
                    <tr>
                        <td  class="form_label">
                        </td>
                        <td colspan="5">
                            <div class="addyytime">
                            </div>
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

        </div>
    </div>


    </div>
</body>

</html>