<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 11:14:08
  - Description:
-->
<head>
<title>出车报告</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/OutCar/outCarReport.js?v=1.0.1"></script>
<style type="text/css">

table {
	table-layout: fixed;
	font-size: 12px;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td>
               <a class="nui-button" plain="true" iconCls="" id="selectBtn" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>                
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height:100%;"
         showHandleButton="false" allowResize="false">
        <div size="200" showCollapseButton="false">
            <div class="nui-fit">
                <div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
                    <span>出车报告类型</span>
                </div>
                <!-- 树形联动 -->
                <div class="nui-fit">
                    <ul id="tree1" class="nui-tree"
                        style="width: 100%;"
                        showTreeIcon="true" textField="name" idField="customid" parentField="parentId"
                        resultAsTree="false"
                        onrowclick="onOutCarRowClick"
                        selectOnLoad="true">
                    </ul>
                </div>
            </div>
        </div>
   <div class="nui-fit">
		<div id="datagrid1" dataField="outs" class="nui-datagrid"
		     style="width: 100%; height: 100%;"
		     showPager="false"
		         selectOnLoad="true"
		         allowSortColumn="true">
	        <div property="columns">
	            <div type="indexcolumn" headerAlign="center" width="30">序号</div>
	            <div header="出车报告列表" headerAlign="center">
	                <div property="columns">
	                    <div field="type" headerAlign="center" allowSort="true" visible="true">报告类型
	                    </div>
	                    <div field="content" headerAlign="center" allowSort="true" visible="true" width="60%">报告内容
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
  </div>
</div>
</body>
</html>