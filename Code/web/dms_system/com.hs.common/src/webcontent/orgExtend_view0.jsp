<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>门店管理</title>
     <%@include file="/common/sysCommon.jsp"%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
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
</style> 
</head>
<body>
    <div class="nui-fit"> 
        <div style="width:100%;height:100%;left:0;right:0;margin: 0 auto;">
            <div class="nui-toolbar">
                <input id="Text4" class="mini-textbox" emptytext="输入公司名称查询"  width="200"/>
                <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
                <a class="nui-button " style="float:right;" iconcls="" plain="false" onclick=""><i class="fa fa-ban"></i>&nbsp;禁用</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-plus"></i>&nbsp;新增</a>
            </div> 

            <div class="nui-fit">
                <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
                url="" idField="id" allowResize="true"
                sizeList="[20,30,50,100]" pageSize="20" >
                <div property="columns">
                    <div field="name" width="120" headerAlign="center" align="center">企业号</div>
                    <div field="sex" width="100" align="center" headerAlign="center" align="center">公司名称</div>
                    <div field="tel"  headerAlign="center"  width="100" align="right">电话</div>
                    <div field="entry_date" width="100" headerAlign="center" align="center">省份</div>
                    <div field="is_open_account" width="100"  headerAlign="center" align="center" >城市</div>
                    <div field="system_account" width="100"  headerAlign="center"  align="center" >地址</div>
                    <div field="system_account" width="100"  headerAlign="center"  align="center" dateFormat="yyyy-MM-dd" allowSort="true">开店日期</div>
                    <div field="system_account" width="100"  headerAlign="center"  align="center" >建档人</div>
                    <div field="system_account" width="100"  headerAlign="center"  align="center" dateFormat="yyyy-MM-dd" allowSort="true">建档日期</div>
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