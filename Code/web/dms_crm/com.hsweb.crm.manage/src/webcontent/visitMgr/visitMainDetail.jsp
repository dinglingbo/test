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
    <title>工单回访</title>
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
        /* float: right; */
    }
</style> 
</head>
<body>
   
    <div class="nui-fit" id="form1">
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>

                   </td>
               </tr>
           </table>
       </div>
       <input class="nui-hidden" name="visitId" id="visitId"/>
       <input class="nui-hidden" name="carId" id="carId"/>
       <input class="nui-hidden" name="carNo" id="carNo"/>
       <input class="nui-hidden" name="guestId" id="guestId"/>
       <table class="tmargin" style="table-layout: fixed;width:100%">
        <tr class="htr">
            <td  style="width: 70px;" class="tbText">回访方式：</td>
            <td style="width: 100px;">
                <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name" value='011401' enabled="false">
            </td>
            <td style="width: 90px;" class="tbText">下次保养日期：</td>
            <td style="width: 135px;">
                <input id="careDueDate" name="careDueDate" class=" nui-datepicker textboxWidth" >
            </td>
            <td style="width: 70px;" class="tbText">保养周期：</td>
            <td style="width: 100px;">
                <input id="careDayCycle" name="careDayCycle" class="nui-spinner textboxWidth" minValue="0">
            </td>
            <td style=""></td>
        </tr> 
        <tr class="htr">
            <td class="tbText">回访内容：</td>
            <td  colspan="6">
                <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:150px;">
            </td>
        </tr> 
        <tr class="htr">
            <td class="tbText">回访员：</td>
            <td >
                <input id="visitMan" name="visitMan" class="nui-combobox textboxWidth" allowInput="true" textField="empName" valueField="empName" emptyText="请选择..."nullItemText="请选择..." onvaluechanged="visitManChanged">
            </td>
            <td class="tbText">回访时间：</td>
            <td >
                <input id="visitDate" name="visitDate" class="nui-datepicker textboxWidth">
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var visitModeCtrlUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
    var tabForm = null;
    var mainData = null;
	var form = {};
    tabForm = new nui.Form("#form1");
    var visitIdEl = nui.get("visitId");
    var visitMode_ctrl = nui.get("visitMode");
    visitMode_ctrl.setUrl(visitModeCtrlUrl);

    initMember("visitMan",function(){
    }); 

    function visitManChanged(e){
        var sel = e.selected;
        visitIdEl.setValue(sel.empId);

    }


    function setData(rowData){
        mainData = rowData;
    }

    function save(){
        var data = tabForm.getData();
        var record = {
            visitMode:data.visitMode,
            visitId:data.visitId,
            visitMan:data.visitMan,
            visitDate:data.visitDate,
            visitContent:data.visitContent,
            careDueDate:data.careDueDate,
            careDayCycle:data.careDayCycle,
            carId:mainData.carId,
            carNo:mainData.carNo,
            guestId:mainData.guestId,
            serviceId:mainData.serviceId,
            serviceType:'3',
            mainId:mainData.id
        };
        nui.ajax({
            url:baseUrl + "com.hsapi.crm.svr.visit.savevisitDetail.biz.ext",
            type:"post",
            data:{
                params:record
            },
            success:function(text){
                if(text.errCode == "S"){
                    var detailData = text.detailData;
                    showMsg("保存成功！","S");
                    CloseWindow("ok");
                }

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