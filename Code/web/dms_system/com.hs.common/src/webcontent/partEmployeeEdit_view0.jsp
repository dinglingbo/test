<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00 
  - Description:
-->
<head> 
    <title>添加员工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/js/partEmployeeEdit.js?v=1.0.9" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit"> 
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
            <input class="mini-hidden" id="systemAccount" name="systemAccount" />
            <fieldset id="fd1" style="width:620px;">
                <legend><span>基本信息</span></legend>
                <table >
                    <tr>
                        <td>姓名：</td>
                        <td><input class="nui-textbox"  id="name" name="name" vtype="maxLength:6" required="true" /></td>
                        <td>性别：</td>
                        <td>
                            <div id="sex" name="sex" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                            textField="name" valueField="id" value="1"
                            url="" >
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>手机号码：</td>
                    <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" /></td>
                    <td >生日：</td>
                    <td><input class="nui-datepicker" id="birthday" name="birthday"/></td>
                  </td>
              </tr>

              <tr>
                <td >身份证号码：<span></span></td>
                <td ><input class="nui-textbox" width="200px" id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" /></td>    
            </tr>
            <tr>
                <td >入职日期：<span></span></td>
                <td><input class="nui-datepicker" id="recordDate" name="recordDate"/></td>
                <td >微信/QQ号：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="wechat" id="wechat"/></td>
            </tr>

            <tr>
                <td >紧急联系人：<span></span></td>
                <td ><input class="nui-textbox" name="urgencyPerson" id="urgencyPerson"/></td>
                <td >紧急联系人电话：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="urgencyPersonPhone" id="urgencyPersonPhone"/></td>

            </tr>
            <tr>
            	<td align="right" >是否低于成本价  <br>销售权限：</td>
                <td >
               		 <input class="nui-combobox"  required="false" id="isCanBelowCost" name="isCanBelowCost" textField="name"  value="0" valueField="id" />
                </td>
                <td >是否业务员：<span></span></td>
                <td>
                	<input class="nui-combobox"  required="false" id="isSalesman" name="isSalesman" textField="name"  value="1" valueField="id" />
                </td>
            </tr>
             <tr>
            	<td align="right" >是否限制开单额度：</td>
                <td >
               		 <input class="nui-combobox"  required="false"  vtype="int" id="isLimitCredit" name="isLimitCredit" textField="name"  value="0" valueField="id" />
                </td>
                <td >开单额度：<span></span></td>
                <td>
                	<input class="nui-textbox"  required="false" vtype="int" id="creditMoney" name="creditMoney" onvalidation="onCredValidation" />
                </td>
            </tr>
        </table>
    </fieldset>
    <div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
        <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="javascript:save('new')" id="newand" name="newand"><i class="fa fa-plus"></i>&nbsp;保存并继续</a>
        <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="javascript:save('edit')" ><i class="fa fa-save"></i>&nbsp;保存退出</a>
        <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick="Oncancel()"><i class="fa fa-sign-out"></i>&nbsp;退出</a>

    </div>
</div>
</div>
<script type="text/javascript">
  nui.parse();

</script>
</body>
</html>