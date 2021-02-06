<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>	
<html>
<head>
<title>凭证生成记录查询</title>
<style type="text/css">
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


	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
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

				<label style="font-family:Verdana;">创建日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="serviceId" width="100px" emptyText="单号" class="nui-textbox"/>
                <input id="type"
                   name="type"
                   class="nui-combobox"
                   textField="name"
                   valueField="id"
                   emptyText="类型"
                   url=""
                   width="100px"
                   valueFromSelect="true"
                   allowInput="true"
                   showNullItem="false"
                   nullItemText="请选择..."/>
                <input id="status"
                   name="status"
                   class="nui-combobox"
                   textField="name"
                   valueField="id"
                   emptyText="调用状态"
                   url=""
                   width="100px"
                   valueFromSelect="true"
                   allowInput="true"
                   showNullItem="false"
                   nullItemText="请选择..."/>
                <input id="successSign"
                   name="successSign"
                   class="nui-combobox"
                   textField="name"
                   valueField="id"
                   emptyText="返回状态"
                   url=""
                   width="100px"
                   valueFromSelect="true"
                   allowInput="true"
                   showNullItem="false"
                   nullItemText="请选择..."/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onReload()" id="exportBtn"><span class="fa fa-refresh fa-lg"></span>&nbsp;重新执行</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onReloadPchs()" id="exportBtn"><span class="fa fa-refresh fa-lg"></span>&nbsp;采购凭证重新执行</a>
              
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         selectOnLoad="true"
         allowSort="true"
         url=""
         allowCellSelect="true"
         pageSize="500"
         sizeList="[500,1000,2000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="serviceId" width="120" summaryType="count" headerAlign="center" header="单号" allowSort="true" dataType="string"></div>
            <div field="name" width="100" headerAlign="center" header="名称" allowSort="true" dataType="string"></div>
            <div field="type" width="100" headerAlign="center" header="类型" allowSort="true" dataType="string"></div>
            <div allowSort="true" field="operParam" width="200" headerAlign="center" header="请求参数" allowSort="true" dataType="string"></div>
            <div allowSort="true" field="status" width="50" headerAlign="center" header="调用状态" allowSort="true" dataType="string"></div>
            <div allowSort="true" field="successSign" width="50" headerAlign="center" header="返回状态" allowSort="true" dataType="string"></div>
            <div allowSort="true" field="jsonResult" width="200" headerAlign="center" header="返回结果" ></div>
            <div allowSort="true" field="creator" width="50" headerAlign="center" header="创建人" ></div>
            <div allowSort="true" width="100" field="createDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date"></div>
        </div>
    </div>
</div>

<div id="exportDiv" style="display:none"> 

</body>

