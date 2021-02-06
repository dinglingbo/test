<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@include file="/common/sysCommon.jsp" %>
<html>
<!--
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>资料管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/nui/xlsx.core.min.js?v=2.0.0"></script>
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/CustomerProfile/AddTelTrackGuest.js?v=1.0.20"></script>
    <style type="text/css">

    .file {
    position: relative;
    display: inline-block;
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 0px 12px;
    text-align: center;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;

}
.file input {
    position: absolute;
    font-size: 10px;
    right: 0;
    top: 0px;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}

    </style>


</head>
<body>
<input name="visitStatus"  id="visitStatus"  visible="false" class="nui-combobox "  textField="name" valueField="customid"/>
<input name="color"  id="color"  visible="false" class="nui-combobox "  textField="name" valueField="customid"/>
<input name="query_orgid"  id="query_orgid"  visible="false" class="nui-combobox "  textField="name" valueField="customid"/>
<input name="man"  id="man"  visible="false" class="nui-combobox "  textField="name" valueField="customid"/>
<input name="carBrandId"  id="carBrandId"  visible="false" class="nui-combobox "  textField="name" valueField="customid"/>
<div class="nui-toolbar" style="padding:4px;border-bottom:0;" id="queryForm">
                    <a href="javascript:;" class="file">点击这里选择文件
                        <input type="file" name="" id="" onchange="importf(this)">
                    </a>
                    <a class="nui-button" iconCls="" plain="true" onclick="sure()" id="openBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
					<a style="text-decoration: none;color: #2779aa;" plain="true" href="<%=request.getContextPath() %>/repair/RepairBusiness/template/phoneGuest.xlsx" download="电销客户导入模板"><span class="fa fa-arrow-down fa-lg"></span>下载模板</a>
</div>


            <div class="nui-fit">
                    <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
                         showPager="true"
                         totalField="page.count"
                         pageSize="50" sizeList=[20,50,100]
                         selectOnLoad="true"
                         ondrawcell=""
                         onrowdblclick=""
                         dataField="data"
                         sortMode="client"
                         idField="id"
                         multiSelect="true"
                         allowCellWrap = true
                         showSummaryRow="true">
                        <div property="columns">
                            <!-- <div type="checkcolumn" width="25"></div> -->
                            <div type="indexcolumn" width="30" summaryType="count">序号</div>
                            <div headerAlign="center">车辆信息
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="orgid" width="120" headerAlign="center" allowSort=false>所在分店</div>
                                    <div field="carNo" width="90" headerAlign="center" allowSort=false>*车牌号</div>
                                    <div field="carBrandId" width="100" headerAlign="center" allowSort=false>品牌</div>
                                    <div field="carModel" width="250" headerAlign="center" allowSort=false>品牌车型</div>
                                    <div field="vin" width="160" headerAlign="center" allowSort=false>车架号</div>
                                    <div field="engineNo" width="160" headerAlign="center" allowSort=false>发动机号</div>
                                    <div field="color" width="160" headerAlign="center" allowSort=false>颜色</div>
                                    <div field="firstRegDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>初登日期</div>
                                    <div field="annualInspectionDate" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>保险到期</div>
                                    <div field="recorder" width="80" headerAlign="center" allowSort=false>建档人</div>
                                    <div field="recordDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>建档日期</div>
                                </div>
                            </div>
                            <div headerAlign="center">客户信息
                                <div property="columns">
                                    <div field="guestId" visible=false>客户ID</div>
                                    <div field="guestName" width="80" headerAlign="center" summaryType="" allowSort=false>*客户名称</div>
                                    <div field="mobile" width="100" headerAlign="center" summaryType="" allowSort=false>*手机号</div>
                                    <div field="contacts" width="80" headerAlign="center" summaryType="" allowSort=false>联系人</div>
                                    <div field="tel" width="100" headerAlign="center" summaryType="" allowSort=false>电话</div>
                                    <div field="sex" width="80" headerAlign="center" summaryType="" allowSort=false>性别</div>
                                    <div field="address" width="150" headerAlign="center" summaryType="" allowSort=false>地址</div>
                                </div>
                            </div>
                            <div headerAlign="center">联系状态
                                <div property="columns">
                                    <div field="visitManId" id="visitManId" name="visitManId" width="60" headerAlign="center" summaryType="" allowSort=false>营销员</div>
                                    <div field="visitStatus" width="100" headerAlign="center" summaryType="" allowSort=false>跟踪状态</div>
                                    <div field="priorScoutDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>上次联系时间</div>
                                    <div field="nextScoutDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>下次联系时间</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
</body>
</html>