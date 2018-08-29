<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
    <title>工单-洗车单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
    body { 
     margin: 0;
     padding: 0;
     border: 0;
     width: 100%;
     height: 100%;
     overflow: hidden;
 }





#table_A tr
{
  height:40px;
}
table tr td span
{

  display: inline-block;
}


#table_A tr
{
  height:40px;
}
table tr td span
{

  display: inline-block;
}

.tabwidth{
  width:100%;
}
.tbtext{
  float: right;
  line-height: 40px;
}
.tbCtrl{
    width: 150px;
}
.mini-textbox{
  height: 28px;
}
.mini-textbox-border{
  height: 25px;
}
.mini-textbox-input{/* 输入框的里面的高度 */
  height: 24px;
}

.checkboxwidth{
  width: 65px;
  margin-left:20px;
}

.mini-tabs-header{
    height: 30px;
}

.mini-button-text{
    line-height: 26px;
} 




/* ////////////////下拉框样式/////////////////////////////// */
.mini-buttonedit {
    height: 28px; 
}

.mini-buttonedit-border { 
    height: 25px;
}

.mini-buttonedit-input {
    height: 24px;
} 
.mini-buttonedit-buttons{
    top:3px; 
    right: 10px;
}
.mini-buttonedit-button{
    border-left:0px;
    background: #fff;
}    

.mini-buttonedit-button-pressed, .mini-buttonedit-popup .mini-buttonedit-button {
    background: #fff; 
    color: #333333;
    border-width: 0px; 
    border-left: 0px;
} 

.mini-buttonedit-popup .mini-buttonedit-button
{
    background: #fff;
    border-width:0px;
    border-left: 0px ;
}

.mini-buttonedit-button-hover,
.mini-buttonedit-hover .mini-buttonedit-button
{
    color:#333;     
    background:#fff;
    border-width:0px;
    border-left: 0px ;
}
/* /////////////////////////////////////////////// */
.red{
    color: red;
}
.right{
    text-align: right;
}
.fwidtha{
    width: 120px;
}
.fwidthb{
    width: 120px;
}
.bt_trWidth{
    width: 170px;
}
.textboxWidth{
    width:100%;
}
.htr{
    height: 30px;
}
.tmargin{
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;height:60px">
        <table class="table" id="table1" border="0" style="width:100%">
            <tr>
                <td>
                    <label style="font-family:Verdana;">工单号:</label>
                    <label id="servieIdEl" style="font-family:Verdana;font-size:15px;font-weight:bold;">综合开单详情</label>
                    <label style="font-family:Verdana;">车牌号:</label>
                    <label id="carNoEl" style="font-family:Verdana;font-size:15px;font-weight:bold;">粤AXXXXX</label>
                    <span class="separator"></span>
                    <span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;
                    <label style="font-family:Verdana;">客户名称:</label>
                    <label id="guestNameEl" style="font-family:Verdana;font-weight:bold;">秦生</label>&nbsp;
                    <label style="font-family:Verdana;">联系方式:</label>
                    <label id="guestTelEl" style="font-family:Verdana;font-weight:bold;">1371032XXXX</label>
                    <label id="cardPackageEl" style="font-family:Verdana;color:blue;">次卡套餐(7)</label>
                    <label id="clubCardEl" style="font-family:Verdana;color:blue;">会员卡(2)</label>
                    <label id="creditEl" style="font-family:Verdana;color:blue;">挂账:265</label>
                </td>
                <td rowspan="2" style="text-align:left;">
                    <a class="nui-button btnType" iconCls="" plain="false" onclick="addcardTime()" id="addBtn"><span class="btnType"><span class="fa fa-gift fa-lg"></span>&nbsp;次卡套餐</span></a>
                    <a class="nui-button btnType" iconCls="" plain="false" onclick="add()" id="addBtn"><span class="btnType"><span class="fa fa-dollar fa-lg"></span>&nbsp;充值办卡</span></a>
                </td>
            </tr>
            <tr>
                <td style="text-align:left;">
                    <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                    <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    <span class="separator"></span>

                    <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                    <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="onPrint(0)" id="type10">打印维修委托单</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">打印派工单</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">打印结算单</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">打印领料单</li>
                    </ul>


                    <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"><span class="fa fa-print fa-lg"></span>&nbsp;其他</a>

                    <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="onPrint(0)" id="type10">储值卡销售</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">储值卡充值</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">车牌替换/修改</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11">等级转介绍客户</li>
                    </ul>
                    <input name="receTypeId"
                                id="receTypeId"
                                class="nui-combobox"
                                textField="name"
                                visible="false"
                                valueField="customid"/>
                </td>
            </tr>
        </table>

    </div>
    <div class="nui-fit">
       <table  style=" left:0;right:0;margin: 0 auto;"> 
<!--          <tr>   
            <td class="tbtext">进场日期</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">预计交车日期</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        </tr>-->
        <tr>   
            <td class="tbtext">车牌号</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">联系方式</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">进厂里程</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        </tr>
            <td class="tbtext">客户名称</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">备注</td> 
            <td class="tbCtrl" colspan="3"><input  class="nui-textbox tabwidth" /></td>
            <td class="tbtext">开单时间</td> 
            <td class="tbCtrl"><input  class="nui-textbox tabwidth" /></td>
        </tr>
        <!--<tr>
            <td class="tbtext">选择服务类型</td>
            <td class="tbCtrl" colspan="7">
                <input  class="nui-button tabwidth" text="精致洗车（￥135）" style="height: 60px;width: 200px" />
                <input  class="nui-button tabwidth" text="普通洗车（￥50）" style="height: 60px;width: 200px" />
            </td>

        </tr>-->

    </table>


    <div style="width:100%;margin-top: 10px;">
        <a class="nui-button" onclick=""   plain="false" >洗车历史</a>
    </div>
    <div>
        <div id="datagrid1" class="nui-datagrid" showPager="false">
            <div property="columns">

                <div field="" width="100" headerAlign="center" align="center">项目名称</div>
                <div field="" width="100" headerAlign="center" align="center">业务分类</div>
                <div field="" width="100" headerAlign="center" align="center">工时</div>
                <div field="" width="100" headerAlign="center" align="center">单价</div>
                <div field="" width="100" headerAlign="center" align="center">工时费</div>
                <div field="" width="100" headerAlign="center" align="center">折扣</div>
                <div field="" width="100" headerAlign="center" align="center">折后金额</div>
                <div field="" width="300" headerAlign="center" align="center">服务技师</div>
                <div field="" width="100" headerAlign="center" align="center">备注</div>
                <div field="" width="100" headerAlign="center" align="center">删除</div>
            </div>
        </div>
    </div>


    <table > 
        <tr>   
            <td class="tbtext">备注</td> 
            <td class="tbCtrl" style="width: 600px;"><input  class="nui-textarea tabwidth" style="height: 60px;width: 100%"/></td>


        </tr>

        <tr>   
            <td class="tbtext">应收总计</td> 
            <td class="tbCtrl">￥0.00 = 工时费小计：￥0.00 + 材料费小计：￥0.00 +附加费小计：￥0.00</td>
     
        </tr>

    </table>
    <div style="width:100%;margin-top: 10px;text-align: center;">
        <a class="nui-button" onclick=""   plain="false" >保存</a>

        <a class="nui-button" onclick=""   plain="false" >退出</a>
    </div>

</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>