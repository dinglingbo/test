<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>产品管理</title>
    <%@include file="/common/sysCommon.jsp"%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	 <script src="<%= request.getContextPath() %>/tenant/js/productManager.js?v=1.8"
	type="text/javascript"></script>
    <style type="text/css">
    body {
     margin: 0;
     padding: 0;
     border: 0;
     width: 100%;
     height: 100%;
     overflow: hidden;
 }

 .gridborder .mini-panel-border,.gridborder .mini-grid-border{
    border-top: 0px ;

}

.mini-toolbar
{
  font-weight:bold;
}

.mini-grid-headerCell, .mini-grid-topRightCell
{
  font-weight:bold;
}
.mini-checkbox-check {

    margin-right: 0px;
    
}

.mini-panel-border {
    border-radius: 0px;
}

</style> 
</head>
<body>
    <div class="nui-toolbar">
<div class="nui-form" id="queryForm">
产品名称：<input class="mini-textbox" emptytext="输入产品名称"  width="125px" style="margin-right:10px;" id="name" name="name" />
产品状态：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" data="productStatus" idFeild="id" textFeild="text" id="status" name="status"/>
产品分类：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" data="types" idFeild="id" textFeild="text" id="type" name="type"/>
<a class="nui-button" onclick="search()" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>

<span class="separator"></span>
<span style="display:inline-block;">
    <a class="nui-button" plain="false" onclick="ViewType(1)"><i class="fa fa-plus"></i>&nbsp;新增</a>
    <a class="nui-button" plain="false" onclick="ViewType(2)"><i class="fa fa-pencil"></i>&nbsp;修改</a>
    <a class="nui-button" plain="false" onclick="remove()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
    <span class="separator"></span>
    <a class="nui-button " style="" iconcls="" plain="false" onclick="upOrDown('1')"><i class="fa fa-long-arrow-up"></i>&nbsp;上架</a>
    <a class="nui-button " style="" iconcls="" plain="false" onclick="upOrDown('0')"><i class="fa fa-long-arrow-down"></i>&nbsp;下架</a>
</span>
</div> 
</div>

<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
    bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true" dataField="rs" 
    sizeList="[20,30,50,100]" pageSize="20" >
    <div property="columns">
    	<div type="checkcolumn" >选择</div>
        <div field="code" width="80" headerAlign="center" align="center" id="code">产品ID</div>
        <div field="type" width="80" headerAlign="center" align="center" id="type">产品类型</div>
        <div field="name" width="80" headerAlign="center" align="center" id="name">产品名称</div>
        <div field="remark" width="80" headerAlign="center" align="center" id="remark">产品描述</div>
        <div field="isCycle" width="90" headerAlign="center" align="center" id="isCycle">是否限定周期</div>
        <div field="cycle" width="90" headerAlign="center" align="center" id="cycle">产品限定周期</div>
        <div field="consumptionTimes" width="95" headerAlign="center" align="center" id="consumptionTimes">周期内消费次数</div>
        <div field="orderNumber" width="80" headerAlign="center" align="center" id="orderNumber">排序号</div>
        <div field="status" width="80" headerAlign="center" align="center" id="status">产品状态</div>
        <div field="isRecommend" width="80" headerAlign="center" align="center" id="isRecommend">是否推荐</div>
        <div field="salesPrice1" width="80" headerAlign="center" align="center" id="salesPrice1">原价</div>
        <div field="salesPrice2" width="80" headerAlign="center" align="center" id="salesPrice2">活动价</div>
        <div field="recordDate" width="80" headerAlign="center" align="center" id="recordDate" dateFormat="yyyy-MM-dd hh:MM">建档时间</div>
        <div field="recorder" width="80" headerAlign="center" align="center" id="recorder">建档人</div>
        <div field="modifyDate" width="80" headerAlign="center" align="center" id="modifyDate" dateFormat="yyyy-MM-dd hh:MM">修改时间</div>
        <div field="modifyDate" width="80" headerAlign="center" align="center" id="modifier">修改人</div>
    </div>
</div>
</div>
<script type="text/javascript">
    var productStatus = [{id:"",text:"全部"},{id:"1",text:"上架"},{id:"2",text:"下架"}];
    var types = [{id:"",text:"全部"},{id:"1",text:"上架"},{id:"2",text:"下架"}];
    nui.parse();






</script>
</body>
</html>