<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/js/employeeQuery.js" type="text/javascript"></script>
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
        <div style="width:90%;height:100%;left:0;right:0;margin: 0 auto;">
            <div class="nui-toolbar">
                <input id="Text4" class="mini-textbox" emptytext="输入员工姓名/手机号码查询"  width="200"/>
                <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
                <a class="nui-button " style="float:right;" iconcls="" plain="false" onclick=""><i class="fa fa-exchange"></i>&nbsp;启用/禁用</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-exchange"></i>&nbsp;复职/离职</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-user-plus"></i>&nbsp;开通系统</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button " style="float:right;margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-plus"></i>&nbsp;新增</a>
            </div> 

            <div class="nui-fit">
                <div id="datagrid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
                url="" idField="id" allowResize="true"
                sizeList="[20,30,50,100]" pageSize="20" >
                <div property="columns">
                    <div field="name" width="120" headerAlign="center" >姓名</div>
                    <div field="sex" width="100" align="center" headerAlign="center">性别</div>
                    <div field="tel"  headerAlign="center" align="right" width="100" >手机号</div>
                    <div field="entry_date" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">入职日期</div>
                    <div field="is_open_account" width="100"  headerAlign="center" align="center" >是否开通系统</div>
                    <div field="system_account" width="100"  headerAlign="center"  align="center" >系统账号</div>
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