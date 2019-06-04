<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    <style type="text/css">

	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
	    	width:150px;
	    	height:100px;
/* 		    max-width: 100%;
		    height: auto; */
		    vertical-align: middle;
	    }
	    .windowsss{
	    	z-index: 100;
	    	margin: auto;
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	right: 0;
	    	bottom: 0;
	    }
	    .imgList{
	    	overflow: auto;
	    	border: 1px solid #B8B8B8;
		    border-radius: 5%;
		    height: 380px;
		    width: 315px;
		    padding: 10px;
	    }
	    .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    	cursor: pointer;
	    	width:150px;
	    	height: 100px;
	    	display:inline-block;
	    }
	    .imgListOneDiv{
	    	background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
    		position: absolute;
    		width: 278px;
    		
    		height: 182px;
    		padding-top: 50px;
	    }
	    .imgListone{
		    width: 28px;
    		height: 28px;
    		position: relative;
    		margin-bottom: -90px;
    		margin-left: 35%;
    		cursor: pointer;
	    }
	    .imgListtwo{
		   	width: 28px;
    		height: 28px;
    		position: relative;
    		margin-bottom: 100px;
    		margin-left: 50%;
    		cursor: pointer;
	    }

	    body .mini-tabs-plain .mini-tabs-scrollCt{
	    	background-color: DEEDF7;
	    }
	    .mini-tabs-position-top .mini-tabs-plain .mini-tabs-header{
	    	margin-top: 4px;
	    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px !important;
	    }
    </style>
    <div title="车辆信息" class="nui-window" id="carview" style="width:100%;height:100%">
        <div class="nui-tabs" activeIndex="0" style="width:100%;height: 100%;">
            <div title="基本信息" >
                <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td >
                                <a class="nui-button" onclick="addCarList()" plain="true" style="width: 60px;">
                                    <span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                    <a class="nui-button" onclick="onClose(2)" plain="true" style="width: 60px;">
                                        <span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="form" id="carInfoFrom">
                    <input class="nui-hidden" name="id" />
                    <input class="nui-hidden" name="guestId" />
                    <input class="nui-hidden" name="carBrandId" id="carBrandId" />
                    <input class="nui-hidden" name="carModelId" id="carModelId" />
                    <input class="nui-hidden" name="carModelIdLy" id="carModelIdLy" />
                    <input class="nui-hidden" name="insureCompName" id="insureCompName" />
                    <input class="nui-hidden" name="annualInspectionCompName" id="annualInspectionCompName" />
                    <table class="nui-form-table" style="width:100%;">
                        <tr>
                            <td class="form_label required">
                                <label>车牌号：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" name="carNo" id="carNo" onvaluechanged="onCarNoChanged" />
                                <a class="nui-button" onclick="parsingCarNo()">获取车架号(VIN)</a>
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
                                <label>生产日期：</label>
                            </td>
                            <td>
                                <input name="produceDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
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
                                <input class="nui-combobox" name="annualInspectionCompCode" id="annualInspectionCompCode" valueField="id" textField="fullName"
                                    width="100%" onvaluechanged="onannualInsureChange" />
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
                                <label>发证日期：</label>
                            </td>
                            <td>
                                <input id="issuingDate" name="issuingDate" format="yyyy-MM-dd" allowInput="true" class="nui-datepicker" width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>注册日期：</label>
                            </td>
                            <td>
                                <input name="firstRegDate" id="firstRegDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                            </td>
                            <td class="form_label">
                                <label>年审到期：</label>
                            </td>
                            <td>
                                <input name="annualVerificationDueDate" id="annualVerificationDueDate" format="yyyy-MM-dd" allowInput="true" class="nui-datepicker" width="100%" />
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
                                <label>下次保养时间：</label>
                            </td>
                            <td>
                                <input name="careDueDate" allowInput="true" format="yyyy-MM-dd" timeFormat="H:mm:ss" class="nui-datepicker" width="100%"
                                    showTime="false" />
                            </td>
                            <td class="form_label">
                                <label>下次保养里程：</label>
                            </td>
                            <td>
                                <input name="careDueMileage" class="nui-textbox" width="100%" />
                            </td>

                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>备注：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" name="remark" width="85%" />

                                <label>是否禁用：</label>
                                <input type="checkbox" id="isDisabled" class="mini-checkbox" name="isDisabled" trueValue="1" falseValue="0">
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">

                            </td>
                            <td>

                            </td>
                        </tr>

                        <tr>
                            <td class="form_label">
                                <label>行驶证正本照：
                                    <br>
                                    <a href="#" id="faker2">点击上传</a>
                                </label>
                            </td>
                            <td nowrap="nowrap">
                                <div class="page-header" id="btn-uploader">
                                    <img id="xmTanImg2" style="width: 100px;height: 100px" onclick="preview(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"
                                    />
                                </div>


                                <input class="nui-textbox" id="driveLicensePicOne" name="driveLicensePicOne" style="display:none">
                            </td>
                            <td class="form_label" colspan="1">
                                <label>行驶证副本照：
                                    <br>
                                    <a href="#" id="faker3">点击上传</a>
                                </label>
                            </td>
                            <td>
                                <div class="div1" id="faker3" onchange="xmTanUploadImg(this)">
                                    <img id="xmTanImg3" style="width: 100px;height: 100px" onclick="preview(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"
                                    />
                                </div>


                                <input class="nui-textbox" id="driveLicensePicTwo" name="driveLicensePicTwo" style="display:none">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="max_img" style="margin:0 auto">
                    <img src="" id="maxImgShow" onclick="changeHide();" width="100%" height="100%" />
                </div>
            </div>
            <div title="车辆照片">
                <div class="nui-fit">
                    <div class="nui-toolbar" style="">
                        <table style="width:100%;">
                            <tr>
                                <td >
                                    <input class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%" />
                                    <input class="nui-hidden" name="serviceCode" id="serviceCode" enabled="false" width="100%" />
                                    <a class="nui-button" onclick="addCarListPhoto()" plain="true" style="width: 60px;">
                                        <span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                    <a class="nui-button" onclick="onClose(2)" plain="true" style="width: 60px;">
                                        <span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="form" id="" class="imgList" name="basicInfoForm" style="height:100%;left:0;right:0;margin: 0 auto;padding-top: 10px;padding-left: 10px;float: left;">

                                <div id="photos" class="photos" style="width:300px; display:block;word-break: break-all;word-wrap: break-word;">



                                </div>
                                    <div id="btn-uploader">
                                        <a href="javascript:;" id="faker4" class="addImage tc sub-add-btn" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;height: 80px;width:80px;text-align: center;text-decoration: none;">
                                            <div class="vm dib sub-add-icon" style="height: 80px;margin-right: 5px;width: 80px;9px;;margin-left: 0%;background-size: 18px;">
                                            	<img alt="" style="height: 80px;width: 80px;" src="<%=webPath + contextPath%>/repair/prototype/images/add1.png">
                                            	
                                            </div>
                                        </a>
                                    </div>
                    </div>

                </div>
            </div>
        </div>
    </div>