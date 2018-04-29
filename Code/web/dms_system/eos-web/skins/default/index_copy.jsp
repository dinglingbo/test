
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<meta http-equiv="x-ua-compatible" content="IE=8;" />
<html>

<head>    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <script src="http://www.miniui.com/scripts/boot.js" type="text/javascript"></script>
    <script src="http://www.miniui.com/scripts/jquery.min.js" type="text/javascript"></script>
    <script src="http://www.miniui.com/scripts/miniui/miniui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/scripts/miniui/themes/default/miniui.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/res/css/common.css" rel="stylesheet" type="text/css">
    <script src="http://www.miniui.com/res/js/common.js" type="text/javascript"></script>
    <link href="http://www.miniui.com/scripts/miniui/themes/cupertino/skin.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/scripts/miniui/themes/default/medium-mode.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/scripts/miniui/themes/icons.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css">
    <script src="http://www.miniui.com/res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
    <link href="http://www.miniui.com/frame/frame1/res/menu/menu.css" rel="stylesheet" type="text/css">
    <script src="http://www.miniui.com/frame/frame1/res/menu/menu.js" type="text/javascript"></script>
    <script src="http://www.miniui.com/frame/frame1/res/menutip.js" type="text/javascript"></script>
    <link href="http://www.miniui.com/frame/frame1/res/tabs.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/frame/frame1/res/frame.css" rel="stylesheet" type="text/css">
    <link href="http://www.miniui.com/frame/frame1/res/index.css" rel="stylesheet" type="text/css">
    <style>
    .menu .has-children .menu-icon{line-height: 36px;}
    </style>
</head>
<body>
    
<div class="navbar">
    <div class="navbar-header">
        <div class="navbar-brand">云服务</div>
        <div class="navbar-brand navbar-brand-compact">fcu</div>
    </div>
    <ul class="nav navbar-nav">
        <li><a id="toggle"><span class="fa fa-bars" ></span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-hand-pointer-o"></i><span >系统演示</span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-puzzle-piece"></i><span >开发文档</span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-sort-amount-asc"></i><span >人力资源</span></a></li>
        <li class="icontop"><a href="#"><i class="fa  fa-cog"></i><span >系统设置</span></a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 代办事项</a></li>
        <li><a href="#"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li>
        <li class="dropdown">
            <a class="dropdown-toggle userinfo">
                <img class="user-img" src="res/images/user.jpg" />个人资料<i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu pull-right">
                <li ><a href="#"><i class="fa fa-eye "></i> 用户信息</a></li>
                <li><a href="#"><i class="fa fa-user"></i> 退出登录</a></li>
            </ul>
        </li>
    </ul>
</div>

<div class="container">
    
    <div class="sidebar">
        <div class="sidebar-toggle"><i class = "fa fa-fw fa-dedent" ></i></div>
        <div id="mainMenu"></div>
    </div>

    <div class="main">
        <div id="mainTabs" class="mini-tabs main-tabs" activeIndex="0" style="height:100%;" plain="false"
             buttons="#tabsButtons" arrowPosition="side" >
            <div name="index" iconCls="fa-android" title="控制台">
                MiniUI导航框架
            </div>
        </div>
        <div id="tabsButtons">
            <a class="tabsBtn"><i class="fa fa-home"></i></a>
            <a class="tabsBtn"><i class="fa fa-refresh"></i></a>
            <a class="tabsBtn"><i class="fa fa-remove"></i></a>
            <a class="tabsBtn"><i class="fa fa-arrows-alt"></i></a>
        </div>   
    </div>
   
</div>


