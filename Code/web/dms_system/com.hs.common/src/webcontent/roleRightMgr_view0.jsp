<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-05-30 08:57:57
  - Description:
-->
<head>
    <title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: Microsoft YaHei !important;
    }

    .mini-toolbar {
        border: 0px  solid #ccc !important;
        border-bottom: 1px solid #ccc !important;
        /* background: #fafafa; */
    }

    .mini-grid-headerCell, .mini-grid-topRightCell { 
        border-right: #c5c5c5 0px solid;
    }

    .mini-grid-headerCell {
     border-right: #A5ACB5 0px solid;
 }


 .mini-grid-cell, .mini-grid-headerCell, .mini-grid-filterCell, .mini-grid-summaryCell {
     border-right: #d2d2d2 0px solid;
 } 

 .mini-grid .mini-grid-rightCell {
    border-right-width: 0px; 
}

</style> 
</head>
<body> 


    <div class="nui-splitter" style="width: 100%; height: 100%;">
        <div size="270" showcollapsebutton="true">
            <div class="nui-toolbar"  >

                <input  class="mini-textbox" emptytext="输入员工姓名查询"  width="calc(100% - 80px)"/>
                <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
                <br>
                <a class="nui-button" plain="false" onclick="grid1_addRow()"><i class="fa fa-plus"></i>&nbsp;新增</a>
                <a class="nui-button" plain="false" onclick="grid1_editRow()"><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button" plain="false" onclick="deleteData()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>

            </div>
            <div id="grid1" class="nui-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;" allowcelledit="false" allowcellselect="true"  selectonload="true" showpager="false" showmodified="false"  >
                <div property="columns">
                    <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
                    <div field="post"  name="post" width="140" headeralign="left" ><strong>角色名称</strong></div>
                </div>
            </div> 

        </div>
        <div showcollapsebutton="true">
            <div id="tabs" name="tabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;padding:0px;" bodyStyle="padding:0;border:0;">
                <div title="功能" name="tab1"  >
                    <div class="nui-toolbar"  >
                        <a class="nui-button" style=" "  plain="false" onclick=""><i class="fa fa-save"></i>&nbsp;保存</a>

                    </div>
                    <div class="nui-fit">
                        <ul id="tree1" class="nui-tree" data="treedata"  showCheckBox="true"
                        style="width: 100%;height:100%;" showTreeIcon="true"
                        expandOnLoad="0" resultAsTree="false" parentField="pid" 
                        idField="id"  textField="text"  expandOnNodeClick="false">
                    </ul>

                </div>
            </div>

            <div title="员工" name="tab2"  >
                <div class="nui-toolbar"  >
                    <a class="nui-button" style=" "  plain="false" onclick=""><i class="fa fa-save"></i>&nbsp;保存</a>
                    <span style="display: inline-block;float:right;">
                        机构名称：<input  class="mini-textbox" emptytext="输入机构名称查询"  width="150px"/>
                        员工名称：<input  class="mini-textbox" emptytext="输入员工名称查询"  width="150px"/>
                        <a class="nui-button" onclick="" plain="false" enabled=""><i class="fa fa-search"></i>&nbsp;查询(<u>Q</u>)</a>
                    </span>
                </div>
                <div class="nui-fit">

                    <div id="grid2"  class="nui-datagrid"   style="width: 100%; height:100%; border-top:0px" borderstyle="border:0;"   allowcellselect="true"  showpager="false" showmodified="false">
                        <div property="columns">
                            <div type="indexcolumn" name="index" width="30px" headeralign="center" align="center">  <strong>序号</strong></div>
                            <div field="userCode" name="assessmentLat" width="100" headeralign="center" align="center">   <strong>员工编号</strong></div>
                            <div field="name" name="productLine" width="100" headeralign="center" align="center">    <strong>员工姓名</strong></div>    
                            <div field="department" name="productLine" width="100" headeralign="center" align="center">    <strong>所属机构</strong></div>    
                            <div field="jurisdiction" type="checkboxcolumn" trueValue="1" falseValue="0" width="60" headerAlign="center" align="center"><strong>授权</strong></div>    
                        </div>
                    </div>


                </div>
            </div>

        </div>
    </div>
