<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>

<head>
    <title>特别关怀</title>
    <script src="<%=request.getContextPath()%>/manage/js/specialAttention.js?v=1.2.2">
    </script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
</head>

<body style="margin:0;width: 100%; height:100%;overflow-x:hidden">
    <div id="tabs" class="nui-tabs" width="100%" height="100%" onactivechanged="change(e)" activeIndex="0">
        <div title="商业险到期提醒">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
                            <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'syx')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'syx')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'syx')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'syx')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'syx')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'syx')" id="type5">上月</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(10,'syx')" id="type10">本年</li>
                                <li iconCls="" onclick="quickSearch(11,'syx')" id="type11">上年</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>

                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                    class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
                    pageSize="20" showPageInfo="true"   selectOnLoad="true"   onDrawCell="onDrawCell" onselectionchanged="" allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="carModel"name="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="annualInspectionCompName" name="annualInspectionCompName"headerAlign="center" allowSort="true" width="100px">保险公司</div>
                        <div field="annualStatus" name="annualStatus"headerAlign="center" allowSort="true" width="60px">状态</div>
                        <div field="annualInspectionDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true"
                            width="50px">
                            商业险到期日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="交强险到期提醒">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate2" id="menunamedate2">本日</a>
                            <ul id="popupMenuDate2" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'jqx')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'jqx')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'jqx')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'jqx')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'jqx')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'jqx')" id="type5">上月</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(10,'jqx')" id="type10">本年</li>
                                <li iconCls="" onclick="quickSearch(11,'jqx')" id="type11">上年</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate2" name="startDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate2" name="endDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                    class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="compulsoryInsurance" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="true" pageSize="20" showPageInfo="true" selectOnLoad="true" onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="carModel"  name="carModel"headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="insureCompName"  name="insureCompName"headerAlign="center" allowSort="true" width="100px">保险公司</div>
                        <div field="insureStatus"  name="insureStatus"headerAlign="center" allowSort="true" width="60px">状态</div>
                        <div field="insureDueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true"
                            width="50px">
                            交强险到期日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="驾照年审提醒">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate3" id="menunamedate3">本日</a>
                            <ul id="popupMenuDate3" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'jzns')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'jzns')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'jzns')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'jzns')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'jzns')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'jzns')" id="type5">上月</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(10,'jzns')" id="type10">本年</li>
                                <li iconCls="" onclick="quickSearch(11,'jzns')" id="type11">上年</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate3" name="startDate3" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate3" name="endDate3" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>

                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                    class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="drivingLicense" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="true" pageSize="20" showPageInfo="true"   selectOnLoad="true"   onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="orgid" headerAlign="center" allowSort="true" visible="false">orgid</div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestName" name="guestName"headerAlign="center" allowSort="true" width="100px">客户姓名</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="60px">电话</div>
                        <div field="licenseStatus"  name="licenseStatus"headerAlign="center" allowSort="true" width="60px">状态</div>
                        <div field="licenseOverDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true"
                            width="50px">
                            驾照年审日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="车辆年检提醒">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate4" id="menunamedate4">本日</a>
                            <ul id="popupMenuDate4" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'clnj')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'clnj')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'clnj')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'clnj')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'clnj')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'clnj')" id="type5">上月</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(10,'clnj')" id="type10">本年</li>
                                <li iconCls="" onclick="quickSearch(11,'clnj')" id="type11">上年</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate4" name="startDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate4" name="endDate2" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                    class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="car" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20"
                    multiSelect="true" showPageInfo="true" selectOnLoad="true" onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="carModel" name="carModel"headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="veriStatus" name="veriStatus"headerAlign="center" allowSort="true" width="60px">状态</div>
                        <div field="annualVerificationDueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"
                            allowSort="true" width="50px">
                            车辆年检到期日期</div>
                    </div>
                </div>
            </div>
        </div>

        <div title="客户生日提醒">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate5" id="menunamedate5">本日</a>
                            <ul id="popupMenuDate5" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'khsr')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'khsr')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'khsr')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'khsr')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'khsr')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'khsr')" id="type5">上月</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(10,'khsr')" id="type10">本年</li>
                                <li iconCls="" onclick="quickSearch(11,'khsr')" id="type11">上年</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate5" name="startDate5" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate5" name="endDate5" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                    class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="guestBirthday" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="true" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">orgid</div>
                        <div field="guestName"  name="guestName"headerAlign="center" allowSort="true" width="100px">客户姓名</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="60px">电话</div>
                        <div field="birthdayType"  name="birthdayType"headerAlign="center" allowSort="true" width="100px">生日类型</div>
                        <div field="birStatus"  name="birStatus"headerAlign="center" allowSort="true" width="60px">状态</div>
                        <div field="birthday" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="50px">生日</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>