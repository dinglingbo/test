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
            <input id="id" name="id" class="nui-textbox" visible="false"/>
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                   </td>
               </tr>
           </table>
       </div>
       <table style="width:100%">
       <tr>
           <td style="text-align: right; width:61px;">
               编号：&nbsp;
           </td>
           <td>
               <input id="code" name="code"  style="width: 150px" enabled="false" class="nui-textbox" />
           </td>
           <td style="text-align: right ;width:60px;">
               拼音码：&nbsp;
           </td>
           <td>
               <input id="pyCode" name="pyCode" style="width: 140px" class="nui-textbox" enabled="false"/>
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               名称：&nbsp;
           </td>
           <td colspan="3">
               <input id="name" name="name"  style="width: 464px" class="nui-textbox" />
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               车型：&nbsp;
           </td>
           <td colspan="3">
               <input id="carModelId" name="carModelId" class="nui-textbox" required="true"  visible="false"  style="width: 352px;"/>
               <input id="carModelName" name="carModelName" class="nui-buttonedit" allowInput="false" required="true" style="width: 352px;" onbuttonclick="onButtonEdit"/>
               <div id="isDefault" name="isDefault" class="nui-checkbox"  text="车型默认模板" trueValue="1" falseValue="0"></div>
           </td>
       </tr>
       <tr>
           <td style="text-align: right; width:61px;">
               备注：&nbsp;
           </td>
           <td colspan="3">
               <input id="remark" name="remark" class="nui-textarea" style="width: 352px;height:40px" />
               <div id="isDisabled" name="isDisabled" class="nui-checkbox" text="禁用" trueValue="1" falseValue="0"></div>
           </td>        
       </tr>
   </table>
   <div class="nui-toolbar" style="padding:0px;">
        <table style="width:80%;">
            <tr>
                <td style="width:80%;">
                        <a class="nui-button" plain="true" onclick="edit()" id="" plain="false"><span
                            class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" onclick="delRow()" id="" enabled="true"><span
                            class="fa fa-close fa-lg"></span>&nbsp;删除</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
            <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true"
              pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"  onDrawCell=""
              onselectionchanged="" allowSortColumn="false" totalField="page.count">
              <div property="columns">
                    <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div>
                    <div field="orderNo" headerAlign="center" width="60px">序号</div>
                    <div field="name" headerAlign="center" allowSort="true" width="150px">项目名称</div>
                    <div field="pdiTypeId" headerAlign="center" allowSort="true" width="150px">项目类型</div>
                    <div field="code" headerAlign="center" allowSort="true" width="150px">项目编号</div>
                <!-- <div field="" headerAlign="center" allowSort="true" width="150px">拼音码</div> -->
              </div>
            </div>
          </div>
</div>
<script type="text/javascript">
    nui.parse();
    var saveUrl = apiPath + saleApi + "/sales.base.saveCsbCarTemplate.biz.ext";
    var gridUrl = apiPath + saleApi + "/sales.base.searchCsbPDICarDetail.biz.ext";
    var form = new nui.Form("form1");
    var grid =nui.get("grid1");
    grid.setUrl(gridUrl);


function setData(row,e) {
    if(e == 1){
        nui.get("isDisabled").setValue(0);
    }else{
        form.setData(row);
        nui.get("carModelName").setText(row.carModelName);
        var params = {
            templateId:row.id 
        };
        grid.load({params:params,token:token});
    }
}

    function edit() {
      var tit = null;
      nui.open({
        url: webPath + contextPath + '/sales/base/PDI_checkWindow.jsp',
        title: '选择项目',
        width: 740,
        height: 350,
        onload: function () {
          var iframe = this.getIFrameEl();
          //iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            var iframe = this.getIFrameEl();
            if(action == 'ok'){
                var rows = iframe.contentWindow.getRows();
                var dataList = grid.getData();
                for (var k = 0; k < rows.length; k++) {
                    var temp = rows[k];
                    var value = JSON.stringify(dataList).indexOf('"code":"'+temp.code+'"');
                    if(value == -1){
                        grid.addRow(temp);
                    }
                    // for (let i = 0; i < dataList.length; i++) {
                    //     var element = dataList[i];
                        
                    // }
                    
                }
            }
        }
      });
    }

    function onButtonEdit(e) {
        nui.open({
        url: webPath + contextPath + '/sales/base/selectCarModel.jsp',
        title: '选择车型',
        width: 1000,
        height: 500,
        onload: function () {
          var iframe = this.getIFrameEl();
          //iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            var iframe = this.getIFrameEl();
          if(action == 'ok'){
            var row = iframe.contentWindow.getRow();
            nui.get("carModelId").setValue(row.id);
            nui.get("carModelName").setValue(row.fullName);
            nui.get("carModelName").setText(row.fullName);
          }
        }
      });
    }


    function save() {
        var addArr = grid.getChanges('added');
        var delArr = grid.getChanges('removed');
        var data = form.getData(true);
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '保存中...'
        });
        nui.ajax({
            url:saveUrl,
            type:'post',
            data:{
                data:data,
                addArr:addArr,
                delArr:delArr
            },
            success:function(res){
                nui.unmask(document.body);
                if(res.errCode == 'S'){
                    showMsg('保存成功','S');
                    //grid.reload();
                    CloseWindow("ok");
                }else{
                    showMsg('保存失败','E');
                }
            }
        });
    }

    function delRow() {
        var rows = grid.getSelecteds();
        grid.removeRows(rows);
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