<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->

<head>
    <title>电销客户</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0; 
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .title {
            width: 90px;
            text-align: right;
        }

        .title.required {
            color: red;
        }

        .mini-panel-border {
            /*border-right: 0;*/

        }

        .mini-panel-body {
            padding: 0;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;margin-top: 10px;" id="form1">
        <table style="width:100%;">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
                    <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                        <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                        <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                        <li class="separator"></li>
                        <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                        <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                    </ul>
                    沟通日期:
                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    至
                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    <input id="carModel" name="carModel" class="nui-textbox" style="width: 100px;" emptyText="品牌">
                    <input id="visitId" name="visitId" class="nui-combobox" style="width: 100px;" emptyText="回访员"
                    textField="empName" valueField="empId" emptyText="请选择..."
                    showNullItem="true"nullItemText="请选择...">
                    <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" nullItemText="请选择..."
                    emptyText="兼职公司" url="" allowInput="true" showNullItem="true" width="130" valueFromSelect="true"/>
                    <a class="nui-button" iconcls="" name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" plain="false" onclick="load(0)" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;按品牌分组</a>
                    <a class="nui-button" plain="false" onclick="load(1)" id="" style="margin-right:5px;"><span class="fa fa-bars fa-lg"></span>&nbsp;按营销员分组</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" dataField="list" idField="detailId"
            ondrawcell="" sortMode="client" url="" totalField="page.count" pageSize="20" sizeList="[10,20,50,100]"
            showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                <div allowSort="true" field="groupName" name="groupName" width="60" headerAlign="center" align="center">品牌</div>
                <div allowSort="true" field="total" width="60" headerAlign="center" align="center">沟通总次数</div>
                <div header="沟通有效性" headerAlign="center">
                    <div property="columns">
                        <div allowSort="true" field="effective" width="60" headerAlign="center" align="center">有效沟通</div>
                        <div allowSort="true" field="invalid" width="60" headerAlign="center" align="center">无效沟通</div>
                    </div>
                </div>
                <div header="跟踪状态" headerAlign="center">
                    <div property="columns">
                        <div allowSort="true" field="goonScout" width="60" headerAlign="center" align="center">继续跟踪</div>
                        <div allowSort="true" field="keyScout" width="60" headerAlign="center" align="center">重点跟踪</div>
                        <div allowSort="true" field="stopScout" width="60" headerAlign="center" align="center">终止跟踪</div>
                    </div>
                </div>
                <div header="成交信息" headerAlign="center">
                    <div property="columns">
                        <div allowSort="true" field="hasCome" width="60" headerAlign="center" align="center">成交量</div>
                        <div allowSort="true" field="comeRate" width="60" headerAlign="center" align="center" numberFormat="p">成交率</div>
                    </div>
                </div>
                <div header="跟踪类型" headerAlign="center">
                    <div property="columns">
                        <div allowSort="true" field="telToScout" width="60" headerAlign="center" align="center">电话</div>
                        <div allowSort="true" field="infoToScout" width="60" headerAlign="center" align="center">短信</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.guestReport.queryTelGuestTotal.biz.ext';
        var grid1 = nui.get("grid1");
        var form=new nui.Form("#form1");
        grid1.setUrl(gridUrl);
        var currType = 2;
        var cType = 0;
        var startDateEl = nui.get("startDate");
        var endDateEl = nui.get("endDate");
        var orgidsEl = nui.get("orgids");
        quickSearch(3);

        //判断是否有兼职门店,是否显示门店选择框
        orgidsEl.setData(currOrgList);
        if(currOrgList.length==1){
            orgidsEl.hide();
        }else{
            orgidsEl.setValue(currOrgid);
        }

        initMember("visitId",function(){});

        function quickSearch(type) {
            var params = {};
            var queryname = "本日";
            switch (type) {
                case 0:
                    params.today = 1;
                    params.startDate = getNowStartDate();
                    params.endDate = addDate(getNowEndDate(), 1);
                    queryname = "本日";
                    break;
                case 1:
                    params.yesterday = 1;
                    params.startDate = getPrevStartDate();
                    params.endDate = addDate(getPrevEndDate(), 1);
                    queryname = "昨日";
                    break;
                case 2:
                    params.thisWeek = 1;
                    params.startDate = getWeekStartDate();
                    params.endDate = addDate(getWeekEndDate(), 1);
                    queryname = "本周";
                    break;
                case 3:
                    params.lastWeek = 1;
                    params.startDate = getLastWeekStartDate();
                    params.endDate = addDate(getLastWeekEndDate(), 1);
                    queryname = "上周";
                    break;
                case 4:
                    params.thisMonth = 1;
                    params.startDate = getMonthStartDate();
                    params.endDate = addDate(getMonthEndDate(), 1);
                    queryname = "本月";
                    break;
                case 5:
                    params.lastMonth = 1;
                    params.startDate = getLastMonthStartDate();
                    params.endDate = addDate(getLastMonthEndDate(), 1);
                    queryname = "上月";
                    break;

                case 10:
                    params.thisYear = 1;
                    params.startDate = getYearStartDate();
                    params.endDate = getYearEndDate();
                    queryname = "本年";
                    break;
                case 11:
                    params.lastYear = 1;
                    params.startDate = getPrevYearStartDate();
                    params.endDate = getPrevYearEndDate();
                    queryname = "上年";
                    break;
                default:
                    break;
            }
            currType = type;
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            params.groupByType = cType;
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                params.orgids =  currOrgs;
            }else{
                params.orgid=orgidsElValue;
            }
            grid1.load({params:params});
            updateGridColoumn(cType);
        }


        function updateGridColoumn(e){
            var column = grid1.getColumn("groupName");
            $("#carModel").hide();
            $("#visitId").hide();
            if(e == 0){
                grid1.updateColumn(column,{header:"品牌"});
                $("#carModel").show();
            }
            if(e == 1){
                grid1.updateColumn(column,{header:"营销员"});
                $("#visitId").show();
            }
        }


        function load(e){
            if(e != undefined){
                cType = e;
            }
            
            var data= form.getData();
            data.endDate = formatDate(data.endDate) +" 23:59:59";
            data.groupByType = cType;
            updateGridColoumn(cType);
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                data.orgids =  currOrgs;
            }else{
                data.orgid=orgidsElValue;
            }
            grid1.load({params:data,token :token});
        }

    </script>
</body>
</html>