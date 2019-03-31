<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-29 15:58:11
  - Description:
-->
<head>
    <title>编辑保险公司</title>
    <script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceDetail.js?v=1.0.7"></script>
    <style type="text/css">
    table {
/*      table-layout: fixed;
     font-size: 12px;
     width: 100%; */
     
 }

 .form_label {
  /*   width: 120px; */
     text-align:left ;
 }

 .required {
     color: red;
 }
</style>
</head>
<body>
      <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:80%;">
            <tr>
                <td style="width:80%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="basicInfoForm" class="nui-form" style="padding-top:5px;">
        <table class="nui-form-table" style=" left:0;right:0;margin: 0 auto;">
            <tbody>
                <tr>
                    <td class="form_label required" >
                        <label>保险公司代码：</label>
                    </td>
                    <td style="width: 150px">
                        <input class="nui-textbox" name="code" id="code" >
                    </td>
                    <td style="width:50px;"></td>
                    <td class="form_label required">
                        <label>保险公司名称：</label>
                    </td>
                    <td style="width: 150px">
                        <input class="nui-textbox" name="fullName" >
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>保险公司缩写：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="shortName" >
                    </td>
                    <td ></td>
                    <td class="form_label">
                        <label>保险公司拼音：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="pyName" >
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>联系人：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="contactor" >
                    </td>
                    <td ></td>
                    <td class="form_label">
                        <label>联系人电话：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="contactorTel"  onvalidation="valid">
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>排序号：</label>
                    </td>
                    <td>
                        <input class="nui-spinner" name="orderIndex" minvalue="0" maxvlaue="1000000000"  inputstyle="text-align:right;">
                    </td>
                    <td ></td>
                    <td class="form_label">
                        <label>保险公司ID：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="id" readonly="readonly" >
                    </td>
                </tr>
                <tr>   
		            <td class="tbtext" colspan="2"><lable style="font-size: 14px;font-weight:550;">保险公司返点给门店</lable></td> 
					<td ></td>
		            <td class="tbtext" colspan="2"><lable style="font-size: 14px;font-weight:550;">门店返点给车主</lable></td> 
		
		        </tr>
                
                
                <tr>
                    <td class="form_label" >商业险返点：</td>
                    <td >
                        <input class="nui-textbox" name="rebateAgentToCompany1" vtype="float;range:0,100;">%
                    </td>
                    <td ></td>
                    <td class="form_label" >商业险返点：</td>
                    <td >
                        <input class="nui-textbox" name="rebateCompanyToGuest1" vtype="float;range:0,100;">%
                    </td>
                </tr>
                <tr>
                    <td class="form_label">交强险返点：</td>
                    <td>
                        <input class="nui-textbox" name="rebateAgentToCompany2" vtype="float;range:0,100;">%
                    </td>
                    <td ></td>
                    <td class="form_label">交强险返点：</td>
                    <td>
                        <input class="nui-textbox" name="rebateCompanyToGuest2" vtype="float;range:0,100;">%
                    </td>
                </tr>
                <tr>
                    <td class="form_label">车船税返点：</td>
                    <td>
                        <input class="nui-textbox" name="rebateAgentToCompany3" vtype="float;range:0,100;">%
                    </td>
                    <td ></td>
                    <td class="form_label">车船税返点：</td>
                    <td>
                        <input class="nui-textbox" name="rebateCompanyToGuest3" vtype="float;range:0,100;">%
                    </td>
                </tr>
                <tr>
                    <td class="form_label">商业险提成：</td>
                    <td>
                        <input type="radio" name="deductType1" value="1">固定提成
                        <input type="radio" name="deductType1" value="2">比例提成
                    </td>
                    <td ></td>
                    <td class="form_label">提成金额：</td>
                    <td>
                        <input class="nui-textbox" name="deductRate1">
                        <input class="nui-textbox" name="rid" visible="false"> <span id="vala"></span>

                    </td>
                </tr>
                <tr>
                    <td class="form_label">交强险提成：</td>
                    <td>
                        <input type="radio" name="deductType2" value="1">固定提成
                        <input type="radio" name="deductType2" value="2">比例提成
                    </td>
                    <td ></td>
                    <td class="form_label">提成金额：</td>
                    <td>
                        <input class="nui-textbox" name="deductRate2"> <span id="valb"></span>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">车船税提成：</td>
                    <td>
                        <input type="radio" name="deductType3" value="1">固定提成
                        <input type="radio" name="deductType3" value="2">比例提成
                    </td>
                    <td ></td>
                    <td class="form_label">提成金额：</td>
                    <td>
                        <input class="nui-textbox" name="deductRate3"> <span id="valc"></span>

                    </td>
                </tr>
            </tbody>
            </table>
        </div>
<!--         <div style="text-align:center;padding:10px;">    -->
<!--             <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a> -->
<!--             <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a> -->
<!--         </div> -->
    </body>
    </html>