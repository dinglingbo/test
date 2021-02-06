<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
--> 
<head>  
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;  
        overflow: hidden;
        font-family: "微软雅黑";
    }
    .textboxWidth{
        width: 100%;
    }
    .tbText{
        text-align: right;
    }
</style> 
</head>
<body>
   
    <div class="nui-fit" id="form1">
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick=""><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                   </td>
               </tr>
           </table>
       </div>
       <table >
       <tr>
           <td style="text-align: right; width:61px;">
               编号：&nbsp;
           </td>
           <td>
               <input id="TemplateId_input" value="自动编号" style="width: 150px" disabled class="nui-textbox" />
           </td>
           <td style="text-align: right ;width:60px;">
               拼音码：&nbsp;
           </td>
           <td>
               <input id="TemplateCode_input" editable="false" style="width: 140px" class="nui-textbox" />
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               名称：&nbsp;
           </td>
           <td colspan="3">
               <input id="TemplateName_input" style="width: 360px" class="nui-textbox" />
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               车型：&nbsp;
           </td>
           <td colspan="3">
               <input id="CarType_combobox" class="nui-combobox" showheader="false" style="width: 250px;">
               </input>
               <input id="DefaultFlg_input" type="checkbox" />&nbsp;车型默认模板
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               备注：&nbsp;
           </td>
           <td colspan="3">
               <input id="Remark_input" class="nui-textarea" multiline="true" type="text" style="width: 360px;height:40px"
                    />
           </td>
       </tr>
   </table>
   <div class="nui-toolbar" style="padding:0px;">
        <table style="width:80%;">
            <tr>
                <td style="width:80%;">
                        <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
                            class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
                            class="fa fa-close fa-lg"></span>&nbsp;删除</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
            <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
              pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
              onselectionchanged="" allowSortColumn="false" totalField="page.count">
              <div property="columns">
                <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                <div field="" headerAlign="center" allowSort="true" width="150px">项目编号</div>
                <div field="" headerAlign="center" allowSort="true" width="150px">项目名称</div>
                <div field="" headerAlign="center" allowSort="true" width="150px">拼音码</div>
                <div field="" headerAlign="center" allowSort="true" width="150px">项目类型</div>
              </div>
            </div>
          </div>
</div>
<script type="text/javascript">
    nui.parse();
   
    function edit(e) {
      var tit = null;
      if (e == 1) {
        tit = '新增';
      } else {
        tit = '修改';
      }
      nui.open({
        url: webPath + contextPath + '/page/car/PDI_checkWindow.jsp',
        title: tit,
        width: 740,
        height: 350,
        onload: function () {
          var iframe = this.getIFrameEl();
          iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
          visitHis.reload();
        }
      });
    }



function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}

</script>
</body>
</html>