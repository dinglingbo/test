<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/common.jsp"%>
        <%@include file="/common/commonRepair.jsp"%>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>
            <!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
    <title>新增客户档案</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditGuset.js?v=1.1.65"></script>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
         a.optbtn {
        width: 60px; 
        height: 20px; 
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }
    </style>
</head>

<body>
    <div title="联系人信息" class="nui-window" id="contactview" style="width: 100%">
    	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="addContactList()" plain="true" style="width: 60px;" ><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onClose(1)" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" id="contactInfoForm">
            <input class="nui-hidden" name="id" />
            <input class="nui-hidden" name="guestId" />
            <table class="nui-form-table" style="width:100%;">
                <tr>
                    <td class="form_label required">
                        <label>姓名：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" id="name" name="name" width="100%" />
                    </td>
                    <td class="form_label required">
                        <label>手机：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" id="mobile2" name="mobile" width="100%" />
                    </td>
                </tr>
                <tr>

                    <td class="form_label required">
                        <label>身份：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="identity" id="identity" valueField="customid" textField="name" width="100%" value="0" />
                    </td>
                    <td class="form_label required">
                        <label>来源：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="source" id="source" valueField="customid" textField="name" width="100%" value="0" />
                    </td>
                </tr>
                <tr>
                     <td class="form_label">
                        <label>性别：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" id="sex" name="sex" data="[{id:0,text:'男'},{id:1,text:'女'},{id:2,text:'未知'}]" width="100%" value="0"
                        />
                    </td>
					<td class="form_label">
                        <label>身份证号码：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="idNo" width="100%" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>驾驶证号：</label>
                    </td>
                    <td>
                 	   <input class="nui-textbox" name="licenseNo" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>准备车型(A1)：</label>
                    </td>
                    <td>
                    	<input class="nui-textbox" name="licenseType" width="100%" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>初次领证时间：</label>
                    </td>
                    <td>
                        <input name="licenseRecordDate" allowInput="false" class="nui-datepicker" format="yyyy-MM-dd" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>驾照到期日期：</label>
                    </td>
                    <td>
                        <input name="licenseOverDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>生日类型：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="birthdayType" data="[{id:0,text:'农历'},{id:1,text:'阳历'}]" width="100%" value="0" />
                    </td>
                    <td class="form_label">
                        <label>生日：</label>
                    </td>
                    <td>
                        <input name="birthday" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>微信服务号：</label>
                    </td>
                    <td nowrap="nowrap">
                       <input class="nui-textbox" name="wechatServiceId" width="80%" id="wechatServiceId" />
                        <a class="optbtn" href="javascript:void()" onclick="wechatBin()">绑定</a>
                    </td>
                    <td class="form_label" colspan="1">
                       <label>微信ID：</label>
                    </td>
                    <td>
                       <input class="nui-textbox" name="wechatOpenId" width="100%" id="wechatOpenId" >
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>备注：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-textbox" name="remark" width="100%" />
                    </td>
                </tr>
            </table> 
        </div>
    </div>
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
                    <td colspan="3">
                        <input class="nui-textbox" name="carNo" id="carNo" onvaluechanged="onCarNoChanged"/>
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
                        <input name="annualVerificationDueDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
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
                        <input name="annualInspectionDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
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
                        <input name="insureDueDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
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
                        <label>生产日期：</label>
                    </td>
                    <td>
                        <input name="produceDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                    <td class="form_label"> 
                        <label>上牌日期：</label>
                    </td>
                    <td>
                        <input name="firstRegDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                <tr>

                    <td class="form_label">
                        <label>发证日期：</label>
                    </td>
                    <td>
                        <input id="issuingDate" name="issuingDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
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
            </table>
        </div>
    </div>
    <div class="nui-splitter" id="addEditCustomerPage" style="width:100%;height:100%;" vertical="true" borderStyle="border:0;"
        handlerSize="0" allowResize="false">
        <div size="240" showCollapseButton="false" style="border:0;">
            <div class="nui-panel" showToolbar="false" title="客户信息" showFooter="false" borderStyle="border:0;" style="width:100%;height:100%;">

                <div class="form" id="basicInfoForm">
                    <input class="nui-hidden" name="id" />
                    <table class="nui-form-table" style="width:99%">
                        <tr>
                            <td class="form_label required">
                                <label>客户名称：</label>
                            </td>
                            <td>
                                <input class="nui-hidden" name="id" id="guestId" />
                                <input class="nui-textbox" id="fullName" name="fullName" width="200px" onvaluechanged="onChanged(this.id)" />
                            </td>
                            <td class="form_label required">
                                <label>手机号码：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" id="mobile" name="mobile" width="100%" onvaluechanged="onChanged(this.id)"
                                  emptyText="请输入手机号查询" onenter="onChanged(this.id)"
                                 />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>性别：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]" textField="text" valueField="value" name="sex"
                                    value="0"  width="200px"/>
                            </td>
                            <td class="form_label ">
                                <label>客户简称：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" id="shortName" name="shortName" onValuechanged="processMobile(this.value)" width="100%" />
                            </td>
                        </tr>
                        <tr>
                        
                           <td class="form_label">
                                <label>客户级别：</label>
                            </td>
                            <td colspan="3">
                                <input name="guestTypeId"
                                   id="guestTypeId"
                                   class="nui-combobox "
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="32%" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                        	</td>
                           <!--  <td class="form_label">
                                <label>生日类型：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" data="[{value:'0',text:'农历',},{value:'1',text:'阳历'},]" textField="text" valueField="value" name="birthdayType"
                                    value="0"  width="200px"/>
                            </td>
                            <td class="form_label ">
                                <label>生日日期：</label>
                            </td>
                            <td>
                                <input name="birthday" allowInput="false" class="nui-datepicker" width="100%" />
                            </td> -->
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>地址：</label>
                            </td>
                            <td colspan="3">
                                <input name="provinceId" id="provice" valueField="code" textField="name" emptyText="省" url="" onValuechanged="initCityByParent('cityId', e.value || -1)"
                                    class="nui-combobox" width="32%" />

                                <input name="cityId" id="cityId" valueField="code" textField="name" emptyText="市/县" onValuechanged="initCityByParent('areaId', e.value || -1)"
                                    class="nui-combobox" width="33%" />

                                <input name="areaId" id="areaId" valueField="code" textField="name" emptyText="乡/镇" class="nui-combobox" width="33%" />

                                <input class="nui-textbox" name="addr" width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>备注：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" name="remark" width="100%" />
                            </td>
                        </tr>
                        <tr>

                            <td colspan="6" align="left">
                                <a class="nui-button" onclick="onOk" style="width:120px;margin-right:20px;">
                                    <span class="fa fa-save fa-lg"></span>&nbsp;保存客户信息</a>
                                <!-- <a class="nui-button" onclick="onCancel" style="width:60px;"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>


        <div showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div class="nui-tabs" activeIndex="0" style="width:100%;height: 85%;">
                    <div title="车辆信息">
                        <div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height:33px" id="toolbar1">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 90px;text-align:left;">
                                        <a class="nui-button" onclick="addCar()" id="addp">
                                            <span class="fa fa-plus fa-lg"></span>&nbsp;添加车辆 </a>
                                    </td>
                                    <td >
                                        <a class="nui-button" onclick="eaidCar()" id="addi">
                                            <span class="fa fa-edit fa-lg"></span>&nbsp;修改车辆 </a>
                                    </td>

                                </tr>
                            </table>
                        </div>
                        <div class="nui-fit">
                            <div id="cardatagrid" class="nui-datagrid" style="width: 100%;height:100%" showPager="false" sortMode="client" allowCellEdit="true" onrowdblclick="eaidCar()"
                                allowCellSelect="true" multiSelect="true"  editNextOnEnterKey="true">
                                <div property="columns">

                                    <div field="id" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        车辆ID
                                    </div>
                                    <div field="guestId" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        客户ID
                                    </div>
                                    <div field="carNo" allowSort="true" align="left" summaryType="count" headerAlign="center" width="">车牌号</div>
                                    <div field="vin" allowSort="true" align="left" headerAlign="center" width="160px" dataType="int">
                                        车架号(VIN)
                                    </div>
                                    <div field="carModelFullName" allowSort="true" align="left" headerAlign="center" width="160px" dataType="int">
                                        车型信息
                                    </div>
                                    
                                    <div field="annualVerificationDueDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        年审到期
                                    </div>
                                     <div field="annualInspectionDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        交强险到期
                                    </div>
                                    <div field="annualInspectionDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        商业险到期
                                    </div>
                                   
                                    <div field="insureNo" allowSort="true" align="left" headerAlign="center" width="">
                                        交强险单号
                                    </div>
                                   
                                    <div field="insureCompName" allowSort="true" align="left" headerAlign="center" width="">
                                      交强险投保公司
                                    </div>
           
                             
                                    <div field="annualInspectionCompName" allowSort="true" align="left" headerAlign="center" width="">
                                        商业险投保公司
                                    </div>
                                     <div field="engineNo" allowSort="true" align="left" headerAlign="center" width="">发动机号</div>
                                    <div field="produceDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        生产日期
                                    </div>
                                    <div field="firstRegDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        上牌日期
                                    </div>
                                    <div field="issuingDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        发证日期
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="联系人信息">
                        <div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height:33px" id="toolbar1">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 100px;text-align:left;">
                                        <a class="nui-button" onclick="addContact()" id="addp">
                                            <span class="fa fa-plus fa-lg"></span>&nbsp;添加联系人 </a>
                                    </td>
                                    <td >
                                        <a class="nui-button" onclick="eaidContact()" id="addi">
                                            <span class="fa fa-edit fa-lg"></span>&nbsp;修改联系人 </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-fit">
                            <div id="contactdatagrid" class="nui-datagrid" style="width: 100%;height:100%" showPager="false" sortMode="client" allowCellEdit="true" onrowdblclick="eaidContact()"
                                allowCellSelect="true" multiSelect="true"  editNextOnEnterKey="true" onDrawCell="onDrawCell">
                                <div property="columns">

                                    <div field="id" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        联系人ID
                                    </div>
                                    <div field="guestId" class="nui-hidden" allowSort="true" align="left" headerAlign="center" width="" visible="false">
                                        客户ID
                                    </div>
                                    <div field="name" allowSort="true" align="left" summaryType="count" headerAlign="center" width="">姓名</div>
                                    <div field="sex" allowSort="true" align="left" headerAlign="center" width="" dataType="int">
                                        性别
                                    </div>
                                    <div field="mobile" allowSort="true" align="left" headerAlign="center" width="" dataType="int">
                                        手机
                                    </div>
                                    <div field="identity" allowSort="true" align="left" headerAlign="center" width="">身份</div>
                                    <div field="source" allowSort="true" align="left" headerAlign="center" width="">
                                        来源
                                    </div>
                                    <div field="birthdayType" allowSort="true" align="left" headerAlign="center" width="">
                                        生日类型
                                    </div>
                                    <div field="birthday" allowSort="true" align="left" headerAlign="center" width="">
                                        生日
                                    </div>
                                     <div field="licenseRecordDate" allowSort="true" align="left" headerAlign="center" width="">
                                        初次领证日期
                                    </div>
                                    <div field="licenseOverDate" allowSort="true" align="left" headerAlign="center" width="">
                                        驾照到期日期
                                    </div>
                                     <div field="licenseNo" allowSort="true" align="left" headerAlign="center" width="">
                                        驾照证号
                                    </div>
                                    <div field="idNo" allowSort="true" align="left" headerAlign="center" width="">
                                        身份证号码
                                    </div>
                                     <div field="wechatServiceId" allowSort="true" align="left" headerAlign="center" width="">
                                        微信服务号
                                    </div>
                                      <div field="wechatOpenId" allowSort="true" align="left" headerAlign="center" width="">
                                        微信ID
                                    </div>
                                    <div field="remark" allowSort="true" align="left" headerAlign="center" width="">
                                        备注
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>

</html>