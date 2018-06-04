<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>运营管理</title>
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
    <div id="tabs" name="tabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;padding:0px;" bodyStyle="padding:0;border:0;">
        <div title="产品销售排行" name="tab1"  >
           <div class="nui-fit">
            <div class="nui-toolbar">

                业务员：<input  class="nui-textbox" emptytext="输入业务员"  width="125px" style="margin-right:10px;" />
                省份：<input  class="mini-combobox" emptytext="选择省份"  width="125px" style="margin-right:10px;" />
                城市：<input  class="mini-combobox" emptytext="选择城市"  width="125px" style="margin-right:10px;" />
                <span style="display:inline-block;">
                    订单日期 从：<input id="date1" class="nui-datepicker" />至
                    <input id="date2" class="nui-datepicker" />
                </span>
                <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
            </div>

            <div class="nui-fit">
                <div id="grid1" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
                bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true"
                sizeList="[20,30,50,100]" pageSize="20" >
                <div property="columns">
                    <div field="" width="80" headerAlign="center" align="center">产品类型</div>
                    <div field="" width="80" headerAlign="center" align="center">产品名称</div>
                    <div field="" width="80" headerAlign="center" align="center">产品描述</div>
                    <div field="" width="80" headerAlign="center" align="center">销售次数</div>
                    <div field="" width="80" headerAlign="center" align="center">销售金额</div>
                </div>
            </div>
        </div>

    </div>
</div>

<div title="租户消费排行" name="tab2"  >
    <div class="nui-fit">

        <div class="nui-toolbar">

            业务员：<input  class="nui-textbox" emptytext="输入业务员"  width="125px" style="margin-right:10px;" />
            省份：<input  class="mini-combobox" emptytext="选择省份"  width="125px" style="margin-right:10px;" />
            城市：<input  class="mini-combobox" emptytext="选择城市"  width="125px" style="margin-right:10px;" />
            <span style="display:inline-block;">
                订单日期 从：<input id="date1" class="nui-datepicker" />至
                <input id="date2" class="nui-datepicker" />
            </span>
            <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
        </div>

        <div class="nui-fit">
            <div id="grid2" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
            bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true"
            sizeList="[20,30,50,100]" pageSize="20" >
            <div property="columns">
                <div field="" width="80" headerAlign="center" align="center">省份</div>
                <div field="" width="80" headerAlign="center" align="center">城市</div>
                <div field="" width="80" headerAlign="center" align="center">租户ID</div>
                <div field="" width="80" headerAlign="center" align="center">租户名称</div>
                <div field="" width="80" headerAlign="center" align="center">联系电话</div>
                <div field="" width="80" headerAlign="center" align="center">成交订单数量</div>
                <div field="" width="80" headerAlign="center" align="center">成交金额</div>
            </div>
        </div>
    </div>



</div>
</div>

<div title="业务员管理" name="tab3"  >
    <div class="nui-fit">

        <div class="nui-toolbar">
            业务员：<input  class="nui-textbox" emptytext="输入业务员"  width="125px" style="margin-right:10px;" />
            省份：<input  class="mini-combobox" emptytext="选择省份"  width="125px" style="margin-right:10px;" />
            城市：<input  class="mini-combobox" emptytext="选择城市"  width="125px" style="margin-right:10px;" />
            <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
            <span class="separator"></span>
            <a class="nui-button" plain="false" onclick="grid3_addRow()"><i class="fa fa-plus"></i>&nbsp;新增</a>
            <a class="nui-button" plain="false" onclick="grid3_editRow()"><i class="fa fa-pencil"></i>&nbsp;修改</a>
            <a class="nui-button" plain="false" onclick="deleteData()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
            <span class="separator"></span>
            <a class="nui-button" plain="false" onclick=""><i class="fa fa-calculator"></i>&nbsp;自动计算业绩</a>
        </div>

        <div class="nui-fit">
            <div id="grid3" class="nui-datagrid gridborder" style="width: 100%; height:100%;"
            bodyStyle="padding:0;border:0;" url="" idField="id" allowResize="true"
            sizeList="[20,30,50,100]" pageSize="20" >
            <div property="columns">
                <div field="" width="80" headerAlign="center" align="center">省份</div>
                <div field="" width="80" headerAlign="center" align="center">城市</div>
                <div field="" width="80" headerAlign="center" align="center">姓名</div>
                <div field="" width="80" headerAlign="center" align="center">年龄</div>
                <div field="" width="80" headerAlign="center" align="center">联系电话</div>
                <div field="" width="80" headerAlign="center" align="center">租户数量</div>
                <div field="" width="80" headerAlign="center" align="center">贡献金额</div>
            </div>
        </div>
    </div>


</div>
</div>

<div title="API接口调用监控" name="tab4"  >
    <div class="nui-fit">


    </div>
</div>
</div>
 

<div id="form1" class="nui-window" title="窗体" style="width:500px;height:230px;"  allowDrag="true" >
    <input name="id" class="nui-hidden" />
    <table style="margin-top:10px;">
                <tr>
            <td style="width: 90px;text-align:right">姓名：</td>
            <td colspan="3"><input class="nui-textbox" 
                style="width: 100%"  /></td>
            </tr>

        <tr>
            <td style="width: 90px;text-align:right">性别：</td>
            <td colspan="3"><input class="nui-combobox" idField="id" textFeild="text" data="sex"
                style="width: 100%"  /></td>
            </tr>
                    <tr>
            <td style="width: 90px;text-align:right">年龄：</td>
            <td colspan="3"><input class="nui-textbox" 
                style="width: 100%"  /></td>
            </tr>

        <tr>
            <td style="width: 90px;text-align:right">电话：</td>
            <td colspan="3"><input class="nui-textbox" 
                style="width: 100%"  /></td>
            </tr>


        <tr>
            <td  style="width: 90px; text-align: right">省份：</td>
            <td><input class="nui-combobox"  /></td>
            <td style="width: 90px; text-align: right">城市：</td>
            <td><input class="nui-combobox"   /></td>

        </tr>


        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
<script type="text/javascript">
    var payStatus = [{id:0,text:"全部"},{id:1,text:"已付款"},{id:2,text:"未付款"}];
    var isDue = [{id:0,text:"全部"},{id:1,text:"即将到期"}];
    var sex = [{id:0,text:"男"},{id:1,text:"女"}];
    nui.parse();

        var grid1 = nui.get("grid1");
        var grid2 = nui.get("grid2");
        var grid3 = nui.get("grid3");

        var form1 = nui.get("form1");
function grid3_addRow() {//列表表格 -弹出 新增角色
    form1.setTitle("新增业务员");
    form1.showAtPos("center", "middle");
}

function grid3_editRow() {//列表表格 -弹出编辑--修改角色信息
    var row = grid1.getSelected();
    if (row) {
        form1.setTitle("编辑业务员");
        form1.showAtPos("center", "middle");
    } else {
        nui.alert("请选中一条记录");
    }

}

function deleteData(e) {//删除某条角色数据
    var row = grid3.getSelected();
    if (row) {
        nui.confirm("确定删除此记录？", "友情提示", function(action) {
            if (action == "ok") {
                try {//删除
                    grid1.removeRow(row,true);
                } finally {}

            }
        });
    } else {
        nui.alert("请选择一条记录！");
    }
}

function onCancel(e) {
    form1.hide();
        //需要手动清控表单
    }

</script>
</body>
</html>