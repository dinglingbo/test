<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="/WEB-INF/tlds/btnAuth.tld" prefix="btnAuth" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
    <title>理赔开单详情</title>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/claimDetail.js?v=1.7.8"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
        body { 
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        #guestTab a:link { 
           font-size: 12px; 
           color: #578ccd; 
           text-decoration: none; 
        } 
        .btnType{
            font-family:Verdana;
            font-size: 14px;
            text-align: center;
            height: 40px;
            width: 120px;
            line-height:40px;
        }
        .title {
            width: 80px;
            text-align: right;
        }
        .textStyle{
            text-align: center; 
            font-size:14px;
            /* font-weight:bold; 
            color:#32b400; */
        } 
        .required {
            color: red;
        }

        #guestInfo a:link { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
        }  
        #guestInfo a:visited { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: none; 
        } 
        #guestInfo a:hover { 
        font-size: 12px; 
        color: #578ccd; 
        text-decoration: underline; 
        }  

        #wechatTag{
            color:#62b900;
        }
        #wechatTag1{
            color:#ccc;
        }
        #eTag{
            color:#62b900;
        }
        #eTag1{
            color:#ccc;
        }


        /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/
        a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
        a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}

        a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
        a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}
        
        a.optbtn {
            width: 52px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }

        .statusview{background:#78c800; color:#fff; padding:3px 20px; border-radius:20px;}

        .nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}

        .bottomfont{font-size: 20px;}

        .showhealthcss{color: #5a78a0;padding:3px 20px;border: 1px solid;}
     	#comment_bubble {

    width: 140px;
    height: 100px;
    background: #78c800c2;
    position: relative;
    -moz-border-radius: 12px;
    -webkit-border-radius: 12px;
    border-radius: 12px;
} 
  
/*  #search:before {
    content: "";
    width: 0;
    height: 0;
    right: 100%;
    top: 12px;
    position: absolute;
    border-top: 8px solid transparent;
    border-right: 18px solid #cac52afc;
    border-bottom: 8px solid transparent;
}   */
.tishi{
	margin-top: 5px;
}
.btn .mini-buttonedit{
	height:36px;
}
.btn .aa{
	height:36px;
	width: 300px;
}
.btn .mini-buttonedit .mini-corner-all{
	height:33px;
	background: #368bf447;
}
.btn .aa .mini-corner-all{
	height:33px;
}
.mini-corner-all .nui-textbox{
	height:30px;
}
.btn .mini-corner-all .mini-buttonedit-input{
	font-size: 16px;
	margin-top: 8px;
	
}
.btn .mini-corner-all .mini-textbox-input{
	font-size: 14px;
	margin-top: 8px;
	
}
    </style>
</head>
<body>



