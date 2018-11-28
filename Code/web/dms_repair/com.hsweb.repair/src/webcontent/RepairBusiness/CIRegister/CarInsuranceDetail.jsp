<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59 
  - Description:
-->
<head>
    <title>保险开单明细</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceDetail.js?v=1.1.50"></script>
    <style type="text/css">
   .title {
        width: 80px;
        text-align: right; 
    }
    table {
       font-size: 12px;
   } 

   .form_label {
       width: 84px;
   }
	#wechatTag{
            color:#62b900;
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
   a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
  a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}  
   a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
   a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}
   
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
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="add"> <span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> 
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
    <input class="nui-hidden" name="insureCompId" id="insureCompId"/>
    <input class="nui-hidden" name="saleMans" id="saleMans"/>
    <table  style="width: 100%;border-spacing: 0px 5px;"> 
        <tr>
            <td class="title required">车牌号:</td> 
            <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>

            <td class="title required">手机号:</td> 
            <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false" width="100%"/></td>

            <td class="title required" style="color:red">本次里程:</td> 
            <td class=""><input  class="nui-textbox" name="enterKilometers" vtype="int;range:0,100000000" id="enterKilometers" enabled="true" width="100%"/></td>

            <td class="title">开单时间:</td> 
            <td class="">
                <input id="recordDate"
                name="recordDate"
                allowInput="false" format="yyyy-MM-dd "
                class="nui-datepicker" enabled="false" width="100%"/>
            </td>

        </tr>
        <tr>   
            <td class="title required">客户名称:</td> 
            <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%"/></td>
         
            <td class="title required" style="color:red">
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
                onvaluechanged="ManChanged"
                nullItemText="请选择..." width="100%"/>
            </td>

            <td class="title required">车辆/品牌:</td> 
            <td class="" colspan="3"><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
			
        </tr>
        
        <tr>   
            <td class="title required" style="color:red">保险公司:</td> 
            <td class=""><input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..."popupWidth="200" onvaluechanged="insuranceChange" width="100%"/></td>
            <td class="title required" style="color:red">销售人员:</td> 
            <td class=""><input class="nui-combobox" id="saleManIds" name="saleManIds" emptyText="选择销售人员" dataField="data" valueField="empId" textField="empName" showNullItem="true" nullItemText="请选择..." multiSelect="true" onvaluechanged="saleManChange" width="100%"/></td>

            <td class="title required" style="color:red">
                <label>有效日期：</label>
            </td>
            <td style="width:20%" >
               <input id="beginDate" name="beginDate" class="nui-datepicker" value="" format="yyyy-MM-dd " width="43%"/>
    			至 <input id="endDate" name="endDate" class="nui-datepicker" value="" format="yyyy-MM-dd "width="43%"/> &nbsp;&nbsp;
            </td>

            <td class="title required" style="color:red">保费收取方式:</td> 
            <td class=""><input  class="nui-combobox" name="settleTypeId" id="settleTypeId" valueField="id" textField="name" data="settleTypeIdList" dataField="settleTypeIdList" width="100%"/></td>
			
        </tr>
    </table>
</div>

<div style="text-align:center;" >
    <table border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
            <td>
            </td>
            <td>
                <span id="wechatTag" class="fa fa-wechat fa-lg healthview"></span>&nbsp;
                <label style="font-family:Verdana;">客户名称:</label>
                <label id="guestInfo" style="font-family:Verdana;"><a id="guestNameEl" href="javascript:checkGuest()"></a></label>&nbsp;
                <label style="font-family:Verdana;">客户手机:</label>
                <label id="guestTelEl" style="font-family:Verdana;"></label>&nbsp;
            </td>
            <td>
                <div id="guestInfo">
                    <label style="font-family:Verdana;">车牌号:</label>
                    <label id="guestCarEl" style="font-family:Verdana;">
                </div>
            </td>
        </tr>
    </table>
</div> 

<!-- <div class="nui-toolbar" style="margin-top:5px;" id="insuranceForm"> -->
<!--     <input class="nui-hidden" name="insureCompId" id="insureCompId"/> -->
<!--     <input class="nui-hidden" name="saleMans" id="saleMans"/> -->
<!--     <input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..."popupWidth="200" onvaluechanged="insuranceChange"/> -->
<!--     <input class="nui-combobox" id="saleManIds" name="saleManIds" emptyText="选择销售人员" dataField="data" valueField="empId" textField="empName" showNullItem="true" nullItemText="请选择..." multiSelect="true" onvaluechanged="saleManChange"/> -->
<!--     有效日期 从<input id="date1" name="date1" class="nui-datepicker" value="" format="yyyy-MM-dd "/> -->
<!--     至 <input id="date2" name="date2" class="nui-datepicker" value="" format="yyyy-MM-dd "/> &nbsp;&nbsp; -->

<!--     <label>保费收取方式：</label>  -->
<!--     <input type="radio" name="settleTypeId" id="radio1" value="1">保司直收 -->
<!--     <input type="radio" name="settleTypeId" id="radio2" value="2" checked>门店代收全款 -->
<!--     <input type="radio" name="settleTypeId" id="radio3" value="3">代收减返点 -->

<!-- </div>    -->

<div class="nui-fit">
    <div id="detailGrid" datafield="list" class="nui-datagrid" style="width: 100%; height:118px;" 
    showpager="false" sortmode="client" allowcelledit="true" allowcellselect="true" 
    showSummaryRow="true" showModified ="false" ondrawsummarycell="drawSummaryCell">
    <div property="columns"> 
        <div type="indexcolumn" width="50" headeralign="center" align="center">序号</div>
        <div field="insureTypeName" headeralign="center"  align="center" visible="true" width="100">名称</div>
        <div field="insureTypeId" headeralign="center"  align="center" visible="false" width="100"  header="险种ID"> </div>
        <div field="insureNo" headeralign="center"  align="center" visible="true" width="100"  header="交强险/商业险单号">
        <input property="editor" class="nui-textbox" vtype="float" >
        </div>
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

</body>
</html>