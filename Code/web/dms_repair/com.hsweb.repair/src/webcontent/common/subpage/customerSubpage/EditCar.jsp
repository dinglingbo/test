<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
  <div title="车辆信息" class="nui-window" id="carview" style="width: 100%">
    	  <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="addCarList()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onClose(2)" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
  	
        <div class="form" id="carInfoFrom">
            <input class="nui-hidden" name="id" />
            <input class="nui-hidden" name="guestId" />
            <input class="nui-hidden" name="carBrandId" id="carBrandId" />
            <input class="nui-hidden" name="carModelId" id="carModelId"/>
            <input class="nui-hidden" name="carModelIdLy" id="carModelIdLy"/>
            <input class="nui-hidden" name="insureCompName" id="insureCompName" />
            <input class="nui-hidden" name="annualInspectionCompName" id="annualInspectionCompName" />
            <table class="nui-form-table" style="width:100%;">
                <tr>
                    <td class="form_label required">
                        <label>车牌号：</label>
                    </td>
                    <td colspan="2">
                        <input class="nui-textbox" name="carNo" id="carNo" onvaluechanged="onCarNoChanged"/>
                    </td>
                    <td>
                        <a class="nui-button" onclick="parsingCarNo()">解析车牌(VIN)</a>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>车架号(VIN)：</label>
                    </td>
                    <td colspan="2">
                        <input class="nui-textbox" id="vin" name="vin" width="100%" />
                    </td>
                    <td>
                        <a class="nui-button" onclick="onParseUnderpanNo()">解析车型</a>
                        <a class="nui-button" onclick="getCarModel(setCarModel)">选择车型</a>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>车型信息：</label>
                    </td>
                    <td colspan="3">
                        <textarea class="nui-textarea" id="carModel" name="carModelFullName" width="100%"></textarea>
                    </td>
                </tr>
                <!--
                <tr>
                    <td class="form_label">
                        <label>品牌车型：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-buttonedit" name="carModelId" id="carModelId" onclick="selectCarModel('carModelId','carBrandId')" width="100%"/>
                    </td>
                </tr>
                -->
                <tr>
                    <td class="form_label">
                        <label>发动机号：</label>
                    </td>
                    <td>
                        <input name="engineNo" class="nui-textbox" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>年审到期：</label>
                    </td>
                    <td>
                        <input name="annualVerificationDueDate" format="yyyy-MM-dd" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>
                </tr>

                <tr>
                    <td class="form_label">
                        <label>商业险单号：</label>
                    </td>
                    <td>
                        <input name="annualInspectionNo" class="nui-textbox" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>商业险到期：</label>
                    </td>
                    <td>
                        <input name="annualInspectionDate" format="yyyy-MM-dd" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>商业险投保公司：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-combobox" name="annualInspectionCompCode" id="annualInspectionCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onannualInsureChange"
                        />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>交强险单号：</label>
                    </td>
                    <td>
                        <input name="insureNo" class="nui-textbox" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>交强险到期：</label>
                    </td>
                    <td>
                        <input name="insureDueDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>交强险投保公司：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-combobox" name="insureCompCode" id="insureCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onInsureChange"
                        />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>当前里程：</label>
                    </td>
                    <td>
                        <input name="lastComeKilometers" class="nui-textbox" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>下次保养里程：</label>
                    </td>
                    <td>
                        <input name="careDueMileage" class="nui-textbox" width="100%"/>
                    </td>
                </tr>
                <tr>
                     <td class="form_label"> 
                        <label>下次保养时间：</label>
                    </td>
                    <td>
                        <input name="careDueDate" allowInput="true" format="yyyy-MM-dd" timeFormat="H:mm:ss" class="nui-datepicker" width="100%"  
                          showTime="false" />
                    </td>
                    <td class="form_label">
                        <label>生产日期：</label>
                    </td>
                    <td>
                        <input name="produceDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                   
                </tr>
                <tr>
                    <td class="form_label"> 
                        <label>上牌日期：</label>
                    </td>
                    <td>
                        <input name="firstRegDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>发证日期：</label>
                    </td>
                    <td>
                        <input id="issuingDate" name="issuingDate" format="yyyy-MM-dd" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>

                    <!--   <td class="form_label" >
                        <label>公司内部车：</label>
                    </td>
                    <td>
                        <input name="isCompanyInside"
                               data="[{id:1,text:'是'},{id:0,text:'否'}]"
                               class="nui-combobox" width="100%"/>
                    </td> -->

                </tr>
                <tr>
	                <td class="form_label">
	                    <label>备注：</label>
	                </td>
	                <td colspan="3">
	                    <input class="nui-textbox" name="remark" width="85%" />
	                    
	                     <label>是否禁用：</label>
	                     <input type="checkbox" id="isDisabled" class="mini-checkbox"  name="isDisabled"  trueValue="1" falseValue="0" >
	                </td>
	            </tr>
                 <tr>
                    <td class="form_label">
                      
                    </td>
                    <td>
                     
                    </td>
                </tr>
            </table>
        </div>
    </div>
    