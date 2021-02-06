<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:49:45
  - Description:
-->
<head>
<title>3DC回访</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Visit3DC/Visit3DCMain.js?v=1.0.6"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<input class="nui-combobox" id="artType" visible="false"/>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" plain="true" onclick="quickSearch(0)" id="type0">我接待的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(1)" id="type1">所有维修车辆</a>
                    <span class="separator"></span>
                    <label>车牌号：</label>
                    <input class="nui-textbox" id="carNo-search"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新</a>
                <a class="nui-button" plain="true" iconCls="icon-add" onclick="threeDc()">3DC回访</a>
                <a class="nui-button" plain="true" iconCls="" onclick="sendSMS()">发送短信</a>
                <a class="nui-button" plain="true" iconCls="icon-node" onclick="history()">维修历史</a>
                <a class="nui-button" plain="true" iconCls="icon-node" onclick="visit()">回访历史</a>
                <a class="nui-button" plain="true" iconCls="icon-user" onclick="complaint()">投诉登记</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;"
         borderStyle="border:0"
         allowResize="false">
        <div size="300" showCollapseButton="false" style="border: 0;">
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid"
                     style="width: 100%; height: 100%;"
                     dataField="list"
                     pageSize="20"
                     selectOnLoad="true"
                     totalField="page.count"
                     allowSortColumn="true">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
                        <div header="双击填写回访内容" headerAlign="center">
                            <div property="columns">
                                <div field="carNo" headerAlign="center"
                                     allowSort="true" visible="true" width="50px">车牌号
                                </div>
                                <div field="mtAdvisor" headerAlign="center"
                                     allowSort="true" visible="true" width="50px">维修顾问
                                </div>
                                <div field="serviceCode" headerAlign="center"
                                     allowSort="true" visible="true" width="70px">工单号
                                </div>
                                <div field="leaveDay" headerAlign="center"
                                     allowSort="true" visible="true" width="50px">离厂天数
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border: 0;">
            <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 210px;" plain="false"
                 onactivechanged="">
                <div title="基本信息">
                    <div id="basicInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="carId"/>
                        <table class="nui-form-table">
                            <tr>
                                <td class="form_label">
                                    <label>客户名称：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="guestFullName" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>客户电话：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="guestMobile" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>来厂次数：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="compComeTimes" enabled="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>联系人：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="contactorName" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>联系电话：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="mobile" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>身份：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="identity" enabled="false"
                                           valueField="customid" textField="name"
                                           id="identity"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车牌号：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="carNo" id="carNo" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>品牌：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="carBrandId"
                                           valueField="id" textField="nameCn"
                                           id="carBrand"/>
                                </td>
                                <td class="form_label">
                                    <label>品牌车型：</label>
                                </td>
                                <td colspan="1">
                                    <input class="nui-textbox" name="carModel" enabled="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>发动机：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="engineNo" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>底盘号：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="carVin" enabled="false"/>
                                </td>
                                <td class="form_label">
                                    <label>是否出单：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="outBillSign"
                                           data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                           allowInput="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>业务类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="serviceTypeId"
                                           valueField="customid" textField="name"
                                           id="serviceTypeId"/>
                                </td>
                                <td class="form_label">
                                    <label>维修类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="mtType"
                                           valueField="customid" textField="name"
                                           id="mtType"/>
                                </td>
                                <td class="form_label">
                                    <label>维修顾问：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="mtAdvisorId" id="mtAdvisorId"
                                           valueField="empId" textField="empName"
                                           allowInput="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>进厂里程：</label>
                                </td>
                                <td>
                                    <input class="nui-Spinner"
                                           minValue="0" maxValue="100000000"
                                           name="enterKilometers" allowNull="false"
                                           showButton="false"/>
                                </td>
                                <td class="form_label">
                                    <label>进厂日期：</label>
                                </td>
                                <td>
                                    <input name="enterDate" class="nui-datepicker" value="" nullValue="null"
                                           format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                </td>
                                <td class="form_label">
                                    <label>离厂日期：</label>
                                </td>
                                <td>
                                    <input name="outDate" class="nui-datepicker" value="" nullValue="null"
                                           format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div title="套餐信息">
                    <div id="packageGrid" class="nui-datagrid"
                         style="width: 100%; height: 100%;"
                         dataField="list"
                         showPager="false"
                         allowSortColumn="true">
                        <div property="columns">
                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                            <div header="套餐信息">
                                <div property="columns">
                                    <div type="expandcolumn" >#</div>
                                    <div field="packageName" headerAlign="center" allowSort="true"
                                         visible="true" width="">套餐名称
                                    </div>
                                    <div field="status" headerAlign="center"
                                         allowSort="true" visible="true" width="60">状态
                                    </div>
                                    <div field="pkgamt" headerAlign="center"
                                         allowSort="true" visible="true" width="80">套餐金额
                                    </div>
                                    <div field="discountAmt" headerAlign="center"
                                         allowSort="true" visible="true" width="80">优惠金额
                                    </div>
                                    <div field="subtotal" headerAlign="center"
                                         allowSort="true" visible="true" width="80">小计金额
                                    </div>
                                    <div field="amt4s" headerAlign="center"
                                         allowSort="true" visible="true" width="80">4S店金额
                                    </div>
                                    <div field="remark" headerAlign="center"
                                         allowSort="true" visible="true" width="">备注
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="packageDetailGrid_Form" style="display:none;">
                        <div id="packageDetailGrid" class="nui-datagrid"
                             style="width: 100%; "
                             dataField="list"
                             showPager="false"
                             selectOnLoad="true"
                             allowSortColumn="true">
                            <div property="columns">
                                <div field="typeName" headerAlign="center" allowSort="true"
                                     visible="true" width="60">类型
                                </div>
                                <div field="name" headerAlign="center"
                                     allowSort="true" visible="true" width="">名称
                                </div>
                                <div field="qty" headerAlign="center"
                                     allowSort="true" visible="true" width="80">工时/数量
                                </div>
                                <div field="remark" headerAlign="center"
                                     allowSort="true" visible="true" width="80">备注
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="维修项目信息">
                    <div id="rpsItemGrid"
                         borderStyle="border-bottom:0;"
                         class="nui-datagrid"
                         dataField="list"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         allowSortColumn="true">
                        <div property="columns">
                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                            <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                            <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
                            <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
                            <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">小计</div>
                            <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                            <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                            <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
                            <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
                            <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                        </div>
                    </div>
                </div>
                <div title="维修材料信息">
                    <div id="rpsPartGrid"
                         dataField="list"
                         class="nui-datagrid"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         allowSortColumn="true">
                        <div property="columns">
                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                            <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                            <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                            <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                            <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
                            <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
                            <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                        </div>
                    </div>
                </div>
                <div title="估算项目信息">
                    <div id="rpsItemQuoteGrid"
                         borderStyle="border-bottom:0;"
                         class="nui-datagrid"
                         dataField="list"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         allowSortColumn="true">
                        <div property="columns">
                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额小计</div>
                            <div field="receTypeId" headerAlign="center"
                                 allowSort="true" visible="true" width="80">收费类型
                            </div>
                            <div field="itemTime" headerAlign="center"
                                 allowSort="true" visible="true" width="80">工时
                            </div>
                            <div field="itemKind" headerAlign="center"
                                 allowSort="true" visible="true" width="80">工种
                            </div>
                            <div field="status" headerAlign="center"
                                 allowSort="true" visible="true" width="80">状态
                            </div>
                            <div field="itemCode" headerAlign="center"
                                 allowSort="true" visible="true" width="">项目编码
                            </div>
                        </div>
                    </div>
                </div>
                <div title="估算材料信息">
                    <div id="rpsPartQuoteGrid"
                         dataField="list"
                         class="nui-datagrid"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         allowSortColumn="true">
                        <div property="columns">
                            <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额小计</div>
                            <div field="receTypeId" headerAlign="center"
                                 allowSort="true" visible="true" width="80">收费类型
                            </div>
                            <div field="qty" headerAlign="center"
                                 allowSort="true" visible="true" width="80">数量
                            </div>
                            <div field="unitPrice" headerAlign="center"
                                 allowSort="true" visible="true" width="80">单价
                            </div>
                            <div field="status" headerAlign="center"
                                 allowSort="true" visible="true" width="80">状态
                            </div>
                            <div field="partCode" headerAlign="center"
                                 allowSort="true" visible="true" width="">零件编码
                            </div>
                        </div>
                    </div>
                </div>
                <div title="出单信息">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSize="5"
                         allowResize="false" vertical="false">
                        <div size="50%" showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsItemBillGrid"
                                     borderStyle="border-bottom:0;"
                                     class="nui-datagrid"
                                     dataField="list"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                        <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                        <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                        <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
                                        <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
                                        <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">小计</div>
                                        <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                        <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsPartBillGrid"
                                     dataField="list"
                                     class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                        <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                        <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                                        <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                        <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
                                        <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
                                        <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">小计</div>
                                        <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="出车报告">
                    <div class="nui-fit">
                        <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport" enabled="false" style="width:100%;height:100%;"></textarea>
                    </div>
                </div>
                <div title="描述信息">
                    <div id="descInfoForm">
                        <table class="nui-form-table" style="margin:0;width: 100%">
                            <tr>
                                <td>
                                    <label>客户描述：</label>
                                </td>
                                <td>
                                    <label>故障现象：</label>
                                </td>
                                <td>
                                    <label>解决措施：</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                        <textarea class="nui-textarea" name="guestDesc"
                                                  style="width:100%;height: 80px;"></textarea>
                                </td>
                                <td>
                                        <textarea class="nui-textarea" name="faultPhen"
                                                  style="width:100%;height: 80px;"></textarea>
                                </td>
                                <td>
                                        <textarea class="nui-textarea" name="solveMethod"
                                                  style="width:100%;height: 80px;"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="nui-panel" showToolbar="false" title="请填写回访内容"
                 showFooter="true" style="width: 100%; height: 100%">
                <div class="nui-fit">
                    <div id="detailInfoForm">
                        <input class="nui-hidden" name="detailId"/>
                        <input class="nui-hidden" name="serviceId"/>
                        <input class="nui-hidden" name="carId"/>
                        <table>
                            <tr>
                                <td>
                                    <div class="nui-panel" showToolbar="false" title="质量满意度评分"
                                         showFooter="false" style="width: 150px; height: 90px">
                                        <div class="nui-radiobuttonlist" valueField="id"
                                             repeatItems="2" repeatLayout="table"
                                             repeatDirection="vertical" textField="text"
                                             name="qualityDegree"
                                             data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="nui-panel" showToolbar="false" title="服务满意度评分"
                                         showFooter="false" style="width: 150px; height: 90px">
                                        <div class="nui-radiobuttonlist" valueField="id"
                                             repeatItems="2" repeatLayout="table"
                                             repeatDirection="vertical" textField="text"
                                             name="serviceDegree"
                                             data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="nui-panel" showToolbar="false" title="时间满意度评分"
                                         showFooter="false" style="width: 150px; height: 90px">
                                        <div class="nui-radiobuttonlist" valueField="id"
                                             repeatItems="2" repeatLayout="table"
                                             repeatDirection="vertical" textField="text"
                                             name="timeDegree"
                                             data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																			   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="nui-panel" showToolbar="false" title="价格满意度评分" id="radiobuttonlist"
                                         showFooter="false" style="width: 150px; height: 90px">
                                        <div class="nui-radiobuttonlist" valueField="id"
                                             repeatItems="2" repeatLayout="table"
                                             repeatDirection="vertical" textField="text"
                                             name="priceDegree"
                                             data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
														{ id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 }]">
                                            <table>
                                                <tr>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td class="form_label">
                                    <label>回访方式：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" allowInput="false" name="mode"
                                           textField="name" valueField="customid"
                                           id="mode"/>
                                </td>
                                <td class="form_label">
                                    <label>下次保养日期：</label>
                                </td>
                                <td>
                                    <input class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd "
                                           timeFormat="HH:mm:ss" showTime="false" name="careDueDate"
                                           showOkButton="false" showClearButton="true"/>
                                </td>
                                <td class="form_label">
                                    <label>保养周期：</label>
                                </td>
                                <td>
                                    <input id="spinner" class="nui-spinner" minValue="0" maxValue="100000000" name="careCycle"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>回访内容：</label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-textarea" name="content" id="content" style="width:100%;height: 100px;"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>回访员：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="scoutMan" id="scoutMan"/>
                                </td>
                                <td class="form_label">
                                    <label>回访时间：</label>
                                </td>
                                <td>
                                    <input class="nui-datepicker" nullValue="null" format="yyyy-MM-dd " id="scoutDate"
                                           timeFormat="HH:mm:ss" showTime="false" showTime="false" name="scoutDate"
                                           showOkButton="false" showClearButton="true"/>
                                </td>
                                <td>
                                    <a class="nui-button" iconCls="" onclick="choiceScript()">选择话术</a>
                                </td>
                                <td>
                                    <a class="nui-button" iconCls="" onclick="collectScript()">收藏话术</a>
                                    <a class="nui-button" iconCls="" onclick="save()">保存</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>