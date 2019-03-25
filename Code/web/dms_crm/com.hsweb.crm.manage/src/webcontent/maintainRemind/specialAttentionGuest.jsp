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
    <script src="<%=request.getContextPath()%>/manage/js/maintainRemMain/specialAttentionGuest.js?v=1.1.5">
    </script>
    <style>
          html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        #wechatTag1{
            color:#ccc;
    }
    #wechatTag{
        color:#62b900;
    }
    
    </style>
</head>
<body style="margin:0;width: 100%; height:100%;overflow-x:hidden">
    <input name="visitMode" id="visitMode" class="nui-combobox "textField="name" valueField="customid" visible="false"/>
    <div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
        <div size="70%" showCollapseButton="true">

    <div id="tabs" class="nui-tabs" width="100%" height="100%" onactivechanged="change(e)" activeIndex="0">
        <div title="保养提醒" name="bytx">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label style="font-family:Verdana;">快速查询：</label>
                            <a class="nui-menubutton " menu="#popupMenuDate0" id="menunamedate0">本日</a>
                            <ul id="popupMenuDate0" class="nui-menu" style="display:none;">
                                <li iconCls="" onclick="quickSearch(0,'bytx')" id="type0">本日</li>
                                <li iconCls="" onclick="quickSearch(1,'bytx')" id="type1">昨日</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(2,'bytx')" id="type2">本周</li>
                                <li iconCls="" onclick="quickSearch(3,'bytx')" id="type3">上周</li>
                                <li class="separator"></li>
                                <li iconCls="" onclick="quickSearch(4,'bytx')" id="type4">本月</li>
                                <li iconCls="" onclick="quickSearch(5,'bytx')" id="type5">上月</li>
                            </ul>
                            到期日期:
                            <input class="nui-datepicker" id="startDate0" name="startDate0" dateFormat="yyyy-MM-dd" style="width:100px" />
                            至
                            <input class="nui-datepicker" id="endDate0" name="endDate0" dateFormat="yyyy-MM-dd" style="width:100px" />
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>

                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                                <a id="wcBtn13" class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                    <a id="wcBtn14" class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                    <a id="wcBtn15" class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                    <span id="showMonile0" style="display: none;">
                                            <span class="separator"></span>
                                            <span id="mobileText0" style="color: red;font-weight:bold;display: inline-block;"></span>
                                        </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="reminding" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
                    pageSize="20" showPageInfo="true"   selectOnLoad="true"   onDrawCell="onDrawCell" onselectionchanged="" 
                    allowSortColumn="false" totalField='page.count'>
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="careDueDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true"
                        width="100px">
                            下次保养日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="商业险到期提醒" name="syx">
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
                                <a id="wcBtn23" class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                    <a id="wcBtn24"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                    <a id="wcBtn25"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                    <span id="showMonile" style="display: none;">
                                            <span class="separator"></span>
                                            <span id="mobileText" style="color: red;font-weight:bold;display: inline-block;"></span>
                                        </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
                    pageSize="20" showPageInfo="true"   selectOnLoad="true"   onDrawCell="" onselectionchanged="" allowSortColumn="false"
                    totalField='page.count'>
                    <div property="columns" >
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="annualInspectionCompName" headerAlign="center" allowSort="true" width="100px">保险公司</div>
                        <div field="annualInspectionDate" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true"
                        width="100px">
                            商业险到期日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="交强险到期提醒" name='jqx'>
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
                                <a id="wcBtn33"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                    <a id="wcBtn34"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                    <a id="wcBtn35"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                    <span id="showMonile2" style="display: none;">
                                            <span class="separator"></span>
                                            <span id="mobileText2" style="color: red;font-weight:bold;display: inline-block;"></span>
                                        </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="compulsoryInsurance" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true" onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false" totalField='page.count'>
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="insureCompName" headerAlign="center" allowSort="true" width="100px">保险公司</div>
                        <div field="insureDueDate" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true"
                        width="100px">
                            交强险到期日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="驾照年审提醒" name='jzns'>
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
                                <a id="wcBtn43"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                    <a id="wcBtn44"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                    <a id="wcBtn45"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                    <span id="showMonile3" style="display: none;">
                                            <span class="separator"></span>
                                            <span id="mobileText3" style="color: red;font-weight:bold;display: inline-block;"></span>
                                        </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="drivingLicense" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="false" pageSize="20" showPageInfo="true"   selectOnLoad="true"   onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false" totalField='page.count'>
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="orgid" headerAlign="center" allowSort="true" visible="false">orgid</div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="licenseOverDate" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true"
                        width="100px">
                            驾照年审日期</div>
                    </div>
                </div>
            </div>
        </div>
        <div title="车辆年检提醒" name='clnj'>
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
                                <a id="wcBtn53"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()"><span
                                    class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                    <a id="wcBtn54"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                    <a id="wcBtn55"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                    <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                    <span id="showMonile4" style="display: none;">
                                            <span class="separator"></span>
                                            <span id="mobileText4" style="color: red;font-weight:bold;display: inline-block;"></span>
                                        </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="car" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" pageSize="20"
                    multiSelect="false" showPageInfo="true" selectOnLoad="true" onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false" totalField='page.count'>
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">carId</div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="dueDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                            allowSort="true" width="100px">
                            车辆年检到期日期</div>
                    </div>
                </div>
            </div>
        </div>

        <div title="客户生日提醒" name='khsr'>
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <label>客户生日在</label>
                            <input class="nui-textbox" name="" id="bir" style="width: 80px;" vtype="int" value="30"/>
                            <label>天以内</label>
                            <a class="nui-button" iconcls="" name="" plain="true" onclick="change(1)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                            <li class="separator"></li>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="remind()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span
                                class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a id="wcBtn63"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcText()" visible="false"><span
                                class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                                <a id="wcBtn64"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                                <a id="wcBtn65"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
                                <a class="nui-button" plain="true" iconCls="" plain="false" onclick="updateDate()"><span class="fa fa-vcard-o fa-lg"></span>&nbsp;修改信息</a>
                                <span id="showMonile5" style="display: none;">
                                        <span class="separator"></span>
                                        <span id="mobileText5" style="color: red;font-weight:bold;display: inline-block;"></span>
                                    </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="guestBirthday" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                    multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="onDrawCell" onselectionchanged=""
                    allowSortColumn="false" totalField='page.count'>
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                        <div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                        <div field="guestId" headerAlign="center" allowSort="true" visible="false">guestId</div>
                        <div field="carId" headerAlign="center" allowSort="true" visible="false">orgid</div>
                        <div field="carNo" headerAlign="center" allowSort="true" width="100px">车牌号</div>
                        <div field="guestName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
                        <div field="mobile" headerAlign="center" allowSort="true" width="100px">联系方式</div>
                        <div field="carModel" headerAlign="center" allowSort="true" width="100px">品牌车型</div>
                        <div field="guestType" headerAlign="center" allowSort="true" width="100px">客户类型</div>
                        <div field="birComeDay" headerAlign="center" allowSort="true" width="100px">距离天数</div>
                        <div field="birthday" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true" width="100px">生日</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        <div >
        <div class="nui-fit">
            <div id="visitHis" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="" onselectionchanged=""
                allowSortColumn="false" totalField='page.count' allowCellWrap="true">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                    <div field="serviceType" headerAlign="center" allowSort="true" width="100px">回访类型</div>
                    <div field="visitMode" headerAlign="center" allowSort="true" width="100px">回访方式</div>
                    <div field="visitContent" headerAlign="center" allowSort="true" width="200px">回访内容</div>
                    <div field="visitMan" headerAlign="center" allowSort="true" width="100px">回访员</div>
                    <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="100px">回访日期</div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>