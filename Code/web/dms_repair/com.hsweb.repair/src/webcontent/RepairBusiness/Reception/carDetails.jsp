<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-05 10:29:58
  - Description:
-->
<head>
<title>车辆详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/carDetails.js?version=7" type="text/javascript"></script>
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
<div class="nui-fit">
<input class="nui-hidden" id="carId"name="carId"/>
<input class="nui-hidden" id="guestId"name="guestId"/>
<div id="editForm1">
<div class="nui-tabs" activeIndex="0" style="width:100%;height:100%;" id="tabs">
    <div title="车辆信息">
        <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>基本信息</legend>
            <div id="editForm" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;">车牌号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carNO" width="100%" enabled="false"/>                   
                        </td>
                        <td style="width:80px;">VIN码：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carVin" width="100%" enabled="false"/>                      
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">品牌：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carBrandId" width="100%" enabled="false"/>                    
                        </td>
                        <td style="width:80px;">车型：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carModel" width="100%" enabled="false"/>        
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">车系：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carBrandId" width="100%" enabled="false"/>     
                        </td>
                        <td style="width:80px;">发动机号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="engineNo" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">车辆颜色：</td>
                        <td style="width:150px;"colspan="3">
                            <input class="nui-textbox" name="color" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">注册时间：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="firstRegDate" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">年审到期：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="annualVerificationDueDate" width="100%" enabled="false"/>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>保养</legend>
            <div id="editForm2" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;" >当前里程(KM)：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="enterKilometers" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">建议保养里程(KM)：</td>
                        <td style="width:150px;">
                           <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">建议保养时间：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <fieldset style="width:90%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>保险</legend>
            <div id="editForm3" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;">交强险到期时间：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="insureDueDate" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">商业险到期时间：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="annualInspectionDate" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险保险公司：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">商业险公司名称：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险保单号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="insureNo" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">商业险保单号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="annualInspectionNo" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险销售人员：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                        <td style="width:80px;">商业险销售人员：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">保险备注:</td>
                        <td style="width:150px;" colspan="3">
                            <input class="nui-textbox" name="" width="100%" enabled="false"/>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
    </div>
    <div title="客户信息">
        <div id="editForm4" style="padding:5px;">
        
            <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                <tr>
                    <td style="width:80px;">姓名</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="fullName" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">性别</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">客户来源</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">手机号</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="tel" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">生日</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">服务顾问</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">客户单位</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">积分</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">挂账</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">客户分组</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">地址</td>
                    <td style="width:150px;" colspan="3">
                        <input class="nui-textbox" name="addr" width="100%"enabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">资料照片:</td>
                    <td style="width:150px;" colspan="5">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">上次消费时间</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                    <td style="width:80px;">累计消费</td>
                    <td style="width:150px;" colspan="3">
                        <input class="nui-textbox" name="" width="100%"enabled="false"/>
                    </td>
                </tr>
            </table>
        </div>
        <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>计次卡</legend>
                 <div id="grid1" class="nui-datagrid" style="width:100%;height:auto;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick="" allowCellSelect="true" url="com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext">
                    <div property="columns">
                          <div field="prdtName" name="prdtName" width="100" headerAlign="center" header="产品名称"></div>
		                  <div field="prdtType" name="prdtType" width="50" headerAlign="center" header="产品类别"></div>
		                  <div field="canUseTimes" name="canUseTimes" width="50" headerAlign="center" header="可使用次数"></div>
		                  <div field="doTimes" name="doTimes" width="50" headerAlign="center" header="使用中次数"></div>
		                  <div field="balaTimes" name="balaTimes" width="50" headerAlign="center" header="剩余次数"></div>
                    </div>
                </div>
        </fieldset>
        <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>储值卡</legend>
            <div id="grid2" class="nui-datagrid" style="width:100%;height:auto;" selectOnLoad="true" showPager="true" pageSize="50"
                totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick="" allowCellSelect="true" url="com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext">
                <div property="columns">
                    <div field="cardName" name="cardName" width="100" headerAlign="center" header="卡名称"></div>
                    <div field="balaAmt" name="balaAmt" width="50" headerAlign="center" header="余额"></div>
                    <div field="modifyDate" name="modifyDate" width="100" headerAlign="center" header="储值日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="periodValidity" name="periodValidity" width="100" headerAlign="center" header="到期日期" dateFormat="yyyy-MM-dd"></div>
                </div>
            </div>
        </fieldset>
        <!-- <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>VIP卡</legend>
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" url="">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                    <div field="" name="" headerAlign="center" align="center">卡名称</div>
                    <div field="" name="" headerAlign="center" align="center">卡类型</div>
                    <div field="" name="" headerAlign="center" align="center">卡号</div>
                    <div field="" name="" headerAlign="center" align="center">绑定车牌</div>
                    <div field="" name="" headerAlign="center" align="center">到期时间</div>
                </div>
            </div>
        </fieldset> -->
    </div>
    <div title="服务记录" >
        <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick="" allowCellSelect="true" url="com.hsapi.repair.repairService.query.querySettleList.biz.ext">
            <div property="columns">
                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
	                <div field="guestFullName" name="guestFullName" width="55" headerAlign="center" header="客户姓名"></div>
	                <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div>
	                <div field="contactName" name="contactName" width="65" headerAlign="center" header="送修人姓名"></div>
                  	<div field="contactMobile" name="contactMobile" width="80" headerAlign="center" header="送修人手机"></div>
                  	<div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="服务顾问"></div>
	                <div field="serviceCode" name="serviceCode" width="120" headerAlign="center" header="工单号"></div>
                    <div field="recordDate" name="recordDate" width="120" headerAlign="center" header="开单日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
                    <div field="balaAmt" name="balaAmt" width="120" headerAlign="center" header="金额"></div>
                    
            </div>
        </div>
    </div>
</div>
</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>