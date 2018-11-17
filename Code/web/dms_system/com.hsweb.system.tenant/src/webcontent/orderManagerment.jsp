<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head> 
    <title>订单管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/tenant/js/orderManager.js?v=1.7"
	type="text/javascript"></script>
	    <script src="<%= request.getContextPath() %>/common/js/date.js?v=1.9"
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

            <div class="nui-toolbar" >
            <div class="nui-form" id="queryForm">
                <span style="display:inline-block;">
                    订单单号：<input  class="nui-textbox" emptytext="输入订单单号"  width="125px" style="margin-right:10px;" id="id" name="name"/>
                </span>
                <span style="display:inline-block;">
                    租户ID：<input  class="nui-textbox" emptytext="输入租户ID"  width="125px" style="margin-right:10px;" id="tenantId" name="tenantId"/>
                </span>
                <span style="display:inline-block;">
                    租户名称：<input  class="nui-textbox" emptytext="输入租户名称"  width="125px" style="margin-right:10px;" id="tenantName" name="tenantName" />
                </span>
                <span style="display:inline-block;">
                    联系电话：<input  class="nui-textbox" emptytext="输入电话"  width="125px" style="margin-right:10px;" id="mobile" name="mobile"/>
                </span>
                <span style="display:inline-block;">
                    付款状态：<input  class="nui-combobox" emptytext="请选择..." idField="id" textFeild="text" data="payStatus"   width="125px" style="margin-right:10px;" id="status" name="status" />
                </span>
                <span style="display:inline-block;">
                    订单日期 从：<input id="startDate" name="startDate" class="nui-datepicker" />至
                    <input id="endDate" name="endDate" class="nui-datepicker" />
                </span>
                <span style="display:inline-block;">
                    <a class="nui-button" onclick="search" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
                    <span class="separator"></span>
                    <a class="nui-button " style="" iconcls="" plain="false" onclick="exprie"><i class="fa fa-clock-o"></i>&nbsp;即将到期(30天内）</a>
                    <a class="nui-button " style="" iconcls="" plain="false" onclick="wfk"><i class="fa fa-window-maximize"></i>&nbsp;未付款</a>
                    <span class="separator"></span>
                    <a class="nui-button " style="" iconcls="" plain="false" onclick="closeOrder"><i class="fa fa-times"></i>&nbsp;关闭未付款订单</a>
                </span>
            </div> 
	</div>
            <div class="nui-fit">
                <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
                bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true" dataField="data" 
                sizeList="[20,30,50,100]" pageSize="20" >
                <div property="columns">
                	<div type="checkcolumn" >选择</div>
                    <div field="tenantId" width="80" headerAlign="center" align="center">租户ID</div>
                    <div field="tenantName" width="80" headerAlign="center" align="center">租户名称</div>
                    <div field="mobile" width="80" headerAlign="center" align="center">联系电话</div>
                    <div field="id" width="80" headerAlign="center" align="center">订单单号</div>
                    <div field="recordDate" width="80" headerAlign="center" align="center">订单时间</div>
                    <div field="productId" width="80" headerAlign="center" align="center">产品ID</div>
                    <div field="name" width="80" headerAlign="center" align="center">产品名称</div>
                    <div field="type" width="80" headerAlign="center" align="center">产品类型</div>
                    <div field="startDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">开通时间</div>
                    <div field="endDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">结束时间</div>
                    <div field="isPayment" width="80" headerAlign="center" align="center">是否付款</div>
                    <div field="paymentDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">付款时间</div>
                    <div field="paymentType" width="80" headerAlign="center" align="center">付款方式</div>
                    <!-- <div field="" width="80" headerAlign="center" align="center">是否生效</div> -->
                    <div field="status" width="80" headerAlign="center" align="center">订单状态</div>
                </div>
            </div>
        </div>

<script type="text/javascript">
    var payStatus = [{id:0,text:"全部"},{id:1,text:"已付款"},{id:2,text:"未付款"}];
    var isDue = [{id:0,text:"全部"},{id:1,text:"即将到期(30天内)"}];
    nui.parse();


</script>
</body>
</html>