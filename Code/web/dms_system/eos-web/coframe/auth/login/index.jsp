﻿<%@page pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <%@page import="com.primeton.cap.AppUserManager"%>
        <meta http-equiv="x-ua-compatible" content="IE=8;" />
        <html>

        <head>
            <meta http-equiv="Content-Type" content="tgetMenuDatagetext/html; charset=utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <%@include file="/common/sysCommon.jsp" %>
                <title>车道SaaS平台</title>

                <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
                <script src="<%=request.getContextPath()%>/common/nui/boot.js" type="text/javascript"></script>
                <link href="<%=request.getContextPath()%>/coframe/auth/login/css/kefu.css" rel="stylesheet" type="text/css" />
                <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menu/menu.css?v=1.0.1" rel="stylesheet" type="text/css" />
                <script src="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menu/menu.js?v=1.0.2" type="text/javascript"></script>
                <script src="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menupop.js" type="text/javascript"></script>
                <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/tabs.css?v=1.0.2" rel="stylesheet" type="text/css" />
                <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/frame.css?v=1.0.15" rel="stylesheet" type="text/css"
                />
                <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/index.css?v=1.0.0" rel="stylesheet" type="text/css"
                />
                <link href="<%=webPath + contextPath%>/common/nui/themes/cupertino/skin.css?v=1.0.7" rel="stylesheet" type="text/css" />
                <link href="<%=request.getContextPath()%>/common/nui/res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet"
                    type="text/css" />
                <link href="<%=request.getContextPath()%>/coframe/auth/login/feedback/feedback.css" rel="stylesheet" type="text/css" />
                <script src="<%=request.getContextPath()%>/common/nui/res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
                <script src="<%=request.getContextPath()%>/coframe/auth/login/feedback/html2canvas.min.js" type="text/javascript"></script>
                <link rel="stylesheet" href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css">
                <script src="<%=request.getContextPath()%>/coframe/imjs/util.js"></script>
                <script src="<%=request.getContextPath()%>/coframe/imjs/message.js"></script>
                <script src="<%=request.getContextPath()%>/coframe/imjs/messagebody.js"></script>
                <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js"></script>
                <script src="<%=request.getContextPath()%>/coframe/imjs/websocketconfig.js?v=1.3.3"></script>
                <style type="text/css">
                    a {
                        cursor: pointer;                     
                    }

                    .groupSize {
                        max-height: 200px;
                        overflow: auto;
                    }

					.layui-layim-close{
					    z-index: 99 !important;
					  }
					#layui-layer2{    
						z-index: 99 !important;
					}
                    #_sys_tip_msg_ {
                        z-index: 9999;
                        position: fixed;
                        left: -20;
                        top: 190;
                        text-align: center;
                        /* right*/
                        width: 100%;
                        /**/
                    }

                    #_sys_tip_msg_ span {
                        background-color: #03C440;
                        /*opacity: .8;*/
                        padding: 15px 20px;
                        border-radius: 5px;
                        text-align: center;

                        word-wrap: break-word;
                        word-break: break-all;
                        overflow: hidden;
                        width: 180px;
                        height: 56px;
                        display: inline-block;

                        color: #fff;
                        font-size: 14px;
                    }

                    #_sys_tip_msg_ span.E {
                        background-color: #FC4236;
                    }

                    #_sys_tip_msg_ span.W {
                        background-color: #FFCE42;
                        /*#FFCE42  EAA000  F8D714**/
                    }

                    #_sys_tip_msg_ span.small {
                        height: auto;
                    }

                    #toolData {
                        width: 1600px;
                        heigth: 1000px;
                    }

                    .menu {
                        padding-top: 0px;
                    }

                    .org_hover:hover {
                        text-decoration: underline
                    }

                    .icon {
                        width: 80px;
                        height: 50px;
                        overflow: auto;
                    }
                </style>
        </head>

        <body>

            <div id="advancedOrgWin" class="nui-window" title="公司选择" style="width:530px;height:340px;" showModal="true" showHeader="false"
                allowResize="false" style="padding:2px;border-bottom:0;" allowDrag="true">
                <div class="nui-toolbar">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <input class="nui-textbox" id="orgidOrName" name="orgidOrName" width="160px" emptyText="请输入店号或公司名">
                                <a class="nui-button" iconCls="" plain="true" onclick="searchOrg()">
                                    <span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="addOrg" id="">
                                    <span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id="">
                                    <span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false" dataField="orgList"
                        onrowdblclick="addOrg" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap=t rue allowCellSelect="true"
                        multiSelect="false" url="">
                        <div property="columns">
                            <div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
                            <div field="orgcode" name="orgid" width="15" align="center" visible="true" headerAlign="center" header="企业号"></div>
                            <div field="orgname" name="orgname" width="" align="center" headerAlign="center" header="公司名称"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="toolData" class="sidebar">
