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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp"%>
	 <script src="<%= request.getContextPath() %>/tenant/js/productManager.js?v=1.0.12" type="text/javascript"></script>
    <style type="text/css">
    body {
     margin: 0;
     padding: 0;
     border: 0;
     width: 100%;
     height: 100%;
     overflow: hidden;
 }



</style> 
</head>
<body>
    <div class="nui-toolbar">
<div class="nui-form" id="queryForm">
产品名称：<input class="mini-textbox" emptytext="输入产品名称"  width="125px" style="margin-right:10px;" id="name" name="name" />
<!-- 产品状态：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" data="productStatus" idFeild="id" textFeild="text" id="status" name="status"/>
产品分类：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" data="types" idFeild="id" textFeild="text" id="type" name="type"/> -->
<a class="nui-button" onclick="search()" plain="true" enabled=""><i class="fa fa-search fa-lg"></i>&nbsp;查询</a>

<span class="separator"></span>
<span style="display:inline-block;">
    <a class="nui-button" plain="true" onclick="save(1)"><i class="fa fa-plus fa-lg"></i>&nbsp;新增</a>
    <a class="nui-button" plain="true" onclick="save(2)"><i class="fa fa-pencil fa-lg"></i>&nbsp;修改</a>
    <span class="separator"></span>
    <a class="nui-button" plain="true" onclick="showProductRes()"><i class="fa fa-edit fa-lg"></i>&nbsp;产品资源</a>
</span>
</div> 
</div>

<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
    bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true" dataField="list" 
    sizeList="[20,30,50,100]" pageSize="20" >
    <div property="columns">
    	<div type="indexcolumn" headerAlign="center">排序号</div>
    	<div type="checkcolumn" >选择</div>
        <div field="name" width="80" headerAlign="center" align="center" >产品名称</div>
        <div field="type" width="80" headerAlign="center" align="center" >产品类型</div>
        <div field="proUrl" width="80" headerAlign="center" align="center" >接口地址</div>
        <div field="callNeedCoin" width="80" headerAlign="center" align="center" >单次扣减链车币</div>
        <div field="periodValidity" width="90" headerAlign="center" align="center" >有效期（天）</div>
<!--         <div field="orderNumber" width="80" headerAlign="center" align="center" >排序号</div> -->
        <div field="sellPrice" width="80" headerAlign="center" align="center" >销售价</div>
         <div field="isDisabled" width="80" headerAlign="center" align="center" >是否禁用</div>
        <div field="remark" width="80" headerAlign="center" align="center" >产品描述</div>
        <div field="recorder" width="80" headerAlign="center" align="center" >建档人</div>
        <div field="recordDate" width="80" headerAlign="center" align="center"  dateFormat="yyyy-MM-dd HH:mm">建档时间</div>
        <div field="modifier" width="80" headerAlign="center" align="center" >修改人</div>
        <div field="modifyDate" width="80" headerAlign="center" align="center"  dateFormat="yyyy-MM-dd HH:mm">修改时间</div>
    </div>
</div>
</div>

</body>
</html>