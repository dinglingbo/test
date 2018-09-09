<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 20:50:20 
  - Description:
-->          
    
<head> 
    <title>出库单</title> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/repairOutDetail.js?v=1.0.91"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
    .tbtext {
        float: right;
}

    .vpanel {
        border: 1px solid #d9dee9;
        margin: 10px 0px 10px 0px;
        /* width: 39%;
        height: 248px; */

    }

    .vpanel_heading {
        border-bottom: 1px solid #d9dee9;
        width: 100%;
        height: 28px;
        line-height: 28px;
    }

    .vpanel_heading span {
        margin: 0 0 0 20px;
        font-size: 16px;
        font-weight: normal;
    }

    .vpanel_bodyww {
        padding: 10 10 10 10px !important
    }


    .function-item {
        margin-left: 5px;
        margin-right: 5px;
    } 
</style>
</head>

<body>

    <div class="nui-toolbar" id="toolbar1" style="padding:2px;height:30px">
    <input class="nui-hidden" id="mid" name="mid" value='<b:write property="mid"/>'/>
    <input class="nui-hidden" id="tid" name="tid" value='<b:write property="tid"/>'/>
    <input class="nui-hidden" id="actionType" name="actionType" value='<b:write property="actionType"/>'/>
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td>
                <div class="nui-autocomplete" style="width:200px;"  popupWidth="600" textField="text" valueField="id" 
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
        <td style="text-align:left;">
<!-- 
          进场日期:<input class="nui-datepicker tabwidth" name="enterDate" id="enterDate" />

          预计交车日期:<input class="nui-datepicker tabwidth" name="planFinishDate" id="planFinishDate"/> -->
      </td>     
  </tr>
</table>

</div>


<div class="nui-fit">
    <div id="billForm" class="form">
        <input class="nui-hidden" name="id" id="id" value='<b:write property="actionType"/>'/>
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="mtAdvisor" id="mtAdvisor"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <input class="nui-hidden" name="serviceTypeId"/>
        <table  style=" left:0;right:0;margin: 0 auto;"> 

            <tr>
                <td class="tbtext">车主:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestFullName" id="guestFullName" />
                </td>
                <td class="tbtext">车主电话:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestMobile" id="guestMobile" />
                </td>
                <td class="tbtext">级别:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">会员卡:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth"  name="cardType" id ="cardType"/>
                </td>
                <td class="tbtext">车型:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="carModel" id="carModel"/>
                </td>
            </tr> 
            <tr>
                <td class="tbtext">车牌:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="carNo" id="carNo"/>
                </td>

                <td class="tbtext">VIN码:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" id="carVin" name="carVin"/>
                </td>



            </tr>
            <tr>

            <td class="tbtext">服务顾问:</td>
            <td class="tbCtrl">

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
            <td class="tbtext">服务技师:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="sureMtMan" id="sureMtMan"/>
            </td>
            <td class="tbtext">送修人:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="contactorName" id="contactorName"/>
            </td>
            <td class="tbtext">联系方式:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" " name="mobile" id="mobile" />
            </td>

        </tr>

    </table>
</div>

<div id="mainGrid" class="nui-datagrid" style="width:100%;height:auto;" showPager="false" 
dataField="data"   multiSelect="false" 
url="com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext"  showModified="false"
allowCellEdit="true" >
<div property="columns">
       <div headerAlign="center" type="indexcolumn" width="20">序号</div>
       <div type="checkcolumn"></div> 
        <div header="配件信息">  
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">

                </div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center">
        
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量">

                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价">

                </div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center"  header="优惠率">

                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额">

                </div>
                <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">金额</div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件编码">
                </div>           
                <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center">

                </div>
                <div field="saleManId" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
               
            </div>
        </div>
</div>
</div>


<div id="mainGrid2" class="nui-datagrid" style="width:100%;height:auto;" showPager="false" 
dataField="list"  allowCellSelect="true" multiSelect="true" 
url="com.hsapi.repair.baseData.query.queryCheckModelDetail.biz.ext"  showModified="false"
allowCellEdit="true"  >
<div property="columns">
       <div headerAlign="center" type="indexcolumn" width="20">序号</div>
       <div type="checkcolumn"></div>
        <div header="配件信息">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">

                </div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center">
 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量">

                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价">

                </div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center"  header="优惠率">

                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额">

                </div>
                <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">金额</div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件编码">
                </div>           
                <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center">
 
                </div>
                <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center">
                </div>   
               
            </div>
        </div>
</div>
</div>

<div style="width:100%;margin-top: 10px;">
    <a class="nui-button" onclick="LLSave()" plain="false">领料</a>
    <a class="nui-button" onclick="" plain="false">退货</a>
</div>
</div>

<script type="text/javascript">
    nui.parse();
</script>
</body>

</html>