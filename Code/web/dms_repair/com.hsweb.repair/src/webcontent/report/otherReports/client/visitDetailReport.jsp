<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->

<head>
    <title>回访明细明细表</title>
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
                    跟踪日期:
                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    至
                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    <li class="separator"></li>
                    <input id="guestName" name="guestName" class="nui-textbox" style="width: 100px;" emptyText="客户姓名">
                    <input id="carNo" name="carNo" class="nui-textbox" style="width: 100px;" emptyText="车牌号">
                    <input id="mobile" name="mobile" class="nui-textbox" style="width: 100px;" emptyText="手机号">
                    <input id="carModel" name="carModel" class="nui-textbox" style="width: 100px;" emptyText="品牌">
                    <input id="visitId" name="visitId" class="nui-combobox" style="width: 100px;" emptyText="回访员"
                    textField="empName" valueField="empId" emptyText="请选择..."
                    showNullItem="true"nullItemText="请选择...">
                    <input id="visitStatus" name="visitStatus" class="nui-combobox" style="width: 100px;" emptyText="回访状态"
                    data="visStatus" valueField="customid" textField="name"emptyText="请选择..."
                    allowInput="false"valueFromSelect="true" showNullItem="true"nullItemText="请选择...">
                    <input id="serviceType" name="serviceType" class="nui-combobox" style="width: 100px;" emptyText="回访类型"
                    data="visType" valueField="id" textField="text"emptyText="请选择..."
                    allowInput="false"valueFromSelect="true" showNullItem="true"nullItemText="请选择...">
                    <input id="visitMode" name="visitMode" class="nui-combobox" style="width: 100px;" emptyText="回访方式"
                    textField="name" valueField="customid"emptyText="请选择..."
                    allowInput="false"valueFromSelect="true" showNullItem="true"nullItemText="请选择...">
                    <input id="visitResult" name="visitResult" class="nui-combobox"visible="false" style="width: 100px;" emptyText="回访结果"
                    data="const_enabled_communicate" textField="text" valueField="value">
                    <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" nullItemText="请选择..."
                    emptyText="兼职公司" url="" allowInput="true" showNullItem="true" width="130" valueFromSelect="true"/>
                    <a class="nui-button" iconcls="" name="" plain="true" onclick="load()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
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
                <div field="carNo" name="carNo" width="60" headerAlign="center" align="center">车牌号</div>
                <div field="carModel" width="80" headerAlign="center" align="center">品牌车型</div>
                <div field="vin" width="90" headerAlign="center" align="center">车架号(VIN)</div>
                <div field="guestName" width="60" headerAlign="center" align="center">客户姓名</div>
                <div field="mobile" width="60" headerAlign="center" align="center">客户手机</div>
                <div field="serviceType" width="60" headerAlign="center" align="center">回访类型</div>
                <div field="visitMode" width="60" headerAlign="center" align="center">回访方式</div>
                <div field="visitResult" width="60" headerAlign="center" align="center">回访结果</div>
                <div field="visitContent" width="60" headerAlign="center" align="center">回访内容</div>
                <div field="visitStatus" width="60" headerAlign="center" align="center">回访状态</div>
                <div field="visitMan" width="60" headerAlign="center" align="center">回访员</div>
                <div field="visitDate" width="80" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">跟踪日期</div>
                <div field="orgid" name="orgid" width="100" headerAlign="center" align="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        
        var visStatus = [{customid:"060701",name:"继续跟踪"},
            {customid:"060702",name:"终止跟踪"},
            {customid:"060703",name:"重点跟踪"},
            {customid:"060704",name:"已来厂/已成交"}];
        var visType = [{ id: 1, text: '电销回访' }, { id: 2, text: '预约回访' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }];
        
        nui.parse();
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.guestReport.queryVisitDetail.biz.ext';
        var grid1 = nui.get("grid1");
        var form = new nui.Form("#form1");
        grid1.setUrl(gridUrl);
        var currType = 2;
        var startDateEl = nui.get("startDate");
        var endDateEl = nui.get("endDate");
        var orgidsEl = nui.get("orgids");
        var memList = {};
        var memHash = {};



        //判断是否有兼职门店,是否显示门店选择框
        orgidsEl.setData(currOrgList);
            if(currOrgList.length==1){
                orgidsEl.hide();
            }else{
                orgidsEl.setValue(currOrgid);
            }

        initDicts({
            visitMode: "DDT20130703000021",//跟踪方式
        });

        initMember("visitId",function(){
            memList = nui.get("visitId").getData();
            memList.forEach(function(v) {
                memHash[v.empId] = v;
            });
                    quickSearch(4);
        });

        grid1.on("drawcell", function (e) { //表格绘制
            var field = e.field;
            if(field == "visitResult"){//跟踪结果
                e.cellHtml = setColVal('visitResult', 'value', 'text', e.value);
            }else if(field == "visitMode"){//跟踪方式
                e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
            }else if(field == "visitStatus"){//跟踪状态
                e.cellHtml = setColVal('visitStatus', 'customid', 'name', e.value);
            }else if(field == "serviceType"){//业务类型
                e.cellHtml = setColVal('serviceType', 'id', 'text', e.value);
            }else if(field == "mobile"){//手机
                e.cellHtml = changedTel(e);
            }else if(field == "visitId"){//营销员
                if(memHash[e.value]){
                    e.cellHtml = memHash[e.value].empName || "";
                }
            }else if(e.field == "orgid"){
                for(var i=0;i<currOrgList.length;i++){
                    if(currOrgList[i].orgid==e.value){
                        e.cellHtml = currOrgList[i].shortName;
                    }
                }
            }
        });


			function changedTel(e) {
			    var uid = e.record._uid;
			    var value = e.value
			    var res = {};
			    value = "" + value;
			    var reg=/(\d{3})\d{4}(\d{4})/;
			    value = value.replace(reg, "$1****$2");
			    if(e.value){
			            res =  value;
			    }else{
			        res="";
			    }
			    return res;
			}

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
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
                params.orgids =  currOrgs;
            }else{
                params.orgid=orgidsElValue;
            }
            grid1.load({params:params});
        }

        function load(e){
            if(e != undefined){
            }
            
            var data= form.getData();
            data.endDate = formatDate(data.endDate) +" 23:59:59";
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