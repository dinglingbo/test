<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
    <title>工单-洗车单</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/carWashBill.js?v=1.0.4"></script>
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
        .required {
            color: red;
        }


    </style>
</head>
<body>



<div class="nui-toolbar" style="padding:2px;height:30px">
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td>
                <input id="search_name"
                name="search_name"
                class="nui-buttonedit"
                emptyText="车牌号/手机号/客户名称/VIN码"
                onbuttonclick="onSearchClick()"
                width="50%"
                showClose="false"
                allowInput="true"/>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;font-size:15px;font-weight:bold;">洗车开单详情</label>
            </td>
            <td style="text-align:right;">
                <!-- <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                <span class="separator"></span>

                <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(0)" id="type10">打印维修委托单</li>
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印派工单</li>
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印结算单</li>
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印领料单</li>
                </ul>


                <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"><span class="fa fa-gift fa-lg"></span>&nbsp;充值办卡</a>

                <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(0)" id="type10">计次卡销售</li>
                    <li iconCls="" onclick="onPrint(1)" id="type11">储值卡充值</li>
                </ul>
            </td>
        </tr>
    </table>

</div>

<div class="nui-fit">
    <div id="billForm" class="form">
        <input name="id" class="nui-hidden"/>
        <input name="guestId" class="nui-hidden"/>
        <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="carVin"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="carModel"/>
        <input class="nui-hidden" name="identity"/>
        <table  style=" left:0;right:0;margin: 0 auto;"> 
            <tr>   
                <td class="title required">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false"/></td>
                <td class="title required">
                    <label>业务类型:</label>
                </td>
                <td class="">
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
                        nullItemText="请选择..."/>
                </td>
                <td class="title required">
                    <label>服务顾问：</label>
                </td>
                <td>
                    <input name="mtAdvisorId"
                            id="mtAdvisorId"
                            class="nui-combobox width1"
                            textField="empName"
                            valueField="empId"
                            emptyText="请选择..."
                            url=""
                            allowInput="true"
                            showNullItem="false"
                            valueFromSelect="true"
                            nullItemText="请选择..."/>
                </td>
                <td class="title">进厂里程:</td> 
                <td class=""><input  class="nui-textbox" name="enterKilometers"/></td>
            </tr>
            <tr>   
                <td class="title required">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestFullName" enabled="false"/></td>
                <td class="title required">联系方式:</td> 
                <td class=""><input  class="nui-textbox" name="mobile" enabled="false"/></td>
                <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark"/></td>
                <td class="title">开单时间:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false"
                    class="nui-datepicker" enabled="false"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div class="nui-splitter"
                id="splitter"
                allowResize="true"
                handlerSize="6"
                style="width:100%;height:100%;">
            <div size="300" showCollapseButton="true">
                <div class="nui-fit">
                    <iframe id="formIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
                </div>
            </div>
            <div showCollapseButton="false">
                
                    <div class="nui-fit">
                        <div class="" style="width:100%;height:auto;" >
                            <div style="width:100%;height:5px;"></div>
                            <%@include file="/repair/RepairBusiness/Reception/repairPackage.jsp" %>
                            <div style="width:100%;height:5px;"></div>
                            <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
                            <div style="width:100%;height:5px;"></div>
                            <%@include file="/repair/RepairBusiness/Reception/repairPart.jsp" %>
                        </div>
                
                        <div id="bottomPanel" class="nui-panel" title="其他" iconCls="" style="width:100%;height:100px;" 
                            showToolbar="false" showCollapseButton="true" showFooter="false" allowResize="false" collapseOnTitleClick="true"
                        >
                            <div id="billForm" class="form">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td class="title">
                                                <label>套餐金额：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                            <td class="title">
                                                <label>套餐优惠：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                            <td class="title">
                                                <label>工时金额：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                            <td class="title">
                                                <label>工时优惠：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                            <td class="title">
                                                <label>零件金额：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                            <td class="title">
                                                <label>零件优惠：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="title required">
                                                <label>应收总计：</label>
                                            </td>
                                            <td >
                                                <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                
                
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