<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 <%@include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-12 16:44:24
  - Description:
-->
<head>
<title>客户来源</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   
     <script src="<%= request.getContextPath() %>/config/js/userFrom.js?v=1.2.5"></script>
</head>
<body>

	
	
	 <div style="margin-left: 58%; margin-top: 5%; height: 3%;">
	 <input class="nui-button"onclick="newRow" iconCls="icon-add" text="新建" >
	 <input class="nui-button"onclick="editRow" iconCls="icon-edit" text="修改" >
	 <input class="nui-button"onclick="stopRow('1')" iconCls="icon-remove" text="停用">
	 <input class="nui-button"onclick="stopRow('2')" iconCls="icon-addnew" text="启用">
	 </div>
	 <div style="margin-left: 5%; margin-top: 1%; height: 80%;">
 
	<div id="dgGrid" class="nui-datagrid" 
				style="width: 60%; height: 40%; float: right; margin-right: 28%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"  
				 dataField="data" idField="id" allowCellEdit="true" allowCellSelect="true"treeColumn="name" parentField="parentId" showPager="false">
				<div property="columns" width="10">
				<div field="id" allowSort="true" headerAlign="center" visible="false"
								width="120">id</div>
				<div field="orgid" allowSort="true" headerAlign="center"  visible="false"
								width="120">orgid</div>
				<div field="name" allowSort="true" headerAlign="center"
								width="120">客户来源</div>
				<div field="isDisabled" allowSort="true" headerAlign="center"
								width="120">状态</div>	
				</div>
			</div>
	</div>
<div id="editWindow" class="mini-window" title="新建分类" style="width:650px;" 
  			showModal="true" allowResize="true" allowDrag="true">
   	 <div id="editform" class="form" >
        <input class="nui-hidden" name="id"/>
        <table style="width:100%;">
            <tr>
                <td style="width:80px; text-align: right;">客户来源</td>
                <td style="width:150px;  text-align: center;"><input name="name" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td style="width:80px; text-align: right;">是否启用</td>
                <td style="width:150px;  text-align: center;"><input class="nui-combobox" id="isDisabled" name="isDisabled" value=""   width="70px"  textField="name" valueField="id" data="typeList"/></td>
            </tr>
            <tr>
                <td  colspan="6"  style="text-align: center;" >
                    <input class="nui-button" text="确认" onclick="onOk"></input> 
                    <input class="nui-button" text="取消" onclick="onCancel"></input>
                </td>                
            </tr>
       
        </table>
    </div>
    
</div>
	

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>