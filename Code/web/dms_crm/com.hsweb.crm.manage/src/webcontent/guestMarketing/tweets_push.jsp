<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 14:49:04
  - Description:
-->
<head>
    <title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .tbtext {
        float: right;
        width: 70px;
        text-align: right;
    }
    .tbinput{
        width: 100%
    }

    .boxWidth{
        width: 110px;
    }
</style>
</head>
<body>
  <div id="tabs1" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="true">
    <div title="关注用户" >
      <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
          <tr>
            <td>
             关注时间:
             <input class="nui-datepicker boxWidth" id="startDate" name="startDate" dateFormat="yyyy-MM-dd"  /> 至
             <input class="nui-datepicker boxWidth" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" />
             <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
             <li class="separator"></li> 
             <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
             <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
         </td>
     </tr>
 </table>
</div>
<div class="nui-fit">
  <div style="height:100%;width: 100%;">
    <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    allowCellWrap = true
    ondrawcell=""
    multiSelect="true" 
    >
    <div property="columns">
      <div type="checkcolumn" ></div>    
      <div field="" name="" width="80" headerAlign="center" header="手机号"></div>
      <div field="" name="" width="80" headerAlign="center" header="微信昵称"></div>
      <div field="" name="" width="80" headerAlign="center" header="关注时间"></div>
  </div>
</div>
</div>
</div>
</div>
<div title="绑定用户" >
   <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
      <tr>
        <td>
            <label>车牌号：</label>
            <input class="nui-textbox boxWidth" name="" id="" enabled="true"/>
            <label>客户名称：</label>
            <input class="nui-textbox boxWidth" name="" id="" enabled="true"/>
            <label>手机号：</label>
            <input class="nui-textbox boxWidth" name="" id="" enabled="true"/>
            <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            <li class="separator"></li>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
            <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
        </td>
    </tr>
</table>
</div>
<div class="nui-fit">
  <div style="height:100%;width: 100%;">
    <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    allowCellWrap = true
    ondrawcell=""
    multiSelect="true" 
    >
    <div property="columns">
      <div type="checkcolumn" ></div>    
      <div field="" name="" width="80" headerAlign="center" header="昵称"></div>
      <div field="" name="" width="80" headerAlign="center" header="车主"></div>
      <div field="" name="" width="80" headerAlign="center" header="品牌车型"></div>
      <div field="" name="" width="80" headerAlign="center" header="车牌号"></div>
      <div field="" name="" width="80" headerAlign="center" header="手机"></div>
      <div field="" name="" width="80" headerAlign="center" header="openid"></div>
  </div>
</div>
</div>
</div>
</div>
<div title="车辆选择" >
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    更新时间:
                    <input class="nui-datepicker boxWidth" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" /> 至
                    <input class="nui-datepicker boxWidth" id="endDate" name="endDate" dateFormat="yyyy-MM-dd"  />
                    <label>车牌号：</label>
                    <input class="nui-textbox boxWidth" name="" id="" enabled="true"/>
                    <label>客户名称：</label>
                    <input class="nui-textbox boxWidth" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
      <div style="height:100%;width: 100%;">
        <div id="" class="nui-datagrid" style="width:100%;height:100%;"
        pageSize="50"
        totalField="page.count"
        sizeList=[20,50,100,200]
        dataField="list"
        onrowdblclick=""
        allowCellSelect="true"
        allowCellWrap = true
        ondrawcell=""
        multiSelect="true" 
        >
        <div property="columns">
          <div type="checkcolumn" ></div>    
          <div field="" name="" width="80" headerAlign="center" header="门店"></div>
          <div field="" name="" width="80" headerAlign="center" header="车牌号"></div>
          <div field="" name="" width="80" headerAlign="center" header="客户"></div>
          <div field="" name="" width="80" headerAlign="center" header="手机"></div>
          <div field="" name="" width="80" headerAlign="center" header="品牌车型"></div>
      </div>
  </div>
</div>

</div>



</div>

</div>

<script type="text/javascript">
   nui.parse();



</script>
</body>
</html>