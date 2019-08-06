<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>已结算工单汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/sell/businessOutputTotal.js?v=1.0.1"></script>

    <style>
		.title {
		  width: 100px;
		  text-align: right;
		}

		.form_label {
			width: 50px;
			text-align: right;
		}
		
		.required {
			color: red;
		}
		
		.rmenu {
		    font-size: 14px;
		    /* font-weight: bold; */
		    text-align: left;
		    margin: 0;
		    padding-left: 25px;
		    height: 18px;
		    color: #fff;
		    width: auto;
		    margin-left: 20px;
		    margin-top: 20px;
		    background-size: 50%;
		}
        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
        .iconStyle{
            font-size: 14px;
            margin-top: 2px;
            position: absolute;
            color:#f0ce25;
        }
        .tipStyle{
            position: absolute; 
            background-color: #595959; 
            color:#fff;
            border-radius: 4px;
            padding:5px 10px 5px 10px;
            opacity:0.9;
            font-size:14px;
            display: none;
            z-index:999;
        }
    </style>
</head>

<body>

    <div class="nui-toolbar" style="padding:2px;" id="form1">
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
		                    出厂日期:<input class="nui-datepicker" id="sEnterDate" name="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
		        	<label style="font-family:Verdana;">至</label>
		        	<input class="nui-datepicker" id="eEnterDate" name="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>                   
		        	<input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                                  包含未收款：<div  class="nui-checkbox" id="isCollectMoney" name="isCollectMoney" value="1" onclick="onSearch" trueValue="1" falseValue="0"></div>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()">
					<span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>  
					 <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
                    </br>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="summary(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按日期汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="summary(3)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按业务类型汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="summary(4)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按工单类型汇总</a>
  					<a class="nui-button" iconcls=""  name="" plain="true" onclick="summary(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按服务顾问汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="summary(2)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按品牌车型汇总</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="showDiv" class="tipStyle"></div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false"
            pageSize="500" totalField="page.count" sizeList=[500,1000,2000] dataField="data" onrowdblclick=""
            allowCellSelect="true" editNextOnEnterKey="true" onshowrowdetail="onShowRowDetail" url="" showSummaryRow="true" allowCellWrap=true  sortMode="client">
            <div property="columns">
            	<div type="indexcolumn">序号</div>
                <div  field="groupName" name="groupName"  width="100" headerAlign="center" header="业务类型" allowsort="true" ></div>
                <div field="ct" name="ct" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">单数</div>
                <div field="totalPrefAmt" name="totalPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">优惠合计&nbsp;
</div>
                <div field="allowanceAmt" name="allowanceAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float"> 结算优惠&nbsp;
</div>
                <div field="balaAmt" name="balaAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">实收合计&nbsp;
</div>
                <div field="pkgAmt" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐销售金额</div>
                <div field="pkgPrefAmt" name="pkgPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐优惠金额</div>
                 <div field="pkgSubtotal" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐销售小计</div>
                 <div field="itemTotalAmt" name="itemTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目销售金额</div>
                <div field="itemPrefAmt" name="itemPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目优惠金额</div>
                 <div field="itemSubtotal" name="itemSubtotal" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目销售小计</div>
                <div field="partTotalAmt" name="partTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件销售金额</div>
                <div field="partPrefAmt" name="partPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件优惠金额</div>
                 <div field="partSubtotal" name="partSubtotal" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件销售小计</div>
 				<div field="partTrueCost"  width="70" headerAlign="center" header="配件成本" summaryType="sum" allowsort="true" ></div>
                <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">计次卡抵扣</div>       
                <div field="otherAmt" name="otherAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">其他费用收入</div>
                <div field="otherCostAmt" name="other_cost_amt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">其他费用成本</div>
                <div field="salesDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">销售提成</div>
                <div field="techDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">技师提成</div>
                <div field="advisorDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">服务顾问提成</div>
                <div field="totalDeductAmt" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">总提成金额</div>
                <div field="netinAmt" name="netinAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">营收金额</div>
                <div field="grossProfit" name="grossProfit" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">毛利&nbsp;</div>
                <div field="allowanceAmt" name="allowanceAmt" width="70" headerAlign="center" allowsort="true" summaryType="sum" header="其他优惠" dataType="float"></div>
                <div field="grossProfitRate" name="grossProfitRate" width="100" numberFormat="p" headerAlign="center" align="center"  allowsort="true" dataType="float">毛利率&nbsp;</div>

            </div>
        </div>
    </div>