<div class="nui-toolbar" style="padding:2px;height:48px;position: relative;">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td class="btn">
                <div class="mini-autocomplete" emptyText="未匹配到数据...(输入的内容长度要求大于或是等于3)"
                    style="width:300px;height: 50px !important;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo"   searchField="key" 
                    dataField="list" placeholder="请输入...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="VIN" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox aa"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>&nbsp;
                <a href="javascript:signElectronics()" id="showE" style="display:none"><span id="eTag" class="fa fa-star fa-lg"></span></a>
                <a href="javascript:signElectronics()" id="showE1" style="display:none"><span id="eTag1" class="fa fa-star fa-lg"></span></a>
            </td>      
            <td style="text-align:right;">
                <!-- <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="sureMT()" id="addBtn"><span class="fa fa-car fa-lg"></span>&nbsp;施工</a>
                
                <btnAuth:MyAuth btnArea="dms_claim_bill_1"/>
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a> -->
                
                
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="unfinish()" id="addBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a> -->
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                <span class="separator"></span>

                <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印报价单</li>
                   <!--  <li iconCls="" onclick="onPrint(8)" id="type11">打印报价单(项目配件分开)</li> -->
                    <li iconCls="" onclick="onPrint(2)" id="type11">打印派工单</li>
                    <li iconCls="" onclick="onPrint(11)" id="type11">打印派工单(项目配件分开)</li>
                    <li iconCls="" onclick="onPrint(3)" id="type11">打印结账单</li>
                   <!--  <li iconCls="" onclick="onPrint(9)" id="type11">打印结账单(项目配件分开)</li> -->
                    <li iconCls="" onclick="onPrint(4)" id="type11">打印结账单(小票)</li>
                     <li iconCls="" onclick="onPrint(10)" id="type11">打印结账单(小票,项目配件分开)</li>
                    <li iconCls="" onclick="onPrint(5)" id="type11">打印领料单</li>
                </ul>


                <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"><span class="fa fa-gift fa-lg"></span>&nbsp;充值办卡</a>

                <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="addcardTime()" id="type10">计次卡销售</li>
                    <li iconCls="" onclick="addcard()" id="type11">储值卡充值</li>
                </ul>

                <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>

                <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="unfinish()" id="addBtn">返单</li>
                    <li iconCls="" onclick="updateBillExpense()" id="billExpense">费用登记</li>
                    <!-- <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount">新增报销单</li> -->
                    <li iconCls="" onclick="addExpenseAccount()" id="ExpenseAccount1">报销单</li>
                    <li iconCls="" onclick="toChangBillTypeId(0)" id="">转为综合开单</li>
                    <li iconCls="" onclick="toChangBillTypeId(2)" id="">转为洗美开单</li>
                    <li iconCls="" onclick="upload()" id="ExpenseAccount1">上传维修前后照片</li>
                    <!-- <li iconCls="" onclick="addcardTime()" id="type13">车牌替换/修改</li>
                    <li iconCls="" onclick="addcard()" id="type11">等级转介绍客户</li> -->
                </ul>
            </td>
        </tr>
    </table>

</div>
<div class="nui-fit">
    <div class="" style="width:100%; height:110px" >
    <%@include file="/repair/RepairBusiness/Reception/repairCarInfoLp.jsp" %>
    </div>

    <div style="text-align:center;" >
        <table border="0" align="center" cellpadding="0" cellspacing="0" >
            <tr>
                <td>
                    <div >
                        <span id="carHealthEl" >
                            <a href="javascript:showHealth()" class="healthview" >车况:100</a>&nbsp;
                        </span>
                    </div>
                </td>
                <td>
                    <a href="javascript:bindWechat()" id="showA" style="display:none"><span id="wechatTag" class="fa fa-wechat fa-lg"></span></a>&nbsp;
                    <a href="javascript:bindWechat()" id="showA1" style="display:none"><span id="wechatTag1" class="fa fa-wechat fa-lg"></span></a>&nbsp;
                    <label style="font-family:Verdana;">客户名称:</label>
                    <label id="guestInfo" style="font-family:Verdana;"><a id="guestNameEl" href="javascript:checkGuest()"></a></label>&nbsp;
                    <label id="guestTab" style="font-family:Verdana;color:#578ccd;"><a id="" href="javascript:GuestTabShow()" >客户标签</a></label>&nbsp;
                    <label style="font-family:Verdana;">手机:</label>
                    <label id="guestTelEl" style="font-family:Verdana;"></label>&nbsp;
                </td>
                <td>
                    <div id="guestInfo">
                        <label style="font-family:Verdana;">车牌号:</label>
                        <label id="guestCarEl" style="font-family:Verdana;"><a id="showCarInfoEl" href="javascript:showBillInfo()"></a></label>&nbsp;
                        <label id="cardPackageEl" style="font-family:Verdana;color:blue;"><a id="showCardTimesEl" href="javascript:showCardTimes()">次卡套餐(0)</a></label>
                        <label id="itemTimesEl" style="font-family:Verdana;color:blue;"><a id="showItemTimesEl" href="javascript:showItemTimes()">线上订单(0)</a></label>
                        <label id="clubCardEl" style="font-family:Verdana;color:blue;"><a id="showCardEl" href="javascript:showCard()">储值卡(0)</a></label>
                        <label id="creditEl" style="font-family:Verdana;color:#578ccd;">挂账:0</label><span>&nbsp;&nbsp;&nbsp;</span>
                    </div>
                </td>
                <td>
                    <div >
                        <span id="carSellInfoEl" >
                           <a href="javascript:showSellPoint()" class="healthview" id="showSellEl" href="javascript:showSell()">销售机会(0)</a>&nbsp;
                        </span>
                    </div>
                </td>
                <td>
	                 <span id="carRemind" style="display:none">
	                	<a id="" href="javascript:saleReminding()" class="healthview" >报价提醒</a>
	                </span>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit" >
        <div class="" style="width:100%;height:auto;" >
            <div style="width:100%;height:5px;"></div>
            <%@include file="/repair/RepairBusiness/Reception/repairPackage.jsp" %>
            <div style="width:100%;height:5px;"></div>
            <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
            <%-- <div style="width:100%;height:5px;"></div>
            <%@include file="/repair/RepairBusiness/Reception/repairPart.jsp" %> --%>
        </div>

    </div>
    <div style="height: 5%;"></div>
        <!-- <div id="bottomPanel" class="nui-panel" title="其他" iconCls="" style="width:100%;height:100px;" 
            showToolbar="false" showCollapseButton="true" showFooter="false" allowResize="false" collapseOnTitleClick="true"
        >
            <div id="sellForm" class="form">
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>套餐金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="packageSubtotal" name="packageSubtotal"/>
                            </td>
                            <td class="title">
                                <label>套餐优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="packagePrefAmt" name="packagePrefAmt"/>
                            </td>
                            <td class="title">
                                <label>工时金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="itemSubtotal" name="itemSubtotal"/>
                            </td>
                            <td class="title">
                                <label>工时优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="itemPrefAmt" name="itemPrefAmt"/>
                            </td>
                            <td class="title">
                                <label>零件金额：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="partSubtotal" name="partSubtotal"/>
                            </td>
                            <td class="title">
                                <label>零件优惠：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="partPrefAmt" name="partPrefAmt"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>应收总计：</label>
                            </td>
                            <td >
                                <input class="nui-textbox" enabled="false" width="100%" id="mtAmt" name="mtAmt"/>
                            </td>
                        </tr>
                    </table>
                </div>
        </div> -->
