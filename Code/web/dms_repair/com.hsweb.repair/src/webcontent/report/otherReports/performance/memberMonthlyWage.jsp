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
    <title>员工月工资报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>

    <%@include file="/common/commonRepair.jsp"%>
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
        <div class="nui-toolbar" style="padding:2px;" id="queryForm">
            <table style="width:100%;">
                <tr>
                    <td>
                       
                        结算年月:
                     
                        <input class="nui-combobox" style="widows: 50px;" emptyText="年">
                        <input class="nui-combobox" style="widows: 50px;" emptyText="月">
                        <a class="nui-button" plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <!-- <li class="separator"></li> -->
                    </td>
                </tr>
            </table>
        </div>
        
        <div class="nui-fit">
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
            onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
            <div property="columns">
              <div type="indexcolumn" width="40" headerAlign="center" align="center">序号</div>
              <div field="id" name="id" visible="false" width="100" >id</div>
              <div field="" name="" width="100" headerAlign="center" align="center">员工</div>
              <div field="" name="" width="100" headerAlign="center" align="center">基本工资</div>
              <div field="" name="" width="100" headerAlign="center" align="center">技师提成</div>
              <div field="" name="" width="100" headerAlign="center" align="center">销售提成</div>
              <div field="" name="" width="100" headerAlign="center" align="center">服务顾问提成</div>
              <div field="" name="" width="100" headerAlign="center" align="center">评价加成</div>
              <div field="" name="" width="100" headerAlign="center" align="center">合计</div>
          </div>
          </div>
          </div>

    <script type="text/javascript">
        nui.parse();
        var con8='这是一个提示';


        function overShow(e,con) {
            var showDiv = document.getElementById('showDiv');
            var pos = e.getBoundingClientRect();
            $("#showDiv").css("top", pos.bottom); //设置提示div的位置
            $("#showDiv").css("left", pos.right);
            showDiv.style.display = 'block';
            showDiv.innerHTML = con;
        }

        function outHide() {
            var showDiv = document.getElementById('showDiv');
            showDiv.style.display = 'none';
            showDiv.innerHTML = '';
        }


    </script>
</body>

</html>