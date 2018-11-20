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
    <title>保养提醒</title>
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
        <div id="p1" class="nui-panel" title="沟通结果" iconCls="" style="width:100%;height:100%;"buttons="">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </div>
            <input class="nui-hidden" name="visitId" id="visitId"/>
            <input class="nui-hidden" name="id" id="id"/>
            <table class="tmargin" style="table-layout: fixed;width:100%">
                <tr class="htr">
                    <td  style="width: 70px;">提醒方式：</td>
                    <td style="width: 135px;">
                        <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
                    </td>

                    <td style="width: "></td>
                </tr> 
                <tr class="htr">
                    <td >提醒内容：</td>
                    <td  colspan="6">
                        <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:150px;">
                    </td>
                </tr> 

            </table>
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();

        var baseUrl = apiPath +repairApi + "/";
        var sysUrl =apiPath +sysApi+"/";
        var visitModeCtrlUrl = sysUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
        var tabForm = new nui.Form("#form1");
        var visitMode = nui.get("visitMode");
        visitMode.setUrl(visitModeCtrlUrl);
        var mainData = {};


        function setData(rowData){
            mainData = rowData;
        }



        function save(){
            var data = tabForm.getData();

            if(!data.visitMode){
                showMsg("清先选择提醒方式","W");
                return;
            }
            if(!data.visitContent){
                showMsg("清填写内容","W");
                return;
            }
            var record=[];
            record[0] = {
                orgid: currOrgId,
                careType:1,
                guestId:mainData.guestId,
                carId:mainData.carId,
                visitMode : data.visitMode,
                visitContent:data.visitContent,
                visitId:currUserId,
                visitMan:currUserName
            };
            nui.ajax({
                url:baseUrl + "com.hsapi.repair.repairService.crud.saveCareRecord.biz.ext",
                type:"post",
                data:{
                    data:record
                },
                success:function(text){
                    if(text.errCode == "S"){
                        var detailData = text.list;
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