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
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/BookingManagement/BookingManagementList.js?v=2.2.6"></script>
        <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 110px;
            text-align: right;
        }

        .required {
            color: red;
        }
        /* #radiobuttonlist{
          float: left; 
        } */
         #wechatTag1{
            color:#ccc;
        }
        #wechatTag{
            color:#62b900;
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
            <div class="nui-form" id="queryForm" style="width: 100%;white-space:nowrap">
                <table style="width: 100%;white-space:nowrap;" id="table1">
                
                    <tr >
                        <td style="display: flex;display: -webkit-flex;flex-wrap: nowrap | wrap | wrap-reverse;">
                       
                            <label>快速查询：</label>
                             <div class="mini-radiobuttonlist" repeatItems="1"
							      repeatLayout="table" repeatDirection="vertical" name="status"
							      textField="text" valueField="value" id = "radiobuttonlist"
							      data="[{value:'0',text:'预约创建日期',},{value:'1',text:'预计来厂日期'}]" value="0" onvaluechanged="setDate()">
						      </div>
						 
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
                            <input class="nui-textbox" id="carNo" name="carNo" onenter="doSearch()" width="80px"/>
                            <label>手机号：</label>
                            <input class="nui-textbox" id="contactorTel" name="contactorTel" onenter="doSearch()" width="100px"/>
                            <label >服务顾问：</label>
                            <input class="nui-combobox" id="mtAdvisorList" name="mtAdvisorList" showNullItem="true" value="" width="80px" textField="empName" valueField="empId" onvalueChanged="doSearch()""
                            />
                            <label class="form_label" width="140px"><span id="setDate" >预约创建日期</span>&nbsp;从：</label>
	                        <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                        <label class="form_label" style="width:15px">至：</label>
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
                         <!-- <a class="nui-button" plain="true" id="btnCall" iconCls="" onclick=""><span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;发送微信</a> -->
                       <!--  <a class="nui-button" plain="true" id="btnshowhistory" iconCls="" onclick="showhistory()" visible="false">
                            <span class="fa fa-shopping-bag fa-lg"></span>&nbsp;服务履历</a> -->
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
                            allowSortColumn="true" >
                            <div property="columns">
                                <div field="id" name="id" headerAlign="center"  visible="false" width="">id </div>
                                <div field="status" name="status" headerAlign="center"  visible="true" width="80" id="updStatus">状态 </div>
                                <div field="prebookSource" name="prebookSource" headerAlign="center"  visible="true" width="90">预约来源</div>
                                <div field="carNo"  name="carNo"headerAlign="center"  visible="true" width="80">车牌号 </div>
                                <div field="carModel" name="carModel" headerAlign="center"  visible="true" width="130">品牌车型 </div>
                                <div field="predictComeDate" name="predictComeDate" headerAlign="center"  dateformat="yyyy-MM-dd HH:mm" visible="true" width="100">预计来厂 </div>
                                <div field="Time"  name="Time" headerAlign="center"  dateformat="yyyy-MM-dd HH:mm" visible="true" width="100">距离来厂时间</div>
                                <div field="contactorName" name="contactorName" headerAlign="center"  visible="true" width="80">客户名称 </div>
                                <div field="contactorTel" name="contactorTel" headerAlign="center"  visible="true" width="100">联系电话 </div>                                
                                <!-- <div field="carSeriesId" name="carSeriesId" headerAlign="center"  visible="true" width="40">车系 </div> -->
                                <div field="serviceTypeId" name="serviceTypeId" headerAlign="center"  visible="true" width="100">业务类型 </div>
                                <div field="prebookCategory" name="prebookCategory" headerAlign="center"  visible="true" width="120">预约类型 </div>
                                <div field="mtAdvisor" name="mtAdvisor" headerAlign="center"  align="center" visible="true" width="100">服务顾问 </div>
                                <div field="mtAdvisorId" name="mtAdvisorId" headerAlign="center"  visible="false" width="">服务顾问Id </div>
                                <div field="isOpenBill" name="isOpenBill" headerAlign="center"  visible="true" width="100">是否开单 </div>
                                <div field="isJudge" name="isJudge" headerAlign="center"  visible="true" width="60">是否评价 </div>
                                <div field="faultDesc" name="faultDesc" headerAlign="center"  visible="true" width="100">客户描述 </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div size="30%" showCollapseButton="true">
                    <div class="nui-fit">
                        <div id="downGrid" class="nui-datagrid" dataField="rs" style="width: 100%; height: 100%;" showPager="false" allowSortColumn="true" allowCellWrap=true>
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center"  width="30">序号</div>
                                <div field="modifier" headerAlign="center"  visible="true" width="100">跟进人 </div>
                                <div field="scoutContent" headerAlign="center"  visible="true" width="300">跟进内容 </div>
                                <div field="scoutDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"  visible="true" width="100">跟进时间 </div>
                                <div field="scoutMode" headerAlign="center"  visible="true" width="100">跟进方式 </div>
                                <div field="isUsabled" headerAlign="center"  visible="true" width="100">跟进结果 </div>
                                <div field="nextScoutDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"  visible="true" width="100">下次跟进时间</div>
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