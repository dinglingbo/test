<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:05:48
  - Description:
-->
<head>
<title>选择提成成员</title>
<script src="<%=webPath + contextPath%>/basic/js/selectMember.js?v=1.0.44"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	  <table style="width:100%;">
		  	<td style="white-space:nowrap;">
		  		<input class="nui-hidden" id ="serviceId" name="serviceId">
		  		<a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
		  		<a class="nui-button" iconCls="" plain="true" onclick="close()" id="closeBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		  		名称：<input class="nui-textbox" id ="name" name="name">
		  		<a class="nui-button" iconCls="" plain="true" onclick="search()" id="searchBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		  	</td>
	  </table>
	</div>
	<div class="nui-splitter"
	     id="splitter"
	     allowResize="false"
	     vertical="true"
	     handlerSize="6"
	     style="width:100%;height:92%;">
		<!--上 -->
	    <div size="60%" showCollapseButton="false" >
	    	
	    	<div class="nui-splitter"
			     id="splitter"
			     allowResize="false"
			     handlerSize="6"
			     style="width:100%;height:100%;">
				<!--   左 -->
			    <div size="20%" showCollapseButton="false">
			    	 <div class="nui-fit">
			        	<div id="roleGrid" class="nui-datagrid" style="width:100%;height:100%;"
			                 showPager="false"
			                 dataField="list"
			                 idField="id"
			                 allowCellEdit="true"
			                 allowCellSelect="true"
			                 selectOnLoad="true"
			                 sortMode="client" showModified="false"
			                 url="">
			                <div property="columns">
			                    <div type="indexcolumn">序号</div>
			                    <div field="name" name="name" headerAlign="center" allowSort="true" header="角色名称">
			                        <input property="editor" class="nui-textbox" style="width:100%;"/>
			                    </div>
			                </div>
			            </div>
			        </div>
			    	
			   	</div>
			   	<!--  右 -->
			   	<div size="" showCollapseButton="false">
			   		<div class="nui-fit">
				        <div id="deductMemGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="list"  url="" onrowdblclick="edit()"
					         showTreeIcon="true"  treeColumn="name" expandOnLoad="true" showModified="false"
					         selectOnLoad="true" idField="id" parentField="pid" resultAsTree="false"
					          multiSelect="true"  selectOnLoad="true">
					        <div property="columns">
					            <div type="indexcolumn"  headeralign="center" width="20">序号</div>
					            <div type="checkcolumn" width="20"></div>
					            <div field="id" name="id" width="80"  visible="false" >id</div>
					            <div field="parentId" name="pid" width="80"  visible="false" >pid</div>
					            <div field="name" name="name" width="140"  headeralign="center" >名称</div>
					            <div field="creator" name="creator" width="60"  headeralign="center" >创建人</div>
					            <div field="createDate" name="createDate" width="80" dateFormat="yyyy-MM-dd HH:mm"  headeralign="center" >创建日期</div>
					        </div>
					    </div>
			        </div>
			   	</div>		   	
		   	</div>
		   	
	    </div>
		<!--  下 -->
	    <div size="40%" showCollapseButton="false">
	    	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	    		<span>已选择成员</span>
	    	</div>
	    	<div class="nui-fit">
		    	<div id="haveSelectGrid" class="nui-datagrid"
		    		 showPager="false"
	                 dataField="data"
	                 style="width:100%;height:95%;"
	                 idField="id"
	                 allowCellEdit="true"
	                 allowCellSelect="true"
	                 ondrawcell="onDrawCell"
	                 selectOnLoad="true"
	                 sortMode="client"
	                 multiSelect="true">                 
	                 <div property="columns">
	                 	 <div type="indexcolumn">序号</div>
	                 	 <div field="roleId" width="100" headerAlign="center" allowSort="true" header="角色名称"></div>
	                 	 <div field="deductMemName" width="100" headerAlign="center" allowSort="true" header="成员名称"></div>
	                 	 <div field="creator" width="100" headerAlign="center" allowSort="true" header="添加人"></div>
	             	     <div field="createDate" width="100" headerAlign="center" allowSort="true"dateFormat="yyyy-MM-dd HH:mm" header="添加日期"></div>
	                 </div>
		    	</div>
		    </div>
	    </div>
	</div>

</body>
</html>
