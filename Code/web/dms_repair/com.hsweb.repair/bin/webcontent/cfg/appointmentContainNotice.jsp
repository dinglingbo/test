<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    


<div class="nui-fit">
    <div id="basicNoticeForm" class="form" contenteditable="false" >
        <table width="100%" border="0" align="center" cellpadding="8" cellspacing="0">
            <tr>
                <td></td>
                <td style="width: 100%">
                    <input class="nui-combobox" id="guestVar" textField="name"
                           onvaluechanged="setVar"
                           valueField="id" emptyText="插入动态变量" style="width: 8%">&nbsp;
                    <span style="color: red">收费标准：每条短信扣费增值币8个，目前增值币余额</span>
                    <span style="color: blue">666</span>
                    <span style="color: red">个</span>
                    <div class="spTag">
                        <span style="float:right; color:#999;">一条短信是60个字，包括换行、空格、门店签名</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tbtext">短信内容</td>
                <td >
                    <input class="nui-textarea" id="msgContent" name="msgContent" style="height:110px;width:80%;">
                </td>
            </tr>
            <tr>
                <td class="tbtext" >接收手机</td>
                <td  >
                    <input class="nui-textbox" width="100px" id="mobile1" name="mobile1">&nbsp;&nbsp;
                    <input class="nui-textbox" width="100px" id="mobile2" name="mobile2">&nbsp;&nbsp;
                    <input class="nui-textbox" width="100px" id="mobile3" name="mobile3">
                </td>
            </tr>
            <tr>
                <td class="tbtext">预约短信通知</td>
                <td class="">
                    <div id="isNotice" name="isNotice" 
                        class="nui-radiobuttonlist" value="1" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="name" valueField="id" ></div>
                </td>
            </tr>
            <tr>
                <td class="tbtext">
                    <a class="nui-button" iconcls="" onclick="saveParams">保存</a>
                </td>
            </tr>
        </table>
    </div>


</div>


