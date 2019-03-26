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
    <title>客户资料汇总</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://unpkg.com/echarts@3.5.3/dist/echarts.js"></script>
    <script src="<%= request.getContextPath() %>/common/nui/macarons.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>
        .parent{display:flex;}
        .column{flex:1;border-radius:10px;background-color:#95d9f966;margin-top:20px;padding:10px;}
        .column+.column{margin-left:20px;} 
        .incomeTitle{
            margin: 10px 0px 0px 5px;
            color: #23c0fa;
            font-size:18px;
            font-weight: normal;
        }
        .incomeStyle{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:28px;
        }
        .incomeStyle2{
            margin: 10px 0px 0px 0px;
            text-align: center;
            color: #f9a52e ;
            font-size:18px; 
        }
         .parent div:hover{
            background-color:#B0D6F9;
            
            cursor: pointer;
        }
        .parent div:hover p{
            color:#fff ;
        }
        .parent div:hover h3{
            color:#fff ;
        }
        .parent div:hover p>span{
            color:#fff ;
        }
        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:2px;color:#2d79aa;margin-top: 10px;" id="form1">
        <table style="width:100%;">
            <tr>
                <td>
                    <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" nullItemText="请选择..."
                    emptyText="兼职公司" url="" allowInput="true" showNullItem="true" width="130" valueFromSelect="true"/>
                    <a class="nui-button" iconcls="" name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>


    <div style="height: 150px;" class="parent">

        <div class="column">
            <h3 class="incomeTitle">总客户数</h3>
            <p id="pdata1" class="incomeStyle" style="margin-top: 20px;">0</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">总车辆数</h3>
            <p id="pdata2" class="incomeStyle" style="margin-top: 20px;">0</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">已来厂车辆</h3>
            <p id="pdata3" class="incomeStyle" style="margin-top: 20px;">0</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">未来厂车辆</h3>
            <p id="pdata4" class="incomeStyle" style="margin-top: 20px;">0</p>
        </div>
        <div class="column">
            <h3 class="incomeTitle">禁用车辆</h3>
            <p id="pdata5" class="incomeStyle" onclick="toGuestCar()" style="margin-top: 20px;">0</p>
        </div>

    </div>

    <div class="nui-fit">
        <div id="t1" style="width: 100%; height: 100%;padding:10px 0px 0px 0px;display: inline-block;">
            <div id="t2" style="float:left;width: 49.5%; height: 100%;">
                <div style="border-bottom:1px solid #ccc;">
                    <span class="titleText">已来厂客户</span>
                </div>
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;margin-top: 10px;" id="queryForm">
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <label style="font-family:Verdana;">分组查询条件：</label>
                                <a class="nui-button" plain="false" onclick="GridLoad1(0)" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;品牌</a>
                                <a class="nui-button" plain="false" onclick="GridLoad1(1)" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;SA</a>
                                <a class="nui-button" plain="false" onclick="GridLoad1(2)" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;来厂次数</a>
                                <!-- <a class="nui-button" plain="false" onclick="GridLoad1(3)" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;金额</a> -->
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%" idField="id" allowResize="false"
                        showPager="true" pageSize="20" pageList="[10,20,50,100]" totalField="page.count" showColumns="true"
                        showSummaryRow="true" dataField="list">
                        <div property="columns">
                            <div field="groupName" name="groupName" width="100" headerAlign="center" align="left">品牌</div>
                            <div field="allCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">总数</div>
                            <div field="firstCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">新客户</div>
                            <div field="activeCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">活跃期</div>
                            <div field="stableCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">稳定期</div>
                            <div field="sleepCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">睡眠期</div>
                            <div field="loseCarNum" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">流失期</div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="t4" style="float:left;width: 1%; height:-webkit-fill-available;display:block;"></div>
            <div id="t3" style="float:left;width: 49.5%; height: 100%;">
                <div style="border-bottom:1px solid #ccc;">
                    <span class="titleText">营销客户</span>
                </div>
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;margin-top: 10px;" id="queryForm">
                    <table style="width:100%;">
                        <tr>
                            <td>
                                <label style="font-family:Verdana;">分组查询条件：</label>
                                <a class="nui-button" plain="false" onclick="GridLoad2(0);" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;品牌</a>
                                <a class="nui-button" plain="false" onclick="GridLoad2(1);" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;营销员</a>
                                <!-- <a class="nui-button" plain="false" onclick="GridLoad2(0);" id="" style="margin-right:5px;">
                                    <span class="fa fa-bars fa-lg"></span>&nbsp;意向等级</a> -->
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="datagrid2" class="mini-datagrid" style="width:100%;height:100%;" idField="id" allowResize="false"
                        showPager="true" pageSize="20" pageList="[10,20,50,100]" showColumns="true" showSummaryRow="true"
                        dataField="list" totalField="page.count">
                        <div property="columns">
                            <div field="groupName" name="groupName" width="100" headerAlign="center" align="center">品牌</div>
                            <div field="total" width="60" headerAlign="center" align="center" dataType="int"
                                summaryType="sum">总数</div>
                            <div field="" headerAlign="center" align="center">联系状态
                                <div property="columns">
                                    <div field="goonScout" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">已联系</div>
                                    <div field="noScout" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">未联系</div>
                                    <div field="stopScout" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">终止联系</div>
                                </div>

                            </div>
                            <div field="" headerAlign="center" align="center">来厂状态
                                <div property="columns">
                                    <div field="hasCome" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">已来厂</div>
                                    <div field="noCome" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">未来厂</div>
                                </div>

                            </div>
                            <div field="" headerAlign="center" align="center">资料有效状态
                                <div property="columns">
                                    <div field="effective" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">有效资料</div>
                                    <div field="invalid" width="60" headerAlign="center" align="center" dataType="int"
                                        summaryType="sum">无效资料</div>
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
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var grid1 = nui.get("datagrid1");
        var grid2 = nui.get("datagrid2");
        var orgidsEl = nui.get("orgids");
        var form1 = nui.get("form1");
        var mainDataUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.guestReport.queryGuestAndCar.biz.ext';
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.guestReport.queryComeGuest.biz.ext';
        var gridUrl2 = apiPath + repairApi + '/com.hsapi.repair.repairService.guestReport.queryGuestTotal.biz.ext';
        grid1.setUrl(gridUrl);
        grid2.setUrl(gridUrl2);

        //判断是否有兼职门店,是否显示门店选择框
        orgidsEl.setData(currOrgList);
        if(currOrgList.length==1){
            form1.hide();
        }else{
            orgidsEl.setValue(currOrgid);
        }

        GridLoad1(0);
        GridLoad2(0);
        loadMainData();
        function load() {
            loadMainData();
            GridLoad1(0);
            GridLoad2(0);
        }

        function loadMainData() {
            var params = {};
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                params.orgids =  currOrgs;
            }else{
                params.orgid=orgidsElValue;
            }
            nui.ajax({
                url:mainDataUrl,
                type:"post",
                data:{params:params},
                success:function(res){
                    var data = res;
                    document.getElementById("pdata1").innerHTML= data.guestList[0].num||0;
                    document.getElementById("pdata2").innerHTML= data.carList[0].num||0;
                    document.getElementById("pdata3").innerHTML= data.carList[0].hasComeNum||0;
                    document.getElementById("pdata4").innerHTML= data.carList[0].noComeNum||0;
                    document.getElementById("pdata5").innerHTML= data.carIsDisabled[0].isDisabledNum||0;
                }
            })
        }

        function GridLoad1(e) {
            var column = grid1.getColumn("groupName");
            var params = {};
            params.groupByType = e;
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                params.orgids =  currOrgs;
            }else{
                params.orgid=orgidsElValue;
            }
            switch (e) {
                case 0:
                    grid1.updateColumn(column, {
                        header: "品牌"
                    });
                    break;
                case 1:
                    grid1.updateColumn(column, {
                        header: "SA"
                    });
                    break;
                case 2:
                    grid1.updateColumn(column, {
                        header: "来厂次数"
                    });
                    break;
                case 3:
                    grid1.updateColumn(column, {
                        header: "金额"
                    });
                    break;
                default:
                    break;
            }
            grid1.load({
                params: params,
                token: token
            });
        }

        function GridLoad2(e) {
            var column = grid2.getColumn("groupName");
            var params = {};
            params.groupByType = e;
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                params.orgids =  currOrgs;
            }else{
                params.orgid=orgidsElValue;
            }
            switch (e) {
                case 0:
                    grid2.updateColumn(column, {
                        header: "品牌"
                    });
                    break;
                case 1:
                    grid2.updateColumn(column, {
                        header: "营销员"
                    });
                    break;
                default:
                    break;
            }
            grid2.load({
                params: params,
                token: token
            });
        }
        function toGuestCar(){
	        var item={};
		    item.id = "2101";
		    item.text = "客户车辆";
		    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CustomerProfileMain.flow?token="+token;
		    item.iconCls = "fa fa-file-text";
		    var params = {id:"isDisabledCar"};
		    window.parent.activeTabAndInit(item,params);
        }
    </script>
</body>

</html>