<%--                  <div id="tu" style="overflow-y:auto;overflow-x:auto; width:800px; height:50px;background-color: #055594;">
                    <a>
                        <img class="icon" id="icon" src="<%=webPath + contextPath%>/coframe/auth/images/icon.jpg" style="background-color: #fff;"
                        />
                    </a>
                </div>  --%>
                <div id="mainMenu" style="overflow:auto; width:800px;margin-top: 50px;background-color:#0067b8;">

                </div>
            </div>

            <div class="container">
                <div class="navbar" id="skin" style="margin-left: -80px;    background-color: #0067b8;">
                    <div class="navbar-brand" id="systemName">车道SaaS平台</div>
                    <ul class="nav navbar-nav navbar-right">
                        <!-- <li><a href="#"><i class="fa fa-paper-plane"></i> 代办事项</a></li>
            <li><a href="javascript:updatePassWord();"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li> -->
                        <li class="dropdown" style="margin-top: 3px;">
                            <a onClick="OrgShow()" >
                                <span class="org_hover" id="currOrgName">公司</span>
                            </a>
                            <ul class="dropdown-menu pull-right" id="orgsname">
                                <!-- <li>
                        <a href="javascript:openGuestOrder();"><i class="fa fa-pencil-square-o"></i> 待处理客户订单</a>
                    </li>
                    <li>
                        <a href="javascript:openSellOrder();"><i class="fa fa-pencil-square-o"></i> 待收货单</a>
                    </li> -->
                            </ul>
                        </li>
                        <li class="dropdown">

                            <!--<a class="dropdown-toggle userinfo">
                    <img class="user-img" src="res/images/user.jpg" />个人资料<i class="fa fa-angle-down"></i>
                </a>-->


                               
                            <a class="kefu" >
                                <!--<img class="user-img" src="res/images/user.jpg" />-->
                                <!-- <span  > 当前登录人:</span> -->
                                <span class="kefu-title" id="currUserName"></span>
                            	<ul class="kefu-dropdown">
	                                <!--  <li id="orgName" ><a href="#">所属：</a></li> -->
	                                <li onclick="myMessage()" class="toTop">
	                                        <span   class="fa fa-comments-o"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我的消息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                </li>
	                                <li onclick="updateEmployee()">
	                                        <span class="fa fa-pencil-square-o"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;个人设置
	                                </li>
	                                <li onclick="updatePassWord()">
	                                        <span class="fa fa-pencil-square-o"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改密码
	                                </li>
	                                <!-- <li><a href="javascript:resetIM();"><i class="fa fa-pencil-square-o"></i> 登录IM</a></li> -->
	                                <!-- <li><a href="javascript:updateSkin();"><i class="fa fa-pencil-square-o"></i> 皮肤中心</a></li> -->
	                                <!-- <li><a href="#"><i class="fa fa-eye "></i> 用户信息</a></li> -->
	                                <li onclick="cancellation()">
<%-- 	                                    <a href="<%=request.getContextPath()%>/coframe/auth/login/logout.jsp"> --%>
	                                        <span class="fa fa-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退出登录
	                                </li>
                            	</ul>
                        </a>
                        </li>
                        <!-- <li class="dropdown">
           		<a class="" style="padding-top: 18px; " onclick="customer()" title="客服信息"><i class="fa fa-user-circle-o"></i></a>
           	</li> -->
                        <li id="customer" class="dropdown">
