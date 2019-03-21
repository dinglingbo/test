<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->

<head>
    <title>保养提醒-发送微信消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>

    <style>
        .tbtext{
        text-align: right;
    }
    
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="send()" id="save" plain="true" style="width: ;"><span class="fa fa-mail-forward fa-lg"></span>&nbsp;发送</a>
                    <!-- <a class="nui-button" onclick="" plain="true" style="width: ;"><span class="fa fa-navicon fa-lg"></span>&nbsp;选择短信模板</a> -->
                    <a class="nui-button" onclick="onClose()" plain="true" style="width: ;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="t1" style="height:100%">

            <div id="t2" style="float:left;width: 60%; height: 100%;">
                <div class="nui-fit" id="form1">

                    <input class="nui-hidden" name="visitId" id="visitId" />
                    <input class="nui-hidden" name="id" id="id" />
                    <input class="nui-hidden" name="wechatOpenId" id="wechatOpenId" />
                    <table class="tmargin" style="table-layout: fixed;width:100%">
                        <tr class="htr">
                            <td style="width:100px;" class="tbtext"><label>车架号：</label></td>
                            <td style="width:150px;">
                                <input id="carVin" name="carVin" class="nui-textbox textboxWidth" style="width: 100%;"
                                    required="false">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext"><label>上次进站里程：</label></td>
                            <td>
                                <input id="lastComeKilometers" name="lastComeKilometers" class="nui-textbox textboxWidth"
                                    style="width: 100%;" required="true">
                            </td>
                        </tr>
                        <tr class="htr">
                        <tr class="htr">
                            <td class="tbtext"><label>上次进站时间：</label></td>
                            <td>
                                <input id="lastComeDate" name="lastComeDate" class="nui-datepicker textboxWidth" style="width: 100%;"
                                    required="true" format="yyyy-MM-dd HH:mm">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext"><label>首行内容：</label></td>
                            <td colspan="3">
                                <input id="firstContent" name="firstContent" class="nui-textarea textboxWidth" style="width: 80%;height:60px;"
                                    emptyText="请输入首行内容" required="true">
                            </td>
                        </tr>


                        <tr class="htr">
                            <td class="tbtext"><label>尾行内容：</label></td>
                            <td colspan="3">
                                <input id="endContent" name="endContent" class="nui-textarea textboxWidth" style="width: 80%;height:60px;"
                                    emptyText="请输入尾行内容" required="true">
                            </td>
                        </tr>
                    </table>
                    <div>
                        <a class="nui-button" onclick="view()" id="save" plain="false" style="margin-left: 20px;margin-top: 20px;">
                            <span class="fa fa-refresh fa-lg"></span>&nbsp;生成预览</a>
                    </div>
                </div>
            </div>
            <div id="t3" style="float:left;width: 40%; height: 100%;">
                <div style="padding:10px;height: 100%;">
                    <div style="padding:10px;border: 1px solid #aed0ea;height: 230px;width: 260px;">
                        <label id="lbText"></label>
                    </div>
                </div>

            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->

        </div>
    </div>



    <script type="text/javascript">
        nui.parse();
        var turl = apiPath + wechatApi + '/com.hsapi.wechat.autoServiceBackstage.weChatInterface.sendToolWeChatTemplateMessage.biz.ext';
        var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
        var form = new nui.Form("#form1");
        var mainData = {};

        nui.get("carVin").focus();
        document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27)) { //ESC
        onCancel();
        }
        };


        function setData(row) {
            var firstText = '您好：尊敬的'+row.guestName+'先生/女士，根据您上次的进站记录，提醒您近期进站为您的爱车做个“体检”，使用微信保养预约功能，可大大缩减您的等待时间，祝您驾驶愉快！';
            var endText ='感谢您的支持，点击详情查看具体信息。';
            row.firstContent = firstText;
            row.endContent = endText;
            form.setData(row);
            mainData= row;
        }

        function send(params) {
            if (form.validate()) {
                sendWeChat();
            } else {
                showMsg("请完善数据", "W");
            }
        }

        function getViewText() {
            var data = form.getData(true);
            var firstContent = data.firstContent.toString();
            var carVin = data.carVin.toString();
            var lastComeKilometers = data.lastComeKilometers.toString();
            var lastComeDate = data.lastComeDate.toString();
            var endContent = data.endContent.toString();

            var viewText= firstContent + '<br>' +
                '车架号：' + carVin + '<br>' +
                '上次进站里程：' + lastComeKilometers + '公里' + '<br>' +
                '上次进站时间：' + lastComeDate + '<br>' +
                endContent;
                return viewText;
        }

        function view() {
            var text = getViewText();
            document.getElementById("lbText").innerHTML = text;
        }

        function CloseWindow(action) {
            if (action == "close") {} else if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                return window.close();
        }

        function onClose() {
            window.CloseOwnerWindow();
        }


        function sendWeChat() {
            var data = form.getData(true);
            if(!data.wechatOpenId){
                showMsg("该用户没有关注车道服务号","E");
                return;
            }

            var p={
                first:data.firstContent,
                keyword1:data.carVin,
                keyword2:data.lastComeKilometers+'公里',
                keyword3:data.lastComeDate,
                remark:data.endContent
            };
            var params ={
                openid:data.wechatOpenId,
                templateId:'J503rlGOPzZgfUJ5mpGdP5cqL57sWZN_wlxYhbib234',//模板id
                url:'',//消息的yurl 可为空
                paraMap:p,
                token:token
            }
            nui.ajax({
                url:turl,
                type:"post",
                data:params,
                success:function (res) {
                    saveRecord(mainData);
                }
            })
        }


        
function saveRecord(data) {
   
    var message  = getViewText();
    var params ={
        serviceType:data.serviceType,
        mainId:data.id||'',
        guestId:data.guestId||'',
        carId:data.carId||'',
        carNo: data.carNo || '',
        visitMode:'011403',//微信
        visitContent:message||'',
    }
    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            params:params
        },
        success:function(res){
            if(res.errCode == 'S'){
                showMsg("发送成功！","S");
            }else{
                showMsg("发送失败！","E");
            }
            onClose() 
        },
        error: function (jqXHR) {
            showMsg(jqXHR.responseText);
        }
    })
    
}
    </script>
</body>

</html>