<div id="advancedSearchWin" class="nui-window" title="高级查询" style="width: 630px; height: 400px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
				
					<td class="title">
						<label>进厂日期 从:</label>
					</td>
					<td>
						<input class="nui-datepicker" id="sEnterDate1" name="sEnterDate1" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
					</td>
					<td class="title">
						<label>至:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td>
						<input class="nui-datepicker" id="eEnterDate1" name="eEnterDate1" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>  
					</td>
					
				</tr>
				<tr>
				
					<td class="title">
						<label>出厂日期 从:</label>
					</td>
					<td>
						<input class="nui-datepicker" id="outDateStart" name="outDateStart" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/> 
					</td>
					<td class="title">
						<label>至:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td>
						<input class="nui-datepicker" id="outDateEnd" name="outDateEnd" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/> 
						
					</td>
				</tr>
 
				<tr>
					<td class="title">
						<label>收款日期 从:</label>
					</td>
					<td>
						<input class="nui-datepicker" id="collectMoneyDateStart" name="collectMoneyDateStart" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/> 
					</td>
					<td class="title">
						<label>至:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</td>
					<td>
						<input class="nui-datepicker" id="collectMoneyDateEnd" name="collectMoneyDateEnd" allowInput="false" width="100%" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/> 					
					</td>
				</tr>      			 
<!-- 				<tr>
					<td class="title">
						<label>车牌号：</label>
					</td>
					<td>
				        <input class="nui-textbox" name="carNo" id="carNo"   width="100%"  />
					</td>
					<td class="title">
						<label>车架号(VIN)：</label>
					</td>
					<td>
				        <input class="nui-textbox" name="vin" id="vin"   width="100%"  />
					</td>
				</tr>	
				<tr>
					<td class="title">
						<label>客户名称：</label>
					</td>
					<td>
				        <input class="nui-textbox" name="name" id="name"   width="100%"  />
					</td>
					<td class="title">
						<label>手机号：</label>
					</td>
					<td>
				        <input class="nui-textbox" name="mobile" id="mobile"   width="100%"  />
					</td>
				</tr>-->				
				<tr>
					<td class="title">
						<label>服务顾问：</label>
					</td>
					<td>
				        <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId" 
                       	 emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="100%" valueFromSelect="true"/>
					</td>
                        <td class="title">
                            <label>业务类型：</label>
                        </td>
                        <td>
                            <input name="serviceTypeId"
                                   id="serviceTypeId"
                                   class="nui-combobox"
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   multiSelect="true"
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100%"
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                        </td>
				</tr>		
				 <tr>
					<td class="title">
						<label> 工单类型:</label>
					</td>
					<td colspan="3">
						<input class="mini-checkboxlist" id="billTypeIdList" emptyText="综合开单" name="billTypeIdList" data="[{billTypeId:0,text:'综合开单'},{billTypeId:2,text:'洗美开单'},{billTypeId:4,text:'理赔开单'},{billTypeId:6,text:'波箱开单'}]"
                        	width="100%"     multiSelect="true" textField="text" valueField="billTypeId" allowInput="true" showNullItem="false" valueFromSelect="true" />
					</td>
				</tr>  
				 				
