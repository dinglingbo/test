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
<title>提成参数设置</title>
<script src="<%=webPath + contextPath%>/basic/js/deductParamsMgr.js?v=1.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-splitter"
     id="splitter"
     allowResize="false"
     handlerSize="6"
     style="width:100%;height:100%;">
    <div size="300" showCollapseButton="false">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">角色定义:</label>
                        <a class="nui-button" plain="true" iconCls="" onclick="addRole()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" iconCls="" onclick="saveRole()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    </td>
                </tr>
            </table>
        </div>
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
    <div showCollapseButton="false">
        
        
        <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
	        <!-- 上 -->
	        <div size="50%" showCollapseButton="false">
	         	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="white-space:nowrap;">
		                    	<label style="font-family:Verdana;">角色成员定义:</label>
		                        <a class="nui-button" plain="true" iconCls="" onclick="addDeductMem()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增同级</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="addDeductMemSub()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增子级</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="freshDeductMem()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
		                    </td>
		                </tr>
		            </table>
		        </div>
		        <div class="nui-fit">
			        <div id="deductMemGrid" class="nui-treegrid" style="width:100%;height:100%;" dataField="list"  url="" onrowdblclick="edit()"
				         showTreeIcon="true"  treeColumn="name" expandOnLoad="true" showModified="false"
				         selectOnLoad="true" idField="id" parentField="pid" resultAsTree="false">
				        <div property="columns">
				            <div type="indexcolumn"  headeralign="center" width="20">序号</div>
				            <div field="id" name="id" width="80"  visible="false" >id</div>
				            <div field="parentId" name="pid" width="80"  visible="false" >pid</div>
				            <div field="name" name="name" width="140"  headeralign="center" >名称</div>
				            <div field="creator" name="creator" width="60"  headeralign="center" >创建人</div>
				            <div field="createDate" name="createDate" width="80" dateFormat="yyyy-MM-dd HH:mm"  headeralign="center" >创建日期</div>
				        </div>
				    </div>
		        </div>
        	</div>
        
	        <div  showCollapseButton="false">
	        	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="white-space:nowrap;">
		                    	 <label style="font-family:Verdana;">成员提成参数配置:</label>
		                        <a class="nui-button" plain="true" iconCls="" onclick="addParams()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="saveParams()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
		                    </td>
		                </tr>
		            </table>
		        </div>
		        <div class="nui-fit">
		            <div id="deductParamsGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                 showPager="false"
		                 dataField="list"
		                 idField="id"
		                 allowCellEdit="true"
		                 allowCellSelect="true"
		                 ondrawcell="onDrawCell"
		                 selectOnLoad="true"
		                 sortMode="client"
		                 multiSelect="true"
		                 url="">
		                <div property="columns">
		                    <div type="indexcolumn">序号</div>
		                    <div type="comboboxcolumn" field="type" headerAlign="center" allowSort="false">
                        		提成方式<input  property="editor" enabled="true" allowInput="false" class="nui-combobox" 
                        			valueField="id" textField="name" data="typeList"/> 
                        	</div>  
		                    <div field="beginAmt" width="100" headerAlign="center" allowSort="true">销售金额区间（大于）
		                    	<input property="editor" vtype="float" class="nui-textbox"/>
		                    </div>
		                    <div field="endAmt" width="100" headerAlign="center" allowSort="true">销售金额区间（小于或等于）
		                    	<input property="editor" vtype="float" class="nui-textbox"/>
		                    </div>
		                    <div field="deductRate" width="60" headerAlign="center" allowSort="true">提成比例(%)
		                    	<input property="editor" vtype="float" class="nui-textbox"/>
		                    </div>
		                    <div field="creator" width="60" headerAlign="center" allowSort="true">创建人</div>
		                    <div field="createDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">创建日期</div>
		                </div>
		            </div>
		        </div>
	        </div>
        </div>
        
        
    </div>
</div>

<div id="advancedMemSetWin" class="nui-window"
     title="新增角色成员" style="width:300px;height:150px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <div class="nui-fit">
    	<div id="memForm" class="form" contenteditable="false">
    		<input class="nui-hidden" name="pid"/>
    		<input class="nui-hidden" name="roleId"/>
    		<input class="nui-hidden" name="type"/>
	        <table style="width: 100%;height: 100%;">
	        	<tr >
	                <td colspan="2"  style="text-align: left;">
	                    <label style="color: #9e9e9e;" id="t">当前角色：</label>
	                </td>
	            </tr>
	            <tr >
	                <td style="text-align: right;">
	                    上级成员：
	                </td>
	                <td >
	                    <input property="editor" id="pname" name="pname" width="80%" class="nui-textbox" enabled="false" />
	                </td>
	            </tr>
	            <tr >
	                <td style="text-align: right;">
	                    名称：
	                </td>
	                <td >
	                    <input property="editor" id="memName" name="memName"  width="80%" class="nui-textbox" selectOnFocus="true" />
	                </td>
	            </tr>
	            <tr >
	                <td colspan="2" style="text-align: center;">
	                    <a class="nui-button"  plain="false" onclick="saveDeductMem()">确定</a>
	                    <a class="nui-button"  plain="false" onclick="cancel()">取消</a>
	                </td>
	            </tr>
	        </table>
	    </div>
    </div>
</div>   	

</body>
</html>
