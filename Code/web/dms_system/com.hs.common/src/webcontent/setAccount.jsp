<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lilium_ll
  - Date: 2018-05-31 15:46:30
  - Description:
-->
<head>
<title>Title</title>
    <%@include file="/common/sysCommon.jsp"%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  
    
</head>
<body>
	<div class="form" id="basicInfoForm" >
		<table>
		      <tr>
                <td class="tbtext">员工姓名<span style="color:red">*</span></td>
                <td style="width:400px;"><input class="nui-textbox" style="width: 400px;" id="name" name="name" readonly="readonly"/></td>
              	</tr>
                <tr>
                <td class="tbtext">请输入账号<span style="color:red">*</span></td>
                <td style="width:400px;"><input class="nui-textbox" style="width: 400px;" id="Account" name="Account" /></td>
                </tr>
                <tr>
                <td class="tbtext">密码<span style="color:red">*</span></td>
                <td style="width:400px;"><input class="nui-textbox" value="000000" style="width: 400px;" readonly="readonly" id="passWord" name="passWord"/></td>
                </tr>
                 <tr>
				 <td><input class="nui-textbox" id="empid" name="empid" visible="false"/></td>
                </tr>
		</table>
		<div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
            <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="OnOk"><i class="fa fa-plus"></i>&nbsp;确认</a>
			<a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="Oncancel"><i class="fa fa-sign-out"></i>&nbsp;退出</a>

        </div> 
	</div>


	<script type="text/javascript">
    	nui.parse();
     	var form;
     	baseUrl = apiPath + sysApi + "/";;
    	$(document).ready(function(v) {
			form = new nui.Form("#basicInfoForm");

		});
    function SetData(data) {
	if (!data.empid) return;
	form.setData(data);
    }
    setAccountUrl=baseUrl+"com.hsapi.system.employee.employeeMgr.setAccount.biz.ext"
    function OnOk(){
    	var tmpAccount=nui.get("Account").getValue();
    	var tmpempid=nui.get("empid").getValue();
    	var s={};
    	s.Account=tmpAccount;
    	s.empid=tmpempid;
    		if(tmpAccount=="")
    		{
    		nui.alert("请输入帐号！");
    		return ; 
    		}
    	 nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '开通账户中...'
	    });
 			nui.ajax({
            url: setAccountUrl,
            type: 'post',
            data: nui.encode({
            	params: s
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
               			nui.unmask(document.body);
                		closeWindow("OK");
                    }else {
                    	nui.unmask(document.body);
                    	closeWindow("cal");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
 	
    }
  	function Oncancel(){
     	closeWindow("cal");
    	
    }
     
    </script>
</body>
</html>