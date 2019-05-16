<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2019-05-15 10:00:56
  - Description:
-->
<head>
<title>menuSetting</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/page/data.js?v=1.0.0" type="text/javascript"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:0px;">
            <input id="key" class="nui-textbox" style="width:150px;" onenter="onKeyEnter"/>
            <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
                class="fa fa-search fa-lg"></span>&nbsp;查找</a>
                <span class="separator"></span>
        <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
            class="fa fa-plus fa-lg"></span>&nbsp;新增同级节点</a>
            <a class="nui-button" plain="true" onclick="edit(2)" id="" plain="false"><span
                class="fa fa-plus fa-lg"></span>&nbsp;新增子级节点</a>
            <a class="nui-button" plain="true" onclick="" id="" plain="false"><span
                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <!-- <span class="separator"></span>
                <label >注：长按序号可进行拖动</label> -->
    </div>
    <!-- allowDrag="true" allowDrop="true"  -->
    <div id="treegrid1" class="nui-treegrid" style="width:100%;height:580px;"     
        showTreeIcon="true"  
        treeColumn="taskname" resultAsTree="false"  
        allowResize="true" expandOnLoad="true"multiSelect="false" 
        allowCellEdit="true"   frozenStartColumn="0" frozenEndColumn="1" 
    >
    <div property="columns">
            <!-- <div type="checkboxcolumn" field="Critical" trueValue="1" falseValue="0" width="60">         
                </div>    -->
        <div type="indexcolumn" width="50"> 序号</div>
        <div field="Name" name="taskname"  width="460" >栏目名称
            <!-- <input property="editor" class="nui-textbox" style="width:100%;" /> -->
        </div>
        <div field="" name=""  width="460" >栏目介绍
                <!-- <input property="editor" class="nui-textbox" style="width:100%;" /> -->
            </div>
        <div field="" width="80">排序
            <!-- <input property="editor" class="nui-spinner"  minValue="0" maxValue="100" value="0" style="width:100%;"/> -->
        </div>
        <div field="" width="80">状态
                <!-- <input property="editor" class="nui-combobox" style="width:100%;" data="[{id:'0',text:'启用'},{id:'1',text:'禁用'}]"
                valueField="id" textField="text"/> -->
            </div>
        <!-- <div field="action" width="80">操作
        </div> -->
    </div>
</div>

	<script type="text/javascript">
        nui.parse();
        var treegrid = nui.get("treegrid1");
        //treegrid.setData(treeData);
        treegrid.loadList(treeData, "UID", "ParentTaskUID");
        // treegrid.on("drawcell",function(e){
        //     var field = e.field;
        //     if(field == 'action'){
        //         e.cellHtml = 1
        //     }
        // });

        function edit(e) {
                var tit = null;
                if (e == 1) {
                    tit = '新增';
                } else {
                    tit = '修改';
                }
                nui.open({
                    url: webPath + contextPath + '/page/menusetting_det.jsp',
                    title: tit,
                    width: 400,
                    height: 250,
                    onload: function() {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData(row);
                    },
                    ondestroy: function(action) {
                        visitHis.reload();
                    }
                });
            }
    </script>
</body>
</html>