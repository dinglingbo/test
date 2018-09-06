<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-05 10:29:58
  - Description:
-->
<head>
<title>车辆详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/carDetails.js?version=2" type="text/javascript"></script>
</head>
<body>
<div class="nui-tabs" activeIndex="0" style="width:100%;height:100%;" id="tabs">
    <div title="车辆信息">
        <fieldset style="width:80%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>基本信息</legend>
            <div id="editForm1" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;">车牌号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carNo" width="100%"/>                   
                        </td>
                        <td style="width:80px;">VIN码：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="vin" width="100%"/>                      
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">品牌：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carBrandId" width="100%"/>                    
                        </td>
                        <td style="width:80px;">车型：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carModel" width="100%"/>        
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">车系：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="carBrandId" width="100%"/>     
                        </td>
                        <td style="width:80px;">发动机号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="engineNo" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">车辆颜色：</td>
                        <td style="width:150px;"colspan="3">
                            <input class="nui-textbox" name="color" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">注册时间：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="firstRegDate" width="100%"/>
                        </td>
                        <td style="width:80px;">年审到期：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="annualVerificationDueDate" width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <fieldset style="width:80%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>保养</legend>
            <div id="editForm2" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;">当前里程(KM)：</td>
                        <td style="width:150px;">
                            <span id="" name=""></span>
                        </td>
                        <td style="width:80px;">建议保养里程(KM)：</td>
                        <td style="width:150px;">
                            <span id="" name=""></span>
                        </td>
                        <td style="width:80px;">建议保养时间：</td>
                        <td style="width:150px;">
                            <span id="" name=""></span>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <fieldset style="width:80%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>保险</legend>
            <div id="editForm3" style="padding:5px;">
                
                <table style="width:100%;" border="1" cellspacing="0" cellpadding="2px">
                    <tr>
                        <td style="width:80px;">交强险到期时间：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="insureDueDate" width="100%"/>
                        </td>
                        <td style="width:80px;">商业险到期时间：</td>
                        <td style="width:150px;">
                            <input class="nui-datepicker" name="annualInspectionDate" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险保险公司：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%"/>
                        </td>
                        <td style="width:80px;">商业险公司名称：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险保单号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="insureNo" width="100%"/>
                        </td>
                        <td style="width:80px;">商业险保单号：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="annualInspectionNo" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">交强险销售人员：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%"/>
                        </td>
                        <td style="width:80px;">商业险销售人员：</td>
                        <td style="width:150px;">
                            <input class="nui-textbox" name="" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px;">保险备注:</td>
                        <td style="width:150px;" colspan="3">
                            <input class="nui-textbox" name="" width="100%"/>
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
                        <input class="nui-textbox" name="contactor" width="100%"/>
                    </td>
                    <td style="width:80px;">性别</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                    <td style="width:80px;">客户来源</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">手机号</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="contactorTel" width="100%"/>
                    </td>
                    <td style="width:80px;">生日</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                    <td style="width:80px;">服务顾问</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">客户单位</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="fullName" width="100%"/>
                    </td>
                    <td style="width:80px;">积分</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                    <td style="width:80px;">挂账</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">客户分组</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                    <td style="width:80px;">地址</td>
                    <td style="width:150px;" colspan="3">
                        <input class="nui-textbox" name="addr" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">资料照片:</td>
                    <td style="width:150px;" colspan="5">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;">上次消费时间</td>
                    <td style="width:150px;">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                    <td style="width:80px;">累计消费</td>
                    <td style="width:150px;" colspan="3">
                        <input class="nui-textbox" name="" width="100%"/>
                    </td>
                </tr>
            </table>
        </div>
        <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>文本套餐</legend>
                <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                    totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                        <div field="" name=""  headerAlign="center" align="center">套餐名称</div>
                        <div field="" name=""  headerAlign="center" align="center">套餐价格</div>
                        <div field="" name=""  headerAlign="center" align="center">套餐内容</div>
                        <div field="" name=""  headerAlign="center" align="center">剩余</div>
                        <div field="" name=""  headerAlign="center" align="center">到期时间</div>
                    </div>
                </div>
        </fieldset>
        <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
            <legend>会员卡</legend>
            <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
                totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" url="">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                    <div field="" name="" headerAlign="center" align="center">卡类型</div>
                    <div field="" name="" headerAlign="center" align="center">充值/扣款</div>
                    <div field="" name="" headerAlign="center" align="center">卡号</div>
                    <div field="" name="" headerAlign="center" align="center">绑定车辆</div>
                    <div field="" name="" headerAlign="center" align="center">余额</div>
                    <div field="" name="" headerAlign="center" align="center">现金账户</div>
                    <div field="" name="" headerAlign="center" align="center">到期时间</div>
                </div>
            </div>
        </fieldset>
        <fieldset style="width:98%;border:solid 1px #aaa;margin-top:8px;position:relative;">
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
        </fieldset>
    </div>
    <div title="服务记录" >
        <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="RpsMaintain" onrowdblclick="" allowCellSelect="true" url="com.hsapi.repair.common.carDetails.searchRpsMaintain.biz.ext">
            <div property="columns">
                <div field="serviceCode" name="serviceCode" headerAlign="center" align="center">工单号</div>
                <div field="" name="" headerAlign="center" align="center">服务项目</div>
                <div field="" name="" headerAlign="center" align="center">金额</div>
                <div field="" name="" headerAlign="center" align="center">单据日期</div>
                <div field="enterKilometers" name="" headerAlign="center" align="center">里程/KM</div>
                <div field="" name="" headerAlign="center" align="center">服务性质</div>
                <div field="" name="" headerAlign="center" align="center">门店</div>
            </div>
        </div>
    </div>
    <div title="历史维修记录（导入）">
        <div id="mainGrid2" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" url="">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                <div field="" name="" headerAlign="center" align="center">服务项目</div>
                <div field="" name="" headerAlign="center" align="center">所需物料</div>
                <div field="" name="" headerAlign="center" align="center">金额</div>
                <div field="" name="" headerAlign="center" align="center">服务时间</div>
                <div field="" name="" headerAlign="center" align="center">里程/KM</div>
                <div field="" name="" headerAlign="center" align="center">服务性质</div>
                <div field="" name="" headerAlign="center" align="center">服务门店</div>
            </div>
        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>