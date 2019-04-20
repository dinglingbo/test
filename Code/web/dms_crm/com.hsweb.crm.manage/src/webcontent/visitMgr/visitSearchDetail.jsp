<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-29 14:11:16
  - Description:
-->

<head>
    <title>高级查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
        .form_table {
            width: 100%;
            table-layout: fixed;
            border-right: 15px;
            line-height: 30px;
        }

        .form_table tr {
            height: 30px;
        }

        .tbtext {
            text-align: right;
            width: 90px;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" plain="true" onclick="CloseWindow('ok')" id="add" enabled="true"><span
                            class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('no')"><span
                            class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit" id="form1" style="padding: 0px 20px 0px 0px;">
        <table class="form_table">
            <!-- <tr>
                    <td class="tbtext" ><label for="">下次回访日期：</label>
                    </td><td  colspan="3" >
                        <input id="nextVisitDateS" name="nextVisitDateS" class="nui-datepicker textboxWidth" format="yyyy-MM-dd " >
                    <label >至</label>
                    <input id="nextVisitDateE" name="nextVisitDateE" class="nui-datepicker textboxWidth" format="yyyy-MM-dd HH:mm" timeFormat="HH:mm" showTime="true">
                    </td>
                </tr> -->

            <tr>
                <td class="tbtext">下次回访日期：</td>
                <td><input id="sNextVisitDay" name="sNextVisitDay" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
                <td class="tbtext">至：</td>
                <td> <input id="eNextVisitDay" name="eNextVisitDay" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
            </tr>
            <tr>
                <td class="tbtext">进厂日期：</td>
                <td><input id="sEnterDate" name="sEnterDate" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
                <td class="tbtext">至：</td>
                <td> <input id="eEnterDate" name="eEnterDate" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
            </tr>
            <tr>
                <td class="tbtext">离厂日期：</td>
                <td><input id="sOutDate" name="sOutDate" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
                <td class="tbtext">至：</td>
                <td> <input id="eOutDate" name="eOutDate" class="nui-datepicker textboxWidth"
                        format="yyyy-MM-dd "></td>
            </tr>
            <tr>
                <td class="tbtext">客户等级：</td>
                <td>        <input class="nui-combobox textboxWidth" name="level" id="level" required="false" multiSelect="true"
                    textField="name" valueField="id" allowInput="false"  /></td>
                <td class="tbtext">回访类型：</td>
                <td><input class="nui-combobox textboxWidth" name="dataType" id="dataType"  required="false" multiSelect="true"
                    data="dataTypeIdList" textField="name" valueField="id"></td>
            </tr>
            <tr>
                <td class="tbtext">回访次数：</td>
                <td> <input class="nui-textbox" name="sVisitTimes" id="sVisitTimes" style="width: 69px;" vtype="int" value=""/>
                    <label>-</label>
                    <input class="nui-textbox" name="eVisitTimes" id="eVisitTimes" style="width: 69px;" vtype="int" value=""/>
                
                </td>
                <td class="tbtext">离厂天数：</td>
                <td><input class="nui-textbox" name="sLeaveDays" id="leaveNumS" style="width: 69px;" vtype="int" value=""/>
                    <label>-</label>
                    <input class="nui-textbox" name="eLeaveDays" id="leaveNumE" style="width: 69px;" vtype="int" value=""/>
                </td>
            </tr>
        </table>

    </div>

    <script type="text/javascript">
    var dataTypeIdList = [{id:1,name:"第一次回访"},{id:2,name:"第二次回访"},{id:3,name:"第三次回访"}]; 
        nui.parse();
        var form = new nui.Form("#form1");

        //initCarBrand("carBrandId"); //车辆品牌s

        initGuestType("level", function (data) {
        levelList = nui.get("level").getData();
        levelList.forEach(function(v) {
	        levelHash[v.id] = v;
	    });//客户级别 
    });

        nui.get("add").focus();
        document.onkeyup = function (event) {
            var e = event || window.event;
            var keyCode = e.keyCode || e.which; //38向上 40向下

            if ((keyCode == 27)) { //ESC
                onClose();
            }
        };

        function getData() {
            var data = form.getData(true);
            return data;
        }


        function CloseWindow(action) {
            if (action == "close") {} else if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                return window.close();
        }

        function onClose() {
            window.CloseOwnerWindow();
        }
    </script>
</body>

</html>