<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/sysCommon.jsp"%>

        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->

        <head>
            <title>门店信息</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%=webPath + contextPath%>/common/js/orgExtendEdit.js?v=1.9.8" type="text/javascript"></script>

            <style type="text/css">
            
				
				    
			
                .form_label {
                    width: 80px;
                    text-align: right;
                }
            </style>
        </head>

        <body class="back">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('no')" plain="true" style="width: 60px;">
                                <span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true" style="width: 60px;">
                                <span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div class="nui-panel" showToolbar="false" title="变更信息" showFooter="false" style="width:100%;">
                    <div class="form" id="basicInfoForm" name="basicInfoForm">
                        <table style="line-height: 2;">
                            <tr>
                                <td class="form_label required">
                                    <label>LOGO图片：</label>
                                </td>
                                <td colspan="1" class="tabwidth">
                                    <div class="pic" style="width:64px;height:64px;border:1px solid #ccc; "></div>
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">企业号:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox" width="120px" name="code" id="code" vtype="maxLength:5" />
                                    <input class="nui-hidden" name="orgid" id="orgid" />
                                </td>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">公司全称:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox " width="120px" name="name" id="name" />
                                </td>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">公司简称:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox " width="120px" name="shortName" id="shortName" />
                                </td>
                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">省份:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-combobox textboxwidth" width="120px" name="provinceId" id="provinceId" valueFromSelect="true" allowinput="true" valueField="code"
                                        textField="name" data="list" onvaluechanged="onProvinceChange" />
                                </td>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">城市:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-combobox textboxwidth" width="120px" name="cityId" id="cityId" onvaluechanged="onCityChange" valueFromSelect="true" allowinput="true"
                                        valueFromSelect="true" allowinput="true" valueField="code" textField="name" />
                                </td>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">地区:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-combobox textboxwidth" width="120px" name="countyId" valueFromSelect="true" valueField="code" textField="name" allowinput="true"
                                        id="countyId" valueFromSelect="true" allowinput="true" onvaluechanged="onCountyChange"
                                    />
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                        <font color="red">纤细地址:</font>
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="355px"  name="streetAddress" id="streetAddress" onvaluechanged="onStreetChange" />
                                </td>

                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>
                                        组合地址:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="595px" enabled="false" name="address" id="address" />
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                        经度:
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline " width="120px" style="" name="longitude" id="longitude" />
                                </td>
                                <td class="form_label required">
                                    <label>
                                        纬度:
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline" width="120px" style="margin-left: 10px;" name="latitude" id="latitude" />
                                </td>
							       <td class="form_label required">
                                    <label>
                                        <font color="red">开店日期:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-datepicker tabwidth" width="120px" enabled="true" format="yyyy-MM-dd hh:MM" name="softOpenDate" id="softOpenDate" />
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>
                                        开户银行:
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline " width="120px" style="" name="bankName" id="bankName" />
                                    <td class="form_label required">
                                        <label>
                                            银行账号:
                                        </label>
                                    </td>
                                    <td>
                                    <input class="nui-textbox inline" width="120px" style="margin-left: 10px;" name="bankAccountNumber" id="bankAccountNumber" />
                                </td>
								                               <td class="form_label required">
                                    <label>
                                        <font color="red">公司电话:</font>
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox tabwidth" width="120px" name="tel" id="tel" onvalidation="onMobileValidation" />
                                </td>
                            </tr>


                            <tr>
                                <td class="form_label required">
                                    <label>
                                        网站:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" id="webaddress" name="webaddress" />
                                </td>

                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>
                                        报表标题:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" name="reportTitle" id="reportTitle" />
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                       主修品牌:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" name="mainBrandId" id="mainBrandId" />
                                </td>

                            </tr>


                            <tr>
                                <td class="form_label required">
                                    <label>
                                       救援电话:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" name="rescueTel" id="rescueTel" />
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required">
                                    <label>
                                        广告语1:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" name="slogan1" id="slogan1" />
                                </td>

                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>
                                      广告语2:
                                    </label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textbox tabwidth" width="590px" name="slogan2" id="slogan2" />
                                </td>

                            </tr>

                            <tr>
                                <td class="form_label required" colspan="2">
                                    <label>
                                        电子档案对接省份:
                                    </label>
                                </td>
                                <td >
                                    <input class="nui-textbox inline "  width="120px" style="" name="eRecordProvince" id="eRecordProvince" />
                                </td>
                                <td class="form_label required" colspan="2">
                                    <label>电子档案维修厂编号:</label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline"  width="120px" style="margin-left: 10px;" name="eRecordRepairNo" id="eRecordRepairNo" />
                                </td>


                            </tr>

                            <tr>
                                <td class="form_label required" colspan="2">
                                    <label>电子档案用户名:</label>
                                </td>

                                <td>
                                    <input class="nui-textbox inline " width="120px" style="" name="eRecordUser" id="eRecordUser" />
                                </td>
                                <td class="form_label required" colspan="2">
                                    <label>
                                        电子档案密码:
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline" width="120px" style="margin-left: 10px;" name="eRecordPwd" id="eRecordPwd" />
                                </td>


                            </tr>


                            <tr>
                                <td class="form_label required">
                                    <label>
                                        备注:
                                    </label>
                                </td>

                                <td colspan="5">
                                    <input class="nui-textbox tabwidth"  width="590px"/>
                                </td>

                            </tr>


                            <tr>
                                <td class="form_label required">
                                    <label>
                                        建档人:
                                    </label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline " width="120px" readonly="readonly" style="" name="recorder" id="recorder" enabled="false" />
                                </td>
                                <td class="form_label required">
                                    <label>建档日期:</label>
                                </td>
                                <td>
                                    <input class="nui-textbox inline" width="120px" readonly="readonly" style="margin-left: 10px;" name="recordDate" id="recordDate" enabled="false"
                                    />
                                </td>

                            </tr>


                            <tr>
                                <td class="form_label required">
                                    <label>最后操作人:</label>
                                </td>

                                <td>
                                    <input class="nui-textbox inline " width="120px" style="" name="modifier" id="modifier" readonly="readonly" enabled="false" />
                                </td>
                                <td class="form_label required">
                                    <label>最后操作日期:</label>
                                </td>
                                <td>
                                <input readonly="readonly" class="nui-textbox inline" width="120px" style="margin-left: 10px;" name="modifyDate" id="modifyDate" enabled="false"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                nui.parse();
                function ajaxFileUpload() {

                    var inputFile = $("#file1 > input:file")[0];

                    $.ajaxFileUpload({
                        url: 'upload.aspx',                 //用于文件上传的服务器端请求地址
                        fileElementId: inputFile,               //文件上传域的ID
                        //data: { a: 1, b: true },            //附加的额外参数
                        dataType: 'text',                   //返回值类型 一般设置为json
                        success: function (data, status)    //服务器成功响应处理函数
                        {
                            alert("上传成功: " + data);

                        },
                        error: function (data, status, e)   //服务器响应失败处理函数
                        {
                            alert(e);
                        },
                        complete: function () {
                            var jq = $("#file1 > input:file");
                            jq.before(inputFile);
                            jq.remove();
                        }
                    });
                }

            </script>
        </body>

        </html>