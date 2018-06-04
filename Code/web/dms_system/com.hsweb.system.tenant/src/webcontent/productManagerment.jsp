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

产品名称：<input class="mini-textbox" emptytext="输入产品名称"  width="125px" style="margin-right:10px;" />
产品状态：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" data="productStatus" idFeild="id" textFeild="text"/>
产品分类：<input class="mini-combobox" emptytext="请选择..."  width="125px" style="margin-right:10px;" />
<a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
<span class="separator"></span>
<span style="display:inline-block;">
    <a class="nui-button" plain="false" onclick="ViewType(1)"><i class="fa fa-plus"></i>&nbsp;新增</a>
    <a class="nui-button" plain="false" onclick="ViewType(2)"><i class="fa fa-pencil"></i>&nbsp;修改</a>
    <a class="nui-button" plain="false" onclick=""><i class="fa fa-trash-o"></i>&nbsp;删除</a>
    <span class="separator"></span>
    <a class="nui-button " style="" iconcls="" plain="false" onclick=""><i class="fa fa-long-arrow-up"></i>&nbsp;上架</a>
    <a class="nui-button " style="" iconcls="" plain="false" onclick=""><i class="fa fa-long-arrow-down"></i>&nbsp;下架</a>
</span>
</div> 

<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
    bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true"
    sizeList="[20,30,50,100]" pageSize="20" >
    <div property="columns">
        <div field="" width="80" headerAlign="center" align="center">产品ID</div>
        <div field="" width="80" headerAlign="center" align="center">产品类型</div>
        <div field="" width="80" headerAlign="center" align="center">产品名称</div>
        <div field="" width="80" headerAlign="center" align="center">产品描述</div>
        <div field="" width="90" headerAlign="center" align="center">是否限定周期</div>
        <div field="" width="90" headerAlign="center" align="center">产品限定周期</div>
        <div field="" width="95" headerAlign="center" align="center">周期内消费次数</div>
        <div field="" width="80" headerAlign="center" align="center">排序号</div>
        <div field="" width="80" headerAlign="center" align="center">产品状态</div>
        <div field="" width="80" headerAlign="center" align="center">是否推荐</div>
        <div field="" width="80" headerAlign="center" align="center">原价</div>
        <div field="" width="80" headerAlign="center" align="center">活动价</div>
        <div field="" width="80" headerAlign="center" align="center">建档时间</div>
        <div field="" width="80" headerAlign="center" align="center">建档人</div>
        <div field="" width="80" headerAlign="center" align="center">修改时间</div>
        <div field="" width="80" headerAlign="center" align="center">修改人</div>
    </div>
</div>
</div>
<script type="text/javascript">
    var productStatus = [{id:"",text:"全部"},{id:"1",text:"上架"},{id:"2",text:"下架"}];
    nui.parse();


  function ViewType(e){
    var tit = null;
    if(e == 1){
        tit="新增产品";
    }
    if(e == 2){
        tit="修改产品";

    }

    nui.open({
        url: "productMgr.flow?_eosFlowAction=action2",
        title: tit, 
        width: 630,  
        height: 250,
        onload: function(){
            var iframe = this.getIFrameEl();
            //iframe.contentWindow.ShowGrid(e);
        },
        ondestroy: function (action) {
        }
    });


}



</script>
</body>
</html>