</body>
</html>
<script>

    function activeTab(item) {
        var tabs = mini.get("mainTabs");
        var tab = tabs.getTab(item.id);
        if (!tab) {
            tab = { name: item.id, title: item.text, url: item.url, iconCls: item.iconCls, showCloseButton: true };
            tab = tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }

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

        new MenuTip(menu);

		var data = [
						{ "id": "1", iconCls: "fa fa-send-o", text: "敏捷开发", children: [
					        { "id": "1_1", iconCls: "fa fa-desktop", text: "代码生成器", url: "pages/1.html" },
					        { "id": "1_2", iconCls: "fa fa-search", text: "单页管理", url: "pages/1.html"},
					         { "id": "1_3", iconCls: "fa fa-send-o", text: "插件演示", url: "pages/1.html" },
					         { "id": "1_4", iconCls: "fa fa-window-restore", text: "开发示例", children: [
					                    { "id": "1_4_1", iconCls: "fa fa-assistive-listening-systems", text: "商机管理" , url: "pages/1.html"},
					                    { "id": "khgl", iconCls: "fa fa-vcard", text: "客户管理", url: "pages/1.html" },
					                    { "id": "kpxx", iconCls: "fa fa-file-excel-o", text: "开票信息" , url: "pages/1.html"},
					                    { "id": "khdd", iconCls: "fa fa-modx", text: "客户订单" , url: "pages/1.html"}
					            ]
					         }
						    ]
						},
					    { "id": "xtgl", iconCls: "fa fa-desktop", text: "系统管理", children: [
					        { "id": "xzgl", iconCls: "fa fa-leaf", text: "行政管理", url: "pages/1.html" },
					        { "id": "sjzd", iconCls: "fa fa-book", text: "数据字典", url: "pages/1.html" },
					        { "id": "djbm", iconCls: "fa fa-barcode", text: "单据编码", url: "pages/1.html" },
					        { "id": "xtgn", iconCls: "fa fa-navicon", text: "系统功能", url: "pages/1.html" },
					        { "id": "excel", iconCls: "fa fa-file-excel-o", text: "Excel配置", children: [
					                  { "id": "drpz", iconCls: "fa fa-sign-out", text: "导入配置", url: "pages/1.html" },
					                  { "id": "dcpz", iconCls: "fa fa-sign-out", text: "导出配置", url: "pages/1.html" }
					            ]
					        },
					        { "id": "sjgl", iconCls: "fa fa-database", text: "数据管理", children: [
					                { "id": "sjklj", iconCls: "fa fa-plug", text: "数据库连接", url: "pages/1.html" },
					                { "id": "sjbgl", iconCls: "fa fa-table", text: "数据表管理", url: "pages/1.html" },
					                { "id": "sjygl", iconCls: "fa fa-bullseye", text: "数据源管理", url: "pages/1.html" }
					            ]
					        },
					        { "id": "xtrz", iconCls: "fa fa-warning", text: "系统日志" },
					        { "id": "sjqxgl", iconCls: "fa fa-briefcase", text: "数据权限管理" }
					    ]
					    },
						{ "id": "dwzz", iconCls: "fa fa-coffee",  text: "单位组织", children: [
						         { "id": "gsgl", iconCls: "fa fa-sitemap", text: "公司管理", url: "pages/1.html" },
						         { "id": "bmgl", iconCls: "fa fa-th-list", text: "部门管理", url: "pages/1.html" },
						         { "id": "gwgl", iconCls: "fa fa-graduation-cap", text: "岗位管理", url: "pages/1.html" },
						         { "id": "jsgl", iconCls: "fa fa-paw", text: "角色管理", url: "pages/1.html" },
						         { "id": "yhgl", iconCls: "fa fa-user", text: "用户管理", url: "pages/1.html" }
						    ]
						},
						{ "id": "bdzx", iconCls: "fa fa-table", text: "表单中心", children: [
						        { "id": "zdybd", iconCls: "fa fa-puzzle-piece", text: "自定义表单", url: "pages/1.html" },
						        { "id": "fbbdgn", iconCls: "fa fa-list-alt", text: "发布表单功能", url: "pages/1.html" },
						        { "id": "bdfbsl", iconCls: "fa fa-list-alt", text: "表单发布实例", children: [
						              { "id": "hyda", iconCls: "fa fa-address-card-o", text: "会员档案", url: "pages/1.html" },
						              { "id": "ddgn", iconCls: "fa fa-address-book", text: "订单功能", url: "pages/1.html" },
						              { "id": "qjgl", iconCls: "fa fa-user-circle", text: "请假管理", url: "pages/1.html" },
						              { "id": "csbd", iconCls: "fa fa-bandcamp", text: "测试表单", url: "pages/1.html" }
						            ]
						        }
						    ]
						},
						{ "id": "lczx", iconCls: "fa fa-share-alt", text: "流程中心", children: [
						          { "id": "mbgl", iconCls: "fa fa-share-alt", text: "模板管理", url: "pages/1.html" },
						          { "id": "wdrw", iconCls: "fa fa-file-word-o", text: "我的任务", url: "pages/1.html" },
						          { "id": "gzwt", iconCls: "fa fa-coffee", text: "工作委托", url: "pages/1.html" },
						          { "id": "lcjk", iconCls: "fa fa-eye", text: "流程监控", url: "pages/1.html" },
						          { "id": "xtlcgl", iconCls: "fa fa-industry", text: "系统流程案例", url: "pages/1.html" }
						    ]
						},
						{ "id": "bbzx", iconCls: "fa fa-area-chart", text: "报表中心", children: [
						        { "id": "bbgl", iconCls: "fa fa-cogs", text: "报表管理", url: "pages/1.html" },
						        { "id": "bbsl", iconCls: "fa fa-file-powerpoint-o", text: "报表实例", children: [
						                { "id": "xstb", iconCls: "fa fa-area-chart", text: "销售图表", url: "pages/1.html" },
						                { "id": "xslb", iconCls: "fa fa-area-chart", text: "销售列表", url: "pages/1.html" },
						                { "id": "xshh", iconCls: "fa fa-area-chart", text: "销售混合", url: "pages/1.html" }
						            ]
						        },
						        { "id": "bbxq", iconCls: "fa fa-wpforms", text: "报表模板", children: [
						                { "id": "cgbb", iconCls: "fa fa-bar-chart", text: "采购报表", url: "pages/1.html" },
						                { "id": "sxbb", iconCls: "fa fa-line-chart", text: "销售报表", url: "pages/1.html" },
						                { "id": "ccbb", iconCls: "fa fa-area-chart", text: "仓存报表", url: "pages/1.html" },
						                { "id": "szbb", iconCls: "fa fa-pie-chart", text: "收支报表", url: "pages/1.html" }
						            ]
						        }
						    ]
						},
						{ "id": "ggxx", iconCls: "fa fa-globe", text: "公共信息", children: [
						        { "id": "xwzx", iconCls: "fa-feed", text: "新闻中心", url: "pages/1.html" },
						        { "id": "khxq1", iconCls: "fa-braille", text: "客户详情", url: "pages/1.html" },
						        { "id": "khxq2", iconCls: "fa fa-braille", text: "客户详情", url: "pages/1.html" },
						        { "id": "khxq3", iconCls: "fa fa-braille", text: "客户详情", url: "pages/1.html" },
						        { "id": "tzgg", iconCls: "fa fa-volume-up", text: "通知公告", url: "pages/1.html" },
						        { "id": "wjzl", iconCls: "fa fa-jsfiddle", text: "文件资料", url: "pages/1.html" },
						        { "id": "rcgl", iconCls: "fa fa-calendar", text: "日程管理", url: "pages/1.html" },
						        { "id": "yjzx", iconCls: "fa fa-send", text: "邮件中心", url: "pages/1.html" },
						        { "id": "dzqz", iconCls: "fa fa-registered", text: "电子签章", url: "pages/1.html" }
						    ]
						},
						{ "id": "ydgl", iconCls: "fa fa-android", text: "移动管理", children: [
						        { "id": "wxgl", iconCls: "fa fa-weixin", text: "微信管理", children: [
						                { "id": "qyhsz", iconCls: "fa fa-plug", text: "企业号设置", url: "pages/1.html" }
						            ]
						        }
						    ]
						}
					];
		menu.loadData(data);
        /* $.ajax({
            url: "skins/default/menu.txt",
            success: function (text) {
                var data = mini.decode(text);
                menu.loadData(data);
            }
        }) */

        //toggle
        $("#toggle, .sidebar-toggle").click(function () {
            $('body').toggleClass('compact');
            mini.layout();
        });

        //dropdown
        $(".dropdown-toggle").click(function (event) {
            $(this).parent().addClass("open");
            return false;
        });

        $(document).click(function (event) {
            $(".dropdown").removeClass("open");
        });
    });

</script>
