<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-03-21 09:13:58
  - Description:
-->
<head>
  <title>首页</title>
  <script src="<%=webPath + contextPath%>/purchase/js/indexCloudPart.js?v=1.5.14"></script>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/purchase/css/cloudIndex.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
        #nuifit {
            height: 125px !important;
        }

        .box {
            width: 28px;
            height: 20px;
            background-color: red;
            text-align: center;
            border-top-left-radius: 20px;
            border-top-right-radius: 25px;
            border-bottom-right-radius: 25px;
            border-bottom-left-radius: 0px;
            position: absolute;
            margin-top: -14px;
            margin-left: 130px;
        }

        .daBox {
            width: 100%;
            height: 100%;
            cursor: pointer;
            margin-left: 20px;
            margin-top: 16px;
            position: relative;
            float: left;
        }

        em.emarrow {
            color: #E6E6E6;
            font-size: 40px;
        }

        span.arrow {
            color: #E6E6E6;
            font-size: 40px;
        }

        .shu {
            color: #f2f5f7;
            font-size: 12px;
            margin-top: 2px;
        }

        .icon {
            width: 30px;
            height: 50px;
            position: relative;
            float: left;
            margin-right: 10px;
        }
    </style>
</head>
<body> 
    <div class="nui-fit">

        <div class="nui-fit" id="nuifit">
            <div class="vpanel_heading" id="demoFather">
                <i class="fa fa-th-list fa-lg-custom fa-fw"></i>
                <span>快捷菜单</span>
                <!-- 	                    	<div class="menu_pannel menu_pannel_bg" style="background-color: #1faeff;width: 90px;height: 50px;float: left;margin-top: 10px;margin-left: 10px;border-radius: 12px;">
                        <div class="menu_pannel menu_pannel_bg" style="width: 90px;height: 40px;float: left;margin-top: 10px;border-radius: 12px;">	
                            <a onclick="tojump()" style="width: 50px;height: 60px;">
                                <i class="fa fa-file-code-o fa-2x  fa-inverse" style="margin-top: 10px;margin-left: 10px;"></i>
                            </a>
                        </div>
                        <p align="center" style="margin-top: 50px;">综合开单</p>                          
                    </div> -->
            </div>
            <div class="nui-fit" style="white-space: nowrap;height: 125px !important;overflow-y:hidden;overflow-x:auto;padding:0px 0px 0px 0px;"
                id="demo">

            </div>
        </div>

        

        <div style="clear: both"></div>
        <!-- 注释：清除float产生浮动 -->
    

    <div  id="" class="main" style="margin-top: 15px;height: 205px;">

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" >
                    <i class="fa fa-eye fa-lg-custom fa-fw"></i><span>今日工作看板</span>
                    <div class="refresh_button">
                        <a onclick="loadWorkBoard()">
                           <i class="fa fa-refresh fa-lg"></i> 
                        </a>
                    </div>
                </div>
                <div class="nui-fit">
                    <div class="nui-fit"> 
                        <div id="gridWorkBoard" class="nui-datagrid" style="width: 100%; height: 100%;" borderstyle="border:0;" showColumns="false" showpager="false" dataField="list" ondrawcell="onDrawCell"> 
                            <div property="columns">
                                <div field="id" name="id" visible="false" ></div>
                                <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
                                <div field="orderTypeId" name="orderTypeId" width="80px" headeralign="center" ><strong>订单类型</strong></div>
                                <div field="shortName" name="shortName" width="80px" headeralign="center" ><strong>客户/供应商</strong></div>
                                <div field="fullName" name="shortName" width="80px" headeralign="center" ><strong>客户全称/供应商全称</strong></div>
                                <div field="addr" name="addr" width="80px" headeralign="center" ><strong>地址</strong></div>
                                <div field="auditDate" name="auditDate" dateFormat="H:mm" width="80px" headeralign="center" ><strong>时间</strong></div>
                                <div field="billStatusId" name="billStatusId" width="80px" headeralign="center" ><strong>状态</strong></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" >
                    <i class="fa fa-th-list fa-lg-custom fa-fw"></i> <span >待办事项</span>
                    <div class="refresh_button">
                        <a onclick="queryBusinessRemindData(setGridWaitDoData)">
                           <i class="fa fa-refresh fa-lg"></i> 
                        </a>
                    </div>
                </div>
                <div class="nui-fit">
                    <div class="nui-fit" >
                        <div class="shadeDiv" id="shadeWaitDo">
                            <div id="gridWaitDo" class="nui-datagrid" style="width: 100%; height: 100%;font-weight: 600;" borderstyle="border:0;" showColumns="false" showpager="false" showModified="false"> 
                                <div property="columns">
                                    <div field="id" name="id" visible="false" ></div>
                                    <div field="business1" name="business1" width="80px" headeralign="center" ><strong>订单</strong></div>
                                    <div field="num1" name="num1" width="80px" headeralign="center" ><strong>数量</strong></div>
                                    <div field="business2" name="business2" width="80px" headeralign="center" ><strong>订单</strong></div>
                                    <div field="num2" name="num2" width="80px" headeralign="center" ><strong>数量</strong></div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="clear: both"></div>
    <!-- 注释：清除float产生浮动 -->


    <div  id="" class="main" style="margin-top: 15px;">

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" > 
                    <i class="fa fa-bar-chart fa-lg-custom fa-fw"></i><span >本季度业务员销售排名</span>
                    <div class="refresh_button">
                        <a onclick="showMain()">
                        <i class="fa fa-refresh fa-lg"></i> 
                        </a>
                    </div>
                </div>
                <div class="nui-fit">
                    <div id="Ranking" style="height:95%;width:95%;" title="本季度业务员销售排名"> </div>
                </div>
            </div> 
        </div>  

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" >
                    <i class="fa fa-bars fa-lg-custom fa-fw"></i><span>今日数据</span>
                    <div class="refresh_button">
                        <a onclick="queryTargetDataRemindData(setGridTargetDataData)">
                            <i class="fa fa-refresh fa-lg"></i> 
                        </a>
                    </div>
                </div>
                <div class="nui-fit">
                    <div class="nui-fit" > 
                        <div style="padding:10px 10px 10px 10px;" id="targetDataMindForm">
                            <table id="table1" style="margin-left:0px;">
                                <tr>  
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>今日收入：</td>
                                    <td class="tablenum" name="todayReceive"><span id="todayReceive">0</span></td>
                                    <td style="width:0.05%;"></td>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>今日支出：</td>
                                    <td class="tablenum" name="todayPay"><span id="todayPay">0</span></td>
                                </tr>

                                <tr>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>库存总成本：</td>
                                    <td class="tablenum" name="stockAmt"><span id="stockAmt">0</span></td>
                                    <td ></td>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>库存SKU种类：</td>
                                    <td class="tablenum" name="stockPartItem"><span id="stockPartItem">0</span></td>
                                </tr>


                                <tr>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>客户欠款：</td>
                                <td class="tablenum" name="clientNeedReceive"><span id="clientNeedReceive">0</span></td>
                                <td ></td>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>供应商欠款：</td>
                                <td class="tablenum" name="supplierNeedPay"><span id="supplierNeedPay">0</span></td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

    <div style="clear: both"></div>
    <!-- 注释：清除float产生浮动 -->
    </div>


</div>

</body>
</html>