</div>
   
<div style="background-color: #cfddee;position:absolute; top:95%;width:100%;height: 5%; z-index:900;">
    <div id="statustable" style="float: left;height:100%;font-size:16px;color:#5a78a0;padding-left:20px;">
    	<table  style='height: 100%'>
    		<tbody>
    			<tr>
    				<tr>
    					<td  style='height: 100%;font-size:18px'>
					      <label style="font-family:Verdana;">服务进度:</label>
					      <label style="font-family:Verdana;"><span id="addStatus" name="statusvi" class="nvstatusview">报价</span></label>
					      <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
					      <label style="font-family:Verdana;"><span id="repairStatus" name="statusvi" class="nvstatusview">施工</span></label>
					      <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
					      <label style="font-family:Verdana;"><span id="finishStatus" name="statusvi" class="nvstatusview">完工</span></label>
					      <label style="font-family:Verdana;">&nbsp;>&nbsp;</label>
					      <label style="font-family:Verdana;"><span id="settleStatus" name="statusvi" class="nvstatusview">结算</span></label>
    					</td>
    				</tr>
    		</tbody>
    	</table>
    </div>
    <div id="sellForm" class="form"  style="float:right;height: 100%;padding-right: 20px;">
    	<table style='height: 100%'>
    		 <tbody>
    			<tr>
    				<td  style='height: 100%'>
    				<label>套餐金额：</label>
    				    <span enabled="false"  id="packageAmt1" name="packageAmt1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false" visible="false" id="packageAmt" name="packageAmt" style="width:70px"/>
			        
			        <label>&nbsp;&nbsp;工时金额：</label>
			          <span enabled="false"  id="itemAmt1" name="itemAmt1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
 			          <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" visible="false" enabled="false"  id="itemAmt" name="itemAmt" style="width:70px"/>        
 			       
 			        <label>&nbsp;&nbsp;配件金额：</label>
 			        <span enabled="false"  id="partAmt1" name="partAmt1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" visible="false" enabled="false"  id="partAmt" name="partAmt" style="width:70px"/>
    			
    		      <label>&nbsp;&nbsp;总金额：</label>
    		      <span enabled="false"  id="totalAmt1" name="totalAmt1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
			      <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" visible="false" enabled="false"  id="totalAmt" name="totalAmt" style="width:100px"/>
			      
			      <label>&nbsp;&nbsp;优惠金额：</label>
			      <span enabled="false"  id="totalPrefAmt1" name="totalPrefAmt1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
 			      <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" visible="false" enabled="false"  id="totalPrefAmt" name="totalPrefAmt" style="width:70px"/>        
 			      
 			      <label>&nbsp;&nbsp;小计金额：</label>
 			      <span enabled="false"  id="totalSubtotal1" name="totalSubtotal1" style="width:70px;color:red;font-weight:bold;font-size:14px;"></span>
 			      <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" visible="false" enabled="false"  id="totalSubtotal" name="totalSubtotal" style="width:80px"/>
 					
 					<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"  visible="false" />
                      <div style='display: none'>
			          <input class="nui-hidden" enabled="false" id="packageSubtotal" name="packageSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="packagePrefAmt" name="packagePrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="itemSubtotal" name="itemSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="itemPrefAmt" name="itemPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="partSubtotal" name="partSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="partPrefAmt" name="partPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="ycAmt" name="ycAmt"/>
			        </div>
    				</td>
    			</tr>
    		</tbody>
        </table>
    </div>
