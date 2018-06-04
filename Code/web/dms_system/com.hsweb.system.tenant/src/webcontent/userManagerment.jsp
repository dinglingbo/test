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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
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

            租户ID：<input  class="mini-textbox" emptytext="输入租户ID"  width="125px" style="margin-right:10px;" />
            租户名称：<input  class="mini-textbox" emptytext="输入租户名称"  width="125px" style="margin-right:10px;" />
            省份：<input  class="mini-combobox" emptytext="选择省份"  width="125px" style="margin-right:10px;" />
            城市：<input  class="mini-combobox" emptytext="选择城市"  width="125px" style="margin-right:10px;" />
            <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
            <span style="display:inline-block;">
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(5)"><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick=""><i class="fa fa-exchange"></i>&nbsp;启用/禁用</a>
                <span class="separator"></span>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(1)"><i class="fa fa-cubes"></i>&nbsp;查看产品</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(2)"><i class="fa fa-list"></i>&nbsp;查看订单</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(3)"><i class="fa fa-cny"></i>&nbsp;查看费用</a>
                <a class="nui-button " style="" iconcls="" plain="false" onclick="ViewType(4)"><i class="fa fa-map"></i>&nbsp;查看发票</a>
            </span>
        </div> 

        <div class="nui-fit">
            <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
            bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true"
            sizeList="[20,30,50,100]" pageSize="20" frozenStartColumn="0" frozenEndColumn="3">
            <div property="columns">
                <div field="" width="80" headerAlign="center" align="center">租户ID</div>
                <div field="" width="80" headerAlign="center" align="center">租户名称</div>
                <div field="" width="80" headerAlign="center" align="center">省份</div>
                <div field="" width="80" headerAlign="center" align="center">城市</div>
                <div field="" width="80" headerAlign="center" align="center">管理员</div>
                <div field="" width="80" headerAlign="center" align="center">联系电话</div>
                <div field="" width="80" headerAlign="center" align="center">联系地址</div>
                <div field="" width="80" headerAlign="center" align="center">注册时间</div>
                <div field="" width="80" headerAlign="center" align="center">审核时间</div>
                <div field="" width="80" headerAlign="center" align="center">开通时间</div>
                <div field="" width="80" headerAlign="center" align="center">结束时间</div>
                <div field="" width="80" headerAlign="center" align="center">审核人</div>
                <div field="" width="80" headerAlign="center" align="center">业务员</div>
                <div field="" width="80" headerAlign="center" align="center">推荐人</div>
                <div field="" width="80" headerAlign="center" align="center">邀请号</div>
                <div field="" width="80" headerAlign="center" align="center">下次续费时间</div>
                <div field="" width="80" headerAlign="center" align="center">下次续费金额</div>
            </div>
        </div>
    </div>

<script type="text/javascript">
  nui.parse();


  function ViewType(e){
    var tit = null;
    var view_w = 800;
    var view_d = 400;
    if(e == 1){
        tit="查看产品";
    }
    if(e == 2){
        tit="查看订单";
        view_w = 1000;
    }
    if(e == 3){
        tit="查看费用";
    }
    if(e == 4){
        tit="查看发票";
    }
    if(e == 5){
        tit="修改产品";
        var view_w = 580;
        var view_d = 280;
    }
    nui.open({
        url: "userMgr.flow?_eosFlowAction=action2",
        title: tit, 
        width: view_w, 
        height: view_d,
        onload: function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.ShowGrid(e);
        },
        ondestroy: function (action) {
        }
    });


}



</script>
</body>
</html>