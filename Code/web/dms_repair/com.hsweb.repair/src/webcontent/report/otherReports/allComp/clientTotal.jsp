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
    <title>连锁客户汇总</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=webPath + contextPath%>/repair/js/report/storeReport/clientTotal.js?v=1.0.1"></script>
    
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
  
        
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
            onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true showSummaryRow="true" >
            <div property="columns">
              <div type="indexcolumn" width="40" headerAlign="center" align="center">序号</div>
              <div field="id" name="id" visible="false" width="100" >id</div>
              <div field="shortName" name="shortName" width="100" headerAlign="center" align="center">门店</div>
              <div field="guestTotal" name="guestTotal" width="100" headerAlign="center" align="center" summaryType="sum">客户数量</div>
              <div field="balaAmtTotal" name="balaAmtTotal" width="100" headerAlign="center" align="center" summaryType="sum">余额统计</div>
              <div field="canUseTimesTotal" name="canUseTimesTotal" width="300" headerAlign="center" align="center" summaryType="sum">剩余套餐统计</div>
              <div field="amtTotal" name="amtTotal" width="100" headerAlign="center" align="center" summaryType="sum">剩余套餐余额</div>
          </div>
          </div>
          </div>
</body>

</html>