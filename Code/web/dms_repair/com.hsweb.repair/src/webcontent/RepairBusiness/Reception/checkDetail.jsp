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
    <title>查车单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/checkDetail.js?v=1.0.9"></script>
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
/* 
    table {

        left: 0;
        right: 0;
        margin: 0 auto;
    }


    #table_A tr {
        height: 40px;
    }

    table tr td span {

        display: inline-block;
    }


    #table_A tr {
        height: 40px;
    }

    table tr td span {

        display: inline-block;
    }

    .tabwidth {
        width: 100%;
    }

    .tbtext {
        float: right;
        line-height: 40px;
    }

    .tbCtrl {
        width: 150px;
    }

    .mini-textbox {
        height: 28px;
    }

    .mini-textbox-border {
        height: 25px;
    }

    .mini-textbox-input {
        输入框的里面的高度
        height: 24px;
    }

    .checkboxwidth {
        width: 65px;
        margin-left: 20px;
    }

    .mini-tabs-header {
        height: 30px;
    }

    .mini-button-text {
        line-height: 26px;
    }




    ////////////////下拉框样式///////////////////////////////

    .mini-buttonedit {
        height: 28px;
    }

    .mini-buttonedit-border {
        height: 25px;
    }

    .mini-buttonedit-input {
        height: 24px;
    }

    .mini-buttonedit-buttons {
        top: 3px;
        right: 10px;
    }

    .mini-buttonedit-button {
        border-left: 0px;
        background: #fff;
    }

    .mini-buttonedit-button-pressed,
    .mini-buttonedit-popup .mini-buttonedit-button {
        background: #fff;
        color: #333333;
        border-width: 0px;
        border-left: 0px;
    }

    .mini-buttonedit-popup .mini-buttonedit-button {
        background: #fff;
        border-width: 0px;
        border-left: 0px;
    }

    .mini-buttonedit-button-hover,
    .mini-buttonedit-hover .mini-buttonedit-button {
        color: #333;
        background: #fff;
        border-width: 0px;
        border-left: 0px;
    }

    ///////////////////////////////////////////////

    .red {
        color: red;
    }

    .right {
        text-align: right;
    }

    .fwidtha {
        width: 120px;
    }

    .fwidthb {
        width: 120px;
    }

    .bt_trWidth {
        width: 170px;
    }

    .textboxWidth {
        width: 100%;
    }

    .htr {
        height: 30px;
    }
    */
    .tmargin {
        margin-top: 10px;
        margin-bottom: 10px;
    }


    .vpanel {
        border: 1px solid #d9dee9;
        margin: 10px 0px 0px 20px;
        width: 39%;
        height: 248px;

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

   <input class="nui-hidden" id="tid" name="tid" value='<b:write property="tid"/>'/>
   <div class="nui-toolbar" style="padding:2px;height:30px">
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

          进场日期:<input class="nui-datepicker tabwidth" />

          预计交车日期:<input class="nui-datepicker tabwidth" />
      </td>     
  </tr>
</table>

</div>


<div class="nui-fit">
    <div id="billForm" class="form">
        <input class="nui-hidden" name="id" />
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="mtAdvisor" id="mtAdvisor"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="carModel"/>
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
                <td class="tbtext">油量:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">当前里程:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth"  name="enterKilometers"/>
                </td>
                <td class="tbtext">下次保养:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
            </tr>
            <tr>
               <td class="tbtext">下次保养日期:</td>
               <td class="tbCtrl">
                <input class="nui-datepicker tabwidth" />
            </td>
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
                <input class="nui-textbox tabwidth" />
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
dataField="list"  allowCellSelect="true" OnCellBeginEdit="OnCellBeginEdit" 
url="com.hsapi.repair.baseData.query.queryCheckModelDetail.biz.ext" 
allowCellEdit="true" ShowHGridLines="false" ShowVGridLines="false" ondrawcell="ondrawcell" >
<div property="columns">
    <div type="indexcolumn" align="center" headerAlign="center" width="30px"><strong>序号</strong></div>
    <div field="id" name="mid" visible="false">id</div>
    <div field="partName" name="partName" width="40" headerAlign="center" align="center"><strong>配件名称</strong></div>
    <div field="status" name="status" width="40" headerAlign="center" align="center"><strong>正常状态</strong></div>
    <div field="statusid" name="status" width="40" headerAlign="center" align="center" visible="false"><strong>正常状态id</strong></div>
    <div field="nostatus" name="nostatus" width="40" headerAlign="center" align="center"><strong>异常状态</strong></div>
    <div field="nostatusid" name="nostatus" width="40" headerAlign="center" align="center" visible="false"><strong>异常状态id</strong></div>
    <div field="remark" name="remark" width="80" headerAlign="center" align="center"><strong>备注</strong>
        <input property="editor" class="nui-combobox" style="width:100%;" 
        textfield="content" valuefield="content"  dataField="list"/>  

    </div>
</div>
</div>


<div class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
        <span>客户描述</span>
    </div>
    <div class="vpanel_body">

        <input class="nui-textarea " style="width:100%;height: 100px;border:0px;" />
    </div>
</div>


<div class="vpanel" style="width:99%;height:100px;margin-left: auto;margin-right: auto;margin-top: 40px;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
        <span>检测照片</span>
    </div>
    <div class="vpanel_body">


    </div>
</div>

<div style="width:100%;margin-top: 10px;">
    <a class="nui-button" onclick="saveDetail()" plain="false">保存</a>
    <a class="nui-button" onclick="" plain="false">退出</a>
</div>
</div>
<script type="text/javascript">
    nui.parse();
    var mainGrid = nui.get("mainGrid");
    var mid = nui.get("tid").value;
    mainGrid.load({mainid:mid});

    function ondrawcell(e) {
/*        var tree = e.sender,
        record = e.record,
        column = e.column,
        field = e.field;
        
        var html1 = '<label class="function-item"><input onclick="'  +'" ' + ' type="radio" name="'+ record.id +'" hideFocus/>' + '正常' + '</label>';
        var html2 = '<label class="function-item" style="margin-left:100px;"><input onclick="'  +'" ' + ' type="radio" name="'+ record.id +'" hideFocus/>' + '异常' + '</label>';

        var html = html1 + html2;
        if (field == 'status') {
            e.cellHtml = html; 
        }    */

    }

    function OnCellBeginEdit(e){ 
        var record = e.record;
        var field = e.field;
        var value = e.value;
        var editor = e.editor;
        if (field == "remark") {
            var id = record.id;
            var url = "com.hsapi.repair.baseData.query.queryCheckModelDetailContent.biz.ext?checkId=" + id;
            editor.setUrl(url);
        } 
    }

    var selected = '<span class="icon-ok" style="display:inline-block;width:20px;text-align:center;margin-left:40%;" onClick="" title="">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
mainGrid.on("cellclick",function(e){
    var field = e.field;
    var record = e.record;
    var column = e.column;
    if(column.field == "status"){

        e.cellHtml = "2";
    }

});


</script>
</body>

</html>