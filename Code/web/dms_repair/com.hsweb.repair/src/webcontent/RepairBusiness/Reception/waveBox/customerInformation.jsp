<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-19 12:14:46
  - Description:
-->
<head>
<title>新增修改客户信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link href="<%=webPath + contextPath%>/repair/cfg/css/appoint.css" rel="stylesheet"	type="text/css" />
</head>
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


</style>
<body>
<div class="nui-panel" showToolbar="false" title="客户信息" showFooter="false"
             borderStyle="border:0;"
             style="width:100%;">
              <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
            <div class="form" id="basicInfoForm">
                <table class="nui-form-table" style="width:99%">
                     <tr>
                        <td class="form_label required">
                            <label>客户名称：</label>
                        </td>
                        <td >
                         <input class="nui-hidden" name="id" id="guestId"/>
                         <input class="nui-textbox" id="fullName" name="fullName" width="100%" onvaluechanged="onChanged(this.id)"/>
                        </td>
                        <td class="form_label required">
                            <label>手机号码：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="mobile" name="mobile"  width="100%" onvaluechanged="onChanged(this.id)"  
                            emptyText="请输入手机号查询" onenter="onChanged(this.id)"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>性别：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]"
						textField="text" valueField="value" name="sex"
						value="0"  width="100%" />
                        </td>
                        <td class="form_label ">
                            <label>客户简称：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="shortName" name="shortName" onValuechanged="processMobile(this.value)" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>生日类型：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" data="[{value:'0',text:'农历',},{value:'1',text:'阳历'},]"
						textField="text" valueField="value" name="birthdayType"
						value="0"  width="100%"/>
                        </td>
                        <td class="form_label ">
                            <label>生日日期：</label>
                        </td>
                        <td>
                            <input name="birthday" allowInput="false" class="nui-datepicker" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>地址：</label>
                        </td>
                        <td colspan="3">
                            <input name="provinceId"
                               id="provice"
                               valueField="code"
                               textField="name"
                               emptyText = "省"
                               url=""
                               onValuechanged="initCityByParent('cityId', e.value || -1)"
                               class="nui-combobox" width="32%"/>
                            
                            <input name="cityId"
                               id="cityId"
                               valueField="code"
                               textField="name"
                               emptyText = "市/县"
                               onValuechanged="initCityByParent('areaId', e.value || -1)"
                               class="nui-combobox" width="33%"/>
                               
                            <input name="areaId"
                               id="areaId"
                               valueField="code"
                               textField="name"
                               emptyText = "乡/镇"
                               class="nui-combobox" width="33%"/>
                            
                            <input class="nui-textbox" name="addr" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>备注：</label>
                        </td>
                        <td colspan="3">
                            <input class="nui-textbox" name="remark" width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="nui-fit">
		        <div class="nui-panel" showToolbar="false" title="联系人信息" showFooter="false"
		             borderStyle="border:0;"
		             style="width:100%;height:100%">
		      
				    	<table width="100%" border="0" align="center" cellpadding="6" cellspacing="0">
				    		<tr>
				    			<td>
				                    <ul class="sjd">
				                    		
				                    </ul>
				            	</td>
				    		</tr>
				    	</table>
			    	
		        	<div class="form" id="contactInfoForm" style="height:40px;">
		                        <input class="nui-hidden" name="id"/>
		                        <input class="nui-hidden" name="guestId" />
		                        <input class="nui-hidden" name="check"  id="check"/>
		                    
							<table class="nui-form-table" style="width:100%;">
		                <tr>
		                    <td class="form_label required">
		                        <label>姓名：</label>
		                    </td>
		                    <td colspan="3">
		                        <input class="nui-textbox" id="name2" name="name" width="160px" />
		                       <!--  <a class="nui-button" iconCls="" id="preContactBtn" onclick="preContact()" style="margin-right:10px;" tooltip="上一个" plain="true"><span class="fa fa-chevron-left fa-lg"></span></a>
		                        <a class="nui-button" iconCls="" id="nextContactBtn" onclick="nextContact()" style="margin-right:10px;" tooltip="下一个" plain="true"><span class="fa fa-chevron-right fa-lg"></span></a> -->
		                        <a class="nui-button" iconCls="" onclick="addContact()" tooltip="新增" plain="true"><span class="fa fa-plus fa-lg"></span></a>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label required">
		                        <label>手机：</label>
		                    </td>
		                    <td>
		                        <input class="nui-textbox" id="mobile2" name="mobile" width="100%" />
		                    </td>
		                    <td class="form_label required">
		                        <label>身份：</label>
		                    </td>
		                    <td>
		                        <input class="nui-combobox" name="identity" id="identity" valueField="customid" textField="name" width="100%" value="060301" />
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
		                    <td class="form_label required">
		                        <label>来源：</label>
		                    </td>
		                    <td>
		                        <input class="nui-combobox" name="source" id="source" valueField="customid" textField="name" width="100%" value="060110" />
		                    </td>
		                </tr>
		            </table>
                    </div>
		 
	  
    </div>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	var baseUrl = apiPath + repairApi + "/";
    	var contactInfoForm = new nui.Form("#contactInfoForm");
    	var basicInfoForm = new nui.Form("#basicInfoForm");
    	var hash = {};
    	var provice = nui.get("provice");
    	var cityId = nui.get("cityId");
    	initProvince("provice");
    	provice.doValueChanged();
        cityId.doValueChanged();
	    initDicts({
	        //carSpec:CAR_SPEC,//车辆规格
	        //kiloType:KILO_TYPE,//里程类别
	        source:GUEST_SOURCE,//客户来源
	        identity:IDENTITY //客户身份
	    },function(){
	        hash.initDicts = true;
	    });
    
        function addContact(){
        	var data = contactInfoForm.getData();
        	if(!data.name){
        		alert("请输入联系人名称");
        	}else{
        		$(".sjd").append('<li name="name0"><font>' + data.name + '</font>' +
                            '<p><span name="mobile0" discount="">' +data.mobile +'</span></p>' +
                            '<p style="display:none"><span name="identity0" discount="">' +data.identity +'</span></p>' +
                             '<p style="display:none"><span name="sex0" discount="">' +data.sex +'</span></p>' +
                              '<p style="display:none"><span name="source0" discount="">' +data.source +'</span></p>' +
                              '<p style="display:none"><span name="id0" discount="">' +data.id +'</span></p>' +
                              '<p style="display:none"><span name="check0" discount="">Y</span></p>' +
                        '</li>');
                 //保存。。。。。。。。
                 
                 //清空表格
                 contactInfoForm.setData([]);     
        	}
        	clickLi();
        }
        
        function clickLi(){
        	$(".sjd li[name=name0]").click(function () {
        		contactInfoForm.setData([]);     
		     	var data = {
		     		name : $(this)[0].childNodes[0].innerText,
		     		mobile : $(this)[0].childNodes[1].innerText,
		     		identity : $(this)[0].childNodes[2].innerText,
		     		sex : $(this)[0].childNodes[3].innerText,
		     		source : $(this)[0].childNodes[4].innerText,
		     		id: $(this)[0].childNodes[5].innerText,
		     		check:$(this)[0].childNodes[6].innerText
		     	};
		     	contactInfoForm.setData(data);     
	    	});
        }
        
        function onOk(){
        	var form = basicInfoForm.getData();//客户信息
        	var contact = $(".sjd li");//获取填写的联系人数据，数组类型
        	var arr = new Array;
        	var index = 0 ;
        	for(var i = 0 , l = contact.length; i < l ; i++){//拼接数据
        		index ++;
        		arr[i]= {
        			name : contact[i].childNodes[0].innerText,
		     		mobile : contact[i].childNodes[1].innerText,
		     		identity : contact[i].childNodes[2].innerText,
		     		sex : contact[i].childNodes[3].innerText,
		     		source : contact[i].childNodes[4].innerText
        		};
        		if(form.id){//保存了一遍
        			arr[i].guestId = form.id;
        		}
        	}
        	if(index == 0){//当没有点击+增加联系人信息时contact为空
        		var data =  contactInfoForm.getData();
        		if(!data.id){
        			if(data.name || data.mobile || data.identity || !data.sex || data.source){
        				arr[0] = data;
        			}
        		}else{
        				arr[0] = data;
        		}
        	}else{
        		if(contactInfoForm.getData().check != "Y"){
        			arr[arr.length] = contactInfoForm.getData();
        		}
        	}
        	
        	 nui.ajax({
                    url: baseUrl+"com.hsapi.repair.repairService.crud.saveBXCustomerInforMation.biz.ext",
                    type: "post",
                    cache: false,
                    async: false,
                    data: {
                       guest : form,
                       rpb : arr
                    },
                    success: function(text) {
							var guest = text.guest;
							basicInfoForm.setData(guest);			 
							var rpb = text.rpb;
							$(".sjd").empty();
							contactInfoForm.setData([]);
							for(var i = 0 , l = rpb.length ; i < l ; i++){
								$(".sjd").append('<li name="name0"><font>' + rpb[i].name + '</font>' +
		                            '<p><span name="mobile0" discount="">' +rpb[i].mobile +'</span></p>' +
		                            '<p style="display:none"><span name="identity0" discount="">' +rpb[i].identity +'</span></p>' +
		                             '<p style="display:none"><span name="sex0" discount="">' +rpb[i].sex +'</span></p>' +
		                              '<p style="display:none"><span name="source0" discount="">' +rpb[i].source +'</span></p>' +
		                              '<p style="display:none"><span name="id0" discount="">' +rpb[i].id +'</span></p>' +
		                              '<p style="display:none"><span name="check0" discount="">Y</span></p>' +
		                        '</li>');
							}
							clickLi();
                    }
            });
        }
    </script>
</body>
</html>