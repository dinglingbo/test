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
<title>用户管理列表</title>
<%@include file="/common/sysCommon.jsp"%>


</head>
<body>
 <div style="margin-left: 5%; margin-top: 2%;">
	 <input class="mini-buttonedit searchbox"/> <input class="nui-button"onclick="isalter" text="更多筛选">

		<a class="nui-button" style="margin-left: 60%;">新建</a>
		<a class="nui-button">修改</a>
		<a class="nui-button">启用</a>
		<a class="nui-button">停用</a>
		<a class="nui-button"  title="重置后用户密码为000000">重置密码</a>
	 <div id="extra" name="extra" style="display: none; margin-top: 1%;">
		<table><tr>
		<td style="width: 20%;">用户角色:<a class="nui-menubutton "  menu="#popupMenu2"id="timeStatus" name="timeStatus">所有</a>
        </td>   		
          <td>     	 
          <ul id="popupMenu2" class="nui-menu" style="display:none;">
                    <li>请选择</li>
                    <li>超级管理员</li>
                    <li>前台</li>
                    <li>连锁店店长</li>
               		<li>采购仓库</li>
                    <li>维修技师</li>
            </ul>	
			</td>
			<td style="width: 60%;"></td>
			<td style="width: 10%;">
			<a class="nui-button">搜索</a>
			</td>
			<td style="width: 10%;">
			<a class="nui-button">清空</a>
			</td>	
		</tr>     
      </table>
	 </div>
 </div>
   <div class="row" style="margin-left: 5%; margin-top: 1%;">
      <span style="background-color: blue; color: white;">
	                   当前激活账户数1,可创建账户上限为1000
	  </span>
   </div>
 <div style="margin-left: 5%; margin-top: 1%;">
 
	<div id="dgGrid" class="nui-datagrid"
				style="width: 95%; height: 50%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">用户名</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="120">对应员工</div>
							<div field="serviceTypeId" allowSort="true" headerAlign="center"
								width="120">角色</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">手机号</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">启用时间</div>
								<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">状态</div>
				</div>
			</div>
			</div>
</body>
 <script type="text/javascript">
      
		nui.parse();
		function isalter(){
		if($("#extra").is(":hidden"))
			$("#extra").show();
		else
			$("#extra").hide();
		
		}
      
       
  </script>
</html>