<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<div title="基本信息" name="tab2" visible="true">
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend>客户信息</legend>
        <div style="padding:5px;">
            <input class="nui-hidden" name="id" />
            <input class="nui-hidden" name="guestId" />
            <input class="nui-hidden" id="visitStatus" name="visitStatus" />
            <input class="nui-hidden" id="status" name="status" />

            <table>
                <tr style="display:none;">
                    <td><input id="recorder" name="recorder" style="display:none;" class="nui-textbox width2" /></td>
                    <td><input id="recordDate" name="recordDate" class="nui-datepicker width2" dateFormat="yyyy-MM-dd hh:MM"
                            style="display:none;" emptyText="请选择日期" alwaysView="true" />
                    </td>
                    <td>
                        <input id="modifier" name="modifier" style="display:none;" class="nui-textbox width2" value="<b:write property='userName'/>" />
                    </td>
                    <td><input id="modifyDate" name="modifyDate" class="nui-datepicker width2" dateFormat="yyyy-MM-dd hh:MM"
                            style="display:none;" emptyText="请选择日期" alwaysView="true" />
                    </td>
                </tr>

                <tr>
                    <td><span class="title title-width1 required">客户名称：</span></td>
                    <td colspan="3"><input id="guestName" name="guestName" class="nui-textbox" style="width: 100%;"
                            required="true" onvaluechanged="guestNameChange" /></td>
                </tr>

                <tr>

                    <td><span class="title title-width1 ">联系人：</span></td>
                    <td><input id="contacts" name="contacts" class="nui-textbox width2" required="false" /></td>
                    <td><span class="title title-width1 ">性别：</span></td>
                    <td><input name="sex" id="sex" class="nui-combobox width2" textField="text" valueField="value"
                            emptyText="请选择..." data="const_gender" allowInput="false" showNullItem="false" />
                    </td>

                </tr>

                <tr>
                    <td><span class="title title-width1 required">手机号码：</span></td>
                    <td><input id="mobile" name="mobile" class="nui-textbox width2" required="true" /></td>
                    <td><span class="title title-width1 ">电话号码：</span></td>
                    <td><input id="tel" name="tel" class="nui-textbox width2" required="false" /></td>
                </tr>
                <tr>
                    <td><span class="title title-width1 ">客户地址：</span></td>
                    <td colspan="3"><input id="address" name="address" class="nui-textbox" style="width: 100%;" /></td>
                </tr>
                <tr>
                    <td><span class="title title-width1">身份证号：</span></td>
                    <td colspan="3"><input id="idCardNumber" name="idCardNumber" class="nui-textbox" style="width: 100%;" /></td>
                </tr>
            </table>

        </div>
    </fieldset>

    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend>车辆信息</legend>
        <div style="padding:5px;">
            <input class="nui-hidden" name="id" />

            <table>

                <tr>
                    <td><span class="title title-width1 required">车牌号：</span></td>
                    <td><input id="carNo" name="carNo" class="nui-textbox width2" required="true" /></td>
                    <td><span class="title title-width1 ">车辆品牌：</span>
                        <input id="carBrandName" name="carBrandName" class="nui-hidden" />
                    </td>
                    <td><input name="carBrandId" id="carBrandId" class="nui-combobox width2" textField="nameCn"
                            valueField="id" emptyText="请选择..." url="" allowInput="false" onValuechanged="onCarBrandChange"
                            showNullItem="false" nullItemText="请选择..." />
                    </td>
                </tr>
                <tr>
                    <td><span class="title title-width1 ">车架号(VIN)：</span></td>
                    <td colspan="3"><input id="vin" name="vin" class="nui-textbox width6" required="false" style="width:284px"/>
                        <a class="nui-button" onclick="onParseUnderpanNo()">解析车型</a>
                        <a class="nui-button" onclick="getCarModel(setCarModel)" visible="false">选择车型</a>
                        <!-- <a class="nui-button" iconCls="" plain="true" onclick="carVinModel()" id="query"><span class="fa fa-binoculars fa-lg"></span>&nbsp;解析</a> -->
                    </td>

                </tr>
                <tr>
                    <td><span class="title title-width1">车型信息：</span></td>
                    <td colspan="3">
                        <textarea id="carModelInfo" name="carModelInfo" class="mini-textarea width6" onValuechanged=""
                            onKeyup="carModelInfo.doValueChanged()" style="height: 80px;" emptyText="">
                    </textarea>
                    </td>

                </tr>
                <tr>

                    <td><span class="title title-width1 ">品牌车型：</span></td>
                    <input class="nui-hidden" id="_carModel" name="carModel" />
                    <td><input name="carModelId" id="carModelId" popupWidth="400px" class="nui-combobox width2"
                            textField="carModel" valueField="carModelId" emptyText="请选择..." onValuechanged="nui.get('_carModel').setValue(this.text)"
                            allowInput="false" showNullItem="false" nullItemText="请选择..." />
                    </td>
                    <td><span class="title title-width1 ">上牌日期：</span></td>
                    <td><input id="firstRegDate" name="firstRegDate" class="nui-datepicker width2" dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true" />
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
</div>