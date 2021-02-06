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
    <title>推文营销</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
     <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label>标题：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="push()" id="addBtn"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="list()" id="addBtn"><span class="fa fa-tablet fa-lg"></span>&nbsp;推送详情</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="file()" id="addBtn"><span class="fa fa-file fa-lg"></span>&nbsp;wechat素材</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
        pageSize="50"
        multiSelect="false"
        totalField="page.count"
        sizeList=[20,50,100,200]
        dataField="list"
        onrowdblclick=""
        allowCellSelect="true"
        allowCellWrap = true
        ondrawcell="">
        <div property="columns">

            <div type="checkcolumn" ></div>
            <div field="serviceCode" name="serviceCode" width="80" headerAlign="center" header="ID"></div>
            <div field="visitMan" name="visitMan" width="130" headerAlign="center" header="标题"></div>
            <div field="carType" name="carType" width="80" headerAlign="center" header="类型"></div>
            <div field="auditSign" name="auditSign" width="80" headerAlign="center" header="时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="auditOpinion" name="auditOpinion" width="80" headerAlign="center" header="状态"></div>
        </div>
    </div>


</div>

<script type="text/javascript">
 nui.parse();


               function push(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/tweets_push.jsp",
             title: "推文推送",
             width: 950, 
             height: 400,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

                  function list(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/tweetsPushList.jsp",
             title: "推送列表",
             width: 950, 
             height: 400,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

                  function edit(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/tweets_edit.jsp",
             title: "添加推文",
             width: 700, 
             height: 390,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }


                     function file(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/wechatFile.jsp",
             title: "微信素材",
             width: 950, 
             height: 400,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }

</script>
</body>
</html>