</div>
<div id="form1" class="nui-window" title="窗体" style="width:500px;height:200px;"  allowDrag="true" >
    <input name="id" class="nui-hidden" />
    <table style="table-layout: fixed; border-collapse:separate;border-spacing:5px; ">
        <tr>
            <td  style="width: 90px; text-align: right">角色编码：</td>
            <td><input class="nui-textbox" id="postCode" name="postCode" /></td>
            <td>角色名称：</td>
            <td><input class="nui-textbox"  id="post" name="post" /></td>

        </tr>

        <tr>
            <td style="width: 90px;text-align:right">角色描述：</td>
            <td colspan="3"><input class="nui-textarea" id="postRemark" name="postRemark" 
                style="width: 324px;height:60px;"  /></td>
            </tr>
        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>

    <script type="text/javascript">
        var Post = [{post:"系统管理员"},{post:"SA"},{post:"SR"},{post:"维修技师"}];
        var grid2_data=[{userCode:"mem001",name:"张三",department:"车间",jurisdiction:1},
        {userCode:"mem002",name:"李永",department:"车间",jurisdiction:0},
        {userCode:"mem041",name:"郑成",department:"广州科韵路店",jurisdiction:0},
        {userCode:"mem045",name:"周捷",department:"广州科韵路店",jurisdiction:1}];
        nui.parse();

        var grid1 = nui.get("grid1");
        var grid2 = nui.get("grid2");
        grid1.setData(Post);
        grid2.setData(grid2_data);

        var form1 = nui.get("form1");
function grid1_addRow() {//列表表格 -弹出 新增角色
    form1.setTitle("新增角色");
    form1.showAtPos("center", "middle");
}

function grid1_editRow() {//列表表格 -弹出编辑--修改角色信息
    var row = grid1.getSelected();
    if (row) {
        form1.setTitle("编辑角色");
        form1.showAtPos("center", "middle");
    } else {
        nui.alert("请选中一条记录");
    }

}

function deleteData(e) {//删除某条角色数据
    var row = grid1.getSelected();
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
    var treedata = 
    [
    {"id": "应用基础框架","text": "应用基础框架","checked": true},
    {"id": "应用功能管理","text": "应用功能管理","pid":"应用基础框架"},
    {"id": "菜单管理","text": "菜单管理","pid":"应用基础框架"},
    {"id": "授权管理","text": "授权管理","pid":"应用基础框架"},
    {"id": "用户管理","text": "用户管理","pid":"应用基础框架"},
    {"id": "组织机构管理","text": "组织机构管理","pid":"应用基础框架"},
    {"id": "工作流程","text": "工作流程","pid":"应用基础框架"},
    {"id": "汽车配件","text": "汽车配件","pid":"应用基础框架"},
    {"id": "汽车维修","text": "汽车维修","pid":"应用基础框架"},
    {"id": "数据引擎","text": "数据引擎","pid":"应用基础框架"},
    {"id": "云汽配","text": "云汽配","pid":"应用基础框架"},
    {"id": "系统管理","text": "系统管理","pid":"应用基础框架"},
    {"id": "客户关系","text": "客户关系","pid":"应用基础框架"},
    {"id": "财务管理","text": "财务管理","pid":"应用基础框架"},
    {"id": "租赁管理","text": "租赁管理","pid":"应用基础框架"},
    {"id": "1","text": "1","pid":"应用功能管理"},
    {"id": "2","text": "2","pid":"菜单管理"},
    {"id": "3","text": "3","pid":"授权管理"},
    {"id": "4","text": "4","pid":"用户管理"},
    {"id": "5","text": "5","pid":"组织机构管理"},
    {"id": "6","text": "6","pid":"工作流程"},
    {"id": "7","text": "7","pid":"汽车配件"}, 
    {"id": "8","text": "8","pid":"汽车维修"},
    {"id": "9","text": "9","pid":"数据引擎"},
    {"id": "10","text": "10","pid":"云汽配"},
    {"id": "11","text": "11","pid":"系统管理"},
    {"id": "12","text": "12","pid":"客户关系"},
    {"id": "13","text": "13","pid":"财务管理"},
    {"id": "14","text": "14","pid":"租赁管理"},
    ];
    var tree1 = mini.get("tree1");
    tree1.loadList(treedata);
</script>
</body>
</html>