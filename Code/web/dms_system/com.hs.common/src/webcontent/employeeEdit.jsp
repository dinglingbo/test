<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<!-- 
  - Author(s): steven
  - Date: 2018-01-24 23:05:24
  - Description:
-->
<head>
<title>员工资料</title>
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/common/js/employeeEdit.js?v=1.0.0"></script>
</head>
<body>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存关闭</a>
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save('new')">继续添加</a> 					
					<a class="nui-button" plain="true" iconCls="icon-close" onclick="close()">取消关闭</a> 
				</td>
			</tr>
		</table>
	</div>
	
    <div class="nui-fit" style="padding: 10px;overflow: hidden;">
    <fieldset id="fd1" style="width:95%;">
    	<legend><span>员工信息</span></legend>
        <div id="basicInfoForm" class="form">
        	<table border="0" cellpadding="1" cellspacing="2" style="width:100%;table-layout:fixed;">
        	<tr>
        		    <td style="width:100px">
                  <input class="nui-hidden" name="empid"/>
	                <span class="title required">姓名：</span> 
                </td>
                <td style="width:50%"><input name="name" class="nui-textbox"/></td>
                <td style="width:100px"><span class="title required">性别：</span></td>
                <td style="width:50%">
                	<input name="sex" 
                			id="sex" 
                			class="nui-combobox" 
                			textField="name" 
                			valueField="id" 
                			emptyText="请选择..." 
                			data="sexlist" 
                			allowInput="true" 
                			showNullItem="false" 
                			nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
            	<td><span class="title required">部门：</span></td>
                <td><input name="deptId" 
	                	id="deptId" 
	                	class="nui-combobox" 
	                	textField="name" 
	                	valueField="id" 
	                	emptyText="请选择..." 
	                	allowInput="true" 
	                	showNullItem="false" 
	                	nullItemText="请选择..."
	                    url=""
                    />
                </td>       
                <td><span class="title required">职务：</span></td>
                <td>
                	<input name="postId"
                       id="dutyId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url= ""
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
            	<td><span class="title">联系电话：</span></td>
                <td><input name="tel" class="nui-textbox"/></td>
                <td><span class="title">工作电话：</span> </td>
                <td><input name="companymobile" class="nui-textbox"/></td>          
            </tr>            
            <tr>
            	<td><span class="title">身份证号：</span></td>
                <td> <input  style="width:150px;" name="idcardno" class="nui-textbox"/> </td>
                <td><span class="title">出生日期：</span></td> 
                <td><input name= "birthday" id="date1" class="nui-datepicker" value="2010-01-01"/></td>            
            </tr>
            
            <tr>
            	<td><span class="title">是否在职：</span> </td>
                <td><input name="isDimission"
                       id="isDimission"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       data="dimissionlist"
                       allowInput="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                </td>
                <td><span class="title">紧急联系人：</span></td> 
                <td><input name="urgencyperson" class="nui-textbox"/></td>          
            </tr>     
                               
            <tr>
                <td><span class="title">关系：</span></td> 
                <td><input name="urgencypersonrelation" class="nui-textbox"/></td>          
                <td><span class="title">电话：</span></td> 
                <td><input name="urgencypersonphone" class="nui-textbox"/></td>                   
            </tr>   
        </table>
        </fieldset>
    </div>
</body>

</html>