<!--                             <a href="#click" class="kefu">
                                <h2 class="kefu-title">客服</h2>
                                <ul class="kefu-dropdown">
                                    <li>
                                        <span class="fa fa-user-circle-o"></span>&nbsp;&nbsp;&nbsp;熊鹰</li>
                                    <li>
                                        <span class="fa fa-qq"></span>&nbsp;&nbsp;&nbsp;1074331924</li>
                                    <li>
                                        <span class="fa fa-wechat"></span>&nbsp;&nbsp;&nbsp;qq1074331924</li>
                                    <li>
                                        <span class="fa fa-volume-control-phone"></span>&nbsp;&nbsp;&nbsp;&nbsp;13260632181</li>
                                </ul>
                            </a> -->
                        </li>
                        <li class="dropdown">
                            <a class="kefu">
                                <span class="kefu-title">换肤</span>
                            <ul class="kefu-dropdown">
                                <li onclick="updateSkin('#055594')" class="toTop">
                                        <div style="width:10px;height:15px;background-color: #055594;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;经典蓝
                      			</li>
                                <li onclick="updateSkin('#369cf4d9')" >
                                        <div style="width:10px;height:15px;background-color: #369cf4d9;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;亮蓝
                                </li>
  								<li onclick="updateSkin('#f36205a6')">
                                        <div style="width:10px;height:15px;background-color: #f36205a6;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;秋日橙
                                </li>
<!--                                 <li onclick="updateSkin('#f36205')">
                                        <div style="width:10px;height:15px;background-color: #f36205;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;秋日橙
                                </li> -->
<!--                                 <li onclick="updateSkin('#c1c1c1')">
                                        <div style="width:10px;height:15px;background-color: #c1c1c1;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;极简灰
                                </li> -->
                                <li onclick="updateSkin('#42485b')">
                                        <div style="width:10px;height:15px;background-color: #42485b;float:left;"></div>&nbsp;&nbsp;&nbsp;&nbsp;炫酷黑
                                </li>
                            </ul>
                            </a>
                        </li>
                        
<!--                         <li class="dropdown">
	                        <div  onclick="reload()" style="padding-top: 21px;">                    
	                            <div  id="limiStatus" title="聊天工具，点击连接" style="width:12px; height:12px; border-radius:50%; background-color:#cccccccc;">                           
	                            </div>
	                        </div>
                        </li> -->
                        <li class="dropdown">
                            <a class="feedback-bt FeedBackButton" style="padding-top: 19px; ">
                                反馈
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="main">
                    <div id="mainTabs" class="mini-tabs indexTabs" activeIndex="0" style="width:100%;height:100%;" plain="false" buttons="#tabsButtons"
                        arrowPosition="side" ontabload="ontabload">
                        <div name="index" iconCls="fa-home" title="首页">
                            <iframe id="formIframe" src="<%=request.getContextPath()%>/common/Index/TextIndex.jsp" frameborder="0" scrolling="yes" height="100%"
                                width="100%" noresize="noresize"></iframe>
                        </div>
                    </div>
                    <div id="tabsButtons" >
                        <a class="tabsBtn" onclick="toHome()">
                            <i class="fa fa-home"></i>
                        </a>
                        <a class="tabsBtn" onclick="toRefresh()">
                            <i class="fa fa-refresh"></i>
                        </a>
                        <a class="tabsBtn" onclick="toClose()">
                            <i class="fa fa-remove"></i>
                        </a>
                        <a class="tabsBtn" onclick="toMax()">
                            <i class="fa fa-arrows-alt"></i>
                        </a>
                    </div>
                </div>
            </div>
            <form id="toggleRole" role="form" method="post" action="">
                <input type="hidden" name="_eosFlowAction" value="toggleOrg">
                <input type="hidden" name="operatorId" value="" id="operatorId">
                <input type="hidden" name="orgid" value="" id="orgid">
            </form>

            <script src="<%=request.getContextPath()%>/coframe/auth/login/feedback/drawDom.js?v=1.0.1" type="text/javascript"></script>

        </body>

        </html>

        <script>
            window.onresize = function () {
                document.getElementById("mainMenu").style.height = (document.documentElement.clientHeight - 50) + 'px';
            }
            document.getElementById("mainMenu").style.height = (document.documentElement.clientHeight - 50) + 'px';
           

            var defDomin = "<%=request.getContextPath()%>";
            var baseUrl = apiPath + sysApi + "/";
            var mainTabs = mini.get("mainTabs");
            var loadingV = false;
            var obj = {};
            var advancedOrgWin = null;
            var moreOrgGrid = null;
            var moreOrgGridUrl = apiPath + sysApi + "/com.hsapi.system.basic.organization.getUserOrg.biz.ext";
            var show = 0;
            var titleUrl = null;
            var title = null;

            /* var music=new Audio();
            music.src=defDomin+"/layim-v3.8.0/src/css/modules/layim/voice/default.mp3";
            music.loop=true;
            var playStatus=false;
            var lastRunTime=Date.now();
            function playOrPause(){
                var currentTime=Date.now();
                var protectTime=100;//设置保护性延时 单位毫秒，不要小于50 建议100以上
                if((currentTime-lastRunTime)<protectTime){
                    return;//两次执行太过频繁，直接退出
                }
                
                if(playStatus){
                    music.pause();
                }else{
                    music.play();
                }
                playStatus=!playStatus;
                lastRunTime=Date.now();
            } */

            skin();
            /*     $(document).ready(function(v) {
                moreOrgGrid = nui.get("moreOrgGrid");
                moreOrgGrid.on("drawcell", function (e){
                    if(e.field=="orgname"){
                        e.cellHtml = e.row.orgcode+e.row.orgname;
                    }
                });
                
            }); */

