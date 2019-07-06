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
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditGuset.js?v=1.3.0"></script>
    <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
        table {
            font-size: 12px !important;
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
    a{
cursor: pointer;
}
 	.max_img{
		display: none;
		position: absolute;
		bottom: 0;
		left: 120px; 
		width:500px;
		height:530px;
		z-index:999;
		margin:0 auto;		
	}
	 	.max_img1{
		display: none;
		position: absolute;
		bottom: 0;
		left: 120px; 
		width:450px;
		height:370px;
		z-index:999;
		margin:0 auto;		
	}
	
    </style>
</head>

<body>
   <%--   <div class="" style="width:100%; height:110px" >
    <%@include file="/repair/RepairBusiness/Reception/repairCarInfo.jsp" %>
    </div> --%>
   <%@include file="/repair/common/subpage/customerSubpage/EditContactor.jsp" %>
   <%@include file="/repair/common/subpage/customerSubpage/EditCar.jsp" %>
  
      <div class="nui-splitter" id="addEditCustomerPage" style="width:100%;height:100%;" vertical="true" borderStyle="border:0;"
        handlerSize="0" allowResize="false">
        <div size="260" showCollapseButton="false" style="border:0;">
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
                                   width="200px" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                        	</td>
        
                        </tr>
                        <tr>
                        	 <td class="form_label ">
		                        <label>客户属性：</label>
		                    </td>
		                    <td>
		                        <input class="nui-combobox" name="guestProperty" id="guestProperty" valueField="customid" textField="name" width="200px" value="013902" />
		                    </td> 
		                    <td class="form_label ">
		                        <label>客户属性特点：</label>
		                    </td>
		                    <td>
		                        <input class="nui-textbox" name="propertyFeatures" id="propertyFeatures"  width="100%"  />
		                    </td> 
                        </tr>
						<tr>
                            <td class="form_label">
                                <label>地址：</label>
                            </td>
                            <td colspan="3">
                                <input name="provinceId" id="provice" valueField="code" textField="name" emptyText="省" url="" onvaluechanged="onProvinceChange"
                                    class="nui-combobox" width="32%" />

                                <input name="cityId" id="cityId" valueField="code" textField="name" emptyText="市/县" onvaluechanged="onCityChange"
                                    class="nui-combobox" width="33%" />

                                <input name="areaId" id="areaId" valueField="code" textField="name" emptyText="乡/镇" class="nui-combobox" width="33%" onvaluechanged="onCountyChange"/>
                            </td>
                        </tr>
                        <tr>
			                <td class="form_label"><label>详细地址:</label></td>
			                <td colspan="3"><input class="nui-textbox tabwidth" name="streetAddress" id="streetAddress" onvaluechanged="onStreetChange" width="66%"/></td>			
			            </tr>
			            <tr>
			                <td class="form_label"><label>组合地址:</label></td>
			                <td colspan="3"><input class="nui-textbox tabwidth" enabled="true" name="addr" id="addr" width="66%"/></td>			
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
                                    <td style="width: 90px;text-align:left;">
                                        <a class="nui-button" onclick="eaidCar()" id="addi" >
                                            <span class="fa fa-edit fa-lg"></span>&nbsp;修改车辆 </a>
                                    </td>
                                    <td style="width: 90px;text-align:left;">
                                        <a class="nui-button" onclick="mergeCar()" id="">
                                            <span class="fa fa-edit fa-lg"></span>&nbsp;资料合并
                                        </a>
                                    </td>
                                    <td style="text-align:left;">
                                        <a class="nui-button" onclick="split()" id="split">
                                            <span class="fa fa-edit fa-lg"></span>&nbsp;资料拆分
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-fit">
                            <div id="cardatagrid" class="nui-datagrid" style="width: 100%;height:100%" showPager="false" sortMode="client" allowCellEdit="true" onrowdblclick="eaidCar()"
                                allowCellSelect="true" multiSelect="true"  editNextOnEnterKey="true"   showSummaryRow="true"
                                >
                                <div property="columns">
                                    <div type="checkcolumn" width="50" class="mini-radiobutton" header="选择"></div>
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
                                        注册日期
                                    </div>
                                    <div field="issuingDate" allowSort="true" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        发证日期
                                    </div>
                                    <div field="lastComeKilometers" allowSort="true" visible="false" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        当前里程
                                    </div>
                                    <div field="careDueDate" allowSort="true" visible="false" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        下次保养里程
                                    </div>
                                    <div field="careDueDate" allowSort="true" visible="false" dateFormat="yyyy-MM-dd" align="left" headerAlign="center" width="">
                                        下次保养时间
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