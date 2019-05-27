<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>来访记录</title>
<script src="<%=webPath + contextPath%>/sales/customer/js/visitorsRecordsMain.js?v=1.0.1"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">

.title {
  width: 80px;
  text-align: right;
}shu

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}
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
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="form1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)">本日</li>
                        <li iconCls="" onclick="quickSearch(1)">昨日</li>
                        <li iconCls="" onclick="quickSearch(2)">本周</li>
                        <li iconCls="" onclick="quickSearch(3)">上周</li>
                        <li iconCls="" onclick="quickSearch(4)">本月</li>
                        <li iconCls="" onclick="quickSearch(5)">上月</li>
                        <li iconCls="" onclick="quickSearch(6)">本年</li>
                        <li iconCls="" onclick="quickSearch(7)">上年</li>
                    </ul>
                     <a class="nui-menubutton" plain="false" iconCls="" id="menunamestatus" menu="#popupMenu2" >草稿</a>
                    <ul id="popupMenu2" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch2(0)">草稿</li>
                        <li iconCls="" onclick="quickSearch2(1)">归档</li>
                        <li iconCls="" onclick="quickSearch2(2)">转销售</li>
                        <li iconCls="" onclick="quickSearch2(3)">作废</li>
                        <li iconCls="" onclick="quickSearch2(4)">全部</li>
                    </ul>
                    <span class="separator"></span>
                    <!-- <label style="font-family:Verdana;">客户名称：</label> -->
                    <input class="nui-textbox" id="fullName" emptyText="客户名称" width="100"  onenter="onSearch"/>
                   <!--  <label style="font-family:Verdana;">销售顾问：</label> -->
                    <input name="saleAdvisorId" id="saleAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="销售顾问" url=""  allowInput="true" showNullItem="false" width="100" valueFromSelect="true"  onenter="onSearch"/>
                    
                    <label style="font-family:Verdana;">来访日期从：</label>
				    <input class="nui-datepicker" id="sEnterDate" name="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
				    <label style="font-family:Verdana;">至</label>
				    <input class="nui-datepicker" id="eEnterDate" name="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>                   
	                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                    <span class="separator"></span>
                    <a class="nui-button" onclick="onCancel" plain="true"  style="width: 100px;"><span class="fa fa-user-plus fa-lg"></span>&nbsp;客户档案&nbsp;</a>
                    <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-search fa-lg"></span>&nbsp;库存查询</a>
                </td>
            </tr>
        </table>
    </div> 
    <div class="nui-fit">
          <input name="intentLevelId"
             id="intentLevelId"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
           <input name="frameColorId"
             id="frameColorId"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
           <input name="interialColorId"
             id="interialColorId"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               allowCellWrap = "true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <!-- <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div> -->
                  <div field="id" name="id" width="160px" headerAlign="center" header="工单号" visible="false"></div>
                  <div field="guestId" name="guestId" width="160px" headerAlign="center" header="工单号" visible="false"></div>
                  <div field="serviceCode" name="serviceCode" width="160px" headerAlign="center" header="工单号"></div>
                  <div field="status" name="status" width="70px" headerAlign="center" header="状态"></div>
                  <div field="fullName" name="fullName" width="70px" headerAlign="center" header="客户名称"></div>
                  <div field="sex" name="sex" width="70px" headerAlign="center" header="性别"></div>
                  <div field="comeDate" name="comeDate" width="115px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="来访时间"></div>
                  <div field="mobile" name="mobile" width="100px" headerAlign="center" header="手机号"></div>
                  <div field="specialCare" name="specialCare" width="160px" headerAlign="center" header="关注重点"></div>
                  <div field="intentLevelId" name="intentLevelId" width="110px" headerAlign="center"  header="意向级别"></div>
                  <div field="carModelName" name="carModelName" width="150px" headerAlign="center" header="意向车型"></div>
                  <div field="frameColorId" name="frameColorId" width="90px" headerAlign="center" header="车身颜色"></div>
                  <div field="interialColorId" name="interialColorId" width="85px" headerAlign="center" header="内饰颜色"></div>
                  <div field="expectPrice" name="expectPrice" width="85px" headerAlign="center" header="预算金额"></div>
              </div>
          </div>
    </div>
</div>


<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:420px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            
            <input name="carBrandId"
                id="carBrandId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
                
           <input name="serviceTypeId"
                id="serviceTypeId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
            <tr>
                <td class="title" width="800px">开单日期:</td>
                <td>
                    <input id="sRecordDate"
                           name="sRecordDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eRecordDate"
                           name="eRecordDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">预计完工日期:</td>
                <td>
                    <input id="sPlanFinishDate"
                           name="sPlanFinishDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="ePlanFinishDate"
                           name="ePlanFinishDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">业务类型:</td>
                <td colspan="3">
                    <div id="serviceTypeIds" name="serviceTypeIds" class="nui-checkboxlist" repeatItems="5" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" ></div>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
        </div>
    </div>
</div>
</body>
</html>