/*             if (currSystemImg != "") {
                $("#icon").attr("src", currSystemImg || webPath + contextPath + "/common/images/logo.jpg");
            } */
            if (currSystemName != "") {
                $('#systemName').html(currSystemName);
            }
            function OrgShow() {
                searchOrg();
                advancedOrgWin.show();
                moreOrgGrid.focus();
                show = 1;
            }

            function onOrgClose() {
                advancedOrgWin.hide();
                moreOrgGrid.setData([]);
                nui.get('orgidOrName').setValue("");
                show = 0;
            }
            function addOrg() {
                var orgid = moreOrgGrid.getSelected().orgid;
                changeOrgs(orgid);
                advancedOrgWin.hide();
            }
            function searchOrg() {
                var params = {};
                var orgidOrName = nui.get('orgidOrName').value;
                params.orgidOrName = orgidOrName;
                moreOrgGrid.load({ params: params, token: token });

            }
            function activeTab(item) {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getTab(item.id);
                if (!tab) {
                    tab = { name: item.id, title: item.text, url: item.url, iconCls: item.iconCls, resId: item.resId, showCloseButton: true };
                    tab = tabs.addTab(tab);
                }
                tabs.activeTab(tab);
                tabs.updateTab(tab, { title: item.text })
            }

            function ontabload() {
                if (loadingV) {
                    if (obj) {
                        doInitTab(obj);
                        obj = {};
                        loadingV = false;
                    }
                } else {
                    var tabs = mini.get("mainTabs");
                    var tab = tabs.getActiveTab();
                    var iframe = tabs.getTabIFrameEl(tab);
                    var params = {
                        resId: tab.resId
                    };
                    if (iframe.contentWindow && iframe.contentWindow.setInitData) {
                        iframe.contentWindow.setInitData(params);
                    }
                }
            }

            function activeTabAndInit(item, params) {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getTab(item.id);
                loadingV = true;
                if (!tab) {
                    tab = { name: item.id, title: item.text, url: item.url, iconCls: item.iconCls, resId: item.resId, showCloseButton: true };
                    tab = tabs.addTab(tab);

                    tabs.activeTab(tab);

                    obj = params;
                    //doInitTab(params);
                } else {
                    tabs.activeTab(tab);
                    tabs.updateTab(tab, { title: item.text })
                    doInitTab(params);
                }
            }

            function doInitTab(params) {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getActiveTab();
                var iframe = tabs.getTabIFrameEl(tab);
                if (iframe.contentWindow && iframe.contentWindow.setInitData) {
                    iframe.contentWindow.setInitData(params);
                }
            }

            function toClose() {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getActiveTab();
                if (tab && tab.name != "index") {
                    tabs.removeTab(tab);
                }
            }

            function toHome() {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getTab("index");

                tabs.activeTab(tab);
            }

            function toRefresh() {
                var tabs = mini.get("mainTabs");
                var tab = tabs.getActiveTab();

                if (tab.name == "index") {
                    tab.url = defDomin + "/common/Index/TextIndex.jsp";
                }
                tabs.loadTab(tab.url, tab);
            }

            function myMessage() {
                var item = {};
                item.id = "myMessage";
                item.text = "我的消息";
                item.url = defDomin + "/stat.myMessage.flow?token=" + token;
                item.iconCls = "fa fa-file-text";
                //window.parent.activeTab(item);
                var params = { Refresh: "Refresh" };//是否刷新页面，解决工单详情界面结算之后不能再选择客户
                window.parent.activeTab(item, params);

                /* nui.open({
                    url: defDomin + "/stat.myMessage.flow?token="+token,
                    title:"我的消息",
                    width: "570px",
                    height: "400px"
                }); */
            }

            function updatePassWord() {
                nui.open({
                    url: defDomin + "/coframe/rights/user/update_password.jsp",
                    title: "修改密码",
                    width: "390px",
                    height: "200px"
                });
            }

            function updateSkin(color) {
                var queryEmployeeUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
                nui.ajax({
                    url: queryEmployeeUrl,
                    type: "post",
                    cache: false,
                    data: JSON.stringify({
                        params: {
                            orgid: currOrgId,
                            empid: currEmpId
                        },
                        token: token
                    }),
                    success: function (text) {
                        var list = text.rs || {};
                        if (list.length == 0) {
                            //showMsg("此用户无法修改","W");
                        } else {
                            updateSkinColor(list[0], color);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                    }
                });
            }

            function skin() {
                var queryEmployeeUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
                nui.ajax({
                    url: queryEmployeeUrl,
                    type: "post",
                    cache: false,
                    data: JSON.stringify({
                        params: {
                            orgid: currOrgId,
                            empid: currEmpId
                        },
                        token: token
                    }),
                    success: function (text) {
                        var list = text.rs || {};
                        if (list.length == 0) {
                            // showMsg("此用户无法修改","W");
/*                                 document.getElementById("skin").style.backgroundColor = "#0067b8";
                                document.getElementById("mainMenu").style.backgroundColor = "#0067b8"; */
                        } else {
                            if (list[0].backgroundColor != null) {
                                document.getElementById("skin").style.backgroundColor = list[0].backgroundColor;
                                document.getElementById("mainMenu").style.backgroundColor = list[0].backgroundColor;
                            } else {
                                document.getElementById("skin").style.backgroundColor = "#0067b8";
                                document.getElementById("mainMenu").style.backgroundColor = "#0067b8";
                            }

                            //list[0]
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                    }
                });
            }

            function resetIM() {
                reconnect(null);
            }

            function updateEmployee() {
                var queryEmployeeUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
                nui.ajax({
                    url: queryEmployeeUrl,
                    type: "post",
                    cache: false,
                    data: JSON.stringify({
                        params: {
                            orgid: currOrgId,
                            empid: currEmpId
                        },
                        token: token
                    }),
                    success: function (text) {
                        var list = text.rs || {};
                        if (list.length == 0) {
                            //showMsg("此用户无法修改","W");
                        } else {
                            nui.open({
                                url: webPath + contextPath + "/com.hs.common.homePageEmployeeEdit.flow?token=" + token,
                                width: 680,         //宽度
                                height: 230,        //高度
                                title: "员工信息",      //标题 组织编码选择
                                allowResize: true,
                                onload: function () {
                                    var iframe = this.getIFrameEl();
                                    iframe.contentWindow.SetInitData(list[0]);
                                },
                                ondestroy: function (action) {  //弹出页面关闭前
                                    if (action == "ok") {       //如果点击“确定”
                                        search();
                                    }
                                }
                            });
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                    }
                });
            }


            function toMax() {
                launchFullscreen(document.documentElement);
            }


            // 判断各种浏览器，找到正确的方法
            function launchFullscreen(element) {
                if (element.requestFullscreen) {
                    element.requestFullscreen();
                } else if (element.mozRequestFullScreen) {
                    element.mozRequestFullScreen();
                } else if (element.webkitRequestFullscreen) {
                    element.webkitRequestFullscreen();
                } else if (element.msRequestFullscreen) {
                    element.msRequestFullscreen();
                }
            }
            // 启动全屏!
            //launchFullScreen(document.documentElement); // 整个网页
            //launchFullScreen(document.getElementById("videoElement")); // 某个页面元素

            // 判断浏览器种类
            function exitFullscreen() {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.webkitExitFullscreen) {
                    document.webkitExitFullscreen();
                }
            }
            // 退出全屏模式!
            //exitFullscreen();

            $(function () {


                //menu
                var menu = new Menu("#mainMenu", {
                    itemclick: function (item) {
                        if (!item.children) {
                            activeTab(item);
                        }
                    }
                });

                $(".sidebar").mCustomScrollbar({ autoHideScrollbar: true });

                function autoScrollbar() {
                    var jq = $(".mCSB_container");
                    if (jq.parent().height() >= jq.children().outerHeight()) {
                        jq.css("height", "100%");
                    } else {
                        jq.css("height", "auto");
                    }
                }
                $(window).on("resize", function () {
                    autoScrollbar();
                });
                autoScrollbar();

                new MenuPop(menu);

                //com.hsapi.system.tenant.permissions.getMenuData.biz.ext
                $.ajax({
                    url: defDomin + "/com.hsapi.system.tenant.permissions.getMenuData.biz.ext",//defDomin + "/org.gocom.components.coframe.auth.LoginManager.getMenuData.biz.ext",
                    type: "POST",
                    success: function (text) {
                        var treeNodes = text.treeNodes;
                        var data = setMenuData(treeNodes);
                        menu.loadData(data);
                    }
                });

                var menuData = [];

                function setMenuData(treeNodes) {
                    if (!treeNodes) return;
                    var tmpObj = {};
                    for (var i = 0; i < treeNodes.length; i++) {
                        var node = treeNodes[i];
                        var imagePath = node.imagePath;
                        tmpObj = {};
                        tmpObj.text = node.menuName;
                        tmpObj.id = node.menuPrimeKey;
                        tmpObj.iconCls = imagePath || "fa fa-th-list";
                        tmpObj.url = node.linkAction;
                        tmpObj.resId = node.linkResId;
                        if (node.childrenMenuTreeNodeList) {
                            tmpObj.children = getChildrenData(node.childrenMenuTreeNodeList);
                        }
                        menuData.push(tmpObj);
                    }
                    return menuData;
                }

                function getChildrenData(treeNodes) {
                    var data = [];
                    var tmpObj = {};
                    for (var i = 0; i < treeNodes.length; i++) {
                        var node = treeNodes[i];
                        var imagePath = node.imagePath;
                        tmpObj = {};
                        tmpObj.text = node.menuName;
                        tmpObj.id = node.menuPrimeKey;
                        tmpObj.iconCls = imagePath || "fa fa-file-text";
                        tmpObj.url = defDomin + node.linkAction;
                        tmpObj.resId = node.linkResId;
                        if (node.childrenMenuTreeNodeList) {
                            tmpObj.children = getChildrenData(node.childrenMenuTreeNodeList);
                        }
                        data.push(tmpObj);
                    }
                    return data;

                }

                function getChildren(node, treeNodes) {
                    if (!treeNodes) return;
                    for (var i = 0; i < treeNodes.length; i++) {
                        var node = treeNodes[i];
                        var id = node.menuPrimeKey;
                        var iconCls = "fa fa-file-text";
                        var text = node.menuName;
                        var url = defDomin + node.linkAction;
                        var children = node.childrenMenuTreeNodeList;
                        var resId = node.linkResId;

                        var child = {};
                        child.id = id;
                        child.iconCls = iconCls;
                        child.text = text;
                        child.url = url;
                        child.children = children;
                        child.resId = resId;

                        getChildren(child, children);
                        node.push(child);
                        //getChildren(children);
                    }
                }

                function getMainTabs() {
                    return mainTabs;
                }

                //dropdown
                $(".dropdown-toggle").click(function (event) {
                    $(this).parent().addClass("open");
                    return false;
                });

                $(".dropdown-toggle").click(function (event) {
                    if ($(this).next().attr("id") == "orgsname") {
                        $("#orgsname").empty();
                        setOrgList();

                    }

                    $(this).parent().addClass("open");
                    return false;
                });

                $(document).click(function (event) {
                    $(".dropdown").removeClass("open");
                });
                window.onbeforeunload = function () {
                    return "离开此网站?";
                    //return null;
                };

                //document.getElementById('orgName').innerHTML = '<a href="#">所属：'+currOrgName+'</a>';

                //document.getElementById('orgName').innerHTML = '<a href="#">所属：'+currOrgName+'</a>';
                document.getElementById('currOrgName').innerHTML = currOrgName;
                document.getElementById('currUserName').innerHTML = currUserName;

                $.ajax({
                    url: apiPath + sysApi + "/com.hs.common.login.authRequried.biz.ext",
                    type: "POST",
                    data: JSON.stringify({
                        token: token
                    }),
                    success: function (text) {
                    }
                });

                //org
                advancedOrgWin = mini.get("advancedOrgWin");
                moreOrgGrid = mini.get("moreOrgGrid");
                moreOrgGrid.setUrl(moreOrgGridUrl);
                var params = {};
                moreOrgGrid.load({ params: params, token: token });
                document.onkeyup = function (event) {
                    var e = event || window.event;
                    var keyCode = e.keyCode || e.which;// 38向上 40向下
                    if ((keyCode == 13)) { // F9
                        if (show == 1) {
                            addOrg();
                        }
                    }
                    if ((keyCode == 27)) { // F9
                        onOrgClose();
                    }
                }

                tabs1 = mini.get("mainTabs");
                tabs1.on("activechanged", function (e) {
                    var index = e.index;
                    var tab = e.tab;
                    if (tab) {
                        titleUrl = tab.url || "";
                        title = tab.title;
                    }

                    //console.log("titleUrl"+titleUrl +"-----"+"title"+title);
                });


            });

            //切换角色
            function changeOrgs(orgid) {
                if (orgid != currOrgId) {
                    $("#toggleRole")[0].action = "com.hsapi.system.auth.login.login.flow";
                    $("#operatorId").val(currUserId);
                    $("#orgid").val(orgid);
                    $("#toggleRole")[0].submit();
                    //nui.confirm('切换公司后将重新加载页面，是否继续?','温馨提示',function(action){
                    //    if (action == "ok") {
                    //        $("#toggleRole")[0].action = "com.hsapi.system.auth.login.wlogin.flow";
                    //        $("#operatorId").val(currUserId);
                    //        $("#orgid").val(orgid);
                    //         $("#toggleRole")[0].submit();
                    //     } else {
                    //mini.get("changeRole").setValue(vGrid);
                    //     }
                    // });
                }
            }

            function setOrgList() {
                $.ajax({
                    url: apiPath + sysApi + "/com.hsapi.system.auth.LoginManager.getOrgList.biz.ext?userId=" + currUserId,
                    type: "POST",
                    data: JSON.stringify({
                        token: token
                    }),
                    success: function (text) {
                        var orgList = text.orgList;
                        if (orgList && orgList.length > 0) {
                            if (orgList.length > 16) {
                                $("#orgsname").attr("style", "position:absolute; height:400px; overflow:auto;");
                            }

                            for (var i = 0; i < orgList.length; i++) {
                                var rtoken = '<li><a href="javascript:void(0);" onclick="changeOrgs('
                                    + orgList[i].orgid
                                    + ')" title="'
                                    + orgList[i].orgname + '">';
                                rtoken = rtoken + orgList[i].orgname;
                                rtoken = rtoken + '</a></li>';
                                $("#orgsname").append(rtoken);
                            }
                        }
                    }
                });

            }

            var _sysMsg_index;
            //提示成功信息    
            function showMsgBox_index(message, life) {
                var time = 3000;
                if (life) {
                    time = life;
                }

                _sysMsg_index = message;
                $("#_sys_tip_msg_").remove();

                if ($("#_sys_tip_msg_").text().length > 0) {
                    var msg = "<span>" + message + "</span>";
                    $("#_sys_tip_msg_").empty().append(msg);
                } else {
                    var msg = "<div id='_sys_tip_msg_'><span>" + message + "</span></div>";
                    $("body").append(msg);
                }

                //$("#_sys_tip_msg_").fadeIn(1000);

                setTimeout($("#_sys_tip_msg_").stop().delay(1000).fadeOut(time), time);
            };

            //提示错误信息
            function showIndexMsg(message, msgType) {
                showMsgBox_index(message, 2000);
                if (msgType) {
                    $("#_sys_tip_msg_ span").addClass(msgType);
                }
                if (("" + message).length < 36) {
                    $("#_sys_tip_msg_ span").addClass("small");
                }
            };

            function showIndexError(message) {
                showMsgBox_index(message, "E");
            };

            function showIndexWarn(message) {
                showMsgBox_index(message, "W");
            };

            var saveUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.saveEmployee.biz.ext";
            function updateSkinColor(emp, color) {
                emp.backgroundColor = color;
                nui.mask({
                    el: document.body,
                    cls: 'mini-mask-loading',
                    html: '换肤中...'
                });
                nui.ajax({
                    url: saveUrl,
                    type: "post",
                    data: JSON.stringify({
                        emp: emp,
                        token: token
                    }),
                    success: function (data) {
                        nui.unmask();
                        data = data || {};
                        if (data.errCode == 'S') {
                            //showMsg(data.errMsg,"S");
                            skin();
                        } else {
                            //showMsg(data.errMsg,"W");
                            //basicInfoForm.setData([]); 
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //  nui.alert(jqXHR.responseText);

                        closeWindow("cal");
                    }
                });
            }

/*             function customer() {
                nui.open({
                    url: webPath + contextPath + "/common/customer.jsp?token=" + token,
                    width: "100%",         //宽度
                    height: "100%",        //高度
                    title: "客服信息",      //标题 组织编码选择
                    allowResize: true,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData();
                    },
                    ondestroy: function (action) {  //弹出页面关闭前
                        if (action == "ok") {       //如果点击“确定”
                            search();
                        }
                    }
                });
            } */

            var querCustomerUrl = baseUrl + "com.primeton.tenant.comTenant.queryCusomer.biz.ext";
                nui.ajax({
                    url: querCustomerUrl,
                    type: "post",
                    data: JSON.stringify({
                        params: {
                            tenantId: currTenantId
                        },
                        token: token
                    }),
                    success: function (data) {
                        var html = "";
                        if(data.rs.length>0){
                            if (data.rs[0].sex == 1) {
                                data.rs[0].sex = "男";
                            } else {
                                data.rs[0].sex = "女";
                            }
                            html += '<a href="#click" class="kefu" >';
                            html += '   <h2 class="kefu-title">客服</h2>';
                            html += '		 <ul class="kefu-dropdown"> ';
                            html += '             <li class="toTop"><span class="fa fa-user-circle-o"></span>&nbsp;&nbsp;&nbsp;' + data.rs[0].name + '</li>';
                            html += '			  <li><span class="fa fa-volume-control-phone"></span>&nbsp;&nbsp;&nbsp;&nbsp;' + data.rs[0].mobile + '</li>';
                            html += '             <li><span class="fa fa-qq"></span>&nbsp;&nbsp;&nbsp;' + data.rs[0].qq + '</li>';
/*                             html += '		      <li><span class="fa fa-wechat"></span>&nbsp;&nbsp;&nbsp;' + data.rs[0].wechat + '</li>'; */
                            html += '			  <li class="photo"><span class="fa fa-wechat"></span>&nbsp;&nbsp;&nbsp;&nbsp;<img id="xmTanImg" style="width: 90px;height: 90px" src="' + data.rs[0].wechatPhoto + '"/></li>';                                                    
                            html += '		 </ul>';
                            html += '	</a>';
                            $("#customer").append(html);
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
 	function cancellation(){
 		window.location="<%=request.getContextPath()%>/coframe/auth/login/logout.jsp";
 	}     
 	        var scriptList=[
            {src:defDomin + "/coframe/imjs/websocketconfig.js",id:"js1"},
            {src:defDomin + "/coframe/imjs/util.js",id:"js2"},
            {src:defDomin + "/coframe/imjs/message.js",id:"js3"},
            {src:defDomin + "/coframe/imjs/messagebody.js",id:"js4"},
            {src:defDomin + "/layim-v3.8.0/dist/layui.js",id:"js5"}
            
            ]
        function reload() {
            scriptList.forEach(x=>{
                loadJs(x.src,x.id);
            })
        }
        //重新加载js        
        function loadJs(file,id)
        {
            $("#"+id).remove();
            $("<scri"+"pt >"+"</scr"+"ipt>").attr({id:id,src:file,type:'text/javascript'}).appendTo($('body'));
        }          
        </script>