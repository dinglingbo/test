<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

<head>
    <title>PDI检测模板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar">
        模板编号： <input id="code" name="code" class="nui-textbox" type="text" style="width: 110px" />
        模板名称： <input id="name" name="name"class="nui-textbox" type="text" style="width: 110px" />
        <!-- 拼音码： <input id="txtItemCode" class="nui-textbox" type="text" style="width: 110px" /> -->
        车型名称：<input id="carModelName"name="carModelName" class="nui-textbox" type="text" style="width: 110px" />
        <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                class="fa fa-search fa-lg"></span>&nbsp;查找</a>
        <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
                class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
        <a class="nui-button" plain="true" onclick="edit(2)" id="" enabled="true"><span
                class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
        <!-- <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
                class="fa fa-close fa-lg"></span>&nbsp;删除</a> -->
    </div>

    <div class="nui-fit">
        <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
            pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
            onselectionchanged="" allowSortColumn="false" totalField="page.count" fitColumns="true">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                <!-- <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div> -->
                <div field="name" headerAlign="center" allowSort="true" width="150px">模板名称</div>
                <div field="carModelName" headerAlign="center" allowSort="true" width="150px">车型名称</div>
                <div field="isDefault" headerAlign="center" allowSort="true" width="150px">是否车型默认模板</div>
                <div field="remark" headerAlign="center" allowSort="true" width="300px">备注</div>
                <div field="code" headerAlign="center" allowSort="true" width="150px">模板编号</div>
                <div field="pyCode" headerAlign="center" allowSort="true" width="150px">拼音码</div>
                <div field="isDisabled" headerAlign="center" allowSort="true" width="100px">状态</div>
            </div>
        </div>
    </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var checkList = [{id:0,name:"否"},{id:1,name:"是"}];
        var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
        var gridUrl = apiPath + saleApi + "/sales.base.searchCsbPDICarTemplate.biz.ext";
        var grid = nui.get("grid1");
        grid.setUrl(gridUrl);
        grid.load();

        grid.on("drawcell",function(e){
            switch (e.field) {
                case "isDisabled":
                    e.cellHtml = (e.value == 0?'启用':'禁用');
                    break;
                case "isDefault":
                        e.cellHtml = (e.value == 0?'否':'是');
                    break;
                default:
                    break;
            }
        });


        function edit(e) {
            var tit = null;
            var row = null;
            if (e == 1) {
                tit = '新增';
            } else {
                tit = '修改';
                row = grid.getSelected();
                if(!row){
                    showMsg('请先选中要修改的数据','W');
                    return;
                }
            }
            nui.open({
                url: webPath + contextPath + '/sales/base/PDI_checkModel_det.jsp',
                title: tit,
                width: 640, 
                height: 450,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    iframe.contentWindow.setData(row,e);
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        }

        function search() {
            var params = {
                name: nui.get('name').value,
                code: nui.get('code').value,
                carModelName: nui.get('carModelName').value
            };
            grid.load({ params: params, token: token });
        }
    </script>
</body>

</html>