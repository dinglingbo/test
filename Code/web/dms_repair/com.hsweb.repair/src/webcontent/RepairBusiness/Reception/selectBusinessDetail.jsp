<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>	
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-28 14:49:40
  - Description:
-->
<head>
<title>查询营业明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
</head>
<body>
<div id="toolbar" class="nui-toolbar" style="padding:2px;">
    <table style="width:80%;">
        <tr>
        <td style="width:80%;">
        	快速统计：
            <a class="nui-button" plain="true" onclick="getDate(1)"><font color="blue"><u>本周</u></font></a>
            <a class="nui-button" plain="true" onclick="getDate(2)"><font color="blue"><u>上周</u></font></a>
            <a class="nui-button" plain="true" onclick="getDate(3)"><font color="blue"><u>本月</u></font></a>
            <a class="nui-button" plain="true" onclick="getDate(4)"><font color="blue"><u>上月</u></font></a>
            <a class="nui-button" plain="true" onclick="getDate(5)"><font color="blue"><u>本年</u></font></a>
            <a class="nui-button" plain="true" onclick="getDate(6)"><font color="blue"><u>上年</u></font></a>
            <span class="separator"></span>
                      结算日期  从：
          	<input class="nui-datepicker" name="start" id="start"/>&nbsp;至：<input class="nui-datepicker" name="end" id="end"/>
          	车牌号：<input class="nui-textbox" name="carNo"/>
          	<span class="separator"></span>
          	<a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
          	<input name="serviceTypeId"
                    id="serviceTypeId"
                    class="nui-combobox width1"
                    textField="name"
                    valueField="id"
                    emptyText="请选择..."
                    url=""
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..." />
        </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
