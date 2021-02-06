<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>连锁现金收入汇总</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/cashGainTotal.js?v=1.0.2"></script>


    <style>

        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
        .iconStyle{
            font-size: 14px;
            margin-top: 2px;
            position: absolute;
            color:#f0ce25;
        }
        .tipStyle{
            position: absolute; 
            background-color: #595959; 
            color:#fff;
            border-radius: 4px;
            padding:5px 10px 5px 10px;
            opacity:0.9;
            font-size:14px;
            display: none;
            z-index:999;
        }

    </style>
</head>

<body>
        <div id="showDiv" class="tipStyle"></div>
        <div class="nui-toolbar" style="padding:2px;" id="form1">
            <table style="width:100%;">
                <tr>
                    <td>
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
                        <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                        至
                        <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                        <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <!-- <li class="separator"></li> -->
                    </td>
                </tr>
            </table>
        </div>
        
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
            onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
            <div property="columns">
              <div type="indexcolumn" width="40" headerAlign="center" align="center">序号</div>
              <div field="id" name="id" visible="false" width="100" >id</div>
              <div field="orgid" name="orgid" width="100" headerAlign="center" align="center">门店</div>
              <div field="zongAmt" name="zongAmt" width="100" headerAlign="center" align="center">现金总收入</div>
              <div field="repairAmt" name="repairAmt" width="100" headerAlign="center" align="center">工单现金收入</div>
              <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center">计次卡现金收入</div>
              <div field="cardAmt" name="cardAmt" width="300" headerAlign="center" align="center">储值卡现金收入</div>
              <div field="qtAmt" name="qtAmt" width="100" headerAlign="center" align="center">其他现金收入</div>
          </div>
          </div>
          </div>

   
</body>

</html>