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
    <script src="<%=webPath + contextPath%>/common/Index/TextIndex.js?v=1.5.27"></script>
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/common/Index/TextIndex.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/echarts.min.js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <style type="text/css">          

</style>
</head>
<body> 
    <div class="nui-fit">
        <div  id="" class="main" style="margin-top: 15px;height:250px !important;">

            <div  id=""  class="main_child_left"> 
                <div class="nui-fit"> 

                  <div  id="menu1" class="demo"  style="">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toRepairBill()">
                            <i class="fa fa-wrench fa-4x  fa-inverse"></i>
                            <p>综合开单</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCarWashBill()">
                            <i class="fa fa-shower fa-4x  fa-inverse"></i> 
                            <p>洗车开单</p> 
                        </a>
                    </div> 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toSellBill()">
                            <i class="fa fa-cart-plus fa-4x  fa-inverse"></i>
                            <p>销售开单</p> 
                        </a> 

                    </div>
 
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCarInsuranceDetail()">
                            <i class="fa fa-unlock-alt fa-4x  fa-inverse"></i>
                            <p>保险开单</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toRepairOut()">
                            <i class="fa fa-arrow-up fa-4x  fa-inverse"></i>
                            <p>维修出库</p> 
                        </a>
                    </div>
                </div>

                <div  id="menu2" class="demo"  style="margin-top:20px;">
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toTimesCardList()">
                            <i class="fa fa-gift fa-4x  fa-inverse"></i>
                            <p>计次卡销售</p> 
                        </a> 
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCardList()">
                            <i class="fa fa-user-o fa-4x  fa-inverse"></i>
                            <p>储值卡充值</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toVisitMain()">
                            <i class="fa fa-handshake-o fa-4x  fa-inverse"></i>
                            <p>工单回访</p> 
                        </a>
                    </div>
                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toPurchaseOrderMain()">
                            <i class="fa fa-copy fa-4x  fa-inverse"></i>
                            <p>采购订单</p> 
                        </a>
                    </div>

                    <div class="menu_pannel menu_pannel_bg">
                        <a onclick="toCustomerProfileMain()">
                            <i class="fa fa-car fa-4x  fa-inverse"></i>
                            <p>车辆新建</p> 
                        </a>
                    </div>
                </div>
            </div> 
        </div>

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" >
                    <i class="fa fa-eye fa-lg-custom fa-fw"></i>
                <span >
                    <a onclick="showGuestBoard()" style="cursor: pointer;">客户休息区看板</a>丨
                    <a onclick="showWorkShopBoard()" style="cursor: pointer;">维修车间看板</a>
                </span>
                </div>
                <div class="nui-fit">
                    <div class="nui-fit"> 
                        <div id="guestBoardGrid" dataField="data" class="nui-datagrid" style="width:100%;height:100%;" borderstyle="border:0;" showColumns="true" showpager="false" > 
                            <div property="columns">
                                <div field="carNo" name="business" width="80px" headeralign="center" align="center"><strong>车牌号</strong></div>
                                <div field="recordDate" name="recordDate" width="120px" dateFormat="yyyy-MM-dd H:mm" headeralign="center" align="center"><strong>接车时间</strong></div>
                                <div field="planFinishDate" name="planFinishDate" width="120px" dateFormat="yyyy-MM-dd H:mm" headeralign="center" align="center"><strong>预计完工时间</strong></div>
                                <div field="status" name="status" width="80px" headeralign="center" align="center"><strong>施工状态</strong></div>
                            </div>
                        </div>
                        <div id="workShopBoardGrid" class="nui-datagrid" style="width:100%;height:100%;display: none;" borderstyle="border:0;" showColumns="true" showpager="false" > 
                            <div property="columns">
                                <div field="business" name="business" width="80px" headeralign="center" align="center"><strong>车牌号</strong></div>
                                <div field="custom" name="custom" width="120px" dateFormat="yyyy-MM-dd H:mm" headeralign="center" align="center"><strong>接车时间</strong></div>
                                <div field="address" name="address" width="120px" dateFormat="yyyy-MM-dd H:mm" headeralign="center" align="center"><strong>预计完工时间</strong></div>
                                <div field="business" name="business" width="80px" headeralign="center" align="center"><strong>服务顾问</strong></div>
                                <div field="business" name="business" width="80px" headeralign="center" align="center"><strong>施工员</strong></div>
                                <div field="status" name="status" width="80px" headeralign="center" align="center"><strong>项目进度</strong></div>
                                <div field="status" name="status" width="80px" headeralign="center" align="center"><strong>施工状态</strong></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div style="clear: both"></div>
        <!-- 注释：清除float产生浮动 -->
    </div>

    <div  id="" class="main" style="margin-top: 15px;height: 205px;">

        <div  id=""  class="main_child_left">
            <div class="vpanel" >
                <div class="vpanel_heading" ><i class="fa fa-th-list fa-lg-custom fa-fw"></i> <span >消息提醒</span><i class="fa fa-refresh fa-lg-custom fa-fw" style="float:right;margin-right:10px;"></i></div>
                <div class="nui-fit">
                    <div class="nui-fit">
						<div style="padding:10px 10px 10px 10px;">
                            <table id="table1" style="margin-left:0px;">
                                <tr>  
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>保养提醒：</td>
                                    <td class="tablenum"><span id="newCarQty">0</span></td>
                                    <td style="width:0.05%;"></td>
                                   <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>保险提醒：</td>
                                   <td class="tablenum"><span id="recordBillQty">0</span></td>
                                </tr>

                                <tr>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>年检提醒：</td>
                                    <td class="tablenum"><span id="settleQty">0</span></td>
                                   <td ></td>
                                   <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>年审提醒：</td>
                                   <td class="tablenum"><span id="serviceBillQty">0</span></td>
                               </tr>


                               <tr>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>客户生日：</td>
                                <td class="tablenum"><span id="bookingBillQty">0</span></td>
                                <td ></td>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>员工生日：</td>
                                <td class="tablenum"><span id="receiveAmt">0</span></td>
                              </tr>

                          </table>
                      </div>

                    </div>
                </div>
            </div>
        </div>

        <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

        <div  id=""  class="main_child">
            <div class="vpanel" >
                <div class="vpanel_heading" >
                    <i class="fa fa-bullhorn fa-lg-custom fa-fw"></i>
                    <span>今日数据</span>
                    <!-- <span style="float:right;margin-right:10px;font-size: 13px;">
                        <a onclick="" style="cursor: pointer;">总览</a>丨
                        <a onclick="" style="cursor: pointer;">分类</a>
                    </span> -->
                </div>
                <div class="nui-fit">
                    <div class="nui-fit" > 
                        <div style="padding:10px 10px 10px 10px;">
                            <table id="table1" style="margin-left:0px;">
                                <tr>  
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>首修车辆：</td>
                                    <td class="tablenum"><span id="newCarQty">0</span></td>
                                    <td style="width:0.05%;"></td>
                                   <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>进店车辆：</td>
                                   <td class="tablenum"><span id="recordBillQty">0</span></td>
                                </tr>

                                <tr>
                                    <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>结算车次：</td>
                                    <td class="tablenum"><span id="settleQty">0</span></td>
                                   <td ></td>
                                   <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>在修车辆：</td>
                                   <td class="tablenum"><span id="serviceBillQty">0</span></td>
                               </tr>


                               <tr>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>预约车辆：</td>
                                <td class="tablenum"><span id="bookingBillQty">0</span></td>
                                <td ></td>
                                <td class="tabletext"><i class="fa fa-cube fa-lg-custom fa-fw"></i>营业额：</td>
                                <td class="tablenum"><span id="receiveAmt">0</span></td>
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

  <div  id="" class="main" style="margin-top: 15px;height:150px;">

    <div  id=""  class="main_child_left">
        <div class="vpanel" >
            <div class="vpanel_heading" > 
                <i class="fa fa-user fa-lg-custom fa-fw"></i>
                <span >客户数据</span>
                <span style="float:right;margin-right:10px;font-size: 13px;">
                    <a onclick="showOrgGuestCar()" style="cursor: pointer;">本店</a>丨
                    <a onclick="showTenantGuestCar()" style="cursor: pointer;">连锁</a>
                </span>
            </div>
            <div class="nui-fit">
                <div id="Ranking" style="height:95%;width:95%;display: none;" title="图" > </div>
                                            <table id="tableInfo" style="margin-left:20px;margin-top:10px;">
                                <tr>   
                                    <td class="tabletext">
                                        <i class="fa fa-users fa-5x">
                                    </td>
                                    <td class="tablenumb" >
                                        <p>今日新增客户：&nbsp;&nbsp;&nbsp;<span id="addGuestQty">0</span>人</p>
                                        <p>客户总数：&nbsp;&nbsp;&nbsp;<span id="guestQty">0</span>人</p>
                                    </td>
                                    <td style="width:0.05%;">
                                        
                                    </td>
                                    <td class="tabletext" >
                                        <i class="fa fa-car fa-5x"></i>
                                    </td>
                                    <td class="tablenumb">
                                        <p >今日新增车辆：&nbsp;&nbsp;&nbsp;<span id="addCarQty">0</span>辆</p>
                                        <p>车辆总数：&nbsp;&nbsp;&nbsp;<span id="carQty">0</span>辆</p>
                                    </td>
                                </tr>


                          </table>
            </div>
        </div> 
    </div>  

    <div  id=""  style="float:left;width: 1%;height: 100%;"> </div>

    <div  id=""  class="main_child">
        <div class="vpanel" >
            <div class="vpanel_heading" ><i class="fa fa-lightbulb-o fa-lg-custom fa-fw"></i><span>新闻公告</span></div>
            <div class="nui-fit">
                <div class="nui-fit">
                    <div  style="padding:10px 10px 10px 10px;">
                     <ul id="newul" > 
                        <li><a target="_blank" href="https://list.tmall.com/search_product.htm?q=%CD%E6%BE%DF%B3%B5&user_id=725677994&type=p&cat=50514008&spm=a3204.7084717.a2227oh.d100&from=chaoshi.index.pc_1_searchbutton">
                            <i class="fa fa-hand-o-right fa-fw"></i>
                             今年买车看这里
                        	</a></li>
                            <li><a target="_blank" href="http://fontawesome.dashgame.com/">图标</a></li>
                            <li><a target="_blank" href="http://www.baidu.com">百度</a></li>
                            <li><a target="_blank" href="http://www.miniui.com/demo/">MINIUI</a></li>

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