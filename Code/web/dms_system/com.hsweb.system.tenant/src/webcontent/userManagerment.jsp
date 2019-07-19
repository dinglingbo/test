<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>用户管理</title>
    <%@include file="/common/sysCommon.jsp"%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	 <script src="<%= request.getContextPath() %>/tenant/js/userManager.js?v=1.9.13"
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

 .gridborder .nui-panel-border,.gridborder .nui-grid-border{
    border-top: 0px ;

}

.nui-toolbar
{
  font-weight:bold;
}

.nui-grid-headerCell, .nui-grid-topRightCell
{
  font-weight:bold;
}
.nui-checkbox-check {

    margin-right: 0px;
    
}

.nui-panel-border {
    border-radius: 0px;
}

</style> 
</head>
<body>

   <div class="nui-toolbar">
	<div class="nui-form" id="queryForm" style="height: 100%">
       <label style="font-family:Verdana;">是否付费：</label>
        <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate1" menu="#popupMenu1" >付费</a>
        <ul id="popupMenu1" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch1(1)">付费</li>
            <li iconCls="" onclick="quickSearch1(0)">免费</li>
            <li iconCls="" onclick="quickSearch1(2)">所有</li>
        </ul>
        <label style="font-family:Verdana;">是否在用：</label>
        <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >在用</a>
        <ul id="popupMenu" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch(1)">停用</li>
            <li iconCls="" onclick="quickSearch(0)">在用</li>
            <li iconCls="" onclick="quickSearch(2)">所有</li>
            
        </ul>
        <label style="font-family:Verdana;">到期：</label>
        <input class="nui-combobox" id="endDatet" emptyText="" name="endDatet" data="[{endDatet:0,text:''},{endDatet:1,text:'一周内'},{endDatet:2,text:'一个月内'}]"
                          width="90px"   textField="text" valueField="endDatet" value=""/>
         <label style="font-family:Verdana;">开通时间：</label>
        <input class="nui-combobox" id="startDatet" emptyText="" name="startDatet" data="[{startDatet:0,text:''},{startDatet:1,text:'本周'},{startDatet:2,text:'本月'},{startDatet:3,text:'本年'},{startDatet:4,text:'上年'}]"
                          width="60px"   textField="text" valueField="startDatet" value=""/>
           <input  class="nui-textbox" emptytext="输入租户ID"  width="125px" style="margin-right:0px;" name="tenantId" onenter="search()"/>
           <input  class="nui-textbox" emptytext="输入租户名称"  width="125px" style="margin-right:0px;" name="tenantName" onenter="search()"/>
           <input  class="nui-textbox" emptytext="租户手机号"  width="125px" style="margin-right:0px;" name="mobile" onenter="search()"/>
           <input  class="nui-combobox" emptytext="选择省份"  width="125px" style="margin-right:0px;"id="provinceId" name="provinceId" textField="name"  valueField="code" onvaluechanged="onProvinceChange" />
           <input  class="nui-combobox" emptytext="选择城市"  width="125px" style="margin-right:0px;"  id="cityId" name="cityId" textField="name"  valueField="code"/>
           <input  class="nui-textbox" emptytext="业务员"  width="125px" style="margin-right:0px;" name="salesMan" id="salesMan" onenter="search()"/>
           <input  class="nui-textbox" emptytext="推荐人"  width="125px" style="margin-right:0px;" name="referee" id="referee" onenter="search()"/>
            <a class="nui-button" onclick="search()" plain="true" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
            <span style="display:inline-block;">
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="ViewType(5)"><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="stoporstart()"><i class="fa fa-exchange"></i>&nbsp;启用/禁用</a>
                <span class="separator"></span>
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="ViewType(1)"><i class="fa fa-cubes"></i>&nbsp;查看产品</a>
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="ViewType(2)"><i class="fa fa-list"></i>&nbsp;查看订单</a>
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="ViewType(3)"><i class="fa fa-cny"></i>&nbsp;查看费用</a>
                <a class="nui-button " plain="true" style="" iconcls="" plain="false" onclick="ViewType(4)"><i class="fa fa-map"></i>&nbsp;查看发票</a>
            </span>
        </div> 
	</div>
        <div class="nui-fit">
            <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
            bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true" dataField="rs"  totalField="page.count"
            sizeList="[20,30,50,100]"  frozenStartColumn="0" frozenEndColumn="3" pageSize="20" showPageInfo="true"
             allowCellWrap = "true"
            >  
           
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div type="checkboxcolumn" trueValue="1" falseValue="0" field="isPay" name="isPay"  width="60" headerAlign="center" header="是否付费" allowsort="true"></div>
            	<div type="checkboxcolumn" trueValue="0" falseValue="1" field="isDisabled" name="isDisabled"  width="60" headerAlign="center" header="是否在用" allowsort="true"></div>
            	<div field="tenantId" width="80" headerAlign="center" align="center" >租户ID</div>
                <div field="code" width="80" headerAlign="center" align="center" visible="false">租户ID</div>
                <div field="tenantType" width="120" headerAlign="center" align="center">租户类型</div>
                <div field="tenantName" width="120" headerAlign="center" align="center">租户名称</div>
                <div field="orgQty" width="80" headerAlign="center" align="center">门店数量</div>
                <div field="provinceId" width="80" headerAlign="center" align="center">省份</div>
                <div field="cityId" width="80" headerAlign="center" align="center">城市</div>
                <div field="manager" width="80" headerAlign="center" align="center">管理员</div>
                <div field="managerIdentity" width="80" headerAlign="center" align="center">管理员身份</div>
                <div field="mobile" width="80" headerAlign="center" align="center">联系电话</div>
                <div field="address" width="80" headerAlign="center" align="center">联系地址</div>
                <div field="recordDate" width="80" headerAlign="center" align="center"dateFormat="yyyy-MM-dd HH:mm" >注册时间</div>
                <div field="auditDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm" >审核时间</div>
                <div field="startDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm" >开通时间</div>
                <div field="endDate" width="80" headerAlign="center" align="center"dateFormat="yyyy-MM-dd HH:mm" >结束时间</div>
                <div field="auditMan" width="80" headerAlign="center" align="center">审核人</div>
                <div field="salesMan" width="80" headerAlign="center" align="center">业务员</div>
                <div field="referee" width="80" headerAlign="center" align="center">推荐人</div>
                <div field="InvitationNumber" width="80" headerAlign="center" align="center">邀请号</div>
                <!-- <div field="isDisabled" width="80" headerAlign="center" align="center">是否在用</div>
                <div field="isPay" width="80" headerAlign="center" align="center">是否付费</div> -->
                 <div field="firstPayAmt" width="80" headerAlign="center" align="center">首次付费金额</div>
                <div field="nextRenewDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">下次续费时间</div>
               <div field="nextRenewAmt" width="80" headerAlign="center" align="center">下次续费金额</div>
            </div>
        </div>
    </div>

<script type="text/javascript">
  nui.parse();


  



</script>
</body>
</html>