</div>

<div id="advancedCardTimesWin" class="nui-window"
     title="" style="width:550px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="false">
      <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="showCardTimes()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div> 
    <div class="nui-fit">
          <div id="cardTimesGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField="data"
               idField="id"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
		          <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
		          <div field="prdtType" name="prdtType" width="60" headerAlign="center" header="产品类别"></div>
		          <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总次数"></div>
		          <div field="useTimes" name="useTimes" width="60" headerAlign="center" header="已使用次数"></div>
		          <div field="doTimes" name="doTimes" width="70" headerAlign="center" header="使用中次数"></div>
		          <div field="canUseTimes" name="canUseTimes" width="70" headerAlign="center" header="可使用次数"></div>
		          <div field="cardTimesOpt" name="cardTimesOpt" width="60" headerAlign="center"  header="操作"></div>
	          </div>
          </div>
    </div>
</div> 

<div id="advancedItemTimesWin" class="nui-window"
     title="" style="width:550px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="false">
      <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="showItemTimes()" id="itemTimesBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="itemTimesGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField="data"
               idField="id"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
	          <div property="columns">
		          <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
		          <div field="prdtType" name="prdtType" width="60" headerAlign="center" header="产品类别"></div>
		          <div field="totalTimes" name="totalTimes" width="50" headerAlign="center" header="总数量"></div>
		          <div field="useTimes" name="useTimes" width="60" headerAlign="center" header="已使用数量"></div>
		          <div field="doTimes" name="doTimes" width="70" headerAlign="center" header="使用中数量"></div>
		          <div field="canUseTimes" name="canUseTimes" width="70" headerAlign="center" header="可使用数量"></div>
		          <div field="cardTimesOpt" name="cardTimesOpt" width="60" headerAlign="center"  header="操作"></div>
	        </div>
          </div>
    </div>
</div> 

<div id="advancedMemCardWin" class="nui-window"
     title="" style="width:500px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="false">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="showCard()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="memCardGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField="data"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div field="cardName" name="cardName" width="100" headerAlign="center" header="卡名称"></div>
                  <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="余额"></div>
                  <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="储值日期" dateFormat="yyyy-MM-dd"></div>
                  <div field="periodValidity" name="periodValidity" width="100" headerAlign="center" header="到期日期" dateFormat="yyyy-MM-dd"></div>
              </div>
          </div>
    </div>
</div> 

<div id="carCheckInfo" class="nui-window"
    title="" style="width:400px;height:200px;"
    showModal="false"
    showHeader="false"
    allowResize="false"
    allowDrag="false">
