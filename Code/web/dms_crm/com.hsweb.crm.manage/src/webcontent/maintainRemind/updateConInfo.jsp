<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
-->

<head>
    <title>修改联系人信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "微软雅黑";
        }
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
            <div class="nui-toolbar" style="padding:0px;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" onclick="addContactList()" plain="true" style="width: 60px;" ><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                                <a class="nui-button" onclick="onCancel(1)" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                            </td>
                        </tr>
                    </table>
                </div>
            <div class="form" id="contactInfoForm" style="height:100%;width:100%;padding-right:20px;">
                <input class="nui-hidden" name="id" />
                <input class="nui-hidden" name="guestId" />
                <table class="nui-form-table" style="width:100%;margin-top:20px;line-height: 30px;">
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
                            <input class="nui-textbox" id="mobile" name="mobile" width="100%" />
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
                </table> 
            </div>
       
    <script type="text/javascript">
        nui.parse();
        var baseUrl = apiPath + repairApi + "/";
        var contactorUrl = baseUrl + "com.hsapi.repair.repairService.crud.getContactorById.biz.ext";
        // var saveUrl = baseUrl + "com.hsapi.repair.repairService.threeDC.saveContactor.biz.ext";
        var saveUrl = baseUrl + "com.hsapi.repair.repairService.threeDC.saveContactData.biz.ext";

        var mainData = {};
        var contactInfoForm = new nui.Form("#contactInfoForm");


        initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        source:GUEST_SOURCE,//客户来源
        identity:IDENTITY //客户身份
    });

        nui.get("name").focus();
        document.onkeyup = function (event) {
            var e = event || window.event;
            var keyCode = e.keyCode || e.which; //38向上 40向下
            if ((keyCode == 27)) { //ESC
                onCancel();
            }
        };

        function setData(rowData) {
            mainData = rowData;
            loadForm(mainData.conId);
        }


function loadForm(id) {

    nui.ajax({
        url:contactorUrl,
        type:'post',
        data:{id:id},
        success:function(res){
            if(res.con != '' &&res.con != null && res.con != {}){
                    contactInfoForm.setData(res.con);
            }else{
                showMsg('数据加载失败','E');
            }

        }
    });
    
}


function addContactList(){

	var contact = contactInfoForm.getData(true);
	if(contact.identity==""||contact.source==""){
		showMsg("身份和来源不能为空!","W");
		return;
	}else if(!contact.name){
        showMsg("姓名不能为空!","W");
		return;
    }else if(!contact.mobile){
        showMsg("手机不能为空!","W");
		return;
    }else{
    
    // if(contact.id==""||contact.id==null){
    // 	insContactList = [contact];

    // }else{
    // 	updContactList = [contact];
    // }
    
    // nui.mask({
	// 	el : document.body,
	// 	cls : 'mini-mask-loading',
	// 	html : '保存中...'
    // });
    // nui.unmask(document.body);

    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{conData:contact},
        success:function(res){
            if(res.errCode == 'S'){
                showMsg('保存成功','S');
            }else{
                showMsg('保存失败','E');
            }
            CloseWindow("ok");
        }
    });
    }

}


    

        function onCancel() {
            CloseWindow("cancel");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                window.close();
        }
    </script>
</body>

</html>