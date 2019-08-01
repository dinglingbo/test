<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<!-- 
  - Author(s): lilium_ll
  - Date: 2018-05-31 15:46:30
  - Description:
-->
<head>
<title>开通账号</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@ include file="/common/sysCommon.jsp"%>
<style type="text/css">
.title {
  width: 80px;
  text-align: right;
}

</style>
</head>
<body>
  <div class="nui-fit">

  	<div class="form" id="basicInfoForm" >
  		<table>
  		      <tr>
                  <td class="title">姓名：</td>
                  <td style="width:200px;">
                      <input class="nui-textbox" width="100%" id="name" name="name" readonly="readonly" enabled="false"/></td>
                </tr>
                <tr>
                  <td class="title">登陆账号：</td>
                  <td style="width:200px;">
                      <input class="nui-textbox" width="100%" id="Account" name="Account" vtype="maxLength:20"/></td>
                </tr>
                <tr>
                  <td class="title">默认密码：</td>
                  <td style="width:200px;">
                    <input class="nui-textbox" value="000000" width="100%" readonly="readonly" id="passWord" name="passWord" enabled="false" visible="true"/>
                  </td>
                </tr>
                <tr>
  				 <td>
                      <input class="nui-textbox" id="empid" name="empid" visible="false"/>
                  </td>
                </tr>
  		</table>
  		<div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
              <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="OnOk"><i class="fa fa-plus"></i>&nbsp;确认</a>
  			<a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="Oncancel"><i class="fa fa-sign-out"></i>&nbsp;退出</a>

          </div> 
  	</div>
  </div>


	<script type="text/javascript">
    	nui.parse();
     	var form;
     	var baseUrl = apiPath + sysApi + "/";

      nui.get("Account").focus();
    	$(document).ready(function(v) {
			form = new nui.Form("#basicInfoForm");

		});
    function SetInitData(data) {
    	if (!data.empid) return;
    	form.setData(data);
    }
    setAccountUrl=baseUrl+"com.hsapi.system.tenant.employee.openOrCloseUser.biz.ext";
    function OnOk(){
    	var tmpAccount=nui.get("Account").getValue();
    	var tmpempid=nui.get("empid").getValue();
        tmpAccount = tmpAccount.replace(/\s+/g,"");
    	var s={};
    	s.systemAccount=tmpAccount;
        s.name = nui.get("name").getValue();
    	s.empid=tmpempid;
        s.isOpenAccount = 1;
		if(tmpAccount=="")
		{
		  showMsg("请输入帐号！","W");
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
            	comMember: s,
                type:1,
                token:token
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