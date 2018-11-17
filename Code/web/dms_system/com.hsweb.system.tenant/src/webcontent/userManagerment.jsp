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
	 <script src="<%= request.getContextPath() %>/tenant/js/userManager.js?v=1.9.6"
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
            租户ID：<input  class="nui-textbox" emptytext="输入租户ID"  width="125px" style="margin-right:10px;" name="code" />
            租户名称：<input  class="nui-textbox" emptytext="输入租户名称"  width="125px" style="margin-right:10px;" name="tenantName" />
            省份：<input  class="nui-combobox" emptytext="选择省份"  width="125px" style="margin-right:10px;"id="provinceId" name="provinceId" textField="name"  valueField="code" onvaluechanged="onProvinceChange" />
            城市：<input  class="nui-combobox" emptytext="选择城市"  width="125px" style="margin-right:10px;"  id="cityId" name="cityId" textField="name"  valueField="code"/>
        
            <a class="nui-button" onclick="search()" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
            <span style="display:inline-block;">
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(5)"><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="stoporstart()"><i class="fa fa-exchange"></i>&nbsp;启用/禁用</a>
                <span class="separator"></span>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(1)"><i class="fa fa-cubes"></i>&nbsp;查看产品</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(2)"><i class="fa fa-list"></i>&nbsp;查看订单</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(3)"><i class="fa fa-cny"></i>&nbsp;查看费用</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(4)"><i class="fa fa-map"></i>&nbsp;查看发票</a>
            </span>
        </div> 
	</div>
        <div class="nui-fit">
            <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
            bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true" dataField="rs" 
            sizeList="[20,30,50,100]" pageSize="20" frozenStartColumn="0" frozenEndColumn="3">
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	
            	 <div field="tenantId" width="80" headerAlign="center" align="center" visible="false">租户ID</div>
                <div field="code" width="80" headerAlign="center" align="center">租户ID</div>
                <div field="tenantName" width="80" headerAlign="center" align="center">租户名称</div>
                <div field="provinceId" width="80" headerAlign="center" align="center">省份</div>
                <div field="cityId" width="80" headerAlign="center" align="center">城市</div>
                <div field="manager" width="80" headerAlign="center" align="center">管理员</div>
                <div field="mobile" width="80" headerAlign="center" align="center">联系电话</div>
                <div field="address" width="80" headerAlign="center" align="center">联系地址</div>
                <div field="recordDate" width="80" headerAlign="center" align="center"dateFormat="yyyy-MM-dd HH:mm" >注册时间</div>
                <div field="auditDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm" >审核时间</div>
                <div field="startDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm" >开通时间</div>
                <div field="endDate" width="80" headerAlign="center" align="center"dateFormat="yyyy-MM-dd HH:mm" >结束时间</div>
                <div field="auditMan" width="80" headerAlign="center" align="center">审核人</div>
                <div field="salesManId" width="80" headerAlign="center" align="center">业务员</div>
                <div field="referee" width="80" headerAlign="center" align="center">推荐人</div>
                <div field="InvitationNumber" width="80" headerAlign="center" align="center">邀请号</div>
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