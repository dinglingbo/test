<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
    <title>维修归库报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    .title {
       width: 90px;
       text-align: right;
   }

   .title.required {
       color: red;
   }

   .mini-panel-border {
       /*border-right: 0;*/

   }

   .mini-panel-body {
       padding: 0;
   }
</style>
</head>
<body>


	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                    <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                        <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                        <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                        <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                    </ul>
                    <div id="ck1" name="" class="nui-checkbox" readOnly="false" text="显示归库" ></div>
                    <div class="nui-radiobuttonlist"
                    repeatItems="2"
                    id="countWay"
                    width=""
                    style="position: absolute;top: 4px;display: inline-table;"
                    textField="text" valueField="id" value="1" data="[{id:1,text:'领料日期'},{id:2,text:'出厂日期:'}]">
                </div>


                <!-- <label style="font-family:Verdana;">审核日期 从：</label> -->
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="carNo" width="100px" emptyText="车牌号"  class="nui-textbox"/>
                <input id="" width="100px" emptyText="内码"  class="nui-textbox"/>
                <input id="" width="100px" emptyText="配件名称/拼音"  class="nui-textbox"/>
                <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音"  class="nui-textbox"/>
                <input id="partCode" width="100px" emptyText="配件编码"  class="nui-textbox"/>
                <input id="" width="100px" emptyText="配件品质"  class="nui-combobox"/>
                <input id="" width="100px" emptyText="审核状态"  class="nui-combobox"/>

                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
    showPager="true"
    dataField="detailList"
    idField="detailId"
    ondrawcell="onDrawCell"
    sortMode="client"
    url=""
    totalField="page.count"
    pageSize="10000"
    sizeList="[1000,5000,10000]"
    showSummaryRow="true">
    <div property="columns">
        <div type="indexcolumn">序号</div>

            <div header="业务信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="120" headerAlign="center" header="店号"></div>
                    <div allowSort="true" field="" width="120" headerAlign="center" header="内码"></div>
                    <div allowSort="true" field="" width="120" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="" width="60" headerAlign="center" header="品牌编码"></div>
                    <div allowSort="true" field="" width="60" headerAlign="center" header="车身系统分类一级"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车身系统分类二级"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车身系统分类三级"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车辆厂牌"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="业务单号"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="维修顾问"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车牌号"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="数量"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="厂牌"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车型"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="gu"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="车型"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="满足状态"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="审核状态"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="滞销"></div>
                </div>
            </div>

            <div header="领料信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="40" headerAlign="center" header="领料日期"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="领料人"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="操作人"></div>
                </div>
            </div>
            <div header="成本信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="40" headerAlign="center" header="成本单价"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="成本金额"></div>
                </div>
            </div>

            <div header="销售信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="40" headerAlign="center" header="标准销价"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="区域销价"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="销售单价"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="销售金额"></div>
                </div>
            </div>

             <div header="盈利信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="40" headerAlign="center" header="毛利"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="配件毛利率"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="成本率"></div>
                </div>
            </div>

             <div header="归库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="" width="40" headerAlign="center" header="归库标志"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="归库人"></div>
                </div>
            </div>

            <div header="其他信息" headerAlign="center">
                <div property="columns">
                  <div allowSort="true" field="" width="40" headerAlign="center" header="结算状态"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="供应商" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="采购日期"></div>
                    <div allowSort="true" field="" width="40" headerAlign="center" header="维修日期"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
title="高级查询" style="width:416px;height:360px;"
showModal="true"
allowResize="false"
allowDrag="false">
<div id="advancedSearchForm" class="form">
    <table style="width:100%;">
       <tr>
        <td class="title">移仓日期:</td>
        <td>
            <input name="sOrderDate"
            width="100%"
            class="nui-datepicker"/>
        </td>
        <td class="">至:</td>
        <td>
            <input name="eOrderDate"
            class="nui-datepicker"
            format="yyyy-MM-dd"
            timeFormat="H:mm:ss"
            showTime="false"
            showOkButton="false"
            width="100%"
            showClearButton="false"/>
        </td>
    </tr>
    <tr>
        <td class="title">审核日期:</td>
        <td>
            <input name="sAuditDate"
            width="100%"
            class="nui-datepicker"/>
        </td>
        <td class="">至:</td>
        <td>
            <input name="eAuditDate"
            class="nui-datepicker"
            format="yyyy-MM-dd"
            timeFormat="H:mm:ss"
            showTime="false"
            showOkButton="false"
            width="100%"
            showClearButton="false"/>
        </td>
    </tr>
    <tr>
        <td class="title">移仓单号:</td>
        <td colspan="3">
            <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
        </td>
    </tr>
    <tr>
        <td class="title">配件编码:</td>
        <td colspan="3">
            <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
        </td>
    </tr>
    <tr>
        <td class="title">配件名称:</td>
        <td colspan="3">
            <input id="partName"
            name="partName"
            class="nui-textbox" 
            width="100%"/>
        </td>
    </tr>
    <tr>
        <td class="title">业务员:</td>
        <td colspan="3">
            <input id="orderMan"
            name="orderMan"
            class="nui-textbox" 
            width="100%"/>
        </td>
    </tr>
</table>
<div style="text-align:center;padding:10px;">
    <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
</div>
</div>
</div>



</body>
</html>
