<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59 
  - Description:
-->
<head>
    <title>车险登记明细</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceDetail.js?v=1.0.58"></script>
    <style type="text/css">

    table {
       font-size: 12px;
   }

   .form_label {
       width: 84px;
   }

   a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
   a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}
</style>

</head>
<body>
    <div class="nui-toolbar">
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
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="saveData(1)" id="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="pay"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                <a class="nui-button" plain="true" onclick="onPrint()" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
            </td>
        </tr> 
    </table>   
</div> 
 
<div id="basicInfoForm" class="form">
    <input class="nui-hidden" name="id" id="id"/>
    <input name="guestId" class="nui-hidden"/>
    <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
    <input class="nui-hidden" name="contactorId"/>
    <input class="nui-hidden" name="contactorName"/>
    <input class="nui-hidden" name="carId"/>
    <input class="nui-hidden" name="status"/>
    <input class="nui-hidden" name="carVin"/>
    <input class="nui-hidden" name="drawOutReport"/>
    <input class="nui-hidden" name="identity"/>
    <input class="nui-hidden" name="billTypeId"/>
    <input class="nui-hidden" name="status"/>
    <input class="nui-hidden" name="isSettle"/>
    <table  style=" left:0;right:0;margin: 0 auto;"> 
        <tr>
            <td class="title required">车牌号:</td> 
            <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false"/></td>

            <td class="title required">手机号:</td> 
            <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false"/></td>

            <td class="title required">本次里程:</td> 
            <td class=""><input  class="nui-textbox" name="enterKilometers" id="enterKilometers" enabled="true"/></td>

            <td class="title">开单时间:</td> 
            <td class="">
                <input id="recordDate"
                name="recordDate"
                allowInput="false" format="yyyy-MM-dd "
                class="nui-datepicker" enabled="false"/>
            </td>

        </tr>
        <tr>   
            <td class="title required">客户名称:</td> 
            <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false"/></td>
            <td class="title required">客户单位:</td> 
            <td class=""><input  class="nui-textbox" name="" id="" enabled="false"/></td>

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
                nullItemText="请选择..."/>
            </td>

            <td class="title required">车辆品牌:</td> 
            <td class=""><input  class="nui-textbox" name="carBrand" id="carBrand" enabled="false"/></td>

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
                <span id="wechatTag" class="fa fa-wechat fa-lg healthview"></span>&nbsp;
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

<div class="nui-toolbar" style="margin-top:5px;" id="insuranceForm">
    <input class="nui-hidden" name="insureCompId" id="insureCompId"/>
    <input class="nui-hidden" name="saleMans" id="saleMans"/>
    <input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..."popupWidth="200" onvaluechanged="insuranceChange"/>
    <input class="nui-combobox" id="saleManIds" name="saleManIds" emptyText="选择销售人员" dataField="data" valueField="empId" textField="empName" showNullItem="true" nullItemText="请选择..." multiSelect="true" onvaluechanged="saleManChange"/>
    有效日期 从<input id="date1" name="date1" class="nui-datepicker" value="" format="yyyy-MM-dd "/>
    至 <input id="date2" name="date2" class="nui-datepicker" value="" format="yyyy-MM-dd "/> &nbsp;&nbsp;

    <label>保费收取方式：</label> 
    <input type="radio" name="settleTypeId" id="radio1" value="1">保司直收
    <input type="radio" name="settleTypeId" id="radio2" value="2" checked>门店代收全款
    <input type="radio" name="settleTypeId" id="radio3" value="3">代收减返点

</div>   

<div class="nui-fit">
    <div id="detailGrid" datafield="list" class="nui-datagrid" style="width: 100%; height:118px;" 
    showpager="false" sortmode="client" allowcelledit="true" allowcellselect="true" 
    showSummaryRow="true" showModified ="false" ondrawsummarycell="drawSummaryCell">
    <div property="columns"> 
        <div type="indexcolumn" width="50" headeralign="center" align="center">序号</div>
        <div field="insureTypeId" headeralign="center"  align="center" visible="true" width="100">险种ID</div>
        <div field="insureTypeName" headeralign="center"  align="center" visible="true" width="100">名称</div>
        <div field="amt" name="amt" headeralign="center" align="center" visible="true" width="100" header="保司保费(售价/元)"summaryType="sum">
            <input property="editor" class="nui-textbox" vtype="float" >
        </div>
        <div field="rtnCompRate"name="rtnCompRate" headeralign="center" align="center" visible="true" width="100" header="保司返点(%)"summaryType="sum">
            <input property="editor" class="nui-textbox" vtype="float" >
        </div>
        <div field="rtnGuestRate" name="rtnGuestRate" headeralign="center" align="center" visible="true" width="100" header="客户返点(%)" summaryType="sum">
            <input property="editor" class="nui-textbox" vtype="float" >
        </div>

    </div>
</div>

</div>


<div id="advancedCardTimesWin" class="nui-window"
title="" style="width:450px;height:200px;"
showModal="false"
showHeader="false"
allowResize="false"
allowDrag="false">

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
</body>
</html>