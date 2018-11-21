<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:54:29
  - Description:
-->
<head>
<title>进销存报表</title>
<script src="<%=webPath + contextPath%>/manage/js/report/inventoryQuery.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
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
                
                <span class="separator"></span>
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)">未审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)">已审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)">已过帐</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)">全部</a>-->
                <!--<span class="separator"></span>-->
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">分析维度：</label>
                <div class="nui-radiobuttonlist"
                     repeatItems="2"
                     id="countWay"
                     width="500"
                     style="position: absolute;top: 154px;display: inline-table;"
                     textField="text" valueField="id" value="1" data="[{id:1,text:'连锁数据按店分析'},{id:2,text:'本店数据按品牌分析'},{id:3,text:'本店数据按零件类别分析'}]">
                </div>
            </td>
        </tr>
    </table>
</div>
<!--<div class="nui-toolbar" style="padding:2px;border-bottom:0;">-->
    <!--<table style="width:100%;">-->
        <!--<tr>-->
            <!--<td style="width:100%;">-->
                <!--<a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">打印</a>-->
            <!--</td>-->
        <!--</tr>-->
    <!--</table>-->
<!--</div>-->
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="list"
         idField="id"
         sortMode="client"
         frozenStartColumn="0"
         frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="维度" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="name" width="100" headerAlign="center" header="分店名称"></div>
                </div>
            </div>
            <div header="采购" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="purchaseEnter" width="60" headerAlign="center" header="采购入库" align="right"></div>
                    <div allowSort="true" datatype="float" field="purchaseOut" headerAlign="center" header="采购退货" align="right"></div>
                </div>
            </div>
            <div header="维修" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="repairOut" width="60" headerAlign="center" header="出库金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="repairEnter" headerAlign="center" header="归库金额" align="right"></div>
                </div>
            </div>
            <div header="退货" headerAlign="center">
                <div property="columns">
<!--                     <div allowSort="true" datatype="float" field="sellOut" width="60" headerAlign="center" header="出库金额" align="right"></div> -->
                    <div allowSort="true" datatype="float" field="sellEnter" headerAlign="center" header="退货金额" align="right"></div>
                </div>
            </div>
            <div header="移仓" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="allotEnter" width="60" headerAlign="center" header="入库金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="allotOut" headerAlign="center" header="出库金额" align="right"></div>
                </div>
            </div>
            <div header="耗材" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="materialEnter" width="60" headerAlign="center" header="出库金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="materialOut" headerAlign="center" header="归库金额" align="right"></div>
                </div>
            </div>
            <div header="库存" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="beginCount" width="60" headerAlign="center" header="期初金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="endCount" headerAlign="center" header="期末库存金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="currCount" headerAlign="center" header="当前库存金额" align="right"></div>
                </div>
            </div>
            <div header="盘点" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="inventoryProfit" width="60" headerAlign="center" header="盘盈金额" align="right"></div>
                    <div allowSort="true" datatype="float" field="inventoryLoss" headerAlign="center" header="盘亏金额" align="right"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:220px;height:150px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">起始日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
            </tr>
            <tr>
                <td class="title">终止日期:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
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
