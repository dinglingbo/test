<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-12-11 20:01:24
  - Description:
-->

<head>
    <title>客户群发</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>
    <script src="<%= request.getContextPath() %>/common/nui/macarons.js" type="text/javascript"></script>
    <script src="<%=webPath + contextPath%>/manage/js/guestType.js?v=0.5.3" type="text/javascript"></script>
    <style type="text/css">
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        #wechatTag1{
            color:#ccc;
    }
    #wechatTag{
        color:#62b900;
    }
    </style>
</head>

<body>

    <div class="nui-fit">
        <div id="t1" style="width: 100%; height: 100%;">
            <div id="t2" style="float:left;width: 40%; height: 100%;">
                <div class="nui-fit">
                    <div id="lindChatA" style="width:490px;height:530px;"></div>
                </div>
            </div>

            <div id="t3" style="float:left;width: 60%; height: 100%;">
                <div id="tabs1" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;" plain="true"
                onactivechanged=""
                    tabPosition="top">
                    <div title="客户类型" name="type">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" id="form1">
                                    <table style="width:100%;">
                                        <tr>
                                            <td colspan="2">
                                                <label>客户类型：</label>
                                                <input class="nui-combobox" name="type" id="type" style="width: 300px;"  required="false" multiSelect="false"
                                                data="gType" textField="text" valueField="id" allowInput="true" valueFromSelect="true" />
                                            </td>
                                        </tr>

                                        <tr>
                                                <td>
                                                    <label>车辆品牌：</label>
                                                    <input id="cbrand" name="cbrand" class="nui-combobox" dataField="list" required="false"  onvaluechanged="onBrandChanged" 
                                                    textField="nodeName" valueField="nodeId"   style="width:200px"
                                                    allowInput="true" valueFromSelect="true" />
                                                </td>
                                                <td>
                                                    <label>车辆车系：</label>
                                                    <input id="cmodel" name="cmodel"class="nui-combobox" dataField="list"  multiSelect="true"
                                                    textField="nodeName" valueField="nodeId"  allowInput="false"  
                                                    showClose="true" oncloseclick="onCloseClick" style="width:200px"/>
                                                </td>
                                            </tr>

                                            <tr>
                                                    <td>
                                                        <label>客户等级：</label>
                                                        <input class="nui-combobox" name="level" id="level" style="width: 200px;"  required="false" multiSelect="true"
                                                        textField="name" valueField="id" allowInput="false" />
                                                    </td>
                                                    <td>
                                                        <label>维修顾问：</label>
                                                                <input class="nui-combobox" name="mta" id="mta" style="width: 200px;"  required="false" multiSelect="true"
                                                                textField="empName" valueField="empId" allowInput="true" valueFromSelect="true" />
                                
                                                    </td>
                                                </tr>
 
                                                <tr>
                                                        <td>
                                                            <label>消费金额在</label>
                                                            <input class="nui-textbox" name="startAmt" id="startAmt" style="width: 50px;" vtype="int" value=""/>
                                                            <label>-</label>
                                                            <input class="nui-textbox" name="endAmt" id="endAmt" style="width: 50px;" vtype="int" value=""/>
                                                            <label>元之间</label>
                                                        </td>
                                                        <td>
                                                            <label>消费次数在</label>
                                                            <input class="nui-textbox" name="startTime" id="startTime" style="width: 50px;" vtype="int" value=""/>
                                                            <label>-</label>
                                                            <input class="nui-textbox" name="endTime" id="endTime" style="width: 50px;" vtype="int" value=""/>
                                                            <label>次之间</label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                            <td>
                                                                <label>行驶里程在</label>
                                                                <input class="nui-textbox" name="startKilo" id="startKilo" style="width: 50px;" vtype="int" value=""/>
                                                                <label>-</label>
                                                                <input class="nui-textbox" name="endKilo" id="endKilo" style="width: 50px;" vtype="int" value=""/>
                                                                <label>公里之间</label>
                                                            </td>
                                                            <td>
                                                                <label>离厂天数在</label>
                                                                <input class="nui-textbox" name="startDay" id="startDay" style="width: 50px;" vtype="int" value=""/>
                                                                <label>-</label>
                                                                <input class="nui-textbox" name="endDay" id="endDay" style="width: 50px;" vtype="int" value=""/>
                                                                <label>天之间</label>
                                                            </td>
                                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                            <!--<div id="isWechat1" name="isWechat1" class="nui-checkbox" readOnly="false" text="已绑定微信" ></div>-->
                                                    <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                                        <span class="separator"></span>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                 <!-- <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a> -->
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridkhlx" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="110" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="80" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="150" headerAlign="center" header="品牌车型"></div>
                                            <div field="chainComeTimes" name="" width="70" headerAlign="center" header="消费次数" ></div>
                                            <div field="chainConsumeAmt" name="" width="70" headerAlign="center" header="消费金额" ></div>
                                            <!--<div field="chainComeTimes" name="" width="70" headerAlign="center" header="来厂次数" ></div>-->
                                            <div field="leaveDay" name="" width="70" headerAlign="center" header="离厂天数" ></div>
                                            <div field="lastComeKilometers" name="" width="70" headerAlign="center" header="行驶里程" ></div>
                                            <div field="tgrade" name="tgrade" width="70" headerAlign="center" header="客户等级" ></div>
                                            <div field="mtAdvisorName" name="" width="70" headerAlign="center" header="维修顾问" ></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    
                    <div title="商业险到期" name="annual">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>商业险到期在</label>
                                                <input class="nui-textbox" name="" id="annual" style="width: 50px;" vtype="int" value="30"/>
                                                <label>天以内</label>
                                                <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>操作：</label>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridsyx" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                            <div field="annualInspectionDate" name="" width="70" headerAlign="center" header="商业险到期" dateFormat="yyyy-MM-dd"></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    <div title="交强险到期"name="insure" enabled="true">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>交强险到期在</label>
                                                <input class="nui-textbox" name="" id="insure" style="width: 50px;" vtype="int" value="30"/>
                                                <label>天以内</label>
                                                <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>操作：</label>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridjqx" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                            <div field="insureDueDate" name="" width="70" headerAlign="center" header="交强险到期" dateFormat="yyyy-MM-dd"></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    <div title="保养到期" name="care"enabled="true">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>保养到期在</label>
                                                <input class="nui-textbox" name="" id="care" style="width: 50px;" vtype="int" value="30"/>
                                                <label>天以内</label>
                                                <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>操作：</label>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridbydq" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                            <div field="careDueDate" name="" width="70" headerAlign="center" header="保养到期" dateFormat="yyyy-MM-dd"></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    <div title="车辆年检到期" name="due" enabled="true">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>车辆年检到期在</label>
                                                <input class="nui-textbox" name="" id="due" style="width: 50px;" vtype="int" value="30"/>
                                                <label>天以内</label>
                                                <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>操作：</label>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                 <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a> 
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridclnj" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                            <div field="dueDate" name="" width="70" headerAlign="center" header="车辆年检到期" dateFormat="yyyy-MM-dd"></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    <div title="驾照年审到期" name="lic" enabled="true">
                            <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>驾照年审到期在</label>
                                                <input class="nui-textbox" name="" id="license" style="width: 50px;" vtype="int" value="30"/>
                                                <label>天以内</label>
                                                <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                        class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                                    <table style="width:100%;">
                                        <tr>
                                            <td>
                                                <label>操作：</label>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                        class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                        class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                        class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        
                                <div class="nui-fit">
                                    <div id="gridjzns" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                        multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                        onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                        <div property="columns">
                                            <!-- <div type="checkcolumn"></div> -->
                                            <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                            <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                            <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                            <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                            <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                            <div field="licenseOverDate" name="" width="70" headerAlign="center" header="驾照年审到期" dateFormat="yyyy-MM-dd"></div>
                                        </div>
                                    </div>
                                </div>
                    </div>
                    <div title="客户生日" name="bir" enabled="true">
                        <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                            <table style="width:100%;">
                                <tr>
                                    <td>
                                        <label>客户生日在</label>
                                        <input class="nui-textbox" name="" id="birday" style="width: 50px;" vtype="int" value="30"/>
                                        <label>天以内</label>
                                        <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                                                class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-toolbar" style="padding:2px;border-bottom: 0" >
                            <table style="width:100%;">
                                <tr>
                                    <td>
                                        <label>操作：</label>
                                        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(1)"><span
                                                class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                        <!-- <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(2)"><span
                                                class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a> -->
                                        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(3)"><span
                                                class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo(4)"><span
                                                class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="nui-fit">
                            <div id="gridkhsr" class="nui-datagrid" style="width:100%;height:100%;" pageSize="50"
                                multiSelect="false" totalField="page.count" sizeList=[20,50,100,200] dataField="list"
                                onrowdblclick="" allowCellSelect="true" allowCellWrap=true ondrawcell="">
                                <div property="columns">
                                    <!-- <div type="checkcolumn"></div> -->
                                    <div type="indexcolumn" headerAlign="center" width="40" header="序号"></div>
                                    <div field="guestName" name="" width="70" headerAlign="center" header="客户名称"></div>
                                    <div field="mobile" name="" width="80" headerAlign="center" header="联系方式"></div>
                                    <div field="carNo" name="" width="70" headerAlign="center" header="车牌号"></div>
                                    <div field="carModel" name="" width="100" headerAlign="center" header="品牌车型"></div>
                                    <div field="birthday" name="" width="70" headerAlign="center" header="生日" dateFormat="yyyy-MM-dd"></div>
                                </div>
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
        var webBaseUrl = webPath + contextPath + "/";
        var turl = apiPath + crmApi + "/com.hsapi.crm.svr.guest.getGuestTypeNum.biz.ext";
        var echartData = {};

        $("a[name=type]").click(function () {
            if (!$(this).hasClass("xz")) {
                $(this).addClass("xz");
            } else {
                $(this).removeClass("xz");
            }
        });
        getEchartDate();


 

        function getEchartDate() {
            nui.ajax({
                url: turl, 
                type: "post",
                data: {
                token:token
                },
                success: function (res) {
                    if (res.errCode == 'S') {
                        if (res.carNum != []) {
                            echartData = res.carNum[0];
                            showMainA();
                            //     var p = {
                            //         name: '全 部', //初始化
                            //         color:'#2ec7c9'
                            // }
                            // setGuestType(p);
                        }
                    } else {
                        showMsg('接口执行错误！', 'E');
                    }
                }
            })

        }

        function showMainA() {

            var option = {
                title: {
                    text: '客户分类',
                    //subtext: ''
                    x: 'center',
                    y: 'bottom',
                    textStyle: {
                        color: '#000',
                        fontStyle: 'bold'
                    }
                },
                tooltip: {
                    trigger: 'item',
                    //formatter: "{a} <br/>{b} : {c}%"
                    formatter: showTooltip
                },
                //toolbox: {
                //    feature: {
                //        dataView: {readOnly: false},
                //        restore: {},
                //        saveAsImage: {}
                //    }
                //},
                legend: {
                    data: ['全 部', '未分类', '流失期', '睡眠期', '稳定期', '活跃期'],
                    x: 'center',
                    y: 20,
                },
                calculable: true,
                series: [{
                    name: '客户类型',
                    type: 'funnel',
                    left: '10%',
                    top: 60,
                    //x2: 80,
                    bottom: 60,
                    width: '80%',
                    // height: {totalHeight} - y - y2,
                    min: 0,
                    max: 100,
                    minSize: '0%',
                    maxSize: '100%',
                    sort: 'descending',
                    gap: 2,
                    label: {
                        normal: {
                            show: true,
                            position: 'inside'
                        },
                        emphasis: {
                            textStyle: {
                                fontSize: 20
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            length: 10,
                            lineStyle: {
                                width: 1,
                                type: 'solid'
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderColor: '#CCC',
                            borderWidth: 1
                        }
                    },
                    data: [{
                            //value: echartData.allCarNum || 0,
                            value: 100,
                            name: '全 部'
                        },
                        {
                            // value: echartData.notypeCarNum|| 0,
                            value: 80,
                            name: '未分类'
                        },
                        {
                            // value: echartData.loseCarNum|| 0,
                            value: 60,
                            name: '流失期'
                        },
                        {
                            //value: echartData.sleepCarNum|| 0,
                            value: 40,
                            name: '睡眠期'
                        },
                        {
                            //value: echartData.stableCarNum|| 0,
                            value: 20,
                            name: '稳定期'
                        },
                        {
                            // value: echartData.activeCarNum|| 0,
                            value: 10,
                            name: '活跃期'
                        }
                    ],
                    // color: ['rgb(239,219,200)','rgb(137,246,100)','rgb(155,314,203)','rgb(155,155,146)','rgb(111,222,100)']
                }]
            };

            var myChart = echarts.init(document.getElementById('lindChatA'), 'macarons');

            //使用刚指定的配置项和数据显示图表。
            myChart.setOption(option, true);
            window.onresize = function () {
                myChart.resize();
            };

            myChart.on('click', function (param) {
                //console.log(param); //重要的参数都在这里！
                setGuestType(param);
            });

            var app = {};
            app.currentIndex = -1;

            setInterval(function () {
                var dataLen = option.series[0].data.length;
                // 取消之前高亮的图形
                myChart.dispatchAction({
                    type: 'downplay',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
                app.currentIndex = (app.currentIndex + 1) % dataLen;
                // 高亮当前图形
                myChart.dispatchAction({
                    type: 'highlight',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
                // 显示 tooltip
                myChart.dispatchAction({
                    type: 'showTip',
                    seriesIndex: 0,
                    dataIndex: app.currentIndex
                });
            }, 2000);
        }

        function setGuestType(params) {
            var typeValue = null;
            var value = '';
            switch (params.name) {
                case '全 部':
                    typeValue = '';
                    value = echartData.allCarNum;
                    break;
                case '未分类':
                    typeValue = 6;
                    value = echartData.notypeCarNum;
                    break;
                case '流失期':
                    typeValue = 5;
                    value = echartData.loseCarNum;
                    break;
                case '睡眠期':
                    typeValue = 4;
                    value = echartData.sleepCarNum;
                    break;
                case '稳定期':
                    typeValue =3;
                    value = echartData.stableCarNum;
                    break;
                case '活跃期':
                    typeValue = 2;
                    value = echartData.activeCarNum;
                    break;
                default:
                    typeValue = 0;
                    value = '';
                    break;
            }
            var typeEl=nui.get("type");
            typeEl.setValue(typeValue);
            search();
           // value = value || 0;
            // var html = "<a href='javascript:;' typeValue='" + typeValue +
            //     "'style='border:0px;cursor:default;color:#fff;margin-bottom:0px;background-color:" + params.color +
            //     "'class='guestTypeCla'>" + params.name + '(' + value + ')' + "</a>";
            // console.log(html);
            // $('#selectGuestType').html(html);

        }

var gType = [{ id: 1, text: "首修客户 (最近一个月的首次消费车辆)" },
{ id: 2, text: "活跃期 (来店至少2次且30天内消费过的车辆)" },
{ id: 3, text: "稳定期 (来店至少2次且31-90天内消费过车辆)" },
{ id: 4, text: "睡眠期 (来店至少1次且离店天数在91-180天内)" },
{ id: 5, text: "流失期 (来店至少1次且离店天数181天及以上)" },
{ id: 6, text: "未分类 (未来过店)" }];

        var showTooltip = function showEchartTooltip(vla) {
            var value = 0;
            switch (vla.name) {
                case '全 部':
                    value = echartData.allCarNum;
                    break;
                case '未分类':
                    value = echartData.notypeCarNum;
                    break;
                case '流失期':
                    value = echartData.loseCarNum;
                    break;
                case '睡眠期':
                    value = echartData.sleepCarNum;
                    break;
                case '稳定期':
                    value = echartData.stableCarNum;
                    break;
                case '活跃期':
                    value = echartData.activeCarNum;
                    break;
                default:
                    value = 0
                    break;
            }
            value = value || 0;
            return vla.seriesName + '<br>' + vla.name + ':' + value;
        }
    </script>
</body>

</html>