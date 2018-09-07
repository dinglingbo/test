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
    <title>理赔工单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/claimDetail.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/default/common/nui/locale/zh_CN.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/js/repairSvrUtil.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/js/repairUtil.js?v=1.0.9" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/js/constantDef.js?v=1.1" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/js/init.js?v=1.8" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/js/date.js?v=1.2" type="text/javascript"></script>
	<link href="<%= request.getContextPath() %>/common/nui/themes/blue2010/skin.css" rel="stylesheet"	type="text/css" />
	<link href="<%= request.getContextPath() %>/common/nui/themes/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
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
    <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;height:30px">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td>
                <div class="mini-autocomplete" style="width:200px;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo" placeholder="车牌号/客户名称/手机号/VIN码"  searchField="key" 
                    dataField="list" loadingText="数据加载中...">     
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
        <table  style=" left:0;right:0;margin: 0 auto;"> 
            <tr>   
                <td class="title required">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false"/></td>
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
                        nullItemText="请选择..."/>
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
                            nullItemText="请选择..."/>
                </td>
                <td class="title">进厂里程:</td> 
                <td class=""><input  class="nui-textbox" name="enterKilometers"/></td>
                <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark"/></td>
            </tr>
            <tr>   
                <td class="title required">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false"/></td>
                <td class="title required">客户手机:</td> 
                <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false"/></td>
                <td class="title required">送修人名称:</td> 
                <td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" enabled="false"/></td>
                <td class="title required">送修人手机:</td> 
                <td class=""><input  class="nui-textbox" name="mobile" id="mobile" enabled="false"/></td>
                <td class="title">开单时间:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false" format="yyyy-MM-dd H:mm:ss"
                    class="nui-datepicker" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
                    <div class="nui-fit">
                        <div class="" style="width:100%;height:auto;" >
                            <div style="width:100%;height:5px;"></div>
                            
    

<div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     showModified="false"
     allowSortColumn="false">
    <div property="columns">
        <div headerAlign="center" field="orderIndex" width="25" align="right">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div field="prdtName" headerAlign="center" allowSort="false"
                     visible="true" width="100" header="套餐名称">
                </div>
                <div field="serviceTypeId" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="业务类型" align="center">
                     <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="subtotal" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center">
                     <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="rate" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="优惠率" align="center">
                     <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="施工员">
                    <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="true" oncloseclick="onCloseClick" onvaluechanged="onworkerChanged" >     
                </div>
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="施工员" align="center">
                </div>                
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
                <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择套餐</a>
    </span>
</div>
<div id="packageDetailGridForm" style="display:none;">
    <div id="packageDetailGrid" class="nui-datagrid"
         style="width: 100%; "
         dataField="list"
         showPager="false"
         selectOnLoad="true"
         allowSortColumn="true">
        <div property="columns">
            <div field="typeName" headerAlign="center" allowSort="false"
                 visible="true" width="60">类型
            </div>
            <div field="name" headerAlign="center"
                 allowSort="false" visible="true" width="">名称
            </div>
            <div field="qty" headerAlign="center"
                 allowSort="false" visible="true" width="80">工时/数量
            </div>
            <div field="remark" headerAlign="center"
                 allowSort="false" visible="true" width="80">备注
            </div>
        </div>
    </div>
</div>
    



                            <div style="width:100%;height:5px;"></div>
                            
    
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="工时信息">
            <div property="columns">
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="100">工时名称</div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="itemTime" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时单价
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" numberFormat="p">优惠率
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">工时金额
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="80" header="施工员">
                    <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="true" oncloseclick="onCloseClick" onvaluechanged="onitemworkerChanged" >     
                    <!-- <div property="columns">
                        <div header="ID" field="id"></div>
                        <div header="名称" field="empName"></div>
                    </div> -->
                </div>
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="施工员" align="center">
                </div>                
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onitemsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div> 
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择工时</a>
    </span>
</div>
    



                            <div style="width:100%;height:5px;"></div>
                            
    
<div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true">
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="配件信息">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">
                    <!-- <input property="editor" class="nui-textbox" emptyText="配件编码、名称、拼音" /> -->
                </div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center">
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" numberFormat="p" header="优惠率">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center" header="金额">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">金额</div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件编码">
                </div>           
                <div field="saleMan" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="销售员" align="center">
                     <input  property="editor" enabled="true" dataField="memList" 
                             class="nui-combobox" valueField="empName" textField="empName" data="memList"
                             url="" onvaluechanged="onpartsalemanChanged" emptyText=""  vtype="required"/> 
                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
                <div field="partOptBtn" name="partOptBtn" width="100" headerAlign="center" header="操作" align="center" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择配件</a>
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
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
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
                
                        <div id="bottomPanel" class="nui-panel" title="其他" iconCls="" style="width:100%;height:100px;" 
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
        <div style="width:100%;margin-top: 10px;text-align: center;">
            <a class="nui-button" onclick="save()" plain="false">保存</a>

            <a class="nui-button" onclick="" plain="false">价参</a>
        </div>
    </div>
    <script type="text/javascript">
        nui.parse();
    </script>
</body>

</html>