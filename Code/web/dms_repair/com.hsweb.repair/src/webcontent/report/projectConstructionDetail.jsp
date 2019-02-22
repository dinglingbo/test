<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->

<head>
    <title>施工项目明细（应收）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<%@include file="/common/commonPart.jsp"%>
 <%--    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" /> --%>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>

<body>
    <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox " textField="name" valueField="id" visible="false" />
    <div id="form1" class="mini-toolbar" style="padding:10px;">
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
        结算日期:
        <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
        <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
        <input class="nui-textbox" id="serviceCode" name="serviceCode" emptytext="工单号">
        <input class="nui-textbox" id="itemName" name="itemName" emptytext="项目名称">
        <input class="nui-textbox" id="carNo" name="carNo" emptytext="车牌号" style="width: 90px;">
        <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
            emptyText="服务顾问" url="" allowInput="true" showNullItem="false" style="width:90px;" valueFromSelect="true"
            nullItemText="服务顾问" />
        <!-- <input class="nui-textbox" id=""name=""emptytext="配件分类"> -->
         <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
        <a class="nui-button" iconcls="" plain="true" name="" onclick="Search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
       <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>  
    </div>

    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true"     pageSize="500" sizeList="[500,1000,2000]"url="" allowcellwrap="true" style="width:100%;height:100%;" sortMode="client"
            totalField="page.count" showSummaryRow = "true" allowSortColumn="true"> 
            <div property="columns">
            	<div type="indexcolumn" width="40" >序号</div>
                <div field="serviceCode" name="serviceCode" headeralign="center" width="170" align="center" summaryType="count" allowsort="true">工单号</div>
                <div field="serviceTypeId" name="serviceTypeId" headeralign="center" width="80" align="center" allowsort="true">业务类型</div>
                <div field="itemName" name="itemName" headeralign="center" width="100" align="center" allowsort="true">项目名称</div>
                <div field="carNo" name="carNo" headeralign="center" width="80" align="center" allowsort="true">车牌号</div>
                <div field="carModel" name="carModel" headeralign="center" width="200" align="center" width="160" allowsort="true">品牌车型</div>
                <div field="guestName" name="guestName" headeralign="center" width="100" align="center" allowsort="true">客户名称</div>
                <div field="carVin" name="carVin" headeralign="center" width="150" align="center" allowsort="true">车架号(VIN)</div>
                <div field="itemTime" name="itemTime" headeralign="center" width="80" align="center" summaryType="sum" allowsort="true">工时</div>
                <div field="unitPrice" name="unitPrice" headeralign="center" width="80" align="center" summaryType="sum" allowsort="true">单价</div>
                <div field="amt" name="amt" headeralign="center" width="80" align="center" summaryType="sum" allowsort="true">金额</div>
                <div field="rate" name="rate" headeralign="center" width="80" align="center"  allowsort="true">优惠率</div>
                <div field="subtotal" name="subtotal" headeralign="center" width="80" align="center" summaryType="sum" allowsort="true">小计</div>
                <!-- <div field="" name="" headeralign="center" width="100" align="center">来店途径</div> -->
                <div field="workers" name="workers" headeralign="center" width="100" align="center" allowsort="true">施工员</div>
                <div field="status" name="status" renderer="onStatusRenderer" headeralign="center" width="80" align="center" allowsort="true">状态</div>
                <div field="isBack" name="isBack" renderer="onIsBackRenderer" headeralign="center" width="80" align="center" allowsort="true">是否返工</div>
                <div field="mtAdvisor" name="mtAdvisor" headeralign="center" width="100" align="center" allowsort="true">服务顾问</div>
                <div field="finishDate" name="finishDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd" allowsort="true">完工日期</div>
                <div field="outDate" name="outDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd" allowsort="true">结算日期</div>
                <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
            </div>
        </div>
    </div>
