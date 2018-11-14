<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): steven
  - Date: 2018-06-20
  - Description:
-->

<head>
    <title>预约列表</title>
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/BookingManagement/BookingManagementList.js?v=2.1.1"></script>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 84px;
            text-align: right;
        }

        .required {
            color: red;
        }
    </style>

</head>

<body>
    <div class="nui-fit">
        <input id="scoutMode" class="nui-combobox" visible="false" />
        <input id="isUsabled" class="nui-combobox" visible="false" />
        <input id="bookStatus" class="nui-combobox" visible="false" />
        <input id="carBrandList" class="nui-combobox" visible="false" />
        <input id="carSeriesList" class="nui-combobox" visible="false" />
        <input id="bisinessList" class="nui-combobox" visible="false" />
        <input id="scoutModeList" class="nui-combobox" visible="false" />
        <input id="scoutReustList" class="nui-combobox" visible="false" />

        <div class="nui-toolbar" style="border-bottom:0;">
            <div class="nui-form" id="queryForm" style="width: 100%;">
                <table style="width: 100%;" id="table1">
                    <tr>
                        <td>
                            <label>快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenu_date" id="menuBtnDateQuickSearch" name="menuBtnDateQuickSearch" value="0">本日</a>
                            <ul id="popupMenu_date" class="nui-menu" style="display:none;">
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 0, '本日')">本日</li>
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 1, '昨日')">昨日</li>
                                <li class="separator"></li>
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 2, '本周')">本周</li>
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 3, '上周')">上周</li>
                                <li class="separator"></li>
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 4, '本月')">本月</li>
                                <li onclick="quickSearch(menuBtnDateQuickSearch, 5, '上月')">上月</li>
                            </ul>

                            <a class="nui-menubutton " menu="#popupMenu_status" id="menuBtnStatusQuickSearch" name="menuBtnStatusQuickSearch" value="-1">所有</a>
                            <ul id="popupMenu_status" class="nui-menu" style="display:none;">
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, -1,'所有')">所有</li>
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, 0, '待确认')">待确认</li>
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, 1, '已确认')">已确认</li>
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, 2, '已取消')">已取消</li>
                                <li class="separator"></li>
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, 3, '已开单')">已开单</li>
                                <li class="separator"></li>
                                <li onclick="quickSearch(menuBtnStatusQuickSearch, 4, '已评价')">已评价</li>
                            </ul>

                            <span class="separator"></span>
                            <label>车牌号：</label>
                            <input class="nui-textbox" id="carNo" name="carNo" />
                            <label>手机号：</label>
                            <input class="nui-textbox" id="contactorTel" name="contactorTel" />
                            <label >服务顾问：</label>
                            <input class="nui-combobox" id="mtAdvisorList" name="mtAdvisorList" showNullItem="true" value="" textField="empName" valueField="empId"
                            />
                            <label class="form_label">创建日期&nbsp;从：</label>
	                        <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                        <label class="form_label">至：</label>
	                        <input format="yyyy-MM-dd" style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" plain="true" onclick="doSearch()">
                                <span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="nui-toolbar" style="border-bottom: 0;">
            <table style="width: 100%">
                <tr>
                    <td>
                        <a class="nui-button" plain="true" id="btnAdd" onclick="addRow()">
                            <span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" id="btnEdit" onclick="editRow()">
                            <span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                        <a class="nui-button" plain="true" id="btnconfirm" iconCls="" onclick="confirmRow()">
                            <span class="fa fa-check fa-lg"></span>&nbsp;确认</a>
                        <a class="nui-button" plain="true" id="btnNewBill" iconCls="" onclick="newBill()">
                            <span class="fa fa-clone fa-lg"></span>&nbsp;开单</a>
                        <a class="nui-button" plain="true" id="btnCancel" onclick="cancelBill()">
                            <span class="fa fa-times-circle"></span>&nbsp;取消</a>
                        <a class="nui-button" plain="true" id="btnCall" iconCls="" onclick="callBill()">
                            <span class="fa fa-comment-o fa-lg"></span>&nbsp;跟进</a>
                         <a class="nui-button" plain="true" id="btnCall" iconCls="" onclick=""><span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;发送微信</a>
                        <a class="nui-button" plain="true" id="btnshowhistory" iconCls="" onclick="showhistory()" visib le="false">
                            <span class="fa fa-shopping-bag fa-lg"></span>&nbsp;服务履历</a>
                    </td>
                </tr>
            </table>
        </div>

        <div class="nui-fit">
            <div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
                <div size="70%" showCollapseButton="true">
                    <div class="nui-fit">
                        <div id="upGrid" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20" dataField="rs" showPageSize="false"
                            selectOnLoad="true" sortMode="client" showReloadButton="false" showPagerButtonIcon="true" totalField="page.count"
                            allowSortColumn="true">
                            <div property="columns">
                                <div field="id" headerAlign="center" allowSort="true" visible="false" width="">id </div>
                                <div field="status" headerAlign="center" allowSort="true" visible="true" width="40" id="updStatus">状态 </div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" align="center" visible="true" width="40">服务顾问 </div>
                                <div field="mtAdvisorId" headerAlign="center" allowSort="true" visible="false" width="">服务顾问Id </div>
                                <div field="contactorName" headerAlign="center" allowSort="true" visible="true" width="60">客户名称 </div>
                                <div field="contactorTel" headerAlign="center" allowSort="true" visible="true" width="60">联系电话 </div>                                
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="40">车牌号 </div>
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="40">品牌 </div>
                                <div field="carSeriesId" headerAlign="center" allowSort="true" visible="true" width="40">车系 </div>
                                <div field="serviceTypeId" headerAlign="center" allowSort="true" visible="true" width="40">业务类型 </div>
                                <div field="predictComeDate" headerAlign="center" allowSort="true" dateformat="yyyy-MM-dd HH:mm" visible="true" width="60">预计来厂 </div>
                                <div field="prebookCategory" headerAlign="center" allowSort="true" visible="true" width="40">预约类型 </div>
                                <div field="isOpenBill" headerAlign="center" allowSort="true" visible="true" width="40">是否开单 </div>
                                <div field="isJudge" headerAlign="center" allowSort="true" visible="true" width="40">是否评价 </div>
                                <div field="prebookSource" headerAlign="center" allowSort="true" visible="true" width="40">预约来源</div>
                                <div field="faultDesc" headerAlign="center" allowSort="true" visible="true" width="100">客户描述 </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div size="30%" showCollapseButton="true">
                    <div class="nui-fit">
                        <div id="downGrid" class="nui-datagrid" dataField="rs" style="width: 100%; height: 100%;" showPager="false" allowSortColumn="true" allowCellWrap=true>
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                                <div field="modifier" headerAlign="center" allowSort="true" visible="true" width="100">跟进人 </div>
                                <div field="scoutContent" headerAlign="center" allowSort="true" visible="true" width="300">跟进内容 </div>
                                <div field="scoutDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" visible="true" width="100">跟进日期 </div>
                                <div field="scoutMode" headerAlign="center" allowSort="true" visible="true" width="100">跟进方式 </div>
                                <div field="isUsabled" headerAlign="center" allowSort="true" visible="true" width="100">跟进结果 </div>
                                <div field="nextScoutDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" visible="true" width="100">下次跟进时间</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- </div> -->
</body>

</html>