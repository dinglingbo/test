<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    
<div class="nui-fit">
    <div id="basicInfoForm" class="form" contenteditable="false" >
        <input class="nui-hidden" name="id"/>
        <table width="100%" border="0" align="center" cellpadding="8" cellspacing="0">
            <tr>
                <td class="tbtext required">可提前几天预约</td>
                <td colspan="2">
                   <input class="nui-spinner" id="advanceDay" name="advanceDay" width="100px" value="1" minValue="1" maxValue="30"
                          showButton="false" format="0" changeOnMousewheel="true">
                   <strong>
                       <span style="color:#696969">天（不可超过30天）</span>
                   </strong>
               </td>
            </tr>
            <tr>
                <td class="tbtext required" >多长时间不能预约</td>
                <td  >
                    <input class="nui-spinner" width="100px" value="60" minValue="0" maxValue="9999999"
                    id="advanceTimes" name="advanceTimes" showButton="false" format="0" changeOnMousewheel="true">
                    <strong>
                        <span style="color:#696969">分钟</span>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="tbtext required">可预约时间段</td>
                <td >
                    <input class="nui-combobox" id="timeStart" name="timeStart" textField="name" width="100px"width="100px"
                        valueField="id" allowInput="false" value="9:00" onValuechanged="setTimeChange">&nbsp;-
                    <input class="nui-combobox" id="timeEnd" name="timeEnd" textField="name" width="100px"
                        valueField="id" allowInput="false" value="18:00" onValuechanged="setTimeChange">
                </td>
            </tr>
            <tr>
                <td class="tbtext required">预约间隔</td>
                <td >
                    <input class="nui-combobox" id="intervalTime" name="intervalTime" textField="name" width="100px"width="100px"
                        valueField="id" allowInput="false" value="60" onValuechanged="setTimeChange">
                    <div class="spTag">
                        <span style="background-color: #ff7484;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        预约优惠
                        &nbsp;&nbsp;
                        <span style="background-color: #00b4f6;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        可以预约
                            &nbsp;&nbsp;
                        <span style="background-color: #dcdcdc;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        不可预约
                    </div>
                </td>
            </tr>
            <tr>
                <td >
                    <!-- <div style="border:1px solid rgb(0, 162, 255);width: 70px;"align="center">09:00<br>无优惠</div> -->
                </td>
                <td valign="top">
                    <ul class="sjd">
                            <!-- <li name="time" class="yyh"><font>09:00</font>
                                <p><a href="javascript:;"></a><span name="comment" discount="80">折扣：80折</span></p>
                            </li>
                            <li name="time" class=""><font>10:00</font>
                                <p><a href="javascript:;"></a><span name="comment">无优惠</span></p>
                            </li>
                            <li name="time" class=""><font>11:00</font>
                                <p><a href="javascript:;"></a><span name="comment">无优惠</span></p>
                            </li>
                            <li name="time" class=""><font>12:00</font>
                                <p><a href="javascript:;"></a><span name="comment">无优惠</span></p>
                            </li> -->
                    </ul>
                </td>
            </tr>
            <tr>
                <td class="tbtext">是否启动预约</td>
                <td class="">
                    <div id="status" name="status" 
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


