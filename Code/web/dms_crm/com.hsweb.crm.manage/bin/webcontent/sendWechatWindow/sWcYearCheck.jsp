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
    <title>车辆年检-发送微信消息</title>
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
                            <td style="width:100px;" class="tbtext"><label>车牌号：</label></td>
                            <td style="width:150px;">
                                <input id="keyword1" name="keyword1" class="nui-textbox textboxWidth" style="width: 100%;"
                                    required="true">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext"><label>到期时间：</label></td>
                            <td>
                                <input id="keyword2" name="keyword2" class="nui-datepicker textboxWidth" style="width: 100%;"
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
        var turl = apiPath + wechatApi + '/com.hsapi.wechat.autoServiceBackstage.weChatInterface.sendToolWeChatTemplateMessage.biz.ext'
        var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
        var form = new nui.Form("#form1");
        var mainData = {};

        nui.get("keyword1").focus();
        document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27)) { //ESC
        onCancel();
        }
        };


        function setData(row) {
            var firstText = '您好：尊敬的'+row.name+'先生/女士，您的车辆年检时间将到期';
            var endText ='请及时办理。';
            row.firstContent = firstText;
            row.endContent = endText;
            row.keyword1 = row.carNo;
            row.keyword2 = row.annualVerificationDueDate;
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
            var keyword1 = data.keyword1.toString();
            var keyword2 = data.keyword2.toString();
            var endContent = data.endContent.toString();

            var viewText= firstContent + '<br>' +
                '车牌号：' + keyword1 + '<br>' +
                '到期时间：' + keyword2 + '<br>' +
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
            var p={
                first:data.firstContent,
                keyword1:data.keyword1,
                keyword2:data.keyword2,
                remark:data.endContent
            };
            var params ={
                openid:data.wechatOpenId,
                templateId:'oBMHtz2FOq5gbdBLTrELvVC9QrB6J8rrmOyU81Bg844',//模板id  车辆年检
                url:'',//消息的yurl 可为空
                paraMap:p,
                token:token
            }
            nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '发送中...'
        });
            nui.ajax({
                url:turl,
                type:"post",
                data:params,
                success:function (res) {
                    nui.unmask(document.body);
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
            onClose();
        },
        error: function (jqXHR) {
            showMsg(jqXHR.responseText);
        }
    })
    
}
    </script>
</body>

</html>