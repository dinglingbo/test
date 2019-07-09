<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/sysCommon.jsp"%>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): Administrator 
  - Date: 2018-03-21 09:13:58
  - Description:
-->

        <head>
            <title>首页</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%=webPath + contextPath%>/common/Index/TextIndex.js?v=1.3.13"></script>
            <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
            <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
            <link href="<%=request.getContextPath()%>/common/Index/TextIndex.css?v=1.0.5" rel="stylesheet" type="text/css" />
            <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
            <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<%--             <script src="<%=webPath + contextPath%>/common/js/jquery-1.11.3.min.js?v=1.0.3"></script>
			<script src="<%=webPath + contextPath%>/common/js/jquery.dad.min.js?v=1.0.3"></script> --%>
            <style type="text/css">
            </style>
        </head>

        <body>
            <div class="nui-fit" >
				<div class="nui-fit" style="height: 125px !important;">
				              <div class="vpanel_heading">
                                <i class="fa fa-th-list fa-lg-custom fa-fw"></i>
                                <span>快捷菜单</span>                              
                            </div>
                <div  class="nui-fit" style="white-space: nowrap;height: 125px !important;overflow-y:hidden;overflow-x:auto;padding:0px 0px 0px 0px;" id="demo" >

                </div>            
				</div>
                <div id="" class="main" style="margin-top: 15px;height: 205px;">

                    <div id="" class="main_child_left">
                        <div class="vpanel">
                            <div class="vpanel_heading">
                                <i class="fa fa-th-list fa-lg-custom fa-fw"></i>
                                <span>销售机会</span>
                                <i class="fa fa-refresh fa-lg-custom fa-fw" style="float:right;margin-right:10px;"></i>
                            </div>
                            <div class="nui-fit">
                                <div class="nui-fit">
                                    <div style="padding:0px 0px 0px 0px;">
                                        <table id="table1">

                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>预约到店提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryAppointment" href="javascript:bookingMgr()" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td style="width:0.05%;"></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>保养到期提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryMaintain" href="javascript:toMaintain(8)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>商业险到期提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryBusiness" href="javascript:toMaintain(3)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td style="width:0.05%;"></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>交强险到期提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryCompulsoryInsurance" href="javascript:toMaintain(4)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>驾照年审提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryDrivingLicense" href="javascript:toMaintain(5)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>车辆年检提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryCar" href="javascript:toMaintain(6)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>客户生日提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryGuestBirthday" href="javascript:toMaintain(7)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>员工生日提醒：</td>
                                                <td class="tablenum">
                                                    <a id="queryEmployeeBirthday" href="javascript:toMaintain(2)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="" style="float:left;width: 1%;height: 100%;"> </div>

                      <div id="" class="main_child">
                        <div class="vpanel">
                            <div class="vpanel_heading">
                                <i class="fa fa-eye fa-lg-custom fa-fw"></i>
                                <span>
                                    <a onclick="showGuestBoard()" style="cursor: pointer;">客户休息区看板</a>丨
                                    <a onclick="showWorkShopBoard()" style="cursor: pointer;">维修车间看板</a>丨
                                    <a onclick="showPartLogisticsBoard()" style="cursor: pointer;">配件物流看板</a>
                                </span>
                            </div>
                            <div class="nui-fit">
                                <div class="nui-fit">
                                    <div id="guestBoardGrid" dataField="data" class="nui-datagrid" style="width:100%;height:100%;" borderstyle="border:0;" showColumns="true"
                                        showpager="false">
                                        <div property="columns">
                                            <div field="carNo" name="business" width="80px" headeralign="center" align="center">
                                                <strong>车牌号</strong>
                                            </div>
                                            <div field="enterDate" name="enterDate" width="120px" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" align="center">
                                                <strong>进厂时间</strong>
                                            </div>
                                            <div field="planFinishDate" name="planFinishDate" width="120px" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" align="center">
                                                <strong>预计交车时间</strong>
                                            </div>
                                            <div field="status" name="status" width="80px" headeralign="center" align="center">
                                                <strong>施工状态</strong>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="workShopBoardGrid" class="nui-datagrid" style="width:100%;height:100%;display: none;" borderstyle="border:0;" showColumns="true"
                                        showpager="false">
                                        <div property="columns">
                                            <div field="business" name="business" width="80px" headeralign="center" align="center">
                                                <strong>车牌号</strong>
                                            </div>
                                            <div field="custom" name="custom" width="120px" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" align="center">
                                                <strong>接车时间</strong>
                                            </div>
                                            <div field="address" name="address" width="120px" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" align="center">
                                                <strong>预计完工时间</strong>
                                            </div>
                                            <div field="business" name="business" width="80px" headeralign="center" align="center">
                                                <strong>服务顾问</strong>
                                            </div>
                                            <div field="business" name="business" width="80px" headeralign="center" align="center">
                                                <strong>施工员</strong>
                                            </div>
                                            <div field="status" name="status" width="80px" headeralign="center" align="center">
                                                <strong>项目进度</strong>
                                            </div>
                                            <div field="status" name="status" width="80px" headeralign="center" align="center">
                                                <strong>施工状态</strong>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="clear: both"></div>
                    <!-- 注释：清除float产生浮动 -->
                </div>

                <div id="" class="main" style="margin-top: 15px;height:150px;">


                    <div id="" class="main_child_left">
                        <div class="vpanel" style="height:302px;">
                            <div class="vpanel_heading">
                                <i class="fa fa-bullhorn fa-lg-custom fa-fw"></i>
                                <span>今日数据</span>
                                <!-- <span style="float:right;margin-right:10px;font-size: 13px;">
                        <a onclick="" style="cursor: pointer;">总览</a>丨
                        <a onclick="" style="cursor: pointer;">分类</a>
                    </span> -->
                            </div>
                            <div class="nui-fit">
                                <div class="nui-fit">
                                    <div style="padding:10px 10px 10px 10px;">
                                        <table id="table1" style="margin-left:0px;">
                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>首修车辆：</td>
                                                <td class="tablenum">
                                                    <a id="newCarQty" href="javascript:toMaintain(12)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td style="width:0.05%;"></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>今日进厂：</td>
                                                <td class="tablenum">
                                                    <a id="recordBillQty" href="javascript:toMaintain(9)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>结算车次：</td>
                                                <td class="tablenum">
                                                    <a id="settleQty" href="javascript:toMaintain(10)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>在修车辆：</td>
                                                <td class="tablenum">
                                                    <a id="serviceBillQty" href="javascript:toMaintain(11)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>预约车辆：</td>
                                                <td class="tablenum">
                                                    <a id="bookingBillQty" href="javascript:toMaintain(13)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                                <td></td>
                                                <td class="tabletext">
                                                    <i class="fa fa-cube fa-lg-custom fa-fw"></i>营业额：</td>
                                                <td class="tablenum">
                                                    <a id="receiveAmt" href="javascript:toMaintain(14)" style="color: #61acc9;">
                                                        <span></span>
                                                    </a>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="" style="float:left;width: 1%;height: 100%;"> </div>


                    <div id="" class=" main_child">
                        <div class="vpanel">
                            <div class="vpanel_heading">
                                <i class="fa fa-user fa-lg-custom fa-fw"></i>
                                <span>客户数据</span>
                                <span style="float:right;margin-right:10px;font-size: 13px;">
                                    <a onclick="showOrgGuestCar()" style="cursor: pointer;">本店</a>丨
                                    <a onclick="showTenantGuestCar()" style="cursor: pointer;">连锁</a>
                                </span>
                            </div>
                            <div class="nui-fit">
                                <div id="Ranking" style="height:95%;width:95%;display: none;" title="图"> </div>
                                <table id="tableInfo" style="margin-left:20px;margin-top:10px;">
                                    <tr>
                                        <td class="tabletext">
                                            <i class="fa fa-users fa-5x">
                                        </td>
                                        <td class="tablenumb">
                                            <p>今日新增客户：&nbsp;&nbsp;&nbsp;
                                                <span id="addGuestQty">0</span>人</p>
                                            <p>客户总数：&nbsp;&nbsp;&nbsp;
                                                <span id="guestQty">0</span>人</p>
                                        </td>
                                        <td style="width:0.05%;">

                                        </td>
                                        <td class="tabletext">
                                            <i class="fa fa-car fa-5x"></i>
                                        </td>
                                        <td class="tablenumb">
                                            <p>今日新增车辆：&nbsp;&nbsp;&nbsp;
                                                <span id="addCarQty">0</span>辆</p>
                                            <p>车辆总数：&nbsp;&nbsp;&nbsp;
                                                <span id="carQty">0</span>辆</p>
                                        </td>
                                    </tr>


                                </table>
                            </div>
                        </div>

                        <div class="vpanel">
                            <div class="vpanel_heading">
                                <i class="fa fa-lightbulb-o fa-lg-custom fa-fw"></i>
                                <span>新闻公告</span>
                            </div>
                            <div class="nui-fit">
                                <div class="nui-fit">
                                    <div style="padding:10px 10px 10px 10px;">
                                        <ul id="newul" class="newul">
                                            <!-- <li><a target="_blank" href="https://baike.baidu.com/item/%E4%B8%8A%E6%B5%B7%E4%BD%B3%E9%85%8D%E7%94%B5%E5%AD%90%E5%95%86%E5%8A%A1%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/18239743">
                            <i class="fa fa-hand-o-right fa-fw"></i>
                            	 马牌CT1167促销，300送30
                        	</a>
                        </li>
                       <li >
                       		<a target="_blank" href="https://baike.baidu.com/item/%E4%B8%8A%E6%B5%B7%E4%BD%B3%E9%85%8D%E7%94%B5%E5%AD%90%E5%95%86%E5%8A%A1%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/18239743"><i class="fa fa-hand-o-right fa-fw"></i>小糸灯具促销（不享受客户年度合同返利）</a>
                       </li>
                       <li >
                       		<a target="_blank" href="http://www.baidu.com"><i class="fa fa-hand-o-right fa-fw"></i>12灯具热系统促销</a>
                       	</li>
                       <li >
                       		<a target="_blank" href="https://baike.baidu.com/item/%E4%B8%8A%E6%B5%B7%E4%BD%B3%E9%85%8D%E7%94%B5%E5%AD%90%E5%95%86%E5%8A%A1%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/18239743"><i class="fa fa-hand-o-right fa-fw"></i>马勒变速箱滤芯器5点促销</a>
                       </li>
                       <li >
                       		<a target="_blank" href="https://baike.baidu.com/item/%E4%B8%8A%E6%B5%B7%E4%BD%B3%E9%85%8D%E7%94%B5%E5%AD%90%E5%95%86%E5%8A%A1%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/18239743"><i class="fa fa-hand-o-right fa-fw"></i>隆丰滞销处理（不享受客户年度合同返利）</a>
                       </li> -->

                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>

                   

            
                    <div style="clear: both"></div>
                    <!-- 注释：清除float产生浮动 -->
                </div>


            </div>
            <script type="text/javascript">
                nui.parse();
            </script>
        </body>

        </html>