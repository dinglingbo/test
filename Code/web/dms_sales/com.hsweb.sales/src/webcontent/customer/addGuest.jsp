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
    <script src="<%=webPath + contextPath%>/common/js/employeeEdit.js?v=1.1.9" type="text/javascript"></script>
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
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
            <fieldset id="fd1" style="width:800px;">
                <legend><span>基本信息</span></legend>
                <table >
                    <!-- <tr>
                        <td align="right">姓名:</td>
                        <td><input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" readonly="readonly" emptyText="系统自动分配"/></td>
                        <td align="right">所属工作组:</td>
                        <td><input class="nui-combobox"  required="false" id="memberGroupId" name="memberGroupId" textField="name" valueField="id" emptyText="选择工作组"/></td>
                    </tr> -->

                    <tr>
                        <td align="right" style="width:80px"><font color="red" >姓名：</font></td>
                        <td><input class="nui-textbox"  id="name" name="name" vtype="maxLength:6" required="true" width="100%"/></td>
                        <td align="right" style="width:80px"><font color="red">性别：</td>
                        <td>
                           <input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'男'},{billTypeId:2,text:'女'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
                        
                        </td>
                         <td align="right" style="width:80px"><font color="red">客户来源:</td>
                         <td><input class="nui-combobox" width="100%" required="false" id="memberGroupId" name="memberGroupId" textField="name" valueField="id" emptyText=""/></td>
     
                    </tr>
                    <tr>
                        <td align="right" ><font color="red">性格：</font></td>
                        <td>
                    	<input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'内向'},{billTypeId:2,text:'外向'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
                        </td>
                        
                        <td align="right" >身份证号：</td>
                        <td>
                           <input class="nui-textbox"  id="name" name="name" vtype="maxLength:6" required="true" width="100%"/>
                        </td>
                         <td align="right"><font color="red">购车次数:</td>
                         <td>
                         		<input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'首次购车'},{billTypeId:2,text:'再次购车'},{billTypeId:3,text:'首次在本店购车'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
                           
                         </td>
     
                    </tr>
                <tr>
                    <td align="right" style="width:60px"><font color="red" >手机号码：</font></td>
                    <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" width="100%"/></td>
                    <td align="right" ><font color="red">特征：</font></td>
                    <td>
                       <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
				            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
				          
                    </td>
                    <td align="right" ><font color="red">销售顾问：</font></td>
                    <td>
                       <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
				            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
				          
                    </td>
                    <!-- <td align="right">是否服务技师：</td>
                    <td><div  class="nui-checkbox" id="isArtificer" name="isArtificer" value="0" trueValue="1" falseValue="0" onvaluechanged="onChanged"></div>
                    <input class="nui-combobox" id="memberLevelId" name="memberLevelId" required="false" style="width: 107px;display: none;" emptytext="选择技师等级" textField="name" valueField="id"/>
                          <div id="isArtificer" name="isArtificer" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                          textField="name" valueField="id" value="1"  width="100%"
                          url="" > 
                      </div>
                  </td> -->
              </tr>
        </table>
    </fieldset>
    <fieldset id="fd1" style="width:800px;">
        <legend><span>其它信息</span></legend>
        <table>
            <tr>
                <td align="right" style="width:60px"><font color="red">身份：</font></td>
                <td>
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
			            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
			          
                </td>
                <td align="right" style="width:60px">电话：</td>
                <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" width="100%"/></td>
                <td align="right" style="width:80px">婚姻状况：</td>
                 <td>
                 <input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'已婚'},{billTypeId:2,text:'未婚'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value=""/>
                            
                </td>
            </tr>
            <tr>
                <td align="right" style="width:80px">生日类型：</td>
                <td>
            	<input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'农历'},{billTypeId:2,text:'阳历'}]"
                  width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="1"/>
                </td>
		        <td align="right" >生日：</td>
		        <td><input class="nui-datepicker" id="birthday" name="birthday" width="100%"/></td>
            </tr>
            <tr>
                 <td align="right" >住址：</td>
                <td colspan="3"><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" width="100%"/></td>
                <td align="right" >邮箱：</td>
                <td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" width="100%"/></td>
            </tr>
            <tr>
                <td align="right" >行业：</td>
                <td>
                   <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
			            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
			          
                </td>
                <td align="right" style="width:80px"> 工作单位：</td>
                <td ><input class="nui-textbox"  id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" width="100%"/></td>
                <td align="right">特别关注：</td>
                <td ><input class="nui-textbox"  id="idcardno" name="idcardno" required="true" onvalidation="onIDCardsValidation" width="100%"/></td>
            </tr>
            <tr>
               <td class="form_label" align="right">备注:</td>
	          <td colspan="5"><input class="nui-TextArea" name="useRemark"
		       style="width: 100%; height: 50px;" />
		       </td>
							
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