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
    <title>工单-销售单</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/returnBill.js?v=1.3.6"></script>
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
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
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
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="add"> <span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> 
                <a class="nui-button" iconCls="" plain="true" onclick="saveBatch()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="finish"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="sellBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                
 
                <a class="nui-button" plain="true" id="menuprint" onclick="onPrint(5)"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                 <!-- <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(5)" id="type11">打印领料单</li>
                </ul>  -->
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
        <input class="nui-hidden" name="addr" />
        <input class="nui-hidden" name="serviceCode" />
        <table  style="width: 100%;border-spacing: 0px 5px;"> 
            <tr>   
                <td class="title required">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%"/></td>
                <td class="title required">客户手机:</td> 
                <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false" width="100%"/></td>
                <td class="title ">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
                  <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark" width="100%"/></td>
            </tr>
            <tr> 
                 <td class="title required">
                    <label>退货员：</label>
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
<!--                 <td class=""><input  class="nui-textbox" name="recorder" id="recorder" enabled="false"/></td> -->
                 <td class="title ">联系人名称:</td> 
                <td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" enabled="false" width="100%"/></td>
                <td class="title ">联系人手机:</td> 
                <td class=""><input  class="nui-textbox" name="mobile" id="mobile" enabled="false" width="100%"/></td>
                <td class="title">退货日期:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false" format="yyyy-MM-dd hh:MM"
                    class="nui-datepicker" enabled="false" width="100%"/>
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
                        nullItemText="请选择..." visible="false" width="100%"/>
                </td>
            </tr>
        </table>
    </div>
       
    <div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true"
     allowCellSelect="true"
     allowCellEdit="true"
     oncellcommitedit="onCellCommitEdit"
     ondrawsummarycell="onDrawSummaryCell"
     >
   <!--   <div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     showModified="false"
     allowSortColumn="false"
     oncellcommitedit="onCellCommitEdit"

     > -->
     
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="配件信息" headerAlign="center">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">
                </div>
                
                <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码">
                </div>           
                <div field="unitPrice"  width="60" headerAlign="center" header="单价">
                   <!-- <input property="editor" vtype="float" class="nui-textbox"/> -->
                </div>
                <div field="amt" summaryType="sum"  width="60" headerAlign="center" header="金额"></div>
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="退货员" align="center">
                     <input  enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onpartsalemanChanged" emptyText=""  vtype="required" property="editor" /> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>  
                 <div field="qty" summaryType="sum"  width="60" headerAlign="center" header="退货数量" >
                   <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="partOptBtn" name="partOptBtn" width="100" headerAlign="center" header="操作" align="center" align="center"></div>
            </div>
        </div>
    </div>
 </div>
 <div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseReturnPart()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择配件</a>
    </span>
</div>
<div id="advancedMorePartWin" class="nui-window"
     title="" style="width:450px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="1"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="OEM码"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="配件全称"></div>
              </div>
          </div>
    </div>
 </div> 
</div> 
  
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>