<div class="nui-fit" id="show1" >
    <table style="width: 100%;background-color: #eef1f4">
        <tr style="height: 40px;">
            <td class="">
                <label id="lastCheckInfo1" style="color: #9e9e9e;"></label>
            </td>

            <td class="">
                <label id="lastCheckInfo2"></label>
            </td>

            <td class="">
                <label id="lastCheckInfo3"></label>
            </td>

            <td class="">
                <a class="nui-button  mini-button-info" iconCls="" plain="false" onclick="viewLastCheck()" id="lastCheckInfo4" style="display: none">查看</a>
            </td>
        </tr>
    </table>
    <table style="width: 100%;margin-top:20px; " >
        <tr>
            <td class="textStyle"> 
                <label id="checkStatus1" class="showhealthcss">未派工</label>
            </td>

            <td class="textStyle">
                <label id="checkStatus2" class="showhealthcss">已派工</label>
            </td>

            <td class="textStyle">
                <label id="checkStatus3" class="showhealthcss">施工中</label>
            </td>

            <td class="textStyle">
                <label id="checkStatus4" class="showhealthcss">已完工</label>
            </td>
        </tr>
    </table>
    <div align="center" style="margin-top:20px; " id="checkStatusButton1">
        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="MemSelectCancel(2)" id="">
            <span style="line-height: 30px;">车况派工</span>
        </a>
          <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="showHealth()" id="">
            <span style="line-height: 30px;">取消</span>
        </a>
    </div>

    <div align="center" style="margin-top:20px;display: none; " id="checkStatusButton2">
        <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="newCheckMain()" id="">
            <span style="line-height: 30px;">车况查看</span>
        </a>
          <a class="nui-button  mini-button-info" style="height: 30px;font-size: 14px;" iconCls="" plain="false" onclick="showHealth()" id="">
            <span style="line-height: 30px;">取消</span>
        </a>
    </div>
</div>


<div class="nui-fit" id="show2" style="display: none;">

    <table style="width: 100%;margin-top:20px; " >
        <tr>
            <td style="float: right;"> 
                <label>检查人:</label>
            </td>

            <td >
                <input name="checkManId"
                id="checkManId"
                style="width:150px;" 
                class="nui-combobox "
                textField="empName"
                valueField="empId"
                emptyText="请选择..."
                url=""
                allowInput="true"
                required="true"
                showNullItem="false"
                valueFromSelect="true"
                nullItemText="请选择..."/>
            </td>
        </tr>
    </table>
    <div align="center" style="margin-top:20px; ">
        <a class="nui-button  mini-button-info" iconCls="" plain="false" onclick="MemSelectOk" id="">
            确定
        </a>

        <a class="nui-button  mini-button-info" iconCls="" plain="false" onclick="MemSelectCancel(1)" id="">
            取消
        </a>
    </div>
</div>



<div id="carSellPointInfo" class="nui-window"
    title="" style="width:700px;height:200px;"
    showModal="false"
    showHeader="false"
    allowResize="false"
    allowDrag="false">
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="auditBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增销售机会</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="showCarSellPointInfo()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="carSellPointGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField="list"
               idField="id"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div field="prdtName" name="prdtName" width="80" headerAlign="center" header="项目"></div>
                  <div field="prdtAmt" name="amt" width="40" headerAlign="center" header="金额"></div>
                  <div field="chanceType" name="type" width="60" headerAlign="center" header="机会类型"></div>
                  <div field="status" name="status" width="50" headerAlign="center" header="阶段"></div>
                  <div field="chanceMan" name="creator" width="80" headerAlign="center" header="商机所有者"></div>
                <div field="nextFollowDate" name="nextFollowDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >下次跟进时间</div>
 				<div field="planFinishDate" name="planFinishDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center" >预计成单时间</div>
                  <div field="cardTimesOpt" name="cardTimesOpt" width="80" headerAlign="center"  header="操作" align="center"></div>
              </div>
          </div>
    </div>
</div>

<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>