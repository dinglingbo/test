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
    <title>流失回访</title> 
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
</style> 
</head>
<body>

    <div class="nui-fit" id="form1">
           <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
               <table style="width:80%;">
                   <tr>
                       <td style="width:80%;">
                           <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                                  <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>

                       </td>
                   </tr>
               </table>
           </div>
           <table class="tmargin" style="width:100%">
            <tr class="htr">
                <td >回访方式：</td>
                <td >
                    <input id="mode" name="mode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
                </td>
                <td >现在维修厂：</td>
                <td >
                    <input id="nowMtComp" name="nowMtComp" class=" nui-textbox textboxWidth" >
                </td>
                <td></td>
                <td>
                </td>
                <td style="width: "></td>
            </tr>
            <tr class="htr">
                <td style="width: 100px;">是否继续跟进：</td>
                <td style="width: 135px;">
                    <input id="isContinueScout" name="isContinueScout" class="nui-combobox textboxWidth"valueField="id" textField="text" data="[{id:0,text:'是'},{id:1,text:'否'}]">
                </td>
                <td style="width: 100px;">下次跟进日期：</td>
                <td style="width: 135px;">
                    <input id="nextScoutDate" name="nextScoutDate" class=" nui-datepicker textboxWidth" >
                </td>
                <td style="width: 90px;">计划来厂日期：</td>
                <td style="width: 135px;">
                    <input id="predComeDate" name="predComeDate" class="nui-datepicker textboxWidth" minValue="0">
                </td>
                <td style="width: "></td>
            </tr> 
            <tr class="htr">
                <td  >不来厂主要原因：</td>
                <td >
                    <input id="mainReason" name="mainReason" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
                </td>
                <td >不来厂明细原因：</td>
                <td colspan="3">
                    <input id="subReason" name="subReason" class=" nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name" popupWidth="350px" style="width: 358px;">
                </td>
                <td style="width: "></td>
            </tr> 
            <tr class="htr">
                <td >回访内容：</td>
                <td  colspan="6">
                    <input id="content" name="content" class="nui-textarea textboxWidth" style="width: 100%;height:150px;">
                </td> 
            </tr>
            <tr class="htr">
                <td >回访员：</td>
                <td >
                    <input id="scoutMan" name="scoutMan" class="nui-combobox textboxWidth" allowInput="true" textField="empName" valueField="empName" emptyText="请选择..."nullItemText="请选择..." onvaluechanged="visitManChanged">
                </td>
                <td >回访时间：</td>
                <td >
                    <input id="scoutDate" name="scoutDate" class="nui-datepicker textboxWidth">
                </td>
            </tr>

        </table>
</div>
<script type="text/javascript">
    nui.parse();
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
    var visitModeCtrlUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
    var mainReasonUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000008&fromDb=true";
    var detailReasonUrl = baseUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130705000009&fromDb=true";
    visitMode_ctrl = nui.get("mode");
    visitMode_ctrl.setUrl(visitModeCtrlUrl);
    var visitManEl = nui.get("visitMan");
    var visitIdEl = nui.get("visitId");
    var mainReason_ctrl = nui.get("mainReason");
    mainReason_ctrl.setUrl(mainReasonUrl);
    var subReason_ctrl = nui.get("subReason");
    subReason_ctrl.setUrl(detailReasonUrl);
    var tabForm = new nui.Form("#form1");
    var form = {};
    var mainData = null;


    initMember("scoutMan",function(){
    }); 

function visitManChanged(e){
    var sel = e.selected;
    visitIdEl.setValue(sel.empId);

}
    function setData(rowData){
        mainData = rowData;
        var visitdetaildata = searchVisitDetail(rowData.guestId);
        if(visitdetaildata){
            form.mode = visitdetaildata.mode;
            form.scoutMan = visitdetaildata.scoutMan;
            form.scoutDate = visitdetaildata.scoutDate;
            form.content = visitdetaildata.content;
            form.nextScoutDate = visitdetaildata.nextScoutDate;
            form.predComeDate = visitdetaildata.predComeDate;
            form.mainReason = visitdetaildata.mainReason;
            form.subReason = visitdetaildata.subReason;
            form.isContinueScout = visitdetaildata.isContinueScout;
            form.nowMtComp = visitdetaildata.nowMtComp;

        }
        tabForm.setData(form);

    }



function searchVisitDetail(gid){
    var ret = null;
    var p ={
        id:"",
        guestId:gid,
        carId:""
    };
    nui.ajax({
        url:baseUrl + "com.hsapi.crm.svr.visit.QueryCrmVisitLoseDetail.biz.ext",
        type:"post",
        async: false,
        data:{
            params:p,
            token:token
        },
        success:function(text){
            if(text.errCode == "S"){
                var tdata = text.data;
                if(tdata.length == 1){
                    ret = tdata[0];
                }else if(tdata.length > 1 ){
                    showMsg("获取数据失败！","E");
                }else{}
            }

        }
    });
    return ret;
}


function save(){
    var data = tabForm.getData();
    var record = {
        mode:data.mode,
        scoutMan:data.scoutMan,
        scoutDate:data.scoutDate,
        content:data.content,
        nextScoutDate:data.nextScoutDate,
        predComeDate:data.predComeDate,
        mainReason:data.mainReason,
        subReason:data.subReason,
        isContinueScout:data.isContinueScout,
        nowMtComp:data.nowMtComp,
        carId:mainData.id,
        guestId:mainData.guestId
    };
    nui.ajax({
        url:baseUrl + "com.hsapi.crm.svr.visit.saveVisitLoseDetail.biz.ext",
        type:"post",
        data:{
            detail:record
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