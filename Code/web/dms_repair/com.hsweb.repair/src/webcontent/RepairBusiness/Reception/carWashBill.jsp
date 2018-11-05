<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07  
  - Description:   
-->     
<head>
    <title>工单-洗车单</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/carWashBill.js?v=1.4.8"></script>
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
    .btnType{
        font-family:Verdana;
        font-size: 14px;
        text-align: center;
        height: 40px;
        width: 120px;
        line-height:40px;
    }
    .title {
        width: 80px;
        text-align: right; 
    }
    .textStyle{
        text-align: center; 
        font-size:14px;
        font-weight:bold; 
        /* color:#32b400; */
    }  
    .required {
        color: red;
    }

    #guestInfo a:link { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
    }  
    #guestInfo a:visited { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
    } 
    #guestInfo a:hover { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: underline; 
    }  

    #wechatTag{
        color:#62b900;
    }


    /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/
    a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
    a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}

    a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
    a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}

    a.optbtn {
        width: 44px; 
        /* height: 26px; */
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }

    .statusview{background:#78c800; color:#fff; padding:3px 20px; border-radius:20px;}

    .nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}

    .bottomfont{font-size: 20px;}

    .showhealthcss{color: #5a78a0;padding:3px 20px;border: 1px solid;}

</style>
</head>
<body>



    <div class="nui-toolbar" style="padding:2px;height:30px">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td>
                <div class="mini-autocomplete" emptyText="未匹配到数据...(输入的内容长度要求大于或是等于3)"
                    style="width:200px;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo"   searchField="key" 
                    dataField="list" placeholder="请输入...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="送修人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="送修人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="VIN" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                width="200px"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
            </td>     
            <td style="text-align:right;">
                <!-- <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="sureMT()" id="addBtn"><span class="fa fa-car fa-lg"></span>&nbsp;确定开单</a>
                <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                <a class="nui-button" iconCls="" plain="true" onclick="unfinish()" id="addBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                <span class="separator"></span>

                <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印报价单</li>
                    <li iconCls="" onclick="onPrint(2)" id="type11">打印派工单</li>
                    <li iconCls="" onclick="onPrint(3)" id="type11">打印结算单</li>
                    <li iconCls="" onclick="onPrint(4)" id="type11">打印结算单（小票）</li>
                    <li iconCls="" onclick="onPrint(5)" id="type11">打印领料单</li>
                </ul>


                <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"><span class="fa fa-gift fa-lg"></span>&nbsp;充值办卡</a>

                <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="addcardTime()" id="type10">计次卡销售</li>
                    <li iconCls="" onclick="addcard()" id="type11">储值卡充值</li>
                </ul>

                <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

                <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="updateBillExpense()" id="billExpense">费用登记</li>
                    <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount">新增报销单</li>
                    <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount1">修改报销单</li>
                    <!-- <li iconCls="" onclick="addcardTime()" id="type13">车牌替换/修改</li>
                    <li iconCls="" onclick="addcard()" id="type11">等级转介绍客户</li> -->
                </ul>
            </td>
        </tr>
    </table>

</div>
<div class="nui-fit">
    <div id="billForm" class="form">
        <input name="id" class="nui-hidden"/>
        <input name="guestId" class="nui-hidden"/>
        <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="carVin"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="carModel"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <table   style="width: 100%;border-spacing: 0px 5px;"> 
            <tr>   
                <td class="title required">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
                <td class="title required">
                    <label>业务类型:</label>
                </td>
                <td class="">
                    <input name="serviceTypeId"
                    id="serviceTypeId"
                    class="nui-combobox width1"
                    textField="name"
                    valueField="id"
                    emptyText="请选择..."
                    url=""
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..." width="100%"/>
                </td>
                <td class="title required">
                    <label>服务顾问：</label>
                </td>
                <td>
                    <input name="mtAdvisorId"
                    id="mtAdvisorId"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    url=""
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..." width="100%"/>
                </td>
                <td class="title">进厂里程:</td> 
                <td class=""><input  class="nui-textbox" name="enterKilometers" width="100%"/></td>
                <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark" width="100%"/></td>
            </tr>
            <tr>   
                <td class="title required">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%"/></td>
                <td class="title required">客户手机:</td> 
                <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false" width="100%"/></td>
                <td class="title required">联系人名称:</td> 
                <td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" enabled="false" width="100%"/></td>
                <td class="title required">联系人手机:</td> 
                <td class=""><input  class="nui-textbox" name="mobile" id="mobile" enabled="false" width="100%"/></td>
                <td class="title">开单时间:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false" format="yyyy-MM-dd H:mm:ss"
                    class="nui-datepicker" enabled="false" width="100%"/>
                </td>
            </tr>
        </table>
    </div>

    <div style="text-align:center;" >
        <table border="0" align="center" cellpadding="0" cellspacing="0" >
            <tr>
                <td>
                    <div >
                        <span id="carHealthEl" >
                            <a href="javascript:showHealth()" class="healthview" >车况:100</a>&nbsp;
                        </span>
                    </div>
                </td>
                <td>
                    <span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;
                    <label style="font-family:Verdana;">客户名称:</label>
                    <label id="guestNameEl" style="font-family:Verdana;"></label>&nbsp;
                    <label style="font-family:Verdana;">客户手机:</label>
                    <label id="guestTelEl" style="font-family:Verdana;"></label>&nbsp;
                </td>
                <td>
                    <div id="guestInfo">
                        <label style="font-family:Verdana;">车牌号:</label>
                        <label id="guestCarEl" style="font-family:Verdana;"><a id="showCarInfoEl" href="javascript:showBillInfo()"></a></label>&nbsp;
                        <label id="cardPackageEl" style="font-family:Verdana;color:blue;"><a id="showCardTimesEl" href="javascript:showCardTimes()">次卡套餐(0)</a></label>
                        <label id="clubCardEl" style="font-family:Verdana;color:blue;"><a id="showCardEl" href="javascript:showCard()">储值卡(0)</a></label>
                        <label id="creditEl" style="font-family:Verdana;color:#578ccd;">挂账:0</label>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div class="nui-splitter"
        id="splitter"
        allowResize="true"
        handlerSize="6"
        style="width:100%;height:100%;">
        <div size="300" showCollapseButton="true">
            <div class="nui-fit">
                <iframe id="formIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            </div>
        </div>
        <div showCollapseButton="false">

            <div class="nui-fit">
                <div class="" style="width:100%;height:auto;" >
                    <div style="width:100%;height:5px;"></div>
                    <%@include file="/repair/RepairBusiness/Reception/repairPackage.jsp" %>
                    <div style="width:100%;height:5px;"></div>
                    <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
                    <%-- <div style="width:100%;height:5px;"></div>
                    <%@include file="/repair/RepairBusiness/Reception/repairPart.jsp" %> --%>
                </div>
                
                <!-- <div id="bottomPanel" class="nui-panel" title="其他" iconCls="" style="width:100%;height:100px;" 
                showToolbar="false" showCollapseButton="true" showFooter="false" allowResize="false" collapseOnTitleClick="true"
                >
                <div id="billForm" class="form">
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>套餐金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                            <td class="title">
                                <label>套餐优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                            <td class="title">
                                <label>工时金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                            <td class="title">
                                <label>工时优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                            <td class="title">
                                <label>零件金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                            <td class="title">
                                <label>零件优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>应收总计：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                            </td>
                        </tr>
                    </table>
                </div>
                
                
            </div> -->
        </div>
        

    </div>
</div>

</div>
<div style="height: 10%;"></div>



</div>

<div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
    
    <div style="float: left;height: 100%;">
        <table id="statustable" style="width:100%;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
            <tr>
                <td >
                    <label style="font-family:Verdana;">服务进度:</label>
                </td>
                <td >
                    <label style="font-family:Verdana;"><span id="addStatus" name="statusvi" class="nvstatusview">报价</span></label>
                </td>
                <td >
                    <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                </td>
                <td >
                    <label style="font-family:Verdana;"><span id="repairStatus" name="statusvi" class="nvstatusview">施工</span></label>
                </td>
                <td >
                    <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                </td>
                <td >
                    <label style="font-family:Verdana;"><span id="finishStatus" name="statusvi" class="nvstatusview">完工</span></label>
                </td>
                <td >
                    <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
                </td>
                <td >
                    <label style="font-family:Verdana;"><span id="settleStatus" name="statusvi" class="nvstatusview">结算</span></label>
                </td>
            </tr>
        </table>
    </div>
    <div id="sellForm" class="form">
        <table style="width: 50%;float: right;">
            <tr>
                <td class="title">
                    <label>套餐金额：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="packageSubtotal" name="packageSubtotal"/>
                </td>
                <td class="title">
                    <label>套餐优惠：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="packagePrefAmt" name="packagePrefAmt"/>
                </td>
                <td class="title">
                    <label>工时金额：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="itemSubtotal" name="itemSubtotal"/>
                </td>
                <td class="title">
                    <label>工时优惠：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="itemPrefAmt" name="itemPrefAmt"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label>配件金额：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="partSubtotal" name="partSubtotal"/>
                </td>
                <td class="title">
                    <label>配件优惠：</label>
                </td>
                <td style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" width="100%" id="partPrefAmt" name="partPrefAmt"/>
                </td>
                <td class="title required">
                    <label>应收总计：</label>
                </td>
                <td colspan="3" style="width:80px;">
                    <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" inputStyle="" enabled="false" width="100%" id="mtAmt" name="mtAmt"/>
                </td>
            </tr>
        </table>
    </div>
</div>

<div id="advancedCardTimesWin" class="nui-window"
title="" style="width:450px;height:200px;"
showModal="false"
showHeader="false"
allowResize="false"
allowDrag="false">
     <!-- <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
                </td>
            </tr>
        </table>
    </div> -->
    <div class="nui-fit">
      <div id="cardTimesGrid" class="nui-datagrid" style="width:100%;height:95%;"
      selectOnLoad="true"
      showPager="false"
      dataField="data"
      idField="id"
      allowCellSelect="true"
      editNextOnEnterKey="true"
      url="">
      <div property="columns">
          <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
          <div field="prdtType" name="prdtType" width="50" headerAlign="center" header="产品类别"></div>
          <div field="canUseTimes" name="canUseTimes" width="50" headerAlign="center" header="可使用次数"></div>
          <div field="doTimes" name="doTimes" width="50" headerAlign="center" header="使用中次数"></div>
          <div field="balaTimes" name="balaTimes" width="50" headerAlign="center" header="剩余次数"></div>
          <div field="cardTimesOpt" name="cardTimesOpt" width="50" headerAlign="center"  header="操作"></div>
      </div>
  </div>
</div>
</div> 

<div id="advancedMemCardWin" class="nui-window"
title="" style="width:500px;height:200px;"
showModal="false"
showHeader="false"
allowResize="false"
allowDrag="false">
<div class="nui-fit">
  <div id="memCardGrid" class="nui-datagrid" style="width:100%;height:95%;"
  selectOnLoad="true"
  showPager="false"
  dataField="data"
  onrowdblclick="addSelectPart"
  allowCellSelect="true"
  editNextOnEnterKey="true"
  url="">
  <div property="columns">
      <div field="cardName" name="cardName" width="100" headerAlign="center" header="卡名称"></div>
      <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="余额"></div>
      <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="储值日期" dateFormat="yyyy-MM-dd"></div>
      <div field="periodValidity" name="periodValidity" width="100" headerAlign="center" header="到期日期" dateFormat="yyyy-MM-dd"></div>
  </div>
</div>
</div>
</div> 


<div id="carCheckInfo" class="nui-window"
title="" style="width:400px;height:200px;"
showModal="false"
showHeader="false"
allowResize="false"
allowDrag="false">
<div class="nui-fit" id="show1" >
    <table style="width: 100%;background-color: #eef1f4">
        <tr style="height: 40px;">
            <td class="">
                <label id="lastCheckInfo1" style="color: #9e9e9e;"></label>
            </td>

            <td class="">
                <label id="lastCheckInfo2"></label>
            </td>

            <td class="">
                <label id="lastCheckInfo3"></label>
            </td>

            <td class="">
                <a class="nui-button  mini-button-info" iconCls="" plain="false" onclick="newCheckMainMore()" id="lastCheckInfo4" style="display: none">查看</a>
            </td>
        </tr>
    </table>
    <table style="width: 100%;margin-top:20px; "  >
        <tr>
            <td class=""> 
                <label id="checkStatus1" class="showhealthcss">未派工</label>
            </td>

            <td class="">
                <label id="checkStatus2" class="showhealthcss">已派工</label>
            </td>

            <td class="">
                <label id="checkStatus3" class="showhealthcss">施工中</label>
            </td>

            <td class="">
                <label id="checkStatus4" class="showhealthcss">已完工</label>
            </td>
        </tr>
    </table>
    <div align="center" style="margin-top:20px; " id="checkStatusButton1">
        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="MemSelectCancel(2)" id="">
            <span style="line-height: 30px;">车况派工</span>
        </a>
    </div>

    <div align="center" style="margin-top:20px;display: none; " id="checkStatusButton2">
        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="newCheckMain()" id="">
            <span style="line-height: 30px;">车况查看</span>
        </a>
    </div>
</div>


<div class="nui-fit" id="show2" style="display: none;">

    <table style="width: 100%;margin-top:20px; " >
        <tr>
            <td class="" style="float: right;"> 
                <label>选择检查人</label>
            </td>

            <td class="">
                <input name="checkManId"
                id="checkManId"
                style="width:150px;" 
                class="nui-combobox "
                textField="empName"
                valueField="empId"
                emptyText="请选择..."
                url=""
                allowInput="true"
                required="true"
                showNullItem="false"
                valueFromSelect="true"
                nullItemText="请选择..."/>
            </td>
        </tr>
    </table>
    <div align="center" style="margin-top:20px; ">
        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectOk" id="">
            确定
        </a>

        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectCancel(1)" id="">
            取消
        </a>
    </div>
</div>



</div> 

<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>