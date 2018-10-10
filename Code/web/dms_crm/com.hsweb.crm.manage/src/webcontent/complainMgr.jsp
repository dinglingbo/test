<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>投诉管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="manage/js/complainMgr.js" type="text/javascript"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table">
            <tr>
                <td>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>新增</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="status" name="status" width="40" headerAlign="center" header="进程"></div>
                  <div field="carNO" name="carNO" width="60" headerAlign="center" header="车牌"></div>
                  <div field="carBrandId" name="carBrandId" width="60" headerAlign="center" header="品牌"></div>
                  <div field="carModel" name="carModel" width="160" headerAlign="center" header="车型"></div>
                  <div field="carVin" name="carVin" width="120" headerAlign="center" header="VIN码"></div>
                  <div field="guestFullName" name="guestFullName" width="50" headerAlign="center" header="客户姓名"></div>
                  <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div>
                  <div field="contactName" name="contactName" width="50" headerAlign="center" header="送修人姓名"></div>
                  <div field="contactMobile" name="contactMobile" width="80" headerAlign="center" header="送修人手机"></div>
                  <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="服务顾问"></div>
                  <div field="serviceTypeId" name="serviceTypeId" width="50" headerAlign="center" header="业务类型"></div>
                  <div field="isSettle" name="isSettle" width="50" headerAlign="center" header="结算状态"></div>
                  <div field="serviceCode" name="serviceCode" width="120" headerAlign="center" header="工单号"></div>
              </div>
          </div>
    </div>
</body>
</html>