<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
  <title>工单设置</title>
  <script src="<%=webPath + sysDomain%>/config/js/comParamsSet.js?v=1.0.0"></script>
  <style type="text/css">

    .title {
       width: 60px;
       text-align: right;
	}
	
	.form_label {
	   width: 72px;
	   text-align: right;
	}
	
	.required {
	   color: red;
	}
	
	.rmenu {
	  font-size: 14px;
	  /* font-weight: bold; */
	  text-align: left;
	  margin: 0;
	  padding-left: 25px;
	  height: 18px;
	  color: #fff;
	  width: auto;
	  margin-left: 20px;
	  margin-top: 20px;
	  background-size: 50%;
	}
	
	.tbtext{
	  text-align: right;
	  line-height: 40px;
	}

</style>

</head>
<body>

    <div id="basicInfoForm" class="form" contenteditable="false" >
        <table class="table" id="table1"> 
            <tr>
                <td class="tbtext">综合服务单流程控制：</td>
                <td class="tbCtrl" >
                    <div id="repairBillControlFlag" name="repairBillControlFlag" 
                         class="nui-radiobuttonlist" value="" repeatItems="2" 
                         repeatDirection="" repeatLayout="table" 
                         textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">完工、结算配件必须出库：</td>
                <td class="tbCtrl" >
                    <div id="repairBillPartFlag" name="repairBillPartFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">小票、结算单显示结算二维码<br>或微信公众号二维码：</td>
                <td class="tbCtrl" >
                    <div id="repairBillQrcodeFlag" name="repairBillQrcodeFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">微信车主端服务详细直接结算：</td>
                <td class="tbCtrl" >
                    <div id="repairBillQrSettleFlag" name="repairBillQrSettleFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">车型可自由填写：</td>
                <td class="tbCtrl" >
                    <div id="repairBillCmodelFlag" name="repairBillCmodelFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">是否隐藏手机号：</td>
                <td class="tbCtrl" >
                    <div id="repairBillMobileFlag" name="repairBillMobileFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr>
            <tr>
                <td class="tbtext">哪些类别工时开单不能改价：</td>
                <td class="tbCtrl" >
                    <div id="editParice" name="editParice" class="nui-checkboxlist" repeatItems="5" 
                    repeatLayout="flow"  value="" 
                    textField="text" valueField="id" ></div>
                </td>
            </tr>
            <tr>
                <td class="tbtext">税率比例：</td>
                <td class="tbCtrl" >
                    <input id="rate" name="rate" onvalidation="onRateValidation" class="nui-textbox" >
                </td>
            </tr>
            <tr>
                <td class="tbtext">结算单打印抬头显示：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShow" name="repairSettorderPrintShow" class="nui-textbox" >
                </td>
            </tr>
            <tr>
                <td class="tbtext">结算单打印内容：</td>
                <td class="tbCtrl" >
                    <input id="repairSettPrintContent" name="repairSettPrintContent" class="nui-textarea" 
                           style="height:100px;width:300px">
                </td>
            </tr>
            <tr>
                <td class="tbtext">委托单打印内容：</td>
                <td class="tbCtrl" >
                    <input id="repairEntrustPrintContent" name="repairEntrustPrintContent" class="nui-textarea" 
                           style="height:100px;width:300px">
                </td>
            </tr>
            <tr>
                <td class="tbtext">工单服务性质对健康档案不开放：</td>
                <td class="tbCtrl" >
                    <div id="openToArchives" name="openToArchives" class="nui-checkboxlist" repeatItems="5" 
                        repeatLayout="flow"  value="" 
                        textField="text" valueField="id" ></div>
                </td>
            </tr>
            <tr>
                <td class="tbtext">工单服务性质对车主微信端不开放：</td>
                <td class="tbCtrl" >
                    <div id="openToGuestQrcode" name="openToGuestQrcode" class="nui-checkboxlist" repeatItems="5" 
                        repeatLayout="flow"  value="" 
                        textField="text" valueField="id" ></div>
                </td>
            </tr>
            <tr>
                <td class="tbtext"></td>
                <td class="tbCtrl" >
                    <a class="nui-button" onclick="save()"   plain="false" >保存</a>
                </td>
            </tr>
        </table>
    </div>

<script type="text/javascript">
   nui.parse();

</script>
</body>
</html>