<script type="text/javascript">
	nui.parse();
	var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
	var rightGridUrl = baseUrl+"com.hs.common.uitls.queryVoucherRecord.biz.ext";
	var rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	
	var statusList = [{id:0,name:"正常"},{id:1,name:"异常"}];
	var statusHash = {
		0:{id:0,name:"正常"},
		1:{id:1,name:"异常"}
	};
	
	var successList = [{id:0,name:"失败"},{id:1,name:"成功"}];
	var successHash = {
		0:{id:0,name:"失败"},
		1:{id:1,name:"成功"}
	};
	
	var typeList = [{id:1,name:"采购入库"},{id:2,name:"采购退货"},{id:3,name:"销售出库"},{id:4,name:"销售退货"},{id:5,name:"费用登记明细"},{id:6,name:"收款"},
                    {id:7,name:"预存收款"},{id:8,name:"预收抵扣"},{id:9,name:"内部账户调账"},{id:10,name:"付款"},{id:11,name:"预付付款"},{id:12,name:"预付抵扣"},
                    {id:13,name:"费用月结或现结"},{id:14,name:"采购退货收款"},{id:15,name:"销售退货付款"},{id:16,name:"其他应收单"},{id:17,name:"其他应付单"},
                    {id:18,name:"费用支出单"},{id:19,name:"其他收入单"},{id:20,name:"预付退款"},{id:21,name:"预收退款"},{id:22,name:"添加客户资料"},{id:23,name:"添加供应商资料"},
                    {id:24,name:"移仓单"},{id:25,name:"盘点单-盘盈"},{id:26,name:"盘点单-盘亏"}];
	var typeHash = {
		1:{id:1,name:"采购入库"},2:{id:1,name:"采购退货"},3:{id:1,name:"销售出库"},4:{id:1,name:"销售退货"},5:{id:1,name:"费用登记明细"},
        6:{id:1,name:"收款"},7:{id:1,name:"预存收款"},8:{id:1,name:"预收抵扣"},9:{id:1,name:"内部账户调账"},10:{id:1,name:"付款"},11:{id:1,name:"预付付款"},
        12:{id:1,name:"预付抵扣"},13:{id:1,name:"费用月结或现结"},14:{id:1,name:"采购退货收款"},15:{id:1,name:"销售退货付款"},16:{id:1,name:"其他应收单"},17:{id:1,name:"其他应付单"},
        18:{id:1,name:"费用支出单"},19:{id:1,name:"其他收入单"},20:{id:1,name:"预付退款"},21:{id:1,name:"预收退款"},22:{id:1,name:"添加客户资料"},23:{id:1,name:"添加供应商资料"},
        24:{id:1,name:"移仓单"},25:{id:1,name:"盘点单-盘盈"},26:{id:1,name:"盘点单-盘亏"}
	};

    nui.get("type").setData(typeList);
    nui.get("status").setData(statusList);
    nui.get("successSign").setData(successList);

    quickSearch(0);
	
	function getSearchParam(){
	    var params = {};
	    params.serviceId = nui.get("serviceId").getValue().replace(/\s+/g, "");
		params.status = nui.get("status").getValue().replace(/(^\s*)|(\s*$)/g, "");
		params.successSign = nui.get("successSign").getValue().replace(/\s+/g, "");
		params.type = nui.get("type").getValue();
		params.sCreateDate = nui.get("beginDate").getFormValue();
		params.eCreateDate = nui.get("endDate").getFormValue();
	    return params;
	}
	
	function quickSearch(type){
	    var params = getSearchParam();
	    var queryname = "本日";
	    switch (type)
	    {
	        case 0:
	            params.today = 1;
	            params.sCreateDate = getNowStartDate();
	            params.eCreateDate = addDate(getNowEndDate(), 1);
	            queryname = "本日";
	            break;
	        case 1:
	            params.yesterday = 1;
	            params.sCreateDate = getPrevStartDate();
	            params.eCreateDate = addDate(getPrevEndDate(), 1);
	            queryname = "昨日";
	            break;
	        case 2:
	            params.thisWeek = 1;
	            params.sCreateDate = getWeekStartDate();
	            params.eCreateDate = addDate(getWeekEndDate(), 1);
	            queryname = "本周";
	            break;
	        case 3:
	            params.lastWeek = 1;
	            params.sCreateDate = getLastWeekStartDate();
	            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
	            queryname = "上周";
	            break;
	        case 4:
	            params.thisMonth = 1;
	            params.sCreateDate = getMonthStartDate();
	            params.eCreateDate = addDate(getMonthEndDate(), 1);
	            queryname = "本月";
	            break;
	        case 5:
	            params.lastMonth = 1;
	            params.sCreateDate = getLastMonthStartDate();
	            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
	            queryname = "上月";
	            break;
	        case 10:
	            params.thisYear = 1;
	            params.sCreateDate = getYearStartDate();
	            params.eCreateDate = getYearEndDate();
	            queryname = "本年";
	            break;
	        case 11:
	            params.lastYear = 1;
	            params.sCreateDate = getPrevYearStartDate();
	            params.eCreateDate = getPrevYearEndDate();
	            queryname = "上年";
	            break;
	        default:
	            break;
	    }
	    nui.get("beginDate").setValue(params.sCreateDate);
	    nui.get("endDate").setValue(params.eCreateDate);
	    currType = type;
	    var menunamedate = nui.get("menunamedate");
	    menunamedate.setText(queryname);
	    doSearch(params);
	}
	
	function doSearch(params)
	{
	    rightGrid.load({
	        params:params,
	        token: token
	    },function(){
	        rightGrid.mergeColumns(["serviceId"]);
	    });
	}

    function onSearch() {
        var params = getSearchParam();
        doSearch(params);
    }

        
    function onDrawCell(e)
    {
        switch (e.field)
        {
            case "type":
                if(typeHash && typeHash[e.value])
                {
                    e.cellHtml = typeHash[e.value].name;
                }
                break;
            case "status":
                if(statusHash && statusHash[e.value])
                {
                    e.cellHtml = statusHash[e.value].name;
                }
                break;
            case "successSign":
                if(successHash && successHash[e.value])
                {
                    e.cellHtml = successHash[e.value].name;
                }
                break;
            default:
                break;
        }
        
    }
    
    
function onExport(){
	var detail = nui.clone(rightGrid.getData());
	//多级
	//exportMultistage(rightGrid.columns);
	//单级
	exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(typeHash[detail[i].type]){
			detail[i].type = typeHash[detail[i].type].name;
		}
		if(statusHash[detail[i].status]){
			detail[i].status = statusHash[detail[i].status].name;
		}
		if(successHash[detail[i].successSign]){
			detail[i].successSign = successHash[detail[i].successSign].name;
		}
		
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		//setInitExportData( detail,rightGrid.columns,"凭证生成记录");
		//单级表头类型 与上二选一
		setInitExportDataNoMultistage( detail,rightGrid.columns,"凭证生成记录");
	}
}
    

function onReload() {
    var role = rightGrid.getSelected();
    if(role == null) {
    	showMsg("请选择一条记录","W");
    	return;
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '处理中...'
    });

    nui.ajax({
        url:baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.reloadVoucher.biz.ext",
        type:"post",
        data:JSON.stringify({
            id:role.id,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            if (data.errCode == "S"){
                showMsg("处理成功","S");
                rightGrid.reload();
            }else{
                showMsg(data.errMsg||"处理失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            showMsg("网络出错","W");
        }
    });  
}

function onReloadPchs() {
	var role = rightGrid.getSelected();
    if(role == null) {
    	showMsg("请选择一条记录","W");
    	return;
    }
    
    if(role.type != 1 || role.successSign != 0) {
    	showMsg("请选择未执行成功的采购凭证","W");
    	return;
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '处理中...'
    });

    nui.ajax({
        url:baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingPchs.biz.ext",
        type:"post",
        data:JSON.stringify({
            serviceNo:role.serviceId,
            recordId:role.id,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            if (data.errCode == "S"){
                showMsg("处理成功","S");
                rightGrid.reload();
            }else{
                showMsg(data.errMsg||"处理失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            showMsg("网络出错","W");
        }
    });  
}
    
</script>

</html>
