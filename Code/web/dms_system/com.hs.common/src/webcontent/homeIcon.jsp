<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

    <head>
        <title>主页图片款式</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%=webPath + contextPath%>/common/js/homeIcon.js?v=1.0.2"></script>
            <style>
                html,
                body {
                    margin: 0px;
                    padding: 0px;
                    border: 0px;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                }

                .mini-panel-border {
                    border-radius: 0px;
                }
            </style>
    </head>

    <body>
        <input id="level" name="level" class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"
        />
        <div class="nui-splitter" style="width:100%;height:100%;">
            <div style="border:0;" size="30%" showCollapseButton="true">
                <div class="nui-fit">
                    <div class="mini-panel" title="选择功能" style="width:100%;height:100%;" bodyStyle="padding:0;">
<!--                          <ul id="tree1" class="nui-tree" style="width:100%;height:100%;" parentField="parentId" showTreeIcon="true" textField="menuName"  
                            idField="menuPrimeKey">
                        </ul> -->
						<ul id="tree1" class="mini-tree" style="width: 100%;height:100%;"
						        showTreeIcon="true" textField="menuName" idField="menuPrimeKey" >        
						    </ul>
                    </div>
                </div>
            </div>
            <div style="border:0;" showCollapseButton="true">
                <div id="grid1" dataField="data" class="nui-datagrid" style="width:100%;height:100%;" borderstyle="border:0;" showColumns="true"
                    showpager="false">
                    <div property="columns">
                        <div field="name" name="business" width="80px" headeralign="center" align="center" header="功能名称"></div>
						<div field="operateBtn" name="operateBtn" align="center" width="50" headerAlign="center" header="操作"></div>
                    </div>
                </div>

            </div>

        </div>

        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>