<!-- 				<tr>
					<td class="title">
						<label>维修进程:</label>
					</td>
					<td colspan="3">
					    <input class="nui-radiobuttonlist" id="statusId" emptyText="全部进程" name="statusId" data="[{billTypeId:999,text:'全部进程'},{billTypeId:0,text:'报价'},{billTypeId:1,text:'施工'},{billTypeId:2,text:'完工'}]"
                          width="100%"   textField="text" valueField="billTypeId"  allowInput="true" showNullItem="false" valueFromSelect="true"/>
					</td>
				</tr>

				<tr>
					<td class="title">
						<label>出厂状态:</label>
					</td>
					<td colspan="3">
						<input class="nui-radiobuttonlist" id="auditSign"  name="auditSign" emptyText="全部" data="[{billTypeId:999,text:'全部'},{billTypeId:0,text:'未出厂'},{billTypeId:1,text:'已出厂'}]"
                          width="100%"   textField="text" valueField="billTypeId"  allowInput="true" showNullItem="false" valueFromSelect="true"/>
					</td>
				</tr>--> 
<!-- 				<tr>
					<td class="title">
						<label> 结算进程:</label>
					</td>
					<td colspan="3">
						<input class="nui-radiobuttonlist" id="settleType" emptyText="全部" name="settleType" data="[{settleType:999,text:'全部'},{settleType:0,text:'在修'},{settleType:1,text:'预结算未出厂'},{settleType:2,text:'已出厂未收款'},{settleType:3,text:'已收款'}]"
                        	width="100%"      value="999" textField="text" valueField="settleType" allowInput="true" showNullItem="false" valueFromSelect="true" />
					</td>
				</tr>  -->		
				<tr>
					<td class="title">
						<label> 收款状态:</label>
					</td>
					<td colspan="3">
						<input class="nui-radiobuttonlist" id="settleType" emptyText="全部" name="settleType" data="[{settleType:999,text:'全部'},{settleType:1,text:'未收款'},{settleType:2,text:'已收款'}]"
                        	width="100%"      value="999" textField="text" valueField="settleType" allowInput="true" showNullItem="false" valueFromSelect="true" />
					</td>
				</tr>						
				<tr>
					<td class="title">
						<label>客户属性：</label>
					</td>
					<td colspan="3">
				        <input class="nui-radiobuttonlist" name="guestProperty" id="guestProperty" emptyText="客户属性" valueField="customid"  textField="name" width="100%" allowInput="true" showNullItem="false" valueFromSelect="true" />
					</td>
				</tr>
				<tr>
					<td class="title">
						<label>客户属性特点：</label>
					</td>
					<td colspan="3">
				        <input class="nui-textbox" name="propertyFeatures" id="propertyFeatures" emptyText="" valueField="customid"  textField="name" width="100%"  />
					</td>
				</tr>	
<!-- 				<tr>
					<td class="title">
						<label> 包含未收款：：</label>
					</td>
					<td colspan="3">
				         <div  class="nui-checkbox" id="isCollectMoney" name="isCollectMoney" value="1"  trueValue="1" falseValue="0"></div> 
					</td>
				</tr>	 -->								

                       
                        
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width: 60px;margin-right: 20px;">取消</a>
				<a class="nui-button" onclick="cancelData" style="width: 60px;">清除</a>
			</div>
		</div>
	</div>
	<div id="exportDiv" style="display:none">  

</div> 
    <script type="text/javascript">
        nui.parse();
        var con8 = '这是一个提示';






        function overShow(e, con) {
            var showDiv = document.getElementById('showDiv');
            var pos = e.getBoundingClientRect();
            $("#showDiv").css("top", pos.bottom); //设置提示div的位置
            $("#showDiv").css("left", pos.right);
            showDiv.style.display = 'block';
            showDiv.innerHTML = con;
        }

        function outHide() {
            var showDiv = document.getElementById('showDiv');
            showDiv.style.display = 'none';
            showDiv.innerHTML = '';
        }
    </script>
</body>

</html>