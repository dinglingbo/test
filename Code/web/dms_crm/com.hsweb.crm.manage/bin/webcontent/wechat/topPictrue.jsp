<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
    <title>顶部图片</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>


                    <label>幻灯名称：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="newEvent()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
        pageSize="50"
        multiSelect="true"
        totalField="page.count"
        sizeList=[20,50,100,200]
        dataField="list"
        onrowdblclick=""
        allowCellSelect="true"
        allowCellWrap = true
        ondrawcell=""
        >
        <div property="columns">

            <div type="checkcolumn" ></div>    
            <div field="" name="" width="80" headerAlign="center" header="幻灯名称"></div>
            <div field="" name="" width="80" headerAlign="center" header="缩略图"></div>
            <div field="" name="" width="80" headerAlign="center" header="图片" ></div>
            <div field="" name="" width="80" headerAlign="center" header="排序" ></div>
        </div>


    </div>

    <script type="text/javascript">
     nui.parse();


               function newEvent(){
             nui.open({
             url: webPath + contextPath  + "/manage/wechat/topPictrue_edit.jsp",
             title: "新增图片",
             width: 400, 
             height: 300,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }
 </script>
</body>
</html>