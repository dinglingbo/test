<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
    <script src="<%=webPath + contextPath%>/common/js/employeeEdit.js?v=1.0.5" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit"> 
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
            <fieldset id="fd1" style="width:600px;">
                <legend><span>基本信息</span></legend>
                <table >
                    <tr>
                        <td>员工工号</td>
                        <td><input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" readonly="readonly" emptyText="系统自动分配"/></td>
                        <td>所属工作组</td>
                        <td><input class="nui-combobox"  required="false" id="tenantId" name="tenantId" textField="name" valueField="id"/></td>
                    </tr>

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
                    <td>是否服务技师：</td>
                    <td><div  class="nui-checkbox" id="isArtificer" name="isArtificer" value="0" trueValue="1" falseValue="0" onvaluechanged="onChanged"></div>
                    <input class="nui-combobox" id="artificerLevel" name="artificerLevel" required="false" style="width: 107px;display: none;" emptytext="选择技师等级" textField="name" valueField="id"/>
                          <!--<div id="isArtificer" name="isArtificer" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                          textField="name" valueField="id" value="1"  width="100%"
                          url="" > -->
                      </div>
                  </td>
              </tr>

              <tr>
                <td >生日：</td>
                <td><input class="nui-datepicker" id="birthday" name="birthday"/></td>
                <td >入职日期：<span></span></td>
                <td><input class="nui-datepicker" id="recordDate" name="recordDate"/></td>
            </tr>
            <tr>
                <td >身份证号码：<span></span></td>
                <td ><input class="nui-textbox" width="200px" id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" /></td>
                <td >微信/QQ号：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="wechat" id="wechat" vtype="maxLength:50"/></td>
            </tr>

            <tr>
                <td >紧急联系人：<span></span></td>
                <td ><input class="nui-textbox" name="urgencyPerson" id="urgencyPerson" vtype="maxLength:20"/></td>
                <td >紧急联系人电话：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="urgencyPersonPhone" id="urgencyPersonPhone" onvalidation="onMobileValidation" /></td>

            </tr> 
        </table>
    </fieldset>
    <fieldset id="fd1" style="width:600px;">
        <legend><span>其它信息</span></legend>
        <table>
            <tr>
                <td>积分抵扣上限金额：<span></span></td>
                <td><input class="nui-textbox" name="integralDiscountMax" id="integralDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
            </tr>
            <tr>
                <td>工时优惠率最高上限：</td>
                <td><input class="nui-textbox" name="itemDiscountRate" id="itemDiscountRate" value="0" required="true"  vtype="range:0,1"/></td>
            </tr>
            <tr>
                <td>配件优惠率最高上限：</td>
                <td><input class="nui-textbox" name="partDiscountRate" id="partDiscountRate" value="0" required="true"  vtype="range:0,1"/></td>
            </tr>
            <tr>
                <td>整单全免上限金额：<span></span></td>
                <td><input class="mini-textbox" id="freeDiscountMax" name="freeDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
            </tr>
            <tr>
                <td>收银优惠上限金额：</td>
                <td><input class="mini-textbox" name="cashDiscountMax" id="cashDiscountMax" value="0" required="true" vtype="range:0,1000000"/></td>
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


  function onChanged(e) {
    var isArtificer = nui.get("isArtificer").value;
    if(isArtificer == true){
        $("#artificerLevel").show();
    }else{
        $("#artificerLevel").hide();
        nui.get("isArtificer").setValue(null);
    }
}
</script>
</body>
</html>