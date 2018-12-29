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
    <title>客户余额汇总表</title>
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
        .dataDiv{
            width: 100%;
            height: 40px;
            margin: 20px 0px ;
            padding: 0px 20px;
            border-color: #faebcc;
            border: 1px solid transparent;
            /* background-color: #fcf8e3; */
        }
        .dataDivText{
            color: #8a6d3b;
        }
        .dataDivValue{
            color: #ff5b5b !important;
            font-size: 30px;
        }
    </style>
</head>

<body>
        <div id="showDiv" class="tipStyle"></div>


                    
                    <div class="nui-toolbar" style="padding:2px;" id="">
                        <table style="width:100%;">
                            <tr>
                                <td>
                                   
                                    在:
                                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                                    <input class="nui-combobox" style="width: 80px;" data="datacom" textField="name" valueField="id" value="1">
                                    到期
                                    <li class="separator"></li>
                                    <input class="nui-textbox" style="width: 100px;" emptyText="门店">
                                    <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                    <!-- <li class="separator"></li> -->
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="dataDiv">
                            <table style="width:100%;">
                                <tr>
                                    <td>
                                       <span class="dataDivText">系统总余额:</span><span class="dataDivValue">1,015,638,123.08</span>
                                       &nbsp;&nbsp;&nbsp;&nbsp;
                                       <span class="dataDivText">当前筛选结果总余额:</span><span class="dataDivValue">1,003,088,094.89</span>
                                      
                                    </td>
                                </tr>
                            </table>
                        </div>
                    
                    <div class="nui-fit">
                        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                        totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                        onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
                        <div property="columns">
                            <div field="id" name="id" visible="false" width="100" >id</div>
                          <div type="indexcolumn" width="40" headerAlign="center" align="center">客户姓名</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">手机号</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">总余额</div>
                          <div field="" name="" width="100" headerAlign="center" align="center">账户数</div>
                      </div>
                      </div>
                      </div>

         

    <script type="text/javascript">
        var datacom =[{id:1,name:"之后"},{id:2,name:"当天"},{id:3,name:"之前"}];
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