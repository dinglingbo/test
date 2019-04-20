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
    <title>保险到期-发送微信消息-群发</title>
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
                            <td class="tbtext"><label>交强险到期时间：</label></td>
                            <td style="width:150px;">
                                <input id="keyword1" name="keyword1" class="nui-datepicker textboxWidth" style="width: 100%;"
                                    required="false" format="yyyy-MM-dd HH:mm">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext"><label>商业险到期时间：</label></td>
                            <td>
                                <input id="keyword2" name="keyword2" class="nui-datepicker textboxWidth" style="width: 100%;"
                                    required="false" format="yyyy-MM-dd HH:mm">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext"><label>首行内容：</label></td>
                            <td colspan="3">
                                <input id="firstContent" name="firstContent" class="nui-textarea textboxWidth" style="width: 80%;height:60px;"
                                    emptyText="请输入首行内容" required="false">
                            </td>
                        </tr>


                        <tr class="htr">
                            <td class="tbtext"><label>尾行内容：</label></td>
                            <td colspan="3">
                                <input id="endContent" name="endContent" class="nui-textarea textboxWidth" style="width: 80%;height:60px;"
                                    emptyText="请输入尾行内容" required="false">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="" colspan="4"><label style="color: red;margin-left:30px;">注：使用【车主姓名】代替车主姓名</label></td>
                        </tr>
                    </table>
                    <div>
                        <a class="nui-button" onclick="view()" id="save" plain="false" style="margin-left: 20px;margin-top: 10px;">
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
        var turl = apiPath + wechatApi + '/com.hsapi.wechat.autoServiceBackstage.weChatInterface.queryBeatchWeChatTemplateMessage.biz.ext';
        var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
        var taskUrl = apiPath + crmApi +"/com.hsapi.crm.svr.guest.saveSendTask.biz.ext";
        var form = new nui.Form("#form1");
        var mainData = [];

        nui.get("keyword1").focus();
        document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27)) { //ESC
        onCancel();
        }
        };


        function setData(rows) {
            var row = rows[0];
            var firstText = '您好：尊敬的【车主姓名】先生/女士，您有汽车保险将要到期';
            var endText ='请及时续保，若保险时间提醒有误，可重新设置保险时间。如有疑问可致电'+currCompTel;
            row.firstContent = firstText;
            row.endContent = endText;
            row.keyword1 = row.insureDueDate;
            row.keyword2 = row.annualInspectionDate;
            form.setData(row);
            mainDatas= rows;
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
            var firstContent = data.firstContent.toString().replace(/【车主姓名】/g,mainDatas[0].guestName);
            var keyword1 = data.keyword1;
            var keyword2 = data.keyword2;
            var endContent = data.endContent.toString();

            var viewText= firstContent + '<br>' +
                '交强险到期时间：' + keyword1 + '<br>' +
                '商业险到期时间：' + keyword2 + '<br>' +
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
        //     var data = form.getData(true);
        //     var dataList = [];
        //     for (var i = 0; i < mainDatas.length; i++) {
        //         var temp = {};
        //         temp.first = data.firstContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName);
        //         temp.keyword1 =  (mainDatas[i].insureDueDate == null?'':nui.formatDate (new Date(mainDatas[i].insureDueDate),'yyyy-MM-dd HH:mm'));
        //         temp.keyword2 =  (mainDatas[i].annualInspectionDate == null?'':nui.formatDate (new Date(mainDatas[i].annualInspectionDate),'yyyy-MM-dd HH:mm'));
        //         temp.remark =  data.endContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName);
        //         temp.openid = mainDatas[i].wechatOpenId;
        //         dataList.push(temp);
        //     }
        //     nui.mask({
        //     el : document.body,
        //     cls : 'mini-mask-loading',
        //     html : '发送中...'
        // });
        //     nui.ajax({
        //         url:turl,
        //         type:"post",
        //         data:{
        //             paraMapList:dataList,
        //             templateId:'LNDuderGsWD9igtiShaDP1yd7i1t7NiRD2D3D_TXgMk',//模板id  保险到期
        //             url:'',
        //             token:token
        //         },
        //         success:function (res) {
        //             nui.unmask(document.body);
        //             // saveRecord(mainData);
        //         }
        //     })
            saveTask() ;
        }


        function saveTask() {
    if (mainDatas.length > 0) {
        var params = {
            serviceType: mainDatas[0].serviceType,
            visitMode:'011403',//微信
            taskNum: mainDatas.length,
        }

        var formData = form.getData(true);
        var Arr = [];
        for (var i = 0; i < mainDatas.length; i++) {
            var data = mainDatas[i];
            var con = formData.firstContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName)+ '<br/>' 
            + '交强险到期时间：' + (mainDatas[i].insureDueDate == null?'':nui.formatDate (new Date(mainDatas[i].insureDueDate),'yyyy-MM-dd HH:mm')) + '<br>' 
            + '商业险到期时间：' + (mainDatas[i].annualInspectionDate == null?'':nui.formatDate (new Date(mainDatas[i].annualInspectionDate),'yyyy-MM-dd HH:mm')) + '<br>' 
            + formData.endContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName);
            var pa ={
                guestId: data.tureGuestId || '',
                contactorId: data.conId,
                mobile:data.mobile,
                carId:data.carId||'', 
                carNo: data.carNo || '',
                visitContent:con ,
                guestSource: data.guestSource,
                wechatOpenId: data.wechatOpenId,
                wechatServiceId:data.wechatServiceId,
                firstText:formData.firstContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName),
                endText:formData.endContent.toString().replace(/【车主姓名】/g,mainDatas[i].guestName),
                keyword1:(mainDatas[i].insureDueDate == null?'':nui.formatDate (new Date(mainDatas[i].insureDueDate),'yyyy-MM-dd HH:mm')) ,
                keyword2: (mainDatas[i].annualInspectionDate == null?'':nui.formatDate (new Date(mainDatas[i].annualInspectionDate),'yyyy-MM-dd HH:mm')) 
                
            };
            Arr.push(pa);
        }
              nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '微信发送任务后台生成中...'
             });
        nui.ajax({
            url: taskUrl,
            type: 'post',
            data: {
                taskMain: params,
                taskDetail:Arr
            },
            success: function (res) {
                nui.unmask(document.body);
                if (res.errCode == 'S') {
                    showMsg(res.snum+"条微信发送任务生成成功！", "S");
                    //saveRecord(mainData);
					CloseWindow("ok");
                } else {
                    showMsg(res.fnum+"条微信发送任务生成失败！","E");
                }
            }
        })
    }
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
                // showMsg("保存成功！","S");
            }else{
                // showMsg("保存失败！","E");
            }
        },
        error: function (jqXHR) {
            showMsg(jqXHR.responseText);
        }
    })
    
}
    </script>
</body>

</html>