<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>维修接待</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/receptionDetail.js?v=1.1.5"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1">
        <input class="nui-hidden" name="id"/>
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" plain="true" onclick="quickSearch(0)" id="type0">我接待的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(1)" id="type1">在报价的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(2)" id="type2">在维修的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(3)" id="type3">已完工的车</a>
                    <a class="nui-button" plain="true" onclick="quickSearch(4)" id="type4">在结算的车</a>
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
                <a class="nui-button" plain="true" iconCls="icon-reload" onclick="reloadLeftGrid()">刷新</a>
                <a class="nui-button" plain="true" iconCls="icon-add" onclick="add()">新增</a>
                <a class="nui-button" plain="true" id="addProductBtn" iconCls="icon-addnew" onclick="entry()">产品录入</a>
                <a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存</a>
                <a class="nui-button" plain="true" id="sureMtBtn" iconCls="" onclick="sureMt()">确定维修</a>
                <a class="nui-button" plain="true" id="unMtBtn" iconCls="" onclick="noRepair()">未修归档</a>
                <a class="nui-button" plain="true" id="reviewBtn" iconCls="" onclick="examine()">审核</a>
                <a class="nui-button" plain="true" id="balanceBtn" iconCls="" onclick="settlement()">结算</a>
                <a class="nui-button" plain="true" id="outBtn" iconCls="" onclick="issue()">出单</a>
                <a class="nui-button" plain="true" id="returnBtn" iconCls="" onclick="returnList()">返单</a>
                <a class="nui-button" plain="true" iconCls="icon-user" onclick="showCustomer()">客户</a>
                <a class="nui-MenuButton" plain="true" iconCls="icon-date" menu="#ohterMenu">其他</a>
                <a class="nui-MenuButton" plain="true" iconCls="icon-print" menu="#printMenu">打印</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;"
         borderStyle="border:0"
         allowResize="false">
        <div size="300" showCollapseButton="false" style="border: 0;">
            <div id="leftGrid" dataField="list" class="nui-datagrid"
                 style="width: 100%; height: 100%;"
                 pageSize="20"
                 showPageInfo="true"
                 multiSelect="true"
                 showPageIndex="true"
                 showPage="true"
                 showPageSize="false"
                 selectOnLoad="true"
                 showReloadButton="false"
                 showPagerButtonIcon="true"
                 totalField="page.count"
                 allowSortColumn="true">
                <div property="columns">
                    <div field="carNo" headerAlign="center" allowSort="true"
                         visible="true" width="50">车牌
                    </div>
                    <div field="carBrandId" headerAlign="center" allowSort="true"
                         visible="true" width="60">品牌
                    </div>
                    <div field="status" headerAlign="center"
                         allowSort="true" visible="true" width="60">进程
                    </div>
                    <div field="mtAuditor" headerAlign="center"
                         allowSort="true" visible="true" width="60">维修顾问
                    </div>
                    <div field="serviceCode" headerAlign="center"
                         allowSort="true" visible="true">工单号
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border: 0;">
            <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 100%;" plain="false">
                <div title="基本信息">
                    <div class="nui-form" id="basicInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId"/>
                        <input class="nui-hidden" name="contactorId"/>
                        <input class="nui-hidden" name="carId"/>
                        <input class="nui-hidden" name="status"/>
                        <input class="nui-hidden" name="drawOutReport"/>
                        <input class="nui-hidden" name="outBillSign"/>
                        <div class="nui-panel" title="基本信息" borderStyle="border-bottom: 0; " style="width: 100%; ">
                            <table class="nui-form-table">
                                <tr>
                                    <td class="form_label">
                                        <label>车牌号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="carNo" id="carNo" enabled="false"/>
                                        <a class="nui-button" id="changeCarBtn" onclick="changeCar()">改</a>
                                    </td>
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
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>维修顾问：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="mtAdvisorId" id="mtAdvisorId"
                                               valueField="empId" textField="empName"
                                               allowInput="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>进厂油量：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="enterOilMass"
                                               valueField="customid" textField="name"
                                               id="enterOilMass" allowInput="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>进厂里程：</label>
                                    </td>
                                    <td>
                                        <input class="nui-Spinner"
                                               minValue="0" maxValue="100000000"
                                               name="enterKilometers" allowNull="false"
                                               showButton="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>进厂日期：</label>
                                    </td>
                                    <td>
                                        <input name="enterDate" class="nui-datepicker" value="" nullValue="null"
                                               format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>报价日期：</label>
                                    </td>
                                    <td>
                                        <input name="quoteDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
                                               nullValue="null" timeFormat="HH:mm:ss" showTime="true"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>维修日期：</label>
                                    </td>
                                    <td>
                                        <input name="sureMtDate" class="nui-datepicker" enabled="false" format="yyyy-MM-dd"
                                               timeFormat="HH:mm:ss" showTime="false"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>完工日期：</label>
                                    </td>
                                    <td>
                                        <input name="checkDate" class="nui-datepicker" enabled="false"
                                               format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>预计交车：</label>
                                    </td>
                                    <td>
                                        <input name="planFinishDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
                                               nullValue="null" timeFormat="HH:mm:ss" showTime="true"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td class="form_label">
                                        <label>接车卡号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="serviceCard"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>是否洗车：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="isCarWash"
                                               data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                               allowInput="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>备注：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" name="remark" style="width: 100%;"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-panel" title="描述信息"
                             borderStyle="border-bottom: 0; "
                             style="border-bottom: 0; width: 100%; ">
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
                        <div class="nui-panel" title="客户/车辆信息" style="border-bottom: 0;width: 100%;">
                            <table class="nui-form-table">
                                <tr>
                                    <td class="form_label">
                                        <label>VIN：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="carVin" enabled="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>品牌车型：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" name="carModel" style="width: 100%" enabled="false"/>
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
                                        <label>客户名称：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" style="width: 100%" name="guestFullName" enabled="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_label">
                                        <label>联系人姓名：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="contactorName" enabled="false"/>
                                    </td>
                                    <td class="form_label">
                                        <label>身份：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="identity" enabled="false"
                                               valueField="customid" textField="name"
                                               id="identity"/>
                                    </td>
                                    <td class="form_label">
                                        <label>手机号码：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="mobile" enabled="false"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="项目录入">
                    <div class="nui-toolbar">
                        <div id="itemQueryForm" class="form">
                            <table>
                                <tr>
                                    <td>
                                        <label>编码：</label>
                                        <input class="nui-textbox" name="code"/>
                                        <label>名称：</label>
                                        <input class="nui-textbox" name="name"/>
                                        <label>拼音：</label>
                                        <input class="nui-textbox" name="pyName"/>
                                        <label>品牌车型：</label>
                                        <input class="nui-textbox" name="carModel"/>
                                        <a class="nui-button" iconCls="icon-search" onclick="onSearchItem()" plain="true">查询</a>
                                        <a class="nui-button" id="change" iconCls="icon-ok" onclick="selectItem()" plain="true">选择</a>
                                        <a class="nui-button" id="new" iconCls="icon-new" onclick="selectPackage()" plain="true">本店套餐录入</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="nui-fit">
                        <div class="nui-splitter" style="width: 100%; height: 100%;"
                             borderStyle="border-top:0;"
                             allowResize="false">
                            <div size="150" showCollapseButton="false">
                                <div class="nui-toolbar"
                                     style="padding: 2px;text-align: center;border-top:0;border-right: 0;border-left: 0;">
                                    <span>项目类型</span>
                                </div>
                                <div class="nui-fit">
                                    <ul id="tree1" class="nui-tree"style="width: 100%;"
                                        resultAsTree="false"
                                        showTreeIcon="true"
                                        textField="name"
                                        idField="id">
                                    </ul>
                                </div>
                            </div>
                            <div showCollapseButton="false">
                                <div id="itemGrid"
                                     dataField="list"
                                     class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     borderStyle="border:0"
                                     pageSize="50"
                                     totalField="page.count"
                                     showPageSize="true"
                                     allowSortColumn="true"
                                     selectOnLoad="true"
                                     allowCellSelect="true"
                                     showFilterRow="false">
                                    <div property="columns">
                                        <div header="项目基本信息" headerAlign="center">
                                            <div property="columns">
                                                <div field="name" headerAlign="center" allowSort="true" width="">名称</div>
                                                <div field="itemKind" headerAlign="center" allowSort="true" width="40px">工种</div>
                                                <div field="typeName" headerAlign="center" allowSort="true" width="100px">类型</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="套餐清单">
                    <div class="nui-toolbar" style="border-bottom:0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" plain="true" id="addRpsPackageBtn" iconCls="icon-edit" onclick="editRpsPackage()">修改</a>
                                    <a class="nui-button" plain="true" id="delRpsPackageBtn" iconCls="icon-remove" onclick="removeRpsPackage()">删除</a>
                                    <a class="nui-button" plain="true" id="sureMtPackageBtn" iconCls="icon-ok" iconCls="" onclick="sureMtRpsPackage()">同意维修</a>
                                    <label>套餐合计：</label>
                                    <label id="pkgTotal"></label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
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
                </div>
                <div title="估算项目/材料">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSize="0"
                         vertical="true" allowResize="false">
                        <div size="50%" showCollapseButton="false">
                            <div class="nui-toolbar" style="border-bottom: 0;">
                                <table>
                                    <tr>
                                        <td>
                                            <a class="nui-button" plain="true" id="addItemQuoteBtn" iconCls="icon-add" onclick="addRpsItemQuote()">新增</a>
                                            <a class="nui-button" plain="true" id="editItemQuoteBtn" iconCls="icon-edit" onclick="editRpsItemQuote()">修改</a>
                                            <a class="nui-button" plain="true" id="delItemQuoteBtn" iconCls="icon-remove" onclick="removeRpsItemQuote()">删除</a>
                                            <a class="nui-button" plain="true" id="sureMtItemQuoteBtn" iconCls="icon-ok" iconCls="" onclick="sureMtItem()">同意维修</a>
                                            <label>估算合计：</label>
                                            <label id="rpsItemPartQuoteAmt"></label>
                                        </td>
                                    </tr>
				                </table>
                            </div>
                            <div class="nui-fit">
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
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-toolbar" style="border-bottom:0;border-top:0;">
                                <table>
                                    <tr>
                                        <td>
                                            <a class="nui-button" iconCls="icon-add" id="addPartQuoteBtn" onclick="addRpsPartQuote()">新增</a>
                                            <a class="nui-button" iconCls="icon-edit" id="editPartQuoteBtn" onclick="editRpsPartQuote()">修改</a>
                                            <a class="nui-button" iconCls="icon-remove" id="delPartQuoteBtn" onclick="removeRpsPartQuote()">删除</a>
                                            <a class="nui-button" id="sureMtPartQuoteBtn" iconCls="icon-ok" iconCls="" onclick="sureMtPart()">同意维修</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="nui-fit">
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
                        </div>
                    </div>
                </div>
                <div title="维修项目/材料">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSize="0"
                         allowResize="false" vertical="true">
                        <div size="50%" showCollapseButton="false" style="border:0;">
                            <div class="nui-toolbar" style="border-bottom:0;">
                                <table>
                                    <tr>
                                        <td>
                                            <a class="nui-button" iconCls="icon-edit" id="editItemBtn" onclick="editRpsItem()">修改</a>
                                            <a class="nui-button" iconCls="icon-remove" id="delItemBtn" onclick="removeRpsItem()">删除</a>
                                            <label>维修合计：</label>
                                            <label id="rpsItemPartAmt"></label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="nui-fit">
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
                        </div>
                        <div showCollapseButton="false">
                            <div class="nui-toolbar" style="border-bottom:0;border-top:0;">
                                <table>
                                    <tr>
                                        <td>
                                            <a class="nui-button" iconCls="icon-edit" id="editPartBtn" onclick="editRpsPart()">修改</a>
                                            <a class="nui-button" iconCls="icon-remove" id="delPartBtn" onclick="removeRpsPart()">删除</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="nui-fit">
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
                        </div>
                    </div>
                </div>
                <div title="出单项目/材料" name="bill" visible="false">
                    <div class="nui-panel" title="基本信息" borderStyle="border-bottom: 0; " style="width: 100%; ">
                        <table class="nui-form-table">
                            <tr>
                                <td class="form_label">
                                    <label>进厂日期：</label>
                                </td>
                                <td>
                                    <input id="outEnterDate" class="nui-datepicker" value="" nullValue="null"
                                           format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
                                </td>
                                <td class="form_label">
                                    <label>离厂日期：</label>
                                </td>
                                <td>
                                    <input id="outLeaveDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
                                           nullValue="null" timeFormat="HH:mm:ss" showTime="true"
                                           showOkButton="false" showClearButton="true"/>
                                </td>
                                <td class="form_label">
                                    <label>打印日期：</label>
                                </td>
                                <td>
                                    <input id="outPrintDate" class="nui-datepicker" enabled="true" format="yyyy-MM-dd"
                                           timeFormat="HH:mm:ss" showTime="false"
                                           showOkButton="false" showClearButton="true"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <div class="nui-splitter" style="width: 100%; height: 100%"
                             borderStyle="border:0;"
                             handlerSize="0"
                             allowResize="false" vertical="true">
                            <div size="50%" showCollapseButton="false" style="border:0;">
                                <div class="nui-toolbar" style="border-bottom:0;">
                                    <table>
                                        <tr>
                                            <td>
                                                <a class="nui-button" iconCls="icon-add" onclick="addRpsItemBill()">新增</a>
                                                <a class="nui-button" iconCls="icon-edit" onclick="editRpsItemBill()">修改</a>
                                                <a class="nui-button" iconCls="icon-remove" onclick="removeRpsItemBill()">删除</a>
                                                <label>出单合计：</label>
                                                <label id="rpsItemPartBillAmt"></label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
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
                            <div showCollapseButton="false">
                                <div class="nui-toolbar" style="border-bottom:0;border-top:0;">
                                    <table>
                                        <tr>
                                            <td>
                                                <a class="nui-button" iconCls="icon-add" onclick="addRpsPartBill()">新增</a>
                                                <a class="nui-button" iconCls="icon-edit" onclick="editRpsPartBill()">修改</a>
                                                <a class="nui-button" iconCls="icon-remove" onclick="removeRpsPartBill()">删除</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
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
                </div>
                <div title="出车报告" visible="false" name="report">
                    <div class="nui-toolbar" style="border: 0;">
                        <table>
                            <tr>
                                <td>
                                    <a class="nui-button" id="selectReportBtn" iconCls="icon-ok" onclick="selectReport()" plain="true">选择</a>
                                    <a class="nui-button" id="clearReportBtn" iconCls="icon-remove" onclick="clearReport()" plain="true">清空</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="nui-fit">
                        <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport" style="width:100%;height:100%;"></textarea>
                    </div>
                </div>
                <div title="辅料清单">
                    <div id="auxiliaryGrid" dataField="list" class="nui-datagrid"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         sortMode="client"
                         allowSortColumn="true">
                        <div property="columns">
                            <div field="partCode" headerAlign="center" allowSort="true"
                                 visible="true" width="">辅料编码
                            </div>
                            <div field="partName" headerAlign="center" allowSort="true"
                                 visible="true" width="">辅料名称
                            </div>
                            <div field="outQty" headerAlign="center" datatype="int" align="right"
                                 allowSort="true" visible="true" width="">数量
                            </div>
                            <div field="trueUnitPrice" headerAlign="center" datatype="float" align="right"
                                 allowSort="true" visible="true" width="">单价
                            </div>
                            <div field="trueCost" headerAlign="center" datatype="float" align="right"
                                 allowSort="true" visible="true" width="">金额
                            </div>
                        </div>
                    </div>
                </div>
                <div title="库存查询">
                    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                        <div class="form" id="queryForm">
                            <table style="width:100%;">
                                <tr>
                                    <td style="white-space:nowrap;">
                                        <label style="font-family:Verdana;">尾号：</label>
                                        <input class="nui-textbox" width="100" name="endOfCode"/>
                                        <label style="font-family:Verdana;">简称：</label>
                                        <input class="nui-textbox" width="100" name="shortName"/>
                                        <label style="font-family:Verdana;">名称：</label>
                                        <input class="nui-textbox" width="100" name="name"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label style="font-family:Verdana;">品牌：</label>
                                        <input id="carBrand"
                                               name="carBrand"
                                               class="nui-combobox width1"
                                               textField="nameCn"
                                               valueField="id"
                                               emptyText="请选择..."
                                               url=""
                                               allowInput="false"
                                               showNullItem="true"
                                               nullItemText="请选择..."/>
                                        <label style="font-family:Verdana;">编码：</label>
                                        <input class="nui-textbox" width="100" name="partCode"/>
                                        <a class="nui-button" iconCls="icon-search" plain="true" onclick="searchStock()">查询</a>
                                        <a class="nui-button" iconCls="icon-search" plain="true" onclick="searchStock(1)">今日入库</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="nui-fit">
                        <div id="stockGrid" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             dataField="list"
                             pageSize="20"
                             sortMode="client"
                             totalField="page.count"
                             allowSortColumn="true">
                            <div property="columns">
                                <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                <div field="type" headerAlign="center" header="零件基本信息">
                                    <div property="columns">
                                        <div field="partCode" headerAlign="center" allowSort="true" visible="true" header="零件编码"></div>
                                        <div field="partName" headerAlign="center" allowSort="true" visible="true" header="零件名称"></div>
                                        <div field="outableQty" headerAlign="center" allowSort="true" visible="true" header="数量" datatype="int" align="right"></div>
                                    </div>
                                </div>
                                <div field="type" headerAlign="center" header="售价信息">
                                    <div property="columns">
                                        <div field="assignPrice" headerAlign="center" allowSort="true" visible="true" header="指定销价" datatype="float" align="right"></div>
                                        <div field="suggestPrice" headerAlign="center" allowSort="true" visible="true" header="建议销价" datatype="float" align="right"></div>
                                    </div>
                                </div>
                                <div field="type" headerAlign="center" header="配件辅助信息">
                                    <div property="columns">
                                        <div field="stockLocation" headerAlign="center" allowSort="true" visible="true" header="仓位"></div>
                                        <div field="" headerAlign="center" allowSort="true" visible="true" header="类型"></div>
                                        <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="品牌车型"></div>
                                        <div field="unit" headerAlign="center" allowSort="true" visible="true" header="单位"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- menu -->
<ul id="ohterMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li>储值卡销售</li>
    <li>储值卡充值</li>
    <li>车牌替换/修改</li>
    <li onclick="onReferral()">等级转介绍客户</li>
</ul>
<ul id="printMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li>打印维修委托单（A）</li>
    <li>打印派工单（C）</li>
    <li>打印结算单（E）</li>
    <li>打印出单结算单（F）</li>
</ul>

</body>
</html>