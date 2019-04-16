<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    
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
                        <label>准驾车型(A1)：</label>
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
                        <input name="licenseRecordDate" allowInput="true" class="nui-datepicker" format="yyyy-MM-dd" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>驾照到期日期：</label>
                    </td>
                    <td>
                        <input name="licenseOverDate" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
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
                        <input name="birthday" allowInput="true" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
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
                <tr>
                <td class="form_label">
                        <label>驾驶证正本照：<br><a  href="#" id="faker">点击上传</a></label>
                    </td>
                    <td nowrap="nowrap">
		                <div class="page-header" id="btn-uploader">
						            <img id="xmTanImg" style="width: 100px;height: 100px" onclick="changeShow1(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
					    </div>
		
		
								 <input  class="nui-textbox" id="licensePicOne" name="licensePicOne"  style="display:none" >
                    </td>
                    <td class="form_label" colspan="1">
                       <label>驾驶证副本照：<br><a  href="#" id="faker1">点击上传</a></label>
                    </td>
                    <td>
	                    <div class="page-header" id="btn-uploader">
					            <img id="xmTanImg1" style="width: 100px;height: 100px" onclick="changeShow1(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
				        </div>


						 <input  class="nui-textbox" id="licensePicTwo" name="licensePicTwo"  style="display:none" >
                    </td>
                </tr>
            </table> 
        </div>
       <div class="max_img1" style="margin:0 auto">
			<img src="" id="maxImgShow1" onclick="changeHide();" width="100%" height="100%" />
	   </div>
    </div>