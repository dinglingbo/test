<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-20 08:59:17
  - Description:
-->
<head>
<title>计次卡流水汇总</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/js/report/storeReport/cardTimesRunningWaterSummary.js?v=1.1.3"></script>
        <link href="http://127.0.0.1:8080/default/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="http://127.0.0.1:8080/default/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
        <style>
            .parent{display:flex;}
        .column{flex:1;border-radius:10px;background-color:#B0D6F9;margin-top:20px;padding:10px;}
        .column+.column{margin-left:20px;} 
        .incomeTitle{
            margin: 10px 0px 0px 5px;
            color: #23c0fa;
            font-size:18px;
            font-weight: normal;
        }
        .incomeStyle{
            margin: 10px 0px 0px 0px;
            text-align: left;
    		margin-left: 50px;
            color: #bf740994 ;
            font-size:18px;
        }
        .incomeStyle2{
            margin: 10px 0px 0px 0px;
            text-align: left;
    		margin-left: 50px;
            color: #bf740994 ;
            font-size:18px;
            cursor: pointer;
        }
		p:hover{color: #f5940b;}

        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
    </style>
</head>
 <div id="form1" class="mini-toolbar" style="padding:10px;">
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
     结算日期:
     <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
     <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
     <a class="nui-button" iconcls=""  name="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
 </div>
    <div style="height: 150px;" class="parent">

        <div class="column">
            <h3 class="incomeTitle">期初</h3>
            <p class="incomeStyle" >金额：<span id="pdata1">0.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">收入</h3>
            <p class="incomeStyle2" onclick="queryMX(6)">金额：<span id="pdata2">0.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">支出</h3>
            <p class="incomeStyle2" onclick="queryMX(0)">抵扣：<span id="pdata3">0.00</span></p>
            <p class="incomeStyle2" onclick="queryMX(7)">退款：<span id="pdata4">0.00</span></p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">期末</h3>
            <p class="incomeStyle">金额：<span id="pdata5">0.00</span></p>
        </div>


    </div>
    
        <div style="border-bottom:1px solid #ccc;margin-top: 20px;">
        <span class="titleText"> 计次卡明细</span>
    </div>
    <div class="nui-fit">
                <div id="grid1" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="500" dataField="data"  sizeList=[500,1000,2000]
                    selectOnLoad="true" sortMode="client" showReloadButton="false" showPagerButtonIcon="true" totalField="page.count" showSummaryRow = "true"
                    allowSortColumn="true" >
                    <div property="columns">
                        <div field="id" name="id" headerAlign="center"  visible="false" width="">id </div>
                        <div field="billServiceId" name="billServiceId" headerAlign="center"  visible="true" width="130" id="updStatus" summaryType="count">单号</div>
                        <div field="billTypeId" name="billTypeId" headerAlign="center"  visible="true" width="80">类型</div>
                        <div field="guestName"  name="guestName"headerAlign="center"  visible="true" width="80">客户名称 </div>
                        <div field="carNo" name="carNo" headerAlign="center"  visible="true" width="130">车牌号 </div>
                        <div field="prdtName" name="prdtName" headerAlign="center"   visible="true" width="100">名称</div>

                      	<div field="times"  name="times" headerAlign="center"   visible="true" width="100" summaryType="sum">次数</div>
                        <div field="sellPrice" name="sellPrice" headerAlign="center"  visible="true" width="80" summaryType="sum">金额</div>                              
                        <div field="creator" name="creator" headerAlign="center"  visible="true" width="100">创建人 </div>
                        <div field="createDate"  name="createDate" headerAlign="center"  dateformat="yyyy-MM-dd HH:mm" visible="true" width="100">创建日期</div>

                    </div>
                </div>
    </div>
</html>