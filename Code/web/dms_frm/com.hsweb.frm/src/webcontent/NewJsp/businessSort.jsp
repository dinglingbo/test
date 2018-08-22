<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>业务分类列表</title>
<%@include file="/common/sysCommon.jsp"%>
<%-- <script src="<%=webPath + contextPath%>/frm/Newjs/p.js?v=1.0"
	type="text/javascript"></script> --%>

</head>
<body>

			<div style="width: 80%; height: 10%; margin-left: 10%; margin-top: 1%;">
			<input  class="nui-button" onclick="editRow" text="新建"  style="float:right; margin-top: 10px;"></input>		
			</div>
			<div >
			<div id="dgGrid" class="nui-datagrid" 
				style="width: 80%; height: 40%; margin-left: 10%; "pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			<%-- 	url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" --%>
				onselectionchanged="statuschange" dataField="data" idField="id"
				treeColumn="name" parentField="parentId" showPager="false">
				<div property="columns" width="10">

							<div field="remark" allowSort="true" headerAlign="center"
								width="120">业务分类名称</div>
							<div field="remark" allowSort="true" headerAlign="center"
								width="120">操作</div>

				</div>

			</div>
			</div>
			<div id="editWindow" class="mini-window" title="新建分类" style="width:650px;" 
  			showModal="true" allowResize="true" allowDrag="true">
   	 <div id="editform" class="form" >
        <input class="mini-hidden" name="id"/>
        <table style="width:100%;">
            <tr>
                <td style="width:80px; text-align: right;">分类名称</td>
                <td style="width:150px;  text-align: center;"><input name="loginname" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td  colspan="6"  style="text-align: center;" >
                    <input class="nui-button" text="确认"></input> 
                    <input class="nui-button" text="取消"></input>
                </td>                
            </tr>
       
        </table>
    </div>
    
</div>
</body>
 <script type="text/javascript">
      
		nui.parse();

        var editWindow = mini.get("editWindow");
       
		 function editRow() {
       

                editWindow.show();
              
        }
       
       
    </script>
</html>