<div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="80"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               showModified="false"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url=""
               frozenStartColumn="0" frozenEndColumn="6" >
              <div property="columns">
              	<div type="indexcolumn" headerAlign="center" align="center">序号</div>
                  <div header="基本信息" headerAlign="center" >
                	<div property="columns">
                		<div field="serviceCode" width="80" headerAlign="center" align="center" header="业务单号"></div>
                		<div field="carNo" width="80" headerAlign="center" align="center" header="车牌号"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="车辆厂牌"></div>
                		<div field="carModel" width="80" headerAlign="center" align="center" header="品牌车型"></div>
                		<div field="mtAdvisor" width="80" headerAlign="center" align="center" header="维修顾问"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="质检员"></div>
                		<div field="guestFullName" width="80" headerAlign="center" align="center" header="客户名称"></div>
                	</div>
        		  </div>
        		  <div header="业务类型" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="系统判断"></div>
                		<div field="serviceTypeId" width="80" headerAlign="center" align="center" header="业务类型"></div>
                	</div>
        		  </div>
        		  <div header="维修数据" headerAlign="center" >
                	<div property="columns">
                		<div field="packageAmt" width="80" headerAlign="center" align="center" header="项目金额"></div>
                		<div field="packageSubtotal" width="80" headerAlign="center" align="center" header="项目小计"></div>
                		<div field="partTotalAmt" width="80" headerAlign="center" align="center" header="配件金额"></div>
                		<div field="partSubtotal" width="80" headerAlign="center" align="center" header="配件小计"></div>
                		<div field="partManageExpAmt" width="80" headerAlign="center" align="center" header="配件管理费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修金额"></div>
                		<div field="allowanceAmt" width="80" headerAlign="center" align="center" header="折让金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="活动冲减金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="结算金额"></div>
                	</div>
        		  </div>
        		  <div header="收入数据" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="开大金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="发票金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="开大发票金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="营业收入"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="折扣费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="业务费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="预提费"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="费用成本"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="总折扣金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="维修净收入"></div>
                	</div>
        		  </div>
        		  <div header="整单优惠" headerAlign="center" >
                	<div property="columns">
                		<div field="totalPrefRate" width="80" headerAlign="center" align="center" header="整单优惠率"></div>
                	</div>
        		  </div>
        		  <div header="税费金额" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="预提税款"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="开大附加税"></div>
                	</div>
        		  </div>
        		  <div header="实营金额" headerAlign="center" >
                	<div property="columns">
                		<div field="netinAmt" width="80" headerAlign="center" align="center" header="实营金额"></div>
                	</div>
        		  </div>
        		  <div header="模拟提成数据" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="机电金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="机电提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="钣金金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="钣金提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="喷漆金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="喷漆提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="美容金额"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="美容提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="项目提成合计"></div>
                	</div>
        		  </div>
        		  <div header="实际工时提成 工时金额*工时提成率(1-整单优惠率)" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="机电提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="钣金提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="喷漆提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="美容提成"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="工时提成各计"></div>
                	</div>
        		  </div>
        		  <div header="配件成本" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="未含税成本"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="含税成本"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="小计"></div>
                	</div>
        		  </div>
        		  <div header="毛利数据" headerAlign="center" >
                	<div property="columns">
                		<div field="grossProfit" width="80" headerAlign="center" align="center" header="毛利"></div>
                		<div field="grossProfitRate" width="80" headerAlign="center" align="center" header="毛利率"></div>
                	</div>
        		  </div>
        		  <div header="运营毛利" headerAlign="center" >
                	<div property="columns">
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利"></div>
                		<div field="" width="80" headerAlign="center" align="center" header="运营毛利率"></div>
                	</div>
        		  </div>
              </div>
          </div>
  </div>
	<script type="text/javascript">
    	nui.parse();
    	var toolbar = null;
    	var mainGrid = nui.get("mainGrid");
    	var date = new Date();
    	nui.get("start").setValue(date);
    	nui.get("end").setValue(date);
    	
    	mainGrid.setUrl("com.hsapi.repair.baseData.report.yingyemingxi.biz.ext");
    	mainGrid.load();
    	function getDate(e){//获取时间段
    		var params = {};
    		switch (e) {
				case 1:
					params.thisWeek = 1;
					params.sCreateDate = getWeekStartDate();
					params.eCreateDate = addDate(getWeekEndDate(), 1);
					break;
				case 2:
					params.lastWeek = 1;
					params.sCreateDate = getLastWeekStartDate();
					params.eCreateDate = addDate(getLastWeekEndDate(), 1);
					break;
				case 3:
					params.thisMonth = 1;
					params.sCreateDate = getMonthStartDate();
					params.eCreateDate = addDate(getMonthEndDate(), 1);
					break;
				case 4:
					params.lastMonth = 1;
					params.sCreateDate = getLastMonthStartDate();
					params.eCreateDate = addDate(getLastMonthEndDate(), 1);
					break;
				case 5:
					params.sCreateDate = getYearStartDate();
					params.eCreateDate = getYearEndDate();
					break;
				case 6:
					params.sCreateDate = getPrevYearStartDate();
					params.eCreateDate = getPrevYearEndDate();
					break;
				default:
					break;
				}
				mainGrid.load({params : params});
    	}
    	
    	function onSearch(){
    		toolbar = new nui.Form("#toolbar");
    		console.log(toolbar.getData());
    	}
    	var servieTypeList = [];
    	var servieTypeHash = {};
    	initServiceType("serviceTypeId",function(data) {
	        servieTypeList = nui.get("serviceTypeId").getData();
	        servieTypeList.forEach(function(v) {
	            servieTypeHash[v.id] = v;
	        });
	    });
	    
	     mainGrid.on("drawcell",function(e){
	    	var field = e.field,
	    	value = e.value;
	    	if(field == "serviceTypeId"){
	    		if(value){
	    			e.cellHtml = servieTypeHash[e.value].name;
	    		}
	    	}
	    	if(field == "totalPrefRate" || field == "grossProfitRate"){
	    		if(value){
	    			e.cellHtml = (value * 100).toFixed(2);
	    		}
	    	}
	    }); 
	    
	    
    </script>
</body>
</html>