<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
        	<td colspan="1" align="center">工单号</td>
            <td colspan="1" align="center">业务类型</td>
            <td colspan="1" align="center">项目名称</td>
             <td colspan="1" align="center">车牌号</td>           
            <td colspan="1" align="center">品牌/车型</td>          
            <td colspan="1" align="center">客户名称</td>
            <td colspan="1" align="center">车架号(VIN)</td>        
            <td colspan="1" align="center">工时</td>
            <td colspan="1" align="center">单价</td>
            <td colspan="1" align="center">金额</td>
            
            <td colspan="1" align="center">优惠率</td>
            <td colspan="1" align="center">小计</td>
            <td colspan="1" align="center">施工员</td>
            <td colspan="1" align="center">状态</td>
           <!--  <td colspan="1" align="center">是否返工</td>  -->           
            <td colspan="1" align="center">服务顾问</td>         
            <td colspan="1" align="center">完工日期</td>
            <td colspan="1" align="center">结算日期</td>
                     
            
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  
    <script type="text/javascript">
        nui.parse();
        var orgidsEl = null;
        var statusList = [{
            id: 0,
            text: '草稿'
        }, {
            id: 1,
            text: '已完工'
        }];
        var isBackList = [{
            id: 0,
            text: '未返工'
        }, {
            id: 1,
            text: '已返工'
        }];
        var mtAdvisorIdEl = nui.get("mtAdvisorId");
        var webBaseUrl = webPath + contextPath + "/";
        var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
        var grid = nui.get("grid");
        var gridUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.report.queryItemTotalDetailReport.biz.ext';
        var form = new nui.Form("#form1");
        var startDateEl = nui.get("startDate");
        var endDateEl = nui.get("endDate");
        var serviceTypeIdEl = nui.get("serviceTypeId");
        var servieTypeList = [];
        var servieTypeHash = {};
        grid.setUrl(gridUrl);
        quickSearch(3);
        initMember("mtAdvisorId", function () {
            //memList = mtAdvisorIdEl.getData();
            //nui.get("checkManId").setData(memList);
        });

        orgidsEl = nui.get("orgids");
        orgidsEl.setData(currOrgList);
        if(currOrgList.length==1){
    	   orgidsEl.hide();
        }else{
    	  orgidsEl.setValue(currOrgid);
        }
        initServiceType("serviceTypeId", function (data) {
            servieTypeList = nui.get("serviceTypeId").getData();
            servieTypeList.forEach(function (v) {
                servieTypeHash[v.id] = v;
            });
        });

        function onStatusRenderer(e) {
            for (var i = 0, l = statusList.length; i < l; i++) {
                var g = statusList[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }

        function onIsBackRenderer(e) {
            for (var i = 0, l = isBackList.length; i < l; i++) {
                var g = isBackList[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }


        grid.on("drawcell", function (e) {
            if (e.field == "serviceTypeId") {
                e.cellHtml = servieTypeHash[e.value].name;
            }
			if (e.field == "rate") {
                e.cellHtml = e.value+"%";
            }
            if (e.field == "orgid"){
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].name;
	        		}
	        	}
           }
            document.onkeyup = function (event) {
                var e = event || window.event;
                var keyCode = e.keyCode || e.which; // 38向上 40向下


                if ((keyCode == 13)) { // F9
                    Search();
                }
            }
        });    

	  var filter = new HeaderFilter(grid, {
	        columns: [
	            { name: 'itemName' },
	            { name: 'carModel' },
	            { name: 'serviceCode' },
	            { name: 'carNo' },
		            { name: 'workers' },
	            { name: 'mtAdvisor' },
	            { name: 'guestName' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
        function Search() {
            var data = form.getData();
            var eDate = nui.get("endDate").getFormValue();
            if (eDate) {
                data.endDate = eDate + " 23:59:59";
            }
            var orgidsElValue = orgidsEl.getValue();
            if(orgidsElValue==null||orgidsElValue==""){
    	      data.orgids =  currOrgs;
           }else{
    	      data.orgid=orgidsElValue;
           }
            grid.load({
                params: data
            });
        }



        var currType = 2;

        function quickSearch(type) {
            var params = form.getData();
            var queryname = "本日";
            switch (type) {
                case 0:
                    params.today = 1;
                    params.startDate = getNowStartDate();
                    params.endDate = addDate(getNowEndDate(), 0);
                    queryname = "本日";
                    break;
                case 1:
                    params.yesterday = 1;
                    params.startDate = getPrevStartDate();
                    params.endDate = addDate(getPrevEndDate(), 0);
                    queryname = "昨日";
                    break;
                case 2:
                    params.thisWeek = 1;
                    params.startDate = getWeekStartDate();
                    params.endDate = addDate(getWeekEndDate(), 0);
                    queryname = "本周";
                    break;
                case 3:
                    params.lastWeek = 1;
                    params.startDate = getLastWeekStartDate();
                    params.endDate = addDate(getLastWeekEndDate(), 0);
                    queryname = "上周";
                    break;
                case 4:
                    params.thisMonth = 1;
                    params.startDate = getMonthStartDate();
                    params.endDate = addDate(getMonthEndDate(), 0);
                    queryname = "本月";
                    break;
                case 5:
                    params.lastMonth = 1;
                    params.startDate = getLastMonthStartDate();
                    params.endDate = addDate(getLastMonthEndDate(), 0);
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
            // doSearch(params);

            //     if(params.endDate){
            //         params.endDate = params.endDate +" 23:59:59";
            //     }
            grid.load({
                params: params
            });
        }
        
 function onExport(){
	
	var billTypeIdHash = [{name:"综合",id:"0"},{name:"检查",id:"1"},{name:"洗美",id:"2"},{name:"销售",id:"3"},{name:"理赔",id:"4"},{name:"退货",id:"5"}];

	var detail = grid.getData();
	
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<billTypeIdHash.length;j++){
			if(detail[i].billTypeId==billTypeIdHash[j].id){
				detail[i].billTypeId=billTypeIdHash[j].name;
			}
		}
		
		for(var key in servieTypeHash){
			if(detail[i].serviceTypeId==servieTypeHash[key].id){
				detail[i].serviceTypeId=servieTypeHash[key].name;
			}
		}
		for(var j=0;j<statusList.length;j++){
			if(detail[i].status==statusList[j].id){
				detail[i].status=statusList[j].text;
			}
		}

	}
	

	
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[serviceCode]</td>' +
        "<td  colspan='1' align='left'>[serviceTypeId]</td>" +
        "<td  colspan='1' align='left'>[itemName]</td>" +
        "<td  colspan='1' align='left'>[carNo]</td>" +
        "<td  colspan='1' align='left'>[carModel]</td>" +
        
        "<td  colspan='1' align='left'>[guestName]</td>" +
        "<td  colspan='1' align='left'>[carVin]</td>" +
        "<td  colspan='1' align='left'>[itemTime]</td>" +
        "<td  colspan='1' align='left'>[unitPrice]</td>" +
        
        "<td  colspan='1' align='left'>[amt]</td>" +
        "<td  colspan='1' align='left'>[rate]</td>" +
        "<td  colspan='1' align='left'>[subtotal]</td>"+
        "<td  colspan='1' align='left'>[workers]</td>"+
        "<td  colspan='1' align='left'>[status]</td>"+
      /*   "<td  colspan='1' align='left'>[isBack]</td>"+  */     
        "<td  colspan='1' align='left'>[mtAdvisor]</td>" +
        "<td  colspan='1' align='left'>[finishDate]</td>" +
        "<td  colspan='1' align='left'>[outDate]</td>" ;
        
    
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.serviceCode){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[serviceCode]", detail[i].serviceCode?detail[i].serviceCode:"")
                         .replace("[serviceTypeId]", detail[i].serviceTypeId?detail[i].serviceTypeId:"")
                         .replace("[itemName]", detail[i].itemName?detail[i].itemName:"")
                         .replace("[carNo]", detail[i].carNo?detail[i].carNo:"")
                         .replace("[carModel]", detail[i].carModel?detail[i].carModel:"")
                         
                         .replace("[guestName]", detail[i].guestName?detail[i].guestName:"")                        
                         .replace("[carVin]", detail[i].carVin?detail[i].carVin:"")
                         .replace("[itemTime]", detail[i].itemTime?detail[i].itemTime:0)                       
                         .replace("[unitPrice]", detail[i].unitPrice?detail[i].unitPrice:0)
                         
                         .replace("[amt]", detail[i].amt?detail[i].amt:0)                        
                         .replace("[rate]", detail[i].rate?detail[i].rate*100+"%":"0%")
                         .replace("[subtotal]", detail[i].subtotal?detail[i].subtotal:0)
                         .replace("[workers]", detail[i].workers?detail[i].workers:"")
                         .replace("[status]", detail[i].status?detail[i].status:"")
                        /*  .replace("[isBack]", detail[i].isBack?detail[i].isBack:"") */
                         .replace("[mtAdvisor]", detail[i].mtAdvisor?detail[i].mtAdvisor:"")
                         .replace("[finishDate]", nui.formatDate(detail[i].finishDate?detail[i].finishDate:"",'yyyy-MM-dd HH:mm'))
                         .replace("[outDate]", nui.formatDate(detail[i].outDate?detail[i].outDate:"",'yyyy-MM-dd HH:mm'))
                         );       
                        
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"施工项目明细表",'tableExportA');
}
    </script>
</body>

</html>