<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>


<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00 
  - Description:
-->
<head> 
    <title>添加员工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/js/employeeEdit.js?v=1.1.17" type="text/javascript"></script>
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
    	.fwidthb{
		    width: 150px;
		}
	</style>
</head>
<body>
    <div class="nui-fit"> 
    	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
            <input class="mini-hidden" id="systemAccount" name="systemAccount" />
            <fieldset id="fd1" style="width:600px;">
                <legend><span>基本信息</span></legend>
                <table >
                	 <tr >
			                <td align="right">头像：<span class="spanwidth"></span> </td>
			                <td  colspan="5" class="tabwidth" >
			                <div class="page-header" id="btn-uploader">
				                	<div class="div1" id="faker" onchange="xmTanUploadImg(this)">
							            <img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg(this)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
							            <div id="xmTanDiv"></div>
							        </div>
						        </div>
							<input  class="nui-textbox" id="headPortrait" name="headPortrait"  style="display:none" >
		                </td>
				
           			</tr>
                    <tr>
                        <td align="right">员工工号：</td>
                        <td><input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" readonly="readonly" emptyText="系统自动分配"/></td>
                        <td align="right">所属工作组：</td>
                        <td><input class="nui-combobox"  required="false" id="memberGroupId" name="memberGroupId" textField="name" valueField="id" emptyText="选择工作组"/></td>
                    </tr>

                    <tr>
                        <td align="right"><font color="red">姓名：</font></td>
                        <td><input class="nui-textbox"  id="name" name="name" vtype="maxLength:6" required="true" /></td>
                        <td align="right">性别：</td>
                        <td>
                            <div id="sex" name="sex" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                            textField="name" valueField="id" value="1"
                            url="" >
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" ><font color="red">手机号码：</font></td>
                    <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" /></td>
                    <td align="right">是否服务技师：</td>
                    <td><div  class="nui-checkbox" id="isArtificer" name="isArtificer" value="0" trueValue="1" falseValue="0" onvaluechanged="onChanged"></div>
                    <input class="nui-combobox" id="memberLevelId" name="memberLevelId" required="false" style="width: 107px;display: none;" emptytext="选择技师等级" textField="name" valueField="id"/>
                          <!--<div id="isArtificer" name="isArtificer" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                          textField="name" valueField="id" value="1"  width="100%"
                          url="" > 
                      </div>-->
                  </td>
              </tr>

              <tr>
                <td align="right" >生日：</td>
                <td><input class="nui-datepicker" id="birthday" name="birthday"/></td>
                <td align="right">入职日期：<span></span></td>
                <td><input class="nui-datepicker" id="recordDate" name="recordDate"/></td>
            </tr>
            <tr>
                <td align="right"> <font color="red">身份证号码：</fpont></td>
                <td ><input class="nui-textbox"  id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" /></td>
                <td align="right">OpenID：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="openId" id="openId" enabled="false"/></td>
            </tr>
            <tr>
                <td align="right">紧急联系人：<span></span></td>
                <td ><input class="nui-textbox" name="urgencyPerson" id="urgencyPerson" vtype="maxLength:20"/></td>
                <td align="right"><font color="red">紧急联系人电话：</font></td>
                <td colspan="2"><input class="nui-textbox" name="urgencyPersonPhone" id="urgencyPersonPhone" onvalidation="onMobileValidation" /></td>

            </tr> 
            
        </table>
    </fieldset>
    <fieldset id="fd1" style="width:600px;">
        <legend><span>其它信息</span></legend>
        <table>
            <tr>
                <td align="right" class="fwidthb">是否服务顾问：</td>
                <td >
                	<div  class="nui-checkbox" id="isMtadvisor" name="isMtadvisor" value="0" trueValue="1" falseValue="0"></div>
                </td>
                <td align="right" class="fwidthb">是否允许领料：</td>
                <td >
                	<div  class="nui-checkbox" id="isStockman" name="isStockman" value="0" trueValue="1" falseValue="0"></div>
                </td>
            </tr> 
             <tr>
                <td align="right" class="fwidthb">车牌号车架号是否允许自由输入：</td>
                <td >
                	<div  class="nui-checkbox" id="isCanfreeCarnovin" name="isCanfreeCarnovin" value="0" trueValue="1" falseValue="0">
                </td>
                <td align="right" class="fwidthb">工单是否允许直接结算：</td>
                <td >
                	<div  class="nui-checkbox" id="isCanSettle" name="isCanSettle" value="0" trueValue="1" falseValue="0">
                </td>
               
            </tr>
            <tr>
                <td align="right" class="fwidthb">是否采购/仓库：</td>
                <td ><div  class="nui-checkbox" id="isPchsStock" name="isPchsStock" value="0" trueValue="1" falseValue="0"></td>
	            <td align="right" class="fwidthb">显示个人单据：</td>
	            <td >
	            	<div  class="nui-checkbox" id="isShowOwnBill" name="isShowOwnBill" value="0" trueValue="1" falseValue="0">
	           		 <input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" visible="false" emptyText="系统自动分配"/>
	            </td> 
            </tr>
            <tr>
                <td align="right" class="fwidthb">允许消息通知：</td>
                <td ><div  class="nui-checkbox" id="isAllowRemind" name="isAllowRemind" value="0" trueValue="1" falseValue="0"></td>
            </tr>
            <tr>
                <td align="right" class="fwidthb">整单全免上限金额：<span></span></td>
                <td ><input class="mini-textbox" width="100px" id="freeDiscountMax" name="freeDiscountMax" onvalidation="onRateValidation" value="0" required="true" vtype="range:0,1000000"/>元</td>
            
                <td align="right" class="fwidthb">收银优惠上限金额：</td>
                <td ><input class="mini-textbox" width="100px" name="cashDiscountMax" id="cashDiscountMax" onvalidation="onRateValidation" value="0" required="true" vtype="range:0,1000000"/>元</td>
            </tr>
            <tr>
                <td align="right" class="fwidthb">项目优惠率最高上限：</td>
                <td ><input class="nui-textbox" width="100px" name="itemDiscountRate" id="itemDiscountRate" onvalidation="onRateValidation" value="0" required="true"  vtype="range:0,100">%</td>
          
                <td align="right" class="fwidthb">配件优惠率最高上限：</td>
                <td ><input class="nui-textbox" width="100px" name="partDiscountRate" id="partDiscountRate" onvalidation="onRateValidation" value="0" required="true"  vtype="range:0,100"/>%</td>
            </tr>
            <tr>
                <td align="right" class="fwidthb">积分抵扣上限金额：<span></span></td>
                <td ><input class="nui-textbox" width="100px" name="integralDiscountMax" id="integralDiscountMax" onvalidation="onRateValidation" value="0" required="true" vtype="range:0,1000000"/>元</td>
            </tr>
        </table>
    </fieldset>

</div>
</div>
<script type="text/javascript">
  nui.parse();


  function onChanged(e) {
    var isArtificer = nui.get("isArtificer").value;
    if(isArtificer == true){
        $("#memberLevelId").show();
    }else{
        $("#memberLevelId").hide();
        nui.get("isArtificer").setValue(null);
    }
}
</script>
</body>
</html>