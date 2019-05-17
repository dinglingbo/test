<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 17:21:29
  - Description:
-->

    <head>
        <title>车辆登记</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
    </head>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .auto-style1 {
            height: 31px;
        }
        
        .td_title {
            width: 60px;
            text-align: right;
        }
        
        .style1 {
            width: 95px;
            text-align: right;
        }
        
        .style2 {
            width: 80px;
        }
        
        .style3 {
            width: 132px;
        }
        
        .style4 {
            width: 81px;
            text-align: right;
        }
        
        .style5 {
            width: 81px;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap!important;
        }
    </style>

    <body>
        <table style="width: 100%; line-height: 23px; padding-top: 10px; padding-left: 5px;">
            <tr>
                <td class="td_title">销售单号
                </td>
                <td>
                    <input id="sp_SailNo" style="width: 100px" disabled class="nui-textbox" />
                </td>
                <td class="td_title">车牌号码
                </td>
                <td>
                    <input id="sp_CarNo" style="width: 100px" class="nui-textbox" />
                </td>
                <td class="td_title">车牌颜色
                </td>
                <td>
                    <input class="nui-combobox" id="CarNumColor" style="width: 100px;" editable="false" />
                </td>
                <td class="td_title">档案编号
                </td>
                <td>
                    <input id="sp_DocumentNo" style="width: 100px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td align="right">驾驶员
                </td>
                <td>
                    <input id="sp_CarMan" style="width: 100px" class="nui-textbox" />
                </td>
                <td align="right">驾驶证号
                </td>
                <td>
                    <input id="sp_CarManNo" style="width: 100px" class="nui-textbox" />
                </td>
                <td align="right">驾证类型
                </td>
                <td>
                    <select id="sp_CarManKind" class="nui-combobox" style="width: 100px;" editable="false">
                            <option value="A照">A照</option>
                            <option value="B照">B照</option>
                            <option value="C照" selected="selected">C照</option>
                        </select>
                </td>
                <td align="right">出生日期
                </td>
                <td>
                    <input id="sp_BirthDate" style="width: 100px" editable="false" class="nui-datepicker" />
                </td>
            </tr>
            <tr>
                <td align="right">手机号码
                </td>
                <td>
                    <input id="sp_Phone" style="width: 100px" class="nui-textbox" />
                </td>
                <td align="right">联系电话
                </td>
                <td>
                    <input id="sp_LinkWay" style="width: 100px" class="nui-textbox" />
                </td>
                <td align="right">联系地址
                </td>
                <td colspan="3">
                    <input id="sp_LinkAddress" style="width: 290px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td colspan="1" align="right" style="width:95px;">交强险保险公司
                </td>
                <td colspan="3">
                    <input id="sp_cmbqxUnit" class="nui-combobox" editable="false" style="width: 305px" />
                </td>
                <td align="right">保险单号
                </td>
                <td>
                    <input id="sp_txtInsuranceNum1" class="nui-textbox" style="width: 100px" />
                </td>
                <td align="right">保险到期
                </td>
                <td>
                    <input id="sp_dttInsuranceLastDate1" class="nui-datepicker" editable="false" style="width: 100px" />
                </td>
            </tr>
            <tr>
                <td colspan="1" align="right" style="width:95px;">商业险保险公司
                </td>
                <td colspan="3" align="left">
                    <input id="sp_cmbsyUnit" class="nui-combobox" editable="false" style="width: 305px" />
                </td>
                <td align="right">保险单号
                </td>
                <td>
                    <input id="sp_txtInsuranceNum2" class="nui-textbox" style="width: 100px" />
                </td>
                <td align="right">保险到期
                </td>
                <td>
                    <input id="sp_dttInsuranceLastDate2" class="nui-datepicker" editable="false" style="width: 100px" />
                </td>
            </tr>
            <tr>
                <td align="right" style="width:95px;">车辆年审日期
                </td>
                <td>
                    <input id="sp_CLNSDate" style="width: 100px" class="nui-datepicker" editable="false" />
                </td>
                <td align="right" style="width:95px;">驾证年审日期
                </td>
                <td>
                    <input id="sp_JZNSDate" style="width: 100px" class="nui-datepicker" editable="false" />
                </td>
                <td align="right" style="width:95px;">下次保养日期
                </td>
                <td>
                    <input id="sp_XCBYDate" style="width: 100px" class="nui-datepicker" editable="false" />
                </td>
                <td align="right" style="width:95px;">下次保养里程
                </td>
                <td>
                    <input id="sp_XCBYLC" numbertype="Integer" min="0" class="nui-textbox usernumber" onchange="CommonJSNumberChange(this)" style="width: 70px;" value="1" />公里
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-right: 13px" colspan="8">
                    <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="js"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>