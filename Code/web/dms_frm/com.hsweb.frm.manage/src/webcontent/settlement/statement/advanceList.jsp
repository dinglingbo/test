<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>预收预付退款</title>
<script src="<%=webPath + contextPath%>/manage/settlement/js/advanceList.js?v=1.1.4"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
                
<!-- 				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch()" id="type">所有</li>
                    <li iconCls="" onclick="quickSearch(12)" id="type12">订货已到</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">已退货</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">销售中</li>
                    <li iconCls="" onclick="quickSearch(15)" id="type15">已销售</li>
                </ul> -->


				<label style="font-family:Verdana;">付款日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <input id="guestName" name="guestName" width="150px" emptyText="客户名称" class="nui-textbox"/>

                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				<a class="nui-button" iconCls="" plain="true" onclick="doSettle()"><span class="fa fa-dollar fa-lg"></span>&nbsp;退款</a>

            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="fisRpAdvanceList"
         idField="detailId"
         ondrawcell="onDrawCell"   
         sortMode="client"
         url=""
         oncellclick="onRGridbeforeselect"
         allowCellSelect="true" 
         allowCellEdit="true" multiSelect="false"
         oncellcommitedit="onCellCommitEdit"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = "true"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn" width="40px">序号</div>   
           		    <div type="checkcolumn" field="check" width="20px"></div>                                      
                    <div field="guestName" name="guestName" width="200px" headerAlign="center" header="往来单位"></div>    
                    <div field="billTypeId" allowSort="true"   width="80px" headerAlign="center" header="收支项目"></div>  
                    <div allowSort="true" field="amt" name="amt" width="60px" headerAlign="center" header="金额"></div>
                    <div allowSort="true" field="charOffAmt" name="charOffAmt" width="60px" headerAlign="center" header="结算金额"></div>
                    <div allowSort="true" field="deductionAmt" name="deductionAmt" width="60px" headerAlign="center" header="已抵扣金额"></div>
                    <div allowSort="true" field="refundAmt" name="deductionAmt" width="60px" headerAlign="center" header="已退款金额"></div>
                    <div allowSort="true" field="balaAmt" name="balaAmt" width="60px" headerAlign="center" header="剩余金额"></div>
                    <div allowSort="true" field="nowAmt" width="60px" headerAlign="center" align="right" numberFormat="0.00" dataType="float" header="退款金额">
						<input property="editor" vtype="float" class="nui-textbox" />
					</div>
                    <div field="settleDate" allowSort="true"  width="100px" headerAlign="center" header="付款日期" dateFormat="yyyy-MM-dd HH:mm" ></div>                	
                    <div field="remark" allowSort="true"  width="220px" headerAlign="center" header="备注"></div>
        </div>
    </div> 
</div>



</body>
</html>
