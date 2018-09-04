<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>参数设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/basic/sysSet.js?v=2.0.0"></script>
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

    .right{
        text-align: right;
    }  
    .fwidtha{
        width: 120px;
    }
    .fwidthb{
        width: 120px;
    }
    .htr{
        height: 30px;
    }
    .mainwidth{
        width: 1100px;
    }
    .tmargin{
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .vpanel{
        border:1px solid #d9dee9;
        margin:10px 0px 0px 20px;
        height:248px;
        float:left;
    }
    .vpanel_heading{
        border-bottom:1px solid #d9dee9;
        width:100%;
        height:28px;
        line-height:28px;
    }
    .vpanel_heading span{
        margin:0 0 0 20px;
        font-size:16px;
        font-weight:normal;
    }
    .vpanel_bodyww{
        padding : 10 10 10 10px !important

    }

    .required {
        color: red;
    }

</style>
</head>
<body>
    <div class="nui-toolbar" style="padding:10px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
    </div>
    <div class="nui-fit" id= "comForm">
        <input class="nui-hidden" id="orgid" name="orgid"/>
        <input id="recordDate" name="recordDate" class="nui-hidden" />
        <input id="recorder" name="recorder" class="nui-hidden" />
        <input id="address" name="address" class="nui-hidden" />
        <input id="modifyDate" name="modifyDate" class="nui-hidden" />
        <input id="modifier" name="modifier" class="nui-hidden" />
        <div class="vpanel mainwidth" style="height:auto;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>基本信息</span></div>
            <div class="vpanel_body vpanel_bodyww">

                <table class="tmargin">
                    <tr class="htr">
                        <td class=" right fwidtha required">编码:</td>
                        <td ><input id="code" name="code" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb required">公司全称:</td>
                        <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb required">公司简称:</td>
                        <td ><input id="shortName" name="shortName" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb required">联系电话:</td>
                        <td ><input id="tel" name="tel" width="100%" class="nui-textbox" ></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidtha">传真:</td>
                        <td ><input id="fax" name="fax" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb">投诉电话:</td>
                        <td ><input id="complainTel" name="complainTel" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb">救援电话:</td>
                        <td ><input id="rescueTel" name="rescueTel" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb">广告语1:</td>
                        <td ><input id="slogan1" name="slogan1" width="100%" class="nui-textbox" ></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidthb">广告语2:</td>
                        <td ><input id="slogan2" name="slogan2" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidtha">备注:</td>
                        <td ><input id="remark" name="remark" width="100%" class="nui-textbox" ></td>
                    </tr>
                </table>

            </div>
        </div>

        <div class="vpanel mainwidth" style="height:auto;">
            <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>管理信息</span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr class="htr">
                        <td class=" right fwidtha required">省:</td>
                        <td><input id="provinceId" name="provinceId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onProvinceChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择省份..." emptytext="选择省份" shownullitem="true"></td>
                        <td class=" right fwidthb required">市:</td>
                        <td><input id="cityId" name="cityId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onCityChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择市..." emptytext="选择市" shownullitem="true"></td>
                        <td class=" right fwidthb required">乡/镇:</td>
                        <td><input id="countyId" name="countyId" class="nui-combobox" textField="name" valueField="code"     dataField="" onvaluechanged="onCountyChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择乡/镇..." emptytext="选择乡/镇" shownullitem="true"></td>
                        <td class=" right fwidthb required">详细地址:</td>
                        <td><input id="streetAddress" onvaluechanged="onStreetChange" name="streetAddress" width="100%" class="nui-textbox" ></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidtha">经度:</td>
                        <td><input id="longitude" vtype="float" onvalidation="onFloatValidate" name="longitude" width="100%" class="nui-textbox"  ></td>
                        <td class=" right fwidthb">纬度:</td>
                        <td><input id="latitude" vtype="float" onvalidation="onFloatValidate" name="latitude" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidthb">开户银行:</td>
                        <td><input id="bankName" name="bankName" width="100%" class="nui-textbox"  ></td>
                        <td class=" right fwidthb">银行账号:</td>
                        <td><input id="bankAccountNumber" name="bankAccountNumber" width="100%" class="nui-textbox" ></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidtha">主修品牌:</td>
                        <td><input id="mainBrandId" name="mainBrandId" class="nui-combobox" textField="SHORTNAME" valueField="ID"     dataField="mm" onvaluechanged="onCompChange"
                            url="" valueFromSelect="true" allowinput="true" width="100%"
                            nullitemtext="选择品牌..." emptytext="选择品牌" shownullitem="true"></td>
                        <td class=" right fwidthb">网站:</td>
                        <td><input id="webaddress" name="webaddress" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidtha">配件行情<br>过期日期</td>
                        <td><input name="partExpireDate" id="partExpireDate" width="100%" showTime="true" class="nui-datepicker" enabled="true" format="yyyy-MM-dd"/></td>
                        <td class=" right fwidthb">滞销商品<br>过期天数</td>
                        <td><input id="unsalableDays" vtype="int" onvalidation="onFloatValidate" name="unsalableDays" width="100%" class="nui-textbox" ></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidtha">是否关闭系统:</td>
                        <td><input id="isOpenSystem" name="isOpenSystem" width="100%" class="nui-combobox" data="ynData" textfield="text" valuefield="id"></td>
                        <td class=" right fwidthb">是否启用流程:</td>
                        <td><input id="isOpenProcess" name="isOpenProcess" width="100%" class="nui-combobox" data="ynData" textfield="text" valuefield="id"></td>
                        <td class=" right fwidtha">是否启用财务:</td>
                        <td><input id="isUnifyFinancial" name="isUnifyFinancial" width="100%" class="nui-combobox" data="ynData" textfield="text" valuefield="id"></td>
                        <td class=" right fwidthb">是否启用核算:</td>
                        <td><input id="isAccount" name="isAccount" width="100%" class="nui-combobox" data="ynData" textfield="text" valuefield="id"></td>
                    </tr>
                    <tr class="htr">
                        <td class=" right fwidtha">开大税率:</td>
                        <td><input id="widenTaxRate" name="widenTaxRate" width="100%" class="nui-textbox"  ></td>
                        <td class=" right fwidthb">配件管理费率:</td>
                        <td><input id="partManageRate" name="partManageRate" width="100%" class="nui-textbox" ></td>
                        <td class=" right fwidtha">报表标题:</td>
                        <td><input id="reportTitle" name="reportTitle" width="100%" class="nui-textbox"  ></td>
                        <td class=" right fwidthb">是否启用<br>数据共享</td>
                        <td><input id="isDataShare" name="isDataShare" width="100%" class="nui-combobox" data="ynData" textfield="text" valuefield="id"></td>
                    </tr>

                </table>

            </div>
        </div>

        <div style="clear: both"></div>
        <!-- <div class="mainwidth" style="margin-top:25px;" align="center">
            <a class="mini-button" id="saveBtn" onclick="SaveData" style="width:60px;margin-right:20px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
        </div> -->
    </div>
</body>
</html>