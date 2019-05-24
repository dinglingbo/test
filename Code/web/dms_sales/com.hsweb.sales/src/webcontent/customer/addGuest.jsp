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
                            <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="id" />
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
                        <td><input class="nui-textbox"  id="name" name="name"  width="100%"/></td>
                        <td align="right" style="width:80px"><font color="red">性别：</td>
                        <td>
                           <input class="nui-combobox" id="sex" emptyText="" name="sex" data="[{sex:1,text:'男'},{sex:0,text:'女'}]"
                          width="100%"   textField="text" valueField="sex" value="1"/>
                        
                        </td>
                         <td align="right" style="width:80px"><font color="red">客户来源:</td>
                         <td>
                            <input name="source"
				             id="source"
				             class="nui-combobox"
				             textField="name"
				             valueField="id"
				             allowInput="true"
				             width="100%"
				             visible="true"
				            />
                         </td>
     
                    </tr>
                    <tr>
                       <!--  <td align="right" ><font color="red">性格：</font></td>
                        <td>
                    	<input class="nui-combobox" id="nature" emptyText="" name="nature" data="[{nature:1,text:'内向'},{nature:2,text:'外向'}]"
                          width="100%"   textField="text" valueField="nature" value="1"/>
                        </td> -->
                        <td align="right" ><font color="red">特征：</font></td>
                        <td>
				           <input name="nature"
				             id="nature"
				             class="nui-combobox"
				             textField="name"
				             valueField="id"
				             allowInput="true"
				             width="100%"
				            />
                        </td>
                        <td align="right" >身份证号：</td>
                        <td>
                           <input class="nui-textbox"  id="idNo" name="idNo"  width="100%"/>
                        </td>
                         <td align="right"><font color="red">购车次数:</td>
                         <td>
                         		<input class="nui-combobox" id="buyCarStatus" emptyText="" name="buyCarStatus" data="[{buyCarStatus:1,text:'首次购车'},{buyCarStatus:2,text:'再次购车'},{buyCarStatus:3,text:'首次在本店购车'}]"
                          width="100%"   textField="text" valueField="buyCarStatus" value="1"/>
                           
                         </td>
     
                    </tr>
                <tr>
                    <td align="right" style="width:60px"><font color="red" >手机号码：</font></td>
                    <td><input class="mini-textbox" id="mobile" name="mobile"  width="100%"/></td>
                    <td align="right" ><font color="red">销售顾问：</font></td>
                    <td>
                       <input name="saleAdvisorId" id="saleAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
				            emptyText="" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"  />
				          
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
                   <input name="identity"
		             id="identity"
		             class="nui-combobox"
		             textField="name"
		             valueField="id"
		             allowInput="true"
		             width="100%"
		             visible="true"
		            />      
                </td>
                <td align="right" style="width:60px">电话：</td>
                <td><input class="mini-textbox" id="tel" name="tel"   width="100%"/></td>
                <td align="right" style="width:80px">婚姻状况：</td>
                 <td>
                 <input class="nui-combobox" id="billTypeId" emptyText="" name="billTypeId" data="[{billTypeId:1,text:'已婚'},{billTypeId:2,text:'未婚'}]"
                          width="100%"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value=""/>
                            
                </td>
            </tr>
            <tr>
                <td align="right" style="width:80px">生日类型：</td>
                <td>
            	<input class="nui-combobox" id="birthdayType" emptyText="" name="birthdayType" data="[{birthdayType:0,text:'农历'},{birthdayType:1,text:'阳历'}]"
                  width="100%"  textField="text" valueField="birthdayType" value="0"/>
                </td>
		        <td align="right" >生日：</td>
		        <td><input class="nui-datepicker" id="birthday" name="birthday" width="100%"/></td>
            </tr>
            <tr>
                 <td align="right" >住址：</td>
                <td colspan="3"><input class="mini-textbox" id="idAddress" name="idAddress"  width="100%"/></td>
                <td align="right" >邮箱：</td>
                <td><input class="mini-textbox" id="email" name="email"  width="100%"/></td>
            </tr>
            <tr>
                <td align="right" >行业：</td>
                <td>
                   <input name="trade"
		             id="trade"
		             class="nui-combobox"
		             textField="name"
		             valueField="id"
		             allowInput="true"
		             width="100%"
		            />
                </td>
                <td align="right" style="width:80px"> 工作单位：</td>
                <td ><input class="nui-textbox"  id="workPlace" name="workPlace"  width="100%"/></td>
                <td align="right">特别关注：</td>
                <td ><input class="nui-textbox"  id="specialCare" name="specialCare"  width="100%"/></td>
            </tr>
            <tr>
               <td class="form_label" align="right">备注:</td>
	          <td colspan="5"><input class="nui-TextArea" name="remark"
		       style="width: 100%; height: 50px;" />
		       </td>
							
            </tr>
           
        </table>
    </fieldset>

</div>
</div>
<script type="text/javascript">
  nui.parse();
var basicInfoForm = null;
$(document).ready(function (){
  basicInfoForm = new nui.Form("#basicInfoForm");
  initDicts({
	 identity:"DDT20171016000001",
	 trade:"10363",
	 source:GUEST_SOURCE,
	 nature:10181
    },function(data){
   });
   initMember("saleAdvisorId",function(){
      
    });
   document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }
     }  
});

var requiredField = {
	name : "客户名称",
	sex:"性别",
	source:"客户来源",
	nature:"特征",
	buyCarStatus:"购车次数",
	mobile : "手机号",
	saleAdvisorId : "销售顾问",
	identity:"身份"
};
var saveUrl = apiPath + saleApi +"/sales.custormer.saveGuestContactor.biz.ext";
function save(){
   var data = basicInfoForm.getData();
   for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            //nui.get(key).focus();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
    var guest = {};
    var contactor = {};
    guest.fullName = data.name;
    guest.shortName = data.name;
    guest.idCard = data.idNo,
    guest.mobile = data.mobile;
    guest.sex = data.sex;
    guest.birthdayType = data.birthdayType;
    guest.email = data.email;
    contactor = data;
   nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
     var json = nui.encode({
   		 contactor:contactor,
   		 guest:guest,
   		 token:token
   	  });
	nui.ajax({
		url : saveUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(text.errCode=="S"){
		    	var contactor1 = text.contactor;
		    	var guest1 = text.guest;
		    	var setData = {};
		    	setData = contactor1;
		    	setData.id = guest1.id;
		    	setData.email = guest1.email;
		    	basicInfoForm.setData(setData);
		    	showMsg("保存成功","S");
		    }else{
		    	showMsg("保存失败","E");
		    }
			nui.unmask(document.body);
		}
    }); 
}
 
</script>
</body>
</html>